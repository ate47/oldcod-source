#using scripts\core_common\lui_shared;

#namespace luielembar;

// Namespace luielembar
// Method(s) 16 Total 22
class cluielembar : cluielem {

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0xb21b6e5d, Offset: 0xa40
    // Size: 0x30
    function set_bar_percent(localclientnum, value) {
        set_data(localclientnum, "bar_percent", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x4bb8f04a, Offset: 0xa08
    // Size: 0x30
    function set_blue(localclientnum, value) {
        set_data(localclientnum, "blue", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x6268a2c, Offset: 0x9d0
    // Size: 0x30
    function set_green(localclientnum, value) {
        set_data(localclientnum, "green", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x270ff93c, Offset: 0x998
    // Size: 0x30
    function set_red(localclientnum, value) {
        set_data(localclientnum, "red", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x53891e5f, Offset: 0x960
    // Size: 0x30
    function set_alpha(localclientnum, value) {
        set_data(localclientnum, "alpha", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x36a313a1, Offset: 0x928
    // Size: 0x30
    function set_fadeovertime(localclientnum, value) {
        set_data(localclientnum, "fadeOverTime", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x3c083d1d, Offset: 0x8f0
    // Size: 0x30
    function set_height(localclientnum, value) {
        set_data(localclientnum, "height", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x2894b00d, Offset: 0x8b8
    // Size: 0x30
    function set_width(localclientnum, value) {
        set_data(localclientnum, "width", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0xc4461d6c, Offset: 0x880
    // Size: 0x30
    function set_y(localclientnum, value) {
        set_data(localclientnum, "y", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x38b53cb9, Offset: 0x848
    // Size: 0x30
    function set_x(localclientnum, value) {
        set_data(localclientnum, "x", value);
    }

    // Namespace cluielembar/luielembar
    // Params 1, eflags: 0x0
    // Checksum 0x8eaa5e2, Offset: 0x810
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"luielembar");
    }

    // Namespace cluielembar/luielembar
    // Params 1, eflags: 0x0
    // Checksum 0x4a2e7771, Offset: 0x6a0
    // Size: 0x164
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "x", 0);
        set_data(localclientnum, "y", 0);
        set_data(localclientnum, "width", 0);
        set_data(localclientnum, "height", 0);
        set_data(localclientnum, "fadeOverTime", 0);
        set_data(localclientnum, "alpha", 0);
        set_data(localclientnum, "red", 0);
        set_data(localclientnum, "green", 0);
        set_data(localclientnum, "blue", 0);
        set_data(localclientnum, "bar_percent", 0);
    }

    // Namespace cluielembar/luielembar
    // Params 1, eflags: 0x0
    // Checksum 0xd88aef6f, Offset: 0x670
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cluielembar/luielembar
    // Params 11, eflags: 0x0
    // Checksum 0x80820749, Offset: 0x460
    // Size: 0x204
    function setup_clientfields(uid, xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_c3ff047f) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("x", 1, 7, "int", xcallback);
        cluielem::add_clientfield("y", 1, 6, "int", ycallback);
        cluielem::add_clientfield("width", 1, 6, "int", widthcallback);
        cluielem::add_clientfield("height", 1, 6, "int", heightcallback);
        cluielem::add_clientfield("fadeOverTime", 1, 5, "int", fadeovertimecallback);
        cluielem::add_clientfield("alpha", 1, 4, "float", alphacallback);
        cluielem::add_clientfield("red", 1, 4, "float", redcallback);
        cluielem::add_clientfield("green", 1, 4, "float", greencallback);
        cluielem::add_clientfield("blue", 1, 4, "float", bluecallback);
        cluielem::add_clientfield("bar_percent", 1, 6, "float", var_c3ff047f);
    }

}

// Namespace luielembar/luielembar
// Params 11, eflags: 0x0
// Checksum 0x392cb60, Offset: 0xe0
// Size: 0xb8
function register(uid, xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_c3ff047f) {
    elem = new cluielembar();
    [[ elem ]]->setup_clientfields(uid, xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_c3ff047f);
    return elem;
}

// Namespace luielembar/luielembar
// Params 1, eflags: 0x0
// Checksum 0x57636e, Offset: 0x1a0
// Size: 0x40
function register_clientside(uid) {
    elem = new cluielembar();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace luielembar/luielembar
// Params 1, eflags: 0x0
// Checksum 0x1ae3607c, Offset: 0x1e8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace luielembar/luielembar
// Params 1, eflags: 0x0
// Checksum 0xd44c4ebf, Offset: 0x210
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielembar/luielembar
// Params 1, eflags: 0x0
// Checksum 0xd309065, Offset: 0x238
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xb7e4cdbf, Offset: 0x260
// Size: 0x28
function set_x(localclientnum, value) {
    [[ self ]]->set_x(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x5e0e0228, Offset: 0x290
// Size: 0x28
function set_y(localclientnum, value) {
    [[ self ]]->set_y(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x74a7a3e7, Offset: 0x2c0
// Size: 0x28
function set_width(localclientnum, value) {
    [[ self ]]->set_width(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x1aa30500, Offset: 0x2f0
// Size: 0x28
function set_height(localclientnum, value) {
    [[ self ]]->set_height(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x43ef6986, Offset: 0x320
// Size: 0x28
function set_fadeovertime(localclientnum, value) {
    [[ self ]]->set_fadeovertime(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xac3af471, Offset: 0x350
// Size: 0x28
function set_alpha(localclientnum, value) {
    [[ self ]]->set_alpha(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x5ed605d8, Offset: 0x380
// Size: 0x28
function set_red(localclientnum, value) {
    [[ self ]]->set_red(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x4032b12f, Offset: 0x3b0
// Size: 0x28
function set_green(localclientnum, value) {
    [[ self ]]->set_green(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x9d176ba, Offset: 0x3e0
// Size: 0x28
function set_blue(localclientnum, value) {
    [[ self ]]->set_blue(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xa6b514c0, Offset: 0x410
// Size: 0x28
function set_bar_percent(localclientnum, value) {
    [[ self ]]->set_bar_percent(localclientnum, value);
}

