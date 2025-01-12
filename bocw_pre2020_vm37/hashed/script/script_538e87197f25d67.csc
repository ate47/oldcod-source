#using script_34c3e29c2c0c97ef;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_82b4c2d1;

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 0, eflags: 0x6
// Checksum 0xcc76889a, Offset: 0x80
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_79fe34c9f8a0e44c", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 0, eflags: 0x1 linked
// Checksum 0x482df0a0, Offset: 0xd8
// Size: 0x1c
function function_70a657d8() {
    level.var_5df76d0 = sr_perk_machine_choice::register();
}

// Namespace namespace_82b4c2d1/namespace_82b4c2d1
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x100
// Size: 0x4
function postinit() {
    
}

