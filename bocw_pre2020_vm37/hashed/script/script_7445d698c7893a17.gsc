#using script_5f261a5d57de5f7c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\trials\zm_trial_headshots_only;

#namespace ammomod_brainrot;

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 0, eflags: 0x1 linked
// Checksum 0x6f5a3b63, Offset: 0x210
// Size: 0x2f4
function function_9384b521() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("ammomod_brainrot", 0.15, 0, 48, 5, 0, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", &function_6f735de0);
    aat::register("ammomod_brainrot_1", 0.15, 0, 48, 5, 0, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", &function_6f735de0);
    aat::register("ammomod_brainrot_2", 0.15, 0, 48, 5, 0, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", &function_6f735de0);
    aat::register("ammomod_brainrot_3", 0.15, 0, 48, 5, 0, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", &function_6f735de0);
    aat::register("ammomod_brainrot_4", 0.15, 0, 48, 5, 0, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", &function_6f735de0);
    aat::register("ammomod_brainrot_5", 0.15, 0, 48, 5, 0, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", &function_6f735de0);
    clientfield::register("actor", "ammomod_brainrot", 1, 1, "int");
    clientfield::register("vehicle", "ammomod_brainrot", 1, 1, "int");
    clientfield::register("actor", "zm_ammomod_brainrot_exp", 1, 1, "counter");
    clientfield::register("vehicle", "zm_ammomod_brainrot_exp", 1, 1, "counter");
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 1, eflags: 0x5 linked
// Checksum 0x9db9102a, Offset: 0x510
// Size: 0xcc
function private function_76ade8b5(aat_name) {
    switch (aat_name) {
    case #"ammomod_brainrot":
    default:
        return 0;
    case #"ammomod_brainrot_1":
        return 1;
    case #"ammomod_brainrot_2":
        return 2;
    case #"ammomod_brainrot_3":
        return 3;
    case #"ammomod_brainrot_4":
        return 4;
    case #"ammomod_brainrot_5":
        return 5;
    }
    return 0;
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 5, eflags: 0x1 linked
// Checksum 0x7fb0de03, Offset: 0x5e8
// Size: 0x11c
function result(*death, attacker, *mod, weapon, vpoint = self.origin) {
    playfx("zm_weapons/fx9_aat_bul_impact_corrosive", vpoint);
    aat_name = mod aat::getaatonweapon(weapon, 1);
    tier = function_76ade8b5(aat_name);
    if (self.var_6f84b820 === #"special") {
        if (tier >= 3) {
            self thread function_c81ac3e5(mod, weapon, tier);
        }
        return;
    }
    if (self.var_6f84b820 === #"normal") {
        self thread function_c81ac3e5(mod, weapon, tier);
    }
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 3, eflags: 0x1 linked
// Checksum 0x3f38820e, Offset: 0x710
// Size: 0x2b4
function function_c81ac3e5(attacker, weapon, tier) {
    if (self.var_6f84b820 === #"elite" || self.var_6f84b820 === #"boss" || self.var_6f84b820 === #"inanimate") {
        return;
    }
    self thread clientfield::set("ammomod_brainrot", 1);
    self thread zombie_death_time_limit(attacker, weapon, tier);
    self.team = #"allies";
    self.aat_turned = 1;
    self.n_aat_turned_zombie_kills = 0;
    self.var_16d0eb06 = 30;
    self clearpath();
    self.keep_moving = 0;
    if (tier >= 4) {
        self.var_16d0eb06 = 60;
    }
    self.var_16d0eb06 *= isdefined(self.var_41e87ed9) ? self.var_41e87ed9 : 1;
    self.var_72a8a05d = 200 * (isdefined(self.var_41e87ed9) ? self.var_41e87ed9 : 1);
    self.takedamage = 0;
    self.allowdeath = 0;
    self.allowpain = 0;
    self.b_ignore_cleanup = 1;
    if (self.archetype === #"zombie") {
        self zombie_utility::set_zombie_run_cycle("super_sprint");
        if (math::cointoss()) {
            if (self.zombie_arms_position == "up") {
                self.variant_type = 6;
            } else {
                self.variant_type = 7;
            }
        } else if (self.zombie_arms_position == "up") {
            self.variant_type = 7;
        } else {
            self.variant_type = 8;
        }
    }
    if (isplayer(attacker)) {
        self.var_443d78cc = attacker;
    }
    self thread function_f7f8a2cc(attacker, weapon);
    self thread zombie_kill_tracker(attacker);
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 2, eflags: 0x1 linked
// Checksum 0x530fa6ac, Offset: 0x9d0
// Size: 0x1bc
function function_f7f8a2cc(attacker, weapon) {
    var_fd6c12d9 = self.origin;
    a_ai_zombies = array::get_all_closest(var_fd6c12d9, getaiteamarray(level.zombie_team), undefined, undefined, 90);
    if (!isdefined(a_ai_zombies)) {
        return;
    }
    var_be0a98b9 = 8100;
    n_flung_zombies = 0;
    for (i = 0; i < a_ai_zombies.size; i++) {
        if (!isdefined(a_ai_zombies[i]) || !isalive(a_ai_zombies[i])) {
            continue;
        }
        if (is_true(level.aat[#"ammomod_brainrot"].immune_result_indirect[a_ai_zombies[i].archetype])) {
            continue;
        }
        if (a_ai_zombies[i] == self) {
            continue;
        }
        v_curr_zombie_origin = a_ai_zombies[i] getcentroid();
        if (distancesquared(var_fd6c12d9, v_curr_zombie_origin) > var_be0a98b9) {
            continue;
        }
        a_ai_zombies[i] function_eb8a62bc(var_fd6c12d9, 1, attacker, weapon);
        n_flung_zombies++;
        if (-1 && n_flung_zombies >= 3) {
            break;
        }
    }
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 4, eflags: 0x5 linked
// Checksum 0x8405a995, Offset: 0xb98
// Size: 0x15c
function private function_eb8a62bc(var_c5ad44f1, n_damage, e_attacker, weapon) {
    if (zm_trial_headshots_only::is_active()) {
        return;
    }
    v_curr_zombie_origin = self getcentroid();
    self dodamage(n_damage, v_curr_zombie_origin, e_attacker, e_attacker, undefined, "MOD_AAT", 0, weapon);
    if (isalive(self)) {
        self zombie_utility::setup_zombie_knockdown(var_c5ad44f1);
        return;
    }
    n_random_x = randomfloatrange(-3, 3);
    n_random_y = randomfloatrange(-3, 3);
    self startragdoll(1);
    self launchragdoll(60 * vectornormalize(v_curr_zombie_origin - var_c5ad44f1 + (n_random_x, n_random_y, 10)), "torso_lower");
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 0, eflags: 0x1 linked
// Checksum 0xa5497fa9, Offset: 0xd00
// Size: 0x112
function function_6f735de0() {
    if (is_true(level.aat[#"ammomod_brainrot"].immune_result_direct[self.archetype])) {
        return false;
    }
    if (is_true(self.barricade_enter)) {
        return false;
    }
    if (is_true(self.is_traversing)) {
        return false;
    }
    if (is_true(self.var_69a981e6)) {
        return false;
    }
    if (!is_true(self.completed_emerging_into_playable_area)) {
        return false;
    }
    if (is_true(self.is_leaping)) {
        return false;
    }
    if (isdefined(level.var_11350584) && !self [[ level.var_11350584 ]]()) {
        return false;
    }
    return true;
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 3, eflags: 0x1 linked
// Checksum 0x3c96e1b9, Offset: 0xe20
// Size: 0x15c
function zombie_death_time_limit(e_attacker, weapon, tier) {
    self endon(#"death");
    level endoncallback(&function_a22e41ec, #"end_game");
    var_d7064585 = 8;
    if (tier >= 2) {
        var_d7064585 = 15;
    }
    self waittilltimeout(var_d7064585, #"hash_1bbb03bd582e937f");
    var_8651a024 = self getcentroid();
    self clientfield::set("ammomod_brainrot", 0);
    self clientfield::increment("zm_ammomod_brainrot_exp", 1);
    waitframe(1);
    self.takedamage = 1;
    self.allowdeath = 1;
    self.team = #"axis";
    self zombie_death_explosion(var_8651a024, e_attacker, weapon, tier);
    self zombie_death_gib(e_attacker, weapon);
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 1, eflags: 0x1 linked
// Checksum 0x7a5d05fb, Offset: 0xf88
// Size: 0x140
function function_a22e41ec(*_hash) {
    if (!isdefined(level.ai)) {
        return;
    }
    self notify("6baf898fb33d6cc");
    self endon("6baf898fb33d6cc");
    ai_zombies = getaiteamarray(#"axis");
    foreach (ai in ai_zombies) {
        if (is_true(ai.aat_turned) && isalive(ai)) {
            ai.takedamage = 1;
            ai.allowdeath = 1;
            waitframe(1);
            ai kill();
        }
    }
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 4, eflags: 0x1 linked
// Checksum 0x516b9e6d, Offset: 0x10d0
// Size: 0x2c4
function zombie_death_explosion(var_3a5b1930, e_attacker, weapon, tier = 0) {
    n_range = e_attacker namespace_e86ffa8::function_cd6787b(2) ? 512 : 256;
    a_ai_zombies = array::get_all_closest(var_3a5b1930, getaiteamarray(#"axis"), undefined, undefined, n_range);
    if (!isdefined(a_ai_zombies)) {
        return;
    }
    var_be0a98b9 = n_range * n_range;
    var_a374f6da = 3;
    var_5bb9cba5 = 0;
    n_flung_zombies = 0;
    for (i = 0; i < a_ai_zombies.size; i++) {
        if (!isdefined(a_ai_zombies[i]) || !isalive(a_ai_zombies[i])) {
            continue;
        }
        if (is_true(level.aat[#"ammomod_brainrot"].immune_result_indirect[a_ai_zombies[i].archetype])) {
            continue;
        }
        if (a_ai_zombies[i] == self) {
            continue;
        }
        v_curr_zombie_origin = a_ai_zombies[i] getcentroid();
        if (distancesquared(var_3a5b1930, v_curr_zombie_origin) > var_be0a98b9) {
            continue;
        }
        if (tier >= 5) {
            if (var_5bb9cba5 < var_a374f6da) {
                a_ai_zombies[i] function_c81ac3e5(e_attacker, weapon, tier);
                var_5bb9cba5++;
            } else {
                a_ai_zombies[i] function_eb8a62bc(var_3a5b1930, self.var_72a8a05d, e_attacker, weapon);
                util::wait_network_frame(randomintrange(1, 3));
            }
            continue;
        }
        a_ai_zombies[i] function_eb8a62bc(var_3a5b1930, self.var_72a8a05d, e_attacker, weapon);
        util::wait_network_frame(randomintrange(1, 3));
    }
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 1, eflags: 0x1 linked
// Checksum 0x77ab6a9f, Offset: 0x13a0
// Size: 0x86
function zombie_kill_tracker(*e_attacker) {
    self endon(#"death");
    var_a57adbdc = 1;
    while (self.n_aat_turned_zombie_kills < 6) {
        if (!isdefined(self.favoriteenemy)) {
            if (!var_a57adbdc) {
                break;
            }
            var_a57adbdc = 0;
        } else {
            var_a57adbdc = 1;
        }
        wait 1;
    }
    self notify(#"hash_1bbb03bd582e937f");
}

// Namespace ammomod_brainrot/ammomod_brainrot
// Params 2, eflags: 0x1 linked
// Checksum 0x467b72a8, Offset: 0x1430
// Size: 0x10c
function zombie_death_gib(e_attacker, weapon) {
    gibserverutils::gibhead(self);
    if (math::cointoss()) {
        gibserverutils::gibleftarm(self);
    } else {
        gibserverutils::gibrightarm(self);
    }
    gibserverutils::giblegs(self);
    if (is_true(level.headshots_only) || zm_trial_headshots_only::is_active()) {
        self kill();
        return;
    }
    self dodamage(self.health, self.origin, e_attacker, undefined, undefined, "MOD_AAT", 0, weapon);
}

