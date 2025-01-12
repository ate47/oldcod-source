#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_cooldown;

// Namespace zm_perk_mod_cooldown/zm_perk_mod_cooldown
// Params 0, eflags: 0x2
// Checksum 0x28e50a31, Offset: 0x88
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_cooldown", &__init__, &__main__, undefined);
}

// Namespace zm_perk_mod_cooldown/zm_perk_mod_cooldown
// Params 0, eflags: 0x0
// Checksum 0x8724a242, Offset: 0xd8
// Size: 0x14
function __init__() {
    function_e6a7c087();
}

// Namespace zm_perk_mod_cooldown/zm_perk_mod_cooldown
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xf8
// Size: 0x4
function __main__() {
    
}

// Namespace zm_perk_mod_cooldown/zm_perk_mod_cooldown
// Params 0, eflags: 0x0
// Checksum 0x19a55ec, Offset: 0x108
// Size: 0x84
function function_e6a7c087() {
    zm_perks::register_perk_mod_basic_info(#"specialty_mod_cooldown", "mod_cooldown", #"specialty_cooldown", 3500);
    zm_perks::register_perk_threads(#"specialty_mod_cooldown", &function_3c70a03a, &function_d58bbacc);
}

// Namespace zm_perk_mod_cooldown/zm_perk_mod_cooldown
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x198
// Size: 0x4
function function_3c70a03a() {
    
}

// Namespace zm_perk_mod_cooldown/zm_perk_mod_cooldown
// Params 3, eflags: 0x0
// Checksum 0x661c6ee9, Offset: 0x1a8
// Size: 0x1c
function function_d58bbacc(b_pause, str_perk, str_result) {
    
}

