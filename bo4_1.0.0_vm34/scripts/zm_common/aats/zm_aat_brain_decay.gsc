#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_aat_brain_decay;

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 0, eflags: 0x2
// Checksum 0x429ce47b, Offset: 0x140
// Size: 0x3c
function autoexec __init__system__() {
    system::register("zm_aat_brain_decay", &__init__, undefined, #"aat");
}

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 0, eflags: 0x0
// Checksum 0xe7dc7213, Offset: 0x188
// Size: 0x144
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_brain_decay", 0.25, 0, 10, 6, 0, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", &function_14e5b335, 1);
    clientfield::register("actor", "zm_aat_brain_decay", 1, 1, "int");
    clientfield::register("vehicle", "zm_aat_brain_decay", 1, 1, "int");
    clientfield::register("actor", "zm_aat_brain_decay_exp", 1, 1, "counter");
    clientfield::register("vehicle", "zm_aat_brain_decay_exp", 1, 1, "counter");
}

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 4, eflags: 0x0
// Checksum 0xcacae8b4, Offset: 0x2d8
// Size: 0x1c4
function result(death, attacker, mod, weapon) {
    self thread clientfield::set("zm_aat_brain_decay", 1);
    self thread zombie_death_time_limit(attacker);
    self.team = #"allies";
    self.aat_turned = 1;
    self.n_aat_turned_zombie_kills = 0;
    self.takedamage = 0;
    self.allowdeath = 0;
    self.allowpain = 0;
    self.b_ignore_cleanup = 1;
    if (self.archetype === "zombie") {
        self zombie_utility::set_zombie_run_cycle("sprint");
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
    if (isdefined(attacker) && isplayer(attacker)) {
        self.var_fcc82858 = attacker;
    }
    self thread function_9d808fe7(attacker);
    self thread zombie_kill_tracker(attacker);
}

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 1, eflags: 0x0
// Checksum 0x6a531df0, Offset: 0x4a8
// Size: 0x2d0
function function_9d808fe7(attacker) {
    var_56cc6697 = self.origin;
    a_ai_zombies = array::get_all_closest(var_56cc6697, getaiteamarray(#"axis"), undefined, undefined, 90);
    if (!isdefined(a_ai_zombies)) {
        return;
    }
    var_4e484c74 = 8100;
    n_flung_zombies = 0;
    for (i = 0; i < a_ai_zombies.size; i++) {
        if (!isdefined(a_ai_zombies[i]) || !isalive(a_ai_zombies[i])) {
            continue;
        }
        if (isdefined(level.aat[#"zm_aat_brain_decay"].immune_result_indirect[a_ai_zombies[i].archetype]) && level.aat[#"zm_aat_brain_decay"].immune_result_indirect[a_ai_zombies[i].archetype]) {
            continue;
        }
        if (a_ai_zombies[i] == self) {
            continue;
        }
        v_curr_zombie_origin = a_ai_zombies[i] getcentroid();
        if (distancesquared(var_56cc6697, v_curr_zombie_origin) > var_4e484c74) {
            continue;
        }
        a_ai_zombies[i] dodamage(a_ai_zombies[i].health, v_curr_zombie_origin, attacker, attacker, "none", "MOD_AAT");
        n_random_x = randomfloatrange(-3, 3);
        n_random_y = randomfloatrange(-3, 3);
        a_ai_zombies[i] startragdoll(1);
        a_ai_zombies[i] launchragdoll(60 * vectornormalize(v_curr_zombie_origin - var_56cc6697 + (n_random_x, n_random_y, 10)), "torso_lower");
        n_flung_zombies++;
        if (-1 && n_flung_zombies >= 3) {
            break;
        }
    }
}

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 0, eflags: 0x0
// Checksum 0x8d30a70a, Offset: 0x780
// Size: 0x126
function function_14e5b335() {
    if (isdefined(level.aat[#"zm_aat_brain_decay"].immune_result_direct[self.archetype]) && level.aat[#"zm_aat_brain_decay"].immune_result_direct[self.archetype]) {
        return false;
    }
    if (isdefined(self.barricade_enter) && self.barricade_enter) {
        return false;
    }
    if (isdefined(self.is_traversing) && self.is_traversing) {
        return false;
    }
    if (isdefined(self.var_3059fa07) && self.var_3059fa07) {
        return false;
    }
    if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
        return false;
    }
    if (isdefined(self.is_leaping) && self.is_leaping) {
        return false;
    }
    if (isdefined(level.var_a4b7d18a) && !self [[ level.var_a4b7d18a ]]()) {
        return false;
    }
    return true;
}

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 1, eflags: 0x0
// Checksum 0x4dc0adcc, Offset: 0x8b0
// Size: 0xe4
function zombie_death_time_limit(e_attacker) {
    self endon(#"death");
    self waittilltimeout(8, #"hash_1bbb03bd582e937f");
    var_4cab7396 = self getcentroid();
    self clientfield::set("zm_aat_brain_decay", 0);
    self clientfield::increment("zm_aat_brain_decay_exp", 1);
    waitframe(1);
    self.takedamage = 1;
    self.allowdeath = 1;
    self zombie_death_explosion(var_4cab7396, e_attacker);
    self zombie_death_gib(e_attacker);
}

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 2, eflags: 0x0
// Checksum 0x7f1235e5, Offset: 0x9a0
// Size: 0x216
function zombie_death_explosion(var_9eb8aaf8, e_attacker) {
    a_ai_zombies = array::get_all_closest(var_9eb8aaf8, getaiteamarray(#"axis"), undefined, undefined, 160);
    if (!isdefined(a_ai_zombies)) {
        return;
    }
    var_4e484c74 = 25600;
    n_flung_zombies = 0;
    for (i = 0; i < a_ai_zombies.size; i++) {
        if (!isdefined(a_ai_zombies[i]) || !isalive(a_ai_zombies[i])) {
            continue;
        }
        if (isdefined(level.aat[#"zm_aat_brain_decay"].immune_result_indirect[a_ai_zombies[i].archetype]) && level.aat[#"zm_aat_brain_decay"].immune_result_indirect[a_ai_zombies[i].archetype]) {
            continue;
        }
        if (a_ai_zombies[i] == self) {
            continue;
        }
        v_curr_zombie_origin = a_ai_zombies[i] getcentroid();
        if (distancesquared(var_9eb8aaf8, v_curr_zombie_origin) > var_4e484c74) {
            continue;
        }
        a_ai_zombies[i] dodamage(a_ai_zombies[i].health, v_curr_zombie_origin, e_attacker, e_attacker, "none", "MOD_AAT");
        util::wait_network_frame(randomintrange(1, 3));
    }
}

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 1, eflags: 0x0
// Checksum 0x356cb3eb, Offset: 0xbc0
// Size: 0x86
function zombie_kill_tracker(e_attacker) {
    self endon(#"death");
    var_6a971506 = 1;
    while (self.n_aat_turned_zombie_kills < 6) {
        if (!isdefined(self.favoriteenemy)) {
            if (!var_6a971506) {
                break;
            }
            var_6a971506 = 0;
        } else {
            var_6a971506 = 1;
        }
        wait 1;
    }
    self notify(#"hash_1bbb03bd582e937f");
}

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 1, eflags: 0x0
// Checksum 0x58241154, Offset: 0xc50
// Size: 0xa4
function zombie_death_gib(e_attacker) {
    gibserverutils::gibhead(self);
    if (math::cointoss()) {
        gibserverutils::gibleftarm(self);
    } else {
        gibserverutils::gibrightarm(self);
    }
    gibserverutils::giblegs(self);
    self dodamage(self.health, self.origin);
}

