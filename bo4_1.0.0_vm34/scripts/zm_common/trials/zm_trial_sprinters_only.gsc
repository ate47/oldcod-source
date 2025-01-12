#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_sprinters_only;

// Namespace zm_trial_sprinters_only/zm_trial_sprinters_only
// Params 0, eflags: 0x2
// Checksum 0xdecf3884, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_sprinters_only", &__init__, undefined, undefined);
}

// Namespace zm_trial_sprinters_only/zm_trial_sprinters_only
// Params 0, eflags: 0x0
// Checksum 0x4d027780, Offset: 0xc8
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"sprinters_only", &on_begin, &on_end);
}

// Namespace zm_trial_sprinters_only/zm_trial_sprinters_only
// Params 0, eflags: 0x4
// Checksum 0x320df3eb, Offset: 0x130
// Size: 0x5a
function private on_begin() {
    level.var_b43e213c = "sprint";
    level.var_b02d530a = "sprint";
    level.var_28d1499a = 1;
    level.var_ae44635d = 1;
    level.var_fe2329bd = 1;
}

// Namespace zm_trial_sprinters_only/zm_trial_sprinters_only
// Params 1, eflags: 0x4
// Checksum 0x17a43620, Offset: 0x198
// Size: 0x46
function private on_end(round_reset) {
    level.var_b43e213c = undefined;
    level.var_b02d530a = undefined;
    level.var_28d1499a = 0;
    level.var_ae44635d = 0;
    level.var_fe2329bd = 0;
}

