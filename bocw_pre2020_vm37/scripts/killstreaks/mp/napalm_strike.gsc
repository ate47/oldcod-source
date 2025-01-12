#using script_7475f917e6d3bed9;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace napalm_strike;

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x6
// Checksum 0x62360511, Offset: 0x98
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"napalm_strike", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace napalm_strike/napalm_strike
// Params 0, eflags: 0x5 linked
// Checksum 0x7461ffd4, Offset: 0xe8
// Size: 0x1c
function private function_70a657d8() {
    init_shared("killstreak_napalm_strike");
}

