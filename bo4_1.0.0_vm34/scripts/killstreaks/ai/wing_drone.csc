#using scripts\core_common\struct;
#using scripts\core_common\vehicle_shared;

#namespace wing_drone;

// Namespace wing_drone/wing_drone
// Params 0, eflags: 0x0
// Checksum 0x7a620199, Offset: 0x98
// Size: 0x8c
function init() {
    if (!isdefined(level.var_155cd447)) {
        level.var_155cd447 = {};
        level.sentinelbundle = struct::get_script_bundle("killstreak", "killstreak_sentinel");
        if (isdefined(level.sentinelbundle)) {
            vehicle::add_vehicletype_callback(level.sentinelbundle.ksvehicle, &spawned);
        }
    }
}

// Namespace wing_drone/wing_drone
// Params 1, eflags: 0x0
// Checksum 0x8ab7c370, Offset: 0x130
// Size: 0x1e
function spawned(localclientnum) {
    self.killstreakbundle = level.sentinelbundle;
}

// Namespace wing_drone/wing_drone
// Params 7, eflags: 0x0
// Checksum 0xd2798188, Offset: 0x158
// Size: 0xa4
function handle_lod_display_for_driver(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (isdefined(self)) {
        if (self function_2a8c9709()) {
            self sethighdetail(1);
            waitframe(1);
            self vehicle::lights_off(localclientnum);
        }
    }
}

