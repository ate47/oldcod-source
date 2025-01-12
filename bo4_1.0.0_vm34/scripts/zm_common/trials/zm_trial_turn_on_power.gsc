#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_turn_on_power;

// Namespace zm_trial_turn_on_power/zm_trial_turn_on_power
// Params 0, eflags: 0x2
// Checksum 0xa2583148, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_turn_on_power", &__init__, undefined, undefined);
}

// Namespace zm_trial_turn_on_power/zm_trial_turn_on_power
// Params 0, eflags: 0x0
// Checksum 0x12b0a98b, Offset: 0xd0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"turn_on_power", &on_begin, &on_end);
}

// Namespace zm_trial_turn_on_power/zm_trial_turn_on_power
// Params 1, eflags: 0x4
// Checksum 0x5caf78e3, Offset: 0x138
// Size: 0xa0
function private on_begin(weapon_name) {
    zm_trial_util::function_722a8267(0);
    foreach (player in getplayers()) {
        player thread function_8715d970();
    }
}

// Namespace zm_trial_turn_on_power/zm_trial_turn_on_power
// Params 1, eflags: 0x4
// Checksum 0xf4d40cc7, Offset: 0x1e0
// Size: 0x64
function private on_end(round_reset) {
    zm_trial_util::function_59861180();
    if (!round_reset) {
        if (!level flag::get(level.var_8b3ad83a)) {
            zm_trial::fail(#"hash_ad3c47f53414b85");
        }
    }
}

// Namespace zm_trial_turn_on_power/zm_trial_turn_on_power
// Params 0, eflags: 0x4
// Checksum 0xb1b08d77, Offset: 0x250
// Size: 0x8e
function private function_8715d970() {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656");
    while (true) {
        if (level flag::get(level.var_8b3ad83a)) {
            zm_trial_util::function_722a8267(1);
        } else {
            zm_trial_util::function_722a8267(0);
        }
        waitframe(1);
    }
}

