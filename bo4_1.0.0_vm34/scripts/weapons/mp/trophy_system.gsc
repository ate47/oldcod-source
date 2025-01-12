#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\battlechatter;
#using scripts\weapons\trophy_system;

#namespace trophy_system;

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x2
// Checksum 0xb6c6b906, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"trophy_system", &__init__, undefined, undefined);
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0xf500d0fd, Offset: 0xc8
// Size: 0x34
function __init__() {
    init_shared();
    function_9a915f37(&function_9ec5a315);
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0x69a4546f, Offset: 0x108
// Size: 0x4c
function function_9ec5a315(trophy, grenade) {
    self battlechatter::function_b505bc94(trophy.weapon, grenade.owner, grenade.origin, trophy);
}

