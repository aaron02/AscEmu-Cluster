/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "RealmStdAfx.h"

// Database impl
Database* sCharSQL;
Database* sWorldSQL;
Arcemu::Threading::AtomicBoolean mrunning(true);
ConfigMgr Conf;

createFileSingleton(Master);
bool running;

void Master::_OnSignal(int s)
{
    switch (s)
    {

    case SIGINT:
    case SIGTERM:
    case SIGABRT:
#ifdef _WIN32
    case SIGBREAK:
#endif
        Master::m_stopEvent = true;
        mrunning.SetVal(false);
        break;
    }

    signal(s, _OnSignal);

}

void Master::_HookSignals()
{
    signal(SIGINT, _OnSignal);
    signal(SIGTERM, _OnSignal);
    signal(SIGABRT, _OnSignal);
#ifdef _WIN32
    signal(SIGBREAK, _OnSignal);
#else
    signal(SIGHUP, _OnSignal);
    signal(SIGUSR1, _OnSignal);

    // crash handler
    signal(SIGSEGV, segfault_handler);
    signal(SIGFPE, segfault_handler);
    signal(SIGILL, segfault_handler);
    signal(SIGBUS, segfault_handler);
#endif
}

void Master::_UnhookSignals()
{
    signal(SIGINT, 0);
    signal(SIGTERM, 0);
    signal(SIGABRT, 0);
#ifdef _WIN32
    signal(SIGBREAK, 0);
#else
    signal(SIGHUP, 0);
#endif

}

Master::Master()
{

}

Master::~Master()
{
}

void Master::PrintBanner()
{
    AscLog.ConsoleLogDefault(false, "<< AscEmu %s/%s-%s (%s) :: Cluster Server >>", BUILD_HASH_STR, CONFIG, PLATFORM_TEXT, ARCH);
    AscLog.ConsoleLogDefault(false, "========================================================");
    AscLog.ConsoleLogError(true, "<< AscEmu %s/%s-%s (%s) :: Cluster Server >>", BUILD_HASH_STR, CONFIG, PLATFORM_TEXT, ARCH); // Echo off.
    AscLog.ConsoleLogError(true, "========================================================"); // Echo off.
}

volatile bool Master::m_stopEvent = false;
volatile bool bServerShutdown = false;

