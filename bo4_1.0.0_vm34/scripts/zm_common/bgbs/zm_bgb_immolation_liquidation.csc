#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_immolation_liquidation;

// Namespace zm_bgb_immolation_liquidation/zm_bgb_immolation_liquidation
// Params 0, eflags: 0x2
// Checksum 0x78181494, Offset: 0x88
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_immolation_liquidation", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_immolation_liquidation/zm_bgb_immolation_liquidation
// Params 0, eflags: 0x0
// Checksum 0x3a0cc06d, Offset: 0xd8
// Size: 0x4c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_immolation_liquidation", "activated");
}
