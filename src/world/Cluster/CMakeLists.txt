# Copyright (C) 2014-2016 AscEmu Team <http://www.ascemu.org>

set(PATH_PREFIX Cluster)

set(SRC_CLUSTER_FILES
   ${PATH_PREFIX}/ClusterInterface.cpp
   ${PATH_PREFIX}/ClusterInterface.h
   ${PATH_PREFIX}/WorkdSocketCluster.cpp
   ${PATH_PREFIX}/WorkerServerClient.h
   ${PATH_PREFIX}/WorkerServerClient.cpp
)

source_group(Cluster FILES ${SRC_CLUSTER_FILES})
unset(PATH_PREFIX)
