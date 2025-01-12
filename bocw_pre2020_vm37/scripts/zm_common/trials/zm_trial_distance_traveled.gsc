#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_trial_distance_traveled;

// Namespace zm_trial_distance_traveled/zm_trial_distance_traveled
// Params 0, eflags: 0x6
// Checksum 0xc18c4c27, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_distance_traveled", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_distance_traveled/zm_trial_distance_traveled
// Params 0, eflags: 0x4
// Checksum 0x519a3e16, Offset: 0xe8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"distance_traveled", &on_begin, &on_end);
}

// Namespace zm_trial_distance_traveled/zm_trial_distance_traveled
// Params 1, eflags: 0x4
// Checksum 0xe8072022, Offset: 0x150
// Size: 0x194
function private on_begin(var_38282db8) {
    var_38282db8 = zm_trial::function_5769f26a(var_38282db8);
    foreach (player in getplayers()) {
        player thread function_ed4d5d4(var_38282db8);
    }
    level.var_4220f02a = array(getweapon(#"launcher_standard_t8"), getweapon(#"hash_138efe2bb30be63c"), getweapon(#"hash_138f012bb30beb55"), getweapon(#"hash_46ad37ce8122812e"), getweapon(#"hash_138f002bb30be9a2"), getweapon(#"hash_3a8348f19a7e7629"));
}

// Namespace zm_trial_distance_traveled/zm_trial_distance_traveled
// Params 1, eflags: 0x4
// Checksum 0x63741816, Offset: 0x2f0
// Size: 0x16
function private on_end(*round_reset) {
    level.var_4220f02a = undefined;
}

// Namespace zm_trial_distance_traveled/zm_trial_distance_traveled
// Params 0, eflags: 0x0
// Checksum 0xcc4f4462, Offset: 0x310
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"distance_traveled");
    return isdefined(challenge);
}

// Namespace zm_trial_distance_traveled/zm_trial_distance_traveled
// Params 1, eflags: 0x0
// Checksum 0x9a4f5212, Offset: 0x350
// Size: 0x240
function function_ed4d5d4(var_38282db8) {
    self endon(#"disconnect");
    level endon(#"hash_7646638df88a3656", #"end_game", #"hash_43a461e5c99d52a0");
    n_distance_traveled = 0;
    self zm_trial_util::function_2190356a(int(n_distance_traveled), 1);
    self zm_trial_util::function_c2cd0cba(var_38282db8);
    wait 12;
    var_31409e15 = self.origin;
    while (true) {
        var_abf38d09 = distance(self.origin, var_31409e15) * 0.0254;
        if (isalive(self)) {
            if (self function_e7985d50()) {
                while (self function_e7985d50()) {
                    var_31409e15 = self.origin;
                    waitframe(1);
                }
            } else {
                n_distance_traveled += var_abf38d09;
            }
        }
        if (n_distance_traveled < var_38282db8) {
            self zm_trial_util::function_2190356a(int(n_distance_traveled), 1);
            self zm_trial_util::function_c2cd0cba(var_38282db8);
        } else {
            self zm_trial_util::function_2190356a(var_38282db8);
            self zm_trial_util::function_c2cd0cba(var_38282db8);
            zm_trial::fail(#"hash_1ab078fa9460e7c9", array(self));
            level notify(#"hash_43a461e5c99d52a0");
            return;
        }
        var_31409e15 = self.origin;
        waitframe(1);
    }
}

// Namespace zm_trial_distance_traveled/zm_trial_distance_traveled
// Params 0, eflags: 0x0
// Checksum 0x6b6b0de2, Offset: 0x598
// Size: 0x148
function function_e7985d50() {
    if (is_true(self.var_16735873) || self util::function_88c74107() || is_true(self.var_ffe2c4d7) || is_true(self.var_25c3de32)) {
        return true;
    }
    w_weapon = self getcurrentweapon();
    w_weapon = zm_weapons::get_base_weapon(w_weapon);
    var_f77522bb = self getnormalizedmovement();
    if (isarray(level.var_4220f02a) && self isfiring() && isinarray(level.var_4220f02a, w_weapon) && var_f77522bb == (0, 0, 0)) {
        return true;
    }
    return false;
}

