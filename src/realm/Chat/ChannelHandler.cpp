/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/


#include "RealmStdAfx.h"
#include "ChannelMgr.h"

initialiseSingleton( ChannelMgr );

void Session::HandleChannelJoin(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
	std::string channelname,pass;
	uint32 dbc_id = 0;
	uint16 unk;		// some sort of channel type?
	Channel * chn;

	recvPacket >> dbc_id >> unk;
	recvPacket >> channelname;
	recvPacket >> pass;

	if(sRealmMaster.GmClientChannel.size() && !stricmp(sRealmMaster.GmClientChannel.c_str(), channelname.c_str()) && !m_GMPermissions.size())
		return;	

	chn = channelmgr.GetCreateChannel(channelname.c_str(), m_currentPlayer, dbc_id);
	if(chn == NULL)
		return;

	chn->AttemptJoin(m_currentPlayer, pass.c_str());
	LogDebug("Channeljoin : %s, unk %u", channelname.c_str(), unk);
}

void Session::HandleChannelLeave(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
	std::string channelname;
	uint32 code = 0;
	Channel * chn;

	recvPacket >> code;
	recvPacket >> channelname;

	chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
	if( chn != NULL )
		chn->Part(m_currentPlayer, false);
}

void Session::HandleChannelList(WorldPacket& recvPacket)
{
    CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname;
    Channel* chn;

    recvPacket >> channelname;

    chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
    if (chn != NULL)
        chn->List(m_currentPlayer);
}

void Session::HandleChannelPassword(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname, pass;
    Channel* chn;

    recvPacket >> channelname;
    recvPacket >> pass;
    chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
    if (chn)
        chn->Password(m_currentPlayer, pass.c_str());
}

void Session::HandleChannelSetOwner(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname,newp;
	Channel* chn;
	RPlayerInfo* plr;

	recvPacket >> channelname;
	recvPacket >> newp;

	chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
	plr = sClientMgr.GetRPlayer(newp);
	if( chn != NULL && plr != NULL )
		chn->SetOwner(m_currentPlayer, plr);
}

void Session::HandleChannelOwner(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname,pass;
	Channel* chn;

	recvPacket >> channelname;
	chn = channelmgr.GetChannel(channelname.c_str(),m_currentPlayer);
	if (chn)
		chn->GetOwner(m_currentPlayer);
}

void Session::HandleChannelModerator(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname,newp;
	Channel* chn;
	RPlayerInfo* plr;

	recvPacket >> channelname;
	recvPacket >> newp;

	chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
	plr = sClientMgr.GetRPlayer(newp);
	if (chn && plr)
		chn->GiveModerator(m_currentPlayer, plr);
}

void Session::HandleChannelUnmoderator(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname,newp;
	Channel* chn;
	RPlayerInfo* plr;

	recvPacket >> channelname;
	recvPacket >> newp;

	chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
	plr = sClientMgr.GetRPlayer(newp);
	if (chn && plr)
		chn->TakeModerator(m_currentPlayer, plr);
}

void Session::HandleChannelMute(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname,newp;
	Channel* chn;
	RPlayerInfo* plr;

	recvPacket >> channelname;
	recvPacket >> newp;

	chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
	plr = sClientMgr.GetRPlayer(newp);
	if (chn && plr)
		chn->Mute(m_currentPlayer, plr);
}

void Session::HandleChannelUnmute(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname,newp;
	Channel* chn;
	RPlayerInfo* plr;

	recvPacket >> channelname;
	recvPacket >> newp;

	chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
	plr = sClientMgr.GetRPlayer(newp);
	if (chn && plr)
		chn->Unmute(m_currentPlayer, plr);
}

void Session::HandleChannelInvite(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname,newp;
	Channel* chn;
	RPlayerInfo* plr;

	recvPacket >> channelname;
	recvPacket >> newp;

	chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
	plr = sClientMgr.GetRPlayer(newp);
	if (chn && plr)
		chn->Invite(m_currentPlayer, plr);
}
void Session::HandleChannelKick(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname,newp;
	Channel* chn;
	RPlayerInfo* plr;

	recvPacket >> channelname;
	recvPacket >> newp;

	chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
	plr = sClientMgr.GetRPlayer(newp);
	if (chn && plr)
		chn->Kick(m_currentPlayer, plr, false);
}

void Session::HandleChannelBan(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname,newp;
	Channel* chn;
	RPlayerInfo* plr;

	recvPacket >> channelname;
	recvPacket >> newp;

	chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
	plr = sClientMgr.GetRPlayer(newp);
	if (chn && plr)
		chn->Kick(m_currentPlayer, plr, true);
}

void Session::HandleChannelUnban(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname,newp;
	Channel* chn;
	RPlayerInfo * plr;

	recvPacket >> channelname;
	recvPacket >> newp;

	chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
	plr = sClientMgr.GetRPlayer(newp);
	if (chn && plr)
		chn->Unban(m_currentPlayer, plr);
}

void Session::HandleChannelAnnounce(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname;
	Channel* chn;
	recvPacket >> channelname;

	chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
	if (chn)
		chn->Announce(m_currentPlayer);
}

void Session::HandleChannelModerate(WorldPacket& recvPacket)
{
	CHECK_PACKET_SIZE(recvPacket, 1);
    std::string channelname;
	Channel* chn;
	recvPacket >> channelname;

	chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
	if (chn)
		chn->Moderate(m_currentPlayer);
}

void Session::HandleChannelRosterQuery(WorldPacket & recvPacket)
{
    std::string channelname;
	Channel* chn;
	recvPacket >> channelname;

	chn = channelmgr.GetChannel(channelname.c_str(), m_currentPlayer);
	if (chn)
		chn->List(m_currentPlayer);
}

void Session::HandleChannelNumMembersQuery(WorldPacket & recvPacket)
{
    std::string channel_name;
	WorldPacket data(SMSG_CHANNEL_MEMBER_COUNT, recvPacket.size() + 4);
	Channel* chn;
	recvPacket >> channel_name;
	chn = channelmgr.GetChannel(channel_name.c_str(), m_currentPlayer);
	if (chn)
	{
		data << channel_name;
		data << uint8(chn->m_flags);
		data << uint32(chn->GetNumMembers());
		SendPacket(&data);
	}
}

