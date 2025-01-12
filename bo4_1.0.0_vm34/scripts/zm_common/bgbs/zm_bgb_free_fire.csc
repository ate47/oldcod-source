#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_free_fire;

// Namespace zm_bgb_free_fire/zm_bgb_free_fire
// Params 0, eflags: 0x2
// Checksum 0x5b5352e1, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_free_fire", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_free_fire/zm_bgb_free_fire
// Params 0, eflags: 0x0
// Checksum 0x81dc424f, Offset: 0xd0
// Size: 0x4c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_free_fire", "time");
}
