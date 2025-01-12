#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace namespace_919f68ad;

// Namespace namespace_919f68ad/namespace_919f68ad
// Params 0, eflags: 0x6
// Checksum 0x35c90e4d, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_37398b26e502cdde", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_919f68ad/namespace_919f68ad
// Params 0, eflags: 0x4
// Checksum 0xc9edc56, Offset: 0xe0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_2bec904229ece9ed", &on_begin, &on_end);
}

// Namespace namespace_919f68ad/namespace_919f68ad
// Params 1, eflags: 0x4
// Checksum 0x6a82868a, Offset: 0x148
// Size: 0x10c
function private on_begin(var_49106f6b) {
    level.var_60aa7ebf = zm_trial::function_5769f26a(var_49106f6b);
    foreach (player in getplayers()) {
        player.var_e47444a5 = [];
        player zm_trial_util::function_2190356a(0);
        player zm_trial_util::function_c2cd0cba(level.var_60aa7ebf);
    }
    callback::on_ai_killed(&on_ai_killed);
}

// Namespace namespace_919f68ad/namespace_919f68ad
// Params 1, eflags: 0x4
// Checksum 0xe502d177, Offset: 0x260
// Size: 0x1e0
function private on_end(round_reset) {
    if (!round_reset) {
        var_696c3b4 = [];
        foreach (player in getplayers()) {
            if (player.var_e47444a5.size < level.var_60aa7ebf) {
                if (!isdefined(var_696c3b4)) {
                    var_696c3b4 = [];
                } else if (!isarray(var_696c3b4)) {
                    var_696c3b4 = array(var_696c3b4);
                }
                var_696c3b4[var_696c3b4.size] = player;
            }
        }
        if (var_696c3b4.size) {
            zm_trial::fail(#"hash_2ad223a26dff12a0", var_696c3b4);
        }
    }
    callback::remove_on_ai_killed(&on_ai_killed);
    level.var_60aa7ebf = undefined;
    foreach (player in getplayers()) {
        player zm_trial_util::function_f3aacffb();
    }
}

// Namespace namespace_919f68ad/namespace_919f68ad
// Params 0, eflags: 0x0
// Checksum 0x6907c2e5, Offset: 0x448
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"hash_2bec904229ece9ed");
    return isdefined(challenge);
}

// Namespace namespace_919f68ad/namespace_919f68ad
// Params 1, eflags: 0x4
// Checksum 0x15fe057, Offset: 0x488
// Size: 0x2a4
function private on_ai_killed(params) {
    if (isplayer(params.eattacker)) {
        player = params.eattacker;
    } else if (isplayer(params.einflictor)) {
        player = params.einflictor;
    }
    if (!isdefined(player) || isai(params.einflictor)) {
        return;
    }
    if (player.var_e47444a5.size >= level.var_60aa7ebf) {
        return;
    }
    if (zm_utility::is_mini_turret(params.weapon, 1)) {
        w_root = getweapon(#"mini_turret");
    } else if (zm_utility::function_850e7499(params.weapon, 1)) {
        w_root = getweapon(#"eq_wraith_fire");
    } else {
        w_root = zm_weapons::function_93cd8e76(params.weapon, 1);
    }
    if (isdefined(level.var_a601d6a6)) {
        w_root = player [[ level.var_a601d6a6 ]](w_root);
    }
    if (!isinarray(player.var_e47444a5, w_root)) {
        if (!isdefined(player.var_e47444a5)) {
            player.var_e47444a5 = [];
        } else if (!isarray(player.var_e47444a5)) {
            player.var_e47444a5 = array(player.var_e47444a5);
        }
        player.var_e47444a5[player.var_e47444a5.size] = w_root;
        if (player.var_e47444a5.size == level.var_60aa7ebf) {
            player zm_trial_util::function_63060af4(1);
            return;
        }
        player zm_trial_util::function_2190356a(player.var_e47444a5.size);
        player zm_trial_util::function_c2cd0cba(level.var_60aa7ebf);
    }
}
