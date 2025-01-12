#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_quick_revive;

// Namespace zm_perk_quick_revive/zm_perk_quick_revive
// Params 0, eflags: 0x2
// Checksum 0x2561edb0, Offset: 0x100
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_quick_revive", &__init__, undefined, undefined);
}

// Namespace zm_perk_quick_revive/zm_perk_quick_revive
// Params 0, eflags: 0x0
// Checksum 0x45acc403, Offset: 0x148
// Size: 0x14
function __init__() {
    enable_quick_revive_perk_for_level();
}

// Namespace zm_perk_quick_revive/zm_perk_quick_revive
// Params 0, eflags: 0x0
// Checksum 0xd05c804, Offset: 0x168
// Size: 0xd4
function enable_quick_revive_perk_for_level() {
    zm_perks::register_perk_clientfields(#"specialty_quickrevive", &quick_revive_client_field_func, &quick_revive_callback_func);
    zm_perks::register_perk_effects(#"specialty_quickrevive", "revive_light");
    zm_perks::register_perk_init_thread(#"specialty_quickrevive", &init_quick_revive);
    zm_perks::function_32b099ec(#"specialty_quickrevive", #"p8_zm_vapor_altar_icon_01_quickrevive", "zombie/fx8_perk_altar_symbol_ambient_quick_revive");
}

// Namespace zm_perk_quick_revive/zm_perk_quick_revive
// Params 0, eflags: 0x0
// Checksum 0x8f475419, Offset: 0x248
// Size: 0x52
function init_quick_revive() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect[#"revive_light"] = #"zombie/fx_perk_quick_revive_zmb";
    }
}

// Namespace zm_perk_quick_revive/zm_perk_quick_revive
// Params 0, eflags: 0x0
// Checksum 0xd4ca274, Offset: 0x2a8
// Size: 0x3c
function quick_revive_client_field_func() {
    clientfield::register("clientuimodel", "hudItems.perks.quick_revive", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_quick_revive/zm_perk_quick_revive
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x2f0
// Size: 0x4
function quick_revive_callback_func() {
    
}

