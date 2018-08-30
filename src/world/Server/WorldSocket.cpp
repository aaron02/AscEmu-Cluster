/*
 * AscEmu Framework based on ArcEmu MMORPG Server
 * Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
 * Copyright (C) 2008-2012 ArcEmu Team <http://www.ArcEmu.org/>
 * Copyright (C) 2005-2007 Ascent Team
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 */
// Class WorldSocket - Main network code functions, handles
// reading/writing of all packets.

#include "StdAfx.h"
#include "AuthCodes.h"
#include "Management/AddonMgr.h"
#include "Server/LogonCommClient/LogonCommHandler.h"
#include "Management/LocalizationMgr.h"
#include "Server/MainServerDefines.h"
#include "Auth/Sha1.h"
#include "World.h"
#include "World.Legacy.h"

#if VERSION_STRING != Cata
void WorldLog::LogPacket(uint32 len, uint16 opcode, const uint8* data, uint8 direction, uint32 accountid)
#else
void WorldLog::LogPacket(uint32 len, uint32 opcode, const uint8* data, uint8 direction, uint32 accountid)
#endif
{
    if (worldConfig.log.worldDebugFlags & LF_OPCODE)
    {
        switch (opcode)
        {
            //stop spaming opcodes here
            case SMSG_MONSTER_MOVE:
            case MSG_MOVE_HEARTBEAT:
                break;
            default:
                LogDebugFlag(LF_OPCODE, "[%s]: %s %s (0x%03X) of %u bytes.", direction ? "SERVER" : "CLIENT", direction ? "sent" : "received",
                             getOpcodeName(opcode).c_str(), opcode, len);
        }
}

    if (bEnabled)
    {
        mutex.Acquire();
        unsigned int line = 1;
        unsigned int countpos = 0;
        uint16 lenght = static_cast<uint16>(len);
        unsigned int count = 0;

        fprintf(m_file, "{%s} Packet: (0x%04X) %s PacketSize = %u stamp = %u accountid = %u\n", (direction ? "SERVER" : "CLIENT"), opcode,
                getOpcodeName(opcode).c_str(), lenght, getMSTime(), accountid);
        fprintf(m_file, "|------------------------------------------------|----------------|\n");
        fprintf(m_file, "|00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F |0123456789ABCDEF|\n");
        fprintf(m_file, "|------------------------------------------------|----------------|\n");

        if (lenght > 0)
        {
            fprintf(m_file, "|");
            for (count = 0; count < lenght; count++)
            {
                if (countpos == 16)
                {
                    countpos = 0;

                    fprintf(m_file, "|");

                    for (unsigned int a = count - 16; a < count; a++)
                    {
                        if ((data[a] < 32) || (data[a] > 126))
                            fprintf(m_file, ".");
                        else
                            fprintf(m_file, "%c", data[a]);
                    }

                    fprintf(m_file, "|\n");

                    line++;
                    fprintf(m_file, "|");
                }

                fprintf(m_file, "%02X ", data[count]);

                //FIX TO PARSE PACKETS WITH LENGTH < OR = TO 16 BYTES.
                if (count + 1 == lenght && lenght <= 16)
                {
                    for (unsigned int b = countpos + 1; b < 16; b++)
                        fprintf(m_file, "   ");

                    fprintf(m_file, "|");

                    for (unsigned int a = 0; a < lenght; a++)
                    {
                        if ((data[a] < 32) || (data[a] > 126))
                            fprintf(m_file, ".");
                        else
                            fprintf(m_file, "%c", data[a]);
                    }

                    for (unsigned int c = count; c < 15; c++)
                        fprintf(m_file, " ");

                    fprintf(m_file, "|\n");
                }

                //FIX TO PARSE THE LAST LINE OF THE PACKETS WHEN THE LENGTH IS > 16 AND ITS IN THE LAST LINE.
                if (count + 1 == lenght && lenght > 16)
                {
                    for (unsigned int b = countpos + 1; b < 16; b++)
                        fprintf(m_file, "   ");

                    fprintf(m_file, "|");

                    unsigned short print = 0;

                    for (unsigned int a = line * 16 - 16; a < lenght; a++)
                    {
                        if ((data[a] < 32) || (data[a] > 126))
                            fprintf(m_file, ".");
                        else
                            fprintf(m_file, "%c", data[a]);

                        print++;
                    }

                    for (unsigned int c = print; c < 16; c++)
                        fprintf(m_file, " ");

                    fprintf(m_file, "|\n");
                }

                countpos++;
            }
        }
        fprintf(m_file, "-------------------------------------------------------------------\n\n");
        fflush(m_file);
        mutex.Release();
    }
}
