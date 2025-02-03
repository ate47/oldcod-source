#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;

#namespace vehicle;

// Namespace vehicle/vehicle
// Params 0, eflags: 0x6
// Checksum 0xe0a57651, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"vehicle", &preinit, undefined, undefined, undefined);
}

// Namespace vehicle/vehicle
// Params 0, eflags: 0x4
// Checksum 0xa1762829, Offset: 0xb8
// Size: 0x30
function private preinit() {
    if (!isdefined(level._effect)) {
        level._effect = [];
    }
    level.vehicles_inited = 1;
}

// Namespace vehicle/vehicle
// Params 1, eflags: 0x0
// Checksum 0x75aa212f, Offset: 0xf0
// Size: 0xc
function vehicle_variants(*localclientnum) {
    
}

