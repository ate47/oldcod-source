#using scripts\core_common\struct;

#namespace zclassic;

// Namespace zclassic/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xa86cb675, Offset: 0x70
// Size: 0x5c
function event_handler[gametype_init] main(eventstruct) {
    level._zombie_gamemodeprecache = &onprecachegametype;
    level._zombie_gamemodemain = &onstartgametype;
    println("<dev string:x30>");
}

// Namespace zclassic/zclassic
// Params 0, eflags: 0x0
// Checksum 0xc8936c29, Offset: 0xd8
// Size: 0x24
function onprecachegametype() {
    println("<dev string:x4c>");
}

// Namespace zclassic/zclassic
// Params 0, eflags: 0x0
// Checksum 0x6012049d, Offset: 0x108
// Size: 0x24
function onstartgametype() {
    println("<dev string:x6c>");
}

