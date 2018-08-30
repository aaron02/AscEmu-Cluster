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
#include "Server/LogonCommClient/LogonCommHandler.h"
#include "Server/MainServerDefines.h"
#include "Server/Master.h"
#include "Config/Config.h"
#include "Auth/Sha1.h"
#include "Server/World.h"
#include "Server/World.Legacy.h"

initialiseSingleton(LogonCommHandler);

void LogonCommHandler::AccountChangePassword(const char* old_password, const char* new_password, const char* account_name)
{

}

void LogonCommHandler::AccountCreate(const char* name, const char* password, const char* account_name)
{

}

void LogonCommHandler::Account_CheckExist(const char* account, const char* request_name, const char* additional)
{

}