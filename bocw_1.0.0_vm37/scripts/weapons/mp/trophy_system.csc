#using scripts\core_common\system_shared;
#using scripts\weapons\trophy_system;

#namespace trophy_system;

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x6
// Checksum 0xbe56f5cc, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"trophy_system", &preinit, undefined, undefined, undefined);
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x4
// Checksum 0xa0c3f4d0, Offset: 0xb8
// Size: 0x14
function private preinit() {
    init_shared();
}

