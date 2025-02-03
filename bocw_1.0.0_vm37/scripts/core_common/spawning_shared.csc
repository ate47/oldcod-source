#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace spawning;

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x6
// Checksum 0xab02d279, Offset: 0x78
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"spawning_shared", &preinit, undefined, undefined, undefined);
}

// Namespace spawning/spawning_shared
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0xc0
// Size: 0x4
function private preinit() {
    
}

