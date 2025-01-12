#using script_36e0a146280ae23a;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_1cc7b406;

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 0, eflags: 0x6
// Checksum 0xb52dee9b, Offset: 0x80
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_49e3cc2797ad6fbc", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 0, eflags: 0x1 linked
// Checksum 0xcfcb06a0, Offset: 0xd8
// Size: 0x1c
function function_70a657d8() {
    level.var_3ed9fd33 = sr_crafting_table_menu::register();
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x100
// Size: 0x4
function postinit() {
    
}

