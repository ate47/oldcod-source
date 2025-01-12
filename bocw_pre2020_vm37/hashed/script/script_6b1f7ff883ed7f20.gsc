#using script_5f261a5d57de5f7c;
#using script_7464a3005f61a5f6;
#using script_7f6cd71c43c45c57;
#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace ammomod_cryofreeze;

// Namespace ammomod_cryofreeze/ammomod_cryofreeze
// Params 0, eflags: 0x1 linked
// Checksum 0xd8edd454, Offset: 0x208
// Size: 0x384
function function_ab6c8a0b() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("ammomod_cryofreeze", 0.5, 0, 0, 0, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, #"cold");
    aat::register("ammomod_cryofreeze_1", 0.5, 0, 0, 0, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, #"cold");
    aat::register("ammomod_cryofreeze_2", 0.5, 0, 0, 0, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, #"cold");
    aat::register("ammomod_cryofreeze_3", 0.5, 0, 0, 0, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, #"cold");
    aat::register("ammomod_cryofreeze_4", 0.5, 0, 0, 0, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, #"cold");
    aat::register("ammomod_cryofreeze_5", 0.5, 0, 0, 0, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, #"cold");
    clientfield::register("actor", "zm_ammomod_cryofreeze_trail_clientfield", 1, 1, "int");
    clientfield::register("vehicle", "zm_ammomod_cryofreeze_trail_clientfield", 1, 1, "int");
    clientfield::register("actor", "zm_ammomod_cryofreeze_explosion_clientfield", 1, 1, "counter");
    clientfield::register("vehicle", "zm_ammomod_cryofreeze_explosion_clientfield", 1, 1, "counter");
    namespace_df7b10e3::register_slowdown(#"hash_11428bfe58012e24", 0.7, 3);
    namespace_df7b10e3::register_slowdown(#"hash_61bdd7c7815dd7a9", 0.7, 5);
    namespace_df7b10e3::register_slowdown(#"hash_61bdd6c7815dd5f6", 0.5, 5);
}

// Namespace ammomod_cryofreeze/ammomod_cryofreeze
// Params 1, eflags: 0x5 linked
// Checksum 0x93210bda, Offset: 0x598
// Size: 0xcc
function private function_a0c6cb5d(aat_name) {
    switch (aat_name) {
    case #"ammomod_cryofreeze":
    default:
        return 0;
    case #"ammomod_cryofreeze_1":
        return 1;
    case #"ammomod_cryofreeze_2":
        return 2;
    case #"ammomod_cryofreeze_3":
        return 3;
    case #"ammomod_cryofreeze_4":
        return 4;
    case #"ammomod_cryofreeze_5":
        return 5;
    }
    return 0;
}

// Namespace ammomod_cryofreeze/ammomod_cryofreeze
// Params 5, eflags: 0x1 linked
// Checksum 0xe90b4502, Offset: 0x670
// Size: 0x214
function result(death, attacker, mod, weapon, vpoint = self.origin) {
    self notify(#"hash_3c2776b4262d3359");
    self endon(#"hash_3c2776b4262d3359");
    if (!isactor(self) && !isvehicle(self)) {
        return;
    }
    if (is_true(self.aat_turned)) {
        return;
    }
    if (!isplayer(attacker)) {
        return;
    }
    playfx("zm_weapons/fx9_aat_bul_impact_frost", vpoint);
    aat_name = attacker aat::getaatonweapon(weapon, 1);
    tier = function_a0c6cb5d(aat_name);
    if (is_true(death) && function_3be79107(attacker) && tier >= 5) {
        level thread function_9366890d(self, self.origin, attacker, mod, weapon);
        return;
    }
    if (self.var_6f84b820 === #"special") {
        if (tier >= 4) {
            self thread function_f00409f3(attacker, mod, weapon, 0, tier);
        }
        return;
    }
    if (self.var_6f84b820 === #"normal") {
        self thread function_f00409f3(attacker, mod, weapon, 0, tier);
    }
}

// Namespace ammomod_cryofreeze/ammomod_cryofreeze
// Params 1, eflags: 0x5 linked
// Checksum 0x475abe00, Offset: 0x890
// Size: 0xc2
function private function_3be79107(e_attacker) {
    n_current_time = float(gettime()) / 1000;
    if (isplayer(e_attacker)) {
        if (!isdefined(e_attacker.aat_cooldown_start[#"hash_6c45efdfc5561fe0"])) {
            return true;
        } else if (isdefined(e_attacker.aat_cooldown_start[#"hash_6c45efdfc5561fe0"]) && n_current_time >= e_attacker.aat_cooldown_start[#"hash_6c45efdfc5561fe0"] + 30) {
            return true;
        }
    }
    return false;
}

// Namespace ammomod_cryofreeze/ammomod_cryofreeze
// Params 5, eflags: 0x1 linked
// Checksum 0x751ce0f1, Offset: 0x960
// Size: 0x2d4
function function_f00409f3(attacker, *mod, weapon, var_e1ec1eee = 0, tier = 0) {
    self endon(#"death");
    if (!isdefined(self.var_d70e35fb)) {
        self.var_d70e35fb = 1;
    } else if (self.var_d70e35fb <= 0.4) {
        return;
    }
    if (!isdefined(weapon) || !isdefined(mod) || !isplayer(mod)) {
        return;
    }
    if (var_e1ec1eee) {
        self.var_d70e35fb = 0.4;
    } else {
        var_1b767d36 = weapons::getbaseweapon(weapon);
        var_fa87e189 = var_1b767d36.firetime;
        multiplier = 1.5;
        if (tier >= 1) {
            multiplier = 3;
        }
        self.var_d70e35fb -= var_fa87e189 * multiplier;
        if (self.var_d70e35fb <= 0.4) {
            self.var_d70e35fb = 0.4;
        }
    }
    self clientfield::set("zm_ammomod_cryofreeze_trail_clientfield", 1);
    switch (tier) {
    case 0:
    case 1:
        self thread namespace_df7b10e3::slowdown(#"hash_11428bfe58012e24", self.var_d70e35fb);
        break;
    case 2:
        self thread namespace_df7b10e3::slowdown(#"hash_61bdd7c7815dd7a9", self.var_d70e35fb);
        break;
    case 3:
    case 4:
    case 5:
        self thread namespace_df7b10e3::slowdown(#"hash_61bdd6c7815dd5f6", self.var_d70e35fb);
        break;
    }
    self thread function_76d7d189(mod, weapon, tier);
    self thread function_6af83db3(mod, undefined, weapon, tier);
}

// Namespace ammomod_cryofreeze/ammomod_cryofreeze
// Params 3, eflags: 0x1 linked
// Checksum 0x3aeb1617, Offset: 0xc40
// Size: 0x22e
function function_76d7d189(*e_attacker, *weapon, tier = 0) {
    self notify(#"hash_271e03ecc07954ab");
    self endon(#"hash_271e03ecc07954ab", #"death");
    var_b543d2cf = 3;
    if (tier >= 2) {
        var_b543d2cf = 5;
    }
    for (i = 0; i < 8; i++) {
        wait var_b543d2cf / 8;
        self.var_d70e35fb += 0.125;
        if (self.var_d70e35fb >= 1) {
            break;
        }
        switch (tier) {
        case 0:
        case 1:
            self thread namespace_df7b10e3::slowdown(#"hash_11428bfe58012e24", self.var_d70e35fb);
            break;
        case 2:
            self thread namespace_df7b10e3::slowdown(#"hash_61bdd7c7815dd7a9", self.var_d70e35fb);
            break;
        case 3:
        case 4:
        case 5:
            self thread namespace_df7b10e3::slowdown(#"hash_61bdd6c7815dd5f6", self.var_d70e35fb);
            break;
        }
    }
    self clientfield::set("zm_ammomod_cryofreeze_trail_clientfield", 0);
    self.var_d70e35fb = 1;
    self notify(#"hash_4e1fee0199a7c7c9");
}

// Namespace ammomod_cryofreeze/ammomod_cryofreeze
// Params 4, eflags: 0x1 linked
// Checksum 0x1af3e906, Offset: 0xe78
// Size: 0x10c
function function_6af83db3(attacker, mod, weapon, tier = 0) {
    self notify(#"hash_42f4135c766a4dd0");
    self endon(#"hash_42f4135c766a4dd0", #"hash_4e1fee0199a7c7c9");
    self waittill(#"death");
    if (isdefined(self)) {
        if (self.var_d70e35fb <= 0.6 && function_3be79107(attacker) && tier == 5) {
            level thread function_9366890d(self, self.origin, attacker, mod, weapon);
            return;
        }
        self namespace_df7b10e3::function_520f4da5(#"hash_11428bfe58012e24");
    }
}

// Namespace ammomod_cryofreeze/ammomod_cryofreeze
// Params 5, eflags: 0x1 linked
// Checksum 0x7537ca1b, Offset: 0xf90
// Size: 0x218
function function_9366890d(var_4589e270, var_23255fc5, attacker, mod, weapon) {
    self endon(#"death");
    var_4589e270 clientfield::increment("zm_ammomod_cryofreeze_explosion_clientfield");
    n_range = 256;
    if (isplayer(attacker)) {
        attacker.aat_cooldown_start[#"hash_6c45efdfc5561fe0"] = float(gettime()) / 1000;
        n_range = attacker namespace_e86ffa8::function_cd6787b(2) ? 512 : 256;
    }
    a_potential_targets = getentitiesinradius(var_23255fc5, n_range, 15);
    count = 0;
    foreach (e_target in a_potential_targets) {
        if (!isalive(e_target)) {
            continue;
        }
        if (count >= 5) {
            return;
        }
        if (var_4589e270 === e_target) {
            continue;
        }
        if (isalive(e_target)) {
            e_target thread function_f00409f3(attacker, mod, weapon, 1, 5);
        }
        count++;
        util::wait_network_frame();
    }
}

