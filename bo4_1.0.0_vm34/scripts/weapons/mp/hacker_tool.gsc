#using scripts\core_common\system_shared;
#using scripts\weapons\hacker_tool;

#namespace hacker_tool;

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x2
// Checksum 0xb73c2a29, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hacker_tool", &__init__, undefined, undefined);
}

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x0
// Checksum 0x81cd9e47, Offset: 0xc0
// Size: 0x14
function __init__() {
    init_shared();
}
