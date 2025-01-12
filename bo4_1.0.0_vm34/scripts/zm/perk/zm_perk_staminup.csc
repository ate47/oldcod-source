#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_staminup;

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x2
// Checksum 0xce9d3d4a, Offset: 0x118
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_staminup", &__init__, undefined, undefined);
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x22facdb8, Offset: 0x160
// Size: 0x14
function __init__() {
    enable_staminup_perk_for_level();
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x4ae28dba, Offset: 0x180
// Size: 0xd4
function enable_staminup_perk_for_level() {
    zm_perks::register_perk_clientfields(#"specialty_staminup", &staminup_client_field_func, &staminup_callback_func);
    zm_perks::register_perk_effects(#"specialty_staminup", "marathon_light");
    zm_perks::register_perk_init_thread(#"specialty_staminup", &init_staminup);
    zm_perks::function_32b099ec(#"specialty_staminup", #"p8_zm_vapor_altar_icon_01_staminup", "zombie/fx8_perk_altar_symbol_ambient_staminup");
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x58909fcf, Offset: 0x260
// Size: 0x4a
function init_staminup() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect[#"marathon_light"] = "zombie/fx_perk_stamin_up_zmb";
    }
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x52993e39, Offset: 0x2b8
// Size: 0x3c
function staminup_client_field_func() {
    clientfield::register("clientuimodel", "hudItems.perks.marathon", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_staminup/zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x300
// Size: 0x4
function staminup_callback_func() {
    
}

