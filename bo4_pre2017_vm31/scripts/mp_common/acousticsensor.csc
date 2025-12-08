#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/acousticsensor;
#using scripts/mp_common/util;

#namespace acousticsensor;

// Namespace acousticsensor/acousticsensor
// Params 0, eflags: 0x2
// Checksum 0x3857bd2a, Offset: 0x168
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "acousticsensor", &__init__, undefined, undefined );
}

// Namespace acousticsensor/acousticsensor
// Params 0
// Checksum 0x50441954, Offset: 0x1a8
// Size: 0x14
function __init__()
{
    init_shared();
}

