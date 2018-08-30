/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "RealmStdAfx.h"

WorkerServerSocket::WorkerServerSocket(SOCKET fd) : Socket(fd, 100000, 100000)
{
    _authenticated = false;
    use_crypto = false;
    _remaining = 0;
    _cmd = 0;
    workerServer = NULL;
}

WorkerServerSocket::~WorkerServerSocket()
{

}

void WorkerServerSocket::HandleAuthRequest(WorldPacket & pck)
{
    uint32 build;
    std::string ver;
    pck >> build;
    pck >> ver;

    LogNotice("WorkerServerSocket : Auth reply, server is %s build %u", ver.c_str(), build);

    // accept it
    WorldPacket data(ISMSG_AUTH_RESULT, 4);
    data << uint32(1);
    SendPacket(&data);

    _authenticated = true;
}

void WorkerServerSocket::OnRead()
{
    for (;;)
    {
        if (!_cmd)
        {
            if (readBuffer.GetSize() < 6)
                break;

            readBuffer.Read(&_cmd, 2);
            readBuffer.Read(&_remaining, 4);
            //_remaining = ntohl(_remaining);
        }

        if (_remaining && readBuffer.GetSize() < _remaining)
            break;

        if (_cmd == ICMSG_WOW_PACKET)
        {
            uint32 sid;
            uint16 op;
            uint32 sz;


            readBuffer.Read(&sid, 4);
            readBuffer.Read(&op, 2);
            readBuffer.Read(&sz, 4);

            Session * session = sClientMgr.GetSession(sid);
            if (session != NULL && session->GetSocket() != NULL)
            {
                uint8* buf = new uint8[sz];
                readBuffer.Read(buf, sz);
                session->GetSocket()->OutPacket(op, sz, buf);
                delete[] buf;
            }
            else
                readBuffer.Remove(sz);

            _cmd = 0;

            continue;
        }
        WorldPacket * pck = new WorldPacket(_cmd, _remaining);
        _cmd = 0;
        pck->resize(_remaining);
        readBuffer.Read((uint8*)pck->contents(), _remaining);

        if (_authenticated)
        {
            // push to queue
            if (!workerServer)
            {
                if (pck->GetOpcode() == ICMSG_REGISTER_WORKER)
                {
                    // handle register worker
                    HandleRegisterWorker(*pck);
                }

                /* I deliberately don't delete pck here for a reason :P */
            }
            else
            {
                workerServer->QueuePacket(pck);
            }
        }
        else
        {
            if (pck->GetOpcode() != ICMSG_AUTH_REPLY)
                Disconnect();
            else
                HandleAuthRequest(*pck);

            delete pck;
        }
    }
}

void WorkerServerSocket::HandleRegisterWorker(WorldPacket & pck)
{
    uint32 build;
    pck >> build;

    // TODO: Check the build of the server
    WorkerServer* new_server = sClusterMgr.CreateWorkerServer(this);
    if (new_server == 0)
    {
        WorldPacket data(ISMSG_REGISTER_RESULT, 10);
        data << uint32(0);
        SendPacket(&data);
        delete &pck;
        return;
    }

    /* because we don't have any locks in the managers, this has to execute
    in the other thread. this is why I haven't deleted the packet yet
    */

    workerServer = new_server;
    pck.rpos(0);
    workerServer->QueuePacket(&pck);
}

void WorkerServerSocket::SendPacket(WorldPacket * pck)
{
    bool rv;
    size_t size = pck->size();
    uint16 opcode = pck->GetOpcode();

    if (!IsConnected())
        return;

    BurstBegin();

    // Pass the header to our send buffer
    rv = BurstSend((const uint8*)&opcode, 2);
    rv = BurstSend((const uint8*)&size, 4);

    // Pass the rest of the packet to our send buffer (if there is any)
    if (size > 0 && rv)
        rv = BurstSend((const uint8*)pck->contents(), uint32(size));

    if (rv) BurstPush();
    BurstEnd();
}

void WorkerServerSocket::SendWoWPacket(Session * from, WorldPacket * pck)
{
    bool rv;
    size_t size1 = pck->size();
    uint16 opcode1 = pck->GetOpcode();
    size_t size2 = size1 + 10;
    uint32 opcode2 = ISMSG_WOW_PACKET;
    uint32 id = from->GetSessionId();

    if (!IsConnected())
        return;

    BurstBegin();

    // Pass the header to our send buffer
    BurstSend((const uint8*)&opcode2, 2);
    BurstSend((const uint8*)&size2, 4);
    BurstSend((const uint8*)&id, 4);
    BurstSend((const uint8*)&opcode1, 2);
    rv = BurstSend((const uint8*)&size1, 4);

    // Pass the rest of the packet to our send buffer (if there is any)
    if (size1 > 0 && rv)
        rv = BurstSend(pck->contents(), uint32(size1));

    if (rv) BurstPush();
    BurstEnd();
}

void WorkerServerSocket::OnConnect()
{
    Arcemu::Sleep(200);

    WorldPacket data(ISMSG_AUTH_REQUEST, 4);
    data << uint32(1);
    SendPacket(&data);
}

void WorkerServerSocket::OnDisconnect()
{
    LogNotice("OnDisconnect \n");
    sClusterMgr.OnServerDisconnect(workerServer);
}
