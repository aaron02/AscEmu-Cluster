/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "RealmStdAfx.h"
#include "../shared/AuthCodes.h"

/* echo send/received packets to console */
//#define ECHO_PACKET_LOG_TO_CONSOLE 1

#pragma pack(push, 1)
struct ClientPktHeader
{
    uint16 size;
    uint32 cmd;
};

struct ServerPktHeader
{
    uint16 size;
    uint16 cmd;
};
#pragma pack(pop)

WorldSocket::WorldSocket(SOCKET fd) : Socket(fd, WORLDSOCKET_SENDBUF_SIZE, WORLDSOCKET_RECVBUF_SIZE)
{
    Authed = false;
    mOpcode = 0;
    mRemaining = 0;
    mSize = 0;
    mSeed = rand() % 0xFFFFFFF0 + 10;
    mRequestID = 0;
    mSession = NULL,
    pAuthenticationPacket = NULL;
    _latency = 0;
    mQueued = false;
    m_nagleEanbled = false;
    mClientSeed = 0;
    mClientBuild = 0;
    m_fullAccountName = NULL;
}

WorldSocket::~WorldSocket()
{
    WorldPacket* pck;
    queueLock.Acquire();
    while ((pck = _queue.Pop()) != NULL)
    {
        delete pck;
    }
    queueLock.Release();

    if (pAuthenticationPacket)
        delete pAuthenticationPacket;

    if (mSession)
    {
        mSession->SetServer(NULL);
        mSession = NULL;
    }

    if (m_fullAccountName != NULL)
        delete m_fullAccountName;
}

void WorldSocket::OnDisconnect()
{
    if (mSession)
    {
        mSession->SetServer(NULL);
        mSession->m_socket = NULL;
        sClientMgr.DestroySession(mSession->GetSessionId());
        mSession = NULL;
    }

    if (mRequestID != 0)
    {
        sLogonCommHandler.UnauthedSocketClose(mRequestID);
        mRequestID = 0;
    }

    // clear buffer
   /* queueLock.Acquire();

    WorldPacket *pck;
    while ((pck = _queue.Pop()))
        delete pck;

    queueLock.Release();*/
}

void WorldSocket::OutPacket(uint16 opcode, size_t len, const void* data)
{
    OUTPACKET_RESULT res;
    if ((len + 10) > WORLDSOCKET_SENDBUF_SIZE)
    {
        LOG_ERROR("WARNING: Tried to send a packet of %u bytes (which is too large) to a socket. Opcode was: %u (0x%03X)", (unsigned int)len, (unsigned int)opcode, (unsigned int)opcode);
        return;
    }

    res = _OutPacket(opcode, len, data);
    if (res == OUTPACKET_RESULT_SUCCESS)
        return;

    if (res == OUTPACKET_RESULT_NO_ROOM_IN_BUFFER)
    {
        /* queue the packet */
        queueLock.Acquire();

        WorldPacket* pck = new WorldPacket(opcode, len);
        if (len)
            pck->append((const uint8*)data, len);

        _queue.Push(pck);

        queueLock.Release();
    }
}

#if VERSION_STRING != Cata
OUTPACKET_RESULT WorldSocket::_OutPacket(uint16 opcode, size_t len, const void* data)
#else
OUTPACKET_RESULT WorldSocket::_OutPacket(uint32 opcode, size_t len, const void* data)
#endif
{
    bool rv;
    if (!IsConnected())
        return OUTPACKET_RESULT_NOT_CONNECTED;

    BurstBegin();
    //if ((m_writeByteCount + len + 4) >= m_writeBufferSize)
    if (writeBuffer.GetSpace() < (len + 4))
    {
        BurstEnd();
        return OUTPACKET_RESULT_NO_ROOM_IN_BUFFER;
    }

#if VERSION_STRING == Cata
    ServerPktHeader Header(uint32(len + 2), opcode);
#else

    // Encrypt the packet
    // First, create the header.
    ServerPktHeader Header;

    Header.cmd = opcode;
    Header.size = ntohs((uint16)len + 2);
#endif

#if VERSION_STRING < WotLK
    _crypt.encryptTbcSend((uint8*)&Header, sizeof(ServerPktHeader));
#elif VERSION_STRING == WotLK
    _crypt.encryptWotlkSend((uint8*)&Header, sizeof(ServerPktHeader));
#elif VERSION_STRING == Cata
    _crypt.encryptWotlkSend(((uint8*)Header.header), Header.getHeaderLength());
#endif

#if VERSION_STRING == Cata
    rv = BurstSend((const uint8*)&Header.header, Header.getHeaderLength());
#else
    // Pass the header to our send buffer
    rv = BurstSend((const uint8*)&Header, 4);
#endif

    // Pass the rest of the packet to our send buffer (if there is any)
    if (len > 0 && rv)
    {
        rv = BurstSend((const uint8*)data, (uint32)len);
    }

    if (rv) BurstPush();
    BurstEnd();
    return rv ? OUTPACKET_RESULT_SUCCESS : OUTPACKET_RESULT_SOCKET_ERROR;
}


