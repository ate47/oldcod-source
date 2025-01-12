#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_cooldown;

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x2
// Checksum 0x282cb769, Offset: 0xf0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_cooldown", &__init__, undefined, undefined);
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x0
// Checksum 0x2f50bb24, Offset: 0x138
// Size: 0x14
function __init__() {
    enable_cooldown_perk_for_level();
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x0
// Checksum 0x95604513, Offset: 0x158
// Size: 0xd4
function enable_cooldown_perk_for_level() {
    zm_perks::register_perk_clientfields(#"specialty_cooldown", &function_a86c1192, &function_850b6519);
    zm_perks::register_perk_effects(#"specialty_cooldown", "divetonuke_light");
    zm_perks::register_perk_init_thread(#"specialty_cooldown", &init_cooldown);
    zm_perks::function_32b099ec(#"specialty_cooldown", #"p8_zm_vapor_altar_icon_01_timeslip", "zombie/fx8_perk_altar_symbol_ambient_timeslip");
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x0
// Checksum 0x96c7a40, Offset: 0x238
// Size: 0x52
function init_cooldown() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect[#"divetonuke_light"] = #"hash_2225287695ddf9c9";
    }
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x0
// Checksum 0xb42ef6ba, Offset: 0x298
// Size: 0x3c
function function_a86c1192() {
    clientfield::register("clientuimodel", "hudItems.perks.cooldown", 1, 1, "int", undefined, 0, 1);
}

// Namespace zm_perk_cooldown/zm_perk_cooldown
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2e0
// Size: 0x4
function function_850b6519() {
    
}

