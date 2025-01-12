#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_safe_zone;

// Namespace zm_trial_safe_zone/zm_trial_safe_zone
// Params 0, eflags: 0x6
// Checksum 0xfab7e1a1, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_safe_zone", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_safe_zone/zm_trial_safe_zone
// Params 0, eflags: 0x4
// Checksum 0x74578c86, Offset: 0xe0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"safe_zone", &on_begin, &on_end);
}

// Namespace zm_trial_safe_zone/zm_trial_safe_zone
// Params 2, eflags: 0x4
// Checksum 0x748c1369, Offset: 0x148
// Size: 0x1f0
function private on_begin(var_e84d35d1, var_16e6b8ea) {
    var_e9433d0 = struct::get_array(var_e84d35d1);
    assert(var_e9433d0.size, "<dev string:x38>");
    var_64e17761 = [];
    foreach (var_93154b10 in var_e9433d0) {
        assert(isdefined(var_93154b10.target), "<dev string:x68>");
        var_94d5ccbc = getentarray(var_93154b10.target, "targetname");
        var_64e17761 = arraycombine(var_64e17761, var_94d5ccbc, 0, 0);
    }
    var_16e6b8ea = zm_trial::function_5769f26a(var_16e6b8ea);
    foreach (player in getplayers()) {
        player thread function_68b149a2(var_64e17761, var_16e6b8ea);
    }
}

// Namespace zm_trial_safe_zone/zm_trial_safe_zone
// Params 1, eflags: 0x4
// Checksum 0xbf357dbe, Offset: 0x340
// Size: 0xc
function private on_end(*round_reset) {
    
}

// Namespace zm_trial_safe_zone/zm_trial_safe_zone
// Params 2, eflags: 0x0
// Checksum 0xc5e84075, Offset: 0x358
// Size: 0x15c
function function_68b149a2(var_64e17761, var_16e6b8ea) {
    level endon(#"hash_7646638df88a3656");
    self endon(#"disconnect");
    wait 12;
    while (true) {
        var_4cda8676 = 0;
        foreach (var_c1f5749f in var_64e17761) {
            if (self istouching(var_c1f5749f)) {
                var_4cda8676 = 1;
                break;
            }
        }
        if (!var_4cda8676 && isalive(self) && !self laststand::player_is_in_laststand()) {
            self dodamage(var_16e6b8ea, self.origin);
            wait 1;
        }
        waitframe(1);
    }
}

