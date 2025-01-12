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
// Params 0, eflags: 0x6
// Checksum 0x257a80c9, Offset: 0x110
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_hero_weapon_power", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_hero_weapon_power/zm_powerup_hero_weapon_power
// Params 0, eflags: 0x5 linked
// Checksum 0x8dd0288e, Offset: 0x158
// Size: 0x84
function private function_70a657d8() {
    zm_powerups::register_powerup("hero_weapon_power", &hero_weapon_power);
    if (zm_powerups::function_cc33adc8()) {
        zm_powerups::add_zombie_powerup("hero_weapon_power", "p8_zm_powerup_full_power", #"zombie_powerup_free_perk", &function_7e51ac0f, 1, 0, 0);
    }
}

// Namespace zm_powerup_hero_weapon_power/zm_powerup_hero_weapon_power
// Params 0, eflags: 0x1 linked
// Checksum 0x72cebdb8, Offset: 0x1e8
// Size: 0xe
function function_7e51ac0f() {
    return level.var_197c8eb1;
}

// Namespace zm_powerup_hero_weapon_power/zm_powerup_hero_weapon_power
// Params 1, eflags: 0x1 linked
// Checksum 0x544d8fb4, Offset: 0x200
// Size: 0x32
function hero_weapon_power(e_player) {
    e_player endon(#"death");
    e_player.var_8da24ed0 = e_player.var_fc8023b4;
}

