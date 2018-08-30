/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#ifndef _GAME
#include "RealmStdAfx.h"

class Channel;
#endif

struct RPlayerInfo
{
    uint32 Guid;
    uint32 AccountId;
    std::string Name;
    uint32 Level;
    uint32 GuildId;
    float PositionX;
    float PositionY;
    uint32 ZoneId;
    uint8 Race;
    uint8 Class;
    uint8 Gender;
    uint32 Latency;
    std::string GMPermissions;
    uint32 Account_Flags;
    uint32 InstanceId;
    uint32 MapId;
    uint32 iInstanceType;
    uint32 references;
    uint32 ClientBuild;
    uint32 Team;
    bool IsAFK;
    bool IsDND;
    bool IsGmOn;
    std::string AFKreason;
    std::string DNDreason;

    void Pack(ByteBuffer& buf)
    {
        buf << Guid << AccountId << Name << PositionX << PositionY << ZoneId << Race << Class << Gender << Latency << GMPermissions
            << Account_Flags << InstanceId << Level << GuildId << MapId << iInstanceType << ClientBuild << Team << IsAFK << IsDND << IsGmOn << AFKreason << DNDreason;
    }

    size_t Unpack(ByteBuffer & buf)
    {
        buf >> Guid >> AccountId >> Name >> PositionX >> PositionY >> ZoneId >> Race >> Class >> Gender >> Latency >> GMPermissions
            >> Account_Flags >> InstanceId >> Level >> GuildId >> MapId >> iInstanceType >> ClientBuild >> Team >> IsAFK >> IsDND >> IsGmOn >> AFKreason >> DNDreason;
        return buf.rpos();
    }

    uint32 getClassMask() { return 1 << (Class - 1); }
    uint32 getRaceMask() { return 1 << (Race - 1); }


#ifndef _GAME
    /* This stuff is used only by the realm server */
    Session * session;
    Session * GetSession() { return session; }
    uint32 RecoveryMapId;
    LocationVector RecoveryPosition;

    // Channels
    std::set<Channel*> m_channels;

    void JoinedChannel(Channel* c);
    void LeftChannel(Channel* c);
    void CleanupChannels();
    void OnZoneUpdate(std::string updatename, std::string updatename2,uint32 mapId,uint32 ZoneId, uint32 flags);
#endif
};

#ifndef _GAME
/* This stuff is used only by the realm server */


#define EQUIPMENT_SLOT_MAINHAND     15
#define EQUIPMENT_SLOT_OFFHAND      16

struct SocketInfo
{
    uint32 SocketColor;
    uint32 Unk;
};

struct ItemSpell
{
    uint32 Id;
    uint32 Trigger;
    int32 Charges;
    int32 Cooldown;
    uint32 Category;
    int32 CategoryCooldown;
};

struct ItemPage
{
    uint32 id;
    std::string text;
    uint32 next_page;
};

struct ItemSetLinkedItemSetBonus
{
    int32_t itemset;
    uint32_t itemset_bonus;
};

struct ItemDamage
{
    float Min;
    float Max;
    uint32 Type;
};

struct ItemStat
{
    uint32 Type;
    int32 Value;
};

#define MAX_ITEM_PROTO_DAMAGES 2
#define MAX_ITEM_PROTO_SOCKETS 3
#define MAX_ITEM_PROTO_SPELLS  5
#define MAX_ITEM_PROTO_STATS  10

