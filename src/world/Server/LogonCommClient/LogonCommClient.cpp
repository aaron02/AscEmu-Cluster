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
 *
 */
#include "StdAfx.h"
#include "CommonTypes.hpp"
#include "LogonCommClient.h"
#include "LogonCommHandler.h"
#include "WorldPacket.h"
#include "Database/Database.h"
#include "Server/MainServerDefines.h"
#include <set>
#include <map>
#include "Server/World.h"
#include "Server/World.Legacy.h"

#pragma pack(push, 1)
typedef struct
{
    uint16 opcode;
    uint32 size;
} logonpacket;
#pragma pack(pop)

void LogonCommHandler::Account_SetBanned(const char * account, uint32 banned, const char* reason)
{

}

void LogonCommHandler::Account_SetGM(const char * account, const char * flags)
{

}

void LogonCommHandler::Account_SetMute(const char * account, uint32 muted)
{

}

void LogonCommHandler::IPBan_Add(const char * ip, uint32 duration, const char * reason)
{

}

void LogonCommHandler::IPBan_Remove(const char *ip)
{

}
void LogonCommHandler::TestConsoleLogon(std::string &username, std::string &password, uint32 requestnum)
{

}

void LogonCommHandler::Startup()
{

}

void LogonCommHandler::UpdateAccountCount(uint32 account_id, uint8 add)
{

}

void LogonCommHandler::UpdateSockets()
{

}

LogonCommHandler::LogonCommHandler()
{

}

LogonCommHandler::~LogonCommHandler()
{

}
