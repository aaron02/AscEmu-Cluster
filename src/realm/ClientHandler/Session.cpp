/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "RealmStdAfx.h"

SessionPacketHandler Session::Handlers[NUM_MSG_TYPES];
void Session::InitHandlers()
{
    memset(Handlers, 0, sizeof(void*) * NUM_MSG_TYPES);
    Handlers[CMSG_PLAYER_LOGIN] = &Session::HandlePlayerLogin;
    Handlers[CMSG_CHAR_ENUM] = &Session::HandleCharacterEnum;
    Handlers[CMSG_CHAR_CREATE] = &Session::HandleCharacterCreate;
    Handlers[CMSG_ITEM_QUERY_SINGLE] = &Session::HandleItemQuerySingleOpcode;
    Handlers[CMSG_NAME_QUERY] = &Session::HandleNameQueryOpcode;

    // Channels
    Handlers[CMSG_JOIN_CHANNEL] = &Session::HandleChannelJoin;
    Handlers[CMSG_LEAVE_CHANNEL] = &Session::HandleChannelLeave;
    Handlers[CMSG_CHANNEL_LIST] = &Session::HandleChannelList;
    Handlers[CMSG_CHANNEL_PASSWORD] = &Session::HandleChannelPassword;
    Handlers[CMSG_CHANNEL_SET_OWNER] = &Session::HandleChannelSetOwner;
    Handlers[CMSG_CHANNEL_OWNER] = &Session::HandleChannelOwner;
    Handlers[CMSG_CHANNEL_MODERATOR] = &Session::HandleChannelModerator;
    Handlers[CMSG_CHANNEL_UNMODERATOR] = &Session::HandleChannelUnmoderator;
    Handlers[CMSG_CHANNEL_MUTE] = &Session::HandleChannelMute;
    Handlers[CMSG_CHANNEL_UNMUTE] = &Session::HandleChannelUnmute;
    Handlers[CMSG_CHANNEL_INVITE] = &Session::HandleChannelInvite;
    Handlers[CMSG_CHANNEL_KICK] = &Session::HandleChannelKick;
    Handlers[CMSG_CHANNEL_BAN] = &Session::HandleChannelBan;
    Handlers[CMSG_CHANNEL_UNBAN] = &Session::HandleChannelUnban;
    Handlers[CMSG_CHANNEL_ANNOUNCEMENTS] = &Session::HandleChannelAnnounce;
    Handlers[CMSG_CHANNEL_MODERATE] = &Session::HandleChannelModerate;
    Handlers[CMSG_GET_CHANNEL_MEMBER_COUNT] = &Session::HandleChannelNumMembersQuery;
    Handlers[CMSG_CHANNEL_DISPLAY_LIST] = &Session::HandleChannelRosterQuery;
    Handlers[CMSG_MESSAGECHAT] = &Session::HandleMessagechatOpcode;
}

LoginErrorCode VerifyName(const char* name, size_t nlen)
{
    const char* p;
    size_t i;

    static const char* bannedCharacters = "\t\v\b\f\a\n\r\\\"\'\? <>[](){}_=+-|/!@#$%^&*~`.,0123456789\0";
    static const char* allowedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    bool bool2 = false;
    if (bool2 == false)// limited names
    {
        if (nlen == 0)
            return E_CHAR_NAME_NO_NAME;
        else if (nlen < 2)
            return E_CHAR_NAME_TOO_SHORT;
        else if (nlen > 12)
            return E_CHAR_NAME_TOO_LONG;

        for (i = 0; i < nlen; ++i)
        {
            p = allowedCharacters;
            for (; *p != 0; ++p)
            {
                if (name[i] == *p)
                    goto cont;
            }
            return E_CHAR_NAME_INVALID_CHARACTER;
        cont:
            continue;
        }
    }
    else
    {
        for (i = 0; i < nlen; ++i)
        {
            p = bannedCharacters;
            while (*p != 0 && name[i] != *p && name[i] != 0)
                ++p;

            if (*p != 0)
                return E_CHAR_NAME_INVALID_CHARACTER;
        }
    }

    return E_CHAR_NAME_SUCCESS;
}

