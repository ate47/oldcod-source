#using scripts\core_common\laststand_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_contracts;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_powerup_bonus_points_player;

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 0, eflags: 0x6
// Checksum 0x18b97deb, Offset: 0x120
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_bonus_points_player", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 0, eflags: 0x5 linked
// Checksum 0xfbaee674, Offset: 0x168
// Size: 0xf4
function private function_70a657d8() {
    zm_powerups::register_powerup("bonus_points_player", &grab_bonus_points_player);
    zm_powerups::register_powerup("bonus_points_player_shared", &function_ec014d54);
    if (zm_powerups::function_cc33adc8()) {
        zm_powerups::add_zombie_powerup("bonus_points_player", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_never_drop, 1, 0, 0);
        zm_powerups::add_zombie_powerup("bonus_points_player_shared", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_never_drop, 1, 0, 0);
    }
}

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 1, eflags: 0x1 linked
// Checksum 0xd34e72b0, Offset: 0x268
// Size: 0x74
function grab_bonus_points_player(player) {
    level thread bonus_points_player_powerup(self, player);
    player thread zm_powerups::powerup_vo("bonus");
    if (zm_utility::is_standard()) {
        player contracts::increment_zm_contract(#"contract_zm_rush_powerups");
    }
}

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 1, eflags: 0x1 linked
// Checksum 0xdf93f6e4, Offset: 0x2e8
// Size: 0xc4
function function_ec014d54(player) {
    level thread function_56784293(self, player);
    if (player !== self.var_2b5ec373) {
        player thread zm_powerups::powerup_vo("bonus");
        if (isdefined(self.var_2b5ec373) && !is_true(self.var_2b5ec373.var_a50db39d)) {
            self.var_2b5ec373.var_a50db39d = 1;
            self.var_2b5ec373 zm_stats::increment_challenge_stat(#"hash_733e96c5baacb1da");
        }
    }
}

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 2, eflags: 0x1 linked
// Checksum 0x2cb98908, Offset: 0x3b8
// Size: 0x154
function bonus_points_player_powerup(item, player) {
    if (is_true(item.var_258c5fbc)) {
        points = item.var_258c5fbc;
    } else if (is_true(level.var_a4c782b9)) {
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
    level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:player, #scoreevent:"bonus_points_powerup_zm"});
}

// Namespace zm_powerup_bonus_points_player/zm_powerup_bonus_points_player
// Params 2, eflags: 0x1 linked
// Checksum 0xbf078b28, Offset: 0x518
// Size: 0x8c
function function_56784293(item, player) {
    player notify(#"bonus_points_player_grabbed", {#e_powerup:item});
    level scoreevents::doscoreeventcallback("scoreEventZM", {#attacker:player, #scoreevent:"bonus_points_powerup_zm"});
}

