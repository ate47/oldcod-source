#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace doa_bannerelement;

// Namespace doa_bannerelement
// Method(s) 16 Total 23
class class_1bec696c : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xa49ce477, Offset: 0x8c0
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0x4cc5e4f2, Offset: 0xc08
    // Size: 0x44
    function set_horizontal_alignment(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "horizontal_alignment", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0x5ba2d600, Offset: 0xb18
    // Size: 0x44
    function set_green(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "green", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xe7d0125d, Offset: 0xa28
    // Size: 0x44
    function set_fadeovertime(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "fadeOverTime", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 1, eflags: 0x0
    // Checksum 0xfda0afdb, Offset: 0x908
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xa7ee30de, Offset: 0x9d8
    // Size: 0x44
    function set_height(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "height", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xc9a34f7, Offset: 0xb68
    // Size: 0x44
    function set_blue(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "blue", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 0, eflags: 0x0
    // Checksum 0xff7d48db, Offset: 0x6e0
    // Size: 0x1d4
    function setup_clientfields() {
        cluielem::setup_clientfields("DOA_BannerElement");
        cluielem::add_clientfield("x", 1, 7, "int");
        cluielem::add_clientfield("y", 1, 6, "int");
        cluielem::add_clientfield("height", 1, 2, "int");
        cluielem::add_clientfield("fadeOverTime", 1, 5, "int");
        cluielem::add_clientfield("alpha", 1, 4, "float");
        cluielem::add_clientfield("red", 1, 4, "float");
        cluielem::add_clientfield("green", 1, 4, "float");
        cluielem::add_clientfield("blue", 1, 4, "float");
        cluielem::function_dcb34c80("string", "text", 1);
        cluielem::add_clientfield("horizontal_alignment", 1, 2, "int");
        cluielem::add_clientfield("scale", 1, 6, "float");
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xe00001e2, Offset: 0x988
    // Size: 0x44
    function set_y(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "y", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0x3aea2a, Offset: 0xa78
    // Size: 0x44
    function set_alpha(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "alpha", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0x76f628d, Offset: 0xc58
    // Size: 0x44
    function set_scale(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "scale", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xccc685c2, Offset: 0x938
    // Size: 0x44
    function set_x(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "x", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0x7e85ea1b, Offset: 0xbb8
    // Size: 0x44
    function set_text(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "text", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xc5b079f0, Offset: 0xac8
    // Size: 0x44
    function set_red(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "red", value);
    }

}

// Namespace doa_bannerelement/doa_bannerelement
// Params 4, eflags: 0x0
// Checksum 0x4b764145, Offset: 0x140
// Size: 0x6c
function set_color(player, red, green, blue) {
    self set_red(player, red);
    self set_green(player, green);
    self set_blue(player, blue);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 3, eflags: 0x0
// Checksum 0xd50a2d6e, Offset: 0x1b8
// Size: 0x7c
function fade(player, var_1a92607f, duration = 0) {
    self set_alpha(player, var_1a92607f);
    self set_fadeovertime(player, int(duration * 10));
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x1baee8ac, Offset: 0x240
// Size: 0x44
function show(player, duration = 0) {
    self fade(player, 1, duration);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0xe4439740, Offset: 0x290
// Size: 0x3c
function hide(player, duration = 0) {
    self fade(player, 0, duration);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x9b264426, Offset: 0x2d8
// Size: 0x4c
function function_e5898fd7(player, var_c6572d9b) {
    self set_x(player, int(var_c6572d9b / 15));
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x6e6469d9, Offset: 0x330
// Size: 0x4c
function function_58a135d3(player, var_d390c80e) {
    self set_y(player, int(var_d390c80e / 15));
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 3, eflags: 0x0
// Checksum 0x17ef0d7, Offset: 0x388
// Size: 0x4c
function function_f97e9049(player, var_c6572d9b, var_d390c80e) {
    self function_e5898fd7(player, var_c6572d9b);
    self function_58a135d3(player, var_d390c80e);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 0, eflags: 0x0
// Checksum 0x4ae540cb, Offset: 0x3e0
// Size: 0x34
function register() {
    elem = new class_1bec696c();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0xc174e924, Offset: 0x420
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 1, eflags: 0x0
// Checksum 0x9ab251c6, Offset: 0x460
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 1, eflags: 0x0
// Checksum 0x1e664670, Offset: 0x488
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0xc8638a5e, Offset: 0x4b0
// Size: 0x28
function set_x(player, value) {
    [[ self ]]->set_x(player, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x18a6bca5, Offset: 0x4e0
// Size: 0x28
function set_y(player, value) {
    [[ self ]]->set_y(player, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x5bc59df7, Offset: 0x510
// Size: 0x28
function set_height(player, value) {
    [[ self ]]->set_height(player, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0xeab95ca2, Offset: 0x540
// Size: 0x28
function set_fadeovertime(player, value) {
    [[ self ]]->set_fadeovertime(player, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0xee5a5ad, Offset: 0x570
// Size: 0x28
function set_alpha(player, value) {
    [[ self ]]->set_alpha(player, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x8e5d4b30, Offset: 0x5a0
// Size: 0x28
function set_red(player, value) {
    [[ self ]]->set_red(player, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x2d2426b4, Offset: 0x5d0
// Size: 0x28
function set_green(player, value) {
    [[ self ]]->set_green(player, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x57c85235, Offset: 0x600
// Size: 0x28
function set_blue(player, value) {
    [[ self ]]->set_blue(player, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x5c1cd686, Offset: 0x630
// Size: 0x28
function set_text(player, value) {
    [[ self ]]->set_text(player, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x9249e7c0, Offset: 0x660
// Size: 0x28
function set_horizontal_alignment(player, value) {
    [[ self ]]->set_horizontal_alignment(player, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0xe5d0f69b, Offset: 0x690
// Size: 0x28
function set_scale(player, value) {
    [[ self ]]->set_scale(player, value);
}

