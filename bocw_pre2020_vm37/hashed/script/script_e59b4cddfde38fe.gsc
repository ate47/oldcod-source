#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;

#namespace namespace_5f342394;

// Namespace namespace_5f342394/namespace_5f342394
// Params 0, eflags: 0x6
// Checksum 0x1ebcaf5b, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_6c9de9db7f3e44a3", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_5f342394/namespace_5f342394
// Params 0, eflags: 0x4
// Checksum 0xbae10f09, Offset: 0xe8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_6c9de9db7f3e44a3", &on_begin, &on_end);
}

// Namespace namespace_5f342394/namespace_5f342394
// Params 9, eflags: 0x4
// Checksum 0x97c7a9ef, Offset: 0x150
// Size: 0x25c
function private on_begin(var_a84ac7c8, *str_archetype, n_kill_count, *str_destination, str_zone1, str_zone2, var_588808b1, var_91e2fb66, var_84245fe9) {
    str_zones = [str_zone1, str_zone2, var_588808b1, var_91e2fb66, var_84245fe9];
    arrayremovevalue(str_zones, undefined, 0);
    level.var_8c6f70d0 = [];
    foreach (str_zone in str_zones) {
        if (!isdefined(level.var_8c6f70d0)) {
            level.var_8c6f70d0 = [];
        } else if (!isarray(level.var_8c6f70d0)) {
            level.var_8c6f70d0 = array(level.var_8c6f70d0);
        }
        if (!isinarray(level.var_8c6f70d0, str_zone)) {
            level.var_8c6f70d0[level.var_8c6f70d0.size] = str_zone;
        }
    }
    level.var_c23449d8 = zm_trial::function_5769f26a(str_destination);
    self.var_925854c7 = n_kill_count;
    level.var_fbca3288 = 0;
    zm_trial_util::function_2976fa44(level.var_c23449d8);
    zm_trial_util::function_dace284(0);
    callback::on_ai_killed(&on_ai_killed);
}

// Namespace namespace_5f342394/namespace_5f342394
// Params 1, eflags: 0x4
// Checksum 0xa1eb10e4, Offset: 0x3b8
// Size: 0xa4
function private on_end(*round_reset) {
    zm_trial_util::function_f3dbeda7();
    n_remaining = level.var_c23449d8;
    level.var_c23449d8 = undefined;
    level.var_925854c7 = undefined;
    level.var_fbca3288 = undefined;
    callback::remove_on_ai_killed(&on_ai_killed);
    if (n_remaining > 0) {
        zm_trial::fail(self.var_925854c7, level.players);
    }
}

// Namespace namespace_5f342394/namespace_5f342394
// Params 1, eflags: 0x4
// Checksum 0xd1b1d5a6, Offset: 0x468
// Size: 0x11c
function private on_ai_killed(*params) {
    if (self.archetype === #"gladiator" && level.var_c23449d8 > 0) {
        var_d217c89e = 0;
        foreach (str_zone in level.var_8c6f70d0) {
            if (self zm_zonemgr::entity_in_zone(str_zone, 1)) {
                var_d217c89e = 1;
            }
        }
        if (var_d217c89e) {
            level.var_c23449d8--;
            level.var_fbca3288++;
            zm_trial_util::function_dace284(level.var_fbca3288);
        }
    }
}

// Namespace namespace_5f342394/namespace_5f342394
// Params 0, eflags: 0x4
// Checksum 0x911a14a0, Offset: 0x590
// Size: 0x3c
function private function_492f4c79() {
    level endon(#"hash_7646638df88a3656");
    wait 12;
    zm_utility::function_75fd65f9(self.var_f7f308cd, 1);
}

