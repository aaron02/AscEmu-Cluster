/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include <RC4Engine.h>

class WorkerServer;
class Session;
class WorkerServerSocket : public Socket
{
    bool _authenticated;
    uint32 _remaining;
    uint16 _cmd;

    RC4Engine sendCrypto;
    RC4Engine recvCrypto;
    WorkerServer * workerServer;

public:
    uint32 m_id;
    bool use_crypto;

    WorkerServerSocket(SOCKET fd);
    ~WorkerServerSocket();

    void SendPacket(WorldPacket * pck);
    void SendWoWPacket(Session * from, WorldPacket * pck);
    void OnRead();

    void HandleAuthRequest(WorldPacket & pck);
    void HandleRegisterWorker(WorldPacket & pck);
    void OnConnect();
    void OnDisconnect();
};


