#using scripts\core_common\battlechatter;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\system_shared;
#using scripts\weapons\trophy_system;

#namespace trophy_system;

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x6
// Checksum 0xbe56f5cc, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"trophy_system", &preinit, undefined, undefined, undefined);
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x4
// Checksum 0x6fe2c1f3, Offset: 0xc8
// Size: 0x34
function private preinit() {
    init_shared();
    function_720ddf7f(&function_ccfcde75);
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0x57fd9868, Offset: 0x108
// Size: 0x5c
function function_ccfcde75(trophy, grenade) {
    self battlechatter::function_fc82b10(trophy.weapon, grenade.origin, trophy);
    self contracts::increment_contract(#"hash_369e3fd5caa5145b");
}

