#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace wasp;

// Namespace wasp/wasp
// Params 0, eflags: 0x2
// Checksum 0xf5d3bb56, Offset: 0xc8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wasp", &__init__, undefined, undefined);
}

// Namespace wasp/wasp
// Params 0, eflags: 0x0
// Checksum 0xd1084f4d, Offset: 0x110
// Size: 0xb4
function __init__() {
    clientfield::register("vehicle", "rocket_wasp_hijacked", 1, 1, "int", &handle_lod_display_for_driver, 0, 0);
    level.sentinelbundle = struct::get_script_bundle("killstreak", "killstreak_sentinel");
    if (isdefined(level.sentinelbundle)) {
        vehicle::add_vehicletype_callback(level.sentinelbundle.ksvehicle, &spawned);
    }
}

// Namespace wasp/wasp
// Params 1, eflags: 0x0
// Checksum 0x7f0bd194, Offset: 0x1d0
// Size: 0x1e
function spawned(localclientnum) {
    self.killstreakbundle = level.sentinelbundle;
}

// Namespace wasp/wasp
// Params 7, eflags: 0x0
// Checksum 0xe169b5d2, Offset: 0x1f8
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

