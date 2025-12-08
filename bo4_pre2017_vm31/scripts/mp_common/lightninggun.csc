#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/lightninggun;
#using scripts/mp_common/util;

#namespace lightninggun;

// Namespace lightninggun/lightninggun
// Params 0, eflags: 0x2
// Checksum 0x962aa318, Offset: 0x190
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "lightninggun", &__init__, undefined, undefined );
}

// Namespace lightninggun/lightninggun
// Params 0
// Checksum 0xac453e80, Offset: 0x1d0
// Size: 0x14
function __init__()
{
    init_shared();
}

