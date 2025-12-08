#using scripts/core_common/bb_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace bb;

// Namespace bb/bb
// Params 0, eflags: 0x2
// Checksum 0x6f1ecdcd, Offset: 0x108
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "bb", &__init__, undefined, undefined );
}

// Namespace bb/bb
// Params 0
// Checksum 0xe5444e2d, Offset: 0x148
// Size: 0x14
function __init__()
{
    init_shared();
}

