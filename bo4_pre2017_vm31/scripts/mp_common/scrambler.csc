#using scripts/core_common/clientfield_shared;
#using scripts/core_common/fx_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/scrambler;
#using scripts/mp_common/util;

#namespace scrambler;

// Namespace scrambler/scrambler
// Params 0, eflags: 0x2
// Checksum 0xc0ec2bd7, Offset: 0x180
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "scrambler", &__init__, undefined, undefined );
}

// Namespace scrambler/scrambler
// Params 0
// Checksum 0x8017eca, Offset: 0x1c0
// Size: 0x14
function __init__()
{
    init_shared();
}

