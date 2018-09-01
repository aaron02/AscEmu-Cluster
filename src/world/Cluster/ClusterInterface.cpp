/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "StdAfx.h"

initialiseSingleton(ClusterInterface);
ClusterInterfaceHandler ClusterInterface::PHandlers[IMSG_NUM_TYPES];

void ClusterInterface::InitHandlers()
{
    memset(PHandlers, 0, sizeof(void*) * IMSG_NUM_TYPES);

    // Auth
    PHandlers[ISMSG_AUTH_REQUEST] = &ClusterInterface::HandleAuthRequest;
    PHandlers[ISMSG_AUTH_RESULT] = &ClusterInterface::HandleAuthResult;
    PHandlers[ISMSG_REGISTER_RESULT] = &ClusterInterface::HandleRegisterResult;

    // Player
    PHandlers[ISMSG_PLAYER_LOGIN] = &ClusterInterface::HandlePlayerLogin;
    PHandlers[ISMSG_PLAYER_INFO] = &ClusterInterface::HandlePlayerInfo;
    PHandlers[ISMSG_CREATE_PLAYER] = &ClusterInterface::HandleCreatePlayer;
    PHandlers[ISMSG_PACKED_PLAYER_INFO] = &ClusterInterface::HandlePackedPlayerInfo;
    PHandlers[ISMSG_DESTROY_PLAYER_INFO] = &ClusterInterface::HandleDestroyPlayerInfo;

    // Packets
    PHandlers[ISMSG_WOW_PACKET] = &ClusterInterface::HandleWoWPacket;

    // Teleport
    PHandlers[ISMSG_TELEPORT_RESULT] = &ClusterInterface::HandleTeleportResult;

    // Session
    PHandlers[ISMSG_SESSION_REMOVED] = &ClusterInterface::HandleSessionRemoved;
    PHandlers[ISMSG_SAVE_ALL_PLAYERS] = &ClusterInterface::HandleSaveAllPlayers;

    // Transporters
    PHandlers[ISMSG_TRANSPORTER_MAP_CHANGE] = &ClusterInterface::HandleTransporterMapChange;
 
    PHandlers[ICMSG_REALM_PING_STATUS] = &ClusterInterface::Ping;

    // Channel
    PHandlers[ISMSG_CHANNEL_ACTION] = &ClusterInterface::HandleChannelAction;
    PHandlers[ISMSG_CHANNEL_LFG_DUNGEON_STATUS_REQUEST] = &ClusterInterface::HandleChannelLFGDungeonStatusRequest;
}

ClusterInterface::ClusterInterface()
{
    ClusterInterface::InitHandlers();
    m_connected = false;

    for (uint32 i = 0; i < MAX_SESSIONS; ++i)
        _sessions[i] = NULL;
}

ClusterInterface::~ClusterInterface()
{

}

std::string ClusterInterface::GenerateVersionString()
{
    char str[200];
    snprintf(str, 200, "AscEmu r%u/%s-%s-%s", 1, CONFIG, PLATFORM_TEXT, ARCH);
    return std::string(str);
}

void ClusterInterface::ForwardWoWPacket(uint16 opcode, uint32 size, const void * data, uint32 sessionid)
{
    bool rv;
    uint32 size2 = 10 + size;
    uint16 opcode2 = ICMSG_WOW_PACKET;

    if (!_clientSocket || !m_connected) return;			// Shouldn't happen

    _clientSocket->BurstBegin();
    _clientSocket->BurstSend((const uint8*)&opcode2, 2);
    _clientSocket->BurstSend((const uint8*)&size2, 4);
    _clientSocket->BurstSend((const uint8*)&sessionid, 4);
    _clientSocket->BurstSend((const uint8*)&opcode, 2);
    rv = _clientSocket->BurstSend((const uint8*)&size, 4);
    if (size&&rv)
        rv = _clientSocket->BurstSend((const uint8*)data, size);

    if (rv) _clientSocket->BurstPush();
    _clientSocket->BurstEnd();
}

void ClusterInterface::ConnectionDropped()
{
    LogWarning("ClusterInterface : Socket disconnected, will attempt reconnect later");
    m_connected = false;
    retry = true;
    lastConnectTime = time(NULL);
    _clientSocket = NULL;
}

