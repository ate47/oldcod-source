#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace killcam;

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x2
// Checksum 0x252cec0f, Offset: 0x110
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"killcam", &__init__, undefined, undefined);
}

// Namespace killcam/killcam_shared
// Params 0, eflags: 0x0
// Checksum 0xbf30f9f8, Offset: 0x158
// Size: 0x11c
function __init__() {
    clientfield::register("clientuimodel", "hudItems.killcamAllowRespawn", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.voteKillcamSkip", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.voteProgress", 1, 5, "float", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.voteCommitted", 1, 4, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "hudItems.voteRequired", 1, 4, "int", undefined, 0, 0);
}

