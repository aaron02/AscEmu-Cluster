/**
 * AscEmu Framework based on ArcEmu MMORPG Server
 * Copyright (C) 2014-2017 AscEmu Team <http://www.ascemu.org>
 * Copyright (C) 2007-2015 Moon++ Team <http://www.moonplusplus.info/>
 * Copyright (C) 2005-2007 Ascent Team
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Setup.h"
#define SKIP_ALLOCATOR_SHARING 1
#include <Server/Script/ScriptSetup.h>
#include "Server/Script/ScriptMgr.h"

extern "C" SCRIPT_DECL void _exp_set_serverstate_singleton(ServerState* state)
{
    ServerState::instance(state);
}

extern "C" SCRIPT_DECL uint32 _exp_get_script_type()
{
    return SCRIPT_TYPE_MISC;
}

extern "C" SCRIPT_DECL void _exp_script_register(ScriptMgr* mgr)
{
    SetupDalaranGossip(mgr);
    SetupInnkeepers(mgr);
    SetupGuardGossip(mgr);
    SetupTrainerScript(mgr);
    SetupMulgoreGossip(mgr);
    SetupShattrathGossip(mgr);
    SetupTanarisGossip(mgr);
    SetupMoongladeGossip(mgr);
    SetupStormwindGossip(mgr);
    SetupTheramoreGossip(mgr);
    SetupTeldrassilGossip(mgr);
    SetupBoreanTundraGossip(mgr);
    SetupWyrmrestTempleGossip(mgr);
    SetupXpEliminatorGossip(mgr);
}

#ifdef WIN32

BOOL APIENTRY DllMain(HANDLE hModule, DWORD  ul_reason_for_call, LPVOID lpReserved)
{
    return TRUE;
}

#endif