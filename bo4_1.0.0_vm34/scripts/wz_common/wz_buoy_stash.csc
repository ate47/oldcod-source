#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace wz_buoy_stash;

// Namespace wz_buoy_stash/wz_buoy_stash
// Params 0, eflags: 0x2
// Checksum 0x9889722e, Offset: 0xc0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_buoy_stash", &__init__, undefined, undefined);
}

// Namespace wz_buoy_stash/wz_buoy_stash
// Params 0, eflags: 0x0
// Checksum 0x50dd37a3, Offset: 0x108
// Size: 0x4c
function __init__() {
    clientfield::register("scriptmover", "buoy_light_fx_changed", 1, 2, "int", &function_d6c57941, 0, 0);
}

// Namespace wz_buoy_stash/wz_buoy_stash
// Params 7, eflags: 0x0
// Checksum 0x15a06459, Offset: 0x160
// Size: 0xfa
function function_d6c57941(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.fx_id)) {
        stopfx(0, self.fx_id);
    }
    switch (newval) {
    case 1:
        self.fx_id = util::playfxontag(localclientnum, #"hash_212c7fc08851dc9", self, "tag_light_buoy03_jnt");
        break;
    case 2:
        self.fx_id = util::playfxontag(localclientnum, #"hash_77d0b79144a0734d", self, "tag_light_buoy03_jnt");
        break;
    }
}

