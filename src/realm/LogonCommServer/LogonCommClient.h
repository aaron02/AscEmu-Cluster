/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#ifndef _R_LOGON_COMM_CLIENT_H
#define _R_LOGON_COMM_CLIENT_H

#include <RC4Engine.h>

class LogonCommClientSocket : public Socket
{
    uint32 remaining;
    uint16 opcode;
    RC4Engine _sendCrypto;
    RC4Engine _recvCrypto;

public:
    LogonCommClientSocket(SOCKET fd);
    ~LogonCommClientSocket();

    void OnRead();
    void SendPacket(WorldPacket * data, bool no_crypto);
    void HandlePacket(WorldPacket & recvData);
    void SendPing();
    void SendChallenge();
    void HandleAuthResponse(WorldPacket & recvData);

    void HandleRegister(WorldPacket & recvData);
    void HandlePong(WorldPacket & recvData);
    void HandleSessionInfo(WorldPacket & recvData);
    void HandleRequestAccountMapping(WorldPacket & recvData);
    void UpdateAccountCount(uint32 account_id, uint8 add);
    void HandleDisconnectAccount(WorldPacket& recvData);

    void HandleConsoleAuthResult(WorldPacket& recvData);
    void HandlePopulationRequest(WorldPacket& recvData);
    void HandleModifyDatabaseResult(WorldPacket& recvData);
    void HandleResultCheckAccount(WorldPacket& recvData);

    void OnDisconnect();
    void CompressAndSend(ByteBuffer & uncompressed);

    uint32 last_ping;
    uint32 last_pong;

    uint32 pingtime;
    uint32 latency;
    uint32 _id;
    uint32 authenticated;
    bool use_crypto;
    std::set<uint32> realm_ids;
};

typedef void (LogonCommClientSocket::*logonpacket_handler)(WorldPacket&);

#endif