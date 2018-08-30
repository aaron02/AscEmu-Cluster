/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "../logonserver/LogonCommServer/LogonRealmOpcodes.hpp"

#ifndef _WORKER_OPCODES_H
#define _WORKER_OPCODES_H

enum WorkerServerOpcodes
{
    // Realmserver opcodes
    ISMSG_AUTH_REQUEST,             // auth request to worker server
    ICMSG_AUTH_REPLY,               // auth reply to worker server
    ISMSG_AUTH_RESULT,              // auth result from worker server
    ICMSG_REGISTER_WORKER,          // register a worker server

    // Player
    ICMSG_CREATE_PLAYER,            // create a character
    ICMSG_PLAYER_LOGIN_RESULT,      // player login result
    ICMSG_PLAYER_LOGOUT,            // player logout
    ICMSG_PLAYER_INFO,              // handle Player Info from worker server
    ICMSG_SAVE_ALL_PLAYERS,         // incoming msg to save all players
    ICMSG_SWITCH_SERVER,            // handle switch server request from worker server

    // Teleport
    ICMSG_TELEPORT_REQUEST,         // teleport request from worker server
    ICMSG_TRANSPORTER_MAP_CHANGE,   // unused currently

    // Chat
    ICMSG_WHISPER,                  // whisper request from worker server
    ICMSG_CHAT,                     // chat request from worker server

    // Channel
    ICMSG_CHANNEL_ACTION,
    ICMSG_CHANNEL_UPDATE,
    ICMSG_CHANNEL_LFG_DUNGEON_STATUS_REPLY,

    // WoW Packets
    ICMSG_WOW_PACKET,               //

    // Connection Releated
    ICMSG_REALM_PING_STATUS,        // ping
    ICMSG_WORLD_PONG_STATUS,        // pong
    ICMSG_ERROR_HANDLER,            //

    // Instances and Worker server
    ISMSG_REGISTER_RESULT,          // register worker server result

    // Player releated
    ISMSG_CREATE_PLAYER,            // send character create request to a worker server for handling
    ISMSG_PLAYER_LOGIN,             // login a player to a worker server
    ISMSG_PLAYER_INFO,              // handle Player Info to worker server
    ISMSG_PACKED_PLAYER_INFO,       // pack all clients together and send to worker servers  
    ISMSG_DESTROY_PLAYER_INFO,      // destroy Player Info 
    ISMSG_SAVE_ALL_PLAYERS,         // send to worker servers they need to save the players
   
    // Teleport releated
    ISMSG_TRANSPORTER_MAP_CHANGE,   // unused currently
    ISMSG_TELEPORT_RESULT,          // teleport result to worker server 
    ISMSG_SESSION_REMOVED,          // send session remove

    // WoW Packets
    ISMSG_WOW_PACKET,               //

    // Chat
    ISMSG_WHISPER,                  // send whisper request to specific worker
    ISMSG_CHAT,                     // send chat to worker servers

    // Channel
    ISMSG_CHANNEL_ACTION,
    ISMSG_CHANNEL_LFG_DUNGEON_STATUS_REQUEST,

    IMSG_NUM_TYPES
};

// Channel
enum MSG_CHANNEL_ACTION
{
    CHANNEL_JOIN,
    CHANNEL_PART,
    CHANNEL_SAY
};
enum CMSG_CHANNEL_UPDATE
{
    UPDATE_CHANNELS_ON_ZONE_CHANGE = 1,
    PART_ALL_CHANNELS = 2,
    JOIN_ALL_CHANNELS = 3
};

#endif		// _WORKER_OPCODES_H


