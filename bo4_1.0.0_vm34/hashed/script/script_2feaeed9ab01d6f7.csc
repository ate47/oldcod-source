#using scripts\core_common\lui_shared;

#namespace full_screen_black;

// Namespace full_screen_black
// Method(s) 12 Total 18
class cfull_screen_black : cluielem {

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x5144dc69, Offset: 0x730
    // Size: 0x30
    function set_endalpha(localclientnum, value) {
        set_data(localclientnum, "endAlpha", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0xa0ac908a, Offset: 0x6f8
    // Size: 0x30
    function set_startalpha(localclientnum, value) {
        set_data(localclientnum, "startAlpha", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x5d6b9310, Offset: 0x6c0
    // Size: 0x30
    function set_fadeovertime(localclientnum, value) {
        set_data(localclientnum, "fadeOverTime", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x47894206, Offset: 0x688
    // Size: 0x30
    function set_blue(localclientnum, value) {
        set_data(localclientnum, "blue", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x6008499c, Offset: 0x650
    // Size: 0x30
    function set_green(localclientnum, value) {
        set_data(localclientnum, "green", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x6bb92e36, Offset: 0x618
    // Size: 0x30
    function set_red(localclientnum, value) {
        set_data(localclientnum, "red", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 1, eflags: 0x0
    // Checksum 0x2fd3cf, Offset: 0x5e0
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"full_screen_black");
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 1, eflags: 0x0
    // Checksum 0x5e893975, Offset: 0x4e0
    // Size: 0xf4
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "red", 0);
        set_data(localclientnum, "green", 0);
        set_data(localclientnum, "blue", 0);
        set_data(localclientnum, "fadeOverTime", 0);
        set_data(localclientnum, "startAlpha", 0);
        set_data(localclientnum, "endAlpha", 0);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 1, eflags: 0x0
    // Checksum 0xc9dcb8d, Offset: 0x4b0
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 7, eflags: 0x0
    // Checksum 0x3f02fc10, Offset: 0x360
    // Size: 0x144
    function setup_clientfields(uid, redcallback, greencallback, bluecallback, fadeovertimecallback, var_590c4dbc, var_41683581) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("red", 1, 3, "float", redcallback);
        cluielem::add_clientfield("green", 1, 3, "float", greencallback);
        cluielem::add_clientfield("blue", 1, 3, "float", bluecallback);
        cluielem::add_clientfield("fadeOverTime", 1, 12, "int", fadeovertimecallback);
        cluielem::add_clientfield("startAlpha", 1, 5, "float", var_590c4dbc);
        cluielem::add_clientfield("endAlpha", 1, 5, "float", var_41683581);
    }

}

// Namespace full_screen_black/full_screen_black
// Params 7, eflags: 0x0
// Checksum 0x9900d73b, Offset: 0xd0
// Size: 0x88
function register(uid, redcallback, greencallback, bluecallback, fadeovertimecallback, var_590c4dbc, var_41683581) {
    elem = new cfull_screen_black();
    [[ elem ]]->setup_clientfields(uid, redcallback, greencallback, bluecallback, fadeovertimecallback, var_590c4dbc, var_41683581);
    return elem;
}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0x4352a71c, Offset: 0x160
// Size: 0x40
function register_clientside(uid) {
    elem = new cfull_screen_black();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0x87a4a70e, Offset: 0x1a8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0x618121b4, Offset: 0x1d0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0xb57d357, Offset: 0x1f8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x6543474f, Offset: 0x220
// Size: 0x28
function set_red(localclientnum, value) {
    [[ self ]]->set_red(localclientnum, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xc5b9d838, Offset: 0x250
// Size: 0x28
function set_green(localclientnum, value) {
    [[ self ]]->set_green(localclientnum, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x74780e09, Offset: 0x280
// Size: 0x28
function set_blue(localclientnum, value) {
    [[ self ]]->set_blue(localclientnum, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xa55136cc, Offset: 0x2b0
// Size: 0x28
function set_fadeovertime(localclientnum, value) {
    [[ self ]]->set_fadeovertime(localclientnum, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xf2e4de44, Offset: 0x2e0
// Size: 0x28
function set_startalpha(localclientnum, value) {
    [[ self ]]->set_startalpha(localclientnum, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x2b413ba5, Offset: 0x310
// Size: 0x28
function set_endalpha(localclientnum, value) {
    [[ self ]]->set_endalpha(localclientnum, value);
}

