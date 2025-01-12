#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_stronghold;

// Namespace zm_perk_mod_stronghold/zm_perk_mod_stronghold
// Params 0, eflags: 0x2
// Checksum 0x707f8ae3, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_stronghold", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_stronghold/zm_perk_mod_stronghold
// Params 0, eflags: 0x0
// Checksum 0xada956b2, Offset: 0xc0
// Size: 0x14
function __init__() {
    function_7520d4c();
}

// Namespace zm_perk_mod_stronghold/zm_perk_mod_stronghold
// Params 0, eflags: 0x0
// Checksum 0x1b7638c8, Offset: 0xe0
// Size: 0x74
function function_7520d4c() {
    zm_perks::register_perk_clientfields(#"specialty_mod_camper", &function_103eda7a, &function_1ba168c1);
    zm_perks::register_perk_init_thread(#"specialty_mod_camper", &function_c76509);
}

// Namespace zm_perk_mod_stronghold/zm_perk_mod_stronghold
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x160
// Size: 0x4
function function_c76509() {
    
}

// Namespace zm_perk_mod_stronghold/zm_perk_mod_stronghold
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x170
// Size: 0x4
function function_103eda7a() {
    
}

// Namespace zm_perk_mod_stronghold/zm_perk_mod_stronghold
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x180
// Size: 0x4
function function_1ba168c1() {
    
}

