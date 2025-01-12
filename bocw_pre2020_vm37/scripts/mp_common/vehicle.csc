#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace vehicle;

// Namespace vehicle/vehicle
// Params 0, eflags: 0x6
// Checksum 0x299d9c9f, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"vehicle", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace vehicle/vehicle
// Params 0, eflags: 0x5 linked
// Checksum 0x8273cdff, Offset: 0xb8
// Size: 0x30
function private function_70a657d8() {
    if (!isdefined(level._effect)) {
        level._effect = [];
    }
    level.vehicles_inited = 1;
}

// Namespace vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x2af346af, Offset: 0xf0
// Size: 0xc
function vehicle_variants(*localclientnum) {
    
}

