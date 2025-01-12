#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace luielemtext;

// Namespace luielemtext
// Method(s) 15 Total 22
class cluielemtext : cluielem {

    var var_57a3d576;

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x67119980, Offset: 0xb40
    // Size: 0x3c
    function set_horizontal_alignment(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "horizontal_alignment", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0xec047f64, Offset: 0xaf8
    // Size: 0x3c
    function set_text(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "text", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x1741ae46, Offset: 0xab0
    // Size: 0x3c
    function set_blue(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "blue", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x8415a759, Offset: 0xa68
    // Size: 0x3c
    function set_green(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "green", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x885b1bae, Offset: 0xa20
    // Size: 0x3c
    function set_red(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "red", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x34c89239, Offset: 0x9d8
    // Size: 0x3c
    function set_alpha(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "alpha", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0xee40e39b, Offset: 0x990
    // Size: 0x3c
    function set_fadeovertime(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "fadeOverTime", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x173d347f, Offset: 0x948
    // Size: 0x3c
    function set_height(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "height", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x82250c7a, Offset: 0x900
    // Size: 0x3c
    function set_y(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "y", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0xc55089a6, Offset: 0x8b8
    // Size: 0x3c
    function set_x(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "x", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 1, eflags: 0x0
    // Checksum 0x3515f23e, Offset: 0x888
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x17449b69, Offset: 0x838
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "LUIelemText", persistent);
    }

    // Namespace cluielemtext/luielemtext
    // Params 1, eflags: 0x0
    // Checksum 0xeee8c9b1, Offset: 0x678
    // Size: 0x1b4
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("x", 1, 7, "int");
        cluielem::add_clientfield("y", 1, 6, "int");
        cluielem::add_clientfield("height", 1, 2, "int");
        cluielem::add_clientfield("fadeOverTime", 1, 5, "int");
        cluielem::add_clientfield("alpha", 1, 4, "float");
        cluielem::add_clientfield("red", 1, 4, "float");
        cluielem::add_clientfield("green", 1, 4, "float");
        cluielem::add_clientfield("blue", 1, 4, "float");
        cluielem::function_52818084("string", "text", 1);
        cluielem::add_clientfield("horizontal_alignment", 1, 2, "int");
    }

}

// Namespace luielemtext/luielemtext
// Params 4, eflags: 0x0
// Checksum 0x4ace63c4, Offset: 0x100
// Size: 0x6c
function set_color(player, red, green, blue) {
    self set_red(player, red);
    self set_green(player, green);
    self set_blue(player, blue);
}

// Namespace luielemtext/luielemtext
// Params 3, eflags: 0x0
// Checksum 0xa6700810, Offset: 0x178
// Size: 0x7c
function fade(player, var_b43a1f03, duration = 0) {
    self set_alpha(player, var_b43a1f03);
    self set_fadeovertime(player, int(duration * 10));
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x8298868f, Offset: 0x200
// Size: 0x44
function show(player, duration = 0) {
    self fade(player, 1, duration);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xc8277120, Offset: 0x250
// Size: 0x3c
function hide(player, duration = 0) {
    self fade(player, 0, duration);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xae5fe1be, Offset: 0x298
// Size: 0x4c
function function_9afa3156(player, var_5c38c80f) {
    self set_x(player, int(var_5c38c80f / 15));
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xa0d70665, Offset: 0x2f0
// Size: 0x4c
function function_56b41599(player, var_36364da6) {
    self set_y(player, int(var_36364da6 / 15));
}

// Namespace luielemtext/luielemtext
// Params 3, eflags: 0x0
// Checksum 0xa9928d7d, Offset: 0x348
// Size: 0x4c
function function_ec358cb5(player, var_5c38c80f, var_36364da6) {
    self function_9afa3156(player, var_5c38c80f);
    self function_56b41599(player, var_36364da6);
}

// Namespace luielemtext/luielemtext
// Params 1, eflags: 0x0
// Checksum 0xea36a4d8, Offset: 0x3a0
// Size: 0x40
function register(uid) {
    elem = new cluielemtext();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xe31ce424, Offset: 0x3e8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace luielemtext/luielemtext
// Params 1, eflags: 0x0
// Checksum 0x52e3e555, Offset: 0x428
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielemtext/luielemtext
// Params 1, eflags: 0x0
// Checksum 0x187c019c, Offset: 0x450
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x8f0588c5, Offset: 0x478
// Size: 0x28
function set_x(player, value) {
    [[ self ]]->set_x(player, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xa757782c, Offset: 0x4a8
// Size: 0x28
function set_y(player, value) {
    [[ self ]]->set_y(player, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x31440582, Offset: 0x4d8
// Size: 0x28
function set_height(player, value) {
    [[ self ]]->set_height(player, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xc2b7b2c6, Offset: 0x508
// Size: 0x28
function set_fadeovertime(player, value) {
    [[ self ]]->set_fadeovertime(player, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x11e0c8d3, Offset: 0x538
// Size: 0x28
function set_alpha(player, value) {
    [[ self ]]->set_alpha(player, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x4fb73593, Offset: 0x568
// Size: 0x28
function set_red(player, value) {
    [[ self ]]->set_red(player, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x4826a04b, Offset: 0x598
// Size: 0x28
function set_green(player, value) {
    [[ self ]]->set_green(player, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xc61c640f, Offset: 0x5c8
// Size: 0x28
function set_blue(player, value) {
    [[ self ]]->set_blue(player, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x792a7bcc, Offset: 0x5f8
// Size: 0x28
function set_text(player, value) {
    [[ self ]]->set_text(player, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xd5bf63b1, Offset: 0x628
// Size: 0x28
function set_horizontal_alignment(player, value) {
    [[ self ]]->set_horizontal_alignment(player, value);
}

