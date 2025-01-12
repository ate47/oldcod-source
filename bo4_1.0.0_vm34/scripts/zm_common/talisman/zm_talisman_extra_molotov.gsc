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

#namespace zm_talisman_extra_molotov;

// Namespace zm_talisman_extra_molotov/zm_talisman_extra_molotov
// Params 0, eflags: 0x2
// Checksum 0x8c96e6d7, Offset: 0xe0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_talisman_extra_molotov", &__init__, undefined, undefined);
}

// Namespace zm_talisman_extra_molotov/zm_talisman_extra_molotov
// Params 0, eflags: 0x0
// Checksum 0xd3b44136, Offset: 0x128
// Size: 0x2c
function __init__() {
    zm_talisman::register_talisman("talisman_extra_molotov", &activate_talisman);
}

// Namespace zm_talisman_extra_molotov/zm_talisman_extra_molotov
// Params 0, eflags: 0x0
// Checksum 0xbd13551a, Offset: 0x160
// Size: 0x54
function activate_talisman() {
    callback::on_spawned(&function_72296570);
    self.var_210ac5f3 = 1;
    zm_loadout::register_lethal_grenade_for_level(#"eq_wraith_fire_extra");
}

// Namespace zm_talisman_extra_molotov/zm_talisman_extra_molotov
// Params 0, eflags: 0x0
// Checksum 0x14341c46, Offset: 0x1c0
// Size: 0xdc
function function_72296570() {
    if (!(isdefined(self.var_210ac5f3) && self.var_210ac5f3)) {
        return;
    }
    level flagsys::wait_till(#"all_players_spawned");
    if (self.slot_weapons[#"lethal_grenade"] === getweapon(#"eq_wraith_fire")) {
        self takeweapon(getweapon(#"eq_wraith_fire"));
        self giveweapon(getweapon(#"eq_wraith_fire_extra"));
    }
}

