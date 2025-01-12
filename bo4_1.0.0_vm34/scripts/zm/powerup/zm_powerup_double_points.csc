#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_double_points;

// Namespace zm_powerup_double_points/zm_powerup_double_points
// Params 0, eflags: 0x2
// Checksum 0x564b2ad3, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_double_points", &__init__, undefined, undefined);
}

// Namespace zm_powerup_double_points/zm_powerup_double_points
// Params 0, eflags: 0x0
// Checksum 0x7f33818a, Offset: 0xf0
// Size: 0x4c
function __init__() {
    zm_powerups::include_zombie_powerup("double_points");
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("double_points", "powerup_double_points");
    }
}
