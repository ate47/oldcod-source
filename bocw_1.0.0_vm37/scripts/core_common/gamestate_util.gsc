#namespace gamestate;

// Namespace gamestate/gamestate_util
// Params 1, eflags: 0x0
// Checksum 0x724d0825, Offset: 0x60
// Size: 0x1c
function is_state(state) {
    return game.state == state;
}

// Namespace gamestate/gamestate_util
// Params 0, eflags: 0x0
// Checksum 0xbcc251da, Offset: 0x88
// Size: 0x3e
function is_game_over() {
    return game.state == #"postgame" || game.state == #"shutdown";
}

// Namespace gamestate/gamestate_util
// Params 0, eflags: 0x0
// Checksum 0x2fa6080e, Offset: 0xd0
// Size: 0x1c
function is_shutting_down() {
    return game.state == #"shutdown";
}