struct ItemProperties
{
    uint32 ItemId;
    uint32 Class;
    uint32 SubClass;
    uint32 unknown_bc;
    std::string Name;
    uint32 DisplayInfoID;
    uint32 Quality;
    uint32 Flags;
    uint32 Flags2;
    uint32 BuyPrice;
    uint32 SellPrice;
    uint32 InventoryType;
    uint32 AllowableClass;
    uint32 AllowableRace;
    uint32 ItemLevel;
    uint32 RequiredLevel;
    uint32 RequiredSkill;
    uint32 RequiredSkillRank;
    uint32 RequiredSkillSubRank;    /// required spell
    uint32 RequiredPlayerRank1;
    uint32 RequiredPlayerRank2;
    uint32 RequiredFaction;
    uint32 RequiredFactionStanding;
    uint32 Unique;
    uint32 MaxCount;
    uint32 ContainerSlots;
    uint32 itemstatscount;
    ItemStat Stats[MAX_ITEM_PROTO_STATS];
    uint32 ScalingStatsEntry;
    uint32 ScalingStatsFlag;
    ItemDamage Damage[MAX_ITEM_PROTO_DAMAGES];
    uint32 Armor;
    uint32 HolyRes;
    uint32 FireRes;
    uint32 NatureRes;
    uint32 FrostRes;
    uint32 ShadowRes;
    uint32 ArcaneRes;
    uint32 Delay;
    uint32 AmmoType;
    float Range;
    ItemSpell Spells[MAX_ITEM_PROTO_SPELLS];
    uint32 Bonding;
    std::string Description;
    uint32 PageId;
    uint32 PageLanguage;
    uint32 PageMaterial;
    uint32 QuestId;
    uint32 LockId;
    uint32 LockMaterial;
    uint32 SheathID;
    uint32 RandomPropId;
    uint32 RandomSuffixId;
    uint32 Block;
    int32 ItemSet;
    uint32 MaxDurability;
    uint32 ZoneNameID;
    uint32 MapID;
    uint32 BagFamily;
    uint32 TotemCategory;
    SocketInfo Sockets[MAX_ITEM_PROTO_SOCKETS];
    uint32 SocketBonus;
    uint32 GemProperties;
    int32 DisenchantReqSkill;
    uint32 ArmorDamageModifier;
    uint32 ExistingDuration;
    uint32 ItemLimitCategory;
    uint32 HolidayId;
    uint32 FoodType;

    std::string lowercase_name;      /// used in auctions
    int32 ForcedPetId;

    bool HasFlag(uint32 flag) const
    {
        if ((Flags & flag) != 0)
            return true;
        else
            return false;
    }

    bool HasFlag2(uint32 flag) const
    {
        if ((Flags2 & flag) != 0)
            return true;
        else
            return false;
    }
};

// Shorten version it is only needed for query opcode
#pragma pack(push,1)
struct CreatureProperties
{
    uint32 Id;
    uint32 killcredit[2];
    uint32 Male_DisplayID;
    uint32 Female_DisplayID;
    uint32 Male_DisplayID2;
    uint32 Female_DisplayID2;
    std::string Name;
    std::string SubName;
    std::string info_str;
    uint32 Flags1;
    uint32 Type;
    uint32 Family;
    uint32 Rank;
    float unkfloat1;
    float unkfloat2;
    uint8  Leader;
    uint32 QuestItems[6];
    uint32 waypointid;

    uint8 GenerateModelId(uint32* des) const
    {
        uint32 models[] = { Male_DisplayID, Male_DisplayID2, Female_DisplayID, Female_DisplayID2 };
        if (!models[0] && !models[1] && !models[2] && !models[3])
        {
            // All models are invalid.
            LogNotice("CreatureSpawn", "All model IDs are invalid for creature %u", Id);
            return 0;
        }

        while (true)
        {
            uint32 res = RandomUInt(3);
            if (models[res])
            {
                *des = models[res];
                return res < 2 ? 0 : 1;
            }
        }
    }
};

#pragma pack(push,1)
struct GameObjectProperties
{
    uint32 entry;
    uint32 type;
    uint32 display_id;
    std::string name;
    std::string category_name;
    std::string cast_bar_text;
    std::string Unkstr;

