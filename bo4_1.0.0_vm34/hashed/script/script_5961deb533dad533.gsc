#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace luielembar;

// Namespace luielembar
// Method(s) 15 Total 22
class cluielembar : cluielem {

    var var_57a3d576;

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x4e6a19fe, Offset: 0xbc8
    // Size: 0x3c
    function set_bar_percent(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "bar_percent", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0xd17db288, Offset: 0xb80
    // Size: 0x3c
    function set_blue(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "blue", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0xafaf6050, Offset: 0xb38
    // Size: 0x3c
    function set_green(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "green", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x1bd385b1, Offset: 0xaf0
    // Size: 0x3c
    function set_red(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "red", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x2c5030ae, Offset: 0xaa8
    // Size: 0x3c
    function set_alpha(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "alpha", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x32812922, Offset: 0xa60
    // Size: 0x3c
    function set_fadeovertime(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "fadeOverTime", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x4fbdcfd2, Offset: 0xa18
    // Size: 0x3c
    function set_height(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "height", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0xd8642ff4, Offset: 0x9d0
    // Size: 0x3c
    function set_width(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "width", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x28c1f728, Offset: 0x988
    // Size: 0x3c
    function set_y(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "y", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x317c6a11, Offset: 0x940
    // Size: 0x3c
    function set_x(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "x", value);
    }

    // Namespace cluielembar/luielembar
    // Params 1, eflags: 0x0
    // Checksum 0xbf2feec8, Offset: 0x910
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x10947a94, Offset: 0x8c0
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "LUIelemBar", persistent);
    }

    // Namespace cluielembar/luielembar
    // Params 1, eflags: 0x0
    // Checksum 0x159bb7ae, Offset: 0x700
    // Size: 0x1b4
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("x", 1, 7, "int");
        cluielem::add_clientfield("y", 1, 6, "int");
        cluielem::add_clientfield("width", 1, 6, "int");
        cluielem::add_clientfield("height", 1, 6, "int");
        cluielem::add_clientfield("fadeOverTime", 1, 5, "int");
        cluielem::add_clientfield("alpha", 1, 4, "float");
        cluielem::add_clientfield("red", 1, 4, "float");
        cluielem::add_clientfield("green", 1, 4, "float");
        cluielem::add_clientfield("blue", 1, 4, "float");
        cluielem::add_clientfield("bar_percent", 1, 6, "float");
    }

}

// Namespace luielembar/luielembar
// Params 4, eflags: 0x0
// Checksum 0xe72187d1, Offset: 0xf0
// Size: 0x6c
function set_color(player, red, green, blue) {
    self set_red(player, red);
    self set_green(player, green);
    self set_blue(player, blue);
}

// Namespace luielembar/luielembar
// Params 3, eflags: 0x0
// Checksum 0x499719d1, Offset: 0x168
// Size: 0x7c
function fade(player, var_b43a1f03, duration = 0) {
    self set_alpha(player, var_b43a1f03);
    self set_fadeovertime(player, int(duration * 10));
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xef62d0e7, Offset: 0x1f0
// Size: 0x44
function show(player, duration = 0) {
    self fade(player, 1, duration);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x66586316, Offset: 0x240
// Size: 0x3c
function hide(player, duration = 0) {
    self fade(player, 0, duration);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x53e57c, Offset: 0x288
// Size: 0x4c
function function_9afa3156(player, var_5c38c80f) {
    self set_x(player, int(var_5c38c80f / 15));
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x920f1c35, Offset: 0x2e0
// Size: 0x4c
function function_56b41599(player, var_36364da6) {
    self set_y(player, int(var_36364da6 / 15));
}

// Namespace luielembar/luielembar
// Params 3, eflags: 0x0
// Checksum 0x8eda1c73, Offset: 0x338
// Size: 0x4c
function function_ec358cb5(player, var_5c38c80f, var_36364da6) {
    self function_9afa3156(player, var_5c38c80f);
    self function_56b41599(player, var_36364da6);
}

// Namespace luielembar/luielembar
// Params 3, eflags: 0x0
// Checksum 0x20f123dd, Offset: 0x390
// Size: 0x8c
function function_a6bbb523(player, width, height) {
    self set_width(player, int(width / 4));
    self set_height(player, int(height / 4));
}

// Namespace luielembar/luielembar
// Params 1, eflags: 0x0
// Checksum 0x678b4f10, Offset: 0x428
// Size: 0x40
function register(uid) {
    elem = new cluielembar();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xe7732437, Offset: 0x470
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace luielembar/luielembar
// Params 1, eflags: 0x0
// Checksum 0xd14d7b32, Offset: 0x4b0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielembar/luielembar
// Params 1, eflags: 0x0
// Checksum 0x39566483, Offset: 0x4d8
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x91f974b8, Offset: 0x500
// Size: 0x28
function set_x(player, value) {
    [[ self ]]->set_x(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x1af352ea, Offset: 0x530
// Size: 0x28
function set_y(player, value) {
    [[ self ]]->set_y(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xe15a7851, Offset: 0x560
// Size: 0x28
function set_width(player, value) {
    [[ self ]]->set_width(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x97330d0a, Offset: 0x590
// Size: 0x28
function set_height(player, value) {
    [[ self ]]->set_height(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xc3895f9, Offset: 0x5c0
// Size: 0x28
function set_fadeovertime(player, value) {
    [[ self ]]->set_fadeovertime(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x386d13a2, Offset: 0x5f0
// Size: 0x28
function set_alpha(player, value) {
    [[ self ]]->set_alpha(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x8b1057c6, Offset: 0x620
// Size: 0x28
function set_red(player, value) {
    [[ self ]]->set_red(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x806471a8, Offset: 0x650
// Size: 0x28
function set_green(player, value) {
    [[ self ]]->set_green(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x5b3fe855, Offset: 0x680
// Size: 0x28
function set_blue(player, value) {
    [[ self ]]->set_blue(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x79fb4228, Offset: 0x6b0
// Size: 0x28
function set_bar_percent(player, value) {
    [[ self ]]->set_bar_percent(player, value);
}

