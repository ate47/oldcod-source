#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_weapons;

#namespace zm_trial_double_damage;

// Namespace zm_trial_double_damage/zm_trial_double_damage
// Params 0, eflags: 0x6
// Checksum 0x9cd4cdf2, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_double_damage", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_double_damage/zm_trial_double_damage
// Params 0, eflags: 0x4
// Checksum 0xbcdf9d70, Offset: 0xd8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"double_damage", &on_begin, &on_end);
}

// Namespace zm_trial_double_damage/zm_trial_double_damage
// Params 0, eflags: 0x4
// Checksum 0x5be49d6, Offset: 0x140
// Size: 0x84
function private on_begin() {
    self.var_42fe565a = level.var_c739ead9;
    self.var_c98099cd = level.var_cfbc34ae;
    self.var_3ab281b2 = level.var_5a59b382;
    self.var_c7f3b69b = level.var_97850f30;
    level.var_c739ead9 = 2;
    level.var_cfbc34ae = 2;
    level.var_5a59b382 = 2;
    level.var_97850f30 = 2;
}

// Namespace zm_trial_double_damage/zm_trial_double_damage
// Params 1, eflags: 0x4
// Checksum 0xe1a9bd3d, Offset: 0x1d0
// Size: 0x4c
function private on_end(*round_reset) {
    level.var_c739ead9 = self.var_42fe565a;
    level.var_cfbc34ae = self.var_c98099cd;
    level.var_5a59b382 = self.var_3ab281b2;
    level.var_97850f30 = self.var_c7f3b69b;
}

// Namespace zm_trial_double_damage/zm_trial_double_damage
// Params 0, eflags: 0x0
// Checksum 0x353645c9, Offset: 0x228
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"double_damage");
    return isdefined(challenge);
}

