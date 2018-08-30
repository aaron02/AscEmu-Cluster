# Copyright (C) 2014-2016 AscEmu Team <http://www.ascemu.org>

set(PATH_PREFIX ClusterManager)

set(SRC_CLUSTERMANAGER_FILES
   ${PATH_PREFIX}/ClusterManager.cpp
   ${PATH_PREFIX}/ClusterManager.h
)

source_group(ClusterManager FILES ${SRC_CLUSTERMANAGER_FILES})
unset(PATH_PREFIX)
