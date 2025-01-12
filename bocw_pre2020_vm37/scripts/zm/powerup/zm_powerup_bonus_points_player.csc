#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_bonus_points_player;

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 0, eflags: 0x6
// Checksum 0x3bbdf59a, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_bonus_points_player", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 0, eflags: 0x5 linked
// Checksum 0x6fe4f590, Offset: 0xf8
// Size: 0x64
function private function_70a657d8() {
    zm_powerups::include_zombie_powerup("bonus_points_player");
    zm_powerups::add_zombie_powerup("bonus_points_player");
    zm_powerups::include_zombie_powerup("bonus_points_player_shared");
    zm_powerups::add_zombie_powerup("bonus_points_player_shared");
}

