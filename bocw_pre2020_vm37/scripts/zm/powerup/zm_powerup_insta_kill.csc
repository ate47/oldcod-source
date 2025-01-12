#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_insta_kill;

// Namespace zm_powerup_insta_kill/zm_powerup_insta_kill
// Params 0, eflags: 0x6
// Checksum 0xc27c9913, Offset: 0xa0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_insta_kill", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_insta_kill/zm_powerup_insta_kill
// Params 0, eflags: 0x5 linked
// Checksum 0x8d65625e, Offset: 0xe8
// Size: 0x4c
function private function_70a657d8() {
    zm_powerups::include_zombie_powerup("insta_kill");
    if (zm_powerups::function_cc33adc8()) {
        zm_powerups::add_zombie_powerup("insta_kill", "powerup_instant_kill");
    }
}

