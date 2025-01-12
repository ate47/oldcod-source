#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_kill_joy;

// Namespace zm_bgb_kill_joy/zm_bgb_kill_joy
// Params 0, eflags: 0x2
// Checksum 0x45a13ae3, Offset: 0x90
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_kill_joy", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_kill_joy/zm_bgb_kill_joy
// Params 0, eflags: 0x0
// Checksum 0x4ba324e9, Offset: 0xe0
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_kill_joy", "activated", 1, undefined, undefined, undefined, &activation);
}

// Namespace zm_bgb_kill_joy/zm_bgb_kill_joy
// Params 0, eflags: 0x0
// Checksum 0x91a86687, Offset: 0x150
// Size: 0x24
function activation() {
    self thread bgb::function_dea74fb0("insta_kill", undefined, 96);
}

