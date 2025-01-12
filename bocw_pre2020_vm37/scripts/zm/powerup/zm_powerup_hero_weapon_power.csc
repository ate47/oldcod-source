#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_hero_weapon_power;

// Namespace zm_powerup_hero_weapon_power/zm_powerup_hero_weapon_power
// Params 0, eflags: 0x6
// Checksum 0x10d5c6e5, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_hero_weapon_power", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_hero_weapon_power/zm_powerup_hero_weapon_power
// Params 0, eflags: 0x5 linked
// Checksum 0xdc5cae0, Offset: 0xd8
// Size: 0x34
function private function_70a657d8() {
    zm_powerups::include_zombie_powerup("hero_weapon_power");
    zm_powerups::add_zombie_powerup("hero_weapon_power");
}