bool Master::Run(int argc, char ** argv)
{
    time_t curTime;

    AscLog.InitalizeLogFiles("realm");

    if (!LoadRealmConfiguration())
    {
        AscLog.~AscEmuLog();
        return false;
    }

    running = true;

    AscLog.SetFileLoggingLevel(Conf.MainConfig.getIntDefault("Log", "WorldFileLogLevel", 0));

    /* Initialize global timestamp */
    UNIXTIME = time(NULL);

    /* Print Banner */
    PrintBanner();

    LogNotice("Database : Connecting to database...");

    sCharSQL = NULL;
    sWorldSQL = NULL;

    if (!StartCharDb() || !StartWorldDb())
    {
        AscLog.~AscEmuLog();
        return false;
    }

    LogDetail("Database : Connections established.");
    LogDetail("Database : Interface Created.");

    ThreadPool.Startup();
    uint32 LoadingTime = getMSTime();

    _HookSignals();

    LogDetail("Realmserver : Loading DBC files...");
    if (!LoadDBCs())
    {
        AscLog.ConsoleLogMajorError("One or more of the DBC files are missing.", "These are absolutely necessary for the server to function.", "The server will not start without them.", "");
        return false;
    }

    new ClusterMgr;
    new ClientMgr;

    LogDetail("Storage : Begin DB Loading...");
    new MySQLDataStore;
    sMySQLStore.LoadAdditionalTableConfig();
    sMySQLStore.LoadItemPagesTable();
    sMySQLStore.LoadItemPropertiesTable();
    sMySQLStore.LoadCreaturePropertiesTable();
    sMySQLStore.LoadGameObjectPropertiesTable();
    sMySQLStore.LoadQuestPropertiesTable();
    sMySQLStore.LoadWorldMapInfoTable();
    LogDetail("Storage : DB Loading complete...");

    new AddonMgr;

    if (!ChannelMgr::getSingletonPtr())
        new ChannelMgr;

    new ChatHandler;

    channelmgr.seperatechannels = Conf.MainConfig.getBoolDefault("Server", "SeperateChatChannels", false);
    m_lfgForNonLfg = Conf.MainConfig.getBoolDefault("Server", "EnableLFGJoin", false);

    Channel::LoadConfSettings();

#define MAKE_TASK(sp, ptr) tl.AddTask(new Task(new CallbackP0<sp>(sp::getSingletonPtr(), &sp::ptr)))
    // Fill the task list with jobs to do.
    TaskList tl;

    // spawn worker threads (2 * number of cpus)
    tl.spawn();

    // storage stuff has to be loaded first
    tl.wait();

    MAKE_TASK(AddonMgr, LoadFromDB);

#undef MAKE_TASK

    // wait for them to exit, now.
    tl.kill();
    tl.waitForThreadsToExit();

    new SocketMgr;
    new SocketGarbageCollector;
    sSocketMgr.SpawnWorkerThreads();

    /* connect to LS */
    new LogonCommHandler();
    sLogonCommHandler.Startup();

    std::string host = Conf.MainConfig.getStringDefault("Listen", "Host", "0.0.0.0");
    int wsport = Conf.MainConfig.getIntDefault("Listen", "WorldServerPort", 8129);


    LogNotice("Network : Network Subsystem Started.");

    // Create listener
    ListenSocket<WorldSocket> * ls = new ListenSocket<WorldSocket>(host.c_str(), wsport);
    bool listnersockcreate = ls->IsOpen();
#ifdef WIN32
    if (listnersockcreate)
        ThreadPool.ExecuteTask(ls);
#endif

    LogNotice("Network : Opening Server Port...");
    ListenSocket<WorkerServerSocket> * isl = new ListenSocket<WorkerServerSocket>("0.0.0.0", 11010);
    bool ssc = isl->IsOpen();

    if(ssc)
        ThreadPool.ExecuteTask(isl);

    uint32 realCurrTime, realPrevTime;
    realCurrTime = realPrevTime = getMSTime();

    sSocketMgr.SpawnWorkerThreads();

    LoadingTime = getMSTime() - LoadingTime;
    LogNotice("Server : Ready for connections. Startup time: %ums \n", LoadingTime);

    m_startTime = uint32(UNIXTIME);

#ifdef WIN32
    HANDLE hThread = GetCurrentThread();
#endif

    uint32 loop_counter = 0;

    while (mrunning.GetVal())
    {
        if (!((++loop_counter) % 10000))		// 5mins
        {
            ThreadPool.ShowStats();
            ThreadPool.IntegrityCheck();
        }

        if (!(loop_counter % 5))
        {
            sSocketGarbageCollector.Update();
            UNIXTIME = time(NULL);
            g_localTime = *localtime(&UNIXTIME);
        }

        sLogonCommHandler.UpdateSockets();
        sClientMgr.Update();
        sClusterMgr.Update();

        Arcemu::Sleep(1000);
    }

    // begin server shutdown
    LogNotice("Shutdown : Initiated at %s", Util::GetCurrentDateTimeString());
    bServerShutdown = true;

    // send a query to wake it up if its inactive
    LogNotice("Database : Clearing all pending queries...");

    // kill the database thread first so we don't lose any queries/data
    sCharSQL->EndThreads();
    sWorldSQL->EndThreads();
    sCharSQL->Shutdown();
    sWorldSQL->Shutdown();
    delete sCharSQL;
    delete sWorldSQL;

    LogNotice("Network : Shutting down network subsystem.");
#ifdef WIN32
    sSocketMgr.ShutdownThreads();
#endif
    sSocketMgr.CloseAll();

    LogNotice("Network : Closing inter-communication threads");
    isl->Close();
    ls->Close();

    LogNotice("ThreadPool : Shutting down thread pool");
    ThreadPool.Shutdown();

    delete LogonCommHandler::getSingletonPtr();
}

