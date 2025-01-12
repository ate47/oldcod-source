#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_weapons;

#namespace zm_trial_close_quarters;

// Namespace zm_trial_close_quarters/zm_trial_close_quarters
// Params 0, eflags: 0x6
// Checksum 0x31cdfbc4, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_close_quarters", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_close_quarters/zm_trial_close_quarters
// Params 0, eflags: 0x4
// Checksum 0x2d6deae4, Offset: 0xd8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"close_quarters", &on_begin, &on_end);
}

// Namespace zm_trial_close_quarters/zm_trial_close_quarters
// Params 0, eflags: 0x4
// Checksum 0x3ebdda3, Offset: 0x140
// Size: 0x24
function private on_begin() {
    zm::register_actor_damage_callback(&range_check);
}

// Namespace zm_trial_close_quarters/zm_trial_close_quarters
// Params 1, eflags: 0x4
// Checksum 0x352da563, Offset: 0x170
// Size: 0x64
function private on_end(*round_reset) {
    if (isinarray(level.actor_damage_callbacks, &range_check)) {
        arrayremovevalue(level.actor_damage_callbacks, &range_check, 0);
    }
}

// Namespace zm_trial_close_quarters/zm_trial_close_quarters
// Params 0, eflags: 0x0
// Checksum 0xc1e1453c, Offset: 0x1e0
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"close_quarters");
    return isdefined(challenge);
}

// Namespace zm_trial_close_quarters/zm_trial_close_quarters
// Params 12, eflags: 0x4
// Checksum 0xe77b393d, Offset: 0x220
// Size: 0x11a
function private range_check(inflictor, attacker, damage, *flags, *meansofdeath, *weapon, *vpoint, *vdir, *shitloc, *psoffsettime, *boneindex, *surfacetype) {
    if (!isplayer(boneindex) && !isplayer(psoffsettime)) {
        return -1;
    }
    if (is_true(self.aat_turned)) {
        return surfacetype;
    }
    if (isdefined(boneindex.origin) && isdefined(self.origin) && distance2dsquared(boneindex.origin, self.origin) <= 122500) {
        return surfacetype;
    }
    return 0;
}

// Namespace zm_trial_close_quarters/zm_trial_close_quarters
// Params 1, eflags: 0x0
// Checksum 0x12d8661b, Offset: 0x348
// Size: 0x5a
function function_23d15bf3(var_f85889ce) {
    if (isplayer(var_f85889ce) && distance2dsquared(var_f85889ce.origin, self.origin) <= 122500) {
        return true;
    }
    return false;
}

