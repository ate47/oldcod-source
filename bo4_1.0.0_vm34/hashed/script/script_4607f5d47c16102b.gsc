#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace luielemimage;

// Namespace luielemimage
// Method(s) 15 Total 22
class cluielemimage : cluielem {

    var var_57a3d576;

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xe96ed9d8, Offset: 0xbc8
    // Size: 0x3c
    function set_material(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "material", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x55d0e8f6, Offset: 0xb80
    // Size: 0x3c
    function set_blue(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "blue", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x98068e4c, Offset: 0xb38
    // Size: 0x3c
    function set_green(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "green", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x2e1e4411, Offset: 0xaf0
    // Size: 0x3c
    function set_red(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "red", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x7839ba32, Offset: 0xaa8
    // Size: 0x3c
    function set_alpha(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "alpha", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x4d9495e6, Offset: 0xa60
    // Size: 0x3c
    function set_fadeovertime(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "fadeOverTime", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xe04c076c, Offset: 0xa18
    // Size: 0x3c
    function set_height(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "height", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xc7059626, Offset: 0x9d0
    // Size: 0x3c
    function set_width(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "width", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x7b0ffa32, Offset: 0x988
    // Size: 0x3c
    function set_y(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "y", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x55a02102, Offset: 0x940
    // Size: 0x3c
    function set_x(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "x", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 1, eflags: 0x0
    // Checksum 0x9a555dde, Offset: 0x910
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x843848e6, Offset: 0x8c0
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "LUIelemImage", persistent);
    }

    // Namespace cluielemimage/luielemimage
    // Params 1, eflags: 0x0
    // Checksum 0x8f343b3a, Offset: 0x700
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
        cluielem::function_52818084("material", "material", 1);
    }

}

// Namespace luielemimage/luielemimage
// Params 4, eflags: 0x0
// Checksum 0x602e7685, Offset: 0xf0
// Size: 0x6c
function set_color(player, red, green, blue) {
    self set_red(player, red);
    self set_green(player, green);
    self set_blue(player, blue);
}

// Namespace luielemimage/luielemimage
// Params 3, eflags: 0x0
// Checksum 0xb5babc2b, Offset: 0x168
// Size: 0x7c
function fade(player, var_b43a1f03, duration = 0) {
    self set_alpha(player, var_b43a1f03);
    self set_fadeovertime(player, int(duration * 10));
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x84209ce1, Offset: 0x1f0
// Size: 0x44
function show(player, duration = 0) {
    self fade(player, 1, duration);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x76fcccfb, Offset: 0x240
// Size: 0x3c
function hide(player, duration = 0) {
    self fade(player, 0, duration);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x76d17a48, Offset: 0x288
// Size: 0x4c
function function_9afa3156(player, var_5c38c80f) {
    self set_x(player, int(var_5c38c80f / 15));
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x2a121ac1, Offset: 0x2e0
// Size: 0x4c
function function_56b41599(player, var_36364da6) {
    self set_y(player, int(var_36364da6 / 15));
}

// Namespace luielemimage/luielemimage
// Params 3, eflags: 0x0
// Checksum 0x3c206041, Offset: 0x338
// Size: 0x4c
function function_ec358cb5(player, var_5c38c80f, var_36364da6) {
    self function_9afa3156(player, var_5c38c80f);
    self function_56b41599(player, var_36364da6);
}

// Namespace luielemimage/luielemimage
// Params 3, eflags: 0x0
// Checksum 0x968b2810, Offset: 0x390
// Size: 0x8c
function function_a6bbb523(player, width, height) {
    self set_width(player, int(width / 4));
    self set_height(player, int(height / 4));
}

// Namespace luielemimage/luielemimage
// Params 1, eflags: 0x0
// Checksum 0x7723da96, Offset: 0x428
// Size: 0x40
function register(uid) {
    elem = new cluielemimage();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xf5eaae6c, Offset: 0x470
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace luielemimage/luielemimage
// Params 1, eflags: 0x0
// Checksum 0x350030e4, Offset: 0x4b0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielemimage/luielemimage
// Params 1, eflags: 0x0
// Checksum 0xefee19ce, Offset: 0x4d8
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x1e48f5e0, Offset: 0x500
// Size: 0x28
function set_x(player, value) {
    [[ self ]]->set_x(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xbb54a55b, Offset: 0x530
// Size: 0x28
function set_y(player, value) {
    [[ self ]]->set_y(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x9eabc93d, Offset: 0x560
// Size: 0x28
function set_width(player, value) {
    [[ self ]]->set_width(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xc4aa3766, Offset: 0x590
// Size: 0x28
function set_height(player, value) {
    [[ self ]]->set_height(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x8026c1f1, Offset: 0x5c0
// Size: 0x28
function set_fadeovertime(player, value) {
    [[ self ]]->set_fadeovertime(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xebea081b, Offset: 0x5f0
// Size: 0x28
function set_alpha(player, value) {
    [[ self ]]->set_alpha(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x4be17489, Offset: 0x620
// Size: 0x28
function set_red(player, value) {
    [[ self ]]->set_red(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x19574509, Offset: 0x650
// Size: 0x28
function set_green(player, value) {
    [[ self ]]->set_green(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x9e4ace32, Offset: 0x680
// Size: 0x28
function set_blue(player, value) {
    [[ self ]]->set_blue(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xf39a30ff, Offset: 0x6b0
// Size: 0x28
function set_material(player, value) {
    [[ self ]]->set_material(player, value);
}

