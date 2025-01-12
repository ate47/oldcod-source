#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_additionalprimaryweapon;

// Namespace zm_perk_mod_additionalprimaryweapon/zm_perk_mod_additionalprimaryweapon
// Params 0, eflags: 0x2
// Checksum 0x7ff19905, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_additionalprimaryweapon", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_additionalprimaryweapon/zm_perk_mod_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x89ce2f48, Offset: 0xe0
// Size: 0x14
function __init__() {
    enable_additional_primary_weapon_perk_for_level();
}

// Namespace zm_perk_mod_additionalprimaryweapon/zm_perk_mod_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0xd4096d69, Offset: 0x100
// Size: 0xc4
function enable_additional_primary_weapon_perk_for_level() {
    zm_perks::register_perk_mod_basic_info(#"specialty_mod_additionalprimaryweapon", "mod_additionalprimaryweapon", #"specialty_additionalprimaryweapon", 5000);
    zm_perks::register_perk_threads(#"specialty_mod_additionalprimaryweapon", &function_8ca4d634, &function_327a5aee);
    zm_perks::function_b769b7fb(#"specialty_mod_additionalprimaryweapon", array(#"specialty_fastweaponswitch"));
}

// Namespace zm_perk_mod_additionalprimaryweapon/zm_perk_mod_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x465c34a1, Offset: 0x1d0
// Size: 0x12
function function_8ca4d634() {
    self.var_2bd7c22 = 1;
}

// Namespace zm_perk_mod_additionalprimaryweapon/zm_perk_mod_additionalprimaryweapon
// Params 3, eflags: 0x0
// Checksum 0x692451a3, Offset: 0x1f0
// Size: 0x1c
function function_327a5aee(b_pause, str_perk, str_result) {
    
}

