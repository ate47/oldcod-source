#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_utility;

#namespace zm_trial_headshots_only;

// Namespace zm_trial_headshots_only/zm_trial_headshots_only
// Params 0, eflags: 0x2
// Checksum 0xb239642c, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_headshots_only", &__init__, undefined, undefined);
}

// Namespace zm_trial_headshots_only/zm_trial_headshots_only
// Params 0, eflags: 0x0
// Checksum 0x96655870, Offset: 0xd0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"headshots_only", &on_begin, &on_end);
}

// Namespace zm_trial_headshots_only/zm_trial_headshots_only
// Params 1, eflags: 0x4
// Checksum 0xb98b5bed, Offset: 0x138
// Size: 0x2a
function private on_begin(weapon_name) {
    level.var_28d1499a = 1;
    level.var_ae44635d = 1;
}

// Namespace zm_trial_headshots_only/zm_trial_headshots_only
// Params 1, eflags: 0x4
// Checksum 0x5e029424, Offset: 0x170
// Size: 0x26
function private on_end(round_reset) {
    level.var_28d1499a = 0;
    level.var_ae44635d = 0;
}

// Namespace zm_trial_headshots_only/zm_trial_headshots_only
// Params 0, eflags: 0x0
// Checksum 0x6aed297e, Offset: 0x1a0
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_871c1f7f(#"headshots_only");
    return isdefined(challenge);
}

