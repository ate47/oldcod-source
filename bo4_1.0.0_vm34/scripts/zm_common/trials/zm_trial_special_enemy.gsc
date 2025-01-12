#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_special_enemy;

// Namespace zm_trial_special_enemy/zm_trial_special_enemy
// Params 0, eflags: 0x2
// Checksum 0x48b2ae1b, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_special_enemy", &__init__, undefined, undefined);
}

// Namespace zm_trial_special_enemy/zm_trial_special_enemy
// Params 0, eflags: 0x0
// Checksum 0x450b1d90, Offset: 0xe0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"special_enemy", &on_begin, &on_end);
}

// Namespace zm_trial_special_enemy/zm_trial_special_enemy
// Params 4, eflags: 0x4
// Checksum 0x81a53cf8, Offset: 0x148
// Size: 0x19c
function private on_begin(enemy_type, var_6db56dc9, var_520f5adb, var_e46c0a20) {
    if (getplayers().size > 1) {
        self.enemy_count = zm_trial::function_9b72fb1a(var_520f5adb);
    } else {
        self.enemy_count = zm_trial::function_9b72fb1a(var_6db56dc9);
    }
    self.enemy_type = enemy_type;
    self.enemies_killed = 0;
    level.zombie_total = self.enemy_count;
    level.var_9d899152 = level.var_b18a7d0;
    level.var_b18a7d0 = &get_zombie_count_for_round;
    level.var_815d303f = level.fn_custom_round_ai_spawn;
    level.fn_custom_round_ai_spawn = &spawn_enemy;
    level.var_32f9054f = level.var_95f84779;
    level.var_95f84779 = 1;
    zm_spawner::register_zombie_death_event_callback(&function_db6decae);
    if (isdefined(var_e46c0a20)) {
        zm_trial_util::function_368f31a9(self.enemy_count);
        zm_trial_util::function_ef967e48(self.enemies_killed);
        level thread function_31b6dec0(self);
    }
}

// Namespace zm_trial_special_enemy/zm_trial_special_enemy
// Params 1, eflags: 0x4
// Checksum 0xf733564e, Offset: 0x2f0
// Size: 0x7c
function private on_end(round_reset) {
    level.var_b18a7d0 = level.var_9d899152;
    level.fn_custom_round_ai_spawn = level.var_815d303f;
    level.var_95f84779 = level.var_32f9054f;
    zm_trial_util::function_59861180();
    zm_spawner::deregister_zombie_death_event_callback(&function_db6decae);
}

// Namespace zm_trial_special_enemy/zm_trial_special_enemy
// Params 1, eflags: 0x4
// Checksum 0x777a3632, Offset: 0x378
// Size: 0x98
function private function_db6decae(attacker) {
    if (!isplayer(attacker) && !(isdefined(self.nuked) && self.nuked)) {
        return;
    }
    challenge = zm_trial::function_871c1f7f(#"special_enemy");
    assert(isdefined(challenge));
    challenge.enemies_killed++;
}

// Namespace zm_trial_special_enemy/zm_trial_special_enemy
// Params 1, eflags: 0x4
// Checksum 0xfeb0ce39, Offset: 0x418
// Size: 0x5e
function private function_31b6dec0(challenge) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    while (true) {
        zm_trial_util::function_ef967e48(challenge.enemies_killed);
        waitframe(1);
    }
}

// Namespace zm_trial_special_enemy/zm_trial_special_enemy
// Params 2, eflags: 0x4
// Checksum 0x5bdbe6e2, Offset: 0x480
// Size: 0x1e
function private get_zombie_count_for_round(round_number, player_count) {
    return level.zombie_total;
}

// Namespace zm_trial_special_enemy/zm_trial_special_enemy
// Params 0, eflags: 0x4
// Checksum 0x1dbefcc8, Offset: 0x4a8
// Size: 0x1f4
function private spawn_enemy() {
    var_909492cd = zm_trial::function_871c1f7f(#"defend_area");
    if (isdefined(var_909492cd)) {
        var_ebea95b1 = util::get_active_players().size;
        var_a5939917 = 0;
        foreach (player in util::get_active_players()) {
            if (isdefined(player.var_e17d0db8) && player.var_e17d0db8) {
                var_a5939917++;
            }
        }
        if (var_a5939917 < var_ebea95b1) {
            return true;
        }
    }
    challenge = zm_trial::function_871c1f7f(#"special_enemy");
    assert(isdefined(challenge));
    assert(isdefined(level.var_aff1b8b));
    assert(isdefined(level.var_aff1b8b[challenge.enemy_type]));
    spawn_callback = level.var_aff1b8b[challenge.enemy_type];
    spawn_success = [[ spawn_callback ]]();
    if (isdefined(spawn_success) && spawn_success) {
        level.zombie_total--;
    }
    return true;
}

// Namespace zm_trial_special_enemy/zm_trial_special_enemy
// Params 2, eflags: 0x0
// Checksum 0x219d6c91, Offset: 0x6a8
// Size: 0x82
function function_6e25f633(name, spawn_callback) {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    if (!isdefined(level.var_aff1b8b)) {
        level.var_aff1b8b = [];
    }
    assert(!isdefined(level.var_aff1b8b[name]));
    level.var_aff1b8b[name] = spawn_callback;
}

// Namespace zm_trial_special_enemy/zm_trial_special_enemy
// Params 0, eflags: 0x0
// Checksum 0xe753a15c, Offset: 0x738
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_871c1f7f(#"special_enemy");
    return isdefined(challenge);
}

