#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace full_screen_movie;

// Namespace full_screen_movie
// Method(s) 12 Total 19
class cfull_screen_movie : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0x29e5aadf, Offset: 0x520
    // Size: 0x44
    function set_moviename(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "movieName", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0x92961b25, Offset: 0x4a8
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0x3405ea02, Offset: 0x700
    // Size: 0x44
    function set_moviekey(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "movieKey", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0xff94469a, Offset: 0x660
    // Size: 0x44
    function set_playoutromovie(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "playOutroMovie", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0x9fa1017c, Offset: 0x610
    // Size: 0x44
    function set_additive(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "additive", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 1, eflags: 0x0
    // Checksum 0x2f305a8a, Offset: 0x4f0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0xd491f789, Offset: 0x5c0
    // Size: 0x44
    function set_looping(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "looping", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0xe814f00b, Offset: 0x6b0
    // Size: 0x44
    function registerplayer_callout_traversal(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "skippable", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0xcdb2b242, Offset: 0x570
    // Size: 0x44
    function set_showblackscreen(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "showBlackScreen", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 0, eflags: 0x0
    // Checksum 0x22e52038, Offset: 0x368
    // Size: 0x134
    function setup_clientfields() {
        cluielem::setup_clientfields("full_screen_movie");
        cluielem::function_dcb34c80("moviefile", "movieName", 1);
        cluielem::add_clientfield("showBlackScreen", 1, 1, "int");
        cluielem::add_clientfield("looping", 1, 1, "int");
        cluielem::add_clientfield("additive", 1, 1, "int");
        cluielem::add_clientfield("playOutroMovie", 1, 1, "int");
        cluielem::add_clientfield("skippable", 1, 1, "int");
        cluielem::function_dcb34c80("moviefile", "movieKey", 1);
    }

}

// Namespace full_screen_movie/full_screen_movie
// Params 0, eflags: 0x0
// Checksum 0x28300c91, Offset: 0x128
// Size: 0x34
function register() {
    elem = new cfull_screen_movie();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x35673d9d, Offset: 0x168
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace full_screen_movie/full_screen_movie
// Params 1, eflags: 0x0
// Checksum 0x9a12b086, Offset: 0x1a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace full_screen_movie/full_screen_movie
// Params 1, eflags: 0x0
// Checksum 0x49a08577, Offset: 0x1d0
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x1ad65657, Offset: 0x1f8
// Size: 0x28
function set_moviename(player, value) {
    [[ self ]]->set_moviename(player, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x5a4a0144, Offset: 0x228
// Size: 0x28
function set_showblackscreen(player, value) {
    [[ self ]]->set_showblackscreen(player, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x265877a7, Offset: 0x258
// Size: 0x28
function set_looping(player, value) {
    [[ self ]]->set_looping(player, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x8164ed7e, Offset: 0x288
// Size: 0x28
function set_additive(player, value) {
    [[ self ]]->set_additive(player, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0xf07f57d5, Offset: 0x2b8
// Size: 0x28
function set_playoutromovie(player, value) {
    [[ self ]]->set_playoutromovie(player, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0xbc1e1e38, Offset: 0x2e8
// Size: 0x28
function registerplayer_callout_traversal(player, value) {
    [[ self ]]->registerplayer_callout_traversal(player, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x88c08072, Offset: 0x318
// Size: 0x28
function set_moviekey(player, value) {
    [[ self ]]->set_moviekey(player, value);
}

