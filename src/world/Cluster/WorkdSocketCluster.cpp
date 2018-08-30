/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "StdAfx.h"

WorldSocket::WorldSocket(uint32 sessionid) : m_sessionId(sessionid)
{

}

WorldSocket::~WorldSocket()
{

}

void WorldSocket::Disconnect()
{

}

bool WorldSocket::IsConnected()
{
    return true;
}

void WorldSocket::OutPacket(uint16 opcode, size_t len, const void* data)
{
    sClusterInterface.ForwardWoWPacket(opcode, len, data, m_sessionId);
}

