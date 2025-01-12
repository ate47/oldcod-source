#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_disable_hud;

// Namespace zm_trial_disable_hud/zm_trial_disable_hud
// Params 0, eflags: 0x2
// Checksum 0x3a53a10f, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_disable_hud", &__init__, undefined, undefined);
}

// Namespace zm_trial_disable_hud/zm_trial_disable_hud
// Params 0, eflags: 0x0
// Checksum 0xe2718730, Offset: 0xf0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"disable_hud", &on_begin, &on_end);
}

// Namespace zm_trial_disable_hud/zm_trial_disable_hud
// Params 0, eflags: 0x4
// Checksum 0x56a7b056, Offset: 0x158
// Size: 0xb8
function private on_begin() {
    level.var_fc04f28d = 1;
    level clientfield::set_world_uimodel("ZMHudGlobal.trials.hudDeactivated", 1);
    foreach (player in getplayers()) {
        player function_319b02e(0);
    }
}

// Namespace zm_trial_disable_hud/zm_trial_disable_hud
// Params 1, eflags: 0x4
// Checksum 0x63ad0d6d, Offset: 0x218
// Size: 0xc0
function private on_end(round_reset) {
    level clientfield::set_world_uimodel("ZMHudGlobal.trials.hudDeactivated", 0);
    level.var_fc04f28d = undefined;
    foreach (player in getplayers()) {
        player function_319b02e(1);
    }
}

