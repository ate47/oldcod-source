#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_talisman;
#using scripts\zm_common\zm_utility;

#namespace zm_talisman_box_guarantee_lmg;

// Namespace zm_talisman_box_guarantee_lmg/zm_talisman_box_guarantee_lmg
// Params 0, eflags: 0x2
// Checksum 0x885d62be, Offset: 0xd0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_talisman_box_guarantee_lmg", &__init__, undefined, undefined);
}

// Namespace zm_talisman_box_guarantee_lmg/zm_talisman_box_guarantee_lmg
// Params 0, eflags: 0x0
// Checksum 0x42f0fd50, Offset: 0x118
// Size: 0x2c
function __init__() {
    zm_talisman::register_talisman("talisman_box_guarantee_lmg", &activate_talisman);
}

// Namespace zm_talisman_box_guarantee_lmg/zm_talisman_box_guarantee_lmg
// Params 0, eflags: 0x0
// Checksum 0x5df6168a, Offset: 0x150
// Size: 0x1a
function activate_talisman() {
    self.var_f15dc7c3 = &function_d8361f05;
}

// Namespace zm_talisman_box_guarantee_lmg/zm_talisman_box_guarantee_lmg
// Params 1, eflags: 0x0
// Checksum 0xedc64d3b, Offset: 0x178
// Size: 0xf2
function function_d8361f05(a_keys) {
    a_valid = array();
    foreach (w_key in a_keys) {
        if (w_key.weapclass == "mg") {
            array::add(a_valid, w_key);
        }
    }
    if (a_valid.size == 0) {
        a_valid = a_keys;
    }
    a_valid = array::randomize(a_valid);
    self.var_f15dc7c3 = undefined;
    return a_valid;
}

