#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreak_vehicle;
#using scripts\killstreaks\ultimate_turret_shared;

#namespace ultimate_turret;

// Namespace ultimate_turret/ultimate_turret
// Params 0, eflags: 0x6
// Checksum 0xab65224e, Offset: 0xa0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"ultimate_turret", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace ultimate_turret/ultimate_turret
// Params 0, eflags: 0x5 linked
// Checksum 0xd676e8ac, Offset: 0xf0
// Size: 0x4c
function private function_70a657d8() {
    init_shared();
    bundle = getscriptbundle("killstreak_ultimate_turret");
    killstreak_vehicle::init_killstreak(bundle);
}

