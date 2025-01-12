#using scripts\core_common\lui_shared;

#namespace luielemtext;

// Namespace luielemtext
// Method(s) 16 Total 22
class cluielemtext : cluielem {

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0xa8ee3a49, Offset: 0xa50
    // Size: 0x30
    function set_horizontal_alignment(localclientnum, value) {
        set_data(localclientnum, "horizontal_alignment", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0xb7ce2a98, Offset: 0xa18
    // Size: 0x30
    function set_text(localclientnum, value) {
        set_data(localclientnum, "text", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x11368dfa, Offset: 0x9e0
    // Size: 0x30
    function set_blue(localclientnum, value) {
        set_data(localclientnum, "blue", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x924ff542, Offset: 0x9a8
    // Size: 0x30
    function set_green(localclientnum, value) {
        set_data(localclientnum, "green", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x2bf7a698, Offset: 0x970
    // Size: 0x30
    function set_red(localclientnum, value) {
        set_data(localclientnum, "red", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x6a7df9e4, Offset: 0x938
    // Size: 0x30
    function set_alpha(localclientnum, value) {
        set_data(localclientnum, "alpha", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x72f419c4, Offset: 0x900
    // Size: 0x30
    function set_fadeovertime(localclientnum, value) {
        set_data(localclientnum, "fadeOverTime", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0x3670593b, Offset: 0x8c8
    // Size: 0x30
    function set_height(localclientnum, value) {
        set_data(localclientnum, "height", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0xed0e012, Offset: 0x890
    // Size: 0x30
    function set_y(localclientnum, value) {
        set_data(localclientnum, "y", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 2, eflags: 0x0
    // Checksum 0xb9dd2cf8, Offset: 0x858
    // Size: 0x30
    function set_x(localclientnum, value) {
        set_data(localclientnum, "x", value);
    }

    // Namespace cluielemtext/luielemtext
    // Params 1, eflags: 0x0
    // Checksum 0x9d01a5f6, Offset: 0x820
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"luielemtext");
    }

    // Namespace cluielemtext/luielemtext
    // Params 1, eflags: 0x0
    // Checksum 0x3b4a0402, Offset: 0x6b0
    // Size: 0x168
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
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

    // Namespace cluielemtext/luielemtext
    // Params 1, eflags: 0x0
    // Checksum 0xd027ba3d, Offset: 0x680
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cluielemtext/luielemtext
    // Params 11, eflags: 0x0
    // Checksum 0xcdc08611, Offset: 0x470
    // Size: 0x204
    function setup_clientfields(uid, xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, textcallback, horizontal_alignmentcallback) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("x", 1, 7, "int", xcallback);
        cluielem::add_clientfield("y", 1, 6, "int", ycallback);
        cluielem::add_clientfield("height", 1, 2, "int", heightcallback);
        cluielem::add_clientfield("fadeOverTime", 1, 5, "int", fadeovertimecallback);
        cluielem::add_clientfield("alpha", 1, 4, "float", alphacallback);
        cluielem::add_clientfield("red", 1, 4, "float", redcallback);
        cluielem::add_clientfield("green", 1, 4, "float", greencallback);
        cluielem::add_clientfield("blue", 1, 4, "float", bluecallback);
        cluielem::function_52818084("string", "text", 1);
        cluielem::add_clientfield("horizontal_alignment", 1, 2, "int", horizontal_alignmentcallback);
    }

}

// Namespace luielemtext/luielemtext
// Params 11, eflags: 0x0
// Checksum 0x81cd55d3, Offset: 0xf0
// Size: 0xb8
function register(uid, xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, textcallback, horizontal_alignmentcallback) {
    elem = new cluielemtext();
    [[ elem ]]->setup_clientfields(uid, xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, textcallback, horizontal_alignmentcallback);
    return elem;
}

// Namespace luielemtext/luielemtext
// Params 1, eflags: 0x0
// Checksum 0x31872187, Offset: 0x1b0
// Size: 0x40
function register_clientside(uid) {
    elem = new cluielemtext();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace luielemtext/luielemtext
// Params 1, eflags: 0x0
// Checksum 0xa56e516f, Offset: 0x1f8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace luielemtext/luielemtext
// Params 1, eflags: 0x0
// Checksum 0x8bbd92d0, Offset: 0x220
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielemtext/luielemtext
// Params 1, eflags: 0x0
// Checksum 0x63398160, Offset: 0x248
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x303fd749, Offset: 0x270
// Size: 0x28
function set_x(localclientnum, value) {
    [[ self ]]->set_x(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x401f4595, Offset: 0x2a0
// Size: 0x28
function set_y(localclientnum, value) {
    [[ self ]]->set_y(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x197658f6, Offset: 0x2d0
// Size: 0x28
function set_height(localclientnum, value) {
    [[ self ]]->set_height(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xe495ecb1, Offset: 0x300
// Size: 0x28
function set_fadeovertime(localclientnum, value) {
    [[ self ]]->set_fadeovertime(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x6d452e4b, Offset: 0x330
// Size: 0x28
function set_alpha(localclientnum, value) {
    [[ self ]]->set_alpha(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x5434166f, Offset: 0x360
// Size: 0x28
function set_red(localclientnum, value) {
    [[ self ]]->set_red(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xcd7a128, Offset: 0x390
// Size: 0x28
function set_green(localclientnum, value) {
    [[ self ]]->set_green(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x79c458ff, Offset: 0x3c0
// Size: 0x28
function set_blue(localclientnum, value) {
    [[ self ]]->set_blue(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0xcea1abe8, Offset: 0x3f0
// Size: 0x28
function set_text(localclientnum, value) {
    [[ self ]]->set_text(localclientnum, value);
}

// Namespace luielemtext/luielemtext
// Params 2, eflags: 0x0
// Checksum 0x72162a29, Offset: 0x420
// Size: 0x28
function set_horizontal_alignment(localclientnum, value) {
    [[ self ]]->set_horizontal_alignment(localclientnum, value);
}

