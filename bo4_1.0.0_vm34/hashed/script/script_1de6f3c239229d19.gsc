#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_game_timer;

// Namespace zm_game_timer
// Method(s) 8 Total 15
class czm_game_timer : cluielem {

    var var_57a3d576;

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x0
    // Checksum 0x29034299, Offset: 0x408
    // Size: 0x3c
    function set_showzero(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "showzero", value);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x0
    // Checksum 0xe33ab2e3, Offset: 0x3c0
    // Size: 0x3c
    function set_minutes(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "minutes", value);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x0
    // Checksum 0xc4306c82, Offset: 0x378
    // Size: 0x3c
    function set_seconds(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "seconds", value);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 1, eflags: 0x0
    // Checksum 0xb6fb3953, Offset: 0x348
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x0
    // Checksum 0x6cec54e3, Offset: 0x2f8
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_game_timer", persistent);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 1, eflags: 0x0
    // Checksum 0xc9df4542, Offset: 0x250
    // Size: 0x9c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("seconds", 1, 6, "int");
        cluielem::add_clientfield("minutes", 1, 9, "int");
        cluielem::add_clientfield("showzero", 1, 1, "int");
    }

}

// Namespace zm_game_timer/zm_game_timer
// Params 1, eflags: 0x0
// Checksum 0x9884b188, Offset: 0xc8
// Size: 0x40
function register(uid) {
    elem = new czm_game_timer();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0xd5ab1a42, Offset: 0x110
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_game_timer/zm_game_timer
// Params 1, eflags: 0x0
// Checksum 0xe51cf8c9, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_game_timer/zm_game_timer
// Params 1, eflags: 0x0
// Checksum 0xf8c756c, Offset: 0x178
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0x2f410f7d, Offset: 0x1a0
// Size: 0x28
function set_seconds(player, value) {
    [[ self ]]->set_seconds(player, value);
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0x2da67d88, Offset: 0x1d0
// Size: 0x28
function set_minutes(player, value) {
    [[ self ]]->set_minutes(player, value);
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0xeda3c5c0, Offset: 0x200
// Size: 0x28
function set_showzero(player, value) {
    [[ self ]]->set_showzero(player, value);
}

