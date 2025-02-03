#using scripts\core_common\system_shared;

#namespace teamset;

// Namespace teamset/teamset
// Params 0, eflags: 0x6
// Checksum 0xff9bea13, Offset: 0x68
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"teamset_seals", &preinit, undefined, undefined, undefined);
}

// Namespace teamset/teamset
// Params 0, eflags: 0x4
// Checksum 0x92da331f, Offset: 0xb0
// Size: 0x34
function private preinit() {
    level.allies_team = #"allies";
    level.axis_team = #"axis";
}

