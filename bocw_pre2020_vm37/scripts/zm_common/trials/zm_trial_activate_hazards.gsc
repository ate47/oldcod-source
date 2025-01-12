#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace zm_trial_activate_hazards;

// Namespace zm_trial_activate_hazards/zm_trial_activate_hazards
// Params 0, eflags: 0x6
// Checksum 0x82e598a6, Offset: 0x78
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_activate_hazards", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_activate_hazards/zm_trial_activate_hazards
// Params 0, eflags: 0x4
// Checksum 0xb29242d, Offset: 0xc0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"activate_hazards", &on_begin, &on_end);
}

// Namespace zm_trial_activate_hazards/zm_trial_activate_hazards
// Params 0, eflags: 0x4
// Checksum 0x3589cccf, Offset: 0x128
// Size: 0x14
function private on_begin() {
    level.var_2d307e50 = 1;
}

// Namespace zm_trial_activate_hazards/zm_trial_activate_hazards
// Params 1, eflags: 0x4
// Checksum 0xc8df4500, Offset: 0x148
// Size: 0x16
function private on_end(*round_reset) {
    level.var_2d307e50 = undefined;
}

