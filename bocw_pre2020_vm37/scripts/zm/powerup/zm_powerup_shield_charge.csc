#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_shield_charge;

// Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
// Params 0, eflags: 0x6
// Checksum 0xd44eea86, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_shield_charge", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_shield_charge/zm_powerup_shield_charge
// Params 0, eflags: 0x4
// Checksum 0x5e4d93cb, Offset: 0xd0
// Size: 0x34
function private function_70a657d8() {
    zm_powerups::include_zombie_powerup("shield_charge");
    zm_powerups::add_zombie_powerup("shield_charge");
}

