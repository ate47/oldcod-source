#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/decoy;
#using scripts/mp_common/util;

#namespace decoy;

// Namespace decoy/decoy
// Params 0, eflags: 0x2
// Checksum 0x46f0c2eb, Offset: 0x150
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "decoy", &__init__, undefined, undefined );
}

// Namespace decoy/decoy
// Params 0
// Checksum 0x8e3f2203, Offset: 0x190
// Size: 0x14
function __init__()
{
    init_shared();
}

