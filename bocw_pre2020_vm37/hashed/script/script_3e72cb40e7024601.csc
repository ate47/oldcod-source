#using script_1b2f6ef7778cf920;
#using scripts\core_common\util_shared;

#namespace doa;

// Namespace doa/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x8eaf5c36, Offset: 0x80
// Size: 0x4c
function event_handler[gametype_init] main(*eventstruct) {
    level.var_30df1fad = "zombietron";
    level thread namespace_4dae815d::init();
    util::waitforclient(0);
}

