# Copyright (C) 2014-2016 AscEmu Team <http://www.ascemu.org>

set(PATH_PREFIX Chat)

set(SRC_CHAT_FILES
   ${PATH_PREFIX}/Channel.h
   ${PATH_PREFIX}/Channel.cpp
   ${PATH_PREFIX}/ChannelHandler.cpp
   ${PATH_PREFIX}/ChannelMgr.h
   ${PATH_PREFIX}/Chat.cpp
   ${PATH_PREFIX}/Chat.h
   ${PATH_PREFIX}/ChatHandler.cpp
)

source_group(Chat FILES ${SRC_CHAT_FILES})
unset(PATH_PREFIX)
