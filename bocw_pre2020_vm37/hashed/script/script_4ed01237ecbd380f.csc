#using script_7e75c6a3429e6a90;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_4b9fccd8;

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 0, eflags: 0x6
// Checksum 0x52ce0bb9, Offset: 0x80
// Size: 0x4c
function private autoexec __init__system__() {
    system::register(#"hash_794c3bb2e36b3278", &function_70a657d8, &postinit, undefined, undefined);
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 0, eflags: 0x1 linked
// Checksum 0x651d2d41, Offset: 0xd8
// Size: 0x1c
function function_70a657d8() {
    level.var_2457162c = sr_weapon_upgrade_menu::register();
}

// Namespace namespace_4b9fccd8/namespace_4b9fccd8
// Params 0, eflags: 0x1 linked
// Checksum 0x80f724d1, Offset: 0x100
// Size: 0x4
function postinit() {
    
}

