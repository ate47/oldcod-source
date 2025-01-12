#using scripts\core_common\system_shared;
#using scripts\zm\zm_lightning_chain;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_pop_shocks;

// Namespace zm_bgb_pop_shocks/zm_bgb_pop_shocks
// Params 0, eflags: 0x2
// Checksum 0xe5d2bbf5, Offset: 0x88
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_pop_shocks", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_pop_shocks/zm_bgb_pop_shocks
// Params 0, eflags: 0x0
// Checksum 0x67e4585e, Offset: 0xd8
// Size: 0x4c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_pop_shocks", "event");
}

