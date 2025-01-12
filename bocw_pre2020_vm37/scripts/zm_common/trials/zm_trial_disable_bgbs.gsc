#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_bgb_pack;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_disable_bgbs;

// Namespace zm_trial_disable_bgbs/zm_trial_disable_bgbs
// Params 0, eflags: 0x6
// Checksum 0xeac38180, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_disable_bgbs", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_disable_bgbs/zm_trial_disable_bgbs
// Params 0, eflags: 0x5 linked
// Checksum 0x7be4ae, Offset: 0xc8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"disable_bgbs", &on_begin, &on_end);
}

// Namespace zm_trial_disable_bgbs/zm_trial_disable_bgbs
// Params 0, eflags: 0x5 linked
// Checksum 0xb03f9c17, Offset: 0x130
// Size: 0xd8
function private on_begin() {
    level zm_trial::function_2b3a3307(1);
    level zm_trial::function_19a1098f(1);
    foreach (player in getplayers()) {
        player bgb::take();
        player bgb_pack::function_ac9cb612(1);
    }
}

// Namespace zm_trial_disable_bgbs/zm_trial_disable_bgbs
// Params 1, eflags: 0x5 linked
// Checksum 0xdfc17c7e, Offset: 0x210
// Size: 0xc8
function private on_end(*round_reset) {
    level zm_trial::function_2b3a3307(0);
    level zm_trial::function_19a1098f(0);
    foreach (player in getplayers()) {
        player bgb_pack::function_ac9cb612(0);
    }
}

// Namespace zm_trial_disable_bgbs/zm_trial_disable_bgbs
// Params 0, eflags: 0x1 linked
// Checksum 0x5807203d, Offset: 0x2e0
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"disable_bgbs");
    return isdefined(challenge);
}

