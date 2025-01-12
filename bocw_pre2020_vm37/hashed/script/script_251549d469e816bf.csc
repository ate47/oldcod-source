#using scripts\core_common\lui_shared;

#namespace luielemimage;

// Namespace luielemimage
// Method(s) 16 Total 22
class cluielemimage : cluielem {

    // Namespace cluielemimage/luielemimage
    // Params 1, eflags: 0x0
    // Checksum 0x4d81dd12, Offset: 0x948
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x2065c419, Offset: 0xb00
    // Size: 0x30
    function set_green(localclientnum, value) {
        set_data(localclientnum, "green", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xc32ff3bd, Offset: 0xa58
    // Size: 0x30
    function set_fadeovertime(localclientnum, value) {
        set_data(localclientnum, "fadeOverTime", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 0, eflags: 0x0
    // Checksum 0xb9ea7fc4, Offset: 0x7a8
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("LUIelemImage");
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xcc245fb2, Offset: 0xa20
    // Size: 0x30
    function set_height(localclientnum, value) {
        set_data(localclientnum, "height", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x90941878, Offset: 0xb70
    // Size: 0x30
    function set_material(localclientnum, value) {
        set_data(localclientnum, "material", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x36b10eb3, Offset: 0xb38
    // Size: 0x30
    function set_blue(localclientnum, value) {
        set_data(localclientnum, "blue", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x4f4c7aca, Offset: 0x9e8
    // Size: 0x30
    function set_width(localclientnum, value) {
        set_data(localclientnum, "width", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 10, eflags: 0x0
    // Checksum 0x68c32c64, Offset: 0x5a0
    // Size: 0x1fc
    function setup_clientfields(xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, *materialcallback) {
        cluielem::setup_clientfields("LUIelemImage");
        cluielem::add_clientfield("x", 1, 7, "int", ycallback);
        cluielem::add_clientfield("y", 1, 6, "int", widthcallback);
        cluielem::add_clientfield("width", 1, 6, "int", heightcallback);
        cluielem::add_clientfield("height", 1, 6, "int", fadeovertimecallback);
        cluielem::add_clientfield("fadeOverTime", 1, 5, "int", alphacallback);
        cluielem::add_clientfield("alpha", 1, 4, "float", redcallback);
        cluielem::add_clientfield("red", 1, 4, "float", greencallback);
        cluielem::add_clientfield("green", 1, 4, "float", bluecallback);
        cluielem::add_clientfield("blue", 1, 4, "float", materialcallback);
        cluielem::function_dcb34c80("material", "material", 1);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x1ee8653, Offset: 0x9b0
    // Size: 0x30
    function set_y(localclientnum, value) {
        set_data(localclientnum, "y", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x4c546d71, Offset: 0xa90
    // Size: 0x30
    function set_alpha(localclientnum, value) {
        set_data(localclientnum, "alpha", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0x3951ba85, Offset: 0x978
    // Size: 0x30
    function set_x(localclientnum, value) {
        set_data(localclientnum, "x", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 2, eflags: 0x0
    // Checksum 0xc8eed9e, Offset: 0xac8
    // Size: 0x30
    function set_red(localclientnum, value) {
        set_data(localclientnum, "red", value);
    }

    // Namespace cluielemimage/luielemimage
    // Params 1, eflags: 0x0
    // Checksum 0x35369f2, Offset: 0x7d0
    // Size: 0x16c
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
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

}

// Namespace luielemimage/luielemimage
// Params 10, eflags: 0x0
// Checksum 0xc689902d, Offset: 0x110
// Size: 0x1ce
function register(xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, materialcallback) {
    elem = new cluielemimage();
    [[ elem ]]->setup_clientfields(xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, materialcallback);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"luielemimage"])) {
        level.var_ae746e8f[#"luielemimage"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"luielemimage"])) {
        level.var_ae746e8f[#"luielemimage"] = [];
    } else if (!isarray(level.var_ae746e8f[#"luielemimage"])) {
        level.var_ae746e8f[#"luielemimage"] = array(level.var_ae746e8f[#"luielemimage"]);
    }
    level.var_ae746e8f[#"luielemimage"][level.var_ae746e8f[#"luielemimage"].size] = elem;
}

// Namespace luielemimage/luielemimage
// Params 0, eflags: 0x0
// Checksum 0x8c071327, Offset: 0x2e8
// Size: 0x34
function register_clientside() {
    elem = new cluielemimage();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace luielemimage/luielemimage
// Params 1, eflags: 0x0
// Checksum 0xfe313408, Offset: 0x328
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace luielemimage/luielemimage
// Params 1, eflags: 0x0
// Checksum 0xdb3407b0, Offset: 0x350
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielemimage/luielemimage
// Params 1, eflags: 0x0
// Checksum 0xdeed5693, Offset: 0x378
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x1441f42, Offset: 0x3a0
// Size: 0x28
function set_x(localclientnum, value) {
    [[ self ]]->set_x(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x5ad83dc2, Offset: 0x3d0
// Size: 0x28
function set_y(localclientnum, value) {
    [[ self ]]->set_y(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xc70ecc9e, Offset: 0x400
// Size: 0x28
function set_width(localclientnum, value) {
    [[ self ]]->set_width(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xa52257, Offset: 0x430
// Size: 0x28
function set_height(localclientnum, value) {
    [[ self ]]->set_height(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xe3a3a05d, Offset: 0x460
// Size: 0x28
function set_fadeovertime(localclientnum, value) {
    [[ self ]]->set_fadeovertime(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x94da0c33, Offset: 0x490
// Size: 0x28
function set_alpha(localclientnum, value) {
    [[ self ]]->set_alpha(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x6fd66b96, Offset: 0x4c0
// Size: 0x28
function set_red(localclientnum, value) {
    [[ self ]]->set_red(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xe23ff581, Offset: 0x4f0
// Size: 0x28
function set_green(localclientnum, value) {
    [[ self ]]->set_green(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0x72f5ea3c, Offset: 0x520
// Size: 0x28
function set_blue(localclientnum, value) {
    [[ self ]]->set_blue(localclientnum, value);
}

// Namespace luielemimage/luielemimage
// Params 2, eflags: 0x0
// Checksum 0xe5fc32c, Offset: 0x550
// Size: 0x28
function set_material(localclientnum, value) {
    [[ self ]]->set_material(localclientnum, value);
}