void ClusterInterface::ConnectToRealmServer()
{
    std::string hostname;
    int port = 0;
    std::string strkey;

    hostname = Config.MainConfig.getStringDefault("Cluster", "RSHostName", hostname);
    port = Config.MainConfig.getIntDefault("Cluster", "RSPort", port);
    strkey = Config.MainConfig.getStringDefault("Cluster", "Key", strkey);

    if(hostname.empty() || port == 0 || strkey.empty())
    {
        LogError("ClusterInterface : Could not get necessary fields from config file. Please fix and rehash.");
        return;
    }

    /* hash the key */
    Sha1Hash k;
    k.UpdateData(strkey);
    k.Finalize();
    memcpy(key, k.GetDigest(), 20);

    LogNotice("ClusterInterface : Connecting to %s port %u", hostname.c_str(), port);
    WSClient * s = ConnectTCPSocket<WSClient>(hostname.c_str(), port);
    if (!s)
    {
        retry = true;
        lastConnectTime = time(NULL);
        LogError("ClusterInterface : Could not connect to %s:%u", hostname.c_str(), port);
        LogError("ClusterInterface : Next try in 30 sec");
        return;
    }

    SetSocket(s);
    LogNotice("ClusterInterface : Connected to %s:%u", hostname.c_str(), port);

    _clientSocket = s;
    m_latency = getMSTime();
    m_connected = true;
    retry = false;
}

void ClusterInterface::HandleAuthRequest(WorldPacket & pck)
{
    uint32 x;
    pck >> x;

    if (x == 1)// BUILD_REVISION
    {
        //Log.Debug("ClusterInterface", "Incoming auth request from %s (RS build %u)", _clientSocket->GetRemoteIP().c_str(), x);

        WorldPacket data(ICMSG_AUTH_REPLY, 50);
        data << uint32(1); //BUILD_REVISION
        data << GenerateVersionString();
        SendPacket(&data);

        m_latency = getMSTime() - m_latency;
        LogNotice("ClusterInterface : Latency between realm server is %u ms", m_latency);
    }
    else
        LogError("ClusterInterface : Incorrect BUILD Revision");
}

void ClusterInterface::Ping(WorldPacket & pck)
{
    // Ping from Realmserver
    m_latency = getMSTime() - pingtime;
    last_pong = uint32(time(NULL));

    // Reply to Realmserver
    pingtime = getMSTime();
    WorldPacket data(ICMSG_WORLD_PONG_STATUS, 4);
    SendPacket(&data);

    last_ping = (uint32)UNIXTIME;
}

void ClusterInterface::HandleAuthResult(WorldPacket & pck)
{
    uint32 res;
    pck >> res;

    LogDebug("ClusterInterface : Auth Result: %u", res);
    if (!res)
    {
        LogError("ClusterInterface : Authentication Failed");
        retry = true;
        _clientSocket->Disconnect();
        _clientSocket = 0;
        return;
    }

    std::vector<uint32> maps;
    std::vector<uint32> instancedmaps;

    //send info for all the maps we will handle
    MySQLDataStore::WorldMapInfoContainer const* its = sMySQLStore.GetWorldMapInfoStore();
    for (MySQLDataStore::WorldMapInfoContainer::const_iterator itr = its->begin(); itr != its->end(); ++itr)
    {
        if (itr->second.cluster_loads_map)
        {
            if (itr->second.type == INSTANCE_NULL)
                maps.push_back(itr->second.mapid);
            else
                instancedmaps.push_back(itr->second.mapid);
        }
    }

    WorldPacket data(ICMSG_REGISTER_WORKER, 4 + (sizeof(std::vector<uint32>::size_type) * maps.size()) + (sizeof(std::vector<uint32>::size_type) * instancedmaps.size()));
    data << uint32(1);//BUILD_REVISION
    data << maps;
    data << instancedmaps;
    SendPacket(&data);
}


void ClusterInterface::HandleRegisterResult(WorldPacket & pck)
{
    uint32 res;
    pck >> res;

    if (!res)
    {
        _clientSocket->Disconnect();
        _clientSocket = NULL;
    }
    LogDebug("ClusterInterface : Register Result: %u", res);
}