#ifdef WIN32
void OnCrash(bool Terminate)
{
    try
    {
        sWorldSQL->EndThreads();
        sCharSQL->EndThreads();
    }
    catch (...)
    {
        LogError("Database : Threw exception waiting for queries to finish");
    }

    try
    {
        WorldPacket data(ISMSG_SAVE_ALL_PLAYERS);
        sClusterMgr.DistributePacketToAll(&data);
    }
    catch (...)
    {
        LogError("Network : Threw exception telling world servers to save players");
    }
}
#endif

bool Master::StartCharDb()
{
    std::string dbHostname = Conf.MainConfig.getStringDefault("CharacterDatabase", "Hostname", "");
    std::string dbUsername = Conf.MainConfig.getStringDefault("CharacterDatabase", "Username", "");
    std::string dbPassword = Conf.MainConfig.getStringDefault("CharacterDatabase", "Password", "");
    std::string dbDatabase = Conf.MainConfig.getStringDefault("CharacterDatabase", "Name", "");
    int connections = Conf.MainConfig.getIntDefault("CharacterDatabase", "Connections", 5);
    int dbPort = Conf.MainConfig.getIntDefault("CharacterDatabase", "Port", 3306);

    // Configure Main Database
    bool existsUsername = !dbUsername.empty();
    bool existsPassword = !dbPassword.empty();
    bool existsHostname = !dbHostname.empty();
    bool existsName = !dbDatabase.empty();

    bool result = existsUsername && existsPassword && existsHostname && existsName;

    if (!result)
    {
        //Build informative error message
        //Built as one string and then printed rather than calling Log.outString(...) for every line,
        //  as experiments has seen other thread write to the console inbetween calls to Log.outString(...)
        //  resulting in unreadable error messages.
        //If the <LogonDatabase> tag is malformed, all parameters will fail, and a different error message is given

        std::string errorMessage = "sql: Certain <CharacterDatabase> parameters not found in " CONFDIR "\\world.conf \r\n";
        if (!(existsHostname || existsUsername || existsPassword || existsName))
        {
            errorMessage += "  Double check that you have remembered the entire <CharacterDatabase> tag.\r\n";
            errorMessage += "  All parameters missing. It is possible you forgot the first '<' character.\r\n";
        }
        else
        {
            errorMessage += "  Missing paramer(s):\r\n";
            if (!existsHostname) { errorMessage += "    Hostname\r\n"; }
            if (!existsUsername) { errorMessage += "    Username\r\n"; }
            if (!existsPassword) { errorMessage += "    Password\r\n"; }
            if (!existsName) { errorMessage += "    Name\r\n"; }
        }

        LOG_ERROR(errorMessage.c_str());
        return false;
    }

    sCharSQL = Database::CreateDatabaseInterface();

    // Initialize it
    if (!sCharSQL->Initialize(dbHostname.c_str(), (unsigned int)dbPort, dbUsername.c_str(),
        dbPassword.c_str(), dbDatabase.c_str(), connections,
        16384))
    {
        LogError("Configs : Connection to CharacterDatabase failed. Check your database configurations!");
        return false;
    }

    return true;
}

