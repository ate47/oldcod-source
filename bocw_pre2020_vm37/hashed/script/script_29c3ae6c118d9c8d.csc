#using script_78825cbb1ab9f493;
#using scripts\core_common\dogtags;
#using scripts\core_common\player\player_insertion;

#namespace namespace_f2e23b4a;

// Namespace namespace_f2e23b4a/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xd2b973f2, Offset: 0x78
// Size: 0x2c
function event_handler[gametype_init] main(*eventstruct) {
    namespace_17baa64d::init();
    dogtags::init();
}

