#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb_pack;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_disable_bgbs;

// Namespace zm_trial_disable_bgbs/zm_trial_disable_bgbs
// Params 0, eflags: 0x2
// Checksum 0x4f3ba72f, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_disable_bgbs", &__init__, undefined, undefined);
}

// Namespace zm_trial_disable_bgbs/zm_trial_disable_bgbs
// Params 0, eflags: 0x0
// Checksum 0x48fdfacf, Offset: 0xc8
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"disable_bgbs", &on_begin, &on_end);
}

// Namespace zm_trial_disable_bgbs/zm_trial_disable_bgbs
// Params 0, eflags: 0x4
// Checksum 0x2c91f848, Offset: 0x130
// Size: 0xb8
function private on_begin() {
    level zm_trial::function_e6903c38(1);
    level zm_trial::function_a30785f9(1);
    foreach (player in getplayers()) {
        player bgb_pack::function_f27f6f96(1);
    }
}

// Namespace zm_trial_disable_bgbs/zm_trial_disable_bgbs
// Params 1, eflags: 0x4
// Checksum 0xa036a038, Offset: 0x1f0
// Size: 0xc0
function private on_end(round_reset) {
    level zm_trial::function_e6903c38(0);
    level zm_trial::function_a30785f9(0);
    foreach (player in getplayers()) {
        player bgb_pack::function_f27f6f96(0);
    }
}

// Namespace zm_trial_disable_bgbs/zm_trial_disable_bgbs
// Params 0, eflags: 0x0
// Checksum 0x2ba9ee5a, Offset: 0x2b8
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_871c1f7f(#"disable_bgbs");
    return isdefined(challenge);
}

