#using script_3f2bc2eef03cbecc;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_dd7e54e3;

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 0, eflags: 0x6
// Checksum 0xad5d8002, Offset: 0x80
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_7da9887a9375293", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 0, eflags: 0x1 linked
// Checksum 0xa2156a33, Offset: 0xd8
// Size: 0x1c
function function_70a657d8() {
    level.var_2a994cc0 = sr_armor_menu::register();
}

// Namespace namespace_dd7e54e3/namespace_dd7e54e3
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x100
// Size: 0x4
function postinit() {
    
}

