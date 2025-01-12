#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_powerup_free_perk;

// Namespace zm_powerup_free_perk/zm_powerup_free_perk
// Params 0, eflags: 0x2
// Checksum 0x5499b64f, Offset: 0x108
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_free_perk", &__init__, undefined, undefined);
}

// Namespace zm_powerup_free_perk/zm_powerup_free_perk
// Params 0, eflags: 0x0
// Checksum 0xa072af51, Offset: 0x150
// Size: 0x84
function __init__() {
    zm_powerups::register_powerup("free_perk", &grab_free_perk);
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("free_perk", "zombie_pickup_perk_bottle", #"zombie_powerup_free_perk", &zm_powerups::func_should_never_drop, 0, 0, 0);
    }
}

// Namespace zm_powerup_free_perk/zm_powerup_free_perk
// Params 1, eflags: 0x0
// Checksum 0xdc668547, Offset: 0x1e0
// Size: 0xf0
function grab_free_perk(var_25ab3c81) {
    foreach (e_player in level.players) {
        if (!e_player laststand::player_is_in_laststand() && e_player.sessionstate != "spectator") {
            var_70221ebf = e_player zm_perks::function_57435073();
            if (isdefined(var_70221ebf) && isdefined(level.var_7b162f9e)) {
                e_player [[ level.var_7b162f9e ]](var_70221ebf);
            }
        }
    }
}

