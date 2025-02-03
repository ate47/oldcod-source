#using scripts\core_common\lui_shared;

#namespace luielembar;

// Namespace luielembar
// Method(s) 15 Total 22
class cluielembar : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0xbaef4087, Offset: 0x6d8
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x87f776ec, Offset: 0x9f8
    // Size: 0x6c
    function set_green(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 8, int(value * (16 - 1)), 0);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x26e1d189, Offset: 0x8b0
    // Size: 0x4c
    function set_fadeovertime(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 5, value, 0);
    }

    // Namespace cluielembar/luielembar
    // Params 1, eflags: 0x0
    // Checksum 0x73ba2e34, Offset: 0x720
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x73e47b19, Offset: 0x858
    // Size: 0x4c
    function set_height(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 4, value, 0);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x36381a00, Offset: 0xa70
    // Size: 0x6c
    function set_blue(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 9, int(value * (16 - 1)), 0);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x5d7538aa, Offset: 0x800
    // Size: 0x4c
    function set_width(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 3, value, 0);
    }

    // Namespace cluielembar/luielembar
    // Params 0, eflags: 0x0
    // Checksum 0xfb371185, Offset: 0x6b0
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("LUIelemBar");
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x452f744c, Offset: 0x7a8
    // Size: 0x4c
    function set_y(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 2, value, 0);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x401c05f1, Offset: 0x908
    // Size: 0x6c
    function set_alpha(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 6, int(value * (16 - 1)), 0);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x418197be, Offset: 0x750
    // Size: 0x4c
    function set_x(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 1, value, 0);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0xbff15288, Offset: 0x980
    // Size: 0x6c
    function set_red(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 7, int(value * (16 - 1)), 0);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0xef4ea644, Offset: 0xae8
    // Size: 0x6c
    function set_bar_percent(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 10, int(value * (64 - 1)), 0);
    }

}

// Namespace luielembar/luielembar
// Params 4, eflags: 0x0
// Checksum 0x1cee65a1, Offset: 0xa8
// Size: 0x6c
function set_color(player, red, green, blue) {
    self set_red(player, red);
    self set_green(player, green);
    self set_blue(player, blue);
}

// Namespace luielembar/luielembar
// Params 3, eflags: 0x0
// Checksum 0x30835de2, Offset: 0x120
// Size: 0x7c
function fade(player, var_1a92607f, duration = 0) {
    self set_alpha(player, var_1a92607f);
    self set_fadeovertime(player, int(duration * 10));
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x5abae556, Offset: 0x1a8
// Size: 0x44
function show(player, duration = 0) {
    self fade(player, 1, duration);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x6be0f1ad, Offset: 0x1f8
// Size: 0x3c
function hide(player, duration = 0) {
    self fade(player, 0, duration);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xd5c9be37, Offset: 0x240
// Size: 0x4c
function function_e5898fd7(player, var_c6572d9b) {
    self set_x(player, int(var_c6572d9b / 15));
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x2005c05f, Offset: 0x298
// Size: 0x4c
function function_58a135d3(player, var_d390c80e) {
    self set_y(player, int(var_d390c80e / 15));
}

// Namespace luielembar/luielembar
// Params 3, eflags: 0x0
// Checksum 0x84f174e1, Offset: 0x2f0
// Size: 0x4c
function function_f97e9049(player, var_c6572d9b, var_d390c80e) {
    self function_e5898fd7(player, var_c6572d9b);
    self function_58a135d3(player, var_d390c80e);
}

// Namespace luielembar/luielembar
// Params 3, eflags: 0x0
// Checksum 0xbeeb2b53, Offset: 0x348
// Size: 0x8c
function function_35f52fe9(player, width, height) {
    self set_width(player, int(width / 4));
    self set_height(player, int(height / 4));
}

// Namespace luielembar/luielembar
// Params 0, eflags: 0x0
// Checksum 0xe70e3f0, Offset: 0x3e0
// Size: 0x34
function register() {
    elem = new cluielembar();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xa351bee7, Offset: 0x420
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace luielembar/luielembar
// Params 1, eflags: 0x0
// Checksum 0xae9b68da, Offset: 0x460
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielembar/luielembar
// Params 1, eflags: 0x0
// Checksum 0x58eea6a7, Offset: 0x488
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x2eb15b25, Offset: 0x4b0
// Size: 0x28
function set_x(player, value) {
    [[ self ]]->set_x(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x27ef6f3a, Offset: 0x4e0
// Size: 0x28
function set_y(player, value) {
    [[ self ]]->set_y(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xf117287, Offset: 0x510
// Size: 0x28
function set_width(player, value) {
    [[ self ]]->set_width(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xd48b02f4, Offset: 0x540
// Size: 0x28
function set_height(player, value) {
    [[ self ]]->set_height(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xd5d4fc97, Offset: 0x570
// Size: 0x28
function set_fadeovertime(player, value) {
    [[ self ]]->set_fadeovertime(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x2e27b3e5, Offset: 0x5a0
// Size: 0x28
function set_alpha(player, value) {
    [[ self ]]->set_alpha(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x84b3dc9c, Offset: 0x5d0
// Size: 0x28
function set_red(player, value) {
    [[ self ]]->set_red(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x17959333, Offset: 0x600
// Size: 0x28
function set_green(player, value) {
    [[ self ]]->set_green(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x3b0d79bb, Offset: 0x630
// Size: 0x28
function set_blue(player, value) {
    [[ self ]]->set_blue(player, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xfae83cf3, Offset: 0x660
// Size: 0x28
function set_bar_percent(player, value) {
    [[ self ]]->set_bar_percent(player, value);
}

