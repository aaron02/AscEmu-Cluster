/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "RealmStdAfx.h"
#include "../shared/AuthCodes.h"

void Session::HandleCharacterEnum(WorldPacket & pck)
{
    struct player_item
    {
        uint32 displayid;
        uint8 invtype;
        uint32 enchantment; // added in 2.4
    };

    uint32 start_time = getMSTime();

    player_item items[23];
    int8 slot;

    QueryResult* res;
    CreatureProperties const* info = nullptr;
    uint8 race;
    has_dk = false;
    _side = -1; // side should be set on every enumeration for safety

    QueryResult* result = sCharSQL->Query("SELECT guid, level, race, class, gender, bytes, bytes2, name, positionX, positionY, positionZ, mapId, zoneId, banned, restState, deathstate, login_flags, player_flags, guild_data.guildid FROM characters LEFT JOIN guild_data ON characters.guid = guild_data.playerid WHERE acct=%u ORDER BY guid LIMIT 10", GetAccountId());

    uint32 numchar;

    if (result)
        numchar = result->GetRowCount();
    else
        numchar = 0;

    // should be more than enough.. 200 bytes per char..
    WorldPacket data(SMSG_CHAR_ENUM, 1 + numchar * 200);

    // parse m_characters and build a mighty packet of
    // characters to send to the client.
    data << uint8(numchar);

    if (result)
    {
        uint64 guid;
        uint8 Class;
        uint32 bytes2;
        uint32 flags;
        uint32 banned;
        Field* fields;
        uint32 petLevel = 0;
        do
        {
            fields = result->Fetch();

            guid = fields[0].GetUInt64();
            bytes2 = fields[6].GetUInt32();
            Class = fields[3].GetUInt8();
            flags = fields[17].GetUInt32();
            race = fields[2].GetUInt8();

            if (_side < 0)
            {
                // work out the side
                static uint8 sides[RACE_DRAENEI + 1] = { 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 1, 0 };
                _side = sides[race];
            }

            // Death Knight starting information
            // Note: To change what level is required to make a dk change the >= 55 to something.
            // For example >=80 would require a level 80 to create a DK
            has_level_55_char = has_level_55_char || (fields[1].GetUInt8() >= 55);
            has_dk = has_dk || (Class == 6);

            /* build character enum, w0000t :p */
            data << uint64(guid);                           //guid
            data << fields[7].GetString();                  //name
            data << uint8(race);                            //race
            data << uint8(Class);                           //class
            data << uint8(fields[4].GetUInt8());            //gender
            data << uint32(fields[5].GetUInt32());          //PLAYER_BYTES
            data << uint8(bytes2 & 0xFF);                   //facial hair
            data << uint8(fields[1].GetUInt8());            //Level
            data << uint32(fields[12].GetUInt32());         //zoneid
            data << uint32(fields[11].GetUInt32());         //Mapid
            data << float(fields[8].GetFloat());            //X
            data << float(fields[9].GetFloat());            //Y
            data << float(fields[10].GetFloat());           //Z
            data << uint32(fields[18].GetUInt32());         //GuildID

            banned = fields[13].GetUInt32();
            uint32 char_flags = 0;

            if (banned && (banned < 10 || banned >(uint32)UNIXTIME))
                char_flags |= PLAYER_FLAG_IS_BANNED;
            if (fields[15].GetUInt32() != 0)
                char_flags |= PLAYER_FLAG_IS_DEAD;
            if (flags & PLAYER_FLAG_NOHELM)
                char_flags |= PLAYER_FLAG_NOHELM;
            if (flags & PLAYER_FLAG_NOCLOAK)
                char_flags |= PLAYER_FLAG_NOCLOAK;
            if (fields[16].GetUInt32() == 1)
                char_flags |= PLAYER_FLAGS_RENAME_FIRST;

            data << uint32(char_flags);

            switch (fields[16].GetUInt32())
            {
            case LOGIN_CUSTOMIZE_LOOKS:
                data << uint32(CHAR_CUSTOMIZE_FLAG_CUSTOMIZE);  //Character recustomization flag
                break;
            case LOGIN_CUSTOMIZE_RACE:
                data << uint32(CHAR_CUSTOMIZE_FLAG_RACE);       //Character recustomization + race flag
                break;
            case LOGIN_CUSTOMIZE_FACTION:
                data << uint32(CHAR_CUSTOMIZE_FLAG_FACTION); //Character recustomization + race + faction flag
                break;
            default:
                data << uint32(CHAR_CUSTOMIZE_FLAG_NONE);       //Character recustomization no flag set
            }

            data << uint8(0);                //Unknown 3.2.0

            if (Class == WARLOCK || Class == HUNTER)
            {
                res = sCharSQL->Query("SELECT entry, level FROM playerpets WHERE ownerguid = %u AND MOD(active, 10) = 1 AND alive = TRUE;", GUID_LOPART(guid));

                if (res)
                {
                    petLevel = res->Fetch()[1].GetUInt32();
                    info = sMySQLStore.GetCreatureProperties(res->Fetch()[0].GetUInt32());
                    delete res;
                }
                else
                    info = nullptr;
            }
            else
                info = nullptr;

            if (info != nullptr)
            {
                data << uint32(info->Male_DisplayID);
                data << uint32(petLevel);
                data << uint32(info->Family);
            }
            else
            {
                data << uint32(0);
                data << uint32(0);
                data << uint32(0);
            }

            res = sCharSQL->Query("SELECT slot, entry, enchantments FROM playeritems WHERE ownerguid=%u AND containerslot = '-1' AND slot BETWEEN '0' AND '22'", GUID_LOPART(guid));

            memset(items, 0, sizeof(player_item) * 23);
            uint32 enchantid;

            if (res)
            {
                do
                {
                    slot = res->Fetch()[0].GetInt8();
                    ItemProperties const* proto = sMySQLStore.GetItemProperties(res->Fetch()[1].GetUInt32());
                    if (proto)
                    {
                        items[slot].displayid = proto->DisplayInfoID;
                        items[slot].invtype = static_cast<uint8>(proto->InventoryType);

                        // weapon glows
                        if (slot == EQUIPMENT_SLOT_MAINHAND || slot == EQUIPMENT_SLOT_OFFHAND)
                        {
                            // get enchant visual ID
                            const char* enchant_field = res->Fetch()[2].GetString();
                            if (sscanf(enchant_field, "%u,0,0;", (unsigned int*)&enchantid) == 1 && enchantid > 0)
                            {
                                //auto spell_item_enchant = sSpellItemEnchantmentStore.LookupEntry(enchantid);
                                //if (spell_item_enchant != nullptr)
                                //    items[slot].enchantment = spell_item_enchant->visual;
                            }
                        }
                    }
                } while (res->NextRow());
                delete res;
            }

            for (uint8 i = 0; i < 23; ++i) // INVENTORY SLOT BAG END
            {
                data << uint32(items[i].displayid);
                data << uint8(items[i].invtype);
                data << uint32(items[i].enchantment);
            }
        } while (result->NextRow());
    }

    LogDebug("Character Enum : Built in %u ms.", getMSTime() - start_time);
    SendPacket(&data);
}


