/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "RealmStdAfx.h"

initialiseSingleton(ClusterMgr);
ClusterMgr::ClusterMgr()
{
    memset(WorkerServers, 0, sizeof(WorkerServer*) * MAX_WORKER_SERVERS);
    m_maxWorkerServer = 0;
    LogDefault("ClusterMgr : Interface Created");

    WorkerServer::InitHandlers();
}

WorkerServer * ClusterMgr::GetServerByMapId(uint32 MapId)
{
    WorkerServerMap::iterator itr = Maps.find(MapId);
    return (itr == Maps.end()) ? NULL : itr->second->workerServer;
}

WorkerServer* ClusterMgr::GetAnyWorkerServer()
{
    m_lock.AcquireReadLock();

    for (uint32 i = 0; i < MAX_WORKER_SERVERS; ++i)
    {
        if (WorkerServers[i] != NULL)
        {
            m_lock.ReleaseReadLock();
            return WorkerServers[i];
        }
    }

    m_lock.ReleaseReadLock();

    return NULL;
}

WorkerServer * ClusterMgr::CreateWorkerServer(WorkerServerSocket * socket)
{
    /* find an id */
    m_lock.AcquireWriteLock();

    uint32 WorkerId;

    for (WorkerId = 1; WorkerId < MAX_WORKER_SERVERS; ++WorkerId)
    {
        if (WorkerServers[WorkerId] == 0)
            break;
    }

    if (WorkerId == MAX_WORKER_SERVERS)
    {
        m_lock.ReleaseWriteLock();
        return NULL;// No spaces
    }

    LogDebug("ClusterMgr : Allocating worker server %u to %s:%u", WorkerId, socket->GetRemoteIP().c_str(), socket->GetRemotePort());

    // Register the Server :D
    WorkerServers[WorkerId] = new WorkerServer(WorkerId, socket);

    if (m_maxWorkerServer < WorkerId)
        m_maxWorkerServer = WorkerId;

    m_lock.ReleaseWriteLock();
    return WorkerServers[WorkerId];
}

void ClusterMgr::Update()
{
    Slave_Lock.Acquire();

    for (uint32 i = 1; i <= m_maxWorkerServer; ++i)
        if (WorkerServers[i])
            WorkerServers[i]->Update();

    for (auto itr : JunkServers)
        if ((itr)->Destructable())
        {
            LogNotice("Delete Worker Server %u Completly", itr->GetID());
            delete (itr);
        }

    Slave_Lock.Release();
}

void ClusterMgr::DistributePacketToAll(WorldPacket * data, WorkerServer * exclude)
{
    Slave_Lock.Acquire();

    for (uint32 i = 0; i <= m_maxWorkerServer; ++i)
        if (WorkerServers[i] && WorkerServers[i] != exclude)
            WorkerServers[i]->SendPacket(data);            

    Slave_Lock.Release();
}

void ClusterMgr::OnServerDisconnect(WorkerServer* workerServer)
{
    Slave_Lock.Acquire();

    uint32_t workerId = workerServer->GetID();

    if (Maps.size())
    {
        WorkerServerMap::iterator itr = Maps.begin();
        while (itr != Maps.end())
        {
            if (itr->second->workerServer == workerServer)
            {
                LogWarning("ClusterMgr : Removing Map %u on WorkerServer %u due to worker server disconnection", itr->second->Mapid, workerId);
                delete itr->second;
                itr = Maps.erase(itr);
            }
            else
                itr++;
        }
    }

    if (WorkerServers[workerId] == workerServer)
    {
        LogWarning("ClusterMgr : Removing Worker Server due to disconnection");
        JunkServers.insert(WorkerServers[workerId]);
        workerServer->RemoveSocket();
        WorkerServers[workerId] = NULL;
    }

    Slave_Lock.Release();
}