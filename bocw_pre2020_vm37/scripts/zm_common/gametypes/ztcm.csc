#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;

#namespace ztcm;

// Namespace ztcm/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x70612ebf, Offset: 0x70
// Size: 0xa4
function event_handler[gametype_init] main(*eventstruct) {
    level._zombie_gamemodeprecache = &onprecachegametype;
    level._zombie_gamemodemain = &onstartgametype;
    if (!level flag::exists(#"ztcm")) {
        level flag::init(#"ztcm", 1);
    }
    println("<dev string:x38>");
}

// Namespace ztcm/ztcm
// Params 0, eflags: 0x0
// Checksum 0x10f46f94, Offset: 0x120
// Size: 0x24
function onprecachegametype() {
    println("<dev string:x53>");
}

// Namespace ztcm/ztcm
// Params 0, eflags: 0x0
// Checksum 0x4d405cac, Offset: 0x150
// Size: 0x24
function onstartgametype() {
    println("<dev string:x72>");
}

