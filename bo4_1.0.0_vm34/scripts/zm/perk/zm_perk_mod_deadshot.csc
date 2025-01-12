#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_deadshot;

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 0, eflags: 0x2
// Checksum 0x814a81ec, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_deadshot", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 0, eflags: 0x0
// Checksum 0x6a22e399, Offset: 0xe0
// Size: 0x14
function __init__() {
    enable_mod_deadshot_perk_for_level();
}

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 0, eflags: 0x0
// Checksum 0xcb87ddd4, Offset: 0x100
// Size: 0x74
function enable_mod_deadshot_perk_for_level() {
    zm_perks::register_perk_clientfields(#"specialty_mod_deadshot", &function_3c084474, &function_8c655b33);
    zm_perks::register_perk_init_thread(#"specialty_mod_deadshot", &function_6b6bf477);
}

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x180
// Size: 0x4
function function_6b6bf477() {
    
}

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x190
// Size: 0x4
function function_3c084474() {
    
}

// Namespace zm_perk_mod_deadshot/zm_perk_mod_deadshot
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x1a0
// Size: 0x4
function function_8c655b33() {
    
}

