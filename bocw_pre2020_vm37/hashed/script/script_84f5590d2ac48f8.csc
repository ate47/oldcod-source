#using scripts\core_common\lui_shared;

#namespace full_screen_movie;

// Namespace full_screen_movie
// Method(s) 13 Total 19
class cfull_screen_movie : cluielem {

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2bafa018, Offset: 0x7e8
    // Size: 0x30
    function set_moviename(localclientnum, value) {
        set_data(localclientnum, "movieName", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 1, eflags: 0x1 linked
    // Checksum 0x9e677ff8, Offset: 0x7b8
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x1 linked
    // Checksum 0xcb7157db, Offset: 0x938
    // Size: 0x30
    function set_moviekey(localclientnum, value) {
        set_data(localclientnum, "movieKey", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x1 linked
    // Checksum 0xecf29d16, Offset: 0x8c8
    // Size: 0x30
    function set_playoutromovie(localclientnum, value) {
        set_data(localclientnum, "playOutroMovie", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb54971a6, Offset: 0x890
    // Size: 0x30
    function set_additive(localclientnum, value) {
        set_data(localclientnum, "additive", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf202c822, Offset: 0x680
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("full_screen_movie");
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x1 linked
    // Checksum 0x6c03e253, Offset: 0x858
    // Size: 0x30
    function set_looping(localclientnum, value) {
        set_data(localclientnum, "looping", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x1 linked
    // Checksum 0xf17f91ff, Offset: 0x900
    // Size: 0x30
    function registerplayer_callout_traversal(localclientnum, value) {
        set_data(localclientnum, "skippable", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 2, eflags: 0x1 linked
    // Checksum 0x4bfac6a6, Offset: 0x820
    // Size: 0x30
    function set_showblackscreen(localclientnum, value) {
        set_data(localclientnum, "showBlackScreen", value);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 7, eflags: 0x1 linked
    // Checksum 0xc6e6faf5, Offset: 0x508
    // Size: 0x16c
    function setup_clientfields(*var_f7b454f9, var_d5b04ae3, var_e4decd0, var_e545d4b9, var_78184b90, var_8ba396cb, *var_ea38d488) {
        cluielem::setup_clientfields("full_screen_movie");
        cluielem::function_dcb34c80("moviefile", "movieName", 1);
        cluielem::add_clientfield("showBlackScreen", 1, 1, "int", var_e4decd0);
        cluielem::add_clientfield("looping", 1, 1, "int", var_e545d4b9);
        cluielem::add_clientfield("additive", 1, 1, "int", var_78184b90);
        cluielem::add_clientfield("playOutroMovie", 1, 1, "int", var_8ba396cb);
        cluielem::add_clientfield("skippable", 1, 1, "int", var_ea38d488);
        cluielem::function_dcb34c80("moviefile", "movieKey", 1);
    }

    // Namespace cfull_screen_movie/full_screen_movie
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd9084b2f, Offset: 0x6a8
    // Size: 0x104
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "movieName", #"");
        set_data(localclientnum, "showBlackScreen", 0);
        set_data(localclientnum, "looping", 0);
        set_data(localclientnum, "additive", 0);
        set_data(localclientnum, "playOutroMovie", 0);
        set_data(localclientnum, "skippable", 0);
        set_data(localclientnum, "movieKey", #"");
    }

}

// Namespace full_screen_movie/full_screen_movie
// Params 7, eflags: 0x1 linked
// Checksum 0xc0d90e7c, Offset: 0x120
// Size: 0x1b6
function register(var_f7b454f9, var_d5b04ae3, var_e4decd0, var_e545d4b9, var_78184b90, var_8ba396cb, var_ea38d488) {
    elem = new cfull_screen_movie();
    [[ elem ]]->setup_clientfields(var_f7b454f9, var_d5b04ae3, var_e4decd0, var_e545d4b9, var_78184b90, var_8ba396cb, var_ea38d488);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"full_screen_movie"])) {
        level.var_ae746e8f[#"full_screen_movie"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"full_screen_movie"])) {
        level.var_ae746e8f[#"full_screen_movie"] = [];
    } else if (!isarray(level.var_ae746e8f[#"full_screen_movie"])) {
        level.var_ae746e8f[#"full_screen_movie"] = array(level.var_ae746e8f[#"full_screen_movie"]);
    }
    level.var_ae746e8f[#"full_screen_movie"][level.var_ae746e8f[#"full_screen_movie"].size] = elem;
}

// Namespace full_screen_movie/full_screen_movie
// Params 0, eflags: 0x0
// Checksum 0xbb5e9a00, Offset: 0x2e0
// Size: 0x34
function register_clientside() {
    elem = new cfull_screen_movie();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace full_screen_movie/full_screen_movie
// Params 1, eflags: 0x0
// Checksum 0x1ef3c9fe, Offset: 0x320
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace full_screen_movie/full_screen_movie
// Params 1, eflags: 0x0
// Checksum 0xca2ca5ff, Offset: 0x348
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace full_screen_movie/full_screen_movie
// Params 1, eflags: 0x0
// Checksum 0x37aa5fab, Offset: 0x370
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0xc70698db, Offset: 0x398
// Size: 0x28
function set_moviename(localclientnum, value) {
    [[ self ]]->set_moviename(localclientnum, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x67606986, Offset: 0x3c8
// Size: 0x28
function set_showblackscreen(localclientnum, value) {
    [[ self ]]->set_showblackscreen(localclientnum, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0xf2e101ec, Offset: 0x3f8
// Size: 0x28
function set_looping(localclientnum, value) {
    [[ self ]]->set_looping(localclientnum, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x9da1b2da, Offset: 0x428
// Size: 0x28
function set_additive(localclientnum, value) {
    [[ self ]]->set_additive(localclientnum, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0xa6766d5e, Offset: 0x458
// Size: 0x28
function set_playoutromovie(localclientnum, value) {
    [[ self ]]->set_playoutromovie(localclientnum, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0xcf905c46, Offset: 0x488
// Size: 0x28
function registerplayer_callout_traversal(localclientnum, value) {
    [[ self ]]->registerplayer_callout_traversal(localclientnum, value);
}

// Namespace full_screen_movie/full_screen_movie
// Params 2, eflags: 0x0
// Checksum 0x118359e0, Offset: 0x4b8
// Size: 0x28
function set_moviekey(localclientnum, value) {
    [[ self ]]->set_moviekey(localclientnum, value);
}

