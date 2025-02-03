#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreak_hacking;

#namespace killstreak_detect;

// Namespace killstreak_detect/killstreak_detect
// Params 0, eflags: 0x6
// Checksum 0x1bb8d309, Offset: 0xd8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"killstreak_detect", &init_shared, undefined, undefined, undefined);
}

// Namespace killstreak_detect/killstreak_detect
// Params 0, eflags: 0x0
// Checksum 0x12e13e03, Offset: 0x120
// Size: 0x114
function init_shared() {
    if (!isdefined(level.var_c3f91417)) {
        level.var_c3f91417 = {};
        clientfield::register("vehicle", "enemyvehicle", 1, 2, "int");
        clientfield::register("scriptmover", "enemyvehicle", 1, 2, "int");
        clientfield::register("missile", "enemyvehicle", 1, 2, "int");
        clientfield::register("actor", "enemyvehicle", 1, 2, "int");
        clientfield::register("vehicle", "vehicletransition", 1, 1, "int");
    }
}

// Namespace killstreak_detect/killstreak_detect
// Params 2, eflags: 0x0
// Checksum 0x179c5fd, Offset: 0x240
// Size: 0x5c
function killstreaktargetset(killstreakentity, offset = (0, 0, 0)) {
    target_set(killstreakentity, offset);
    /#
        killstreakentity thread killstreak_hacking::killstreak_switch_team(killstreakentity.owner);
    #/
}

// Namespace killstreak_detect/killstreak_detect
// Params 1, eflags: 0x0
// Checksum 0x5de6907, Offset: 0x2a8
// Size: 0x3c
function killstreaktargetclear(killstreakentity) {
    target_remove(killstreakentity);
    /#
        killstreakentity thread killstreak_hacking::killstreak_switch_team_end();
    #/
}

