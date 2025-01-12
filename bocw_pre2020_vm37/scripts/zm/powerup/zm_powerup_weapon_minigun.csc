#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_weapon_minigun;

// Namespace zm_powerup_weapon_minigun/zm_powerup_weapon_minigun
// Params 0, eflags: 0x6
// Checksum 0x64d980ab, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_weapon_minigun", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_weapon_minigun/zm_powerup_weapon_minigun
// Params 0, eflags: 0x4
// Checksum 0xe88daf43, Offset: 0xe0
// Size: 0x4c
function private function_70a657d8() {
    zm_powerups::include_zombie_powerup("minigun");
    if (zm_powerups::function_cc33adc8()) {
        zm_powerups::add_zombie_powerup("minigun", "powerup_mini_gun");
    }
}

