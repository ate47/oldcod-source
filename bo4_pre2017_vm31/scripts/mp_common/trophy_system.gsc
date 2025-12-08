#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/weapons/trophy_system;
#using scripts/mp_common/util;

#namespace trophy_system;

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x2
// Checksum 0x2e77741a, Offset: 0x170
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "trophy_system", &__init__, undefined, undefined );
}

// Namespace trophy_system/trophy_system
// Params 0
// Checksum 0x3ddd0a65, Offset: 0x1b0
// Size: 0x14
function __init__()
{
    init_shared();
}

