/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#ifndef _R_SESSION_H
#define _R_SESSION_H

#define CHECK_PACKET_SIZE(pckp, ssize) if (ssize && pckp.size() < ssize) { Disconnect(); return; }


typedef void(Session::*SessionPacketHandler)(WorldPacket&);

class Session
{
public:
    friend class WorldSocket;
    Session(uint32 id);
    ~Session();

protected:
    FastQueue<WorldPacket*, Mutex> m_readQueue;
    WorldSocket * m_socket;
    WorkerServer * m_server;
    WorkerServer * m_nextServer;
    uint32 m_sessionId;
    uint32 m_accountId;
    RPlayerInfo * m_currentPlayer;
    uint32 m_latency;
    uint32 m_accountFlags;
    std::string m_GMPermissions;
    std::string m_accountName;
    uint32 m_build;
    static SessionPacketHandler Handlers[NUM_MSG_TYPES];

public:
    bool deleted;
    static void InitHandlers();
    void Disconnect();
    void Update();
    _inline RPlayerInfo * GetPlayer() { return m_currentPlayer; }

    _inline void ClearCurrentPlayer() { m_currentPlayer = 0; }
    _inline void ClearServers() { m_nextServer = m_server = 0; }
    _inline void SetNextServer() { m_server = m_nextServer; }
    _inline void SetNextServer(WorkerServer* s) { m_nextServer = s; }
    _inline WorkerServer * GetNextServer() { return m_nextServer; }
    _inline void SetServer(WorkerServer * s) { m_server = s; }
    _inline WorkerServer * GetServer() { return m_server; }
    _inline WorldSocket * GetSocket() { return m_socket; }
    _inline std::string GetAccountPermissions() { return m_GMPermissions; }
    _inline std::string GetAccountName() { return m_accountName; }
    _inline uint32 GetAccountId() { return m_accountId; }
    _inline uint32 GetAccountFlags() { return m_accountFlags; }
    _inline uint32 GetSessionId() { return m_sessionId; }
    void SetAccountFlags(uint32 flags) { m_accountFlags = flags; }
    bool HasFlag(uint32 flag) { return (m_accountFlags & flag) != 0; }

    bool CanUseCommand(std::string cmdstr)
    {
        if (m_GMPermissions.find("a") != std::string::npos)
            return true;

        if (cmdstr.length() <= 1)
            return (m_GMPermissions.find(cmdstr) != std::string::npos);
        else
        {
            for (size_t i = 0; i < cmdstr.length(); i++)
            {
                if (m_GMPermissions.find(cmdstr[i]) == std::string::npos)
                    return false;
            }
        }
        return true;
    }

    void SendPacket(WorldPacket * data)
    {
        if (m_socket && m_socket->IsConnected())
            m_socket->SendPacket(data);
    }

    void HandlePlayerLogin(WorldPacket & pck);
    void HandleCharacterEnum(WorldPacket & pck);
    void HandleCharacterCreate(WorldPacket & pck);
    void HandleCharacterDelete(WorldPacket & pck);
    void HandleCharacterRename(WorldPacket & pck);

    void HandleItemQuerySingleOpcode(WorldPacket & pck);
    void HandleCreatureQueryOpcode(WorldPacket & pck);
    void HandleGameObjectQueryOpcode(WorldPacket & pck);
    void HandleItemPageQueryOpcode(WorldPacket & pck);
    void HandleNpcTextQueryOpcode(WorldPacket & pck);
    void HandleNameQueryOpcode(WorldPacket & pck);

    /// Channel Opcodes (ChannelHandler.cpp)
    void HandleChannelJoin(WorldPacket& recvPacket);
    void HandleChannelLeave(WorldPacket& recvPacket);
    void HandleChannelList(WorldPacket& recvPacket);
    void HandleChannelPassword(WorldPacket& recvPacket);
    void HandleChannelSetOwner(WorldPacket& recvPacket);
    void HandleChannelOwner(WorldPacket& recvPacket);
    void HandleChannelModerator(WorldPacket& recvPacket);
    void HandleChannelUnmoderator(WorldPacket& recvPacket);
    void HandleChannelMute(WorldPacket& recvPacket);
    void HandleChannelUnmute(WorldPacket& recvPacket);
    void HandleChannelInvite(WorldPacket& recvPacket);
    void HandleChannelKick(WorldPacket& recvPacket);
    void HandleChannelBan(WorldPacket& recvPacket);
    void HandleChannelUnban(WorldPacket& recvPacket);
    void HandleChannelAnnounce(WorldPacket& recvPacket);
    void HandleChannelModerate(WorldPacket& recvPacket);
    void HandleChannelNumMembersQuery(WorldPacket & recvPacket);
    void HandleChannelRosterQuery(WorldPacket & recvPacket);
    void HandleMessagechatOpcode(WorldPacket & recv_data);

private:
    bool has_level_55_char; // death knights
    bool has_dk;
    int8 _side;
};

#endif