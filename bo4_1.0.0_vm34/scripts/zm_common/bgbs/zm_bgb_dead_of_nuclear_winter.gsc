#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_dead_of_nuclear_winter;

// Namespace zm_bgb_dead_of_nuclear_winter/zm_bgb_dead_of_nuclear_winter
// Params 0, eflags: 0x2
// Checksum 0x273cc0ec, Offset: 0x88
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_dead_of_nuclear_winter", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_dead_of_nuclear_winter/zm_bgb_dead_of_nuclear_winter
// Params 0, eflags: 0x0
// Checksum 0xb00e0350, Offset: 0xd8
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_dead_of_nuclear_winter", "activated", 1, undefined, undefined, undefined, &activation);
}

// Namespace zm_bgb_dead_of_nuclear_winter/zm_bgb_dead_of_nuclear_winter
// Params 0, eflags: 0x0
// Checksum 0xfa78831e, Offset: 0x148
// Size: 0x24
function activation() {
    self thread bgb::function_dea74fb0("nuke", undefined, 96);
}