void Session::HandlePlayerLogin(WorldPacket & pck)
{
    WorldPacket data(SMSG_CHARACTER_LOGIN_FAILED, 30);
    LocationVector LoginCoord;
    WorkerServer * dest;
    ASSERT(!m_currentPlayer);
    uint64 guid;
    pck >> guid;

    if (sClientMgr.GetRPlayer((uint32)guid) != NULL)
    {
        data << uint8(E_CHAR_LOGIN_DUPLICATE_CHARACTER);
        SendPacket(&data);
        return;
    }

    m_currentPlayer = sClientMgr.CreateRPlayer((uint32)guid);
    RPlayerInfo * plr = m_currentPlayer;

    uint32 AccountId;
    std::string Name;
    uint8 Level;
    uint8 GuildId;
    float PositionX;
    float PositionY;
    uint32 ZoneId;
    uint32 MapId;
    uint32 Race;
    uint32 Class;
    uint32 Gender;
    uint32 Latency;
    std::string GMPermissions;
    uint8 Account_Flags;
    uint32 InstanceId;
    uint32 RecoveryMapId;
    float recv_x;
    float recv_y;
    float recv_z;
    float recv_o;

    sClientMgr.AddSessionRPInfo(this, plr);

    /* Load player data */
    QueryResult * result = sCharSQL->Query("SELECT acct, name, level, guild_data.guildid, positionX, positionY, zoneId, mapId, race, class, gender, instance_id, entrypointmap, entrypointx, entrypointy, entrypointz, entrypointo FROM characters LEFT JOIN guild_data ON characters.guid = guild_data.playerid WHERE guid = %u", guid);
    if (result)
    {
        Field * f = result->Fetch();
        AccountId = f[0].GetUInt32();
        Name = f[1].GetString();
        Level = f[2].GetUInt32();
        GuildId = f[3].GetUInt32();
        PositionX = f[4].GetFloat();
        PositionY = f[5].GetFloat();
        ZoneId = f[6].GetUInt32();
        MapId = f[7].GetUInt32();
        Race = f[8].GetUInt8();
        Class = f[9].GetUInt8();
        Gender = f[10].GetUInt8();
        Latency = m_latency;
        GMPermissions = m_GMPermissions;
        Account_Flags = m_accountFlags;
        InstanceId = f[11].GetUInt32();
        RecoveryMapId = f[12].GetUInt32();
        recv_x = f[13].GetFloat();
        recv_y = f[14].GetFloat();
        recv_z = f[15].GetFloat();
        recv_o = f[16].GetFloat();

        //Add Players Infos
        plr->AccountId = AccountId;
        plr->Name = Name;
        plr->Level = Level;
        plr->GuildId = GuildId;
        plr->PositionX = PositionX;
        plr->PositionY = PositionY;
        plr->ZoneId = ZoneId;
        plr->MapId = MapId;
        plr->Race = Race;
        plr->Class = Class;
        plr->Gender = Gender;
        plr->Latency = Latency;
        plr->GMPermissions = GMPermissions;
        plr->Account_Flags = Account_Flags;
        plr->InstanceId = InstanceId;
        plr->RecoveryMapId = RecoveryMapId;
        plr->RecoveryPosition.ChangeCoords(recv_x, recv_y, recv_z, recv_o);
        plr->session = this;

        uint8 Team = 0;

        //work out the side
        static uint8 teams[12] = { 0,0,1,0,0,1,1,0,1,0,1,0 };
        Team = teams[plr->Race];

        plr->Team = Team;

        delete result;
    }
    else
    {
        data << uint8(0x42);
        SendPacket(&data);
        sClientMgr.DestroyRPlayerInfo((uint32)guid);
        m_currentPlayer = NULL;
        return;
    }

    dest = NULL;

    if (IS_MAIN_MAP(m_currentPlayer->MapId))
    {
        /* try to find the world server we're going to */
        dest = sClusterMgr.GetServerByMapId(m_currentPlayer->MapId);
    }
    else if (IS_INSTANCE(m_currentPlayer->MapId))
    {
        /* try to find the world server we're going to */
        // We could handle wokrers by instances too maybe do it?
        dest = sClusterMgr.GetServerByMapId(m_currentPlayer->MapId);
    }

    if (dest == NULL)
    {
        /* world server is down */
        if(IS_MAIN_MAP(m_currentPlayer->MapId))
            data << uint8(E_CHAR_LOGIN_NO_WORLD);
        else
            data << uint8(E_CHAR_LOGIN_NO_INSTANCES);

        SendPacket(&data);

        // Destroy the Player
        sClientMgr.DestroyRPlayerInfo((uint32)guid);
        m_currentPlayer = NULL;
        return;
    }

    /* log the player into that WorkerServer */
    data.SetOpcode(ISMSG_PLAYER_LOGIN);

    sClientMgr.AddStringPlayerInfo(plr);

    /* append info */
    data << uint32(guid) << uint32(m_currentPlayer->MapId) << uint32(InstanceId);


    /* append the account information */
    data << uint32(AccountId) << uint32(Account_Flags) << uint32(m_sessionId)
        << GMPermissions << m_accountName << m_build << Class << m_socket;

    dest->SendPacket(&data);
    m_nextServer = dest;
}

