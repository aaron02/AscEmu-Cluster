/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#ifndef _CLUSTERINTERFACE_H
#define _CLUSTERINTERFACE_H

#define MAX_SESSIONS 3000
#include "../realm/Server/Structures.h"

class ClusterInterface;
typedef void(ClusterInterface::*ClusterInterfaceHandler)(WorldPacket&);

class ClusterInterface : public Singleton<ClusterInterface>
{
    WSClient * _clientSocket;
    FastQueue<WorldPacket*, Mutex> _pckQueue;
    FastQueue<WorldPacket*, Mutex> _recvQueue;
    uint32 lastConnectTime;
    WorldSession * _sessions[MAX_SESSIONS];
    bool m_connected = false;
    bool retry;
    uint8 key[20];
    uint32 m_latency;
    uint32 last_pong;
    uint32 pingtime;
    uint32 last_ping;
    Mutex m_mapMutex;

public:

    Mutex m_onlinePlayerMapMutex;
    typedef std::unordered_map<uint32, RPlayerInfo*> OnlinePlayerStorageMap;
    OnlinePlayerStorageMap _onlinePlayers;
    std::string GenerateVersionString();

    static ClusterInterfaceHandler PHandlers[IMSG_NUM_TYPES];
    static void InitHandlers();

    ClusterInterface();
    ~ClusterInterface();

    void ForwardWoWPacket(uint16 opcode, uint32 size, const void * data, uint32 sessionid);
    void ConnectToRealmServer();
    void HandlePacket(WorldPacket & recvData);

    RPlayerInfo * GetPlayer(uint32 guid)
    {
        //RPlayerInfo * inf;
        OnlinePlayerStorageMap::iterator itr;
        m_onlinePlayerMapMutex.Acquire();
        itr = _onlinePlayers.find(guid);
        m_onlinePlayerMapMutex.Release();
        return (itr == _onlinePlayers.end()) ? NULL : itr->second;
    }

    WorldSession * GetSession(uint32 sid) { return _sessions[sid]; }

    void HandleSessionRemoved(WorldPacket & pck);
    void HandleTeleportResult(WorldPacket & pck);
    void HandleAuthRequest(WorldPacket & pck);
    void Ping(WorldPacket& pck);
    void Pong(WorldPacket& pck);
    void HandleAuthResult(WorldPacket & pck);
    void HandleRegisterResult(WorldPacket & pck);
    void HandlePlayerLogin(WorldPacket & pck);
    void HandlePackedPlayerInfo(WorldPacket & pck);
    void HandlePlayerInfo(WorldPacket & pck);
    void HandleWoWPacket(WorldPacket & pck);
    void HandleSaveAllPlayers(WorldPacket & pck);
    void HandleTransporterMapChange(WorldPacket & pck);
    void HandleCreatePlayer(WorldPacket & pck);
    void HandleDestroyPlayerInfo(WorldPacket & pck);
    void HandleChannelAction(WorldPacket & pck);
    void HandleChannelLFGDungeonStatusRequest(WorldPacket & pck);

    inline void QueuePacket(WorldPacket* pck)
    {
        _pckQueue.Push(pck);
        //m_lastPing = (uint32)UNIXTIME;
    }

    void SendSwitchServer(WorldSession* s, uint32 sessionid, uint32 playerlowguid, uint8 _class, uint32 mapid, uint32 instanceid, LocationVector vec, float o);

    void Update();

    //Sends our Playerinfo to all Worker Servers
    void SendPlayerInfo(uint32 guid);

    void DestroySession(uint32 sid);
    void ConnectionDropped();

    inline void SendPacket(WorldPacket * data) { if (_clientSocket) _clientSocket->SendPacket(data); }
    inline void SetSocket(WSClient * s) { _clientSocket = s; }

    void RequestTransfer(Player* plr, uint32 MapId, uint32 InstanceId, const LocationVector & vec);
};

typedef void (ClusterInterface::*clusterpacket_handler)(WorldPacket&);

#define sClusterInterface ClusterInterface::getSingleton()

#endif
