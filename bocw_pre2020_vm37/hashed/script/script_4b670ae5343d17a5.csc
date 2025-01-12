#using script_1b2f6ef7778cf920;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace doa;

// Namespace doa/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x8cd1100a, Offset: 0x90
// Size: 0x7c
function event_handler[gametype_init] main(*eventstruct) {
    level.var_30df1fad = "zombietron";
    level thread namespace_4dae815d::init();
    level.var_f18a6bd6 = &function_f18a6bd6;
    waittillframeend();
    level.var_f18a6bd6 = &function_f18a6bd6;
    util::waitforclient(0);
}

// Namespace doa/doa
// Params 0, eflags: 0x0
// Checksum 0xf973b9c9, Offset: 0x118
// Size: 0x34
function function_f18a6bd6() {
    system::function_c11b0642();
    level flag::set(#"load_main_complete");
}