void Session::HandleCharacterDelete(WorldPacket & recv_data)
{
    uint8 fail = E_CHAR_DELETE_SUCCESS;

    uint64 guid;
    recv_data >> guid;

    if (sClientMgr.GetRPlayer((uint32)guid) != NULL)
    {
        // "Char deletion failed"
        fail = E_CHAR_DELETE_FAILED;
    }
    else
    {
        fail = DeleteCharacter((uint32)guid);
    }

    WorldPacket data(SMSG_CHAR_DELETE, 1);
    data << fail;
    SendPacket(&data);
}

uint8 Session::DeleteCharacter(uint32 guid)
{
    RPlayerInfo* plr = sClientMgr.CreateRPlayer((uint32)guid);
    
    if (plr != NULL)
    {
        QueryResult* result = sCharSQL->Query("SELECT name FROM characters WHERE guid = %u AND acct = %u", (uint32)guid, m_accountId);
        if (!result)
            return E_CHAR_DELETE_FAILED;

        std::string name = result->Fetch()[0].GetString();
        delete result;

        /* This Stuff neds to be implemented in Realmserver
        if (inf->GuildId)
        {
            if (inf->guild->GetGuildLeader() == inf->guid)
                return E_CHAR_DELETE_FAILED_GUILD_LEADER;
            else
                inf->guild->RemoveGuildMember(inf, NULL);
        }

        for (uint8 i = 0; i < NUM_CHARTER_TYPES; ++i)
        {
            Charter* c = objmgr.GetCharterByGuid(guid, (CharterTypes)i);
            if (c != nullptr)
                c->RemoveSignature((uint32)guid);
        }


        for (uint8 i = 0; i < NUM_ARENA_TEAM_TYPES; ++i)
        {
            ArenaTeam* t = objmgr.GetArenaTeamByGuid((uint32)guid, i);
            if (t != NULL && t->m_leader == guid)
                return E_CHAR_DELETE_FAILED_ARENA_CAPTAIN;
            if (t != NULL)
                t->RemoveMember(inf);
        }
        */

        sCharSQL->WaitExecute("DELETE FROM characters WHERE guid = %u", (uint32)guid);

        // Add corpse info to Rplayer info to handle this correctly
        //Corpse* c = objmgr.GetCorpseByOwner((uint32)guid);
        //if (c)
            //sCharSQL->Execute("DELETE FROM corpses WHERE guid = %u", (uint32)guid);

        sCharSQL->Execute("DELETE FROM playeritems WHERE ownerguid=%u", (uint32)guid);
        sCharSQL->Execute("DELETE FROM gm_tickets WHERE playerguid = %u", (uint32)guid);
        sCharSQL->Execute("DELETE FROM playerpets WHERE ownerguid = %u", (uint32)guid);
        sCharSQL->Execute("DELETE FROM playerpetspells WHERE ownerguid = %u", (uint32)guid);
        sCharSQL->Execute("DELETE FROM tutorials WHERE playerId = %u", (uint32)guid);
        sCharSQL->Execute("DELETE FROM questlog WHERE player_guid = %u", (uint32)guid);
        sCharSQL->Execute("DELETE FROM playercooldowns WHERE player_guid = %u", (uint32)guid);
        sCharSQL->Execute("DELETE FROM mailbox WHERE player_guid = %u", (uint32)guid);
        sCharSQL->Execute("DELETE FROM social_friends WHERE character_guid = %u OR friend_guid = %u", (uint32)guid, (uint32)guid);
        sCharSQL->Execute("DELETE FROM social_ignores WHERE character_guid = %u OR ignore_guid = %u", (uint32)guid, (uint32)guid);
        sCharSQL->Execute("DELETE FROM character_achievement WHERE guid = '%u' AND achievement NOT IN (457, 467, 466, 465, 464, 463, 462, 461, 460, 459, 458, 1404, 1405, 1406, 1407, 1408, 1409, 1410, 1411, 1412, 1413, 1415, 1414, 1416, 1417, 1418, 1419, 1420, 1421, 1422, 1423, 1424, 1425, 1426, 1427, 1463, 1400, 456, 1402)", (uint32)guid);
        sCharSQL->Execute("DELETE FROM character_achievement_progress WHERE guid = '%u'", (uint32)guid);
        sCharSQL->Execute("DELETE FROM playerspells WHERE GUID = '%u'", guid);
        sCharSQL->Execute("DELETE FROM playerdeletedspells WHERE GUID = '%u'", guid);
        sCharSQL->Execute("DELETE FROM playerreputations WHERE guid = '%u'", guid);
        sCharSQL->Execute("DELETE FROM playerskills WHERE GUID = '%u'", guid);

        // remove player info
        sClientMgr.DestroyRPlayerInfo((uint32)guid);
        return E_CHAR_DELETE_SUCCESS;
    }
    return E_CHAR_DELETE_FAILED;
}