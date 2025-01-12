#using scripts\core_common\lui_shared;

#namespace full_screen_movie;

// Namespace full_screen_movie
// Method(s) 12 Total 18
class cfull_screen_movie : cluielem {

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0x1a4293c2, Offset: 0x728
    // Size: 0x30
    function function_7d4e5f11(localclientnum, value) {
        set_data(localclientnum, "skippable", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0xf6ba6740, Offset: 0x6f0
    // Size: 0x30
    function set_playoutromovie(localclientnum, value) {
        set_data(localclientnum, "playOutroMovie", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0x8585074, Offset: 0x6b8
    // Size: 0x30
    function set_additive(localclientnum, value) {
        set_data(localclientnum, "additive", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0xbfa99209, Offset: 0x680
    // Size: 0x30
    function set_looping(localclientnum, value) {
        set_data(localclientnum, "looping", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0x67543b3e, Offset: 0x648
    // Size: 0x30
    function set_showblackscreen(localclientnum, value) {
        set_data(localclientnum, "showBlackScreen", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x0
    // Checksum 0xa2d826fe, Offset: 0x610
    // Size: 0x30
    function set_moviename(localclientnum, value) {
        set_data(localclientnum, "movieName", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 1, eflags: 0x0
    // Checksum 0xb379a26f, Offset: 0x5d8
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"full_screen_movie");
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 1, eflags: 0x0
    // Checksum 0x337d389c, Offset: 0x4f8
    // Size: 0xd8
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "movieName", #"");
        set_data(localclientnum, "showBlackScreen", 0);
        set_data(localclientnum, "looping", 0);
        set_data(localclientnum, "additive", 0);
        set_data(localclientnum, "playOutroMovie", 0);
        set_data(localclientnum, "skippable", 0);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 1, eflags: 0x0
    // Checksum 0x626b51cf, Offset: 0x4c8
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 7, eflags: 0x0
    // Checksum 0xa26cf6b5, Offset: 0x378
    // Size: 0x144
    function setup_clientfields(uid, var_64e3da13, var_a22272e, var_5b706c2c, var_e7e7a9a4, var_f332688d, var_c1b0ac4d) {
        cluielem::setup_clientfields(uid);
        cluielem::function_52818084("moviefile", "movieName", 1);
        cluielem::add_clientfield("showBlackScreen", 1, 1, "int", var_a22272e);
        cluielem::add_clientfield("looping", 1, 1, "int", var_5b706c2c);
        cluielem::add_clientfield("additive", 1, 1, "int", var_e7e7a9a4);
        cluielem::add_clientfield("playOutroMovie", 1, 1, "int", var_f332688d);
        cluielem::add_clientfield("skippable", 1, 1, "int", var_c1b0ac4d);
    }

}

// Namespace full_screen_movie/full_screen_movie
// Params 7, eflags: 0x0
// Checksum 0xa70e0fb6, Offset: 0xe8
// Size: 0x88
function register(uid, var_64e3da13, var_a22272e, var_5b706c2c, var_e7e7a9a4, var_f332688d, var_c1b0ac4d) {
    elem = new cfull_screen_movie();
    [[ elem ]]->setup_clientfields(uid, var_64e3da13, var_a22272e, var_5b706c2c, var_e7e7a9a4, var_f332688d, var_c1b0ac4d);
    return elem;
}

// Namespace full_screen_movie/full_screen_movie
// Params 1, eflags: 0x0
// Checksum 0x83123739, Offset: 0x178
// Size: 0x40
function register_clientside(uid) {
    elem = new cfull_screen_movie();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace full_screen_movie/full_screen_movie
// Params 1, eflags: 0x0
// Checksum 0x9453fdde, Offset: 0x1c0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace full_screen_movie/full_screen_movie
// Params 1, eflags: 0x0
// Checksum 0x2b66b5f3, Offset: 0x1e8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace full_screen_movie/full_screen_movie
// Params 1, eflags: 0x0
// Checksum 0x816d9a99, Offset: 0x210
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0xde7ab54e, Offset: 0x238
// Size: 0x28
function set_moviename(localclientnum, value) {
    [[ self ]]->set_moviename(localclientnum, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x9af1d294, Offset: 0x268
// Size: 0x28
function set_showblackscreen(localclientnum, value) {
    [[ self ]]->set_showblackscreen(localclientnum, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x1eb39f14, Offset: 0x298
// Size: 0x28
function set_looping(localclientnum, value) {
    [[ self ]]->set_looping(localclientnum, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0xef5330ac, Offset: 0x2c8
// Size: 0x28
function set_additive(localclientnum, value) {
    [[ self ]]->set_additive(localclientnum, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x42c0e0b4, Offset: 0x2f8
// Size: 0x28
function set_playoutromovie(localclientnum, value) {
    [[ self ]]->set_playoutromovie(localclientnum, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x1c6c3e9, Offset: 0x328
// Size: 0x28
function function_7d4e5f11(localclientnum, value) {
    [[ self ]]->function_7d4e5f11(localclientnum, value);
}

