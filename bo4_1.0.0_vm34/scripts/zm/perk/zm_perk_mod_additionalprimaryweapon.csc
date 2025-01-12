#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_additionalprimaryweapon;

// Namespace zm_perk_mod_additionalprimaryweapon/zm_perk_mod_additionalprimaryweapon
// Params 0, eflags: 0x2
// Checksum 0x4d1659c2, Offset: 0x90
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_additionalprimaryweapon", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_additionalprimaryweapon/zm_perk_mod_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0xb7bae6f7, Offset: 0xd8
// Size: 0x14
function __init__() {
    function_b843f161();
}

// Namespace zm_perk_mod_additionalprimaryweapon/zm_perk_mod_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0xad65f20d, Offset: 0xf8
// Size: 0x74
function function_b843f161() {
    zm_perks::register_perk_clientfields(#"specialty_mod_additionalprimaryweapon", &function_e8f0fd15, &function_54f4e710);
    zm_perks::register_perk_init_thread(#"specialty_mod_additionalprimaryweapon", &function_5c89c280);
}

// Namespace zm_perk_mod_additionalprimaryweapon/zm_perk_mod_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x178
// Size: 0x4
function function_5c89c280() {
    
}

// Namespace zm_perk_mod_additionalprimaryweapon/zm_perk_mod_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x188
// Size: 0x4
function function_e8f0fd15() {
    
}

// Namespace zm_perk_mod_additionalprimaryweapon/zm_perk_mod_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x198
// Size: 0x4
function function_54f4e710() {
    
}

