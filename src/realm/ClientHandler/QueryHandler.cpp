/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/



#include "RealmStdAfx.h"

void Session::HandleCreatureQueryOpcode(WorldPacket & recv_data)
{
    WorldPacket data(SMSG_CREATURE_QUERY_RESPONSE, 250); //VLack: thanks Aspire, this was 146 before
    uint32 entry;
    uint64 guid;
    CreatureProperties const* ci;

    recv_data >> entry;
    recv_data >> guid;

    if (entry == 300000)
    {
        data << entry;
        data << "WayPoint";
        data << uint8(0);
        data << uint8(0);
        data << uint8(0);
        data << "Level is WayPoint ID";
        for (uint8 i = 0; i < 8; i++)
        {
            data << uint32(0);
        }
        data << uint8(0);
    }
    else
    {
        ci = sMySQLStore.GetCreatureProperties(entry);
        if (ci == NULL)
            return;


        LOG_DETAIL("WORLD: CMSG_CREATURE_QUERY '%s'", ci->Name.c_str());
        data << entry;
        data << ci->Name;       // name of the creature
        data << uint8(0);       // name2, always seems to be empty
        data << uint8(0);       // name3, always seems to be empty
        data << uint8(0);       // name4, always seems to be empty
        data << ci->SubName;    // this is the title/guild of the creature

        data << ci->info_str;       // this is a string in 2.3.0 Example: stormwind guard has : "Direction"
        data << ci->Flags1;         // flags like skinnable
        data << ci->Type;           // humanoid, beast, etc
        data << ci->Family;         // petfamily
        data << ci->Rank;           // normal, elite, etc
        data << ci->killcredit[0];  // quest kill credit 1
        data << ci->killcredit[1];  // quest kill credit 2
        data << ci->Male_DisplayID;
        data << ci->Female_DisplayID;
        data << ci->Male_DisplayID2;
        data << ci->Female_DisplayID2;
        data << ci->unkfloat1;
        data << ci->unkfloat2;
        data << ci->Leader;         // faction leader

                                    // these are the 6 seperate quest items a creature can drop
        for (uint8 i = 0; i < 6; ++i)
        {
            data << uint32(ci->QuestItems[i]);
        }
        data << ci->waypointid;
    }

    SendPacket(&data);
}

void Session::HandleGameObjectQueryOpcode(WorldPacket & recv_data)
{
    WorldPacket data(SMSG_GAMEOBJECT_QUERY_RESPONSE, 900);

    uint32 entryID;
    uint64 guid;

    recv_data >> entryID;
    recv_data >> guid;

    LOG_DETAIL("WORLD: CMSG_GAMEOBJECT_QUERY '%u'", entryID);

    auto gameobject_info = sMySQLStore.GetGameObjectProperties(entryID);
    if (gameobject_info == nullptr)
        return;

    data << entryID;                // unique identifier of the GO template
    data << gameobject_info->type;           // type of the gameobject
    data << gameobject_info->display_id;      // displayid/modelid of the gameobject

                                              // Name of the gameobject

    data << gameobject_info->name;

    data << uint8(0);               // name2, always seems to be empty
    data << uint8(0);               // name3, always seems to be empty
    data << uint8(0);               // name4, always seems to be empty
    data << gameobject_info->category_name;  // Category string of the GO, like "attack", "pvp", "point", etc
    data << gameobject_info->cast_bar_text;  // text displayed when using the go, like "collecting", "summoning" etc
    data << gameobject_info->Unkstr;
    data << gameobject_info->raw.parameter_0;     // spellfocus id, ex.: spell casted when interacting with the GO
    data << gameobject_info->raw.parameter_1;
    data << gameobject_info->raw.parameter_2;
    data << gameobject_info->raw.parameter_3;
    data << gameobject_info->raw.parameter_4;
    data << gameobject_info->raw.parameter_5;
    data << gameobject_info->raw.parameter_6;
    data << gameobject_info->raw.parameter_7;
    data << gameobject_info->raw.parameter_8;
    data << gameobject_info->raw.parameter_9;
    data << gameobject_info->raw.parameter_10;
    data << gameobject_info->raw.parameter_11;
    data << gameobject_info->raw.parameter_12;
    data << gameobject_info->raw.parameter_13;
    data << gameobject_info->raw.parameter_14;
    data << gameobject_info->raw.parameter_15;
    data << gameobject_info->raw.parameter_16;
    data << gameobject_info->raw.parameter_17;
    data << gameobject_info->raw.parameter_18;
    data << gameobject_info->raw.parameter_19;
    data << gameobject_info->raw.parameter_20;
    data << gameobject_info->raw.parameter_21;
    data << gameobject_info->raw.parameter_22;
    data << gameobject_info->raw.parameter_23;
    data << float(gameobject_info->size);       // scaling of the GO

                                                // questitems that the go can contain
    for (uint8 i = 0; i < 6; ++i)
    {
        data << uint32(gameobject_info->QuestItems[i]);
    }

    SendPacket(&data);
}

