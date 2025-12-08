#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/tacticalinsertion;
#using scripts/mp_common/util;

#namespace tacticalinsertion;

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x2
// Checksum 0x93e20395, Offset: 0x178
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "tacticalinsertion", &__init__, undefined, undefined );
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 0
// Checksum 0x87ec0fc3, Offset: 0x1b8
// Size: 0x14
function __init__()
{
    init_shared();
}

