#using scripts\core_common\struct;

#namespace ztcm;

// Namespace ztcm/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x218e07d1, Offset: 0x70
// Size: 0x5c
function event_handler[gametype_init] main(eventstruct) {
    level._zombie_gamemodeprecache = &onprecachegametype;
    level._zombie_gamemodemain = &onstartgametype;
    println("<dev string:x30>");
}

// Namespace ztcm/ztcm
// Params 0, eflags: 0x0
// Checksum 0x76c8ed0b, Offset: 0xd8
// Size: 0x24
function onprecachegametype() {
    println("<dev string:x48>");
}

// Namespace ztcm/ztcm
// Params 0, eflags: 0x0
// Checksum 0x1bcf53f7, Offset: 0x108
// Size: 0x24
function onstartgametype() {
    println("<dev string:x64>");
}

