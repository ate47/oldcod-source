#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_stats;

#namespace zm_bgb_wall_power;

// Namespace zm_bgb_wall_power/zm_bgb_wall_power
// Params 0, eflags: 0x2
// Checksum 0xb9f3d9bd, Offset: 0xa0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_wall_power", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_wall_power/zm_bgb_wall_power
// Params 0, eflags: 0x0
// Checksum 0x9de5b715, Offset: 0xf0
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_wall_power", "event", &event, undefined, undefined, undefined);
}

// Namespace zm_bgb_wall_power/zm_bgb_wall_power
// Params 0, eflags: 0x0
// Checksum 0x51702817, Offset: 0x160
// Size: 0x94
function event() {
    self endon(#"disconnect");
    self endon(#"bgb_update");
    self waittill(#"zm_bgb_wall_power_used");
    self playsoundtoplayer(#"zmb_bgb_wall_power", self);
    self zm_stats::increment_challenge_stat("GUM_GOBBLER_WALL_POWER");
    self bgb::do_one_shot_use();
}

