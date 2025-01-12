#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_kill_with_special;

// Namespace zm_trial_kill_with_special/zm_trial_kill_with_special
// Params 0, eflags: 0x6
// Checksum 0xa162670f, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"kill_with_special", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_kill_with_special/zm_trial_kill_with_special
// Params 0, eflags: 0x4
// Checksum 0x53fc75d, Offset: 0xc8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"kill_with_special", &on_begin, &on_end);
}

// Namespace zm_trial_kill_with_special/zm_trial_kill_with_special
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x130
// Size: 0x4
function private on_begin() {
    
}

// Namespace zm_trial_kill_with_special/zm_trial_kill_with_special
// Params 1, eflags: 0x4
// Checksum 0xfde054e0, Offset: 0x140
// Size: 0xa8
function private on_end(round_reset) {
    if (round_reset) {
        foreach (e_player in level.players) {
            e_player gadgetpowerset(level.var_a53a05b5, 100);
        }
    }
}

