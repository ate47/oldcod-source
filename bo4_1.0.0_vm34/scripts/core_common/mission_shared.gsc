#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace mission_utils;

// Namespace mission_utils/mission_shared
// Params 0, eflags: 0x2
// Checksum 0xcf7529bd, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"mission", &__init__, undefined, undefined);
}

// Namespace mission_utils/mission_shared
// Params 0, eflags: 0x0
// Checksum 0x3ac99b2d, Offset: 0xe0
// Size: 0x34
function __init__() {
    clientfield::register("world", "mission_active_flags", 1, 8, "int");
}

// Namespace mission_utils/mission_shared
// Params 1, eflags: 0x0
// Checksum 0x2a876b43, Offset: 0x120
// Size: 0x84
function start(mission_index) {
    if (!isdefined(level.mission_active_flags)) {
        level.mission_active_flags = 0;
    }
    level.mission_active_flags |= 1 << mission_index;
    clientfield::set("mission_active_flags", level.mission_active_flags);
    startmission(mission_index);
}

// Namespace mission_utils/mission_shared
// Params 1, eflags: 0x0
// Checksum 0x232cecb3, Offset: 0x1b0
// Size: 0xec
function stop(mission_index) {
    if (!isdefined(level.mission_active_flags)) {
        level.mission_active_flags = 0;
        return;
    }
    if (!isdefined(mission_index)) {
        for (i = 0; i < 8; i++) {
            stop(i);
        }
        return;
    }
    if ((level.mission_active_flags & 1 << mission_index) != 0) {
        level.mission_active_flags &= ~(1 << mission_index);
        clientfield::set("mission_active_flags", level.mission_active_flags);
        stopmission(mission_index);
    }
}

