#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/weapons/satchel_charge;
#using scripts/mp_common/util;

#namespace satchel_charge;

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x2
// Checksum 0xeb38bb89, Offset: 0x148
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "satchel_charge", &__init__, undefined, undefined );
}

// Namespace satchel_charge/satchel_charge
// Params 0
// Checksum 0xa863e54d, Offset: 0x188
// Size: 0x14
function __init__()
{
    init_shared();
}

