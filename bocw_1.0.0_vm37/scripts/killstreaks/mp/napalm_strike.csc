#using script_1568a517f901b845;
#using scripts\core_common\system_shared;

#namespace napalm_strike;

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x6
// Checksum 0x20b4b468, Offset: 0x90
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"napalm_strike", &preinit, undefined, undefined, #"killstreaks");
}

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x4
// Checksum 0x5eeecfd6, Offset: 0xe0
// Size: 0x1c
function private preinit() {
    init_shared("killstreak_napalm_strike");
}

