#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\mp\killstreak_vehicle;
#using scripts\killstreaks\ultimate_turret_shared;

#namespace ultimate_turret;

// Namespace ultimate_turret/ultimate_turret
// Params 0, eflags: 0x2
// Checksum 0x59496002, Offset: 0xb0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"ultimate_turret", &__init__, undefined, #"killstreaks");
}

// Namespace ultimate_turret/ultimate_turret
// Params 0, eflags: 0x0
// Checksum 0x617a49e9, Offset: 0x100
// Size: 0x54
function __init__() {
    init_shared();
    bundle = struct::get_script_bundle("killstreak", "killstreak_ultimate_turret");
    killstreak_vehicle::init_killstreak(bundle);
}