void Session::HandleItemQuerySingleOpcode(WorldPacket & recv_data)
{
    uint32 itemid;
    recv_data >> itemid;

    ItemProperties const* itemProto = sMySQLStore.GetItemProperties(itemid);
    if (!itemProto)
    {
        LOG_ERROR("WORLD: Unknown item id 0x%.8X", itemid);
        return;
    }

    std::string Name = itemProto->Name;
    std::string Description = itemProto->Description;

    WorldPacket data(SMSG_ITEM_QUERY_SINGLE_RESPONSE, 800);
    data << itemProto->ItemId;
    data << itemProto->Class;
    data << itemProto->SubClass;
    data << itemProto->unknown_bc;
    data << Name;
    data << uint8(0);           // name 2?
    data << uint8(0);           // name 3?
    data << uint8(0);           // name 4?
    data << itemProto->DisplayInfoID;
    data << itemProto->Quality;
    data << itemProto->Flags;
    data << itemProto->Flags2;
    data << itemProto->BuyPrice;
    data << itemProto->SellPrice;
    data << itemProto->InventoryType;
    data << itemProto->AllowableClass;
    data << itemProto->AllowableRace;
    data << itemProto->ItemLevel;
    data << itemProto->RequiredLevel;
    data << itemProto->RequiredSkill;
    data << itemProto->RequiredSkillRank;
    data << itemProto->RequiredSkillSubRank;
    data << itemProto->RequiredPlayerRank1;
    data << itemProto->RequiredPlayerRank2;
    data << itemProto->RequiredFaction;
    data << itemProto->RequiredFactionStanding;
    data << itemProto->Unique;
    data << itemProto->MaxCount;
    data << itemProto->ContainerSlots;
    data << itemProto->itemstatscount;
    for (uint8 i = 0; i < itemProto->itemstatscount; i++)
    {
        data << itemProto->Stats[i].Type;
        data << itemProto->Stats[i].Value;
    }
    data << itemProto->ScalingStatsEntry;
    data << itemProto->ScalingStatsFlag;
    for (uint8 i = 0; i < 2; i++)           // originally this went up to 5, now only to 2
    {
        data << itemProto->Damage[i].Min;
        data << itemProto->Damage[i].Max;
        data << itemProto->Damage[i].Type;
    }
    data << itemProto->Armor;
    data << itemProto->HolyRes;
    data << itemProto->FireRes;
    data << itemProto->NatureRes;
    data << itemProto->FrostRes;
    data << itemProto->ShadowRes;
    data << itemProto->ArcaneRes;
    data << itemProto->Delay;
    data << itemProto->AmmoType;
    data << itemProto->Range;
    for (uint8 i = 0; i < 5; i++)
    {
        data << itemProto->Spells[i].Id;
        data << itemProto->Spells[i].Trigger;
        data << itemProto->Spells[i].Charges;
        data << itemProto->Spells[i].Cooldown;
        data << itemProto->Spells[i].Category;
        data << itemProto->Spells[i].CategoryCooldown;
    }
    data << itemProto->Bonding;

    data << Description;

    data << itemProto->PageId;
    data << itemProto->PageLanguage;
    data << itemProto->PageMaterial;
    data << itemProto->QuestId;
    data << itemProto->LockId;
    data << itemProto->LockMaterial;
    data << itemProto->SheathID;
    data << itemProto->RandomPropId;
    data << itemProto->RandomSuffixId;
    data << itemProto->Block;
    data << sMySQLStore.GetItemSetLinkedBonus(itemProto->ItemSet);
    data << itemProto->MaxDurability;
    data << itemProto->ZoneNameID;
    data << itemProto->MapID;
    data << itemProto->BagFamily;
    data << itemProto->TotemCategory;
    data << itemProto->Sockets[0].SocketColor;
    data << itemProto->Sockets[0].Unk;
    data << itemProto->Sockets[1].SocketColor;
    data << itemProto->Sockets[1].Unk;
    data << itemProto->Sockets[2].SocketColor;
    data << itemProto->Sockets[2].Unk;
    data << itemProto->SocketBonus;
    data << itemProto->GemProperties;
    data << itemProto->DisenchantReqSkill;
    data << itemProto->ArmorDamageModifier;
    data << itemProto->ExistingDuration;                    // 2.4.2 Item duration in seconds
    data << itemProto->ItemLimitCategory;
    data << itemProto->HolidayId;                           // HolidayNames.dbc
    SendPacket(&data);
}

void Session::HandleNameQueryOpcode(WorldPacket & recv_data)
{
    CHECK_PACKET_SIZE(recv_data, 8);
    uint64 guid;
    recv_data >> guid;

    QueryResult* result = sCharSQL->Query("SELECT race, class, gender, name FROM characters WHERE guid=%u ", guid);

    if (result)
    {

        Field* fields;
        uint32 Guid;
        std::string Name;
        uint8 Race;
        uint8 Gender;
        uint8 Class;

        fields = result->Fetch();
        Guid = guid;
        Race = fields[0].GetUInt8();
        Class = fields[1].GetUInt8();
        Gender = fields[2].GetUInt8();
        Name = fields[3].GetString();

        LOG_DEBUG("Received CMSG_NAME_QUERY for: %s", Name);

        WoWGuid pguid((uint64)Guid); //VLack: The usual new style guid handling on 3.1.2
        WorldPacket data(SMSG_NAME_QUERY_RESPONSE, Name.size() + 35);
        data << pguid;
        data << uint8(0); //VLack: usual, new-style guid with an uint8
        data << Name;
        data << uint8(0);       // this is a string showed besides players name (eg. in combat log), a custom title ?
        data << uint8(Race);
        data << uint8(Gender);
        data << uint8(Class);
        //    data << uint8(0);            // 2.4.0, why do i get the feeling blizz is adding custom classes or custom titles? (same thing in who list)
        data << uint8(0); //VLack: tell the server this name is not declined... (3.1 fix?)
        SendPacket(&data);

        delete result;
    }
}
