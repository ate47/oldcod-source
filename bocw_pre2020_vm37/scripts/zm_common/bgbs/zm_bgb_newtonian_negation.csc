#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_newtonian_negation;

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x6
// Checksum 0x4122d4cb, Offset: 0xb0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"zm_bgb_newtonian_negation", &function_70a657d8, undefined, undefined, #"bgb");
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x5 linked
// Checksum 0x45cacaa3, Offset: 0x100
// Size: 0xb4
function private function_70a657d8() {
    if (!is_true(level.bgb_in_use) && !is_true(level.var_5470be1c)) {
        return;
    }
    clientfield::register("world", "newtonian_negation", 1, 1, "int", &function_8622e664, 0, 0);
    bgb::register(#"zm_bgb_newtonian_negation", "time");
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 7, eflags: 0x1 linked
// Checksum 0x7fc5a6ca, Offset: 0x1c0
// Size: 0xbc
function function_8622e664(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        setdvar(#"phys_gravity_dir", (0, 0, -1));
        self notify(#"hash_747b48d62f4fbad1");
        return;
    }
    setdvar(#"phys_gravity_dir", (0, 0, 1));
    self thread function_e752a980(fieldname);
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 1, eflags: 0x1 linked
// Checksum 0xf50110e5, Offset: 0x288
// Size: 0x19e
function function_e752a980(localclientnum) {
    self endon(#"hash_747b48d62f4fbad1", #"disconnect");
    var_f42481ac = 0;
    a_dynents = getdynentarray();
    a_corpses = getentarraybytype(localclientnum, 17);
    var_f74f1323 = arraycombine(a_dynents, a_corpses, 1, 0);
    var_f74f1323 = array::randomize(var_f74f1323);
    foreach (var_863ce745 in var_f74f1323) {
        if (!isdefined(var_863ce745)) {
            continue;
        }
        physicsexplosionsphere(localclientnum, var_863ce745.origin, 2, 0, 5, undefined, undefined, 1, 1, 1);
        var_f42481ac++;
        if (var_f42481ac >= 5) {
            waitframe(1);
            var_f42481ac = 0;
        }
    }
}

