#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_acquire_perks;

// Namespace zm_trial_acquire_perks/zm_trial_acquire_perks
// Params 0, eflags: 0x6
// Checksum 0x9223a417, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_acquire_perks", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_acquire_perks/zm_trial_acquire_perks
// Params 0, eflags: 0x4
// Checksum 0xc78085d1, Offset: 0xe0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"acquire_perks", &on_begin, &on_end);
}

// Namespace zm_trial_acquire_perks/zm_trial_acquire_perks
// Params 1, eflags: 0x4
// Checksum 0x169bf814, Offset: 0x148
// Size: 0xd8
function private on_begin(perk_count) {
    assert(isdefined(level.var_b8be892e));
    self.var_851a4ca6 = zm_trial::function_5769f26a(perk_count);
    foreach (player in getplayers()) {
        player thread function_2a5b280f(self);
    }
}

// Namespace zm_trial_acquire_perks/zm_trial_acquire_perks
// Params 1, eflags: 0x4
// Checksum 0x11bfff5b, Offset: 0x228
// Size: 0x28e
function private on_end(round_reset) {
    foreach (player in getplayers()) {
        player zm_trial_util::function_f3aacffb();
    }
    if (!round_reset) {
        assert(isdefined(level.var_b8be892e));
        var_57807cdc = [];
        foreach (player in getplayers()) {
            assert(isdefined(player.var_a53b9221));
            if (player.var_a53b9221 < self.var_851a4ca6) {
                array::add(var_57807cdc, player, 0);
            }
        }
        if (var_57807cdc.size == 1) {
            zm_trial::fail(#"hash_397117e332ee81a0" + self.var_851a4ca6, var_57807cdc);
        } else if (var_57807cdc.size > 1) {
            zm_trial::fail(#"hash_4cf7d929e75b3da3" + self.var_851a4ca6, var_57807cdc);
        }
    }
    foreach (player in getplayers()) {
        player.var_a53b9221 = undefined;
    }
}

// Namespace zm_trial_acquire_perks/zm_trial_acquire_perks
// Params 0, eflags: 0x4
// Checksum 0xf4e98b78, Offset: 0x4c0
// Size: 0xb4
function private function_c9934172() {
    if (self.sessionstate != "spectator") {
        self.var_a53b9221 = 0;
        foreach (var_83225a27 in level.var_b8be892e) {
            if (self hasperk(var_83225a27)) {
                self.var_a53b9221++;
            }
        }
    }
}

// Namespace zm_trial_acquire_perks/zm_trial_acquire_perks
// Params 1, eflags: 0x4
// Checksum 0x357486fe, Offset: 0x580
// Size: 0xf4
function private function_2a5b280f(challenge) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    self.var_a53b9221 = 0;
    var_fa5d7ea0 = 0;
    self zm_trial_util::function_63060af4(0);
    while (true) {
        self function_c9934172();
        if (self.var_a53b9221 >= challenge.var_851a4ca6) {
            if (!var_fa5d7ea0) {
                self zm_trial_util::function_63060af4(1);
                var_fa5d7ea0 = 1;
            }
        } else if (var_fa5d7ea0) {
            self zm_trial_util::function_63060af4(0);
            var_fa5d7ea0 = 0;
        }
        waitframe(1);
    }
}

