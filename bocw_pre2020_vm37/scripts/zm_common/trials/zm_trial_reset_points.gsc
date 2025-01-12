#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_reset_points;

// Namespace zm_trial_reset_points/zm_trial_reset_points
// Params 0, eflags: 0x6
// Checksum 0x83869cb0, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_reset_points", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_reset_points/zm_trial_reset_points
// Params 0, eflags: 0x4
// Checksum 0xf9fcb97a, Offset: 0xd8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"reset_points", &on_begin, &on_end);
}

// Namespace zm_trial_reset_points/zm_trial_reset_points
// Params 1, eflags: 0x4
// Checksum 0x301582e7, Offset: 0x140
// Size: 0xd0
function private on_begin(var_899c6d17) {
    if (isdefined(var_899c6d17)) {
        var_899c6d17 = zm_trial::function_5769f26a(var_899c6d17);
    } else {
        var_899c6d17 = 0;
    }
    wait 6;
    foreach (player in getplayers()) {
        player thread reset_points(var_899c6d17);
    }
}

// Namespace zm_trial_reset_points/zm_trial_reset_points
// Params 1, eflags: 0x4
// Checksum 0x850375ac, Offset: 0x218
// Size: 0x8c
function private reset_points(var_899c6d17) {
    if (self bgb::is_enabled(#"zm_bgb_shopping_free")) {
        self bgb::do_one_shot_use();
        self playsoundtoplayer(#"zmb_bgb_shoppingfree_coinreturn", self);
        return;
    }
    self.score = var_899c6d17;
    self.pers[#"score"] = var_899c6d17;
}

// Namespace zm_trial_reset_points/zm_trial_reset_points
// Params 1, eflags: 0x4
// Checksum 0x7102f71f, Offset: 0x2b0
// Size: 0xc
function private on_end(*round_reset) {
    
}

