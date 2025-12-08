#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/hacker_tool;

#namespace hacker_tool;

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x2
// Checksum 0xc5b1cb3b, Offset: 0x148
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "hacker_tool", &__init__, undefined, undefined );
}

// Namespace hacker_tool/hacker_tool
// Params 0
// Checksum 0xb95e372e, Offset: 0x188
// Size: 0x14
function __init__()
{
    init_shared();
}

