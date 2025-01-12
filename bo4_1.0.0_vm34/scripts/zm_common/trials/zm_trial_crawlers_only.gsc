#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_crawlers_only;

// Namespace zm_trial_crawlers_only/zm_trial_crawlers_only
// Params 0, eflags: 0x2
// Checksum 0xc1a05ba6, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_crawlers_only", &__init__, undefined, undefined);
}

// Namespace zm_trial_crawlers_only/zm_trial_crawlers_only
// Params 0, eflags: 0x0
// Checksum 0x7c6c5df9, Offset: 0xc0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"crawlers_only", &on_begin, &on_end);
}

// Namespace zm_trial_crawlers_only/zm_trial_crawlers_only
// Params 0, eflags: 0x4
// Checksum 0xf65b24df, Offset: 0x128
// Size: 0x62
function private on_begin() {
    level.var_a7873a6 = 1;
    level.var_28d1499a = 1;
    level.var_ae44635d = 1;
    level.var_fe2329bd = 1;
    level.var_25928f80 = level.var_e856e41a;
    level.var_e856e41a = undefined;
}

// Namespace zm_trial_crawlers_only/zm_trial_crawlers_only
// Params 1, eflags: 0x4
// Checksum 0x6f97f35b, Offset: 0x198
// Size: 0x5e
function private on_end(round_reset) {
    level.var_a7873a6 = 0;
    level.var_28d1499a = 0;
    level.var_ae44635d = 0;
    level.var_fe2329bd = 0;
    level.var_e856e41a = level.var_25928f80;
    level.var_25928f80 = undefined;
}