bool Master::StartWorldDb()
{
    std::string dbHostname = Conf.MainConfig.getStringDefault("WorldDatabase", "Hostname", "");
    std::string dbUsername = Conf.MainConfig.getStringDefault("WorldDatabase", "Username", "");
    std::string dbPassword = Conf.MainConfig.getStringDefault("WorldDatabase", "Password", "");
    std::string dbDatabase = Conf.MainConfig.getStringDefault("WorldDatabase", "Name", "");
    int connections = Conf.MainConfig.getIntDefault("WorldDatabase", "Connections", 3);

    int dbPort = Conf.MainConfig.getIntDefault("WorldDatabase", "Port", 3306);

    // Configure Main Database
    bool existsUsername = !dbUsername.empty();
    bool existsPassword = !dbPassword.empty();
    bool existsHostname = !dbHostname.empty();
    bool existsName = !dbDatabase.empty();

    bool result = existsUsername && existsPassword && existsHostname && existsName;

    if (!result)
    {
        //Build informative error message
        //Built as one string and then printed rather than calling Log.outString(...) for every line,
        //  as experiments has seen other thread write to the console inbetween calls to Log.outString(...)
        //  resulting in unreadable error messages.
        //If the <LogonDatabase> tag is malformed, all parameters will fail, and a different error message is given

        std::string errorMessage = "sql: Certain <WorldDatabase> parameters not found in " CONFDIR "\\world.conf \r\n";
        if (!(existsHostname || existsUsername || existsPassword || existsName))
        {
            errorMessage += "  Double check that you have remembered the entire <WorldDatabase> tag.\r\n";
            errorMessage += "  All parameters missing. It is possible you forgot the first '<' character.\r\n";
        }
        else
        {
            errorMessage += "  Missing paramer(s):\r\n";
            if (!existsHostname) { errorMessage += "    Hostname\r\n"; }
            if (!existsUsername) { errorMessage += "    Username\r\n"; }
            if (!existsPassword) { errorMessage += "    Password\r\n"; }
            if (!existsName) { errorMessage += "    Name\r\n"; }
        }

        LOG_ERROR(errorMessage.c_str());
        return false;
    }

    sWorldSQL = Database::CreateDatabaseInterface();

    // Initialize it
    if (!sWorldSQL->Initialize(dbHostname.c_str(), (unsigned int)dbPort, dbUsername.c_str(),
        dbPassword.c_str(), dbDatabase.c_str(), connections,
        16384))
    {
        LogError("Configs : Connection to WorldDatabase failed. Check your database configurations!");
        return false;
    }

    return true;
}

Mutex m_allowedIpLock;
std::vector<AllowedIP> m_allowedIps;
std::vector<AllowedIP> m_allowedModIps;

bool Master::LoadRealmConfiguration()
{
    char* config_file = (char*)CONFDIR "/world.conf";

    LogNotice("Config : Loading Config Files...");
    if (Conf.MainConfig.openAndLoadConfigFile(config_file))
    {
        LogDetail("Config : " CONFDIR "/world.conf loaded");
    }
    else
    {
        LogError("Config : error occurred loading " CONFDIR "/world.conf");
        AscLog.~AscEmuLog();
        return false;
    }

    // re-set the allowed server IP's
    std::string allowedIps = Conf.MainConfig.getStringDefault("LogonServer", "AllowedIPs", "");
    std::vector<std::string> vips = Util::SplitStringBySeperator(allowedIps, " ");

    std::string allowedModIps = Conf.MainConfig.getStringDefault("LogonServer", "AllowedModIPs", "");
    std::vector<std::string> vipsmod = Util::SplitStringBySeperator(allowedModIps, " ");

    m_allowedIpLock.Acquire();
    m_allowedIps.clear();
    m_allowedModIps.clear();

    std::vector<std::string>::iterator itr;

    for (itr = vips.begin(); itr != vips.end(); ++itr)
    {
        std::string::size_type i = itr->find("/");
        if (i == std::string::npos)
        {
            LOG_ERROR("Ips: %s could not be parsed. Ignoring", itr->c_str());
            continue;
        }

        std::string stmp = itr->substr(0, i);
        std::string smask = itr->substr(i + 1);

        unsigned int ipraw = MakeIP(stmp.c_str());
        unsigned char ipmask = (char)atoi(smask.c_str());
        if (ipraw == 0 || ipmask == 0)
        {
            LOG_ERROR("Ips: %s could not be parsed. Ignoring", itr->c_str());
            continue;
        }

        AllowedIP tmp;
        tmp.Bytes = ipmask;
        tmp.IP = ipraw;
        m_allowedIps.push_back(tmp);
    }

    for (itr = vipsmod.begin(); itr != vipsmod.end(); ++itr)
    {
        std::string::size_type i = itr->find("/");
        if (i == std::string::npos)
        {
            LOG_ERROR("ModIps: %s could not be parsed. Ignoring", itr->c_str());
            continue;
        }

        std::string stmp = itr->substr(0, i);
        std::string smask = itr->substr(i + 1);

        unsigned int ipraw = MakeIP(stmp.c_str());
        unsigned char ipmask = (char)atoi(smask.c_str());
        if (ipraw == 0 || ipmask == 0)
        {
            LOG_ERROR("ModIps: %s could not be parsed. Ignoring", itr->c_str());
            continue;
        }

        AllowedIP tmp;
        tmp.Bytes = ipmask;
        tmp.IP = ipraw;
        m_allowedModIps.push_back(tmp);
    }


    m_allowedIpLock.Release();

    return true;
}


