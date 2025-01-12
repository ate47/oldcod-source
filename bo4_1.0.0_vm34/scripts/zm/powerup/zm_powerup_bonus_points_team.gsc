#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;

#namespace zm_powerup_bonus_points_team;

// Namespace zm_powerup_bonus_points_team/zm_powerup_bonus_points_team
// Params 0, eflags: 0x2
// Checksum 0x771bb503, Offset: 0xd0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_bonus_points_team", &__init__, undefined, undefined);
}

// Namespace zm_powerup_bonus_points_team/zm_powerup_bonus_points_team
// Params 0, eflags: 0x0
// Checksum 0xe8bbd4eb, Offset: 0x118
// Size: 0x84
function __init__() {
    zm_powerups::register_powerup("bonus_points_team", &grab_bonus_points_team);
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("bonus_points_team", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_always_drop, 0, 0, 0);
    }
}

// Namespace zm_powerup_bonus_points_team/zm_powerup_bonus_points_team
// Params 1, eflags: 0x0
// Checksum 0x9a405f31, Offset: 0x1a8
// Size: 0x44
function grab_bonus_points_team(player) {
    level thread bonus_points_team_powerup(self, player);
    player thread zm_powerups::powerup_vo("bonus");
}

// Namespace zm_powerup_bonus_points_team/zm_powerup_bonus_points_team
// Params 2, eflags: 0x0
// Checksum 0xb0bc8269, Offset: 0x1f8
// Size: 0x120
function bonus_points_team_powerup(item, player) {
    if (isdefined(level.var_8601d990) && level.var_8601d990) {
        points = randomintrange(2, 11) * 100;
    } else {
        points = 500;
    }
    if (isdefined(level.bonus_points_powerup_override)) {
        points = item [[ level.bonus_points_powerup_override ]](player);
    }
    foreach (e_player in level.players) {
        e_player zm_score::player_add_points("bonus_points_powerup", points, undefined, undefined, undefined, undefined, 1);
    }
}

