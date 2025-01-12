#using scripts\core_common\struct;

#namespace zgrief;

// Namespace zgrief/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x2485bbe, Offset: 0x68
// Size: 0x5c
function event_handler[gametype_init] main(*eventstruct) {
    level._zombie_gamemodeprecache = &onprecachegametype;
    level._zombie_gamemodemain = &onstartgametype;
    println("<dev string:x38>");
}

// Namespace zgrief/zgrief
// Params 0, eflags: 0x0
// Checksum 0xcc9d213d, Offset: 0xd0
// Size: 0x24
function onprecachegametype() {
    println("<dev string:x55>");
}

// Namespace zgrief/zgrief
// Params 0, eflags: 0x0
// Checksum 0x453e14e6, Offset: 0x100
// Size: 0x24
function onstartgametype() {
    println("<dev string:x76>");
}

