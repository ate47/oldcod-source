#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_utility;

#namespace zm_trial_give_reward;

// Namespace zm_trial_give_reward/zm_trial_give_reward
// Params 0, eflags: 0x2
// Checksum 0x6b224138, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_give_reward", &__init__, undefined, undefined);
}

// Namespace zm_trial_give_reward/zm_trial_give_reward
// Params 0, eflags: 0x0
// Checksum 0xa10521c8, Offset: 0xf0
// Size: 0x6a
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"give_reward", &on_begin, &on_end);
    level.var_58858a0f = [];
}

// Namespace zm_trial_give_reward/zm_trial_give_reward
// Params 5, eflags: 0x4
// Checksum 0xbc9febe6, Offset: 0x168
// Size: 0x94
function private on_begin(when, stat_name, description, image, give_achievement) {
    self.when = when;
    self.stat_name = stat_name;
    self.give_achievement = give_achievement === #"1";
    if (self.when == #"on_begin") {
        self function_732000a8();
    }
}

// Namespace zm_trial_give_reward/zm_trial_give_reward
// Params 1, eflags: 0x4
// Checksum 0x168a4b47, Offset: 0x208
// Size: 0x128
function private on_end(round_reset) {
    if (self.when == #"on_end" && !round_reset && !level flag::get(#"trial_failed")) {
        self function_732000a8();
        luinotifyevent(#"zm_trial_completed");
        if (isdefined(self.give_achievement) && self.give_achievement) {
            foreach (player in getplayers()) {
                player zm_utility::giveachievement_wrapper("zm_trials_round_30");
            }
        }
    }
}

// Namespace zm_trial_give_reward/zm_trial_give_reward
// Params 0, eflags: 0x4
// Checksum 0x54fc080f, Offset: 0x338
// Size: 0x230
function private function_732000a8() {
    curr_time = gettime() - level.var_f6545288;
    var_58858a0f = isdefined(level.var_58858a0f[level.round_number]) && level.var_58858a0f[level.round_number];
    foreach (player in getplayers()) {
        best_time = player zm_stats::function_35dc4c8a(self.stat_name);
        if (best_time == 0 && !var_58858a0f) {
            level.var_58858a0f[level.round_number] = 1;
            player luinotifyevent(#"hash_8d33c3be569f08", 1, self.row);
        }
        if (best_time == 0 || curr_time < best_time) {
            player zm_stats::function_5cf52256(self.stat_name, curr_time);
        }
        best_time = zm_stats::get_match_stat(self.stat_name);
        if (best_time == 0 || curr_time < best_time) {
            zm_stats::set_match_stat(self.stat_name, curr_time);
        }
        best_time = player zm_stats::function_febe937b(self.stat_name);
        if (best_time == 0 || curr_time < best_time) {
            player zm_stats::function_bda9bc47(self.stat_name, curr_time);
        }
    }
}

