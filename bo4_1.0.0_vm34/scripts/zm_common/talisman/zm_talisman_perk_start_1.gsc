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

#namespace zm_talisman_perk_start_1;

// Namespace zm_talisman_perk_start_1/zm_talisman_perk_start_1
// Params 0, eflags: 0x2
// Checksum 0x9bfbd311, Offset: 0xd0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_talisman_perk_start_1", &__init__, undefined, undefined);
}

// Namespace zm_talisman_perk_start_1/zm_talisman_perk_start_1
// Params 0, eflags: 0x0
// Checksum 0x2794cddd, Offset: 0x118
// Size: 0x2c
function __init__() {
    zm_talisman::register_talisman("talisman_perk_start_1", &activate_talisman);
}

// Namespace zm_talisman_perk_start_1/zm_talisman_perk_start_1
// Params 0, eflags: 0x0
// Checksum 0x5811a655, Offset: 0x150
// Size: 0x32
function activate_talisman() {
    if (zm_custom::function_3b3d4bf1(self.var_871d24d3[0])) {
        self.talisman_perk_start_1 = 1;
    }
}
