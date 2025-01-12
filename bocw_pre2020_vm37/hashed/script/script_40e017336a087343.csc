#using scripts\core_common\lui_shared;

#namespace luielemtext;

// Namespace luielemtext
// Method(s) 16 Total 22
class cluielemtext : cluielem {

    // Namespace cluielemtext/luielemtext
    // Params 1, eflags: 0x0
    // Checksum 0x7c363626, Offset: 0x958
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x810bdd4d, Offset: 0xb80
    // Size: 0x30
    function set_horizontal_alignment(localclientnum, value) {
        set_data(localclientnum, "horizontal_alignment", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x3fa09c27, Offset: 0xad8
    // Size: 0x30
    function set_green(localclientnum, value) {
        set_data(localclientnum, "green", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x6132e72f, Offset: 0xa30
    // Size: 0x30
    function set_fadeovertime(localclientnum, value) {
        set_data(localclientnum, "fadeOverTime", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 0, eflags: 0x0
    // Checksum 0x310dc719, Offset: 0x7c0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("LUIelemText");
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0xddf5cf66, Offset: 0x9f8
    // Size: 0x30
    function set_height(localclientnum, value) {
        set_data(localclientnum, "height", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x696c5c60, Offset: 0xb10
    // Size: 0x30
    function set_blue(localclientnum, value) {
        set_data(localclientnum, "blue", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 10, eflags: 0x0
    // Checksum 0xc3c65892, Offset: 0x5b8
    // Size: 0x1fc
    function setup_clientfields(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, *textcallback, horizontal_alignmentcallback) {
        cluielem::setup_clientfields("LUIelemText");
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
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x29e33b6d, Offset: 0x9c0
    // Size: 0x30
    function set_y(localclientnum, value) {
        set_data(localclientnum, "y", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0xb78fef88, Offset: 0xa68
    // Size: 0x30
    function set_alpha(localclientnum, value) {
        set_data(localclientnum, "alpha", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x78ebd130, Offset: 0x988
    // Size: 0x30
    function set_x(localclientnum, value) {
        set_data(localclientnum, "x", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x41f7310c, Offset: 0xb48
    // Size: 0x30
    function set_text(localclientnum, value) {
        set_data(localclientnum, "text", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x4e01e91e, Offset: 0xaa0
    // Size: 0x30
    function set_red(localclientnum, value) {
        set_data(localclientnum, "red", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 1, eflags: 0x0
    // Checksum 0x53ec18ac, Offset: 0x7e8
    // Size: 0x168
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
    }

}

// Namespace luielemtext/luielemtext
// Params 10, eflags: 0x0
// Checksum 0xd7c49a6e, Offset: 0x128
// Size: 0x1ce
function register(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, textcallback, horizontal_alignmentcallback) {
    elem = new cluielemtext();
    [[ elem ]]->setup_clientfields(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, textcallback, horizontal_alignmentcallback);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"luielemtext"])) {
        level.var_ae746e8f[#"luielemtext"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"luielemtext"])) {
        level.var_ae746e8f[#"luielemtext"] = [];
    } else if (!isarray(level.var_ae746e8f[#"luielemtext"])) {
        level.var_ae746e8f[#"luielemtext"] = array(level.var_ae746e8f[#"luielemtext"]);
    }
    level.var_ae746e8f[#"luielemtext"][level.var_ae746e8f[#"luielemtext"].size] = elem;
}

// Namespace luielemtext/luielemtext
// Params 0, eflags: 0x0
// Checksum 0xdd775c4, Offset: 0x300
// Size: 0x34
function register_clientside() {
    elem = new cluielemtext();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace luielemtext/luielemtext
// Params 1, eflags: 0x0
// Checksum 0x3c2b7f6f, Offset: 0x340
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace luielemtext/luielemtext
// Params 1, eflags: 0x0
// Checksum 0xf38765eb, Offset: 0x368
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielemtext/luielemtext
// Params 1, eflags: 0x0
// Checksum 0xce7660e0, Offset: 0x390
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x6b7be439, Offset: 0x3b8
// Size: 0x28
function set_x(localclientnum, value) {
    [[ self ]]->set_x(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x84a78c9d, Offset: 0x3e8
// Size: 0x28
function set_y(localclientnum, value) {
    [[ self ]]->set_y(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xc75d915f, Offset: 0x418
// Size: 0x28
function set_height(localclientnum, value) {
    [[ self ]]->set_height(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x74efc1d8, Offset: 0x448
// Size: 0x28
function set_fadeovertime(localclientnum, value) {
    [[ self ]]->set_fadeovertime(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xe8fbe57, Offset: 0x478
// Size: 0x28
function set_alpha(localclientnum, value) {
    [[ self ]]->set_alpha(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xb4afe155, Offset: 0x4a8
// Size: 0x28
function set_red(localclientnum, value) {
    [[ self ]]->set_red(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xf51c61ad, Offset: 0x4d8
// Size: 0x28
function set_green(localclientnum, value) {
    [[ self ]]->set_green(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xc7fc43b9, Offset: 0x508
// Size: 0x28
function set_blue(localclientnum, value) {
    [[ self ]]->set_blue(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xa82bc681, Offset: 0x538
// Size: 0x28
function set_text(localclientnum, value) {
    [[ self ]]->set_text(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xf7c014cf, Offset: 0x568
// Size: 0x28
function set_horizontal_alignment(localclientnum, value) {
    [[ self ]]->set_horizontal_alignment(localclientnum, value);
}

