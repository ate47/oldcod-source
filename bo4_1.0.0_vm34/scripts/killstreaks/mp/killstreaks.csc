#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\mp\killstreak_vehicle;

#namespace killstreaks;

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x2
// Checksum 0x60011ab4, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"killstreaks", &__init__, undefined, undefined);
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x0
// Checksum 0xc142532e, Offset: 0xc8
// Size: 0x24
function __init__() {
    init_shared();
    killstreak_vehicle::init();
}

