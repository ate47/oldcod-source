#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_game_over;

// Namespace zm_game_over
// Method(s) 7 Total 14
class czm_game_over : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace czm_game_over/zm_game_over
    // Params 2, eflags: 0x1 linked
    // Checksum 0xc787022a, Offset: 0x290
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace czm_game_over/zm_game_over
    // Params 1, eflags: 0x1 linked
    // Checksum 0x15274c3d, Offset: 0x2d8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_game_over/zm_game_over
    // Params 0, eflags: 0x1 linked
    // Checksum 0x260105bd, Offset: 0x218
    // Size: 0x6c
    function setup_clientfields() {
        cluielem::setup_clientfields("zm_game_over");
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::add_clientfield("rounds", 1, 8, "int");
    }

    // Namespace czm_game_over/zm_game_over
    // Params 2, eflags: 0x1 linked
    // Checksum 0x99a2339, Offset: 0x3e0
    // Size: 0x44
    function set_rounds(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "rounds", value);
    }

    // Namespace czm_game_over/zm_game_over
    // Params 2, eflags: 0x1 linked
    // Checksum 0xfa7b256b, Offset: 0x308
    // Size: 0xcc
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 0);
            return;
        }
        if (#"gatewayopened" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 1);
            return;
        }
        assertmsg("<dev string:x38>");
    }

}

// Namespace zm_game_over/zm_game_over
// Params 0, eflags: 0x1 linked
// Checksum 0x4ce75a2b, Offset: 0xc8
// Size: 0x34
function register() {
    elem = new czm_game_over();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace zm_game_over/zm_game_over
// Params 2, eflags: 0x1 linked
// Checksum 0xf9df25c3, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_game_over/zm_game_over
// Params 1, eflags: 0x1 linked
// Checksum 0x94bac228, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_game_over/zm_game_over
// Params 1, eflags: 0x1 linked
// Checksum 0x2ab077a3, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace zm_game_over/zm_game_over
// Params 2, eflags: 0x0
// Checksum 0x6c46f716, Offset: 0x198
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace zm_game_over/zm_game_over
// Params 2, eflags: 0x1 linked
// Checksum 0x5073f120, Offset: 0x1c8
// Size: 0x28
function set_rounds(player, value) {
    [[ self ]]->set_rounds(player, value);
}

