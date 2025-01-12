#using scripts\core_common\clientfield_shared;
#using scripts\killstreaks\killstreak_hacking;

#namespace killstreak_detect;

// Namespace killstreak_detect/killstreak_detect
// Params 0, eflags: 0x0
// Checksum 0xbdc7e8f8, Offset: 0xc0
// Size: 0x114
function init_shared() {
    if (!isdefined(level.var_95c59289)) {
        level.var_95c59289 = {};
        clientfield::register("vehicle", "enemyvehicle", 1, 2, "int");
        clientfield::register("scriptmover", "enemyvehicle", 1, 2, "int");
        clientfield::register("missile", "enemyvehicle", 1, 2, "int");
        clientfield::register("actor", "enemyvehicle", 1, 2, "int");
        clientfield::register("vehicle", "vehicletransition", 1, 1, "int");
    }
}

// Namespace killstreak_detect/killstreak_detect
// Params 2, eflags: 0x0
// Checksum 0xee045e96, Offset: 0x1e0
// Size: 0x5c
function killstreaktargetset(killstreakentity, offset = (0, 0, 0)) {
    target_set(killstreakentity, offset);
    /#
        killstreakentity thread killstreak_hacking::killstreak_switch_team(killstreakentity.owner);
    #/
}

// Namespace killstreak_detect/killstreak_detect
// Params 1, eflags: 0x0
// Checksum 0xb099db7, Offset: 0x248
// Size: 0x3c
function killstreaktargetclear(killstreakentity) {
    target_remove(killstreakentity);
    /#
        killstreakentity thread killstreak_hacking::killstreak_switch_team_end();
    #/
}

