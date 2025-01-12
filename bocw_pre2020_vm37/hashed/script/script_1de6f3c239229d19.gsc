#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_game_timer;

// Namespace zm_game_timer
// Method(s) 8 Total 15
class czm_game_timer : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x1 linked
    // Checksum 0x76cbe3e6, Offset: 0x2f8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x1 linked
    // Checksum 0x61c1145e, Offset: 0x3c0
    // Size: 0x44
    function set_minutes(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "minutes", value);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 1, eflags: 0x1 linked
    // Checksum 0x99180767, Offset: 0x340
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x1 linked
    // Checksum 0x99fafd95, Offset: 0x410
    // Size: 0x44
    function set_showzero(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "showzero", value);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbc5e87a8, Offset: 0x258
    // Size: 0x94
    function setup_clientfields() {
        cluielem::setup_clientfields("zm_game_timer");
        cluielem::add_clientfield("seconds", 1, 6, "int");
        cluielem::add_clientfield("minutes", 1, 9, "int");
        cluielem::add_clientfield("showzero", 1, 1, "int");
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa933b148, Offset: 0x370
    // Size: 0x44
    function set_seconds(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "seconds", value);
    }

}

// Namespace zm_game_timer/zm_game_timer
// Params 0, eflags: 0x0
// Checksum 0xcb97bc86, Offset: 0xd8
// Size: 0x34
function register() {
    elem = new czm_game_timer();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0xab93d0f6, Offset: 0x118
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_game_timer/zm_game_timer
// Params 1, eflags: 0x0
// Checksum 0x2f3c9e91, Offset: 0x158
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_game_timer/zm_game_timer
// Params 1, eflags: 0x0
// Checksum 0x54a16eec, Offset: 0x180
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0xade4be6e, Offset: 0x1a8
// Size: 0x28
function set_seconds(player, value) {
    [[ self ]]->set_seconds(player, value);
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0xd7e004c5, Offset: 0x1d8
// Size: 0x28
function set_minutes(player, value) {
    [[ self ]]->set_minutes(player, value);
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0x24942bb8, Offset: 0x208
// Size: 0x28
function set_showzero(player, value) {
    [[ self ]]->set_showzero(player, value);
}

