/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#ifndef __CHANNELMGR_H
#define __CHANNELMGR_H

class Channel;

class SERVER_DECL ChannelMgr :  public Singleton <ChannelMgr>
{
public:
	ChannelMgr();
	~ChannelMgr();
	
	Channel* GetCreateChannel(const char *name, RPlayerInfo* p, uint32 type_id);
	Channel* GetChannel(const char *name, RPlayerInfo* p);
	Channel* GetChannel(const char * name, uint32 team);
	Channel* GetChannel(uint32 id);
    void RemoveChannel(Channel * chn);
    bool seperatechannels;

    void OnZoneUpdate(std::string updatename, RPlayerInfo* plr);

private:
    typedef std::map<std::string, Channel*> ChannelList;
    typedef std::map<uint32, Channel*> ChannelMap;
    ChannelMap m_idToChannel;
    uint32 m_idHigh;
    ChannelList Channels[2];

    Mutex lock;
};

#define channelmgr ChannelMgr::getSingleton()

#endif