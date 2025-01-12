#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace lead_drone;

// Namespace lead_drone/lead_drone
// Params 0, eflags: 0x2
// Checksum 0x37d3073c, Offset: 0x78
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"lead_drone", &__init__, undefined, undefined);
}

// Namespace lead_drone/lead_drone
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0xc0
// Size: 0x4
function __init__() {
    
}

