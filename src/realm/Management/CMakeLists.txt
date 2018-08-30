# Copyright (C) 2014-2016 AscEmu Team <http://www.ascemu.org>

set(PATH_PREFIX Management)

set(SRC_MANAGEMENT_FILES
   ${PATH_PREFIX}/AddonMgr.cpp
   ${PATH_PREFIX}/AddonMgr.h
)

source_group(Management FILES ${SRC_MANAGEMENT_FILES})
unset(PATH_PREFIX)
