#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_talisman;
#using scripts\zm_common\zm_utility;

#namespace zm_talisman_perk_permanent_4;

// Namespace zm_talisman_perk_permanent_4/zm_talisman_perk_permanent_4
// Params 0, eflags: 0x2
// Checksum 0xe3256727, Offset: 0xd0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_talisman_perk_permanent_4", &__init__, undefined, undefined);
}

// Namespace zm_talisman_perk_permanent_4/zm_talisman_perk_permanent_4
// Params 0, eflags: 0x0
// Checksum 0x9f0b72ea, Offset: 0x118
// Size: 0x2c
function __init__() {
    zm_talisman::register_talisman("talisman_perk_permanent_4", &activate_talisman);
}

// Namespace zm_talisman_perk_permanent_4/zm_talisman_perk_permanent_4
// Params 0, eflags: 0x0
// Checksum 0xdd252e4a, Offset: 0x150
// Size: 0x12
function activate_talisman() {
    self.talisman_perk_permanent = 4;
}

