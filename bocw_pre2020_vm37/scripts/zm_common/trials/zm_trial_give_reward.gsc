#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_utility;

#namespace zm_trial_give_reward;

// Namespace zm_trial_give_reward/zm_trial_give_reward
// Params 0, eflags: 0x6
// Checksum 0xd4fd0918, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_give_reward", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_give_reward/zm_trial_give_reward
// Params 0, eflags: 0x4
// Checksum 0x50dceca2, Offset: 0xe0
// Size: 0xf0
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    level.var_5335b66f = associativearray(#"zm_zodt8_default", 1, #"zm_towers_default", 2, #"zm_office_default", 3, #"zm_escape_default", 4, #"zm_mansion_default", 5, #"zm_red_default", 6, #"zm_zodt8_variant_1", 7);
    zm_trial::register_challenge(#"give_reward", &on_begin, &on_end);
    level.var_ee7ca64 = [];
}

// Namespace zm_trial_give_reward/zm_trial_give_reward
// Params 6, eflags: 0x4
// Checksum 0xc8835a6f, Offset: 0x1d8
// Size: 0x76
function private on_begin(var_c2964c77, *description, *image, challenge_stat, var_191009a6, trial_completed) {
    self.var_c2964c77 = image;
    self.challenge_stat = challenge_stat;
    self.var_191009a6 = var_191009a6;
    self.trial_completed = trial_completed === #"1";
}

// Namespace zm_trial_give_reward/zm_trial_give_reward
// Params 1, eflags: 0x4
// Checksum 0x9724e38e, Offset: 0x258
// Size: 0x118
function private on_end(round_reset) {
    if (!round_reset && !level flag::get(#"trial_failed")) {
        self function_e7254828();
        if (is_true(self.trial_completed)) {
            luinotifyevent(#"zm_trial_completed");
            foreach (player in getplayers()) {
                player zm_utility::function_659819fa(#"zm_trials_round_30");
            }
        }
    }
}

// Namespace zm_trial_give_reward/zm_trial_give_reward
// Params 0, eflags: 0x4
// Checksum 0xf3bcae42, Offset: 0x378
// Size: 0x460
function private function_e7254828() {
    assert(isdefined(level.var_6d87ac05) && isdefined(level.var_6d87ac05.name));
    assert(isdefined(level.var_5335b66f) && isdefined(level.var_5335b66f[level.var_6d87ac05.name]));
    var_93493c8 = level.var_5335b66f[level.var_6d87ac05.name];
    curr_time = gettime() - level.var_21e22beb;
    var_ee7ca64 = is_true(level.var_ee7ca64[level.round_number]);
    if (is_true(self.trial_completed)) {
        level.var_bccd8271 = curr_time;
    }
    foreach (player in getplayers()) {
        best_time = player zm_stats::function_8e274b32(self.var_c2964c77);
        if (best_time == 0 && !var_ee7ca64) {
            level.var_ee7ca64[level.round_number] = 1;
            player luinotifyevent(#"hash_8d33c3be569f08", 1, self.row);
            if (level.onlinegame) {
                player function_4835d26a();
            }
        }
        player zm_stats::function_31931250(self.var_c2964c77, curr_time);
        best_time = player zm_stats::function_b1520544(self.var_c2964c77);
        if (best_time == 0 || curr_time < best_time) {
            player zm_stats::function_49469f35(self.var_c2964c77, curr_time);
        }
        best_time = zm_stats::get_match_stat(self.var_c2964c77);
        if (best_time == 0 || curr_time < best_time) {
            zm_stats::set_match_stat(self.var_c2964c77, curr_time);
        }
        best_time = player zm_stats::function_e4358abd(self.var_c2964c77);
        if (best_time == 0 || curr_time < best_time) {
            player zm_stats::function_9daadcaa(self.var_c2964c77, curr_time);
        }
        if (is_true(self.trial_completed)) {
            player notify(#"stop_player_monitor_time_played");
        }
        player zm_stats::increment_challenge_stat(self.challenge_stat, 1);
        if (level.round_number == 20) {
            player contracts::increment_zm_contract(#"contract_zm_gauntlet_silver");
        }
        if (zm_trial::function_ba9853db() == 0) {
            if (isdefined(self.var_191009a6)) {
                player zm_stats::increment_challenge_stat(self.var_191009a6, 1);
            }
            if (level.round_number == 10) {
                player contracts::increment_zm_contract(#"contract_zm_gauntlet_bronze");
            }
        }
    }
}

