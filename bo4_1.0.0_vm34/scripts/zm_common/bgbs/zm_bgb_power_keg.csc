#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_power_keg;

// Namespace zm_bgb_power_keg/zm_bgb_power_keg
// Params 0, eflags: 0x2
// Checksum 0x91a3150c, Offset: 0x88
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_power_keg", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_power_keg/zm_bgb_power_keg
// Params 0, eflags: 0x0
// Checksum 0x78b77b47, Offset: 0xd8
// Size: 0x4c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_power_keg", "activated");
}