void ClusterInterface::HandlePlayerLogin(WorldPacket & pck)
{
    LogNotice("Cluster Interface: HandlePlayerLogin");
    /* player x logging into instance y */
    uint32 Guid, InstanceId, MapId;
    uint32 AccountId, Account_Flags, sessionid, ClientBuild;
    uint8 _class;
    std::string GMPermissions, accountname;

    SOCKET _sock;

    pck >> Guid;
    pck >> MapId;
    pck >> InstanceId;
    pck >> AccountId;
    pck >> Account_Flags;
    pck >> sessionid;
    pck >> GMPermissions;
    pck >> accountname;
    pck >> ClientBuild;
    pck >> _class;
    pck >> _sock;

    /* create the session */
    WorldSession * s = sWorld.FindSession(AccountId);

    /* create the socket */
    WorldSocket * so = new WorldSocket(sessionid);

    if (s == NULL)
        s = new WorldSession(AccountId, accountname, so);

    _sessions[sessionid] = s;
    sWorld.addSession(s);

    bool login_result = s->ClusterTryPlayerLogin(Guid, _class, ClientBuild, GMPermissions, Account_Flags);
    if (login_result)
    {
        /* login was ok. send a message to the realm server telling him to distribute our info to all other realm server */
        WorldPacket data(ICMSG_PLAYER_LOGIN_RESULT, 5);
        data << Guid;
        data << sessionid;
        data << uint8(1);
        SendPacket(&data);
    }
    else
    {
        /* for some reason the login failed */
        WorldPacket data(ICMSG_PLAYER_LOGIN_RESULT, 5);
        data << Guid;
        data << sessionid;
        data << uint8(0);
        SendPacket(&data);

        /* tell the client his login failed before deleting the session */
        data.Initialize(SMSG_CHARACTER_LOGIN_FAILED);
        data << uint8(E_CHAR_LOGIN_NO_WORLD);
        so->SendPacket(&data);

        /* destroy the session */
        DestroySession(sessionid);
    }
}

void ClusterInterface::HandleDestroyPlayerInfo(WorldPacket & pck)
{
    LogNotice("Cluster Interface: DestroyPlayerInfo");
    uint32 guid;
    pck >> guid;

    // Accguire Map Mutex
    m_onlinePlayerMapMutex.Acquire();

    // Delete Record
    if (_onlinePlayers[guid])
        _onlinePlayers.erase(guid);

    // Release
    m_onlinePlayerMapMutex.Release();

    Player * player = objmgr.GetPlayer(guid);
    if (player)
    {
        if (player->GetSession())
        {
            player->GetSession()->SetSocket(NULL);
            player->SetSession(NULL);
        }

        delete player;
        player = NULL;
    }
}

void ClusterInterface::HandlePackedPlayerInfo(WorldPacket & pck)
{
    LogNotice("Cluster Interface: PackedPlayerInfo");
    uint32 real_size;
    pck >> real_size;
    uLongf rsize = real_size;

    ByteBuffer buf(real_size);
    buf.resize(real_size);

    if (uncompress((uint8*)buf.contents(), &rsize, pck.contents() + 4, (u_long)pck.size() - 4) != Z_OK)
    {
        LogDebug("Cluster Interface: Uncompress of player info failed.");
        return;
    }

    RPlayerInfo * pi;
    uint32 count;

    // Accguire Map Mutex
    m_onlinePlayerMapMutex.Acquire();

    buf >> count;
    for (uint32 i = 0; i < count; ++i)
    {
        pi = new RPlayerInfo;
        pi->Unpack(buf);
        _onlinePlayers[pi->Guid] = pi;

        LogDebug("Cluster Interface: PackedPlayerInfo Unpacked Guids %u.", pi->Guid);
    }

    // Release
    m_onlinePlayerMapMutex.Release();
}

void ClusterInterface::Update()
{
    if (retry && time(NULL) >= (lastConnectTime + 30) && !m_connected)
        ConnectToRealmServer();

    WorldPacket * pck;
    uint16 opcode;
    while ((pck = _pckQueue.Pop()))
    {
        opcode = pck->GetOpcode();
        if (opcode < IMSG_NUM_TYPES && ClusterInterface::PHandlers[opcode] != 0)
            (this->*ClusterInterface::PHandlers[opcode])(*pck);
        else
            LogError("ClusterInterface : Unhandled packet %u\n", opcode);
    }

    uint32 t = (uint32)UNIXTIME;

    // Ping the Realm Server to check for Disconnection.

    if (last_pong < t && ((t - last_pong) > 60))
    {
        // no pong for 60 seconds -> remove the socket
        //printf("Remove the Socket time out \n");
        //ConnectionDropped();
    }
}

void ClusterInterface::DestroySession(uint32 sid)
{
    LogNotice("Cluster Interface: DestroySession");
    WorldSession * s = _sessions[sid];
    _sessions[sid] = 0;
    if (s)
    {
        delete s->GetSocket();

        if (s->GetPlayer())
            s->LogoutPlayer(false);

        
        sWorld.removeGlobalSession(s);
        sWorld.removeSession(sid);

        s = NULL;
    }
}


