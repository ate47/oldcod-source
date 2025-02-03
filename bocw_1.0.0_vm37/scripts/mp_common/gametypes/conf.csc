#using scripts\core_common\dogtags;
#using scripts\core_common\util_shared;

#namespace conf;

// Namespace conf/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xfb75eeb6, Offset: 0x70
// Size: 0x1c
function event_handler[gametype_init] main(*eventstruct) {
    dogtags::init();
}

