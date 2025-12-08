#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/weapons/flashgrenades;
#using scripts/mp_common/util;

#namespace flashgrenades;

// Namespace flashgrenades/flashgrenades
// Params 0, eflags: 0x2
// Checksum 0x176df586, Offset: 0x148
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "flashgrenades", &__init__, undefined, undefined );
}

// Namespace flashgrenades/flashgrenades
// Params 0
// Checksum 0xc3cd4b7, Offset: 0x188
// Size: 0x14
function __init__()
{
    init_shared();
}

