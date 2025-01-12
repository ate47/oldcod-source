#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_blockers;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;

#namespace zm_powerup_hero_weapon_power;

// Namespace zm_powerup_hero_weapon_power/zm_powerup_hero_weapon_power
// Params 0, eflags: 0x2
// Checksum 0x3410ff37, Offset: 0x110
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_hero_weapon_power", &__init__, undefined, undefined);
}

// Namespace zm_powerup_hero_weapon_power/zm_powerup_hero_weapon_power
// Params 0, eflags: 0x0
// Checksum 0xfe1c7e7a, Offset: 0x158
// Size: 0x84
function __init__() {
    zm_powerups::register_powerup("hero_weapon_power", &hero_weapon_power);
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("hero_weapon_power", "p8_zm_powerup_full_power", #"zombie_powerup_free_perk", &function_9d722ff3, 1, 0, 0);
    }
}

// Namespace zm_powerup_hero_weapon_power/zm_powerup_hero_weapon_power
// Params 0, eflags: 0x0
// Checksum 0x93d26158, Offset: 0x1e8
// Size: 0xe
function function_9d722ff3() {
    return level.var_864d5cc1;
}

// Namespace zm_powerup_hero_weapon_power/zm_powerup_hero_weapon_power
// Params 1, eflags: 0x0
// Checksum 0x38340d34, Offset: 0x200
// Size: 0x2c
function hero_weapon_power(e_player) {
    e_player gadgetpowerset(level.var_97b2d700, 100);
}

