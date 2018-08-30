# Copyright (C) 2014-2016 AscEmu Team <http://www.ascemu.org>

# set up our project name
project(realm CXX)

include(Server/CMakeLists.txt)
include(ClientManager/CMakeLists.txt)
include(ClientHandler/CMakeLists.txt)
include(ClusterManager/CMakeLists.txt)
include(LogonCommServer/CMakeLists.txt)
include(Storage/CMakeLists.txt)
include(WorkerServer/CMakeLists.txt)
include(Management/CMakeLists.txt)
include(Storage/DBC/CMakeLists.txt)
include(Chat/CMakeLists.txt)

set(SRC_REALM_PROJECT
   ${CMAKE_CURRENT_SOURCE_DIR}/RealmStdAfx.cpp
   ${CMAKE_CURRENT_SOURCE_DIR}/RealmStdAfx.h
)

if(WIN32)
   set(SRC_REALM_PROJECT ${SRC_REALM_PROJECT} ${CMAKE_CURRENT_SOURCE_DIR}/resources.rc)
endif()

source_group(realm FILES ${SRC_REALM_PROJECT})

set(sources
   ${SRC_MANAGEMENT_FILES}
   ${SRC_CLIENTHANDLER_FILES}
   ${SRC_CLIENTMANAGER_FILES}
   ${SRC_CLUSTERMANAGER_FILES}
   ${SRC_LOGONCOMMSERVER_FILES}
   ${SRC_STORAGE_FILES}
   ${SRC_WORKERSERVER_FILES}
   ${SRC_SERVER_FILES}
   ${SRC_REALM_PROJECT}
   ${SRC_STORAGE_DBC_FILES}
   ${SRC_CHAT_FILES}
)

include_directories(
   ${CMAKE_CURRENT_SOURCE_DIR}/Opcodes
   ${CMAKE_SOURCE_DIR}/src/shared
   ${ZLIB_INCLUDE_DIRS}
   ${OPENSSL_INCLUDE_DIR}
   ${PCRE_INCLUDE_DIR}
   ${MYSQL_INCLUDE_DIR}
   ${CMAKE_CURRENT_SOURCE_DIR}
)

link_directories(${EXTRA_LIBS_PATH} ${DEPENDENCY_LIBS})

add_executable(${PROJECT_NAME} ${sources})

if(USE_PCH AND PCHSupport_FOUND)
    ADD_NATIVE_PRECOMPILED_HEADER(${PROJECT_NAME} RealmStdAfx.h ${CMAKE_CURRENT_SOURCE_DIR}/RealmStdAfx.cpp)
endif()

#Link our shared lib.
target_link_libraries(${PROJECT_NAME} shared ${MYSQL_LIBRARIES} ${ZLIB_LIBRARIES} ${PCRE_LIBRARIES})

#Provide make install rules.
install(TARGETS ${PROJECT_NAME} RUNTIME DESTINATION .)

unset(sources)
unset(headers)