void WorldSocket::OnConnect()
{
    _latency = getMSTime();

    WorldPacket wp(SMSG_AUTH_CHALLENGE, 24);

    wp << uint32(1);
    wp << uint32(mSeed);
    wp << uint32(0xC0FFEEEE);
    wp << uint32(0x00BABE00);
    wp << uint32(0xDF1697E5);
    wp << uint32(0x1234ABCD);

    SendPacket(&wp);
}

void WorldSocket::_HandleAuthSession(WorldPacket* recvPacket)
{
    std::string account;
    uint32 unk2, unk3;
    uint64 unk4;
    uint32 unk5, unk6, unk7;

    _latency = getMSTime() - _latency;

    try
    {
        *recvPacket >> mClientBuild;
        *recvPacket >> unk2;
        *recvPacket >> account;
        *recvPacket >> unk3;
        *recvPacket >> mClientSeed;
        *recvPacket >> unk4;
        *recvPacket >> unk5;
        *recvPacket >> unk6;
        *recvPacket >> unk7;
    }
    catch (ByteBuffer::error &)
    {
        LogDetail("Incomplete copy of AUTH_SESSION Received.");
        return;
    }

    // Send out a request for this account.
    mRequestID = sLogonCommHandler.ClientConnected(account, this);

    if (mRequestID == 0xFFFFFFFF)
    {
        Disconnect();
        return;
    }

    m_fullAccountName = new std::string(account);

    // Set the authentication packet 
    pAuthenticationPacket = recvPacket;
}

void WorldSocket::InformationRetreiveCallback(WorldPacket & recvData, uint32 requestid)
{
    if (requestid != mRequestID)
        return;

    uint32 error;
    recvData >> error;

    if (error != 0)
    {
        // something happened wrong @ the logon server
        OutPacket(SMSG_AUTH_RESPONSE, 1, "\x0D");
        return;
    }

    // Extract account information from the packet.
    std::string AccountName;
    const std::string* ForcedPermissions;
    uint32 AccountID;
    std::string GMFlags;
    uint8 AccountFlags;
    std::string lang = "enUS";
    uint32 i;

    recvData >> AccountID;
    recvData >> AccountName;
    recvData >> GMFlags;
    recvData >> AccountFlags;

    ForcedPermissions = sLogonCommHandler.GetForcedPermissions(AccountName);
    if (ForcedPermissions != NULL)
        GMFlags.assign(ForcedPermissions->c_str());

    LOG_DEBUG(" >> got information packet from logon: `%s` ID %u (request %u)", AccountName.c_str(), AccountID, mRequestID);

    mRequestID = 0;

    // Pull the sessionkey we generated during the logon - client handshake
    uint8 K[40];
    recvData.read(K, 40);

#if VERSION_STRING < WotLK
    BigNumber BNK;
    BNK.SetBinary(K, 40);

    uint8 *key = new uint8[20];
    WowCrypt::generateTbcKey(key, K);

    _crypt.setTbcKey(key, 20);
    _crypt.initTbcCrypt();
    delete[] key;
#else
    _crypt.initWotlkCrypt(K);
#endif

    //checking if player is already connected
    //disconnect current player and login this one(blizzlike)

    if (recvData.rpos() != recvData.wpos())
        recvData.read((uint8*)lang.data(), 4);

    Session * session = sClientMgr.CreateSession(AccountID);
    if (session == NULL)
    {
        /* we are already logged in. send auth failed. (if anyone has a better error lemme know :P) */
        OutPacket(SMSG_AUTH_RESPONSE, 1, "\x0D");
        return;
    }

    mSession = session;
    session->m_socket = this;

    Sha1Hash sha;

    uint8 digest[20];
    pAuthenticationPacket->read(digest, 20);

    uint32 t = 0;
    if (m_fullAccountName == NULL)
        sha.UpdateData(AccountName);
    else
    {
        sha.UpdateData(*m_fullAccountName);

        // this is unused now. we may as well free up the memory.
        delete m_fullAccountName;
        m_fullAccountName = NULL;
    }

    sha.UpdateData((uint8*)&t, 4);
    sha.UpdateData((uint8*)&mClientSeed, 4);
    sha.UpdateData((uint8*)&mSeed, 4);
    sha.UpdateData((uint8*)&K, 40);
    sha.Finalize();

    if (memcmp(sha.GetDigest(), digest, 20))
    {
        // AUTH_UNKNOWN_ACCOUNT = 21
        OutPacket(SMSG_AUTH_RESPONSE, 1, "\x15");
        return;
    }

    // Allocate session
    mSession->m_accountFlags = AccountFlags;
    mSession->m_GMPermissions = GMFlags;
    mSession->m_accountId = AccountID;
    mSession->m_latency = _latency;
    mSession->m_accountName = AccountName;

    LogNotice("Auth : %s from %s:%u [%ums]", AccountName.c_str(), GetRemoteIP().c_str(), GetRemotePort(), _latency);
    Authenticate();
}

