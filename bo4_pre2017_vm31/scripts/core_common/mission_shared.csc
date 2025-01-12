#using scripts/core_common/clientfield_shared;
#using scripts/core_common/serverfield_shared;
#using scripts/core_common/system_shared;

#namespace mission_utils;

// Namespace mission_utils/mission_shared
// Params 0, eflags: 0x2
// Checksum 0x6eafe50b, Offset: 0x128
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("mission", &__init__, undefined, undefined);
}

// Namespace mission_utils/mission_shared
// Params 0, eflags: 0x0
// Checksum 0xfdfeab22, Offset: 0x168
// Size: 0x4c
function __init__() {
    clientfield::register("world", "mission_active_flags", 1, 8, "int", &mission_active_changed, 0, 0);
}

// Namespace mission_utils/mission_shared
// Params 7, eflags: 0x0
// Checksum 0x2351dac0, Offset: 0x1c0
// Size: 0x190
function mission_active_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(level.mission_active_flags)) {
        level.mission_active_flags = 0;
    }
    for (i = 0; i < 8; i++) {
        changedflags = level.mission_active_flags ^ newval;
        if ((changedflags & 1 << i) != 0) {
            if ((level.mission_active_flags & 1 << i) != 0) {
                stopmission(i);
            }
        }
    }
    for (i = 0; i < 8; i++) {
        changedflags = level.mission_active_flags ^ newval;
        if ((changedflags & 1 << i) != 0) {
            if ((level.mission_active_flags & 1 << i) == 0) {
                startmission(i);
            }
        }
    }
    level.mission_active_flags = newval;
}

