#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_mod_widows_wine;

// Namespace zm_perk_mod_widows_wine/zm_perk_mod_widows_wine
// Params 0, eflags: 0x2
// Checksum 0x4a9e101e, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_mod_widows_wine", &__init__, undefined, undefined);
}

// Namespace zm_perk_mod_widows_wine/zm_perk_mod_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x6e88cd65, Offset: 0xd0
// Size: 0x14
function __init__() {
    enable_widows_wine_perk_for_level();
}

// Namespace zm_perk_mod_widows_wine/zm_perk_mod_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x70663e04, Offset: 0xf0
// Size: 0x84
function enable_widows_wine_perk_for_level() {
    zm_perks::register_perk_mod_basic_info(#"specialty_mod_widowswine", "mod_widows_wine", #"specialty_widowswine", 4500);
    zm_perks::register_perk_threads(#"specialty_mod_widowswine", &widows_wine_perk_activate, &widows_wine_perk_lost);
}

// Namespace zm_perk_mod_widows_wine/zm_perk_mod_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x180
// Size: 0x4
function widows_wine_perk_activate() {
    
}

// Namespace zm_perk_mod_widows_wine/zm_perk_mod_widows_wine
// Params 3, eflags: 0x0
// Checksum 0x3843339f, Offset: 0x190
// Size: 0x2e
function widows_wine_perk_lost(b_pause, str_perk, str_result) {
    self notify(#"hash_4fa1f45a60444ddc");
}

