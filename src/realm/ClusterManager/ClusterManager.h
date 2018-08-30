/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#define MAX_WORKER_SERVERS 100
#define MAX_SINGLE_MAPID 600

struct Servers
{
    uint32 Mapid;
    WorkerServer* workerServer;
};

#define IS_INSTANCE(a) (((a)>1)&&((a)!=530))
#define IS_MAIN_MAP(a) (((a)<2)||((a)==530) ||((a)==571))

class ClusterMgr : public Singleton<ClusterMgr>
{
    typedef std::map<uint32, Servers*> WorkerServerMap;

private:
    RWLock m_lock;
    Mutex Slave_Lock;
    std::set<WorkerServer*> JunkServers;
    WorkerServer* WorkerServers[MAX_WORKER_SERVERS];
    WorkerServerMap workerServers;

    uint32 m_maxWorkerServer;

public:
    std::multimap<uint32, Servers*> Maps;

    ClusterMgr();

    void OnServerDisconnect(WorkerServer* s);

    WorkerServer* GetServerByMapId(uint32 MapId);
    WorkerServer* GetAnyWorkerServer();
    WorkerServer* CreateWorkerServer(WorkerServerSocket * s);

    _inline WorkerServer* GetWorkerServer(uint32 Id) { return (Id < MAX_WORKER_SERVERS) ? WorkerServers[Id] : 0; }

    /* distribute packet to all worker servers */
    _inline void DistributePacketToAll(WorldPacket * data) { DistributePacketToAll(data, 0); }

    /* distribute packet to all worker server excluding one */
    void DistributePacketToAll(WorldPacket * data, WorkerServer * exclude);

    /* loop */
    void Update();

};


#define sClusterMgr ClusterMgr::getSingleton()


