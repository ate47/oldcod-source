#using script_1568a517f901b845;
#using scripts\core_common\system_shared;

#namespace napalm_strike;

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x6
// Checksum 0x62360511, Offset: 0x90
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"napalm_strike", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x5 linked
// Checksum 0x7461ffd4, Offset: 0xe0
// Size: 0x1c
function private function_70a657d8() {
    init_shared("killstreak_napalm_strike");
}

