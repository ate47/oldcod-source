#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_talisman;
#using scripts\zm_common\zm_utility;

#namespace zm_talisman_start_weapon_lmg;

// Namespace zm_talisman_start_weapon_lmg/zm_talisman_start_weapon_lmg
// Params 0, eflags: 0x2
// Checksum 0x15dc5611, Offset: 0xd8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_talisman_start_weapon_lmg", &__init__, undefined, undefined);
}

// Namespace zm_talisman_start_weapon_lmg/zm_talisman_start_weapon_lmg
// Params 0, eflags: 0x0
// Checksum 0xaa66e28d, Offset: 0x120
// Size: 0x54
function __init__() {
    if (!zm_custom::function_5638f689(#"zmweaponslmg")) {
        return;
    }
    zm_talisman::register_talisman("talisman_start_weapon_lmg", &activate_talisman);
}

// Namespace zm_talisman_start_weapon_lmg/zm_talisman_start_weapon_lmg
// Params 0, eflags: 0x0
// Checksum 0x2184f2ce, Offset: 0x180
// Size: 0x1a
function activate_talisman() {
    self.talisman_weapon_start = #"lmg_standard_t8";
}

