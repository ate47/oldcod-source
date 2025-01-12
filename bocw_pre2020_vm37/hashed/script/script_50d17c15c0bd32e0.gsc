#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace player_insertion_choice;

// Namespace player_insertion_choice
// Method(s) 6 Total 13
class cplayer_insertion_choice : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 2, eflags: 0x0
    // Checksum 0x2827c246, Offset: 0x240
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 1, eflags: 0x0
    // Checksum 0xbfff7d85, Offset: 0x288
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 0, eflags: 0x0
    // Checksum 0xabd12bc7, Offset: 0x1f0
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("player_insertion_choice");
        cluielem::add_clientfield("_state", 1, 2, "int");
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 2, eflags: 0x0
    // Checksum 0x8c3f02d8, Offset: 0x2b8
    // Size: 0x15c
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 0);
            return;
        }
        if (#"groundvehicle" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 1);
            return;
        }
        if (#"halojump" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 2);
            return;
        }
        if (#"heli" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 3);
            return;
        }
        assertmsg("<dev string:x38>");
    }

}

// Namespace player_insertion_choice/player_insertion_choice
// Params 0, eflags: 0x0
// Checksum 0x120c1d3f, Offset: 0xd0
// Size: 0x34
function register() {
    elem = new cplayer_insertion_choice();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 2, eflags: 0x0
// Checksum 0x2d020860, Offset: 0x110
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 1, eflags: 0x0
// Checksum 0xfd201144, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 1, eflags: 0x0
// Checksum 0xc0142567, Offset: 0x178
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 2, eflags: 0x0
// Checksum 0x79874fca, Offset: 0x1a0
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

