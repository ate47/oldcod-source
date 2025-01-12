#using script_7464a3005f61a5f6;
#using script_7f6cd71c43c45c57;
#using scripts\core_common\aat_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace aat_frostbite;

// Namespace aat_frostbite/aat_frostbite
// Params 0, eflags: 0x1 linked
// Checksum 0x972fd7c4, Offset: 0x170
// Size: 0x16c
function function_b39d1bd2() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_frostbite", 0.75, 0, 0, 0, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, #"cold");
    clientfield::register("actor", "zm_aat_frostbite_trail_clientfield", 1, 1, "int");
    clientfield::register("vehicle", "zm_aat_frostbite_trail_clientfield", 1, 1, "int");
    clientfield::register("actor", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter");
    clientfield::register("vehicle", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter");
    namespace_df7b10e3::register_slowdown(#"hash_7cb479d48ba9bbd6", 0.1, 3);
}

// Namespace aat_frostbite/aat_frostbite
// Params 5, eflags: 0x1 linked
// Checksum 0x88672eb4, Offset: 0x2e8
// Size: 0x114
function result(death, attacker, mod, weapon, *vpoint) {
    self notify(#"hash_3c2776b4262d3359");
    self endon(#"hash_3c2776b4262d3359");
    if (!isactor(self) && !isvehicle(self)) {
        return;
    }
    if (is_true(self.aat_turned)) {
        return;
    }
    if (is_true(attacker) && function_a2e05e6(mod)) {
        level thread frostbite_explosion(self, self.origin, mod, weapon, vpoint);
        return;
    }
    self thread function_158a3a18(mod, weapon, vpoint);
}

// Namespace aat_frostbite/aat_frostbite
// Params 1, eflags: 0x5 linked
// Checksum 0x3e3bab6b, Offset: 0x408
// Size: 0xc2
function private function_a2e05e6(e_attacker) {
    n_current_time = float(gettime()) / 1000;
    if (isplayer(e_attacker)) {
        if (!isdefined(e_attacker.aat_cooldown_start[#"zm_aat_frostbite_explosion"])) {
            return true;
        } else if (isdefined(e_attacker.aat_cooldown_start[#"zm_aat_frostbite_explosion"]) && n_current_time >= e_attacker.aat_cooldown_start[#"zm_aat_frostbite_explosion"] + 30) {
            return true;
        }
    }
    return false;
}

// Namespace aat_frostbite/aat_frostbite
// Params 4, eflags: 0x1 linked
// Checksum 0xffee46dd, Offset: 0x4d8
// Size: 0x1bc
function function_158a3a18(attacker, *mod, weapon, var_e1ec1eee = 0) {
    self endon(#"death");
    if (!isdefined(self.var_cbf4894c)) {
        self.var_cbf4894c = 1;
    } else if (self.var_cbf4894c <= 0.4) {
        return;
    }
    if (!isdefined(weapon) || !isdefined(mod) || !isplayer(mod)) {
        return;
    }
    if (var_e1ec1eee) {
        self.var_cbf4894c = 0.4;
    } else {
        var_1b767d36 = weapons::getbaseweapon(weapon);
        var_fa87e189 = var_1b767d36.firetime;
        self.var_cbf4894c -= var_fa87e189 * 1.5;
        if (self.var_cbf4894c <= 0.4) {
            self.var_cbf4894c = 0.4;
        }
    }
    self clientfield::set("zm_aat_frostbite_trail_clientfield", 1);
    self thread namespace_df7b10e3::slowdown(#"hash_7cb479d48ba9bbd6", self.var_cbf4894c);
    self thread function_dab102b8(mod, weapon);
    self thread function_35d3ac3b();
}

// Namespace aat_frostbite/aat_frostbite
// Params 2, eflags: 0x1 linked
// Checksum 0x93ad1706, Offset: 0x6a0
// Size: 0x116
function function_dab102b8(*e_attacker, *weapon) {
    self notify(#"hash_6f92e6943e40092b");
    self endon(#"hash_6f92e6943e40092b", #"death");
    for (i = 0; i < 8; i++) {
        wait 0.375;
        self.var_cbf4894c += 0.125;
        if (self.var_cbf4894c >= 1) {
            break;
        }
        self thread namespace_df7b10e3::slowdown(#"hash_7cb479d48ba9bbd6", self.var_cbf4894c);
    }
    self clientfield::set("zm_aat_frostbite_trail_clientfield", 0);
    self.var_cbf4894c = 1;
    self notify(#"hash_652c15c8a7e2949");
}

// Namespace aat_frostbite/aat_frostbite
// Params 3, eflags: 0x1 linked
// Checksum 0xf697796d, Offset: 0x7c0
// Size: 0xe4
function function_35d3ac3b(attacker, mod, weapon) {
    self notify(#"hash_b04750a529cb350");
    self endon(#"hash_b04750a529cb350", #"hash_652c15c8a7e2949");
    self waittill(#"death");
    if (isdefined(self)) {
        if (self.var_cbf4894c <= 0.6 && function_a2e05e6(attacker)) {
            level thread frostbite_explosion(self, self.origin, attacker, mod, weapon);
            return;
        }
        self namespace_df7b10e3::function_520f4da5(#"hash_7cb479d48ba9bbd6");
    }
}

// Namespace aat_frostbite/aat_frostbite
// Params 5, eflags: 0x1 linked
// Checksum 0x97474046, Offset: 0x8b0
// Size: 0x258
function frostbite_explosion(var_4589e270, var_23255fc5, attacker, mod, weapon) {
    if (randomfloat(100) > 40) {
        return;
    }
    var_4589e270 clientfield::increment("zm_aat_frostbite_explosion_clientfield");
    if (isplayer(attacker)) {
        attacker.aat_cooldown_start[#"zm_aat_frostbite_explosion"] = float(gettime()) / 1000;
    }
    a_potential_targets = array::get_all_closest(var_23255fc5, level.ai[#"axis"], undefined, undefined, 128);
    foreach (e_target in a_potential_targets) {
        if (!isalive(e_target)) {
            continue;
        }
        if (is_true(level.aat[#"zm_aat_frostbite"].immune_result_indirect[e_target.archetype])) {
            return;
        }
        if (!is_true(e_target.var_7cc959b1)) {
            continue;
        }
        if (var_4589e270 === e_target) {
            continue;
        }
        e_target function_11c85ac6(var_23255fc5, attacker, weapon);
        if (isalive(e_target)) {
            e_target thread function_158a3a18(attacker, mod, weapon, 1);
        }
        util::wait_network_frame();
    }
}

// Namespace aat_frostbite/aat_frostbite
// Params 3, eflags: 0x1 linked
// Checksum 0x1a926116, Offset: 0xb10
// Size: 0x5c
function function_11c85ac6(var_23255fc5, e_attacker, weapon) {
    n_damage = 20000;
    self dodamage(n_damage, var_23255fc5, e_attacker, undefined, "none", "MOD_AAT", 0, weapon);
}

