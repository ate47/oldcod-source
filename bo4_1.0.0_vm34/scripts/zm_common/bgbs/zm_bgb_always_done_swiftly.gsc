#using scripts\core_common\perks;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_always_done_swiftly;

// Namespace zm_bgb_always_done_swiftly/zm_bgb_always_done_swiftly
// Params 0, eflags: 0x2
// Checksum 0x505e4844, Offset: 0xb0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_always_done_swiftly", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_always_done_swiftly/zm_bgb_always_done_swiftly
// Params 0, eflags: 0x0
// Checksum 0x722227aa, Offset: 0x100
// Size: 0x74
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_always_done_swiftly", "time", 300, &enable, &disable, undefined);
}

// Namespace zm_bgb_always_done_swiftly/zm_bgb_always_done_swiftly
// Params 0, eflags: 0x0
// Checksum 0xd84d1521, Offset: 0x180
// Size: 0x44
function enable() {
    self perks::perk_setperk("specialty_fastads");
    self perks::perk_setperk("specialty_stalker");
}

// Namespace zm_bgb_always_done_swiftly/zm_bgb_always_done_swiftly
// Params 0, eflags: 0x0
// Checksum 0x62041f52, Offset: 0x1d0
// Size: 0x44
function disable() {
    self perks::perk_unsetperk("specialty_fastads");
    self perks::perk_unsetperk("specialty_stalker");
}

