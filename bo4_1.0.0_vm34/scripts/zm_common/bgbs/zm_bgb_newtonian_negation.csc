#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_newtonian_negation;

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x2
// Checksum 0x2955e00f, Offset: 0xa8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_newtonian_negation", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x0
// Checksum 0x8274d3e4, Offset: 0xf8
// Size: 0x94
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    clientfield::register("world", "newtonian_negation", 1, 1, "int", &function_2b4ff13a, 0, 0);
    bgb::register(#"zm_bgb_newtonian_negation", "time");
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 7, eflags: 0x0
// Checksum 0xdd0678bb, Offset: 0x198
// Size: 0x94
function function_2b4ff13a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setdvar(#"phys_gravity_dir", (0, 0, -1));
        return;
    }
    setdvar(#"phys_gravity_dir", (0, 0, 1));
}

