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

#namespace zm_talisman_extra_claymore;

// Namespace zm_talisman_extra_claymore/zm_talisman_extra_claymore
// Params 0, eflags: 0x2
// Checksum 0x31c53d5c, Offset: 0xe0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_talisman_extra_claymore", &__init__, undefined, undefined);
}

// Namespace zm_talisman_extra_claymore/zm_talisman_extra_claymore
// Params 0, eflags: 0x0
// Checksum 0x64833a28, Offset: 0x128
// Size: 0x2c
function __init__() {
    zm_talisman::register_talisman("talisman_extra_claymore", &activate_talisman);
}

// Namespace zm_talisman_extra_claymore/zm_talisman_extra_claymore
// Params 0, eflags: 0x0
// Checksum 0xb07ac76b, Offset: 0x160
// Size: 0x54
function activate_talisman() {
    callback::on_spawned(&function_b4da9ae4);
    self.b_talisman_extra_claymore = 1;
    zm_loadout::register_lethal_grenade_for_level(#"claymore_extra");
}

// Namespace zm_talisman_extra_claymore/zm_talisman_extra_claymore
// Params 0, eflags: 0x0
// Checksum 0x6b96cff2, Offset: 0x1c0
// Size: 0xdc
function function_b4da9ae4() {
    if (!(isdefined(self.b_talisman_extra_claymore) && self.b_talisman_extra_claymore)) {
        return;
    }
    level flagsys::wait_till(#"all_players_spawned");
    if (self.slot_weapons[#"lethal_grenade"] === getweapon(#"claymore")) {
        self takeweapon(getweapon(#"claymore"));
        self giveweapon(getweapon(#"claymore_extra"));
    }
}

