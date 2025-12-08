#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/trophy_system;
#using scripts/mp_common/util;

#namespace trophy_system;

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x2
// Checksum 0xab4634c2, Offset: 0x190
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "trophy_system", &__init__, undefined, undefined );
}

// Namespace trophy_system/trophy_system
// Params 1
// Checksum 0x1f2f7d66, Offset: 0x1d0
// Size: 0x1c
function __init__( localclientnum )
{
    init_shared();
}

