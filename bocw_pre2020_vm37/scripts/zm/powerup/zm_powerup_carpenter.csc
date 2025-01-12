#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;

#namespace zm_powerup_carpenter;

// Namespace zm_powerup_carpenter/zm_powerup_carpenter
// Params 0, eflags: 0x6
// Checksum 0xf806f198, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_powerup_carpenter", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_powerup_carpenter/zm_powerup_carpenter
// Params 0, eflags: 0x5 linked
// Checksum 0xdc5cae0, Offset: 0xd0
// Size: 0x34
function private function_70a657d8() {
    zm_powerups::include_zombie_powerup("carpenter");
    zm_powerups::add_zombie_powerup("carpenter");
}

