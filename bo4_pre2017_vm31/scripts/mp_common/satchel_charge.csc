#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/satchel_charge;
#using scripts/mp_common/util;

#namespace satchel_charge;

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x2
// Checksum 0xa824c9a6, Offset: 0x168
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "satchel_charge", &__init__, undefined, undefined );
}

// Namespace satchel_charge/satchel_charge
// Params 1
// Checksum 0x9e747b93, Offset: 0x1a8
// Size: 0x1c
function __init__( localclientnum )
{
    init_shared();
}

