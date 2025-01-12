#using scripts/core_common/archetype_shared/archetype_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/filter_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;

#namespace wasp;

// Namespace wasp/wasp
// Params 0, eflags: 0x2
// Checksum 0x6206a1d2, Offset: 0x208
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("wasp", &__init__, undefined, undefined);
}

// Namespace wasp/wasp
// Params 0, eflags: 0x0
// Checksum 0x4910ebb9, Offset: 0x248
// Size: 0xbc
function __init__() {
    clientfield::register("vehicle", "rocket_wasp_hijacked", 1, 1, "int", &handle_lod_display_for_driver, 0, 0);
    level.sentinelbundle = struct::get_script_bundle("killstreak", "killstreak_sentinel");
    if (isdefined(level.sentinelbundle)) {
        vehicle::add_vehicletype_callback(level.sentinelbundle.ksvehicle, &spawned);
    }
}

// Namespace wasp/wasp
// Params 1, eflags: 0x0
// Checksum 0x801c8f90, Offset: 0x310
// Size: 0x20
function spawned(localclientnum) {
    self.killstreakbundle = level.sentinelbundle;
}

// Namespace wasp/wasp
// Params 7, eflags: 0x0
// Checksum 0x42354eef, Offset: 0x338
// Size: 0xa4
function handle_lod_display_for_driver(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (isdefined(self)) {
        if (self islocalclientdriver(localclientnum)) {
            self sethighdetail(1);
            waitframe(1);
            self vehicle::lights_off(localclientnum);
        }
    }
}

