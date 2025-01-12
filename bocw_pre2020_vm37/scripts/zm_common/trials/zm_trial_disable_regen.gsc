#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_disable_regen;

// Namespace zm_trial_disable_regen/zm_trial_disable_regen
// Params 0, eflags: 0x6
// Checksum 0xc370585b, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_disable_regen", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_disable_regen/zm_trial_disable_regen
// Params 0, eflags: 0x4
// Checksum 0x84c9022b, Offset: 0x100
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"disable_regen", &on_begin, &on_end);
}

// Namespace zm_trial_disable_regen/zm_trial_disable_regen
// Params 0, eflags: 0x4
// Checksum 0x4f246410, Offset: 0x168
// Size: 0xa0
function private on_begin() {
    foreach (player in getplayers()) {
        player val::set("trials_disable_regen", "health_regen", 0);
    }
}

// Namespace zm_trial_disable_regen/zm_trial_disable_regen
// Params 1, eflags: 0x4
// Checksum 0x676e516e, Offset: 0x210
// Size: 0xa8
function private on_end(*round_reset) {
    foreach (player in getplayers()) {
        player val::reset("trials_disable_regen", "health_regen");
    }
}

// Namespace zm_trial_disable_regen/zm_trial_disable_regen
// Params 1, eflags: 0x0
// Checksum 0x9ae8e4cd, Offset: 0x2c0
// Size: 0x3a
function is_active(*var_34f09024) {
    challenge = zm_trial::function_a36e8c38(#"disable_regen");
    return isdefined(challenge);
}

