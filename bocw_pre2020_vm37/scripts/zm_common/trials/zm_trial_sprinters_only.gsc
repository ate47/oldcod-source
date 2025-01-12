#using script_444bc5b4fa0fe14f;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_sprinters_only;

// Namespace zm_trial_sprinters_only/zm_trial_sprinters_only
// Params 0, eflags: 0x6
// Checksum 0x1d02d7a9, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_sprinters_only", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_sprinters_only/zm_trial_sprinters_only
// Params 0, eflags: 0x4
// Checksum 0x9f673d23, Offset: 0xd0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"sprinters_only", &on_begin, &on_end);
}

// Namespace zm_trial_sprinters_only/zm_trial_sprinters_only
// Params 0, eflags: 0x4
// Checksum 0xff261c35, Offset: 0x138
// Size: 0x56
function private on_begin() {
    level.var_43fb4347 = "sprint";
    level.var_102b1301 = "sprint";
    level.var_b38bb71 = 1;
    level.var_ef0aada0 = 1;
    if (namespace_c56530a8::is_active()) {
    }
}

// Namespace zm_trial_sprinters_only/zm_trial_sprinters_only
// Params 1, eflags: 0x4
// Checksum 0x709e08e8, Offset: 0x198
// Size: 0x3c
function private on_end(*round_reset) {
    level.var_43fb4347 = undefined;
    level.var_102b1301 = undefined;
    level.var_b38bb71 = 0;
    level.var_ef0aada0 = 0;
}
