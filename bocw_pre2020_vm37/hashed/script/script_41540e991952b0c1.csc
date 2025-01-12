#using scripts\core_common\lui_shared;

#namespace doa_bannerelement;

// Namespace doa_bannerelement
// Method(s) 17 Total 23
class class_1bec696c : cluielem {

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 1, eflags: 0x0
    // Checksum 0xdfc724d0, Offset: 0xca0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0x47e8ec85, Offset: 0xec8
    // Size: 0x30
    function set_horizontal_alignment(localclientnum, value) {
        set_data(localclientnum, "horizontal_alignment", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xaf32f9ca, Offset: 0xe20
    // Size: 0x30
    function set_green(localclientnum, value) {
        set_data(localclientnum, "green", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xc0f18449, Offset: 0xd78
    // Size: 0x30
    function set_fadeovertime(localclientnum, value) {
        set_data(localclientnum, "fadeOverTime", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 0, eflags: 0x0
    // Checksum 0x80bfac44, Offset: 0xae0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("DOA_BannerElement");
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xd2064ae7, Offset: 0xd40
    // Size: 0x30
    function set_height(localclientnum, value) {
        set_data(localclientnum, "height", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xc526fe7b, Offset: 0xe58
    // Size: 0x30
    function set_blue(localclientnum, value) {
        set_data(localclientnum, "blue", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 11, eflags: 0x0
    // Checksum 0x61a893ac, Offset: 0x8a8
    // Size: 0x22c
    function setup_clientfields(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, *textcallback, horizontal_alignmentcallback, var_766e2bbb) {
        cluielem::setup_clientfields("DOA_BannerElement");
        cluielem::add_clientfield("x", 1, 7, "int", ycallback);
        cluielem::add_clientfield("y", 1, 6, "int", heightcallback);
        cluielem::add_clientfield("height", 1, 2, "int", fadeovertimecallback);
        cluielem::add_clientfield("fadeOverTime", 1, 5, "int", alphacallback);
        cluielem::add_clientfield("alpha", 1, 4, "float", redcallback);
        cluielem::add_clientfield("red", 1, 4, "float", greencallback);
        cluielem::add_clientfield("green", 1, 4, "float", bluecallback);
        cluielem::add_clientfield("blue", 1, 4, "float", textcallback);
        cluielem::function_dcb34c80("string", "text", 1);
        cluielem::add_clientfield("horizontal_alignment", 1, 2, "int", horizontal_alignmentcallback);
        cluielem::add_clientfield("scale", 1, 6, "float", var_766e2bbb);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0x5e90c7a8, Offset: 0xd08
    // Size: 0x30
    function set_y(localclientnum, value) {
        set_data(localclientnum, "y", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0x66307d3d, Offset: 0xdb0
    // Size: 0x30
    function set_alpha(localclientnum, value) {
        set_data(localclientnum, "alpha", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xe5b3c51c, Offset: 0xf00
    // Size: 0x30
    function set_scale(localclientnum, value) {
        set_data(localclientnum, "scale", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0x91168c0a, Offset: 0xcd0
    // Size: 0x30
    function set_x(localclientnum, value) {
        set_data(localclientnum, "x", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xc21ad9e9, Offset: 0xe90
    // Size: 0x30
    function set_text(localclientnum, value) {
        set_data(localclientnum, "text", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 2, eflags: 0x0
    // Checksum 0xa8b3b348, Offset: 0xde8
    // Size: 0x30
    function set_red(localclientnum, value) {
        set_data(localclientnum, "red", value);
    }

    // Namespace namespace_1bec696c/doa_bannerelement
    // Params 1, eflags: 0x0
    // Checksum 0xa172d6b3, Offset: 0xb08
    // Size: 0x18c
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
        set_data(localclientnum, "scale", 0);
    }

}

// Namespace doa_bannerelement/doa_bannerelement
// Params 4, eflags: 0x0
// Checksum 0xdbf8a883, Offset: 0x138
// Size: 0x6c
function set_color(localclientnum, red, green, blue) {
    self set_red(localclientnum, red);
    self set_green(localclientnum, green);
    self set_blue(localclientnum, blue);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 3, eflags: 0x0
// Checksum 0xd256c41c, Offset: 0x1b0
// Size: 0x7c
function fade(localclientnum, var_1a92607f, duration = 0) {
    self set_alpha(localclientnum, var_1a92607f);
    self set_fadeovertime(localclientnum, int(duration * 10));
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x1d11a24b, Offset: 0x238
// Size: 0x44
function show(localclientnum, duration = 0) {
    self fade(localclientnum, 1, duration);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0xc7ffa94e, Offset: 0x288
// Size: 0x3c
function hide(localclientnum, duration = 0) {
    self fade(localclientnum, 0, duration);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x96941669, Offset: 0x2d0
// Size: 0x4c
function function_e5898fd7(localclientnum, var_c6572d9b) {
    self set_x(localclientnum, int(var_c6572d9b / 15));
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x63d63b96, Offset: 0x328
// Size: 0x4c
function function_58a135d3(localclientnum, var_d390c80e) {
    self set_y(localclientnum, int(var_d390c80e / 15));
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 3, eflags: 0x0
// Checksum 0xccca298, Offset: 0x380
// Size: 0x4c
function function_f97e9049(localclientnum, var_c6572d9b, var_d390c80e) {
    self function_e5898fd7(localclientnum, var_c6572d9b);
    self function_58a135d3(localclientnum, var_d390c80e);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 11, eflags: 0x0
// Checksum 0xb1cd2e23, Offset: 0x3d8
// Size: 0x1de
function register(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, textcallback, horizontal_alignmentcallback, var_766e2bbb) {
    elem = new class_1bec696c();
    [[ elem ]]->setup_clientfields(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, textcallback, horizontal_alignmentcallback, var_766e2bbb);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"doa_bannerelement"])) {
        level.var_ae746e8f[#"doa_bannerelement"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"doa_bannerelement"])) {
        level.var_ae746e8f[#"doa_bannerelement"] = [];
    } else if (!isarray(level.var_ae746e8f[#"doa_bannerelement"])) {
        level.var_ae746e8f[#"doa_bannerelement"] = array(level.var_ae746e8f[#"doa_bannerelement"]);
    }
    level.var_ae746e8f[#"doa_bannerelement"][level.var_ae746e8f[#"doa_bannerelement"].size] = elem;
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 0, eflags: 0x0
// Checksum 0xcb58b182, Offset: 0x5c0
// Size: 0x34
function register_clientside() {
    elem = new class_1bec696c();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 1, eflags: 0x0
// Checksum 0xaf2e5f71, Offset: 0x600
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 1, eflags: 0x0
// Checksum 0xbac4817c, Offset: 0x628
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 1, eflags: 0x0
// Checksum 0x85d556b1, Offset: 0x650
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0xa129b8bf, Offset: 0x678
// Size: 0x28
function set_x(localclientnum, value) {
    [[ self ]]->set_x(localclientnum, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x1303ee39, Offset: 0x6a8
// Size: 0x28
function set_y(localclientnum, value) {
    [[ self ]]->set_y(localclientnum, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x5c725fb8, Offset: 0x6d8
// Size: 0x28
function set_height(localclientnum, value) {
    [[ self ]]->set_height(localclientnum, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x2e050342, Offset: 0x708
// Size: 0x28
function set_fadeovertime(localclientnum, value) {
    [[ self ]]->set_fadeovertime(localclientnum, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0xd1b1f16a, Offset: 0x738
// Size: 0x28
function set_alpha(localclientnum, value) {
    [[ self ]]->set_alpha(localclientnum, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x6089bdc, Offset: 0x768
// Size: 0x28
function set_red(localclientnum, value) {
    [[ self ]]->set_red(localclientnum, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0xb74ef14a, Offset: 0x798
// Size: 0x28
function set_green(localclientnum, value) {
    [[ self ]]->set_green(localclientnum, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0xfd8507d6, Offset: 0x7c8
// Size: 0x28
function set_blue(localclientnum, value) {
    [[ self ]]->set_blue(localclientnum, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0xc9b3158e, Offset: 0x7f8
// Size: 0x28
function set_text(localclientnum, value) {
    [[ self ]]->set_text(localclientnum, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0xd4a5c817, Offset: 0x828
// Size: 0x28
function set_horizontal_alignment(localclientnum, value) {
    [[ self ]]->set_horizontal_alignment(localclientnum, value);
}

// Namespace doa_bannerelement/doa_bannerelement
// Params 2, eflags: 0x0
// Checksum 0x631cbf45, Offset: 0x858
// Size: 0x28
function set_scale(localclientnum, value) {
    [[ self ]]->set_scale(localclientnum, value);
}

