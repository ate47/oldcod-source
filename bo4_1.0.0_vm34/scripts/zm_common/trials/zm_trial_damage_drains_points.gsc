#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_damage_drains_points;

// Namespace zm_trial_damage_drains_points/zm_trial_damage_drains_points
// Params 0, eflags: 0x2
// Checksum 0xdd4163b2, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_damage_drains_points", &__init__, undefined, undefined);
}

// Namespace zm_trial_damage_drains_points/zm_trial_damage_drains_points
// Params 0, eflags: 0x0
// Checksum 0xc5a40433, Offset: 0xc0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"damage_drains_points", &on_begin, &on_end);
}

// Namespace zm_trial_damage_drains_points/zm_trial_damage_drains_points
// Params 0, eflags: 0x4
// Checksum 0x22985604, Offset: 0x128
// Size: 0x12
function private on_begin() {
    level.var_132a7f92 = 100;
}

// Namespace zm_trial_damage_drains_points/zm_trial_damage_drains_points
// Params 1, eflags: 0x4
// Checksum 0x82e5c138, Offset: 0x148
// Size: 0x16
function private on_end(round_reset) {
    level.var_132a7f92 = undefined;
}