void Session::HandleCharacterCreate(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data, 10);

    std::string name;
    uint8 race;
    uint8 class_;

    recv_data >> name;
    recv_data >> race;
    recv_data >> class_;
    recv_data.rpos(0);

    LoginErrorCode res = VerifyName(name.c_str(), name.length());
    if (res != E_CHAR_NAME_SUCCESS)
    {
        GetSocket()->OutPacket(SMSG_CHAR_CREATE, 1, &res);
        return;
    }

    if (sClientMgr.GetRPlayer(name) != NULL)
    {
        GetSocket()->OutPacket(SMSG_CHAR_CREATE, 1, &res);
        return;
    }

    QueryResult * result = sCharSQL->Query("SELECT COUNT(*) FROM banned_names WHERE name = '%s'", sCharSQL->EscapeString(name).c_str());
    if (result)
    {
        if (result->Fetch()[0].GetUInt32() > 0)
        {
            // That name is banned!
            GetSocket()->OutPacket(SMSG_CHAR_CREATE, 1, &res); // You cannot use that name
            delete result;
            return;
        }
        delete result;
    }
    
    // Check if player got Death Knight already on this realm.
    if (Conf.MainConfig.getBoolDefault("ClassOptions", "DeathKnightLimit", true) && has_dk && (class_ == DEATHKNIGHT))
    {
        LoginErrorCode login_error = E_CHAR_CREATE_UNIQUE_CLASS_LIMIT;
        GetSocket()->OutPacket(SMSG_CHAR_CREATE, 1, &login_error);
        return;
    }


    // loading characters

    // Check the number of characters, so we can't make over 10.
    // They're able to manage to create >10 sometimes, not exactly sure how ..

    result = sCharSQL->Query("SELECT COUNT(*) FROM characters WHERE acct = %u", GetAccountId());
    if (result)
    {
        if (result->Fetch()[0].GetUInt32() >= 10)
        {
            // We can't make any more characters.
            LoginErrorCode login_error = E_CHAR_CREATE_SERVER_LIMIT;
            GetSocket()->OutPacket(SMSG_CHAR_CREATE, 1, &login_error);
            delete result;
            return;
        }
        delete result;
    }

    bool forward_to_Server = true;
    if (forward_to_Server)
    {
        WorkerServer* i = sClusterMgr.GetAnyWorkerServer();

        if (i == NULL)
        {
            GetSocket()->OutPacket(SMSG_CHAR_CREATE, 1, &res);
            return;
        }


        WorldPacket data(ISMSG_CREATE_PLAYER, 4 + 6 + 2 + recv_data.size());
        data << GetAccountId();
        data << class_;
        data << recv_data.GetOpcode();
        data << uint32(recv_data.size());
        data.resize(10 + recv_data.size());
        memcpy((void*)(data.contents() + 12), recv_data.contents(), recv_data.size());
        i->SendPacket(&data);
    }
}

Session::Session(uint32 id) : m_sessionId(id)
{
    deleted = false;
    m_socket = 0;
    m_server = 0;
    m_accountId = 0;
    m_currentPlayer = 0;
    m_latency = 0;
    m_accountFlags = 0;
    m_build = 0;
    m_nextServer = 0;
}

void Session::Update()
{
    WorldPacket * pck;
    uint16 opcode;
    while ((pck = m_readQueue.Pop()))
    {
        opcode = pck->GetOpcode();

        /* can we handle it ourselves? */
        if (opcode < NUM_MSG_TYPES && Session::Handlers[opcode] != 0)
        {
            (this->*Session::Handlers[opcode])(*pck);
        }
        else
        {
            /* no? pass it back to the worker server for handling. */
            if (m_server && sClusterMgr.GetWorkerServer(m_server->GetID()))
                m_server->SendWoWPacket(this, pck);
        }
        delete pck;
    }
}

Session::~Session()
{
    if (m_server != NULL)
        m_server = NULL;

    WorldPacket data(ISMSG_SESSION_REMOVED, 4);
    data << m_sessionId;
    sClusterMgr.DistributePacketToAll(&data);

    if (m_socket != NULL)
        m_socket->Delete();

    WorldPacket * pck = NULL;
    while ((pck = m_readQueue.Pop()))
    {
        delete pck;
    }
}

void Session::Disconnect()
{
    if (m_socket && m_socket->IsConnected())
    {
        m_socket->Disconnect();
        sClientMgr.DestroySession(GetSessionId());
    }
}