    // different data fields for GO-types
    /// \todo add different structure for go types.
    union
    {
        // 0 GAMEOBJECT_TYPE_DOOR
        struct
        {
            uint32 start_open;                  // parameter_0 client side opened/closed
            uint32 lock_id;                     // parameter_1 from Lock.dbc
            uint32 auto_close_time;             // parameter_2 in secs
            uint32 no_damage_immune;            // parameter_3
            uint32 open_text_id;                // parameter_4
            uint32 close_text_id;               // parameter_5
            uint32 ignored_by_pathing;          // parameter_6
        }door;
        // 1 GAMEOBJECT_TYPE_BUTTON
        struct
        {
            uint32 start_open;                  // parameter_0
            uint32 lock_id;                     // parameter_1 from Lock.dbc
            uint32 auto_close_time;             // parameter_2 in secs
            uint32 linked_trap_id;              // parameter_3
            uint32 no_damage_immune;            // parameter_4 BgObject
            uint32 large;                       // parameter_5
            uint32 open_text_id;                // parameter_6
            uint32 close_text_id;               // parameter_7
            uint32 los_ok;                      // parameter_8
        }button;
        // 2 GAMEOBJECT_TYPE_QUESTGIVER
        // 3 GAMEOBJECT_TYPE_CHEST
        struct
        {
            uint32 lock_id;                     // parameter_0 from Lock.dbc
            uint32 loot_id;                     // parameter_1
            uint32 restock_time;                // parameter_2
            uint32 consumable;                  // parameter_3 bool
            uint32 min_success_opens;           // parameter_4
            uint32 max_success_opens;           // parameter_5
            uint32 event_id;                    // parameter_6 lootedEvent
            uint32 linked_trap_id;              // parameter_7
            uint32 quest_id;                    // parameter_8 quest required for GO activation
            uint32 level;                       // parameter_9
            uint32 los_OK;                      // parameter_10
            uint32 leave_loot;                  // parameter_11
            uint32 not_in_combat;               // parameter_12
            uint32 log_loot;                    // parameter_13
            uint32 open_text_id;                // parameter_14
            uint32 group_loot_rules;            // parameter_15
            uint32 floating_tooltip;            // parameter_16
        } chest;
        // 4 GAMEOBJECT_TYPE_BINDER
        // 5 GAMEOBJECT_TYPE_GENERIC
        // 6 GAMEOBJECT_TYPE_TRAP
        struct
        {
            uint32 lock_id;                     // parameter_0 from Lock.dbc
            uint32 level;                       // parameter_1
            uint32 radius;                      // parameter_2 radius for trap activation
            uint32 spell_id;                    // parameter_3
            uint32 charges;                     // parameter_4
            uint32 cooldown;                    // parameter_5 in secs
            uint32 auto_close_time;             // parameter_6 in secs
            uint32 start_delay;                 // parameter_7
            uint32 server_only;                 // parameter_8
            uint32 stealthed;                   // parameter_9
            uint32 large;                       // parameter_10
            uint32 stealth_affected;            // parameter_11
            uint32 open_text_id;                // parameter_12
            uint32 close_text_id;               // parameter_13
            uint32 ignore_totems;               // parameter_14
        } trap;
        // 7 GAMEOBJECT_TYPE_CHAIR
        // 8 GAMEOBJECT_TYPE_SPELL_FOCUS
        struct
        {
            uint32 focus_id;                    // parameter_0
            uint32 distance;                    // parameter_1
            uint32 linked_trap_id;              // parameter_2
            uint32 server_only;                 // parameter_3
            uint32 quest_id;                    // parameter_4
            uint32 large;                       // parameter_5
            uint32 floating_tooltip;            // parameter_6
        } spell_focus;
        // 9 GAMEOBJECT_TYPE_TEXT
        // 10 GAMEOBJECT_TYPE_GOOBER
        struct
        {
            uint32 lock_id;                     // parameter_0 from Lock.dbc
            uint32 quest_id;                    // parameter_1
            uint32 event_id;                    // parameter_2
            uint32 auto_close_time;             // parameter_3 in secs
            uint32 custom_anim;                 // parameter_4
            uint32 consumable;                  // parameter_5
            uint32 cooldown;                    // parameter_6
            uint32 page_id;                     // parameter_7
            uint32 language;                    // parameter_8
            uint32 page_material;               // parameter_9
            uint32 spell_id;                    // parameter_10
            uint32 no_damage_immune;            // parameter_11
            uint32 linked_trap_id;              // parameter_12
            uint32 large;                       // parameter_13
            uint32 open_text_iD;                // parameter_14
            uint32 close_text_iD;               // parameter_15
            uint32 los_ok;                      // parameter_16 BgObject
            uint32 allow_mounted;               // parameter_17
            uint32 floating_tooltip;            // parameter_18
            uint32 gossip_id;                   // parameter_19
            uint32 world_state_sets_state;      // parameter_20
        }goober;
        // 11 GAMEOBJECT_TYPE_TRANSPORT
        // 12 GAMEOBJECT_TYPE_AREADAMAGE
        // 13 GAMEOBJECT_TYPE_CAMERA
        struct
        {
            uint32 lock_id;                     // parameter_0 from Lock.dbc
            uint32 cinematic_id;                // parameter_1
            uint32 event_id;                    // parameter_2
            uint32 open_text_id;                // parameter_3
        }camera;
        // 14 GAMEOBJECT_TYPE_MAP_OBJECT
        // 15 GAMEOBJECT_TYPE_MO_TRANSPORT
        struct
        {
            uint32 taxi_path_id;                // parameter_0
            uint32 move_speed;                  // parameter_1
            uint32 accel_rate;                  // parameter_2
            uint32 start_event_id;              // parameter_3
            uint32 stop_event_id;               // parameter_4
            uint32 transport_physics;           // parameter_5
            uint32 map_id;                      // parameter_6
            uint32 world_state;                 // parameter_7
            uint32 can_be_stopped;              // parameter_8
        } mo_transport;
        // 16 GAMEOBJECT_TYPE_DUEL_ARBITER
        // 17 GAMEOBJECT_TYPE_FISHINGNODE
        // 18 GAMEOBJECT_TYPE_RITUAL
        struct
        {
            uint32 req_participants;            // parameter_0
            uint32 spell_id;                    // parameter_1
            uint32 anim_spell;                  // parameter_2
            uint32 ritual_persistent;           // parameter_3
            uint32 caster_target_spell;         // parameter_4
            uint32 caster_target_spell_targets; // parameter_5
            uint32 casters_grouped;             // parameter_6
            uint32 ritual_no_target_check;      // parameter_7
        }summoning_ritual;
        // 19 GAMEOBJECT_TYPE_MAILBOX
        // 20 GAMEOBJECT_TYPE_AUCTIONHOUSE
        // 21 GAMEOBJECT_TYPE_GUARDPOST
        // 22 GAMEOBJECT_TYPE_SPELLCASTER
        struct
        {
            uint32 spell_id;                    // parameter_0
            uint32 charges;                     // parameter_1
            uint32 party_only;                  // parameter_2
            uint32 allow_mounted;               // parameter_3
            uint32 large;                       // parameter_4
        }spell_caster;
        // 23 GAMEOBJECT_TYPE_MEETINGSTONE
        // 24 GAMEOBJECT_TYPE_FLAGSTAND
        // 25 GAMEOBJECT_TYPE_FISHINGHOLE
        struct
        {
            uint32 radius;                      // parameter_0
            uint32 loot_id;                     // parameter_1
            uint32 min_success_opens;           // parameter_2
            uint32 max_success_opens;           // parameter_3
            uint32 lock_id;                     // parameter_4 from Lock.dbc
        }fishinghole;
        // 26 GAMEOBJECT_TYPE_FLAGDROP
        // 27 GAMEOBJECT_TYPE_MINI_GAME
        // 28 GAMEOBJECT_TYPE_LOTTERY_KIOSK
        // 29 GAMEOBJECT_TYPE_CAPTURE_POINT
        // 30 GAMEOBJECT_TYPE_AURA_GENERATOR
        // 31 GAMEOBJECT_TYPE_DUNGEON_DIFFICULTY
        // 32 GAMEOBJECT_TYPE_BARBER_CHAIR
        // 33 GAMEOBJECT_TYPE_DESTRUCTIBLE_BUILDING
        struct
        {
            uint32 intact_num_hits;             // parameter_0
            uint32 credit_proxy_creature;       // parameter_1
            uint32 state1_name;                 // parameter_2
            uint32 intact_event;                // parameter_3
            uint32 damaged_display_id;          // parameter_4
            uint32 damaged_num_hits;            // parameter_5
            uint32 unused1;                     // parameter_6
            uint32 unused2;                     // parameter_7
            uint32 unused3;                     // parameter_8
            uint32 damaged_event;               // parameter_9
            uint32 destroyed_display_id;        // parameter_10
            uint32 unused4;                     // parameter_11
            uint32 unused5;                     // parameter_12
            uint32 unused6;                     // parameter_13
            uint32 destroyed_event;             // parameter_14
            uint32 unused7;                     // parameter_15
            uint32 debuilding_time_secs;        // parameter_16
            uint32 unused8;                     // parameter_17
            uint32 destructible_data;           // parameter_18
            uint32 rebuilding_event;            // parameter_19
            uint32 unused9;                     // parameter_20
            uint32 unused10;                    // parameter_21
            uint32 damage_event;                // parameter_22
            uint32 unused11;                    // parameter_23
        } destructible_building;
        // 34 GAMEOBJECT_TYPE_GUILD_BANK
        // 35 GAMEOBJECT_TYPE_TRAPDOOR

