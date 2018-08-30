/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

// Move this to Config files
#define MAX_SESSIONS 3000

#ifdef WIN32
typedef std::unordered_map<std::string, RPlayerInfo*> ClientStringMap;
#else
typedef std::map<string, RPlayerInfo*> ClientStringMap;
#endif

class ClientMgr : public Singleton<ClientMgr>
{
public:
    typedef std::unordered_map<uint32, RPlayerInfo*> ClientMap;
    typedef std::unordered_map<uint32, Session*> SessionMap;
protected:
    RWLock m_lock;
    ClientMap m_clients;
    ClientStringMap m_stringclients;
    uint32 m_maxSessionId;
public:
    SessionMap m_sessions;
    std::unordered_map<RPlayerInfo*, Session*> m_sessionsbyinfo;
    std::vector<uint32> m_reusablesessions;
    std::vector<uint32> m_pendingdeletesessionids;

    ClientMgr();
    ~ClientMgr();

    /* create rplayerinfo struct */
    RPlayerInfo * CreateRPlayer(uint32 guid);

    /* destroy rplayerinfo struct */
    void DestroyRPlayerInfo(uint32 guid);

    _inline Session* GetSessionByRPInfo(RPlayerInfo* p)
    {
        m_lock.AcquireReadLock();
        std::unordered_map<RPlayerInfo*, Session*>::iterator itr = m_sessionsbyinfo.find(p);
        if (itr == m_sessionsbyinfo.end())
        {
            m_lock.ReleaseReadLock();
            return NULL;
        }
        Session* s = itr->second;
        m_lock.ReleaseReadLock();
        return s;
    }

    _inline void AddSessionRPInfo(Session* s, RPlayerInfo* p)
    {
        m_lock.AcquireWriteLock();
        m_sessionsbyinfo.insert(std::make_pair(p, s));
        m_lock.ReleaseWriteLock();
    }

    _inline void AddStringPlayerInfo(RPlayerInfo* p)
    {
        m_lock.AcquireWriteLock();
        m_stringclients.insert(std::make_pair(p->Name, p));
        m_lock.ReleaseWriteLock();
    }

    /* get rplayer */
    _inline RPlayerInfo * GetRPlayer(uint32 guid)
    {
        m_lock.AcquireReadLock();
        ClientMap::iterator itr = m_clients.find(guid);
        if (itr == m_clients.end())
        {
            m_lock.ReleaseReadLock();
            return NULL;
        }
        RPlayerInfo* r = itr->second;
        m_lock.ReleaseReadLock();
        return r;
    }

    /* get rplayer */
    _inline RPlayerInfo * GetRPlayer(std::string name)
    {
        m_lock.AcquireReadLock();
        ClientStringMap::iterator itr = m_stringclients.find(name);
        if (itr == m_stringclients.end())
        {
            m_lock.ReleaseReadLock();
            return NULL;
        }
        RPlayerInfo* r = itr->second;
        m_lock.ReleaseReadLock();
        return r;
    }

    /* send "mini" client data to all servers */
    void SendPackedClientInfo(WorkerServer * server);

    /* get session by id */
    _inline Session * GetSession(uint32 Id)
    {
        SessionMap::iterator itr = m_sessions.find(Id);
        if (itr == m_sessions.end() || itr->second->deleted)
            return NULL;
        return itr->second;
    }

    _inline Session* GetSessionByAccountId(uint32 Id)
    {
        m_lock.AcquireReadLock();
        for (SessionMap::iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
        {
            if (!itr->second->deleted && itr->second->GetAccountId() == Id)
            {
                Session* s = itr->second;
                m_lock.ReleaseReadLock();
                return s;
            }
        }
        m_lock.ReleaseReadLock();
        return NULL;
    }

    _inline Session* FindSessionByName(const char* Name) //case insensitive
    {
        m_lock.AcquireReadLock();

        // loop sessions, see if we can find him
        SessionMap::iterator itr = m_sessions.begin();
        for (; itr != m_sessions.end(); ++itr)
        {
            if (!stricmp(itr->second->GetAccountName().c_str(), Name))
            {
                m_lock.ReleaseReadLock();
                return itr->second;
            }
        }
        m_lock.ReleaseReadLock();
        return 0;
    }

    /* create a new session, returns null if the player is already logged in */
    Session * CreateSession(uint32 AccountId);

    void DestroySession(uint32 sessionid);

    /* updates sessions */
    void Update();
};

#define sClientMgr ClientMgr::getSingleton()


