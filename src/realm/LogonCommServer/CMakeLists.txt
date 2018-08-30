# Copyright (C) 2014-2016 AscEmu Team <http://www.ascemu.org>

set(PATH_PREFIX LogonCommServer)

set(SRC_LOGONCOMMSERVER_FILES
   ${PATH_PREFIX}/LogonCommClient.cpp
   ${PATH_PREFIX}/LogonCommClient.h
   ${PATH_PREFIX}/LogonCommHandler.cpp
   ${PATH_PREFIX}/LogonCommHandler.h
)

source_group(LogonCommServer FILES ${SRC_LOGONCOMMSERVER_FILES})
unset(PATH_PREFIX)
