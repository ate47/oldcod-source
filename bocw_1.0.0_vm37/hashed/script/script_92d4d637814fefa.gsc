#using scripts\core_common\lui_shared;

#namespace luielemcounter;

// Namespace luielemcounter
// Method(s) 15 Total 22
class class_1beae0 : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0xe9a901e8, Offset: 0x3a0
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0x9afb098d, Offset: 0x7b0
    // Size: 0x4c
    function set_horizontal_alignment(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 10, value, 0);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0xf2c20403, Offset: 0x668
    // Size: 0x6c
    function set_green(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 7, int(value * (16 - 1)), 0);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0x65c72a2e, Offset: 0x520
    // Size: 0x4c
    function set_fadeovertime(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 4, value, 0);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 1, eflags: 0x0
    // Checksum 0xb2ea3ed6, Offset: 0x3e8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0xd5c7f0fb, Offset: 0x758
    // Size: 0x4c
    function function_5d4dff63(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 9, value, 0);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0x3f367656, Offset: 0x4c8
    // Size: 0x4c
    function set_height(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 3, value, 0);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0x24cb9c22, Offset: 0x6e0
    // Size: 0x6c
    function set_blue(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 8, int(value * (16 - 1)), 0);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 0, eflags: 0x0
    // Checksum 0x6f465ac, Offset: 0x378
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("LUIelemCounter");
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0xa76e5ab2, Offset: 0x470
    // Size: 0x4c
    function set_y(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 2, value, 0);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0xc6ed670d, Offset: 0x578
    // Size: 0x6c
    function set_alpha(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 5, int(value * (16 - 1)), 0);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0x55a04665, Offset: 0x418
    // Size: 0x4c
    function set_x(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 1, value, 0);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0x8bab590d, Offset: 0x5f0
    // Size: 0x6c
    function set_red(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 6, int(value * (16 - 1)), 0);
    }

}

// Namespace luielemcounter/luielemcounter
// Params 0, eflags: 0x0
// Checksum 0x9ba79f49, Offset: 0xa8
// Size: 0x34
function register() {
    elem = new class_1beae0();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0x672bc8a8, Offset: 0xe8
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace luielemcounter/luielemcounter
// Params 1, eflags: 0x0
// Checksum 0x2194ec3f, Offset: 0x128
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielemcounter/luielemcounter
// Params 1, eflags: 0x0
// Checksum 0x37b19c38, Offset: 0x150
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0x4114e258, Offset: 0x178
// Size: 0x28
function set_x(player, value) {
    [[ self ]]->set_x(player, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0x33e41898, Offset: 0x1a8
// Size: 0x28
function set_y(player, value) {
    [[ self ]]->set_y(player, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0x7e141dd7, Offset: 0x1d8
// Size: 0x28
function set_height(player, value) {
    [[ self ]]->set_height(player, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0x4a78f36e, Offset: 0x208
// Size: 0x28
function set_fadeovertime(player, value) {
    [[ self ]]->set_fadeovertime(player, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0x38005ca0, Offset: 0x238
// Size: 0x28
function set_alpha(player, value) {
    [[ self ]]->set_alpha(player, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0xfcd889f8, Offset: 0x268
// Size: 0x28
function set_red(player, value) {
    [[ self ]]->set_red(player, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0x782a06a7, Offset: 0x298
// Size: 0x28
function set_green(player, value) {
    [[ self ]]->set_green(player, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0xb6f565de, Offset: 0x2c8
// Size: 0x28
function set_blue(player, value) {
    [[ self ]]->set_blue(player, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0x716b47a, Offset: 0x2f8
// Size: 0x28
function function_5d4dff63(player, value) {
    [[ self ]]->function_5d4dff63(player, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0x35a985a4, Offset: 0x328
// Size: 0x28
function set_horizontal_alignment(player, value) {
    [[ self ]]->set_horizontal_alignment(player, value);
}

