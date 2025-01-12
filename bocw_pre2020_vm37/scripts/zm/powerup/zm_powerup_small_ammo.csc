#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_small_ammo;

// Namespace zm_powerup_small_ammo/zm_powerup_small_ammo
// Params 0, eflags: 0x6
// Checksum 0x713eb2f0, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_small_ammo", &__init__, undefined, undefined, undefined);
}

// Namespace zm_powerup_small_ammo/zm_powerup_small_ammo
// Params 0, eflags: 0x1 linked
// Checksum 0x2247128b, Offset: 0xd0
// Size: 0x44
function __init__() {
    zm_powerups::include_zombie_powerup("small_ammo");
    if (zm_powerups::function_cc33adc8()) {
        zm_powerups::add_zombie_powerup("small_ammo");
    }
}

