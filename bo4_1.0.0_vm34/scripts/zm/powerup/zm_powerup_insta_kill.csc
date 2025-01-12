#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_insta_kill;

// Namespace zm_powerup_insta_kill/zm_powerup_insta_kill
// Params 0, eflags: 0x2
// Checksum 0xd8de2e5f, Offset: 0xa0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_powerup_insta_kill", &__init__, undefined, undefined);
}

// Namespace zm_powerup_insta_kill/zm_powerup_insta_kill
// Params 0, eflags: 0x0
// Checksum 0xd0e37a96, Offset: 0xe8
// Size: 0x4c
function __init__() {
    zm_powerups::include_zombie_powerup("insta_kill");
    if (zm_powerups::function_b2585f85()) {
        zm_powerups::add_zombie_powerup("insta_kill", "powerup_instant_kill");
    }
}