        // raw parameters
        struct
        {
            uint32 parameter_0;
            uint32 parameter_1;
            uint32 parameter_2;
            uint32 parameter_3;
            uint32 parameter_4;
            uint32 parameter_5;
            uint32 parameter_6;
            uint32 parameter_7;
            uint32 parameter_8;
            uint32 parameter_9;
            uint32 parameter_10;
            uint32 parameter_11;
            uint32 parameter_12;
            uint32 parameter_13;
            uint32 parameter_14;
            uint32 parameter_15;
            uint32 parameter_16;
            uint32 parameter_17;
            uint32 parameter_18;
            uint32 parameter_19;
            uint32 parameter_20;
            uint32 parameter_21;
            uint32 parameter_22;
            uint32 parameter_23;
        }raw;
    };
    float size;
    uint32 QuestItems[6];
};
#pragma pack(pop)

#define MAX_REQUIRED_QUEST_ITEM 6

#pragma pack(push,1)
struct QuestProperties
{
    uint32 id;
    uint32 zone_id;
    uint32 quest_sort;
    uint32 quest_flags;
    uint32 min_level;
    int32 questlevel;
    uint32 type;
    uint32 required_races;
    uint32 required_class;
    uint32 required_tradeskill;
    uint32 required_tradeskill_value;
    uint32 required_rep_faction;
    uint32 required_rep_value;