void ClusterInterface::HandleWoWPacket(WorldPacket & pck)
{
    uint32 size, sid;
    uint16 opcode;

    pck >> sid;
    pck >> opcode;
    pck >> size;

    if (!_sessions[sid])
    {
        LogError("HandleWoWPacket : Invalid session: %u", sid);
        return;
    }

    WorldPacket * npck = new WorldPacket(opcode, size);
    npck->resize(size);
    memcpy((void*)npck->contents(), pck.contents() + 10, size);
    _sessions[sid]->QueuePacket(npck);
}

void ClusterInterface::RequestTransfer(Player* plr, uint32 MapId, uint32 InstanceId, const LocationVector & vec)
{
    LogNotice("Cluster Interface: RequestTransfer");
    WorldPacket data(ICMSG_TELEPORT_REQUEST, 32);
    data << plr->GetSession()->GetSocket()->GetSessionId();
    data << MapId;
    data << InstanceId;
    data << vec;
    data << vec.o;
    SendPacket(&data);
}

void ClusterInterface::HandleTeleportResult(WorldPacket & pck)
{
    LogNotice("Cluster Interface: HandleTeleportResult");
    uint32 sessionid;
    uint8 result;
    uint32 mapid, instanceid;
    LocationVector vec;
    float o;

    pck >> sessionid;

    WorldSession* s = GetSession(sessionid);

    if (!s)
    {
        //tell the realm-server we have no session
        WorldPacket data(ICMSG_ERROR_HANDLER, 5);
        data << uint8(1); //1 = no session
        data << sessionid;
        sClusterInterface.SendPacket(&data);
        return;
    }

    pck >> result;
    pck >> mapid;
    pck >> instanceid;
    pck >> vec;
    pck >> o;

    //the destination is on the same server
    if (result == 1)
    {
        if (s->GetPlayer() != NULL)
            sEventMgr.AddEvent(s->GetPlayer(), &Player::EventClusterMapChange, mapid, instanceid, vec, EVENT_UNK, 1, 1, EVENT_FLAG_DO_NOT_EXECUTE_IN_WORLD_CONTEXT);
    }
    else
    {
        WorldPacket nw(SMSG_NEW_WORLD);
        nw << mapid;
        nw << vec;
        nw << o;
        s->SendPacket(&nw);

        uint32 oldmapid = s->GetPlayer()->GetMapId();
        uint32 oldinstanceid = s->GetPlayer()->GetInstanceID();
        uint32 playerlowguid = s->GetPlayer()->GetLowGUID();
        uint8 _class = s->GetPlayer()->getClass();
        
        // Save us to the Database :)
        CharacterDatabase.Execute("UPDATE characters SET mapid=%u, positionX=%f, positionY=%f, positionZ=%f WHERE guid=%u AND acct=%u", mapid, vec.x, vec.y, vec.z, playerlowguid, s->GetAccountId());

        //Arcemu::Sleep(200);
        // shift back to old ones for removing from world
        s->GetPlayer()->SetMapId(oldmapid);
        s->GetPlayer()->SetInstanceID(oldinstanceid);

        //Switch Server
        SendSwitchServer(s, sessionid, playerlowguid, _class, mapid, instanceid, vec, o);

        //Remove us from this Server
        sEventMgr.AddEvent(s->GetPlayer(), &Player::HandleClusterRemove, EVENT_UNK, 1, 1, EVENT_FLAG_DO_NOT_EXECUTE_IN_WORLD_CONTEXT);
    }
}

void ClusterInterface::SendSwitchServer(WorldSession* s, uint32 sessionid, uint32 playerlowguid, uint8 _class, uint32 mapid, uint32 instanceid, LocationVector vec, float o)
{
    LogNotice("Cluster Interface: SendSwitchServer");
    WorldPacket data(ICMSG_SWITCH_SERVER, 100);
    data << sessionid;
    data << playerlowguid;
    data << _class;
    data << mapid;
    data << instanceid;
    data << vec;
    data << o;
    sClusterInterface.SendPacket(&data);

    RPlayerInfo * pRPlayer = GetPlayer(playerlowguid);
    bool newRplr = false;
    if (pRPlayer == NULL)
    {
        pRPlayer = new RPlayerInfo;
        newRplr = true;
    }
    s->GetPlayer()->UpdateRPlayerInfo(pRPlayer, newRplr);

    pRPlayer->MapId = mapid;
    pRPlayer->InstanceId = instanceid;

    data.Initialize(ICMSG_PLAYER_INFO);
    data << pRPlayer->Guid;
    pRPlayer->Pack(data);
    sClusterInterface.SendPacket(&data);
}

