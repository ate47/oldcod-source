#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_reset_loadout;

// Namespace zm_trial_reset_loadout/zm_trial_reset_loadout
// Params 0, eflags: 0x2
// Checksum 0xc701453c, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_reset_loadout", &__init__, undefined, undefined);
}

// Namespace zm_trial_reset_loadout/zm_trial_reset_loadout
// Params 0, eflags: 0x0
// Checksum 0xcc1bb72, Offset: 0xc8
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"reset_loadout", &on_begin, &on_end);
}

// Namespace zm_trial_reset_loadout/zm_trial_reset_loadout
// Params 0, eflags: 0x4
// Checksum 0x5c6cc33b, Offset: 0x130
// Size: 0x10a
function private on_begin() {
    foreach (player in getplayers()) {
        player takeallweapons();
        player zm_loadout::give_start_weapon(1);
        player zm_loadout::init_player_offhand_weapons();
        for (slot = 0; slot < 3; slot++) {
            if (isdefined(player._gadgets_player[slot])) {
                player gadgetcharging(slot, 1);
            }
        }
    }
}

// Namespace zm_trial_reset_loadout/zm_trial_reset_loadout
// Params 1, eflags: 0x4
// Checksum 0x8ef66cae, Offset: 0x248
// Size: 0xc
function private on_end(round_reset) {
    
}

