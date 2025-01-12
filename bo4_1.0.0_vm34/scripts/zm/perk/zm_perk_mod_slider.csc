#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_slider;

// Namespace zm_perk_mod_slider/zm_perk_mod_slider
// Params 0, eflags: 0x2
// Checksum 0x1870da69, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_slider", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_slider/zm_perk_mod_slider
// Params 0, eflags: 0x0
// Checksum 0xb31c758, Offset: 0xc0
// Size: 0x14
function __init__() {
    function_ea6c5013();
}

// Namespace zm_perk_mod_slider/zm_perk_mod_slider
// Params 0, eflags: 0x0
// Checksum 0x304f7e1, Offset: 0xe0
// Size: 0x74
function function_ea6c5013() {
    zm_perks::register_perk_clientfields(#"specialty_mod_phdflopper", &function_c0a30bfb, &function_67d0466e);
    zm_perks::register_perk_init_thread(#"specialty_mod_phdflopper", &function_4c135a4c);
}

// Namespace zm_perk_mod_slider/zm_perk_mod_slider
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x160
// Size: 0x4
function function_4c135a4c() {
    
}

// Namespace zm_perk_mod_slider/zm_perk_mod_slider
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x170
// Size: 0x4
function function_c0a30bfb() {
    
}

// Namespace zm_perk_mod_slider/zm_perk_mod_slider
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x180
// Size: 0x4
function function_67d0466e() {
    
}

