# Copyright (C) 2014-2016 AscEmu Team <http://www.ascemu.org>

set(PATH_PREFIX ClientManager)

set(SRC_CLIENTMANAGER_FILES
   ${PATH_PREFIX}/ClientManager.cpp
   ${PATH_PREFIX}/ClientManager.h
)

source_group(ClientManager FILES ${SRC_CLIENTMANAGER_FILES})
unset(PATH_PREFIX)
