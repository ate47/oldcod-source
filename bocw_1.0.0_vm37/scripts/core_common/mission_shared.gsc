#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace mission_utils;

// Namespace mission_utils/mission_shared
// Params 0, eflags: 0x6
// Checksum 0x6e931a2f, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"mission", &preinit, undefined, undefined, undefined);
}

// Namespace mission_utils/mission_shared
// Params 0, eflags: 0x4
// Checksum 0x72497b9e, Offset: 0xe0
// Size: 0x34
function private preinit() {
    clientfield::register("world", "mission_active_flags", 1, 8, "int");
}

// Namespace mission_utils/mission_shared
// Params 1, eflags: 0x0
// Checksum 0x131e44b5, Offset: 0x120
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
// Checksum 0x8aae2079, Offset: 0x1b0
// Size: 0xe4
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

