#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/proximity_grenade;
#using scripts/mp_common/util;

#namespace proximity_grenade;

// Namespace proximity_grenade/proximity_grenade
// Params 0, eflags: 0x2
// Checksum 0x18dad917, Offset: 0x1a0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "proximity_grenade", &__init__, undefined, undefined );
}

// Namespace proximity_grenade/proximity_grenade
// Params 0
// Checksum 0x4d35fa4, Offset: 0x1e0
// Size: 0x14
function __init__()
{
    init_shared();
}