void WorldSocket::Authenticate()
{
    ASSERT(pAuthenticationPacket != NULL);

    mQueued = false;

    if (mSession == NULL)
        return;

    if (mSession->HasFlag(ACCOUNT_FLAG_XPACK_02))
        OutPacket(SMSG_AUTH_RESPONSE, 11, "\x0C\x30\x78\x00\x00\x00\x00\x00\x00\x00\x02");
    else if (mSession->HasFlag(ACCOUNT_FLAG_XPACK_01))
        OutPacket(SMSG_AUTH_RESPONSE, 11, "\x0C\x30\x78\x00\x00\x00\x00\x00\x00\x00\x01");
    else
        OutPacket(SMSG_AUTH_RESPONSE, 11, "\x0C\x30\x78\x00\x00\x00\x00\x00\x00\x00\x00");

    sAddonMgr.SendAddonInfoPacket(pAuthenticationPacket, static_cast<uint32>(pAuthenticationPacket->rpos()), mSession);
    mSession->m_latency = _latency;

    delete pAuthenticationPacket;
    pAuthenticationPacket = NULL;

    //sWorld.AddSession(mSession);
    //sWorld.AddGlobalSession(mSession);

    //mSession->SendClientCacheVersion(sWorld.CacheVersion);

    //if (mSession->HasGMPermissions())
    //    sWorld.gmList.insert(mSession);
}

void WorldSocket::UpdateQueuePosition(uint32 Position)
{
    // cebernic: Displays re-correctly until 2.4.3,there will not be always 0
    WorldPacket QueuePacket(SMSG_AUTH_RESPONSE, 16);
    QueuePacket << uint8(0x1B) << uint8(0x2C) << uint8(0x73) << uint8(0) << uint8(0);
    QueuePacket << uint32(0) << uint8(0);// << uint8(0);
    QueuePacket << Position;
    //    QueuePacket << uint8(1);
    SendPacket(&QueuePacket);
}

void WorldSocket::_HandlePing(WorldPacket* recvPacket)
{
    uint32 ping;
    if (recvPacket->size() < 4)
    {
        LogDebug("Socket closed due to incomplete ping packet.");
        Disconnect();
        return;
    }

    *recvPacket >> ping;
    *recvPacket >> _latency;

    OutPacket(SMSG_PONG, 4, &ping);
}

void WorldSocket::OnRead()
{
    for (;;)
    {
        // Check for the header if we don't have any bytes to wait for.
        if (mRemaining == 0)
        {
            if (readBuffer.GetSize() < 6)
            {
                // No header in the packet, let's wait.
                return;
            }

            // Copy from packet buffer into header local var
            ClientPktHeader Header;
            readBuffer.Read(&Header, 6);

            // Decrypt the header
#if VERSION_STRING < WotLK
            _crypt.decryptTbcReceive((uint8*)&Header, sizeof(ClientPktHeader));
#else
            _crypt.decryptWotlkReceive((uint8*)&Header, sizeof(ClientPktHeader));
#endif

            mRemaining = mSize = ntohs(Header.size) - 4;
            mOpcode = Header.cmd;
        }

        WorldPacket * Packet;

        if (mRemaining > 0)
        {
            if (readBuffer.GetSize() < mRemaining)
            {
                // We have a fragmented packet. Wait for the complete one before proceeding.
                return;
            }
        }

        Packet = new WorldPacket(mOpcode, mSize);
        Packet->resize(mSize);

        if (mRemaining > 0)
        {
            // Copy from packet buffer into our actual buffer.
            //Read(mRemaining, (uint8*)Packet->contents());
            readBuffer.Read((uint8*)Packet->contents(), mRemaining);
        }

        //sWorldLog.LogPacket(mSize, static_cast<uint16>(mOpcode), mSize ? Packet->contents() : NULL, 0, (mSession ? mSession->GetAccountId() : 0));
        mRemaining = mSize = mOpcode = 0;

        // Check for packets that we handle
        switch (Packet->GetOpcode())
        {
        case CMSG_PING:
        {
            if (mSession == NULL || mSession->m_currentPlayer == NULL)
            {
                _HandlePing(Packet);
                delete Packet;
            }
            else
                mSession->m_readQueue.Push(Packet);
        }break;
        case CMSG_AUTH_SESSION:
        {
            _HandleAuthSession(Packet);
        }break;
        default:
        {
            if (mSession) mSession->m_readQueue.Push(Packet);
            else delete Packet;
        }break;
        }
    }
}