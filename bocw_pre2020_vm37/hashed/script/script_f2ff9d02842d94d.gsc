#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_d00dc3ab;

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 0, eflags: 0x1 linked
// Checksum 0x660b8b9d, Offset: 0x168
// Size: 0x13c
function function_3de84616() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_brain_decay", 0.25, 0, 48, 5, 0, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", &function_682e5375);
    clientfield::register("actor", "zm_aat_brain_decay", 1, 1, "int");
    clientfield::register("vehicle", "zm_aat_brain_decay", 1, 1, "int");
    clientfield::register("actor", "zm_aat_brain_decay_exp", 1, 1, "counter");
    clientfield::register("vehicle", "zm_aat_brain_decay_exp", 1, 1, "counter");
}

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 5, eflags: 0x1 linked
// Checksum 0x6412e884, Offset: 0x2b0
// Size: 0x1f4
function result(*death, attacker, *mod, weapon, *vpoint) {
    self thread clientfield::set("zm_aat_brain_decay", 1);
    self thread zombie_death_time_limit(weapon, vpoint);
    self.team = #"allies";
    self.aat_turned = 1;
    self.n_aat_turned_zombie_kills = 0;
    self.var_16d0eb06 = 20000;
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
    if (isplayer(weapon)) {
        weapon aat::function_7a12b737(#"zombie_hunter_brain_decay");
        self.var_443d78cc = weapon;
    }
    self thread function_8e97a3a4(weapon, vpoint);
    self thread zombie_kill_tracker(weapon);
}

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 2, eflags: 0x1 linked
// Checksum 0x16936d12, Offset: 0x4b0
// Size: 0x1c4
function function_8e97a3a4(attacker, weapon) {
    var_3c9de13d = self.origin;
    a_ai_zombies = array::get_all_closest(var_3c9de13d, getaiteamarray(#"axis"), undefined, undefined, 90);
    if (!isdefined(a_ai_zombies)) {
        return;
    }
    var_2cc3b86b = 8100;
    n_flung_zombies = 0;
    for (i = 0; i < a_ai_zombies.size; i++) {
        if (!isdefined(a_ai_zombies[i]) || !isalive(a_ai_zombies[i])) {
            continue;
        }
        if (is_true(level.aat[#"zm_aat_brain_decay"].immune_result_indirect[a_ai_zombies[i].archetype])) {
            continue;
        }
        if (a_ai_zombies[i] == self) {
            continue;
        }
        v_curr_zombie_origin = a_ai_zombies[i] getcentroid();
        if (distancesquared(var_3c9de13d, v_curr_zombie_origin) > var_2cc3b86b) {
            continue;
        }
        a_ai_zombies[i] function_fef86dd4(var_3c9de13d, 20000, attacker, weapon);
        n_flung_zombies++;
        if (-1 && n_flung_zombies >= 3) {
            break;
        }
    }
}

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 4, eflags: 0x5 linked
// Checksum 0xed91289f, Offset: 0x680
// Size: 0x14c
function private function_fef86dd4(var_c5ad44f1, n_damage, e_attacker, weapon) {
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

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 0, eflags: 0x1 linked
// Checksum 0x7f188453, Offset: 0x7d8
// Size: 0x112
function function_682e5375() {
    if (is_true(level.aat[#"zm_aat_brain_decay"].immune_result_direct[self.archetype])) {
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
    if (isdefined(level.var_b897ed83) && !self [[ level.var_b897ed83 ]]()) {
        return false;
    }
    return true;
}

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 2, eflags: 0x1 linked
// Checksum 0x46100749, Offset: 0x8f8
// Size: 0x12c
function zombie_death_time_limit(e_attacker, weapon) {
    self endon(#"death");
    level endoncallback(&function_a22e41ec, #"end_game");
    self waittilltimeout(8, #"hash_1bbb03bd582e937f");
    var_8651a024 = self getcentroid();
    self clientfield::set("zm_aat_brain_decay", 0);
    self clientfield::increment("zm_aat_brain_decay_exp", 1);
    waitframe(1);
    self.takedamage = 1;
    self.allowdeath = 1;
    self.team = #"axis";
    self zombie_death_explosion(var_8651a024, e_attacker, weapon);
    self zombie_death_gib(e_attacker, weapon);
}

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 1, eflags: 0x1 linked
// Checksum 0x68eda3c, Offset: 0xa30
// Size: 0x140
function function_a22e41ec(*_hash) {
    if (!isdefined(level.ai)) {
        return;
    }
    self notify("5407ba265ccec516");
    self endon("5407ba265ccec516");
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

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 3, eflags: 0x1 linked
// Checksum 0x64dabb09, Offset: 0xb78
// Size: 0x1c4
function zombie_death_explosion(var_58928a4b, e_attacker, weapon) {
    a_ai_zombies = array::get_all_closest(var_58928a4b, getaiteamarray(#"axis"), undefined, undefined, 160);
    if (!isdefined(a_ai_zombies)) {
        return;
    }
    var_2cc3b86b = 25600;
    n_flung_zombies = 0;
    for (i = 0; i < a_ai_zombies.size; i++) {
        if (!isdefined(a_ai_zombies[i]) || !isalive(a_ai_zombies[i])) {
            continue;
        }
        if (is_true(level.aat[#"zm_aat_brain_decay"].immune_result_indirect[a_ai_zombies[i].archetype])) {
            continue;
        }
        if (a_ai_zombies[i] == self) {
            continue;
        }
        v_curr_zombie_origin = a_ai_zombies[i] getcentroid();
        if (distancesquared(var_58928a4b, v_curr_zombie_origin) > var_2cc3b86b) {
            continue;
        }
        a_ai_zombies[i] function_fef86dd4(var_58928a4b, 20000, e_attacker, weapon);
        util::wait_network_frame(randomintrange(1, 3));
    }
}

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 1, eflags: 0x1 linked
// Checksum 0xfef9a607, Offset: 0xd48
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

// Namespace namespace_d00dc3ab/namespace_d00dc3ab
// Params 2, eflags: 0x1 linked
// Checksum 0xa4b0e252, Offset: 0xdd8
// Size: 0xf4
function zombie_death_gib(e_attacker, weapon) {
    gibserverutils::gibhead(self);
    if (math::cointoss()) {
        gibserverutils::gibleftarm(self);
    } else {
        gibserverutils::gibrightarm(self);
    }
    gibserverutils::giblegs(self);
    if (is_true(level.headshots_only)) {
        self kill();
        return;
    }
    self dodamage(self.health, self.origin, e_attacker, undefined, undefined, "MOD_AAT", 0, weapon);
}

