# Copyright (C) 2014-2016 AscEmu Team <http://www.ascemu.org>

set(PATH_PREFIX ClientHandler)

set(SRC_CLIENTHANDLER_FILES
   ${PATH_PREFIX}/CharacterHandler.cpp
   ${PATH_PREFIX}/QueryHandler.cpp
   ${PATH_PREFIX}/Session.cpp
   ${PATH_PREFIX}/Session.h
   ${PATH_PREFIX}/WorldSocket.cpp
   ${PATH_PREFIX}/WorldSocket.h
)

source_group(ClientHandler FILES ${SRC_CLIENTHANDLER_FILES})
unset(PATH_PREFIX)
