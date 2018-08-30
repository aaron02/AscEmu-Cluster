# Copyright (C) 2014-2016 AscEmu Team <http://www.ascemu.org>

set(PATH_PREFIX WorkerServer)

set(SRC_WORKERSERVER_FILES
   ${PATH_PREFIX}/WorkerOpcodes.h
   ${PATH_PREFIX}/WorkerServer.cpp
   ${PATH_PREFIX}/WorkerServer.h
   ${PATH_PREFIX}/WorkerServerSocket.cpp
   ${PATH_PREFIX}/WorkerServerSocket.h
)

source_group(WorkerServer FILES ${SRC_WORKERSERVER_FILES})
unset(PATH_PREFIX)
