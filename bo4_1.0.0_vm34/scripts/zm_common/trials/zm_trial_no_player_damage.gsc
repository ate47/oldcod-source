#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_no_player_damage;

// Namespace zm_trial_no_player_damage/zm_trial_no_player_damage
// Params 0, eflags: 0x2
// Checksum 0x2b2ec4c7, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_no_player_damage", &__init__, undefined, undefined);
}

// Namespace zm_trial_no_player_damage/zm_trial_no_player_damage
// Params 0, eflags: 0x0
// Checksum 0x6d820af6, Offset: 0xd0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"hash_293a2fd65ffe0222", &on_begin, &on_end);
}

// Namespace zm_trial_no_player_damage/zm_trial_no_player_damage
// Params 0, eflags: 0x4
// Checksum 0xc2cec0ad, Offset: 0x138
// Size: 0x90
function private on_begin() {
    foreach (player in getplayers()) {
        player callback::on_player_damage(&on_player_damage);
    }
}

// Namespace zm_trial_no_player_damage/zm_trial_no_player_damage
// Params 1, eflags: 0x4
// Checksum 0x7d9418f0, Offset: 0x1d0
// Size: 0x98
function private on_end(round_reset) {
    foreach (player in getplayers()) {
        player callback::remove_on_player_damage(&on_player_damage);
    }
}

// Namespace zm_trial_no_player_damage/zm_trial_no_player_damage
// Params 1, eflags: 0x4
// Checksum 0xaa3c1042, Offset: 0x270
// Size: 0x64
function private on_player_damage(params) {
    if (params.idamage > 0) {
        var_9fb91af5 = [];
        array::add(var_9fb91af5, self, 0);
        zm_trial::fail(#"hash_41122a695bc6065d", var_9fb91af5);
    }
}

