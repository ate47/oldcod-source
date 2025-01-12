#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_staminup;

// Namespace zm_perk_mod_staminup/zm_perk_mod_staminup
// Params 0, eflags: 0x2
// Checksum 0x4d85c053, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_staminup", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_staminup/zm_perk_mod_staminup
// Params 0, eflags: 0x0
// Checksum 0xf2b6225a, Offset: 0xd0
// Size: 0x14
function __init__() {
    enable_mod_staminup_perk_for_level();
}

// Namespace zm_perk_mod_staminup/zm_perk_mod_staminup
// Params 0, eflags: 0x0
// Checksum 0xf8299ca, Offset: 0xf0
// Size: 0x94
function enable_mod_staminup_perk_for_level() {
    zm_perks::register_perk_mod_basic_info(#"specialty_mod_staminup", "mod_marathon", #"specialty_staminup", 2500);
    zm_perks::function_b769b7fb(#"specialty_mod_staminup", array(#"specialty_unlimitedsprint", #"specialty_sprintfire"));
}

