#using scripts\core_common\lui_shared;

#namespace luielemimage;

// Namespace luielemimage
// Method(s) 16 Total 22
class cluielemimage : cluielem {

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x83807b39, Offset: 0xa48
    // Size: 0x30
    function set_material(localclientnum, value) {
        set_data(localclientnum, "material", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xa068114, Offset: 0xa10
    // Size: 0x30
    function set_blue(localclientnum, value) {
        set_data(localclientnum, "blue", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xc5387869, Offset: 0x9d8
    // Size: 0x30
    function set_green(localclientnum, value) {
        set_data(localclientnum, "green", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x6d61a290, Offset: 0x9a0
    // Size: 0x30
    function set_red(localclientnum, value) {
        set_data(localclientnum, "red", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x56bd351a, Offset: 0x968
    // Size: 0x30
    function set_alpha(localclientnum, value) {
        set_data(localclientnum, "alpha", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x4cf003ac, Offset: 0x930
    // Size: 0x30
    function set_fadeovertime(localclientnum, value) {
        set_data(localclientnum, "fadeOverTime", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x13cda082, Offset: 0x8f8
    // Size: 0x30
    function set_height(localclientnum, value) {
        set_data(localclientnum, "height", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x30ef6576, Offset: 0x8c0
    // Size: 0x30
    function set_width(localclientnum, value) {
        set_data(localclientnum, "width", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x80098d40, Offset: 0x888
    // Size: 0x30
    function set_y(localclientnum, value) {
        set_data(localclientnum, "y", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xda40d04, Offset: 0x850
    // Size: 0x30
    function set_x(localclientnum, value) {
        set_data(localclientnum, "x", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 1, eflags: 0x0
    // Checksum 0x90491334, Offset: 0x818
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"luielemimage");
    }

    // Namespace cluielemimage/luielemimage
    // Params 1, eflags: 0x0
    // Checksum 0x8c80b345, Offset: 0x6a0
    // Size: 0x16c
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "x", 0);
        set_data(localclientnum, "y", 0);
        set_data(localclientnum, "width", 0);
        set_data(localclientnum, "height", 0);
        set_data(localclientnum, "fadeOverTime", 0);
        set_data(localclientnum, "alpha", 0);
        set_data(localclientnum, "red", 0);
        set_data(localclientnum, "green", 0);
        set_data(localclientnum, "blue", 0);
        set_data(localclientnum, "material", #"");
    }

    // Namespace cluielemimage/luielemimage
    // Params 1, eflags: 0x0
    // Checksum 0x64c880f0, Offset: 0x670
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cluielemimage/luielemimage
    // Params 11, eflags: 0x0
    // Checksum 0x4e13813d, Offset: 0x460
    // Size: 0x204
    function setup_clientfields(uid, xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, materialcallback) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("x", 1, 7, "int", xcallback);
        cluielem::add_clientfield("y", 1, 6, "int", ycallback);
        cluielem::add_clientfield("width", 1, 6, "int", widthcallback);
        cluielem::add_clientfield("height", 1, 6, "int", heightcallback);
        cluielem::add_clientfield("fadeOverTime", 1, 5, "int", fadeovertimecallback);
        cluielem::add_clientfield("alpha", 1, 4, "float", alphacallback);
        cluielem::add_clientfield("red", 1, 4, "float", redcallback);
        cluielem::add_clientfield("green", 1, 4, "float", greencallback);
        cluielem::add_clientfield("blue", 1, 4, "float", bluecallback);
        cluielem::function_52818084("material", "material", 1);
    }

}

// Namespace luielemimage/luielemimage
// Params 11, eflags: 0x0
// Checksum 0x9de7ea9, Offset: 0xe0
// Size: 0xb8
function register(uid, xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, materialcallback) {
    elem = new cluielemimage();
    [[ elem ]]->setup_clientfields(uid, xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, materialcallback);
    return elem;
}

// Namespace luielemimage/luielemimage
// Params 1, eflags: 0x0
// Checksum 0xa6f090cd, Offset: 0x1a0
// Size: 0x40
function register_clientside(uid) {
    elem = new cluielemimage();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace luielemimage/luielemimage
// Params 1, eflags: 0x0
// Checksum 0xca622b7e, Offset: 0x1e8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace luielemimage/luielemimage
// Params 1, eflags: 0x0
// Checksum 0xb741efb3, Offset: 0x210
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielemimage/luielemimage
// Params 1, eflags: 0x0
// Checksum 0x91f5a392, Offset: 0x238
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x36da3706, Offset: 0x260
// Size: 0x28
function set_x(localclientnum, value) {
    [[ self ]]->set_x(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x5ffbb437, Offset: 0x290
// Size: 0x28
function set_y(localclientnum, value) {
    [[ self ]]->set_y(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x641a288a, Offset: 0x2c0
// Size: 0x28
function set_width(localclientnum, value) {
    [[ self ]]->set_width(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x3a0da537, Offset: 0x2f0
// Size: 0x28
function set_height(localclientnum, value) {
    [[ self ]]->set_height(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x4c482148, Offset: 0x320
// Size: 0x28
function set_fadeovertime(localclientnum, value) {
    [[ self ]]->set_fadeovertime(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x72bbea1e, Offset: 0x350
// Size: 0x28
function set_alpha(localclientnum, value) {
    [[ self ]]->set_alpha(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x296d79eb, Offset: 0x380
// Size: 0x28
function set_red(localclientnum, value) {
    [[ self ]]->set_red(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x30f514fe, Offset: 0x3b0
// Size: 0x28
function set_green(localclientnum, value) {
    [[ self ]]->set_green(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x59f92550, Offset: 0x3e0
// Size: 0x28
function set_blue(localclientnum, value) {
    [[ self ]]->set_blue(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x42685e8, Offset: 0x410
// Size: 0x28
function set_material(localclientnum, value) {
    [[ self ]]->set_material(localclientnum, value);
}

