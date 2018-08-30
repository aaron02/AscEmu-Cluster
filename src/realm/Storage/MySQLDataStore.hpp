/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#ifndef MYSQL_DATA_LOADS_HPP
#define MYSQL_DATA_LOADS_HPP

#include "Singleton.h"

extern SERVER_DECL std::set<std::string> GameObjectPropertiesTables;
extern SERVER_DECL std::set<std::string> CreaturePropertiesTables;
extern SERVER_DECL std::set<std::string> ItemPropertiesTables;
extern SERVER_DECL std::set<std::string> QuestPropertiesTables;

class SERVER_DECL MySQLDataStore : public Singleton < MySQLDataStore >
{
public:

    MySQLDataStore();
    ~MySQLDataStore();

    //maps
    typedef std::unordered_map<uint32, ItemPage> ItemPageContainer;
    typedef std::unordered_map<uint32, ItemProperties> ItemPropertiesContainer;
    typedef std::unordered_map<uint32, CreatureProperties> CreaturePropertiesContainer;
    typedef std::unordered_map<uint32, GameObjectProperties> GameObjectPropertiesContainer;
    typedef std::unordered_map<uint32, QuestProperties> QuestPropertiesContainer;

    typedef std::unordered_map<uint32, CreatureDifficulty> CreatureDifficultyContainer;
    typedef std::unordered_map<uint32, DisplayBounding> DisplayBoundingBoxesContainer;
    typedef std::unordered_map<uint32, AreaTrigger> AreaTriggerContainer;
    typedef std::unordered_map<uint32, GraveyardTeleport> GraveyardsContainer;
    typedef std::unordered_map<uint32, MapInfo> WorldMapInfoContainer;
    typedef std::unordered_map<uint32, WorldStringTable> WorldStringContainer;
    typedef std::unordered_map<int32, ItemSetLinkedItemSetBonus> ItemSetDefinedSetBonusContainer;


    //helper
    ItemPage const* GetItemPage(uint32 entry);
    ItemPageContainer const* GetItemPagesStore() { return &_itemPagesStore; }
    ItemProperties const* GetItemProperties(uint32 entry);
    ItemPropertiesContainer const* GetItemPropertiesStore() { return &_itemPropertiesStore; }

    CreatureProperties const* GetCreatureProperties(uint32 entry);
    CreaturePropertiesContainer const* GetCreaturePropertiesStore() { return &_creaturePropertiesStore; }

    GameObjectProperties const* GetGameObjectProperties(uint32 entry);
    GameObjectPropertiesContainer const* GetGameObjectPropertiesStore() { return &_gameobjectPropertiesStore; }

    QuestProperties const* GetQuestProperties(uint32 entry);
    QuestPropertiesContainer const* GetQuestPropertiesStore() { return &_questPropertiesStore; }

    uint32 GetCreatureDifficulty(uint32 entry, uint8 difficulty_type);
    CreatureDifficultyContainer const* GetCreatureDifficultyStore() { return &_creatureDifficultyStore; }

    DisplayBounding const* GetDisplayBounding(uint32 entry);
    DisplayBoundingBoxesContainer const* GetDisplayBoundingBoxesStore() { return &_displayBoundingBoxesStore; }

    AreaTrigger const* GetAreaTrigger(uint32 entry);
    AreaTriggerContainer const* GetAreaTriggersStore() { return &_areaTriggersStore; }

    GraveyardTeleport const* GetGraveyard(uint32 entry);
    GraveyardsContainer const* GetGraveyardsStore() { return &_graveyardsStore; }

    MapInfo const* GetWorldMapInfo(uint32 entry);
    WorldMapInfoContainer const* GetWorldMapInfoStore() { return &_worldMapInfoStore; }

    WorldStringTable const* GetWorldString(uint32 entry);
    WorldStringContainer const* GetWorldStringsStore() { return &_worldStringsStore; }

    ItemSetDefinedSetBonusContainer _definedItemSetBonusStore;

    uint32 GetItemSetLinkedBonus(int32 itemset);
    uint32 GetPlayerXPForLevel(uint32 level);

    uint32 GetGossipTextIdForNpc(uint32 entry);

    //Config
    void LoadAdditionalTableConfig();

    //Loads
    void LoadItemPagesTable();
    void LoadItemPropertiesTable();
    void LoadItemSetLinkedSetBonusTable();
    void LoadCreaturePropertiesTable();
    void LoadGameObjectPropertiesTable();
    void LoadQuestPropertiesTable();
    void LoadGameObjectQuestItemBindingTable();
    void LoadGameObjectQuestPickupBindingTable();

    void LoadCreatureDifficultyTable();
    void LoadDisplayBoundingBoxesTable();
    void LoadAreaTriggersTable();
    void LoadGraveyardsTable();
    void LoadWorldMapInfoTable();
    void LoadWorldStringsTable();

    ItemPageContainer _itemPagesStore;
    ItemPropertiesContainer _itemPropertiesStore;
    CreaturePropertiesContainer _creaturePropertiesStore;
    GameObjectPropertiesContainer _gameobjectPropertiesStore;
    QuestPropertiesContainer _questPropertiesStore;

    CreatureDifficultyContainer _creatureDifficultyStore;
    DisplayBoundingBoxesContainer _displayBoundingBoxesStore;
    AreaTriggerContainer _areaTriggersStore;
    GraveyardsContainer _graveyardsStore;
    WorldMapInfoContainer _worldMapInfoStore;

    WorldStringContainer _worldStringsStore;
};

#define sMySQLStore MySQLDataStore::getSingleton()

#endif MYSQL_DATA_LOADS_HPP