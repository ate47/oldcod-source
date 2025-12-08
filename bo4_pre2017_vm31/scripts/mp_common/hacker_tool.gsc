#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/hacker_tool;
#using scripts/mp_common/util;

#namespace hacker_tool;

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x2
// Checksum 0xd758625e, Offset: 0x160
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "hacker_tool", &__init__, undefined, undefined );
}

// Namespace hacker_tool/hacker_tool
// Params 0
// Checksum 0xa673f981, Offset: 0x1a0
// Size: 0x14
function __init__()
{
    init_shared();
}

