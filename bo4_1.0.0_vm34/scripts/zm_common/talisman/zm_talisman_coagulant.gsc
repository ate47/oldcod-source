#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_talisman;
#using scripts\zm_common\zm_utility;

#namespace zm_talisman_coagulant;

// Namespace zm_talisman_coagulant/zm_talisman_coagulant
// Params 0, eflags: 0x2
// Checksum 0x8d241b68, Offset: 0xc8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_talisman_coagulant", &__init__, undefined, undefined);
}

// Namespace zm_talisman_coagulant/zm_talisman_coagulant
// Params 0, eflags: 0x0
// Checksum 0x5a222dfe, Offset: 0x110
// Size: 0x2c
function __init__() {
    zm_talisman::register_talisman("talisman_coagulant", &activate_talisman);
}

// Namespace zm_talisman_coagulant/zm_talisman_coagulant
// Params 0, eflags: 0x0
// Checksum 0xa3986b38, Offset: 0x148
// Size: 0x12
function activate_talisman() {
    self.var_8a21af29 = 1.5;
}

