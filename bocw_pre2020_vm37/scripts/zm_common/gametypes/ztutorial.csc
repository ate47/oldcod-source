#namespace ztutorial;

// Namespace ztutorial/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xec235af1, Offset: 0x60
// Size: 0x3c
function event_handler[gametype_init] main(*eventstruct) {
    level._zombie_gamemodeprecache = &onprecachegametype;
    level._zombie_gamemodemain = &onstartgametype;
}

// Namespace ztutorial/ztutorial
// Params 0, eflags: 0x0
// Checksum 0x31031161, Offset: 0xa8
// Size: 0x24
function onprecachegametype() {
    println("<dev string:x38>");
}

// Namespace ztutorial/ztutorial
// Params 0, eflags: 0x0
// Checksum 0x3daaf650, Offset: 0xd8
// Size: 0x24
function onstartgametype() {
    println("<dev string:x5c>");
}

