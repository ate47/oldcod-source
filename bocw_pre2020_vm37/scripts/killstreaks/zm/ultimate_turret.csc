#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreak_vehicle;
#using scripts\killstreaks\ultimate_turret_shared;

#namespace ultimate_turret;

// Namespace ultimate_turret/ultimate_turret
// Params 0, eflags: 0x6
// Checksum 0xc7f04f58, Offset: 0xa8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"ultimate_turret", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace ultimate_turret/ultimate_turret
// Params 0, eflags: 0x5 linked
// Checksum 0x14513e95, Offset: 0xf8
// Size: 0x4c
function private function_70a657d8() {
    init_shared();
    bundle = getscriptbundle("killstreak_ultimate_turret_zm");
    killstreak_vehicle::init_killstreak(bundle);
}

