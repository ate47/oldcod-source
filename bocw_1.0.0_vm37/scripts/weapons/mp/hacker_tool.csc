#using scripts\core_common\system_shared;
#using scripts\weapons\hacker_tool;

#namespace hacker_tool;

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x6
// Checksum 0x294dd207, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hacker_tool", &preinit, undefined, undefined, undefined);
}

// Namespace hacker_tool/hacker_tool
// Params 0, eflags: 0x4
// Checksum 0xa0c3f4d0, Offset: 0xb8
// Size: 0x14
function private preinit() {
    init_shared();
}

