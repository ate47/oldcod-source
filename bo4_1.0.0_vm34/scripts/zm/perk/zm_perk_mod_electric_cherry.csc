#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_electric_cherry;

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x2
// Checksum 0x290197db, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_electric_cherry", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0xc8044789, Offset: 0xc0
// Size: 0x74
function __init__() {
    zm_perks::register_perk_clientfields(#"specialty_mod_electriccherry", &function_80593d09, &function_31354254);
    zm_perks::register_perk_init_thread(#"specialty_mod_electriccherry", &function_945ff12c);
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x140
// Size: 0x4
function function_945ff12c() {
    
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x150
// Size: 0x4
function function_80593d09() {
    
}

// Namespace zm_perk_mod_electric_cherry/zm_perk_mod_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x160
// Size: 0x4
function function_31354254() {
    
}

