#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/weapons/lightninggun;

#namespace lightninggun;

// Namespace lightninggun/lightninggun
// Params 0, eflags: 0x2
// Checksum 0x89dd2e07, Offset: 0x150
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "lightninggun", &__init__, undefined, undefined );
}

// Namespace lightninggun/lightninggun
// Params 0
// Checksum 0xbc869895, Offset: 0x190
// Size: 0x14
function __init__()
{
    init_shared();
}

