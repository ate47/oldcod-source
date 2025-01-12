#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;

#namespace zm_trial_turn_on_power;

// Namespace zm_trial_turn_on_power/zm_trial_turn_on_power
// Params 0, eflags: 0x6
// Checksum 0xc30f59eb, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_turn_on_power", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_turn_on_power/zm_trial_turn_on_power
// Params 0, eflags: 0x4
// Checksum 0x9881bc1f, Offset: 0xd0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"turn_on_power", &on_begin, &on_end);
}

// Namespace zm_trial_turn_on_power/zm_trial_turn_on_power
// Params 1, eflags: 0x4
// Checksum 0xff1e18bc, Offset: 0x138
// Size: 0x3c
function private on_begin(*weapon_name) {
    zm_trial_util::function_7d32b7d0(0);
    level thread function_83b71e7c();
}

// Namespace zm_trial_turn_on_power/zm_trial_turn_on_power
// Params 1, eflags: 0x4
// Checksum 0x18d4bd9c, Offset: 0x180
// Size: 0xac
function private on_end(round_reset) {
    zm_trial_util::function_f3dbeda7();
    if (!round_reset) {
        if (!level flag::get(level.var_5bfd847e)) {
            if (zm_utility::get_story() == 1) {
                zm_trial::fail(#"hash_ad3c47f53414b85");
                return;
            }
            zm_trial::fail(#"hash_765b6a6e9523c15a");
        }
    }
}

// Namespace zm_trial_turn_on_power/zm_trial_turn_on_power
// Params 0, eflags: 0x4
// Checksum 0xc94da396, Offset: 0x238
// Size: 0xa8
function private function_83b71e7c() {
    level endon(#"hash_7646638df88a3656");
    self endon(#"death");
    while (true) {
        level flag::wait_till(level.var_5bfd847e);
        zm_trial_util::function_7d32b7d0(1);
        level flag::wait_till_clear(level.var_5bfd847e);
        zm_trial_util::function_7d32b7d0(0);
    }
}

