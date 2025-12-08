#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/weapons/proximity_grenade;

#namespace proximity_grenade;

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x2
// Checksum 0x3112cc91, Offset: 0x160
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "proximity_grenade", &__init__, undefined, undefined );
}

// Namespace proximity_grenade/proximity_grenade
// Params 0
// Checksum 0xed2d62a, Offset: 0x1a0
// Size: 0x24
function __init__()
{
    init_shared();
    level.trackproximitygrenadesonowner = 1;
}

