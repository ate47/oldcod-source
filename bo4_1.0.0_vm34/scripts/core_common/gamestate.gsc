#namespace gamestate;

// Namespace gamestate/gamestate
// Params 1, eflags: 0x0
// Checksum 0x18951bf2, Offset: 0x80
// Size: 0x1a
function set_state(state) {
    game.state = state;
}

// Namespace gamestate/gamestate
// Params 1, eflags: 0x0
// Checksum 0x9e3047ac, Offset: 0xa8
// Size: 0x1c
function is_state(state) {
    return game.state == state;
}

// Namespace gamestate/gamestate
// Params 0, eflags: 0x0
// Checksum 0xd0318e2c, Offset: 0xd0
// Size: 0x32
function is_game_over() {
    return game.state == "postgame" || game.state == "shutdown";
}

// Namespace gamestate/gamestate
// Params 0, eflags: 0x0
// Checksum 0xcefe29fc, Offset: 0x110
// Size: 0x18
function is_shutting_down() {
    return game.state == "shutdown";
}

