#namespace ztutorial;

// Namespace ztutorial/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x9055f816, Offset: 0x68
// Size: 0x3e
function event_handler[gametype_init] main(eventstruct) {
    level._zombie_gamemodeprecache = &onprecachegametype;
    level._zombie_gamemodemain = &onstartgametype;
}

// Namespace ztutorial/ztutorial
// Params 0, eflags: 0x0
// Checksum 0x100c7ac, Offset: 0xb0
// Size: 0x24
function onprecachegametype() {
    println("<dev string:x30>");
}

// Namespace ztutorial/ztutorial
// Params 0, eflags: 0x0
// Checksum 0x963c76f2, Offset: 0xe0
// Size: 0x24
function onstartgametype() {
    println("<dev string:x51>");
}

