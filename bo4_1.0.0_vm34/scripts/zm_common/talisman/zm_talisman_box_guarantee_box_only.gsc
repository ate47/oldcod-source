#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_talisman;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_talisman_box_guarantee_box_only;

// Namespace zm_talisman_box_guarantee_box_only/zm_talisman_box_guarantee_box_only
// Params 0, eflags: 0x2
// Checksum 0x5a9b86af, Offset: 0x108
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_talisman_box_guarantee_box_only", &__init__, undefined, undefined);
}

// Namespace zm_talisman_box_guarantee_box_only/zm_talisman_box_guarantee_box_only
// Params 0, eflags: 0x0
// Checksum 0x5f921ff2, Offset: 0x150
// Size: 0x2c
function __init__() {
    zm_talisman::register_talisman("talisman_box_guarantee_box_only", &activate_talisman);
}

// Namespace zm_talisman_box_guarantee_box_only/zm_talisman_box_guarantee_box_only
// Params 0, eflags: 0x0
// Checksum 0x265adcf1, Offset: 0x188
// Size: 0x1a
function activate_talisman() {
    self.var_f15dc7c3 = &function_dcc369e3;
}

// Namespace zm_talisman_box_guarantee_box_only/zm_talisman_box_guarantee_box_only
// Params 1, eflags: 0x0
// Checksum 0x2fb42b55, Offset: 0x1b0
// Size: 0x1e2
function function_dcc369e3(a_keys) {
    a_wallbuys = array();
    a_valid = array();
    var_1095308c = [];
    var_1095308c = struct::get_array("weapon_upgrade", "targetname");
    var_1095308c = arraycombine(var_1095308c, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);
    for (i = 0; i < var_1095308c.size; i++) {
        w_wallbuy = getweapon(var_1095308c[i].zombie_weapon_upgrade);
        array::add(a_wallbuys, w_wallbuy);
    }
    foreach (w_key in a_keys) {
        if (!zm_weapons::is_wonder_weapon(w_key)) {
            array::add(a_valid, w_key);
        }
    }
    a_keys = array::exclude(a_valid, a_wallbuys);
    a_keys = array::randomize(a_keys);
    self.var_f15dc7c3 = undefined;
    return a_keys;
}

