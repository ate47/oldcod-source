#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_game_over;

// Namespace zm_game_over
// Method(s) 6 Total 13
class czm_game_over : cluielem {

    var var_57a3d576;

    // Namespace czm_game_over/zm_game_over
    // Params 2, eflags: 0x0
    // Checksum 0xe4ccc897, Offset: 0x2b8
    // Size: 0x3c
    function set_rounds(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "rounds", value);
    }

    // Namespace czm_game_over/zm_game_over
    // Params 1, eflags: 0x0
    // Checksum 0x26587482, Offset: 0x288
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_game_over/zm_game_over
    // Params 2, eflags: 0x0
    // Checksum 0x7c04d097, Offset: 0x238
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_game_over", persistent);
    }

    // Namespace czm_game_over/zm_game_over
    // Params 1, eflags: 0x0
    // Checksum 0x351e3e7b, Offset: 0x1e0
    // Size: 0x4c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("rounds", 1, 8, "int");
    }

}

// Namespace zm_game_over/zm_game_over
// Params 1, eflags: 0x0
// Checksum 0xa6dc2424, Offset: 0xb8
// Size: 0x40
function register(uid) {
    elem = new czm_game_over();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_game_over/zm_game_over
// Params 2, eflags: 0x0
// Checksum 0x2c60b3b6, Offset: 0x100
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_game_over/zm_game_over
// Params 1, eflags: 0x0
// Checksum 0x84d9560a, Offset: 0x140
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_game_over/zm_game_over
// Params 1, eflags: 0x0
// Checksum 0x9406c6bb, Offset: 0x168
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_game_over/zm_game_over
// Params 2, eflags: 0x0
// Checksum 0xf0856088, Offset: 0x190
// Size: 0x28
function set_rounds(player, value) {
    [[ self ]]->set_rounds(player, value);
}

