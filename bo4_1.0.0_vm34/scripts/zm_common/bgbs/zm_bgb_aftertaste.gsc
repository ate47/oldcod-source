#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_aftertaste;

// Namespace zm_bgb_aftertaste/zm_bgb_aftertaste
// Params 0, eflags: 0x2
// Checksum 0x8f1c26da, Offset: 0x80
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_aftertaste", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_aftertaste/zm_bgb_aftertaste
// Params 0, eflags: 0x0
// Checksum 0xfe4fb8db, Offset: 0xd0
// Size: 0x94
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_aftertaste", "event", &event, undefined, undefined, undefined);
    bgb::register_lost_perk_override(#"zm_bgb_aftertaste", &lost_perk_override, 0);
}

// Namespace zm_bgb_aftertaste/zm_bgb_aftertaste
// Params 3, eflags: 0x0
// Checksum 0x80913b43, Offset: 0x170
// Size: 0x68
function lost_perk_override(perk, var_2488e46a = undefined, var_24df4040 = undefined) {
    if (isdefined(var_2488e46a) && isdefined(var_24df4040) && var_2488e46a == var_24df4040) {
        return 1;
    }
    return 0;
}

// Namespace zm_bgb_aftertaste/zm_bgb_aftertaste
// Params 0, eflags: 0x0
// Checksum 0x41a26bb5, Offset: 0x1e0
// Size: 0x64
function event() {
    self endon(#"disconnect", #"bled_out", #"bgb_update");
    self waittill(#"player_revived");
    self bgb::do_one_shot_use(1);
}

