#using scripts\core_common\aat_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_aat_frostbite;

// Namespace zm_aat_frostbite/zm_aat_frostbite
// Params 0, eflags: 0x2
// Checksum 0x40e2b3e9, Offset: 0x148
// Size: 0x3c
function autoexec __init__system__() {
    system::register("zm_aat_frostbite", &__init__, undefined, #"aat");
}

// Namespace zm_aat_frostbite/zm_aat_frostbite
// Params 0, eflags: 0x0
// Checksum 0xe0b6bd9f, Offset: 0x190
// Size: 0x164
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_frostbite", 0.75, 0, 0, 0, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, 4);
    clientfield::register("actor", "zm_aat_frostbite_trail_clientfield", 1, 1, "int");
    clientfield::register("vehicle", "zm_aat_frostbite_trail_clientfield", 1, 1, "int");
    clientfield::register("actor", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter");
    clientfield::register("vehicle", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter");
    zm_utility::register_slowdown(#"zm_aat_frostbite_slowdown", 0.1, 3);
}

// Namespace zm_aat_frostbite/zm_aat_frostbite
// Params 4, eflags: 0x0
// Checksum 0x2003d2dc, Offset: 0x300
// Size: 0xec
function result(death, attacker, mod, weapon) {
    self notify(#"hash_3c2776b4262d3359");
    self endon(#"hash_3c2776b4262d3359");
    if (!isactor(self) && !isvehicle(self)) {
        return;
    }
    if (isdefined(self.aat_turned) && self.aat_turned) {
        return;
    }
    if (death) {
        level thread frostbite_explosion(self, self.origin, attacker, mod, weapon);
        return;
    }
    self thread function_e141078e(attacker, mod, weapon);
}

// Namespace zm_aat_frostbite/zm_aat_frostbite
// Params 4, eflags: 0x0
// Checksum 0x77d49551, Offset: 0x3f8
// Size: 0x1c4
function function_e141078e(attacker, mod, weapon, var_49522810 = 0) {
    self endon(#"death");
    if (!isdefined(self.var_fabdc0ef)) {
        self.var_fabdc0ef = 1;
    } else if (self.var_fabdc0ef <= 0.4) {
        return;
    }
    if (!isdefined(weapon) || !isdefined(attacker) || !isplayer(attacker)) {
        return;
    }
    if (var_49522810) {
        self.var_fabdc0ef = 0.4;
    } else {
        n_baseweapon = zm_weapons::get_base_weapon(weapon);
        var_d9e85a89 = n_baseweapon.firetime;
        self.var_fabdc0ef -= var_d9e85a89 * 2;
        if (self.var_fabdc0ef <= 0.4) {
            self.var_fabdc0ef = 0.4;
        }
    }
    self clientfield::set("zm_aat_frostbite_trail_clientfield", 1);
    self thread zm_utility::function_447d3917(#"zm_aat_frostbite_slowdown", self.var_fabdc0ef);
    self thread function_c71fc34f();
    self thread function_335bbcf9();
}

// Namespace zm_aat_frostbite/zm_aat_frostbite
// Params 0, eflags: 0x0
// Checksum 0x3152e879, Offset: 0x5c8
// Size: 0x106
function function_c71fc34f() {
    self notify(#"hash_6f92e6943e40092b");
    self endon(#"hash_6f92e6943e40092b", #"death");
    for (i = 0; i < 8; i++) {
        wait 0.375;
        self.var_fabdc0ef += 0.125;
        if (self.var_fabdc0ef >= 1) {
            break;
        }
        self thread zm_utility::function_447d3917(#"zm_aat_frostbite_slowdown", self.var_fabdc0ef);
    }
    self clientfield::set("zm_aat_frostbite_trail_clientfield", 0);
    self.var_fabdc0ef = 1;
    self notify(#"hash_652c15c8a7e2949");
}

// Namespace zm_aat_frostbite/zm_aat_frostbite
// Params 3, eflags: 0x0
// Checksum 0x327af0f6, Offset: 0x6d8
// Size: 0xc4
function function_335bbcf9(attacker, mod, weapon) {
    self notify(#"hash_b04750a529cb350");
    self endon(#"hash_b04750a529cb350", #"hash_652c15c8a7e2949");
    self waittill(#"death");
    if (isdefined(self)) {
        if (self.var_fabdc0ef <= 0.6) {
            level thread frostbite_explosion(self, self.origin, attacker, mod, weapon);
            return;
        }
        self zm_utility::function_95398de5();
    }
}

// Namespace zm_aat_frostbite/zm_aat_frostbite
// Params 5, eflags: 0x0
// Checksum 0xcc744d03, Offset: 0x7a8
// Size: 0x1f8
function frostbite_explosion(var_dedcd667, var_313aab1a, attacker, mod, weapon) {
    if (randomfloat(100) > 40) {
        return;
    }
    var_dedcd667 clientfield::increment("zm_aat_frostbite_explosion_clientfield");
    a_potential_targets = array::get_all_closest(var_313aab1a, level.ai[#"axis"], undefined, undefined, 128);
    foreach (e_target in a_potential_targets) {
        if (!isalive(e_target)) {
            continue;
        }
        if (isdefined(level.aat[#"zm_aat_frostbite"].immune_result_indirect[e_target.archetype]) && level.aat[#"zm_aat_frostbite"].immune_result_indirect[e_target.archetype]) {
            return;
        }
        if (!(isdefined(e_target.var_ad0da952) && e_target.var_ad0da952)) {
            continue;
        }
        if (var_dedcd667 === e_target) {
            continue;
        }
        e_target thread function_e141078e(attacker, mod, weapon, 1);
        util::wait_network_frame();
    }
}

