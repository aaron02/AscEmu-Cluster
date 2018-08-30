/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#ifndef RLOGONCOMMHANDLER_H
#define RLOGONCOMMHANDLER_H

typedef struct
{
    uint32 ID;
    std::string Name;
    std::string Address;
    uint32 Port;
    uint32 ServerID;
    uint32 RetryTime;
    bool   Registered;
}LogonServer;

typedef struct
{
    std::string Name;
    std::string Address;
    uint32 flags;
    uint32 Icon;
    uint32 TimeZone;
    float Population;
    uint8 Lock;
    uint32 GameBuild;
}Realm;

enum RealmType
{
    REALMTYPE_NORMAL = 0,
    REALMTYPE_PVP = 3,
    REALMTYPE_RP = 6,
    REALMTYPE_RPPVP = 8,
};

class SocketLoadBalancer;

class LogonCommHandler : public Singleton<LogonCommHandler>
{
#ifdef WIN32
    typedef std::unordered_map<std::string, std::string> ForcedPermissionMap;
#else
    typedef std::map<std::string, std::string> ForcedPermissionMap;
#endif

    ForcedPermissionMap forced_permissions;
    std::map<LogonServer*, LogonCommClientSocket*> logons;
    std::map<uint32, WorldSocket*> pending_logons;
    std::set<Realm*> realms;
    std::set<LogonServer*> servers;
    uint32 idhigh;
    uint32 next_request;
    Mutex mapLock;
    Mutex pendingLock;
    bool pings;
    uint32 _realmType;
    uint32 pLimit;
    float server_population;

public:
    uint8 sql_passhash[20];

    LogonCommHandler();
    ~LogonCommHandler();

    LogonCommClientSocket* ConnectToLogon(std::string Address, uint32 Port);
    void UpdateAccountCount(uint32 account_id, uint8 add);
    void RequestAddition(LogonCommClientSocket* Socket);
    void CheckAllServers();
    void Startup();
    void AddForcedPermission(std::string acct, std::string perm);
    void ConnectionDropped(uint32 ID);
    void AdditionAck(uint32 ID, uint32 ServID);
    void UpdateSockets();
    void Connect(LogonServer* server);
    void ConnectAll();
    //void LogonDatabaseSQLExecute(const char* str, ...);
    //void LogonDatabaseReloadAccounts();
    void RefreshRealmPop();

    void Account_SetBanned(const char* account, uint32 banned, const char* reason);
    void Account_SetGM(const char* account, const char* flags);
    void Account_SetMute(const char* account, uint32 muted);
    void Account_CheckExist(const char* account, const char* request_name, const char* additional);
    void IPBan_Add(const char* ip, uint32 duration, const char* reason);
    void IPBan_Remove(const char* ip);
    void AccountChangePassword(const char* old_pw, const char* new_password, const char* account_name);
    void AccountCreate(const char* name, const char* password, const char* account_name);

    void LoadRealmConfiguration();
    void AddServer(std::string Name, std::string Address, uint32 Port);

    float GetServerPopulation() { return server_population; }

    _inline uint32 GetRealmType() { return _realmType; }
    void SetRealmType(uint32 type) { _realmType = type; }

    /////////////////////////////
    // Worldsocket stuff
    ///////

    uint32 ClientConnected(std::string AccountName, WorldSocket * Socket);
    void UnauthedSocketClose(uint32 id);
    void RemoveUnauthedSocket(uint32 id);
    inline WorldSocket* GetSocketByRequest(uint32 id)
    {
        //pendingLock.Acquire();

        WorldSocket * sock;
        std::map<uint32, WorldSocket*>::iterator itr = pending_logons.find(id);
        sock = (itr == pending_logons.end()) ? 0 : itr->second;

        //pendingLock.Release();
        return sock;
    }
    inline Mutex & GetPendingLock() { return pendingLock; }
    const std::string* GetForcedPermissions(std::string & username);

    void TestConsoleLogon(std::string & username, std::string & password, uint32 requestnum);
};

#define sLogonCommHandler LogonCommHandler::getSingleton()

#endif