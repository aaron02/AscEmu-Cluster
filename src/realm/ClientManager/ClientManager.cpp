/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "RealmStdAfx.h"

initialiseSingleton(ClientMgr);

ClientMgr::ClientMgr()
{
    Session::InitHandlers();
    m_maxSessionId = 0;
    LogNotice("ClientMgr : Interface Created");
}

ClientMgr::~ClientMgr()
{
    for (SessionMap::iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
        delete itr->second;

    for (ClientMap::iterator itr = m_clients.begin(); itr != m_clients.end(); ++itr)
        delete itr->second;
};

void ClientMgr::SendPackedClientInfo(WorkerServer * server)
{
    if (!m_clients.size())
        return;

    ByteBuffer uncompressed(4000 * 19 + 8);
    uncompressed << uint32(m_clients.size());

    /* pack them all together */
    ClientMap::iterator itr = m_clients.begin();
    RPlayerInfo* pi;
    for (; itr != m_clients.end(); ++itr)
    {
        pi = itr->second;
        pi->Pack(uncompressed);
    }

    size_t destsize = uncompressed.size() + uncompressed.size() / 10 + 16;

    WorldPacket data(ISMSG_PACKED_PLAYER_INFO, destsize + 4);
    data.resize(destsize + 4);

    z_stream stream;
    stream.zalloc = 0;
    stream.zfree = 0;
    stream.opaque = 0;

    if (deflateInit(&stream, 1) != Z_OK)
    {
        printf("deflateInit failed.");
        return;
    }

    // set up stream pointers
    stream.next_out = (Bytef*)((uint8*)data.contents()) + 4;
    stream.avail_out = (uInt)destsize;
    stream.next_in = (Bytef*)uncompressed.contents();
    stream.avail_in = (uInt)uncompressed.size();

    // call the actual process
    if (deflate(&stream, Z_NO_FLUSH) != Z_OK ||
        stream.avail_in != 0)
    {
        printf("deflate failed.");
        return;
    }

    // finish the deflate
    if (deflate(&stream, Z_FINISH) != Z_STREAM_END)
    {
        printf("deflate failed: did not end stream");
        return;
    }

    // finish up
    if (deflateEnd(&stream) != Z_OK)
    {
        printf("deflateEnd failed.");
        return;
    }

    // put real size at the beginning of the packet
    *(uint32*)data.contents() = (uint32)uncompressed.size();
    data.resize(stream.total_out + 4);

    server->SendPacket(&data);
}

Session * ClientMgr::CreateSession(uint32 AccountId)
{
    m_lock.AcquireWriteLock();

    //lets generate a session id
    //get from reusable
    uint32 sessionid = 0;
    if (m_reusablesessions.size() > 0)
    {
        sessionid = m_reusablesessions[m_reusablesessions.size() - 1];
        m_reusablesessions.pop_back();
    }
    else
    {
        sessionid = ++m_maxSessionId;
        LogDebug("Session : New max session id: %u", sessionid);
    }

    //ok, if we have a session with this account, add it to delete queue
    for (SessionMap::iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
        if (itr->second->GetAccountId() == AccountId)
            m_pendingdeletesessionids.push_back(itr->first);

    //we couldn't generate an id for some reason
    if (sessionid == 0)
        return NULL;

    LogDebug("ClientMgr : Allocating session %u for account id %u", sessionid, AccountId);
    Session* s = new Session(sessionid);

    m_sessions.insert(SessionMap::value_type(sessionid, s));

    m_lock.ReleaseWriteLock();
    return s;
}

void ClientMgr::Update()
{
    //get teh write lock for this so we don't fuck up other things
    m_lock.AcquireWriteLock();
    for (std::vector<uint32>::iterator itr = m_pendingdeletesessionids.begin(); itr != m_pendingdeletesessionids.end(); ++itr)
    {
        SessionMap::iterator itr2 = m_sessions.find(*itr);
        if (itr2 == m_sessions.end()) //uh oh
            continue;
        Session* s = itr2->second;

        //use a reference int incase a player times out and logs in again :), were under a write lock here, were synced
        if (s->GetPlayer() != NULL && --s->GetPlayer()->references == 0)
        {
            m_sessionsbyinfo.erase(s->GetPlayer());
            m_clients.erase(s->GetPlayer()->Guid);
            m_stringclients.erase(s->GetPlayer()->Name);
            delete s->GetPlayer();
        }

        m_reusablesessions.push_back(*itr);
        m_sessions.erase(itr2);
        delete s;
    }
    m_lock.ReleaseWriteLock();

    for (SessionMap::iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
        if (!itr->second->deleted)
            itr->second->Update();
}

void ClientMgr::DestroySession(uint32 sessionid)
{
    m_lock.AcquireWriteLock();
    //session doesn't exist
    Session* s = GetSession(sessionid);
    if (s == NULL)
        return;

    s->deleted = true;
    m_pendingdeletesessionids.push_back(sessionid);
    m_lock.ReleaseWriteLock();
}

RPlayerInfo * ClientMgr::CreateRPlayer(uint32 guid)
{
    m_lock.AcquireWriteLock();
    ClientMap::iterator itr = m_clients.find(guid);
    if (itr == m_clients.end())
    {
        RPlayerInfo * rp = new RPlayerInfo;
        rp->references = 1;
        rp->Guid = guid;
        m_clients.insert(ClientMap::value_type(guid, rp));
        m_lock.ReleaseWriteLock();
        return rp;
    }
    else
    {
        ++itr->second->references;
        m_lock.ReleaseWriteLock();
        return itr->second;
    }
}

void ClientMgr::DestroyRPlayerInfo(uint32 guid)
{
    RPlayerInfo * rp;
    m_lock.AcquireWriteLock();
    ClientMap::iterator itr = m_clients.find(guid);
    //no need for sync here, were under a write lock
    if (itr != m_clients.end() && --itr->second->references == 0)
    {
        rp = itr->second;
        m_clients.erase(itr);
        m_stringclients.erase(rp->Name);
        delete rp;
    }
    m_lock.ReleaseWriteLock();
}

void RPlayerInfo::JoinedChannel(Channel* c)
{
    if (c != NULL)
        m_channels.insert(c);
}

void RPlayerInfo::LeftChannel(Channel* c)
{
    if (c != NULL)
        m_channels.erase(c);
}

void RPlayerInfo::CleanupChannels()
{
    std::set<Channel*>::iterator i;
    Channel* c;
    for (i = m_channels.begin(); i != m_channels.end();)
    {
        c = *i;
        ++i;

        c->Part(this, true);
    }
}

void RPlayerInfo::OnZoneUpdate(std::string updatename, std::string updatename2,uint32 mapId,uint32 ZoneId, uint32 flags)
{
    if (!m_channels.empty())
    {
        // change to zone name, not area name
        for (std::set<Channel*>::iterator itr = m_channels.begin(), nextitr; itr != m_channels.end(); itr = nextitr)
        {
            Channel* chn;
            nextitr = itr;
            ++nextitr;
            chn = (*itr);
            // Check if this is a custom channel (i.e. global)
            if (!((*itr)->m_flags & CHANNEL_FLAGS_CUSTOM))  // 0x10
                continue;

            if (chn->m_flags & CHANNEL_FLAGS_LFG)
                continue;

            char updatedName[95];

            auto chat_channels = sChatChannelsStore.LookupEntry(chn->m_id);
            if (!chat_channels)
            {
                LOG_ERROR("Invalid channel entry %u for %s", chn->m_id, chn->m_name.c_str());
                return;
            }

            //printf("%s \n", updatename.c_str());

            snprintf(updatedName, 95, chat_channels->name_pattern[0], updatename.c_str());

            Channel* newChannel = channelmgr.GetCreateChannel(updatedName, NULL, chn->m_id);
            if (newChannel == NULL)
            {
                LOG_ERROR("Could not create channel %s!", updatedName);
                return; // whoops?
            }

            if (chn != newChannel)   // perhaps there's no need
            {
                // join new channel
                newChannel->AttemptJoin(this, "");
                // leave the old channel
                chn->Part(this, false);
            }
        }
    }

    std::set<Channel*>::iterator i;
    Channel* c;
    std::string channelname, AreaName;

    if (mapId == 450)
        ZoneId = 2917;
    else if (mapId == 449)
        ZoneId = 2918;

    //Check for instances?
    if (!ZoneId || ZoneId == 0xFFFF)
    {
        MapInfo const* pMapinfo = sMySQLStore.GetWorldMapInfo(mapId);
        if (IS_INSTANCE(mapId))
            AreaName = pMapinfo->name;
        else
            return;//How'd we get here?
    }
    else
    {
        AreaName = updatename2;
        if (AreaName.length() < 2)
        {
            MapInfo const* pMapinfo = sMySQLStore.GetWorldMapInfo(mapId);
            AreaName = pMapinfo->name;
        }
    }

    for (i = m_channels.begin(); i != m_channels.end();)
    {
        c = *i;
        ++i;

        if (!c->m_general || c->m_name == "LookingForGroup")//Not an updatable channel.
            continue;

        if (strstr(c->m_name.c_str(), "General"))
            channelname = "General";
        else if (strstr(c->m_name.c_str(), "Trade"))
            channelname = "Trade";
        else if (strstr(c->m_name.c_str(), "LocalDefense"))
            channelname = "LocalDefense";
        else if (strstr(c->m_name.c_str(), "GuildRecruitment"))
            channelname = "GuildRecruitment";
        else
            continue;//Those 4 are the only ones we want updated.
        channelname += " - ";
        if ((strstr(c->m_name.c_str(), "Trade") || strstr(c->m_name.c_str(), "GuildRecruitment")) && (flags & 0x0200 || flags & 0x0020))
        {
            channelname += "City";
        }
        else
            channelname += AreaName;

        Channel* chn = channelmgr.GetCreateChannel(channelname.c_str(), this, c->m_id);
        if (chn != NULL && !chn->HasMember(this))
        {
            c->Part(this, false);
            chn->AttemptJoin(this, NULL);
        }
    }
}
