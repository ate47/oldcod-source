#using scripts\core_common\callbacks_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\trials\zm_trial_defend_area;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;

#namespace namespace_9b24ce43;

// Namespace namespace_9b24ce43/namespace_9b24ce43
// Params 0, eflags: 0x6
// Checksum 0x7744cd36, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_678d56e299d40621", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_9b24ce43/namespace_9b24ce43
// Params 0, eflags: 0x4
// Checksum 0xd99ef266, Offset: 0xe8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_32cdfeca4a793d78", &on_begin, &on_end);
}

// Namespace namespace_9b24ce43/namespace_9b24ce43
// Params 0, eflags: 0x4
// Checksum 0xc88b84ce, Offset: 0x150
// Size: 0x90
function private on_begin() {
    foreach (player in getplayers()) {
        player thread movement_watcher();
    }
}

// Namespace namespace_9b24ce43/namespace_9b24ce43
// Params 1, eflags: 0x4
// Checksum 0x8d449c77, Offset: 0x1e8
// Size: 0x94
function private on_end(*round_reset) {
    foreach (player in getplayers()) {
        player notify(#"hash_17c41292130032eb");
    }
}

// Namespace namespace_9b24ce43/namespace_9b24ce43
// Params 0, eflags: 0x0
// Checksum 0x596e4e92, Offset: 0x288
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"hash_32cdfeca4a793d78");
    return isdefined(challenge);
}

// Namespace namespace_9b24ce43/namespace_9b24ce43
// Params 0, eflags: 0x4
// Checksum 0x6049083f, Offset: 0x2c8
// Size: 0x2c2
function private movement_watcher() {
    self endon(#"disconnect", #"hash_17c41292130032eb");
    wait zm_round_logic::get_delay_between_rounds() - 2;
    while (true) {
        var_89276ce9 = 0;
        var_197c85d1 = self getvelocity();
        n_speed = length(var_197c85d1);
        var_f77522bb = self getnormalizedmovement();
        if (isalive(self) && !self laststand::player_is_in_laststand() && n_speed > 0 && !self zm_utility::is_jumping() && var_f77522bb != (0, 0, 0)) {
            if (isdefined(self.armor) && self.armor > 0) {
                if (!zm_trial_defend_area::is_active() || zm_trial_defend_area::is_active() && is_true(self.var_ccee13fc)) {
                    self playsoundtoplayer(#"hash_6df374d848ba6a60", self);
                    self dodamage(11, self.origin);
                    var_89276ce9 = 1;
                }
            } else if (!zm_trial_defend_area::is_active() || zm_trial_defend_area::is_active() && is_true(self.var_ccee13fc)) {
                self playsoundtoplayer(#"hash_6df374d848ba6a60", self);
                self dodamage(6, self.origin);
                var_89276ce9 = 1;
            }
        }
        if (var_89276ce9) {
            if (zm_trial_defend_area::is_active() && is_true(self.var_ccee13fc)) {
                wait 1;
            } else {
                wait 0.2;
            }
            continue;
        }
        waitframe(1);
    }
}
