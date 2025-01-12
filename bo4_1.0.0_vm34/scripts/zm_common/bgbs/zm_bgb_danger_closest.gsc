#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_danger_closest;

// Namespace zm_bgb_danger_closest/zm_bgb_danger_closest
// Params 0, eflags: 0x2
// Checksum 0xa4c324b9, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_danger_closest", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_danger_closest/zm_bgb_danger_closest
// Params 0, eflags: 0x0
// Checksum 0x58a67eba, Offset: 0xd0
// Size: 0x5c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_danger_closest", "time", 300, undefined, undefined, undefined);
}

