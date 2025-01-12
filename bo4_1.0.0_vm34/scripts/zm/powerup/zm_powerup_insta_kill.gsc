#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_utility;

#namespace zm_powerup_insta_kill;

// Namespace zm_powerup_insta_kill/zm_powerup_insta_kill
// Params 0, eflags: 0x2
// Checksum 0x994015fd, Offset: 0x148
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_insta_kill", &__init__, undefined, undefined);
}

// Namespace zm_powerup_insta_kill/zm_powerup_insta_kill
// Params 0, eflags: 0x0
// Checksum 0x2c7ff338, Offset: 0x190
// Size: 0x9c
function __init__() {
    zm_powerups::register_powerup("insta_kill", &grab_insta_kill);
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("insta_kill", "p7_zm_power_up_insta_kill", #"hash_1784640b956f2f85", &zm_powerups::func_should_always_drop, 0, 0, 0, undefined, "powerup_instant_kill", "zombie_powerup_insta_kill_time", "zombie_powerup_insta_kill_on");
    }
}

// Namespace zm_powerup_insta_kill/zm_powerup_insta_kill
// Params 1, eflags: 0x0
// Checksum 0x957c956c, Offset: 0x238
// Size: 0x8c
function grab_insta_kill(player) {
    if (zm_powerups::function_ffd24ecc(#"insta_kill")) {
        level thread function_64509808(self, player);
    } else {
        level thread insta_kill_powerup(self, player);
    }
    player thread zm_powerups::powerup_vo("insta_kill");
}

// Namespace zm_powerup_insta_kill/zm_powerup_insta_kill
// Params 2, eflags: 0x0
// Checksum 0x97a05409, Offset: 0x2d0
// Size: 0x120
function function_64509808(e_powerup, player) {
    player notify(#"powerup instakill");
    player endon(#"powerup instakill", #"disconnect");
    if (player bgb::is_enabled(#"zm_bgb_temporal_gift")) {
        n_wait_time = 60;
    } else {
        n_wait_time = 30;
    }
    player thread zm_powerups::function_e00ef9d4("insta_kill");
    player zombie_utility::set_zombie_var_player(#"zombie_insta_kill", 1);
    level waittilltimeout(n_wait_time, #"end_game");
    player zombie_utility::set_zombie_var_player(#"zombie_insta_kill", 0);
    player notify(#"insta_kill_over");
}

// Namespace zm_powerup_insta_kill/zm_powerup_insta_kill
// Params 2, eflags: 0x0
// Checksum 0x5d620e73, Offset: 0x3f8
// Size: 0x1c0
function insta_kill_powerup(drop_item, player) {
    level notify("powerup instakill_" + player.team);
    level endon("powerup instakill_" + player.team);
    if (isdefined(level.insta_kill_powerup_override)) {
        level thread [[ level.insta_kill_powerup_override ]](drop_item, player);
        return;
    }
    team = player.team;
    level thread zm_powerups::show_on_hud(team, "insta_kill");
    zombie_utility::set_zombie_var_team(#"zombie_insta_kill", team, 1);
    n_wait_time = 30;
    if (bgb::is_team_enabled(#"zm_bgb_temporal_gift")) {
        n_wait_time += 30;
    }
    wait n_wait_time;
    zombie_utility::set_zombie_var_team(#"zombie_insta_kill", team, 0);
    players = getplayers(team);
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i])) {
            players[i] notify(#"insta_kill_over");
        }
    }
}