    uint32 time;
    uint32 special_flags;

    uint32 previous_quest_id;
    uint32 next_quest_id;

    uint32 srcitem;
    uint32 srcitemcount;

    std::string title;
    std::string details;
    std::string objectives;
    std::string completiontext;
    std::string incompletetext;
    std::string endtext;

    std::string objectivetexts[4];

    uint32 required_item[MAX_REQUIRED_QUEST_ITEM];
    uint32 required_itemcount[MAX_REQUIRED_QUEST_ITEM];

    int32 required_mob[4];              /// positive is NPC, negative is GO
    uint32 required_mobcount[4];
    uint32 required_spell[4];
    uint32 required_emote[4];

    uint32 reward_choiceitem[6];
    uint32 reward_choiceitemcount[6];

    uint32 reward_item[4];
    uint32 reward_itemcount[4];

    uint32 reward_repfaction[6];
    int32 reward_repvalue[6];
    uint32 reward_replimit;

    int32 reward_money;
    uint32 reward_xp;
    uint32 reward_spell;
    uint32 effect_on_player;

    uint32 MailTemplateId;
    uint32 MailDelaySecs;
    uint32 MailSendItem;

    uint32 point_mapid;
    uint32 point_x;
    uint32 point_y;
    uint32 point_opt;

    uint32 rew_money_at_max_level;
    uint32 required_triggers[4];
    std::string x_or_y_quest_string;
    uint32 required_quests[4];
    std::string remove_quests;
    uint32 receive_items[4];
    uint32 receive_itemcount[4];
    int is_repeatable;
    uint32 GetRewardItemCount() const;

    uint32 bonushonor;
    uint32 bonusarenapoints;
    uint32 rewardtitleid;
    uint32 rewardtalents;
    uint32 suggestedplayers;

    // emotes
    uint32 detailemotecount;
    uint32 detailemote[4];
    uint32 detailemotedelay[4];
    uint32 completionemotecount;
    uint32 completionemote[4];
    uint32 completionemotedelay[4];
    uint32 completeemote;
    uint32 incompleteemote;
    uint32 iscompletedbyspelleffect;
    uint32 RewXPId;

    // this marks the end of the fields loaded from db - don't remove the comment please

    uint32 count_required_mob;
    uint32 count_requiredquests;
    uint32 count_requiredtriggers;
    uint32 count_receiveitems;
    uint32 count_reward_choiceitem;
    uint32 count_required_item;
    uint32 required_mobtype[4];
    uint32 count_reward_item;

    std::set<uint32> quest_list;
    std::set<uint32> remove_quest_list;


