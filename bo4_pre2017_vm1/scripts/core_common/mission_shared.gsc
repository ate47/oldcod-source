#using scripts/core_common/clientfield_shared;
#using scripts/core_common/serverfield_shared;
#using scripts/core_common/system_shared;

#namespace mission_utils;

// Namespace mission_utils/mission_shared
// Params 0, eflags: 0x2
// Checksum 0xc58a7475, Offset: 0x128
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("mission", &__init__, undefined, undefined);
}

// Namespace mission_utils/mission_shared
// Params 0, eflags: 0x0
// Checksum 0xb589da6b, Offset: 0x168
// Size: 0x34
function __init__() {
    clientfield::register("world", "mission_active_flags", 1, 8, "int");
}

// Namespace mission_utils/mission_shared
// Params 1, eflags: 0x0
// Checksum 0x62e9b5e1, Offset: 0x1a8
// Size: 0x8c
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
// Checksum 0x69eb5adc, Offset: 0x240
// Size: 0xfc
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

