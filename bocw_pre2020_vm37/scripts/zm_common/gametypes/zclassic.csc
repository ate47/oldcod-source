#using script_359683f0ff3b3fbb;
#using script_62c40d9a3acec9b1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace zclassic;

// Namespace zclassic/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x1aea72a4, Offset: 0x88
// Size: 0xac
function event_handler[gametype_init] main(*eventstruct) {
    level._zombie_gamemodeprecache = &onprecachegametype;
    level._zombie_gamemodemain = &onstartgametype;
    if (!isdefined(level.var_352498c6)) {
        prototype_hud::register();
        level.var_352498c6 = 1;
    }
    callback::on_gameplay_started(&on_gameplay_started);
    println("<dev string:x38>");
}

// Namespace zclassic/zclassic
// Params 0, eflags: 0x1 linked
// Checksum 0xe35f1d87, Offset: 0x140
// Size: 0x24
function onprecachegametype() {
    println("<dev string:x57>");
}

// Namespace zclassic/zclassic
// Params 0, eflags: 0x1 linked
// Checksum 0xc88cc18e, Offset: 0x170
// Size: 0x24
function onstartgametype() {
    println("<dev string:x7a>");
}

// Namespace zclassic/zclassic
// Params 1, eflags: 0x1 linked
// Checksum 0x8399714b, Offset: 0x1a0
// Size: 0x2c
function on_gameplay_started(*localclientnum) {
    waitframe(1);
    util::function_8eb5d4b0(3500, 2.5);
}

