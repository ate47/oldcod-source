#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/flashgrenades;
#using scripts/mp_common/util;

#namespace flashgrenades;

// Namespace flashgrenades/flashgrenades
// Params 0, eflags: 0x2
// Checksum 0xd3a6947e, Offset: 0x1a0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "flashgrenades", &__init__, undefined, undefined );
}

// Namespace flashgrenades/flashgrenades
// Params 1
// Checksum 0x20cdd9b1, Offset: 0x1e0
// Size: 0x1c
function __init__( localclientnum )
{
    init_shared();
}