void ClusterInterface::HandlePlayerInfo(WorldPacket & pck)
{
    LogNotice("Cluster Interface: HandlePlayerInfo");
    uint32 guid;
    pck >> guid;
    RPlayerInfo * pRPlayer = GetPlayer(guid);
    if (!pRPlayer)
        pRPlayer = new RPlayerInfo;

    pRPlayer->Unpack(pck);

    m_onlinePlayerMapMutex.Acquire();

    _onlinePlayers[pRPlayer->Guid] = pRPlayer;

    m_onlinePlayerMapMutex.Release();
}

bool WorldSession::ClusterTryPlayerLogin(uint32 Guid, uint8 _class, uint32 ClientBuild, std::string GMPermissions, uint32 Account_Flags)
{
    LogDebug("WorldSession : Recvd Player Logon Message");

    if (objmgr.GetPlayer(Guid) != NULL || m_loggingInPlayer || _player)
    {
        // A character with that name already exists 0x3E
        uint8 respons = 0x3E;
        OutPacket(SMSG_CHARACTER_LOGIN_FAILED, 1, &respons);
        return false;
    }

    Player* plr = NULL;

    switch (_class)
    {
    case WARRIOR:
        plr = new Warrior(Guid);
        break;
    case PALADIN:
        plr = new Paladin(Guid);
        break;
    case HUNTER:
        plr = new Hunter(Guid);
        break;
    case ROGUE:
        plr = new Rogue(Guid);
        break;
    case PRIEST:
        plr = new Priest(Guid);
        break;
    case DEATHKNIGHT:
        plr = new DeathKnight(Guid);
        break;
    case SHAMAN:
        plr = new Shaman(Guid);
        break;
    case MAGE:
        plr = new Mage(Guid);
        break;
    case WARLOCK:
        plr = new Warlock(Guid);
        break;
    case DRUID:
        plr = new Druid(Guid);
        break;
    }

    if (plr == NULL)
    {
        LogError("ClusterInterface : Class %u unknown!", _class);
        uint8 respons = E_CHAR_LOGIN_NO_CHARACTER;
        OutPacket(SMSG_CHARACTER_LOGIN_FAILED, 1, &respons);
        return false;
    }

    plr->SetSession(this);
    m_bIsWLevelSet = false;
    SetClientBuild(ClientBuild);
    LoadSecurity(GMPermissions);
    SetAccountFlags(Account_Flags);

    m_lastPing = (uint32)UNIXTIME;

    LogDebug("WorldSession : Async loading player %u", Guid);
    m_loggingInPlayer = plr;
    plr->LoadFromDB(Guid);
    return true;
}

//This must be an event to stay in the correct context!
void Player::EventClusterMapChange(uint32 mapid, uint32 instanceid, LocationVector location)
{
    LogNotice("Cluster Interface: ClusterMapChange");
    WorldPacket data;
    uint32 status = sInstanceMgr.PreTeleport(mapid, this, instanceid);
    if (status != INSTANCE_OK)
    {
        data.Initialize(SMSG_TRANSFER_ABORTED);
        data << mapid << status;
        GetSession()->SendPacket(&data);
        return;
    }

    if (instanceid)
        m_instanceId = instanceid;

    if (IsInWorld())
        RemoveFromWorld();

    data.Initialize(SMSG_NEW_WORLD);
    data << (uint32)mapid << location << location.o;
    GetSession()->SendPacket(&data);
    SetMapId(mapid);


    SetPlayerStatus(TRANSFER_PENDING);
    m_sentTeleportPosition = location;
    SetPosition(location);
    //ResetHeartbeatCoords();
    z_axisposition = 0.0f;
}

void Player::HandleClusterRemove()
{
    LogNotice("Cluster Interface: HandleClusterRemove");
    RemoveAllAuras();
    if (IsInWorld())
        RemoveFromWorld();

    sEventMgr.AddEvent(this, &Player::Destructor, EVENT_UNK, 1000, 1, EVENT_FLAG_DO_NOT_EXECUTE_IN_WORLD_CONTEXT | EVENT_FLAG_DELETES_OBJECT);

    if (GetSession() != NULL)
    {
        GetSession()->SetPlayer(NULL);
        if (GetSession()->GetSocket() != NULL)
        {
            uint32 sessionid = GetSession()->GetSocket()->GetSessionId();
            ok_to_remove = true;

            sClusterInterface.DestroySession(sessionid);
        }
        SetSession(NULL);
    }
    objmgr.RemovePlayer(this);
}

