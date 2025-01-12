#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_talisman;
#using scripts\zm_common\zm_utility;

#namespace zm_talisman_extra_semtex;

// Namespace zm_talisman_extra_semtex/zm_talisman_extra_semtex
// Params 0, eflags: 0x2
// Checksum 0x690fecc8, Offset: 0xe0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_talisman_extra_semtex", &__init__, undefined, undefined);
}

// Namespace zm_talisman_extra_semtex/zm_talisman_extra_semtex
// Params 0, eflags: 0x0
// Checksum 0xb46c06e6, Offset: 0x128
// Size: 0x2c
function __init__() {
    zm_talisman::register_talisman("talisman_extra_semtex", &activate_talisman);
}

// Namespace zm_talisman_extra_semtex/zm_talisman_extra_semtex
// Params 0, eflags: 0x0
// Checksum 0x24f4f964, Offset: 0x160
// Size: 0x54
function activate_talisman() {
    callback::on_spawned(&function_8dd0b990);
    self.b_talisman_extra_semtex = 1;
    zm_loadout::register_lethal_grenade_for_level(#"eq_acid_bomb_extra");
}

// Namespace zm_talisman_extra_semtex/zm_talisman_extra_semtex
// Params 0, eflags: 0x0
// Checksum 0x3cd6dda2, Offset: 0x1c0
// Size: 0xdc
function function_8dd0b990() {
    if (!(isdefined(self.b_talisman_extra_semtex) && self.b_talisman_extra_semtex)) {
        return;
    }
    level flagsys::wait_till(#"all_players_spawned");
    if (self.slot_weapons[#"lethal_grenade"] === getweapon(#"eq_acid_bomb")) {
        self takeweapon(getweapon(#"eq_acid_bomb"));
        self giveweapon(getweapon(#"eq_acid_bomb_extra"));
    }
}

