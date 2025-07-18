#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace doa_textelement;

// Namespace doa_textelement
// Method(s) 18 Total 25
class class_df106b1 : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x5e2cc196, Offset: 0x988
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0xddf11793, Offset: 0xd70
    // Size: 0x44
    function function_1a98dac6(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "textpayload", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0xafec2b2a, Offset: 0xcd0
    // Size: 0x44
    function set_horizontal_alignment(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "horizontal_alignment", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x1256d854, Offset: 0xbe0
    // Size: 0x44
    function set_green(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "green", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x6de45331, Offset: 0xaf0
    // Size: 0x44
    function set_fadeovertime(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "fadeOverTime", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 1, eflags: 0x0
    // Checksum 0xcbf89199, Offset: 0x9d0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x1f319f5e, Offset: 0xaa0
    // Size: 0x44
    function set_height(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "height", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x6a4dde4c, Offset: 0xc30
    // Size: 0x44
    function set_blue(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "blue", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 0, eflags: 0x0
    // Checksum 0x5aba4d33, Offset: 0x758
    // Size: 0x224
    function setup_clientfields() {
        cluielem::setup_clientfields("DOA_TextElement");
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
        cluielem::add_clientfield("intpayload", 1, 32, "int");
        cluielem::function_dcb34c80("string", "textpayload", 1);
        cluielem::add_clientfield("scale", 1, 5, "float");
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0xa16358d4, Offset: 0xa50
    // Size: 0x44
    function set_y(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "y", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x63ca141, Offset: 0xd20
    // Size: 0x44
    function function_9e089af4(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "intpayload", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0xfd2bf5fe, Offset: 0xb40
    // Size: 0x44
    function set_alpha(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "alpha", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x770d4528, Offset: 0xdc0
    // Size: 0x44
    function set_scale(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "scale", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0xd1311773, Offset: 0xa00
    // Size: 0x44
    function set_x(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "x", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0xb75bc666, Offset: 0xc80
    // Size: 0x44
    function set_text(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "text", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0xb3f05b23, Offset: 0xb90
    // Size: 0x44
    function set_red(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "red", value);
    }

}

// Namespace doa_textelement/doa_textelement
// Params 4, eflags: 0x0
// Checksum 0xe02a3778, Offset: 0x158
// Size: 0x6c
function set_color(player, red, green, blue) {
    self set_red(player, red);
    self set_green(player, green);
    self set_blue(player, blue);
}

// Namespace doa_textelement/doa_textelement
// Params 3, eflags: 0x0
// Checksum 0xe5f2c75f, Offset: 0x1d0
// Size: 0x7c
function fade(player, var_1a92607f, duration = 0) {
    self set_alpha(player, var_1a92607f);
    self set_fadeovertime(player, int(duration * 10));
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xd516cdc1, Offset: 0x258
// Size: 0x44
function show(player, duration = 0) {
    self fade(player, 1, duration);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xa8851f40, Offset: 0x2a8
// Size: 0x3c
function hide(player, duration = 0) {
    self fade(player, 0, duration);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x2f5e72b8, Offset: 0x2f0
// Size: 0x4c
function function_e5898fd7(player, var_c6572d9b) {
    self set_x(player, int(var_c6572d9b / 15));
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x31297c75, Offset: 0x348
// Size: 0x4c
function function_58a135d3(player, var_d390c80e) {
    self set_y(player, int(var_d390c80e / 15));
}

// Namespace doa_textelement/doa_textelement
// Params 3, eflags: 0x0
// Checksum 0xf8e5d476, Offset: 0x3a0
// Size: 0x4c
function function_f97e9049(player, var_c6572d9b, var_d390c80e) {
    self function_e5898fd7(player, var_c6572d9b);
    self function_58a135d3(player, var_d390c80e);
}

// Namespace doa_textelement/doa_textelement
// Params 0, eflags: 0x0
// Checksum 0xd8fe823e, Offset: 0x3f8
// Size: 0x34
function register() {
    elem = new class_df106b1();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xe5a80b5, Offset: 0x438
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace doa_textelement/doa_textelement
// Params 1, eflags: 0x0
// Checksum 0xbeca4642, Offset: 0x478
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace doa_textelement/doa_textelement
// Params 1, eflags: 0x0
// Checksum 0x8a6247e5, Offset: 0x4a0
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xe27883b2, Offset: 0x4c8
// Size: 0x28
function set_x(player, value) {
    [[ self ]]->set_x(player, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xca4d9a5e, Offset: 0x4f8
// Size: 0x28
function set_y(player, value) {
    [[ self ]]->set_y(player, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x995dda86, Offset: 0x528
// Size: 0x28
function set_height(player, value) {
    [[ self ]]->set_height(player, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x7d40743d, Offset: 0x558
// Size: 0x28
function set_fadeovertime(player, value) {
    [[ self ]]->set_fadeovertime(player, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xa6d592a4, Offset: 0x588
// Size: 0x28
function set_alpha(player, value) {
    [[ self ]]->set_alpha(player, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x18664f02, Offset: 0x5b8
// Size: 0x28
function set_red(player, value) {
    [[ self ]]->set_red(player, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x15fc3454, Offset: 0x5e8
// Size: 0x28
function set_green(player, value) {
    [[ self ]]->set_green(player, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xf41511ef, Offset: 0x618
// Size: 0x28
function set_blue(player, value) {
    [[ self ]]->set_blue(player, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x65500997, Offset: 0x648
// Size: 0x28
function set_text(player, value) {
    [[ self ]]->set_text(player, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x29aa56bb, Offset: 0x678
// Size: 0x28
function set_horizontal_alignment(player, value) {
    [[ self ]]->set_horizontal_alignment(player, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x1c414db9, Offset: 0x6a8
// Size: 0x28
function function_9e089af4(player, value) {
    [[ self ]]->function_9e089af4(player, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xa236444d, Offset: 0x6d8
// Size: 0x28
function function_1a98dac6(player, value) {
    [[ self ]]->function_1a98dac6(player, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x33c9088b, Offset: 0x708
// Size: 0x28
function set_scale(player, value) {
    [[ self ]]->set_scale(player, value);
}

