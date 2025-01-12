#using scripts\core_common\lui_shared;

#namespace doa_textelement;

// Namespace doa_textelement
// Method(s) 19 Total 25
class class_df106b1 : cluielem {

    // Namespace namespace_df106b1/doa_textelement
    // Params 1, eflags: 0x0
    // Checksum 0x62c9fd58, Offset: 0xdc8
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x2ac71bbe, Offset: 0x1060
    // Size: 0x30
    function function_1a98dac6(localclientnum, value) {
        set_data(localclientnum, "textpayload", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x34db9709, Offset: 0xff0
    // Size: 0x30
    function set_horizontal_alignment(localclientnum, value) {
        set_data(localclientnum, "horizontal_alignment", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x106414ba, Offset: 0xf48
    // Size: 0x30
    function set_green(localclientnum, value) {
        set_data(localclientnum, "green", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x36254187, Offset: 0xea0
    // Size: 0x30
    function set_fadeovertime(localclientnum, value) {
        set_data(localclientnum, "fadeOverTime", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 0, eflags: 0x0
    // Checksum 0xa6167728, Offset: 0xbc8
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("DOA_TextElement");
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x34f7ef37, Offset: 0xe68
    // Size: 0x30
    function set_height(localclientnum, value) {
        set_data(localclientnum, "height", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0xecca0789, Offset: 0xf80
    // Size: 0x30
    function set_blue(localclientnum, value) {
        set_data(localclientnum, "blue", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 13, eflags: 0x0
    // Checksum 0x133cd312, Offset: 0x930
    // Size: 0x28c
    function setup_clientfields(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, *textcallback, horizontal_alignmentcallback, var_9194fd72, *var_3d17213, var_766e2bbb) {
        cluielem::setup_clientfields("DOA_TextElement");
        cluielem::add_clientfield("x", 1, 7, "int", heightcallback);
        cluielem::add_clientfield("y", 1, 6, "int", fadeovertimecallback);
        cluielem::add_clientfield("height", 1, 2, "int", alphacallback);
        cluielem::add_clientfield("fadeOverTime", 1, 5, "int", redcallback);
        cluielem::add_clientfield("alpha", 1, 4, "float", greencallback);
        cluielem::add_clientfield("red", 1, 4, "float", bluecallback);
        cluielem::add_clientfield("green", 1, 4, "float", textcallback);
        cluielem::add_clientfield("blue", 1, 4, "float", horizontal_alignmentcallback);
        cluielem::function_dcb34c80("string", "text", 1);
        cluielem::add_clientfield("horizontal_alignment", 1, 2, "int", var_9194fd72);
        cluielem::add_clientfield("intpayload", 1, 32, "int", var_3d17213);
        cluielem::function_dcb34c80("string", "textpayload", 1);
        cluielem::add_clientfield("scale", 1, 5, "float", var_766e2bbb);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x43e39318, Offset: 0xe30
    // Size: 0x30
    function set_y(localclientnum, value) {
        set_data(localclientnum, "y", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x811511b, Offset: 0x1028
    // Size: 0x30
    function function_9e089af4(localclientnum, value) {
        set_data(localclientnum, "intpayload", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0xa347efeb, Offset: 0xed8
    // Size: 0x30
    function set_alpha(localclientnum, value) {
        set_data(localclientnum, "alpha", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x48375540, Offset: 0x1098
    // Size: 0x30
    function set_scale(localclientnum, value) {
        set_data(localclientnum, "scale", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x50320953, Offset: 0xdf8
    // Size: 0x30
    function set_x(localclientnum, value) {
        set_data(localclientnum, "x", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0x523e8526, Offset: 0xfb8
    // Size: 0x30
    function set_text(localclientnum, value) {
        set_data(localclientnum, "text", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 2, eflags: 0x0
    // Checksum 0xd8ed30c8, Offset: 0xf10
    // Size: 0x30
    function set_red(localclientnum, value) {
        set_data(localclientnum, "red", value);
    }

    // Namespace namespace_df106b1/doa_textelement
    // Params 1, eflags: 0x0
    // Checksum 0x1c9a4a03, Offset: 0xbf0
    // Size: 0x1d0
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "x", 0);
        set_data(localclientnum, "y", 0);
        set_data(localclientnum, "height", 0);
        set_data(localclientnum, "fadeOverTime", 0);
        set_data(localclientnum, "alpha", 0);
        set_data(localclientnum, "red", 0);
        set_data(localclientnum, "green", 0);
        set_data(localclientnum, "blue", 0);
        set_data(localclientnum, "text", #"");
        set_data(localclientnum, "horizontal_alignment", 0);
        set_data(localclientnum, "intpayload", 0);
        set_data(localclientnum, "textpayload", #"");
        set_data(localclientnum, "scale", 0);
    }

}

// Namespace doa_textelement/doa_textelement
// Params 4, eflags: 0x0
// Checksum 0x18603f4b, Offset: 0x150
// Size: 0x6c
function set_color(localclientnum, red, green, blue) {
    self set_red(localclientnum, red);
    self set_green(localclientnum, green);
    self set_blue(localclientnum, blue);
}

// Namespace doa_textelement/doa_textelement
// Params 3, eflags: 0x0
// Checksum 0xfd4e3f39, Offset: 0x1c8
// Size: 0x7c
function fade(localclientnum, var_1a92607f, duration = 0) {
    self set_alpha(localclientnum, var_1a92607f);
    self set_fadeovertime(localclientnum, int(duration * 10));
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x12a570a7, Offset: 0x250
// Size: 0x44
function show(localclientnum, duration = 0) {
    self fade(localclientnum, 1, duration);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x82d77f3d, Offset: 0x2a0
// Size: 0x3c
function hide(localclientnum, duration = 0) {
    self fade(localclientnum, 0, duration);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x68408a7a, Offset: 0x2e8
// Size: 0x4c
function function_e5898fd7(localclientnum, var_c6572d9b) {
    self set_x(localclientnum, int(var_c6572d9b / 15));
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xa14849f2, Offset: 0x340
// Size: 0x4c
function function_58a135d3(localclientnum, var_d390c80e) {
    self set_y(localclientnum, int(var_d390c80e / 15));
}

// Namespace doa_textelement/doa_textelement
// Params 3, eflags: 0x0
// Checksum 0x15358d61, Offset: 0x398
// Size: 0x4c
function function_f97e9049(localclientnum, var_c6572d9b, var_d390c80e) {
    self function_e5898fd7(localclientnum, var_c6572d9b);
    self function_58a135d3(localclientnum, var_d390c80e);
}

// Namespace doa_textelement/doa_textelement
// Params 13, eflags: 0x0
// Checksum 0xdf903cad, Offset: 0x3f0
// Size: 0x1ee
function register(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, textcallback, horizontal_alignmentcallback, var_9194fd72, var_3d17213, var_766e2bbb) {
    elem = new class_df106b1();
    [[ elem ]]->setup_clientfields(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, textcallback, horizontal_alignmentcallback, var_9194fd72, var_3d17213, var_766e2bbb);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"doa_textelement"])) {
        level.var_ae746e8f[#"doa_textelement"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"doa_textelement"])) {
        level.var_ae746e8f[#"doa_textelement"] = [];
    } else if (!isarray(level.var_ae746e8f[#"doa_textelement"])) {
        level.var_ae746e8f[#"doa_textelement"] = array(level.var_ae746e8f[#"doa_textelement"]);
    }
    level.var_ae746e8f[#"doa_textelement"][level.var_ae746e8f[#"doa_textelement"].size] = elem;
}

// Namespace doa_textelement/doa_textelement
// Params 0, eflags: 0x0
// Checksum 0xcab9f3bd, Offset: 0x5e8
// Size: 0x34
function register_clientside() {
    elem = new class_df106b1();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace doa_textelement/doa_textelement
// Params 1, eflags: 0x0
// Checksum 0x5bb80b88, Offset: 0x628
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace doa_textelement/doa_textelement
// Params 1, eflags: 0x0
// Checksum 0x350e08e3, Offset: 0x650
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace doa_textelement/doa_textelement
// Params 1, eflags: 0x0
// Checksum 0xccddc4c5, Offset: 0x678
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x5c87b0f, Offset: 0x6a0
// Size: 0x28
function set_x(localclientnum, value) {
    [[ self ]]->set_x(localclientnum, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xcbcefb4e, Offset: 0x6d0
// Size: 0x28
function set_y(localclientnum, value) {
    [[ self ]]->set_y(localclientnum, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x49cf0daa, Offset: 0x700
// Size: 0x28
function set_height(localclientnum, value) {
    [[ self ]]->set_height(localclientnum, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xa3f891af, Offset: 0x730
// Size: 0x28
function set_fadeovertime(localclientnum, value) {
    [[ self ]]->set_fadeovertime(localclientnum, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x44ed4ff, Offset: 0x760
// Size: 0x28
function set_alpha(localclientnum, value) {
    [[ self ]]->set_alpha(localclientnum, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x19082104, Offset: 0x790
// Size: 0x28
function set_red(localclientnum, value) {
    [[ self ]]->set_red(localclientnum, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xaa67f796, Offset: 0x7c0
// Size: 0x28
function set_green(localclientnum, value) {
    [[ self ]]->set_green(localclientnum, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xd51dc3d6, Offset: 0x7f0
// Size: 0x28
function set_blue(localclientnum, value) {
    [[ self ]]->set_blue(localclientnum, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xe1b69c2d, Offset: 0x820
// Size: 0x28
function set_text(localclientnum, value) {
    [[ self ]]->set_text(localclientnum, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x6d3d8ad7, Offset: 0x850
// Size: 0x28
function set_horizontal_alignment(localclientnum, value) {
    [[ self ]]->set_horizontal_alignment(localclientnum, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x9e1edf91, Offset: 0x880
// Size: 0x28
function function_9e089af4(localclientnum, value) {
    [[ self ]]->function_9e089af4(localclientnum, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0xcf97f73d, Offset: 0x8b0
// Size: 0x28
function function_1a98dac6(localclientnum, value) {
    [[ self ]]->function_1a98dac6(localclientnum, value);
}

// Namespace doa_textelement/doa_textelement
// Params 2, eflags: 0x0
// Checksum 0x9459cb85, Offset: 0x8e0
// Size: 0x28
function set_scale(localclientnum, value) {
    [[ self ]]->set_scale(localclientnum, value);
}

