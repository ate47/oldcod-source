#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_no_powerups;

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 0, eflags: 0x2
// Checksum 0x5bc42958, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_trial_no_powerups", &__init__, undefined, undefined);
}

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 0, eflags: 0x0
// Checksum 0x851e95f3, Offset: 0xe0
// Size: 0x5c
function __init__() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"no_powerups", &on_begin, &on_end);
}

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 0, eflags: 0x4
// Checksum 0x8370c565, Offset: 0x148
// Size: 0x8a
function private on_begin() {
    self.active = 1;
    self.enemies_killed = 0;
    zm_spawner::register_zombie_death_event_callback(&function_db6decae);
    kill_count = zm_powerups::function_4b6d0e9a();
    if (!isdefined(level.var_ccce14c8) || kill_count < level.var_ccce14c8) {
        level.var_ccce14c8 = kill_count;
    }
}

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 1, eflags: 0x4
// Checksum 0x542de1d6, Offset: 0x1e0
// Size: 0x8c
function private on_end(round_reset) {
    self.active = 0;
    kill_count = zm_powerups::function_4b6d0e9a();
    if (!isdefined(level.var_ccce14c8) || kill_count > level.var_ccce14c8) {
        level.var_ccce14c8 = kill_count;
    }
    zm_spawner::deregister_zombie_death_event_callback(&function_db6decae);
}

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 0, eflags: 0x0
// Checksum 0x5a1f0067, Offset: 0x278
// Size: 0x56
function is_active() {
    challenge = zm_trial::function_871c1f7f(#"no_powerups");
    return isdefined(challenge) && isdefined(challenge.active) && challenge.active;
}

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 0, eflags: 0x0
// Checksum 0xcac15421, Offset: 0x2d8
// Size: 0xfa
function function_3de4413() {
    challenge = zm_trial::function_871c1f7f(#"no_powerups");
    assert(isdefined(challenge));
    var_5d993f2 = zm_round_logic::get_zombie_count_for_round(level.round_number, getplayers().size);
    frac = math::clamp(challenge.enemies_killed / var_5d993f2, 0, 1);
    modifier = lerpfloat(3, 6, frac);
    return modifier;
}

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 1, eflags: 0x4
// Checksum 0x4e59fa53, Offset: 0x3e0
// Size: 0x98
function private function_db6decae(attacker) {
    if (!isplayer(attacker) && !(isdefined(self.nuked) && self.nuked)) {
        return;
    }
    challenge = zm_trial::function_871c1f7f(#"no_powerups");
    assert(isdefined(challenge));
    challenge.enemies_killed++;
}

