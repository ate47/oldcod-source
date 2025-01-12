#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_dying_wish;

// Namespace zm_perk_mod_dying_wish/zm_perk_mod_dying_wish
// Params 0, eflags: 0x2
// Checksum 0xe143a9ce, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_dying_wish", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_dying_wish/zm_perk_mod_dying_wish
// Params 0, eflags: 0x0
// Checksum 0xed236834, Offset: 0xc0
// Size: 0x14
function __init__() {
    function_b343727f();
}

// Namespace zm_perk_mod_dying_wish/zm_perk_mod_dying_wish
// Params 0, eflags: 0x0
// Checksum 0xf4200668, Offset: 0xe0
// Size: 0x74
function function_b343727f() {
    zm_perks::register_perk_clientfields(#"specialty_mod_berserker", &function_8e9b9953, &function_87fbea26);
    zm_perks::register_perk_init_thread(#"specialty_mod_berserker", &function_fd566cb4);
}

// Namespace zm_perk_mod_dying_wish/zm_perk_mod_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x160
// Size: 0x4
function function_fd566cb4() {
    
}

// Namespace zm_perk_mod_dying_wish/zm_perk_mod_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x170
// Size: 0x4
function function_8e9b9953() {
    
}

// Namespace zm_perk_mod_dying_wish/zm_perk_mod_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x180
// Size: 0x4
function function_87fbea26() {
    
}

