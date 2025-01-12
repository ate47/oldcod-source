#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_survive;

// Namespace zm_trial_survive/zm_trial_survive
// Params 0, eflags: 0x6
// Checksum 0x83843e4e, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_survive", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_survive/zm_trial_survive
// Params 0, eflags: 0x4
// Checksum 0x38227966, Offset: 0xb8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"survive", &on_begin, &on_end);
}

// Namespace zm_trial_survive/zm_trial_survive
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x120
// Size: 0x4
function private on_begin() {
    
}

// Namespace zm_trial_survive/zm_trial_survive
// Params 1, eflags: 0x4
// Checksum 0x48e0b403, Offset: 0x130
// Size: 0xc
function private on_end(*round_reset) {
    
}