void ClusterInterface::HandleSessionRemoved(WorldPacket & pck)
{
    uint32 sessionid;
    pck >> sessionid;

    WorldSession* s = GetSession(sessionid);
    if (s != NULL)
        delete s;
}

void ClusterInterface::HandleSaveAllPlayers(WorldPacket & pck)
{
    sWorld.saveAllPlayersToDb();
}

void ClusterInterface::HandleTransporterMapChange(WorldPacket & pck)
{

}

void ClusterInterface::HandleCreatePlayer(WorldPacket & pck)
{
    uint32 accountid, size;
    uint8 class_;
    uint16 opcode;

    pck >> accountid;
    pck >> class_;
    pck >> opcode;
    pck >> size;

    LogDetail("CMSG_CHAR_CREATE : accountid %u, opcode %u, size %u", accountid, opcode, size);

    if (_sessions[accountid] != NULL)
        return;

    /* create the session */

    WorldSession* s = sWorld.FindSession(accountid);

    /* create the socket */
    WorldSocket * so = new WorldSocket(accountid);

    if (s == NULL)
        s = new WorldSession(accountid, "", so);

    _sessions[accountid] = s;
    sWorld.addSession(s);
    s->SetSocket(so);

    //construct the cmsg_char_create
    WorldPacket data(opcode, size);
    data.resize(size);
    memcpy((void*)data.contents(), pck.contents() + 12, size);

    Player * pNewChar = objmgr.CreatePlayer(class_);
    pNewChar->SetSession(s);

    if (!pNewChar->Create(data))
    {
        // failed.
        pNewChar->ok_to_remove = true;
        delete pNewChar;
        return;
    }

    pNewChar->UnSetBanned();
    pNewChar->addSpell(22027);	  // Remove Insignia

    if (pNewChar->getClass() == WARLOCK)
    {
        pNewChar->AddSummonSpell(416, 3110);		// imp fireball
        pNewChar->AddSummonSpell(417, 19505);
        pNewChar->AddSummonSpell(1860, 3716);
        pNewChar->AddSummonSpell(1863, 7814);
    }

    pNewChar->SaveToDB(true);
    pNewChar->ok_to_remove = true;

    // Remove us from Sessions
    pNewChar->SetSession(NULL);
    sWorld.removeSession(accountid);

    delete pNewChar;

    //now lets send the info back, send accountid, we have no sessionid
    WorldPacket result(ICMSG_CREATE_PLAYER, 5);
    result << accountid;
    result << uint8(0x2F); //CHAR_CREATE_SUCCESS
    SendPacket(&result);
}

//Sends our Playerinfo to RealmServer
void ClusterInterface::SendPlayerInfo(uint32 guid)
{
    RPlayerInfo* player = GetPlayer(guid);

    if (player)
    {
        WorldPacket data(ICMSG_PLAYER_INFO, 100);
        data << player->Guid;
        player->Pack(data);
        SendPacket(&data);
    }
};

void ClusterInterface::HandleChannelAction(WorldPacket & pck)
{
    uint8 action;
    pck >> action;

    switch (action)
    {
        case CHANNEL_JOIN:
        {
            uint32 guid;
            uint32 cid;
            Player * pPlayer;

            pck >> guid;
            pck >> cid;

            pPlayer = objmgr.GetPlayer(guid);
            if (pPlayer == NULL)
                return;
        
            pPlayer->JoinedChannel(cid);
            LogDebug("ClusterInterface : Joined Channel %u", cid);
            break;

        }
        case CHANNEL_PART:
        {
            uint32 guid;
            uint32 cid;
            Player * pPlayer;

            pck >> guid;
            pck >> cid;

            pPlayer = objmgr.GetPlayer(guid);
            if (pPlayer == NULL)
                return;

            pPlayer->LeftChannel(cid);
            break;
        }
        default:
        {
            LogDebug("ClusterInterface : HandleChannelAction opcode, unhandled action %u", action);
            return;
        }
    }
}

void ClusterInterface::HandleChannelLFGDungeonStatusRequest(WorldPacket & pck)
{
    
}