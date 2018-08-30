/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

// Move this to Config files
#define MAX_SESSIONS_PER_SERVER 1000

struct Instance;
typedef void(WorkerServer::*WorkerServerHandler)(WorldPacket &);

class WorkerServer
{
    static WorkerServerHandler PHandlers[IMSG_NUM_TYPES];
    uint32 m_id;
    WorkerServerSocket * m_socket;
    FastQueue<WorldPacket*, Mutex> m_recvQueue;

public:
    static void InitHandlers();
    WorkerServer(uint32 id, WorkerServerSocket * s);
    ~WorkerServer() { sSocketGarbageCollector.QueueSocket(m_socket); };
    // hackfixx
    _inline void SendPacket(WorldPacket * data) { if (m_socket && this) m_socket->SendPacket(data); }
    _inline void SendWoWPacket(Session * from, WorldPacket * data) { if (m_socket) m_socket->SendWoWPacket(from, data); }
    _inline void QueuePacket(WorldPacket * data) { m_recvQueue.Push(data); }
    _inline uint32 GetID() { return m_id; }

    bool Destructable() { return m_socket == nullptr; };

    _inline void RemoveSocket()
    {
        sSocketGarbageCollector.QueueSocket(m_socket);
        m_socket = nullptr;
    };

    void Update();

    uint32 last_ping;
    uint32 last_pong;
    uint32 pingtime;
    uint32 latency;

    void SendPing();

protected:
    /* packet handlers */
    void HandleSwitchServer(WorldPacket & pck);
    void HandleRegisterWorker(WorldPacket & pck);
    void HandleWoWPacket(WorldPacket & pck);
    void HandlePlayerLoginResult(WorldPacket & pck);
    void HandlePlayerLogout(WorldPacket & pck);
    void HandleTeleportRequest(WorldPacket & pck);
    void HandleError(WorldPacket & pck);
    void HandleSaveAllPlayers(WorldPacket & pck);
    void HandleTransporterMapChange(WorldPacket & pck);
    void HandleCreatePlayerResult(WorldPacket & pck);
    void HandlePlayerInfo(WorldPacket & pck);
    void Pong(WorldPacket & pck);
    void HandleChannelAction(WorldPacket & pck);
    void HandleChannelUpdate(WorldPacket & pck);
    void HandleChannelLFGDungeonStatusReply(WorldPacket& pck);
};
