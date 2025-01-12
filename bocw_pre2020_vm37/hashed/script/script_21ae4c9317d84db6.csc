#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace ray_gun;

// Namespace ray_gun/namespace_b7964db5
// Params 0, eflags: 0x6
// Checksum 0xc77434f6, Offset: 0x78
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"ray_gun", &__init__, undefined, undefined, #"killstreaks");
}

// Namespace ray_gun/namespace_b7964db5
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xc8
// Size: 0x4
function __init__() {
    
}

