#using scripts/core_common/callbacks_shared;
#using scripts/core_common/entityheadicons_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace entityheadicons;

// Namespace entityheadicons/entityheadicons
// Params 0, eflags: 0x2
// Checksum 0xe4b8f92d, Offset: 0x150
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "entityheadicons", &__init__, undefined, undefined );
}

// Namespace entityheadicons/entityheadicons
// Params 0
// Checksum 0x46b1c013, Offset: 0x190
// Size: 0x14
function __init__()
{
    init_shared();
}

