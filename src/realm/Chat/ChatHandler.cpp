/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "RealmStdAfx.h"

static const uint32 LanguageSkills[NUM_LANGUAGES] = {
	0,				// UNIVERSAL		0x00
	109,			// ORCISH			0x01
	113,			// DARNASSIAN		0x02
	115,			// TAURAHE			0x03
	0,				// -				0x04
	0,				// -				0x05
	111,			// DWARVISH			0x06
	98,				// COMMON			0x07
	139,			// DEMON TONGUE		0x08
	140,			// TITAN			0x09
	137,			// THALSSIAN		0x0A
	138,			// DRACONIC			0x0B
	0,				// KALIMAG			0x0C
	313,			// GNOMISH			0x0D
	315,			// TROLL			0x0E
	0,				// -				0x0F
	0,				// -				0x10
	0,				// -				0x11
	0,				// -				0x12
	0,				// -				0x13
	0,				// -				0x14
	0,				// -				0x15
	0,				// -				0x16
	0,				// -				0x17
	0,				// -				0x18
	0,				// -				0x19
	0,				// -				0x1A
	0,				// -				0x1B
	0,				// -				0x1C
	0,				// -				0x1D
	0,				// -				0x1E
	0,				// -				0x1F
	0,				// -				0x20
	673,			// -				0x21
	0,				// -				0x22
	759,			// -				0x23
};

void Session::HandleMessagechatOpcode( WorldPacket & recv_data )
{
	CHECK_PACKET_SIZE(recv_data, 9);
    WorldPacket* data = nullptr;

	uint32 type;
	int32 lang;

    const char* pMisc = NULL;
    const char* pMsg = NULL;

	recv_data >> type;
	// were only going to handle these types here, otherwise send it to the world server for processing
	if( type != CHAT_MSG_CHANNEL && type != CHAT_MSG_WHISPER )
	{
		GetServer()->SendWoWPacket(this, &recv_data);
	}
	recv_data >> lang;

	if( lang >= NUM_LANGUAGES )
		return;

	/*
	if(GetPlayer()->IsBanned())
		{
			SystemMessage("You cannot do that when banned.");
			return;
	}*/

    std::string msg, to = "", channel = "", tmp;
    msg.reserve(256);

    // Process packet
    switch (type)
    {
    case CHAT_MSG_SAY:
    case CHAT_MSG_EMOTE:
    case CHAT_MSG_PARTY:
    case CHAT_MSG_PARTY_LEADER:
    case CHAT_MSG_RAID:
    case CHAT_MSG_RAID_LEADER:
    case CHAT_MSG_RAID_WARNING:
    case CHAT_MSG_GUILD:
    case CHAT_MSG_OFFICER:
    case CHAT_MSG_YELL:
        recv_data >> msg;
        pMsg = msg.c_str();
        //g_chatFilter->ParseEscapeCodes((char*)pMsg,true);
        pMisc = 0;
        break;
    case CHAT_MSG_WHISPER:
        recv_data >> to >> msg;
        pMsg = msg.c_str();
        pMisc = to.c_str();
        break;
    case CHAT_MSG_CHANNEL:
        recv_data >> channel;
        recv_data >> msg;
        pMsg = msg.c_str();
        pMisc = channel.c_str();
        break;
    case CHAT_MSG_AFK:
    case CHAT_MSG_DND:
        break;
    case CHAT_MSG_BATTLEGROUND:
    case CHAT_MSG_BATTLEGROUND_LEADER:
        recv_data >> msg;
        pMsg = msg.c_str();
        break;
    default:
        LOG_ERROR("CHAT: unknown msg type %u, lang: %u", type, lang);
    }

    Channel* chn = NULL;
    // Main chat message processing
	switch(type)
	{
	case CHAT_MSG_WHISPER:
		{

        if (lang != -1)
            lang = LANG_UNIVERSAL; //All whispers are universal

			RPlayerInfo* player = sClientMgr.GetRPlayer(to.c_str());
			if(!player)
			{
					data = new WorldPacket(SMSG_CHAT_PLAYER_NOT_FOUND, to.length() + 1);
					*data << to;
					SendPacket(data);
					delete data;
                    break;
			}

			// Check that the player isn't a gm
            if (!GetPlayer()->GMPermissions.size() && player->IsGmOn)
			{
				// Build automated reply
                std::string Reply = "This Game Master does not currently have an open ticket from you and did not receive your whisper. Please submit a new GM Ticket request if you need to speak to a GM. This is an automatic message.";
				data = sChatHandler.FillMessageData( CHAT_MSG_WHISPER, LANG_UNIVERSAL, Reply.c_str(), uint64(player->Guid), 3);
				SendPacket(data);
				delete data;
				break;
			}

			    data = sChatHandler.FillMessageData( CHAT_MSG_WHISPER, lang,  msg.c_str(), uint64(GetPlayer()->Guid), player->IsGmOn ? 4 : 0 );
			    player->GetSession()->SendPacket(data);
				delete data;

                //Sent the to Users id as the channel, this should be fine as it's not used for whisper
                if (lang != -1) //DO NOT SEND if its an addon message!
                {
                    data = sChatHandler.FillMessageData(CHAT_MSG_WHISPER_INFORM, LANG_UNIVERSAL, msg.c_str(), uint64(player->Guid), player->IsGmOn ? 4 : 0);
                    SendPacket(data);
                    delete data;
                }
                
                if (player->IsAFK)
                {
                    // Has AFK flag, autorespond.
                    data = sChatHandler.FillMessageData(CHAT_MSG_AFK, LANG_UNIVERSAL, player->AFKreason.c_str(), uint64(player->Guid), player->IsGmOn ? 4 : 0);
                    SendPacket(data);
                    delete data;
                }
                else if (player->IsDND)
                {
                    // Has DND flag, autorespond.
                    data = sChatHandler.FillMessageData(CHAT_MSG_DND, LANG_UNIVERSAL, player->DNDreason.c_str(), uint64(player->Guid), player->IsGmOn ? 4 : 0);
                    SendPacket(data);
                    delete data;
                }
		}
        break;
	case CHAT_MSG_CHANNEL:
		{
			chn = channelmgr.GetChannel(channel.c_str(), GetPlayer());
            if (chn)
            {
                chn->Say(GetPlayer(), msg.c_str(), NULL, false);
            }
		}
        break;

	default:
		LogDebug("CHAT: unknown msg type %u, lang: %u", type, lang);
	}
}
