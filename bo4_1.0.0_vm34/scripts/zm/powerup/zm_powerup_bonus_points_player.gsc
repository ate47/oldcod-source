#using scripts\core_common\laststand_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;

#namespace zm_powerup_bonus_points_player;

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 0, eflags: 0x2
// Checksum 0xf03b524f, Offset: 0x108
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_bonus_points_player", &__init__, undefined, undefined);
}

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 0, eflags: 0x0
// Checksum 0x37f4b951, Offset: 0x150
// Size: 0xf4
function __init__() {
    zm_powerups::register_powerup("bonus_points_player", &grab_bonus_points_player);
    zm_powerups::register_powerup("bonus_points_player_shared", &function_9998325f);
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("bonus_points_player", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_never_drop, 1, 0, 0);
        zm_powerups::add_zombie_powerup("bonus_points_player_shared", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_never_drop, 1, 0, 0);
    }
}

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 1, eflags: 0x0
// Checksum 0x477fdc47, Offset: 0x250
// Size: 0x44
function grab_bonus_points_player(player) {
    level thread bonus_points_player_powerup(self, player);
    player thread zm_powerups::powerup_vo("bonus");
}

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 1, eflags: 0x0
// Checksum 0x4e0ac43, Offset: 0x2a0
// Size: 0x44
function function_9998325f(player) {
    level thread function_32c6fba1(self, player);
    player thread zm_powerups::powerup_vo("bonus");
}

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 2, eflags: 0x0
// Checksum 0xd96dca21, Offset: 0x2f0
// Size: 0x114
function bonus_points_player_powerup(item, player) {
    if (isdefined(level.var_8601d990) && level.var_8601d990) {
        points = randomintrange(1, 25) * 100;
    } else {
        points = 500;
    }
    if (isdefined(level.bonus_points_powerup_override)) {
        points = item [[ level.bonus_points_powerup_override ]](player);
    }
    if (isdefined(item.bonus_points_powerup_override)) {
        points = item [[ item.bonus_points_powerup_override ]](player);
    }
    player notify(#"bonus_points_player_grabbed", {#e_powerup:item});
    player zm_score::player_add_points("bonus_points_powerup", points, undefined, undefined, undefined, undefined, 1);
}

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 2, eflags: 0x0
// Checksum 0xa8f3c567, Offset: 0x410
// Size: 0x74
function function_32c6fba1(item, player) {
    player notify(#"bonus_points_player_grabbed", {#e_powerup:item});
    player zm_score::player_add_points("bonus_points_powerup_shared", 500, undefined, undefined, undefined, undefined, 1);
}

