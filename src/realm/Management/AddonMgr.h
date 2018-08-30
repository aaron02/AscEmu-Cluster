/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#ifndef _ADDONMGR_H
#define _ADDONMGR_H

struct AddonEntry
{
    std::string name;
    uint64 crc;
    bool banned;
    bool isNew;
    bool showinlist;
};

typedef std::map<std::string, AddonEntry*> KnownAddons;
typedef KnownAddons::iterator KnownAddonsItr;

typedef std::map<std::string, ByteBuffer> AddonData;
typedef AddonData::iterator AddonDataItr;

class AddonMgr : public Singleton < AddonMgr >
{
public:

    AddonMgr();
    ~AddonMgr();

    void LoadFromDB();
    void SaveToDB();

    void SendAddonInfoPacket(WorldPacket* source, uint32 pos, Session* m_session);
    bool AppendPublicKey(WorldPacket& data, std::string & AddonName, uint32 CRC);

private:

    bool IsAddonBanned(uint64 crc, std::string name = "");
    bool IsAddonBanned(std::string name, uint64 crc = 0);
    bool ShouldShowInList(std::string name);

    KnownAddons mKnownAddons;
    AddonData mAddonData;
};

#define sAddonMgr AddonMgr::getSingleton()

#endif      // _ADDONMGR_H
