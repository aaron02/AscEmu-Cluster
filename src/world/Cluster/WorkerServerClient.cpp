/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "StdAfx.h"

WSClient::WSClient(SOCKET fd) : Socket(fd, 1024576, 1024576),
mOpcode(0),
mRemaining(0),
mSize(0)
{
    _remaining = 0;
    _cmd = 0;
    use_crypto = false;
}

WSClient::~WSClient()
{

}

void WSClient::OnRead()
{
    while (true)
    {
        if (!_cmd)
        {
            if (readBuffer.GetContiguiousBytes() < 6)
                break;

            readBuffer.Read((uint8*)&_cmd, 2);
            readBuffer.Read((uint8*)&_remaining, 4);
        }

        if (_remaining && readBuffer.GetSize() < _remaining)
            break;

        if (_cmd == ISMSG_WOW_PACKET)
        {
            uint32 sid = 0;
            uint16 op = 0;
            uint32 sz = 0;
            readBuffer.Read(&sid, 4);
            readBuffer.Read(&op, 2);
            readBuffer.Read(&sz, 4);

            WorldSession * session = sClusterInterface.GetSession(sid);
            if (session != NULL)
            {
                WorldPacket * pck = new WorldPacket(op, sz);
                if (sz > 0)
                {
                    pck->resize(sz);
                    readBuffer.Read((void*)pck->contents(), sz);
                }
                if (session) session->QueuePacket(pck);
                else delete pck;
            }
            _cmd = 0;
            continue;
        }

        WorldPacket * pck = new WorldPacket(_cmd, _remaining);
        pck->resize(_remaining);
        readBuffer.Read((uint8*)pck->contents(), _remaining);

        /* we could handle auth here */
        switch (pck->GetOpcode())
        {
        case ISMSG_AUTH_REQUEST:
            sClusterInterface.HandleAuthRequest(*pck);
            delete pck;
            break;
        default:
            sClusterInterface.QueuePacket(pck);
        }
        _cmd = 0;
        _remaining = 0;
    }
}

void WSClient::OnConnect()
{
    sClusterInterface.SetSocket(this);
}

void WSClient::OnDisconnect()
{
    sClusterInterface.ConnectionDropped();
    sSocketGarbageCollector.QueueSocket(this);
}

void WSClient::SendPacket(WorldPacket * data)
{
    bool rv;
    uint32 size = data->size();
    uint16 opcode = data->GetOpcode();

    //if(!IsConnected())
    //	return;

    BurstBegin();

    // Pass the header to our send buffer
    rv = BurstSend((const uint8*)&opcode, 2);
    rv = BurstSend((const uint8*)&size, 4);

    // Pass the rest of the packet to our send buffer (if there is any)
    if (size > 0 && rv)
        rv = BurstSend((const uint8*)data->contents(), size);

    if (rv) BurstPush();
    BurstEnd();
}

