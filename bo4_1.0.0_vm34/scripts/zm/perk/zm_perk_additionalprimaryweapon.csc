#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_additionalprimaryweapon;

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x2
// Checksum 0x35394f26, Offset: 0x138
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_additionalprimaryweapon", &__init__, undefined, undefined);
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0xc289ec93, Offset: 0x180
// Size: 0x14
function __init__() {
    enable_additional_primary_weapon_perk_for_level();
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x3c9ea0b0, Offset: 0x1a0
// Size: 0xd4
function enable_additional_primary_weapon_perk_for_level() {
    zm_perks::register_perk_clientfields(#"specialty_additionalprimaryweapon", &additional_primary_weapon_client_field_func, &additional_primary_weapon_code_callback_func);
    zm_perks::register_perk_effects(#"specialty_additionalprimaryweapon", "additionalprimaryweapon_light");
    zm_perks::register_perk_init_thread(#"specialty_additionalprimaryweapon", &init_additional_primary_weapon);
    zm_perks::function_32b099ec(#"specialty_additionalprimaryweapon", #"p8_zm_vapor_altar_icon_01_mulekick", "zombie/fx8_perk_altar_symbol_ambient_mule_kick");
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x3f9e3ce8, Offset: 0x280
// Size: 0x4a
function init_additional_primary_weapon() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect[#"additionalprimaryweapon_light"] = "zombie/fx_perk_mule_kick_zmb";
    }
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x427367a5, Offset: 0x2d8
// Size: 0x3c
function additional_primary_weapon_client_field_func() {
    clientfield::register("clientuimodel", "hudItems.perks.additional_primary_weapon", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_additionalprimaryweapon/zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x320
// Size: 0x4
function additional_primary_weapon_code_callback_func() {
    
}

