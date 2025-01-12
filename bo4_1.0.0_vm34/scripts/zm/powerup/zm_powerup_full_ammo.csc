#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_full_ammo;

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 0, eflags: 0x2
// Checksum 0x6914e241, Offset: 0x90
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_full_ammo", &__init__, undefined, undefined);
}

// Namespace zm_powerup_full_ammo/zm_powerup_full_ammo
// Params 0, eflags: 0x0
// Checksum 0xc9ab9a8f, Offset: 0xd8
// Size: 0x44
function __init__() {
    zm_powerups::include_zombie_powerup("full_ammo");
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("full_ammo");
    }
}

