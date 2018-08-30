/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#ifndef REALMSERVER_WORLDSOCKET_H
#define REALMSERVER_WORLDSOCKET_H

#define WORLDSOCKET_SENDBUF_SIZE 131078
#define WORLDSOCKET_RECVBUF_SIZE 16384

class WorldPacket;
class Session;

enum OUTPACKET_RESULT
{
    OUTPACKET_RESULT_SUCCESS = 1,
    OUTPACKET_RESULT_NO_ROOM_IN_BUFFER = 2,
    OUTPACKET_RESULT_NOT_CONNECTED = 3,
    OUTPACKET_RESULT_SOCKET_ERROR = 4,
};

class SERVER_DECL WorldSocket : public Socket
{
public:

    WorldSocket(SOCKET fd);
    ~WorldSocket();

    // vs8 fix - send null on empty buffer
    inline void SendPacket(WorldPacket* packet) { if (!packet) return; OutPacket(packet->GetOpcode(), packet->size(), (packet->size() ? (const void*)packet->contents() : NULL)); }
    inline void SendPacket(StackBufferBase * packet) { if (!packet) return; OutPacket(packet->GetOpcode(), packet->GetSize(), (packet->GetSize() ? (const void*)packet->GetBufferPointer() : NULL)); }

#if VERSION_STRING != Cata
    void OutPacket(uint16 opcode, size_t len, const void* data);
    OUTPACKET_RESULT _OutPacket(uint16 opcode, size_t len, const void* data);
#else
    void OutPacket(uint32 opcode, size_t len, const void* data);
    OUTPACKET_RESULT _OutPacket(uint32 opcode, size_t len, const void* data);
#endif

    inline uint32 GetLatency() { return _latency; }

    void Authenticate();
    void InformationRetreiveCallback(WorldPacket & recvData, uint32 requestid);

    void UpdateQueuePosition(uint32 Position);

    void OnRead();
    void OnConnect();
    void OnDisconnect();

    inline void SetSession(Session* session) { mSession = session; }
    inline Session* GetSession() { return mSession; }
    bool Authed;

protected:

    void _HandleAuthSession(WorldPacket* recvPacket);
    void _HandlePing(WorldPacket* recvPacket);

private:

    uint32 mOpcode;
    uint32 mRemaining;
    uint32 mSize;
    uint32 mSeed;
    uint32 mClientSeed;
    uint32 mClientBuild;
    uint32 mRequestID;

    Session * mSession;
    WorldPacket * pAuthenticationPacket;
    FastQueue<WorldPacket*, DummyLock> _queue;
    Mutex queueLock;

    WowCrypt _crypt;
    uint32 _latency;
    bool mQueued;
    bool m_nagleEanbled;
    std::string* m_fullAccountName;
};

#endif