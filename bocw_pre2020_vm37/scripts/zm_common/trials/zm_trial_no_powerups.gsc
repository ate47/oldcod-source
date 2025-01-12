#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_round_logic;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_trial;

#namespace zm_trial_no_powerups;

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 0, eflags: 0x6
// Checksum 0x9aa6c47d, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_trial_no_powerups", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 0, eflags: 0x5 linked
// Checksum 0x28a0f7c5, Offset: 0xe0
// Size: 0x5c
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    zm_trial::register_challenge(#"no_powerups", &on_begin, &on_end);
}

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 0, eflags: 0x5 linked
// Checksum 0x7d1c6d0b, Offset: 0x148
// Size: 0xb0
function private on_begin() {
    self.active = 1;
    self.enemies_killed = 0;
    zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 80);
    zm_spawner::register_zombie_death_event_callback(&function_138aec8e);
    kill_count = zm_powerups::function_2ff352cc();
    if (!isdefined(level.var_1dce56cc) || kill_count < level.var_1dce56cc) {
        level.var_1dce56cc = kill_count;
    }
}

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 1, eflags: 0x5 linked
// Checksum 0xf010fa70, Offset: 0x200
// Size: 0xb4
function private on_end(*round_reset) {
    self.active = 0;
    zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_per_round", 4);
    level.var_1dce56cc = level.n_total_kills + randomintrangeinclusive(15, 25);
    zombie_utility::set_zombie_var(#"zombie_drop_item", 0);
    zm_spawner::deregister_zombie_death_event_callback(&function_138aec8e);
}

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xb90f7ece, Offset: 0x2c0
// Size: 0x54
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"no_powerups");
    return isdefined(challenge) && is_true(challenge.active);
}

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0x81d89348, Offset: 0x320
// Size: 0xf2
function function_2fc5f13() {
    challenge = zm_trial::function_a36e8c38(#"no_powerups");
    assert(isdefined(challenge));
    var_5843af96 = zm_round_logic::get_zombie_count_for_round(level.round_number, getplayers().size);
    frac = math::clamp(challenge.enemies_killed / var_5843af96, 0, 1);
    modifier = lerpfloat(25, 40, frac);
    return modifier;
}

// Namespace zm_trial_no_powerups/zm_trial_no_powerups
// Params 1, eflags: 0x5 linked
// Checksum 0x6bd28372, Offset: 0x420
// Size: 0xa0
function private function_138aec8e(attacker) {
    if (!isplayer(attacker) && !is_true(self.nuked)) {
        return;
    }
    challenge = zm_trial::function_a36e8c38(#"no_powerups");
    assert(isdefined(challenge));
    challenge.enemies_killed++;
}