    //////////////////////////////////////////////////////////////////////////////////////////
    /// Tells if the quest has a specific flag.
    ///
    /// \param uint32 flag  -  flag to check
    ///
    /// \return true if the quest has this flag, false if the quest doesn't have this flag.
    ///
    //////////////////////////////////////////////////////////////////////////////////////////
    bool HasFlag(uint32 flag) const
    {
        if ((quest_flags & flag) != 0)
            return true;
        else
            return false;
    }
};

#pragma pack(pop)

typedef std::unordered_map<QuestProperties const*, uint32 > GameObjectGOMap;
typedef std::unordered_map<QuestProperties const*, std::map<uint32, uint32> > GameObjectItemMap;


struct CreatureDifficulty
{
    uint32 Id;
    uint32 difficulty_entry_1;
    uint32 difficulty_entry_2;
    uint32 difficulty_entry_3;
};

#pragma pack(push, 1)
struct DisplayBounding
{
    uint32 displayid;
    float low[3];
    float high[3];
    float boundradius;
};
#pragma pack(pop)

#pragma pack(push,1)
typedef struct AreaTrigger
{
    uint32 AreaTriggerID;
    uint8 Type;
    uint32 Mapid;
    uint32 PendingScreen;
    std::string Name;
    float x;
    float y;
    float z;
    float o;
    uint32 required_honor_rank;
    uint32 required_level;
} AreaTrigger;
#pragma pack(pop)

#pragma pack(push,1)

struct GraveyardTeleport
{
    uint32 ID;
    float X;
    float Y;
    float Z;
    float O;
    uint32 ZoneId;
    uint32 AdjacentZoneId;
    uint32 MapId;
    uint32 FactionID;
};

#pragma pack(pop)

#pragma pack(push,1)
struct MapInfo
{
    uint32 mapid;
    uint32 screenid;
    uint32 type;
    uint32 playerlimit;
    uint32 minlevel;
    uint32 minlevel_heroic;
    float repopx;
    float repopy;
    float repopz;
    uint32 repopmapid;
    std::string name;
    uint32 flags;
    uint32 cooldown;
    uint32 lvl_mod_a;
    uint32 required_quest_A;
    uint32 required_quest_H;
    uint32 required_item;
    uint32 heroic_key_1;
    uint32 heroic_key_2;
    float update_distance;
    uint32 checkpoint_id;
    bool cluster_loads_map;

    //////////////////////////////////////////////////////////////////////////////////////////
    /// Tells if the map has this particular flag
    /// \param  uint32 flag  -  flag to check
    /// \return true if the map has the flag, otherwise false if the map doesn't have the flag.
    //////////////////////////////////////////////////////////////////////////////////////////
    bool HasFlag(uint32 flag) const
    {
        if ((flags & flag) != 0)
            return true;
        else
            return false;
    }

    //////////////////////////////////////////////////////////////////////////////////////////
    /// Tells if the map has a particular raid difficulty.
    /// Valid difficulties are in the RAID_MODE enum.
    /// \param    uint32 difficulty  -  difficulty to check
    /// \return   true if the map has this difficulty, otherwise false.
    //////////////////////////////////////////////////////////////////////////////////////////
    bool HasDifficulty(uint32 difficulty) const
    {
        if (difficulty > uint32(4))
            return false;

        return HasFlag(uint32(32) << difficulty);
    }
};

#pragma pack(pop)

enum RAID_MODE
{
    MODE_NORMAL_10MEN = 0,
    MODE_NORMAL_25MEN = 1,
    MODE_HEROIC_10MEN = 2,
    MODE_HEROIC_25MEN = 3,
    TOTAL_RAID_MODES = 4
};

enum WorldMapInfoFlag
{
    WMI_INSTANCE_ENABLED = 0x001,
    WMI_INSTANCE_WELCOME = 0x002,
    WMI_INSTANCE_ARENA = 0x004,
    WMI_INSTANCE_XPACK_01 = 0x008, //The Burning Crusade expansion
    WMI_INSTANCE_XPACK_02 = 0x010, //Wrath of the Lich King expansion
    WMI_INSTANCE_HAS_NORMAL_10MEN = 0x020,
    WMI_INSTANCE_HAS_NORMAL_25MEN = 0x040,
    WMI_INSTANCE_HAS_HEROIC_10MEN = 0x080,
    WMI_INSTANCE_HAS_HEROIC_25MEN = 0x100
};

struct WorldStringTable
{
    uint32 id;
    std::string text;
};

#endif