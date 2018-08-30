/*
Copyright (c) 2014-2017 AscEmu Team <http://www.ascemu.org/>
This file is released under the MIT license. See README-MIT for more information.
*/

#include "../shared/Config/Config.h"

struct AllowedIP
{
    unsigned int IP;
    unsigned char Bytes;
};

enum AccountFlags
{
    ACCOUNT_FLAG_VIP = 0x1,
    ACCOUNT_FLAG_NO_AUTOJOIN = 0x2,
    //ACCOUNT_FLAG_XTEND_INFO   = 0x4,
    ACCOUNT_FLAG_XPACK_01 = 0x8,
    ACCOUNT_FLAG_XPACK_02 = 0x10
};

class SERVER_DECL ConfigMgr
{
public:

    ConfigFile MainConfig;
};

extern SERVER_DECL ConfigMgr Conf;