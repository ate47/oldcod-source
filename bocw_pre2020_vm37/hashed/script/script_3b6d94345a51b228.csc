#using script_2f272fb57a31d81c;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreak_vehicle;

#namespace missile_turret;

// Namespace missile_turret/missile_turret
// Params 0, eflags: 0x6
// Checksum 0x439053e2, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"missile_turret", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace missile_turret/missile_turret
// Params 0, eflags: 0x5 linked
// Checksum 0x586eead9, Offset: 0xe8
// Size: 0x4c
function private function_70a657d8() {
    init_shared();
    bundle = getscriptbundle("killstreak_missile_turret");
    killstreak_vehicle::init_killstreak(bundle);
}

