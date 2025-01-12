#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_staminup;

// Namespace zm_perk_mod_staminup/zm_perk_mod_staminup
// Params 0, eflags: 0x2
// Checksum 0x5df30985, Offset: 0x90
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_staminup", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_staminup/zm_perk_mod_staminup
// Params 0, eflags: 0x0
// Checksum 0x9f4ecac2, Offset: 0xd8
// Size: 0x14
function __init__() {
    enable_mod_staminup_perk_for_level();
}

// Namespace zm_perk_mod_staminup/zm_perk_mod_staminup
// Params 0, eflags: 0x0
// Checksum 0x8632bf32, Offset: 0xf8
// Size: 0x74
function enable_mod_staminup_perk_for_level() {
    zm_perks::register_perk_clientfields(#"specialty_mod_staminup", &function_f0dcc1d3, &function_40730730);
    zm_perks::register_perk_init_thread(#"specialty_mod_staminup", &function_421863c4);
}

// Namespace zm_perk_mod_staminup/zm_perk_mod_staminup
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x178
// Size: 0x4
function function_421863c4() {
    
}

// Namespace zm_perk_mod_staminup/zm_perk_mod_staminup
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x188
// Size: 0x4
function function_f0dcc1d3() {
    
}

// Namespace zm_perk_mod_staminup/zm_perk_mod_staminup
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x198
// Size: 0x4
function function_40730730() {
    
}

