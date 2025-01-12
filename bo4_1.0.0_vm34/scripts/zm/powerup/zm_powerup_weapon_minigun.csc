#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_weapon_minigun;

// Namespace zm_powerup_weapon_minigun/zm_powerup_weapon_minigun
// Params 0, eflags: 0x2
// Checksum 0xc7b36fae, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_weapon_minigun", &__init__, undefined, undefined);
}

// Namespace zm_powerup_weapon_minigun/zm_powerup_weapon_minigun
// Params 0, eflags: 0x0
// Checksum 0x75f9e7fa, Offset: 0xe8
// Size: 0x4c
function __init__() {
    zm_powerups::include_zombie_powerup("minigun");
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("minigun", "powerup_mini_gun");
    }
}

