#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace wasp;

// Namespace wasp/wasp
// Params 0, eflags: 0x6
// Checksum 0x6bcd7fc1, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wasp", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace wasp/wasp
// Params 0, eflags: 0x5 linked
// Checksum 0x61d7f94d, Offset: 0x110
// Size: 0xac
function private function_70a657d8() {
    clientfield::register("vehicle", "rocket_wasp_hijacked", 1, 1, "int", &handle_lod_display_for_driver, 0, 0);
    level.sentinelbundle = getscriptbundle("killstreak_sentinel");
    if (isdefined(level.sentinelbundle)) {
        vehicle::add_vehicletype_callback(level.sentinelbundle.ksvehicle, &spawned);
    }
}

// Namespace wasp/wasp
// Params 1, eflags: 0x1 linked
// Checksum 0xa5210a1f, Offset: 0x1c8
// Size: 0x1e
function spawned(*localclientnum) {
    self.killstreakbundle = level.sentinelbundle;
}

// Namespace wasp/wasp
// Params 7, eflags: 0x1 linked
// Checksum 0x5cf0430d, Offset: 0x1f0
// Size: 0xa4
function handle_lod_display_for_driver(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    if (isdefined(self)) {
        if (self function_4add50a7()) {
            self sethighdetail(1);
            waitframe(1);
            self vehicle::lights_off(bwastimejump);
        }
    }
}

