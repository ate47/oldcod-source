#using scripts\core_common\gamestate_util;
#using scripts\core_common\system_shared;

#namespace gamestate;

// Namespace gamestate/gamestate
// Params 0, eflags: 0x6
// Checksum 0x25f20c68, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gamestate", &preinit, undefined, undefined, undefined);
}

// Namespace gamestate/gamestate
// Params 0, eflags: 0x4
// Checksum 0xc12b4563, Offset: 0xb8
// Size: 0x2c
function private preinit() {
    if (!isdefined(game.state)) {
        game.state = #"pregame";
    }
}

// Namespace gamestate/gamestate
// Params 1, eflags: 0x0
// Checksum 0x8c1584bd, Offset: 0xf0
// Size: 0x5c
function set_state(state) {
    game.state = state;
    function_cab6408d(state);
    println("<dev string:x38>" + state);
}

