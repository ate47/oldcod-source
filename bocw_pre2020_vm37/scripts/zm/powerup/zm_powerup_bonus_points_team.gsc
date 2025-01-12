#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;

#namespace zm_powerup_bonus_points_team;

// Namespace zm_powerup_bonus_points_team/zm_powerup_bonus_points_team
// Params 0, eflags: 0x6
// Checksum 0xabec9974, Offset: 0xe8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_bonus_points_team", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_bonus_points_team/zm_powerup_bonus_points_team
// Params 0, eflags: 0x5 linked
// Checksum 0x6b3a5124, Offset: 0x130
// Size: 0x84
function private function_70a657d8() {
    zm_powerups::register_powerup("bonus_points_team", &grab_bonus_points_team);
    if (zm_powerups::function_cc33adc8()) {
        zm_powerups::add_zombie_powerup("bonus_points_team", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_always_drop, 0, 0, 0);
    }
}

// Namespace zm_powerup_bonus_points_team/zm_powerup_bonus_points_team
// Params 1, eflags: 0x1 linked
// Checksum 0xf23b9cea, Offset: 0x1c0
// Size: 0x44
function grab_bonus_points_team(player) {
    level thread bonus_points_team_powerup(self, player);
    player thread zm_powerups::powerup_vo("bonus");
}

// Namespace zm_powerup_bonus_points_team/zm_powerup_bonus_points_team
// Params 2, eflags: 0x1 linked
// Checksum 0xe6546a48, Offset: 0x210
// Size: 0x148
function bonus_points_team_powerup(item, player) {
    if (is_true(level.var_a4c782b9)) {
        points = randomintrange(2, 11) * 100;
    } else {
        points = 500;
    }
    if (isdefined(level.bonus_points_powerup_override)) {
        points = item [[ level.bonus_points_powerup_override ]](player);
    }
    foreach (e_player in level.players) {
        level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:e_player, #scoreevent:"bonus_points_powerup_zm"});
    }
}

