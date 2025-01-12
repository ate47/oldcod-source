#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace wz_ai;

// Namespace wz_ai/wz_ai
// Params 0, eflags: 0x2
// Checksum 0x253f0d57, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_ai", &__init__, undefined, undefined);
}

// Namespace wz_ai/wz_ai
// Params 0, eflags: 0x4
// Checksum 0xd597c82b, Offset: 0xf0
// Size: 0x94
function private __init__() {
    clientfield::register("vehicle", "enable_on_radar", 1, 1, "int", &function_4cf751e8, 1, 1);
    clientfield::register("actor", "enable_on_radar", 1, 1, "int", &function_4cf751e8, 1, 1);
}

// Namespace wz_ai/wz_ai
// Params 7, eflags: 0x0
// Checksum 0x8ba81287, Offset: 0x190
// Size: 0x54
function function_4cf751e8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self enableonradar();
}

