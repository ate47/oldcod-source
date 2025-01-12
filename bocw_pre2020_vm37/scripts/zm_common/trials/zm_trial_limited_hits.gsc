#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_weapons;

#namespace zm_trial_limited_hits;

// Namespace zm_trial_limited_hits/zm_trial_limited_hits
// Params 0, eflags: 0x6
// Checksum 0x49f779c1, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_limited_hits", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_limited_hits/zm_trial_limited_hits
// Params 0, eflags: 0x4
// Checksum 0x3f3c9456, Offset: 0xd8
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"limited_hits", &on_begin, &on_end);
}

// Namespace zm_trial_limited_hits/zm_trial_limited_hits
// Params 2, eflags: 0x4
// Checksum 0xb0affde7, Offset: 0x140
// Size: 0xd4
function private on_begin(var_85af3be4, var_752d90ad) {
    if (getplayers().size == 1) {
        level.var_b529249b = zm_trial::function_5769f26a(var_752d90ad);
    } else {
        level.var_b529249b = zm_trial::function_5769f26a(var_85af3be4);
    }
    level.var_4b9163d5 = 0;
    zm_trial_util::function_2976fa44(level.var_b529249b);
    zm_trial_util::function_dace284(level.var_b529249b, 1);
    callback::on_player_damage(&on_player_damage);
}

// Namespace zm_trial_limited_hits/zm_trial_limited_hits
// Params 1, eflags: 0x4
// Checksum 0x9ed49208, Offset: 0x220
// Size: 0x54
function private on_end(*round_reset) {
    zm_trial_util::function_f3dbeda7();
    level.var_b529249b = undefined;
    level.var_4b9163d5 = undefined;
    callback::remove_on_player_damage(&on_player_damage);
}

// Namespace zm_trial_limited_hits/zm_trial_limited_hits
// Params 0, eflags: 0x0
// Checksum 0x88d5c296, Offset: 0x280
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"limited_hits");
    return isdefined(challenge);
}

// Namespace zm_trial_limited_hits/zm_trial_limited_hits
// Params 1, eflags: 0x4
// Checksum 0x5d8c296d, Offset: 0x2c0
// Size: 0x9c
function private on_player_damage(params) {
    if (params.idamage >= 0) {
        level.var_4b9163d5++;
        zm_trial_util::function_dace284(level.var_b529249b - level.var_4b9163d5);
        if (level.var_4b9163d5 >= level.var_b529249b) {
            zm_trial::fail(#"hash_404865fbf8dd5cc2", array(self));
        }
    }
}

