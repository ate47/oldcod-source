#using scripts\core_common\array_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_use_pack_a_punch;

// Namespace zm_trial_use_pack_a_punch/zm_trial_use_pack_a_punch
// Params 0, eflags: 0x2
// Checksum 0x4f6bb342, Offset: 0x90
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_use_pack_a_punch", &__init__, undefined, undefined);
}

// Namespace zm_trial_use_pack_a_punch/zm_trial_use_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x10c114b4, Offset: 0xd8
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"use_pack_a_punch", &on_begin, &on_end);
}

// Namespace zm_trial_use_pack_a_punch/zm_trial_use_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x21d9dae8, Offset: 0x140
// Size: 0xa0
function private on_begin() {
    callback::function_388eb102(&function_388eb102);
    foreach (player in getplayers()) {
        player thread function_554875a4();
    }
}

// Namespace zm_trial_use_pack_a_punch/zm_trial_use_pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0x68c44b1a, Offset: 0x1e8
// Size: 0x1d4
function private on_end(round_reset) {
    foreach (player in getplayers()) {
        player zm_trial_util::function_fccd8386();
    }
    if (!round_reset) {
        var_9fb91af5 = [];
        foreach (player in getplayers()) {
            if (!(isdefined(player.var_8c8a5ed0) && player.var_8c8a5ed0)) {
                array::add(var_9fb91af5, player, 0);
            }
            player.var_8c8a5ed0 = undefined;
        }
        if (var_9fb91af5.size == 1) {
            zm_trial::fail(#"hash_6dbd3c476c903f66", var_9fb91af5);
        } else if (var_9fb91af5.size > 1) {
            zm_trial::fail(#"hash_59d734dda39935cf", var_9fb91af5);
        }
    }
    callback::function_9d2f5a23(&function_388eb102);
}

// Namespace zm_trial_use_pack_a_punch/zm_trial_use_pack_a_punch
// Params 0, eflags: 0x4
// Checksum 0x8ead1a4d, Offset: 0x3c8
// Size: 0x86
function private function_554875a4() {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    while (true) {
        if (isdefined(self.var_8c8a5ed0) && self.var_8c8a5ed0) {
            self zm_trial_util::function_9eca2595(1);
        } else {
            self zm_trial_util::function_9eca2595(0);
        }
        waitframe(1);
    }
}

// Namespace zm_trial_use_pack_a_punch/zm_trial_use_pack_a_punch
// Params 1, eflags: 0x4
// Checksum 0x75a24451, Offset: 0x458
// Size: 0x1a
function private function_388eb102(upgraded_weapon) {
    self.var_8c8a5ed0 = 1;
}

