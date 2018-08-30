/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include <RC4Engine.h>

#ifndef _WORKERSERVER_CLIENT_H
#define _WORKERSERVER_CLIENT_H

struct RealmToClientPktHeader
{
    uint16 inc;
    uint16 size;
    uint32 cmd;
};

class WSClient : public Socket
{
    bool _authenticated;
    uint32 _remaining;
    uint16 _cmd;
    uint32 mOpcode;
    uint32 mRemaining;
    uint32 mSize;

    RC4Engine _sendCrypto;
    RC4Engine _recvCrypto;

public:
    WSClient(SOCKET fd);
    ~WSClient();

    void SendPacket(WorldPacket * data);
    void OnRead();
    void OnConnect();
    void OnDisconnect();

    bool use_crypto;

private:
    WowCrypt _crypt;
};

#endif