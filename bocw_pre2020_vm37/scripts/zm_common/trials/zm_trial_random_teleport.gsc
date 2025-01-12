#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_weapons;

#namespace zm_trial_random_teleport;

// Namespace zm_trial_random_teleport/zm_trial_random_teleport
// Params 0, eflags: 0x6
// Checksum 0x4168dcd6, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_random_teleport", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_random_teleport/zm_trial_random_teleport
// Params 0, eflags: 0x4
// Checksum 0xd404a854, Offset: 0x100
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"random_teleport", &on_begin, &on_end);
}

// Namespace zm_trial_random_teleport/zm_trial_random_teleport
// Params 2, eflags: 0x4
// Checksum 0x680ae24f, Offset: 0x168
// Size: 0xe0
function private on_begin(n_min_time, n_max_time) {
    level.var_935c100a = zm_trial::function_5769f26a(n_min_time);
    level.var_33146b2e = zm_trial::function_5769f26a(n_max_time);
    foreach (player in getplayers()) {
        player thread function_6a04c6e6();
    }
}

// Namespace zm_trial_random_teleport/zm_trial_random_teleport
// Params 1, eflags: 0x4
// Checksum 0x34c9b76f, Offset: 0x250
// Size: 0xe8
function private on_end(*round_reset) {
    level notify(#"hash_34f9cf7500b33c6b");
    foreach (player in getplayers()) {
        player val::reset(#"hash_7d2b25df35ca5b3", "freezecontrols");
        player val::reset(#"hash_7d2b25df35ca5b3", "ignoreme");
    }
}

// Namespace zm_trial_random_teleport/zm_trial_random_teleport
// Params 0, eflags: 0x0
// Checksum 0xb37a7a7e, Offset: 0x340
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"random_teleport");
    return isdefined(challenge);
}

// Namespace zm_trial_random_teleport/zm_trial_random_teleport
// Params 0, eflags: 0x4
// Checksum 0x83e0cd97, Offset: 0x380
// Size: 0xc8
function private function_6a04c6e6() {
    self endon(#"disconnect");
    level endon(#"hash_34f9cf7500b33c6b", #"end_game");
    while (true) {
        wait randomfloatrange(level.var_935c100a, level.var_33146b2e);
        if (isalive(self)) {
            if (self isusingoffhand()) {
                self forceoffhandend();
            }
            self zm_bgb_anywhere_but_here::activation(0);
        }
    }
}

