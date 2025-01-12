#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/vehicle_shared;

#namespace raps;

// Namespace raps/repulsor
// Params 0, eflags: 0x2
// Checksum 0x4c7e3faa, Offset: 0x140
// Size: 0x4c
function autoexec main() {
    clientfield::register("vehicle", "pulse_fx", 1, 1, "counter", &function_feeb41a2, 0, 0);
}

// Namespace raps/repulsor
// Params 7, eflags: 0x4
// Checksum 0x1cf3489, Offset: 0x198
// Size: 0xcc
function private function_feeb41a2(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    self endon(#"death");
    if (!isdefined(self)) {
        return;
    }
    self notify(#"hash_601214b2");
    self endon(#"hash_601214b2");
    if (newvalue) {
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1);
        wait 1;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0.2);
}

