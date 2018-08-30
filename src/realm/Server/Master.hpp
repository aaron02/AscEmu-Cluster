/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "Storage/DBC/DBCStores.h"

class Task
{
    CallbackBase* _cb;

public:

    Task(CallbackBase* cb) : _cb(cb), completed(false), in_progress(false) {}
    ~Task() { delete _cb; }
    bool completed;
    bool in_progress;
    void execute();
};

class TaskList
{
    std::set<Task*> tasks;
    Mutex queueLock;

public:

    TaskList() : thread_count(0), running(false) {};
    Task* GetTask();
    void AddTask(Task* task);
    void RemoveTask(Task* task)
    {
        queueLock.Acquire();
        tasks.erase(task);
        queueLock.Release();
    }

    void spawn();
    void kill();

    void wait();
    void waitForThreadsToExit();
    Arcemu::Threading::AtomicCounter thread_count;
    bool running;
};

enum BasicTaskExecutorPriorities
{
    BTE_PRIORITY_LOW = 0,
    BTE_PRIORITY_MED = 1,
    BTW_PRIORITY_HIGH = 2
};

class TaskExecutor : public ThreadBase
{
    TaskList* starter;

public:

    TaskExecutor(TaskList* l) : starter(l) { ++l->thread_count; }
    ~TaskExecutor() { --starter->thread_count; }

    bool run();
};

class SERVER_DECL Master : public Singleton<Master>
{
public:
    Master();
    ~Master();
    bool Run(int argc, char ** argv);
    void Rehash(bool load);

    static volatile bool m_stopEvent;
    uint32 m_startTime;
    std::string GetUptimeString()
    {
        char str[300];
        time_t pTime = (time_t)UNIXTIME - m_startTime;
        tm * tmv = gmtime(&pTime);

        snprintf(str, 300, "%u days, %u hours, %u minutes, %u seconds.", tmv->tm_yday, tmv->tm_hour, tmv->tm_min, tmv->tm_sec);
        return std::string(str);
    }

    bool m_lfgForNonLfg;
    std::string GmClientChannel;
    bool LoadRealmConfiguration();
    void PrintBanner();

private:
    bool StartCharDb();
    bool StartWorldDb();

    void _HookSignals();
    void _UnhookSignals();

    static void _OnSignal(int s);
};

#define sRealmMaster Master::getSingleton()