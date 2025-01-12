#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace full_screen_movie;

// Namespace full_screen_movie
// Method(s) 11 Total 18
class cfull_screen_movie : cluielem {

    var var_57a3d576;

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0x9dcdd490, Offset: 0x620
    // Size: 0x3c
    function function_7d4e5f11(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "skippable", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0x231b3a7e, Offset: 0x5d8
    // Size: 0x3c
    function set_playoutromovie(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "playOutroMovie", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0xc3124426, Offset: 0x590
    // Size: 0x3c
    function set_additive(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "additive", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0x8088366c, Offset: 0x548
    // Size: 0x3c
    function set_looping(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "looping", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0x2f6e8d09, Offset: 0x500
    // Size: 0x3c
    function set_showblackscreen(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "showBlackScreen", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0xace86483, Offset: 0x4b8
    // Size: 0x3c
    function set_moviename(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "movieName", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 1, eflags: 0x0
    // Checksum 0x62d0eac6, Offset: 0x488
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0x5195e9e5, Offset: 0x438
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "full_screen_movie", persistent);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 1, eflags: 0x0
    // Checksum 0xc26b9adb, Offset: 0x318
    // Size: 0x114
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::function_52818084("moviefile", "movieName", 1);
        cluielem::add_clientfield("showBlackScreen", 1, 1, "int");
        cluielem::add_clientfield("looping", 1, 1, "int");
        cluielem::add_clientfield("additive", 1, 1, "int");
        cluielem::add_clientfield("playOutroMovie", 1, 1, "int");
        cluielem::add_clientfield("skippable", 1, 1, "int");
    }

}

// Namespace full_screen_movie/full_screen_movie
// Params 1, eflags: 0x0
// Checksum 0x73fa247f, Offset: 0x100
// Size: 0x40
function register(uid) {
    elem = new cfull_screen_movie();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x156cdaa7, Offset: 0x148
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace full_screen_movie/full_screen_movie
// Params 1, eflags: 0x0
// Checksum 0xa90f40fd, Offset: 0x188
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace full_screen_movie/full_screen_movie
// Params 1, eflags: 0x0
// Checksum 0xd2ca63eb, Offset: 0x1b0
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0xbdc0be22, Offset: 0x1d8
// Size: 0x28
function set_moviename(player, value) {
    [[ self ]]->set_moviename(player, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x2144d366, Offset: 0x208
// Size: 0x28
function set_showblackscreen(player, value) {
    [[ self ]]->set_showblackscreen(player, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0xf1231312, Offset: 0x238
// Size: 0x28
function set_looping(player, value) {
    [[ self ]]->set_looping(player, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x883bbbf, Offset: 0x268
// Size: 0x28
function set_additive(player, value) {
    [[ self ]]->set_additive(player, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x367717b6, Offset: 0x298
// Size: 0x28
function set_playoutromovie(player, value) {
    [[ self ]]->set_playoutromovie(player, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x61b7374e, Offset: 0x2c8
// Size: 0x28
function function_7d4e5f11(player, value) {
    [[ self ]]->function_7d4e5f11(player, value);
}

