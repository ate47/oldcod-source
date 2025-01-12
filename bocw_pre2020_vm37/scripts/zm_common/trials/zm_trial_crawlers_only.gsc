#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_crawlers_only;

// Namespace zm_trial_crawlers_only/zm_trial_crawlers_only
// Params 0, eflags: 0x6
// Checksum 0xcd8c0a57, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_crawlers_only", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_crawlers_only/zm_trial_crawlers_only
// Params 0, eflags: 0x4
// Checksum 0x3936fc24, Offset: 0xb8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"crawlers_only", &on_begin, &on_end);
}

// Namespace zm_trial_crawlers_only/zm_trial_crawlers_only
// Params 0, eflags: 0x4
// Checksum 0x7af3b501, Offset: 0x120
// Size: 0x52
function private on_begin() {
    level.var_6d8a8e47 = 1;
    level.var_b38bb71 = 1;
    level.var_ef0aada0 = 1;
    level.var_d1b3ec4e = level.var_9b91564e;
    level.var_9b91564e = undefined;
}

// Namespace zm_trial_crawlers_only/zm_trial_crawlers_only
// Params 1, eflags: 0x4
// Checksum 0x8b9f39d3, Offset: 0x180
// Size: 0x4e
function private on_end(*round_reset) {
    level.var_6d8a8e47 = 0;
    level.var_b38bb71 = 0;
    level.var_ef0aada0 = 0;
    level.var_9b91564e = level.var_d1b3ec4e;
    level.var_d1b3ec4e = undefined;
}

