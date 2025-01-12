#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_full_ammo;

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 0, eflags: 0x6
// Checksum 0xb972a725, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_full_ammo", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 0, eflags: 0x5 linked
// Checksum 0x43d56805, Offset: 0xd0
// Size: 0x44
function private function_70a657d8() {
    zm_powerups::include_zombie_powerup("full_ammo");
    if (zm_powerups::function_cc33adc8()) {
        zm_powerups::add_zombie_powerup("full_ammo");
    }
}

