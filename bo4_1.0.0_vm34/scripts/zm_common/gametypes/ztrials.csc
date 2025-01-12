#using script_5afd8ff8f8304cc4;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\zm_common\trials\zm_trial_disable_buys;
#using scripts\zm_common\trials\zm_trial_disable_hud;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;

#namespace ztrials;

// Namespace ztrials/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x9e9743dd, Offset: 0xa0
// Size: 0x84
function event_handler[gametype_init] main(eventstruct) {
    level._zombie_gamemodeprecache = &onprecachegametype;
    level._zombie_gamemodemain = &onstartgametype;
    level flag::init(#"ztrial", 1);
    println("<dev string:x30>");
}

// Namespace ztrials/ztrials
// Params 0, eflags: 0x0
// Checksum 0x553c48dc, Offset: 0x130
// Size: 0x24
function onprecachegametype() {
    println("<dev string:x4b>");
}

// Namespace ztrials/ztrials
// Params 0, eflags: 0x0
// Checksum 0xd7899543, Offset: 0x160
// Size: 0x24
function onstartgametype() {
    println("<dev string:x6a>");
}

// Namespace ztrials/event_3c1e4f2f
// Params 1, eflags: 0x44
// Checksum 0x1864295f, Offset: 0x190
// Size: 0x2c
function private event_handler[event_3c1e4f2f] function_17c87ded(eventstruct) {
    self thread zm_trial_util::function_49b6503a(eventstruct.localclientnum);
}

