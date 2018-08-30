/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/


#pragma once

#include <iostream>
#include <list>
#include <vector>
#include <map>
#include <sstream>
#include <string>

#include "Common.hpp"
#include <Network/Network.h>

#include "../shared/Log.hpp"
#include "../shared/Util.hpp"
#include "../shared/ByteBuffer.h"
#include "../shared/Config/Config.h"
#include <zlib.h>

#include "../shared/Database/DatabaseEnv.h"

#include "../shared/Auth/BigNumber.h"
#include "../shared/Auth/Sha1.h"
#include "../shared/Auth/WowCrypt.h"

#include "../world/Server/Packets/Opcode.h"
#include "WorldPacket.h"
#include "../shared/Threading/RWLock.h"
#include "../shared/FastQueue.h"
#include "../shared/Network/socket.h"

#include "../realm/Server/Master.hpp"
#include "../realm/WorkerServer/WorkerOpcodes.h"
#include "../realm/WorkerServer/WorkerServerSocket.h"
#include "../realm/Server/Structures.h"
#include "../realm/ClientHandler/WorldSocket.h"
#include "../realm/ClientHandler/Session.h"
#include "../realm/WorkerServer/WorkerServer.h"
#include "../realm/ClusterManager/ClusterManager.h"
#include "../realm/ClientManager/ClientManager.h"
#include "../realm/LogonCommServer/LogonCommClient.h"
#include "../realm/LogonCommServer/LogonCommHandler.h"
#include "../realm/Storage/MySQLDataStore.hpp"
#include "../shared/AuthCodes.h"
#include "../realm/Storage/MainServerDefines.h"
#include "../realm/Server/RealmServerDefines.hpp"
#include "../world/Units/Players/PlayerDefines.hpp"
#include "../realm/Management/AddonMgr.h"
#include "../shared/CrashHandler.h"
#include "../realm/Chat/Chat.h"
#include "../realm/Chat/Channel.h"
#include "../realm/Chat/ChannelMgr.h"
#include "../world/Server/WUtil.h"
#include "../shared/Errors.h"

#ifndef WIN32
#ifdef USING_BIG_ENDIAN
#define GUID_LOPART(x) ( ( x >> 32 ) )
#define GUID_HIPART(x) ( ( x & 0x00000000ffffffff ) )
#else
#define GUID_HIPART(x) ( ( x >> 32 ) )
#define GUID_LOPART(x) ( ( x & 0x00000000ffffffff ) )
#endif
#else
#define GUID_HIPART(x) (*(((uint32*)&(x))+1))
#define GUID_LOPART(x) (*((uint32*)&(x)))
#endif

// database decl
extern Database* sCharSQL;
extern Database* sWorldSQL;