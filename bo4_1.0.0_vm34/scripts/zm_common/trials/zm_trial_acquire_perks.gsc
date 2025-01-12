#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_acquire_perks;

// Namespace zm_trial_acquire_perks/zm_trial_acquire_perks
// Params 0, eflags: 0x2
// Checksum 0x109ea9c, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_acquire_perks", &__init__, undefined, undefined);
}

// Namespace zm_trial_acquire_perks/zm_trial_acquire_perks
// Params 0, eflags: 0x0
// Checksum 0x37cc7adb, Offset: 0xe8
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"acquire_perks", &on_begin, &on_end);
}

// Namespace zm_trial_acquire_perks/zm_trial_acquire_perks
// Params 1, eflags: 0x4
// Checksum 0xc50f5453, Offset: 0x150
// Size: 0xd0
function private on_begin(perk_count) {
    assert(isdefined(level.var_3d574fc8));
    self.var_a65fff71 = zm_trial::function_9b72fb1a(perk_count);
    foreach (player in getplayers()) {
        player thread function_665eb907(self);
    }
}

// Namespace zm_trial_acquire_perks/zm_trial_acquire_perks
// Params 1, eflags: 0x4
// Checksum 0xc5cba9ec, Offset: 0x228
// Size: 0x25e
function private on_end(round_reset) {
    foreach (player in getplayers()) {
        player zm_trial_util::function_fccd8386();
    }
    if (!round_reset) {
        assert(isdefined(level.var_3d574fc8));
        var_9fb91af5 = [];
        foreach (player in getplayers()) {
            assert(isdefined(player.var_ac82190a));
            if (player.var_ac82190a < self.var_a65fff71) {
                array::add(var_9fb91af5, player, 0);
            }
        }
        if (var_9fb91af5.size == 1) {
            zm_trial::fail(#"hash_397117e332ee81a0" + self.var_a65fff71, var_9fb91af5);
        } else if (var_9fb91af5.size > 1) {
            zm_trial::fail(#"hash_4cf7d929e75b3da3" + self.var_a65fff71, var_9fb91af5);
        }
    }
    foreach (player in getplayers()) {
        player.var_ac82190a = undefined;
    }
}

// Namespace zm_trial_acquire_perks/zm_trial_acquire_perks
// Params 0, eflags: 0x4
// Checksum 0x95336cb4, Offset: 0x490
// Size: 0xa4
function private function_9a9724b0() {
    if (self.sessionstate != "spectator") {
        self.var_ac82190a = 0;
        foreach (var_b6318641 in level.var_3d574fc8) {
            if (self hasperk(var_b6318641)) {
                self.var_ac82190a++;
            }
        }
    }
}

// Namespace zm_trial_acquire_perks/zm_trial_acquire_perks
// Params 1, eflags: 0x4
// Checksum 0xcc1da92f, Offset: 0x540
// Size: 0xae
function private function_665eb907(challenge) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    self.var_ac82190a = 0;
    while (true) {
        self function_9a9724b0();
        if (self.var_ac82190a >= challenge.var_a65fff71) {
            self zm_trial_util::function_9eca2595(1);
        } else {
            self zm_trial_util::function_9eca2595(0);
        }
        waitframe(1);
    }
}