void TaskList::AddTask(Task* task)
{
    queueLock.Acquire();
    tasks.insert(task);
    queueLock.Release();
}

Task* TaskList::GetTask()
{
    queueLock.Acquire();

    Task* t = 0;

    for (std::set<Task*>::iterator itr = tasks.begin(); itr != tasks.end(); ++itr)
    {
        if (!(*itr)->in_progress)
        {
            t = (*itr);
            t->in_progress = true;
            break;
        }
    }

    queueLock.Release();

    return t;
}

void TaskList::spawn()
{
    running = true;
    thread_count.SetVal(0);

    uint32 threadcount;
    if (Conf.MainConfig.getBoolDefault("Startup", "EnableMultithreadedLoading", true))
    {
        // get processor count
#ifndef WIN32
#if UNIX_FLAVOUR == UNIX_FLAVOUR_LINUX
#if defined(__x86_64__) || defined(__x86_64) || defined(__amd64__)
        threadcount = 2;
#else
        long affmask;
        sched_getaffinity(0, 4, (cpu_set_t*)&affmask);
        threadcount = (BitCount8(affmask)) * 2;
        if (threadcount > 8) threadcount = 8;
        else if (threadcount <= 0) threadcount = 1;
#endif
#else
        threadcount = 2;
#endif
#else
        SYSTEM_INFO s;
        GetSystemInfo(&s);
        threadcount = s.dwNumberOfProcessors * 2;
        if (threadcount > 8)
            threadcount = 8;
#endif
    }
    else
        threadcount = 1;

    LogNotice("World : Beginning %s server startup with %u threads.", (threadcount == 1) ? "progressive" : "parallel", threadcount);

    for (uint32 x = 0; x < threadcount; ++x)
        ThreadPool.ExecuteTask(new TaskExecutor(this));
}

void TaskList::wait()
{
    bool has_tasks = true;
    while (has_tasks)
    {
        queueLock.Acquire();
        has_tasks = false;
        for (std::set<Task*>::iterator itr = tasks.begin(); itr != tasks.end(); ++itr)
        {
            if (!(*itr)->completed)
            {
                has_tasks = true;
                break;
            }
        }
        queueLock.Release();
        Arcemu::Sleep(20);
    }
}

void TaskList::kill()
{
    running = false;
}

void Task::execute()
{
    _cb->execute();
}

bool TaskExecutor::run()
{
    Task* t;

    THREAD_TRY_EXECUTION

        while (starter->running)
        {
            t = starter->GetTask();
            if (t)
            {
                t->execute();
                t->completed = true;
                starter->RemoveTask(t);
                delete t;
            }
            else
                Arcemu::Sleep(20);
        }

    THREAD_HANDLE_CRASH

        return true;
}

void TaskList::waitForThreadsToExit()
{
    while (thread_count.GetVal())
    {
        Arcemu::Sleep(20);
    }
}