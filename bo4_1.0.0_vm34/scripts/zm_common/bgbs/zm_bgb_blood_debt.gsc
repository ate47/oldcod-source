#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace zm_bgb_blood_debt;

// Namespace zm_bgb_blood_debt/zm_bgb_blood_debt
// Params 0, eflags: 0x2
// Checksum 0x2a9bedf7, Offset: 0xa0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_blood_debt", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_blood_debt/zm_bgb_blood_debt
// Params 0, eflags: 0x0
// Checksum 0x144237a9, Offset: 0xf0
// Size: 0x94
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_blood_debt", "time", 180, &enable, &disable, undefined, undefined);
    zm_player::register_player_damage_callback(&function_3e6faedb);
}

// Namespace zm_bgb_blood_debt/zm_bgb_blood_debt
// Params 0, eflags: 0x0
// Checksum 0x4e4b5513, Offset: 0x190
// Size: 0xa6
function enable() {
    self endon(#"disconnect", #"bled_out", #"bgb_update");
    if (zm_utility::is_standard()) {
        self.var_eb4ca8f4 = array(2000);
    } else {
        self.var_eb4ca8f4 = array(50, 100, 250, 500);
    }
    self.var_2318b495 = 1;
}

// Namespace zm_bgb_blood_debt/zm_bgb_blood_debt
// Params 0, eflags: 0x0
// Checksum 0x1ec79c71, Offset: 0x240
// Size: 0x16
function disable() {
    self.var_eb4ca8f4 = undefined;
    self.var_2318b495 = undefined;
}

// Namespace zm_bgb_blood_debt/zm_bgb_blood_debt
// Params 10, eflags: 0x0
// Checksum 0x71734d3b, Offset: 0x260
// Size: 0x16c
function function_3e6faedb(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (bgb::is_enabled(#"zm_bgb_blood_debt")) {
        if (idamage > 0) {
            if (self.var_eb4ca8f4.size > 1) {
                n_cost = self.var_eb4ca8f4[0];
            } else {
                n_cost = self.var_eb4ca8f4[0] * self.var_2318b495;
                self.var_2318b495++;
            }
            if (self zm_score::can_player_purchase(n_cost, 1)) {
                self function_ab5d050f(n_cost);
                return 0;
            } else {
                n_cost = zm_score::function_a8fa79c2();
                if (n_cost == 0) {
                    self bgb::take();
                    return (self.health + 666);
                } else {
                    self function_ab5d050f(n_cost);
                    return 0;
                }
            }
        }
    }
    return -1;
}

// Namespace zm_bgb_blood_debt/zm_bgb_blood_debt
// Params 1, eflags: 0x0
// Checksum 0x30c8d1ae, Offset: 0x3d8
// Size: 0x5a
function function_ab5d050f(n_cost) {
    self zm_score::minus_to_player_score(n_cost, 1);
    if (self.var_eb4ca8f4.size > 1) {
        self.var_eb4ca8f4 = array::remove_index(self.var_eb4ca8f4, 0);
    }
}

