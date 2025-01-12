#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_use_magicbox;

// Namespace zm_trial_use_magicbox/zm_trial_use_magicbox
// Params 0, eflags: 0x2
// Checksum 0x7e2bca11, Offset: 0x90
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_use_magicbox", &__init__, undefined, undefined);
}

// Namespace zm_trial_use_magicbox/zm_trial_use_magicbox
// Params 0, eflags: 0x0
// Checksum 0xcd9e8b03, Offset: 0xd8
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"use_magicbox", &on_begin, &on_end);
}

// Namespace zm_trial_use_magicbox/zm_trial_use_magicbox
// Params 0, eflags: 0x4
// Checksum 0x534e139e, Offset: 0x140
// Size: 0xa0
function private on_begin() {
    callback::function_3089d7a2(&function_3089d7a2);
    foreach (player in getplayers()) {
        player thread function_71c7c3d2();
    }
}

// Namespace zm_trial_use_magicbox/zm_trial_use_magicbox
// Params 1, eflags: 0x4
// Checksum 0x590a2f9c, Offset: 0x1e8
// Size: 0x1d4
function private on_end(round_reset) {
    foreach (player in getplayers()) {
        player zm_trial_util::function_fccd8386();
    }
    if (!round_reset) {
        var_9fb91af5 = [];
        foreach (player in getplayers()) {
            if (!(isdefined(player.var_abed7d5d) && player.var_abed7d5d)) {
                array::add(var_9fb91af5, player, 0);
            }
            player.var_abed7d5d = undefined;
        }
        if (var_9fb91af5.size == 1) {
            zm_trial::fail(#"hash_9c83a93f783b8e4", var_9fb91af5);
        } else if (var_9fb91af5.size > 1) {
            zm_trial::fail(#"hash_484dffbaa43c048d", var_9fb91af5);
        }
    }
    callback::function_7d5c48f3(&function_3089d7a2);
}

// Namespace zm_trial_use_magicbox/zm_trial_use_magicbox
// Params 0, eflags: 0x4
// Checksum 0xb63c3970, Offset: 0x3c8
// Size: 0x86
function private function_71c7c3d2() {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    while (true) {
        if (isdefined(self.var_abed7d5d) && self.var_abed7d5d) {
            self zm_trial_util::function_9eca2595(1);
        } else {
            self zm_trial_util::function_9eca2595(0);
        }
        waitframe(1);
    }
}

// Namespace zm_trial_use_magicbox/zm_trial_use_magicbox
// Params 1, eflags: 0x4
// Checksum 0xd98f2fa4, Offset: 0x458
// Size: 0x1a
function private function_3089d7a2(weapon) {
    self.var_abed7d5d = 1;
}

