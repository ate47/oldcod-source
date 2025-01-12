#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_quick_revive;

// Namespace zm_perk_mod_quick_revive/zm_perk_mod_quick_revive
// Params 0, eflags: 0x2
// Checksum 0xa88eb5d6, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_quick_revive", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_quick_revive/zm_perk_mod_quick_revive
// Params 0, eflags: 0x0
// Checksum 0x96d171a2, Offset: 0xc8
// Size: 0x14
function __init__() {
    enable_quick_revive_perk_for_level();
}

// Namespace zm_perk_mod_quick_revive/zm_perk_mod_quick_revive
// Params 0, eflags: 0x0
// Checksum 0xea63e69d, Offset: 0xe8
// Size: 0x44
function enable_quick_revive_perk_for_level() {
    zm_perks::register_perk_clientfields(#"specialty_mod_quickrevive", &quick_revive_client_field_func, &quick_revive_callback_func);
}

// Namespace zm_perk_mod_quick_revive/zm_perk_mod_quick_revive
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x138
// Size: 0x4
function quick_revive_client_field_func() {
    
}

// Namespace zm_perk_mod_quick_revive/zm_perk_mod_quick_revive
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x148
// Size: 0x4
function quick_revive_callback_func() {
    
}

