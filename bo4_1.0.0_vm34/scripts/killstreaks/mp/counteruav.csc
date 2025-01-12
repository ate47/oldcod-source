#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace counteruav;

// Namespace counteruav/counteruav
// Params 0, eflags: 0x2
// Checksum 0xadae3b4, Offset: 0xa0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"counteruav", &__init__, undefined, #"killstreaks");
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x0
// Checksum 0x31affe07, Offset: 0xf0
// Size: 0x5a
function __init__() {
    clientfield::register("toplayer", "counteruav", 1, 1, "int", &counteruavchanged, 0, 1);
    level.var_34da4a24 = [];
}

// Namespace counteruav/counteruav
// Params 7, eflags: 0x0
// Checksum 0xcb4aed83, Offset: 0x158
// Size: 0x11e
function counteruavchanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = function_f97e7787(localclientnum);
    assert(isdefined(player));
    player setenemyglobalscrambler(newval);
    if (isdefined(level.var_34da4a24[localclientnum])) {
        function_4f246249(localclientnum, level.var_34da4a24[localclientnum], 1);
        level.var_34da4a24[localclientnum] = undefined;
    }
    if (newval) {
        level.var_34da4a24[localclientnum] = function_987d57a7(localclientnum, "mpl_cuav_static");
    }
}

