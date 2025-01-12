#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_powerups;

#namespace zm_bgb_extra_credit;

// Namespace zm_bgb_extra_credit/zm_bgb_extra_credit
// Params 0, eflags: 0x2
// Checksum 0xfea15020, Offset: 0xa8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_extra_credit", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_extra_credit/zm_bgb_extra_credit
// Params 0, eflags: 0x0
// Checksum 0x3ecf458e, Offset: 0xf8
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_extra_credit", "activated", 1, undefined, undefined, undefined, &activation);
}

// Namespace zm_bgb_extra_credit/zm_bgb_extra_credit
// Params 0, eflags: 0x0
// Checksum 0xdbe642fd, Offset: 0x168
// Size: 0x44
function activation() {
    powerup_origin = self bgb::get_player_dropped_powerup_origin();
    self thread function_b18c3b2d(powerup_origin, 96);
}

// Namespace zm_bgb_extra_credit/zm_bgb_extra_credit
// Params 2, eflags: 0x0
// Checksum 0x83b661d2, Offset: 0x1b8
// Size: 0xec
function function_b18c3b2d(origin, var_f9bb25f4) {
    self endon(#"disconnect");
    self endon(#"bled_out");
    e_powerup = zm_powerups::specific_powerup_drop("bonus_points_player", origin, undefined, 0.1, undefined, undefined, 1);
    e_powerup.bonus_points_powerup_override = &function_3258dd42;
    wait 1;
    if (isdefined(e_powerup) && !e_powerup zm_player::in_enabled_playable_area(var_f9bb25f4) && !e_powerup zm_player::in_life_brush()) {
        level thread bgb::function_434235f9(e_powerup);
    }
}

// Namespace zm_bgb_extra_credit/zm_bgb_extra_credit
// Params 1, eflags: 0x0
// Checksum 0x4b076796, Offset: 0x2b0
// Size: 0x10
function function_3258dd42(player) {
    return 1250;
}

