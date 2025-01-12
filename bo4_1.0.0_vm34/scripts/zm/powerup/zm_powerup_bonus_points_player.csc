#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_bonus_points_player;

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 0, eflags: 0x2
// Checksum 0x6ed1cb6c, Offset: 0xb0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_bonus_points_player", &__init__, undefined, undefined);
}

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 0, eflags: 0x0
// Checksum 0x26fde255, Offset: 0xf8
// Size: 0x64
function __init__() {
    zm_powerups::include_zombie_powerup("bonus_points_player");
    zm_powerups::add_zombie_powerup("bonus_points_player");
    zm_powerups::include_zombie_powerup("bonus_points_player_shared");
    zm_powerups::add_zombie_powerup("bonus_points_player_shared");
}

