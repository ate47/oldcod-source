#using scripts\core_common\system_shared;

#namespace gamestate;

// Namespace gamestate/gamestate
// Params 0, eflags: 0x6
// Checksum 0xaaf414a5, Offset: 0x90
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gamestate", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace gamestate/gamestate
// Params 0, eflags: 0x5 linked
// Checksum 0xaec7e673, Offset: 0xd8
// Size: 0x24
function private function_70a657d8() {
    if (!isdefined(game.state)) {
        game.state = "pregame";
    }
}

// Namespace gamestate/gamestate
// Params 1, eflags: 0x1 linked
// Checksum 0x723fdf59, Offset: 0x108
// Size: 0x34
function set_state(state) {
    game.state = state;
    function_cab6408d(state);
}

// Namespace gamestate/gamestate
// Params 1, eflags: 0x1 linked
// Checksum 0xeb122b95, Offset: 0x148
// Size: 0x1c
function is_state(state) {
    return game.state == state;
}

// Namespace gamestate/gamestate
// Params 0, eflags: 0x1 linked
// Checksum 0x89ce41d, Offset: 0x170
// Size: 0x32
function is_game_over() {
    return game.state == "postgame" || game.state == "shutdown";
}

// Namespace gamestate/gamestate
// Params 0, eflags: 0x0
// Checksum 0x9da209b5, Offset: 0x1b0
// Size: 0x18
function is_shutting_down() {
    return game.state == "shutdown";
}

