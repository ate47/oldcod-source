#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_dying_wish;

// Namespace zm_perk_mod_dying_wish/zm_perk_mod_dying_wish
// Params 0, eflags: 0x2
// Checksum 0x9ea574e8, Offset: 0x88
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_dying_wish", &__init__, &__main__, undefined);
}

// Namespace zm_perk_mod_dying_wish/zm_perk_mod_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x29caba01, Offset: 0xd8
// Size: 0x14
function __init__() {
    function_b343727f();
}

// Namespace zm_perk_mod_dying_wish/zm_perk_mod_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xf8
// Size: 0x4
function __main__() {
    
}

// Namespace zm_perk_mod_dying_wish/zm_perk_mod_dying_wish
// Params 0, eflags: 0x0
// Checksum 0xec933fbd, Offset: 0x108
// Size: 0x84
function function_b343727f() {
    zm_perks::register_perk_mod_basic_info(#"specialty_mod_berserker", "mod_dying_wish", #"specialty_berserker", 5000);
    zm_perks::register_perk_threads(#"specialty_mod_berserker", &function_d0ee2f1e, &function_e2a61394);
}

// Namespace zm_perk_mod_dying_wish/zm_perk_mod_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x198
// Size: 0x4
function function_d0ee2f1e() {
    
}

// Namespace zm_perk_mod_dying_wish/zm_perk_mod_dying_wish
// Params 3, eflags: 0x0
// Checksum 0xfad87600, Offset: 0x1a8
// Size: 0x1c
function function_e2a61394(b_pause, str_perk, str_result) {
    
}

