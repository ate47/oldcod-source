#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace luielemimage;

// Namespace luielemimage
// Method(s) 15 Total 22
class cluielemimage : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xdb2cdefd, Offset: 0x8d8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xb007ef82, Offset: 0xb80
    // Size: 0x44
    function set_green(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "green", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xf237721, Offset: 0xa90
    // Size: 0x44
    function set_fadeovertime(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "fadeOverTime", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 1, eflags: 0x0
    // Checksum 0xafaf7c23, Offset: 0x920
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x19b20aa, Offset: 0xa40
    // Size: 0x44
    function set_height(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "height", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x8207291, Offset: 0xc20
    // Size: 0x44
    function set_material(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "material", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xc10f3b04, Offset: 0xbd0
    // Size: 0x44
    function set_blue(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "blue", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xc2ecfd9d, Offset: 0x9f0
    // Size: 0x44
    function set_width(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "width", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 0, eflags: 0x0
    // Checksum 0x8a071168, Offset: 0x720
    // Size: 0x1ac
    function setup_clientfields() {
        cluielem::setup_clientfields("LUIelemImage");
        cluielem::add_clientfield("x", 1, 7, "int");
        cluielem::add_clientfield("y", 1, 6, "int");
        cluielem::add_clientfield("width", 1, 6, "int");
        cluielem::add_clientfield("height", 1, 6, "int");
        cluielem::add_clientfield("fadeOverTime", 1, 5, "int");
        cluielem::add_clientfield("alpha", 1, 4, "float");
        cluielem::add_clientfield("red", 1, 4, "float");
        cluielem::add_clientfield("green", 1, 4, "float");
        cluielem::add_clientfield("blue", 1, 4, "float");
        cluielem::function_dcb34c80("material", "material", 1);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x19b3729f, Offset: 0x9a0
    // Size: 0x44
    function set_y(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "y", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x43b24339, Offset: 0xae0
    // Size: 0x44
    function set_alpha(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "alpha", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xec31511, Offset: 0x950
    // Size: 0x44
    function set_x(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "x", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x7cdd6e68, Offset: 0xb30
    // Size: 0x44
    function set_red(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "red", value);
    }

}

// Namespace luielemimage/luielemimage
// Params 4, eflags: 0x0
// Checksum 0x6ae55b8e, Offset: 0x118
// Size: 0x6c
function set_color(player, red, green, blue) {
    self set_red(player, red);
    self set_green(player, green);
    self set_blue(player, blue);
}

// Namespace luielemimage/luielemimage
// Params 3, eflags: 0x0
// Checksum 0x649d5e77, Offset: 0x190
// Size: 0x7c
function fade(player, var_1a92607f, duration = 0) {
    self set_alpha(player, var_1a92607f);
    self set_fadeovertime(player, int(duration * 10));
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x93930e5e, Offset: 0x218
// Size: 0x44
function show(player, duration = 0) {
    self fade(player, 1, duration);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x481ccebc, Offset: 0x268
// Size: 0x3c
function hide(player, duration = 0) {
    self fade(player, 0, duration);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xce6290a0, Offset: 0x2b0
// Size: 0x4c
function function_e5898fd7(player, var_c6572d9b) {
    self set_x(player, int(var_c6572d9b / 15));
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x6c35cab9, Offset: 0x308
// Size: 0x4c
function function_58a135d3(player, var_d390c80e) {
    self set_y(player, int(var_d390c80e / 15));
}

// Namespace luielemimage/luielemimage
// Params 3, eflags: 0x0
// Checksum 0x27086a66, Offset: 0x360
// Size: 0x4c
function function_f97e9049(player, var_c6572d9b, var_d390c80e) {
    self function_e5898fd7(player, var_c6572d9b);
    self function_58a135d3(player, var_d390c80e);
}

// Namespace luielemimage/luielemimage
// Params 3, eflags: 0x0
// Checksum 0xf400dbf1, Offset: 0x3b8
// Size: 0x8c
function function_35f52fe9(player, width, height) {
    self set_width(player, int(width / 4));
    self set_height(player, int(height / 4));
}

// Namespace luielemimage/luielemimage
// Params 0, eflags: 0x0
// Checksum 0xf72aa312, Offset: 0x450
// Size: 0x34
function register() {
    elem = new cluielemimage();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xbafda441, Offset: 0x490
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace luielemimage/luielemimage
// Params 1, eflags: 0x0
// Checksum 0x119061b9, Offset: 0x4d0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielemimage/luielemimage
// Params 1, eflags: 0x0
// Checksum 0x18b2adb, Offset: 0x4f8
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x3df062d, Offset: 0x520
// Size: 0x28
function set_x(player, value) {
    [[ self ]]->set_x(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x1989c256, Offset: 0x550
// Size: 0x28
function set_y(player, value) {
    [[ self ]]->set_y(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x602368a6, Offset: 0x580
// Size: 0x28
function set_width(player, value) {
    [[ self ]]->set_width(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x6c2653e, Offset: 0x5b0
// Size: 0x28
function set_height(player, value) {
    [[ self ]]->set_height(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xa97ff2dc, Offset: 0x5e0
// Size: 0x28
function set_fadeovertime(player, value) {
    [[ self ]]->set_fadeovertime(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x6d9bd2ee, Offset: 0x610
// Size: 0x28
function set_alpha(player, value) {
    [[ self ]]->set_alpha(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x1a75fb0a, Offset: 0x640
// Size: 0x28
function set_red(player, value) {
    [[ self ]]->set_red(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xb6cf9f24, Offset: 0x670
// Size: 0x28
function set_green(player, value) {
    [[ self ]]->set_green(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xbe77f8f5, Offset: 0x6a0
// Size: 0x28
function set_blue(player, value) {
    [[ self ]]->set_blue(player, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x5f092132, Offset: 0x6d0
// Size: 0x28
function set_material(player, value) {
    [[ self ]]->set_material(player, value);
}

