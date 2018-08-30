/*
 * AscEmu Framework based on ArcEmu MMORPG Server
 * Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
 * Copyright (C) 2008-2012 ArcEmu Team <http://www.ArcEmu.org/>
 * Copyright (C) 2005-2007 Ascent Team
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef __WORLDSOCKET_H
#define __WORLDSOCKET_H

#include "StackBuffer.h"
#include "FastQueue.h"
#include "Auth/WowCrypt.h"
#include "WorldPacket.h"
#include "Network/Network.h"

#include <string>

#define WORLDSOCKET_SENDBUF_SIZE 131078
#define WORLDSOCKET_RECVBUF_SIZE 16384

class SocketHandler;
class WorldSession;

enum OUTPACKET_RESULT
{
    OUTPACKET_RESULT_SUCCESS = 1,
    OUTPACKET_RESULT_NO_ROOM_IN_BUFFER = 2,
    OUTPACKET_RESULT_NOT_CONNECTED = 3,
    OUTPACKET_RESULT_SOCKET_ERROR = 4,
};

//////////////////////////////////////////////////////////////////////////////////////////
/// \brief Main network code functions, handles reading/writing of all packets.
//////////////////////////////////////////////////////////////////////////////////////////
class SERVER_DECL WorldSocket
{
public:
    WorldSocket(uint32 sessionid);
    ~WorldSocket();

    void Disconnect();
    bool IsConnected();
    inline std::string GetRemoteIP() { return std::string(inet_ntoa(m_address.sin_addr)); }
    inline uint32 GetRemotePort() { return ntohs(m_address.sin_port); }

    inline void SendPacket(WorldPacket* packet) { if (!packet) return; OutPacket(packet->GetOpcode(), (uint16)packet->size(), (packet->size() ? (const void*)packet->contents() : NULL)); }
    inline void SendPacket(StackBufferBase* packet) { if (!packet) return; OutPacket(packet->GetOpcode(), packet->GetSize(), (packet->GetSize() ? (const void*)packet->GetBufferPointer() : NULL)); }

    void  OutPacket(uint16 opcode, size_t len, const void* data);
    OUTPACKET_RESULT _OutPacket(uint16 opcode, size_t len, const void* data);

    inline WorldSession* GetSession() { return mSession; }
    inline uint32 GetSessionId() { return m_sessionId; }

protected:
    WorldSession* mSession;
    uint32 m_sessionId;
    sockaddr_in m_address;
};

static inline void FastGUIDPack(ByteBuffer & buf, const uint64 & oldguid)
{
    // hehe speed freaks
    uint8 guidmask = 0;
    uint8 guidfields[9] = {0, 0, 0, 0, 0, 0, 0, 0};

    int j = 1;
    uint8* test = (uint8*)&oldguid;

    if (*test)  //7*8
    {
        guidfields[j] = *test;
        guidmask |= 1;
        j++;
    }
    if (*(test + 1)) //6*8
    {
        guidfields[j] = *(test + 1);
        guidmask |= 2;
        j++;
    }
    if (*(test + 2)) //5*8
    {
        guidfields[j] = *(test + 2);
        guidmask |= 4;
        j++;
    }
    if (*(test + 3)) //4*8
    {
        guidfields[j] = *(test + 3);
        guidmask |= 8;
        j++;
    }
    if (*(test + 4)) //3*8
    {
        guidfields[j] = *(test + 4);
        guidmask |= 16;
        j++;
    }
    if (*(test + 5)) //2*8
    {
        guidfields[j] = *(test + 5);
        guidmask |= 32;
        j++;
    }
    if (*(test + 6)) //1*8
    {
        guidfields[j] = *(test + 6);
        guidmask |= 64;
        j++;
    }
    if (*(test + 7)) //0*8
    {
        guidfields[j] = *(test + 7);
        guidmask |= 128;
        j++;
    }
    guidfields[0] = guidmask;

    buf.append(guidfields, j);
}

//!!! warning. This presumes that all guids can be compressed at least 1 byte
//make sure you choose highguids accordingly
static inline unsigned int FastGUIDPack(const uint64 & oldguid, unsigned char* buffer, uint32 pos)
{
    // hehe speed freaks
    uint8 guidmask = 0;

    int j = 1 + pos;

    uint8* test = (uint8*)&oldguid;

    if (*test)  //7*8
    {
        buffer[j] = *test;
        guidmask |= 1;
        j++;
    }
    if (*(test + 1)) //6*8
    {
        buffer[j] = *(test + 1);
        guidmask |= 2;
        j++;
    }
    if (*(test + 2)) //5*8
    {
        buffer[j] = *(test + 2);
        guidmask |= 4;
        j++;
    }
    if (*(test + 3)) //4*8
    {
        buffer[j] = *(test + 3);
        guidmask |= 8;
        j++;
    }
    if (*(test + 4)) //3*8
    {
        buffer[j] = *(test + 4);
        guidmask |= 16;
        j++;
    }
    if (*(test + 5)) //2*8
    {
        buffer[j] = *(test + 5);
        guidmask |= 32;
        j++;
    }
    if (*(test + 6)) //1*8
    {
        buffer[j] = *(test + 6);
        guidmask |= 64;
        j++;
    }
    if (*(test + 7)) //0*8
    {
        buffer[j] = *(test + 7);
        guidmask |= 128;
        j++;
    }
    buffer[pos] = guidmask;
    return (j - pos);
}

#endif      //__WORLDSOCKET_H
