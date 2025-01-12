#using scripts\core_common\struct;

#namespace zgrief;

// Namespace zgrief/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x6c8e71e0, Offset: 0x70
// Size: 0x5c
function event_handler[gametype_init] main(eventstruct) {
    level._zombie_gamemodeprecache = &onprecachegametype;
    level._zombie_gamemodemain = &onstartgametype;
    println("<dev string:x30>");
}

// Namespace zgrief/zgrief
// Params 0, eflags: 0x0
// Checksum 0xaf3d977e, Offset: 0xd8
// Size: 0x24
function onprecachegametype() {
    println("<dev string:x4a>");
}

// Namespace zgrief/zgrief
// Params 0, eflags: 0x0
// Checksum 0x6d453f94, Offset: 0x108
// Size: 0x24
function onstartgametype() {
    println("<dev string:x68>");
}

