#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_damage_drains_points;

// Namespace zm_trial_damage_drains_points/zm_trial_damage_drains_points
// Params 0, eflags: 0x6
// Checksum 0xeef8aaa2, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_damage_drains_points", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_damage_drains_points/zm_trial_damage_drains_points
// Params 0, eflags: 0x5 linked
// Checksum 0x386be00b, Offset: 0xd8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"damage_drains_points", &on_begin, &on_end);
}

// Namespace zm_trial_damage_drains_points/zm_trial_damage_drains_points
// Params 2, eflags: 0x5 linked
// Checksum 0xef289886, Offset: 0x140
// Size: 0xb8
function private on_begin(var_66fe7443, var_ec90b685) {
    if (isdefined(var_ec90b685)) {
        self.var_ec90b685 = 1;
        callback::on_ai_killed(&function_8e0401ab);
        level.var_a58dc99e = zm_trial::function_5769f26a(var_66fe7443);
        return;
    }
    var_620e7dea = zm_trial::function_5769f26a(var_66fe7443) / 100;
    level.var_baf7ae7f = level.var_a2d8b7eb;
    level.var_a2d8b7eb = var_620e7dea;
}

// Namespace zm_trial_damage_drains_points/zm_trial_damage_drains_points
// Params 1, eflags: 0x5 linked
// Checksum 0x7110ea91, Offset: 0x200
// Size: 0x76
function private on_end(*round_reset) {
    if (is_true(self.var_ec90b685)) {
        callback::remove_on_ai_killed(&function_8e0401ab);
        level.var_a58dc99e = undefined;
        self.var_ec90b685 = undefined;
        return;
    }
    level.var_a2d8b7eb = level.var_baf7ae7f;
    level.var_baf7ae7f = undefined;
}

// Namespace zm_trial_damage_drains_points/zm_trial_damage_drains_points
// Params 1, eflags: 0x1 linked
// Checksum 0x684b44b, Offset: 0x280
// Size: 0x86
function is_active(var_a32bbdd = 0) {
    s_challenge = zm_trial::function_a36e8c38(#"damage_drains_points");
    if (var_a32bbdd) {
        if (isdefined(s_challenge) && is_true(s_challenge.var_ec90b685)) {
            return true;
        }
        return false;
    }
    return isdefined(s_challenge);
}

// Namespace zm_trial_damage_drains_points/zm_trial_damage_drains_points
// Params 1, eflags: 0x5 linked
// Checksum 0x386c1618, Offset: 0x310
// Size: 0xec
function private function_8e0401ab(params) {
    if (is_true(self.nuked)) {
        a_players = function_a1ef346b();
        var_fc97ca4d = array::random(a_players);
        if (isplayer(var_fc97ca4d)) {
            var_fc97ca4d zm_score::minus_to_player_score(level.var_a58dc99e, 1);
        }
        return;
    }
    if (isplayer(params.eattacker)) {
        params.eattacker zm_score::minus_to_player_score(level.var_a58dc99e, 1);
    }
}

