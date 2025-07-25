#using scripts\core_common\lui_shared;

#namespace luielembar_ct;

// Namespace luielembar_ct
// Method(s) 16 Total 23
class cluielembar_ct : cluielem {

    // Namespace cluielembar_ct/luielembar_ct
    // Params 1, eflags: 0x0
    // Checksum 0x74d2456f, Offset: 0x948
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cluielembar_ct/luielembar_ct
    // Params 2, eflags: 0x0
    // Checksum 0x91bd0b5, Offset: 0xb00
    // Size: 0x30
    function set_green(localclientnum, value) {
        set_data(localclientnum, "green", value);
    }

    // Namespace cluielembar_ct/luielembar_ct
    // Params 2, eflags: 0x0
    // Checksum 0x1baffd4, Offset: 0xa58
    // Size: 0x30
    function set_fadeovertime(localclientnum, value) {
        set_data(localclientnum, "fadeOverTime", value);
    }

    // Namespace cluielembar_ct/luielembar_ct
    // Params 0, eflags: 0x0
    // Checksum 0x6963499, Offset: 0x7b0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("LUIelemBar_ct");
    }

    // Namespace cluielembar_ct/luielembar_ct
    // Params 2, eflags: 0x0
    // Checksum 0x27ac38e8, Offset: 0xa20
    // Size: 0x30
    function set_height(localclientnum, value) {
        set_data(localclientnum, "height", value);
    }

    // Namespace cluielembar_ct/luielembar_ct
    // Params 2, eflags: 0x0
    // Checksum 0xa2e0bf5, Offset: 0xb38
    // Size: 0x30
    function set_blue(localclientnum, value) {
        set_data(localclientnum, "blue", value);
    }

    // Namespace cluielembar_ct/luielembar_ct
    // Params 2, eflags: 0x0
    // Checksum 0x4a8047af, Offset: 0x9e8
    // Size: 0x30
    function set_width(localclientnum, value) {
        set_data(localclientnum, "width", value);
    }

    // Namespace cluielembar_ct/luielembar_ct
    // Params 10, eflags: 0x0
    // Checksum 0x4b68fe30, Offset: 0x5a8
    // Size: 0x1fc
    function setup_clientfields(xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_661989d5) {
        cluielem::setup_clientfields("LUIelemBar_ct");
        cluielem::add_clientfield("x", 1, 7, "int", xcallback);
        cluielem::add_clientfield("y", 1, 6, "int", ycallback);
        cluielem::add_clientfield("width", 1, 6, "int", widthcallback);
        cluielem::add_clientfield("height", 1, 6, "int", heightcallback);
        cluielem::add_clientfield("fadeOverTime", 1, 5, "int", fadeovertimecallback);
        cluielem::add_clientfield("alpha", 1, 4, "float", alphacallback);
        cluielem::add_clientfield("red", 1, 4, "float", redcallback);
        cluielem::add_clientfield("green", 1, 4, "float", greencallback);
        cluielem::add_clientfield("blue", 1, 4, "float", bluecallback);
        cluielem::add_clientfield("bar_percent", 1, 6, "float", var_661989d5);
    }

    // Namespace cluielembar_ct/luielembar_ct
    // Params 2, eflags: 0x0
    // Checksum 0x6281d0d, Offset: 0x9b0
    // Size: 0x30
    function set_y(localclientnum, value) {
        set_data(localclientnum, "y", value);
    }

    // Namespace cluielembar_ct/luielembar_ct
    // Params 2, eflags: 0x0
    // Checksum 0xfde2e082, Offset: 0xa90
    // Size: 0x30
    function set_alpha(localclientnum, value) {
        set_data(localclientnum, "alpha", value);
    }

    // Namespace cluielembar_ct/luielembar_ct
    // Params 2, eflags: 0x0
    // Checksum 0x415849d9, Offset: 0x978
    // Size: 0x30
    function set_x(localclientnum, value) {
        set_data(localclientnum, "x", value);
    }

    // Namespace cluielembar_ct/luielembar_ct
    // Params 2, eflags: 0x0
    // Checksum 0x4f023a7b, Offset: 0xac8
    // Size: 0x30
    function set_red(localclientnum, value) {
        set_data(localclientnum, "red", value);
    }

    // Namespace cluielembar_ct/luielembar_ct
    // Params 1, eflags: 0x0
    // Checksum 0x15033b52, Offset: 0x7d8
    // Size: 0x164
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
        set_data(localclientnum, "bar_percent", 0);
    }

    // Namespace cluielembar_ct/luielembar_ct
    // Params 2, eflags: 0x0
    // Checksum 0x997478ad, Offset: 0xb70
    // Size: 0x30
    function set_bar_percent(localclientnum, value) {
        set_data(localclientnum, "bar_percent", value);
    }

}

// Namespace luielembar_ct/luielembar_ct
// Params 10, eflags: 0x0
// Checksum 0x6616932d, Offset: 0x118
// Size: 0x1ce
function register(xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_661989d5) {
    elem = new cluielembar_ct();
    [[ elem ]]->setup_clientfields(xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_661989d5);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"luielembar_ct"])) {
        level.var_ae746e8f[#"luielembar_ct"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"luielembar_ct"])) {
        level.var_ae746e8f[#"luielembar_ct"] = [];
    } else if (!isarray(level.var_ae746e8f[#"luielembar_ct"])) {
        level.var_ae746e8f[#"luielembar_ct"] = array(level.var_ae746e8f[#"luielembar_ct"]);
    }
    level.var_ae746e8f[#"luielembar_ct"][level.var_ae746e8f[#"luielembar_ct"].size] = elem;
}

// Namespace luielembar_ct/luielembar_ct
// Params 0, eflags: 0x0
// Checksum 0x6acf3432, Offset: 0x2f0
// Size: 0x34
function register_clientside() {
    elem = new cluielembar_ct();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace luielembar_ct/luielembar_ct
// Params 1, eflags: 0x0
// Checksum 0x3e738e7e, Offset: 0x330
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace luielembar_ct/luielembar_ct
// Params 1, eflags: 0x0
// Checksum 0x3fb7085b, Offset: 0x358
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielembar_ct/luielembar_ct
// Params 1, eflags: 0x0
// Checksum 0x5f949d0b, Offset: 0x380
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace luielembar_ct/luielembar_ct
// Params 2, eflags: 0x0
// Checksum 0x6c47ad3c, Offset: 0x3a8
// Size: 0x28
function set_x(localclientnum, value) {
    [[ self ]]->set_x(localclientnum, value);
}

// Namespace luielembar_ct/luielembar_ct
// Params 2, eflags: 0x0
// Checksum 0xe1b4b487, Offset: 0x3d8
// Size: 0x28
function set_y(localclientnum, value) {
    [[ self ]]->set_y(localclientnum, value);
}

// Namespace luielembar_ct/luielembar_ct
// Params 2, eflags: 0x0
// Checksum 0x8f83831a, Offset: 0x408
// Size: 0x28
function set_width(localclientnum, value) {
    [[ self ]]->set_width(localclientnum, value);
}

// Namespace luielembar_ct/luielembar_ct
// Params 2, eflags: 0x0
// Checksum 0xc1944e69, Offset: 0x438
// Size: 0x28
function set_height(localclientnum, value) {
    [[ self ]]->set_height(localclientnum, value);
}

// Namespace luielembar_ct/luielembar_ct
// Params 2, eflags: 0x0
// Checksum 0x1cdea1b4, Offset: 0x468
// Size: 0x28
function set_fadeovertime(localclientnum, value) {
    [[ self ]]->set_fadeovertime(localclientnum, value);
}

// Namespace luielembar_ct/luielembar_ct
// Params 2, eflags: 0x0
// Checksum 0x9cd77def, Offset: 0x498
// Size: 0x28
function set_alpha(localclientnum, value) {
    [[ self ]]->set_alpha(localclientnum, value);
}

// Namespace luielembar_ct/luielembar_ct
// Params 2, eflags: 0x0
// Checksum 0x5aaf1c2e, Offset: 0x4c8
// Size: 0x28
function set_red(localclientnum, value) {
    [[ self ]]->set_red(localclientnum, value);
}

// Namespace luielembar_ct/luielembar_ct
// Params 2, eflags: 0x0
// Checksum 0x6c6c36ac, Offset: 0x4f8
// Size: 0x28
function set_green(localclientnum, value) {
    [[ self ]]->set_green(localclientnum, value);
}

// Namespace luielembar_ct/luielembar_ct
// Params 2, eflags: 0x0
// Checksum 0xa596382c, Offset: 0x528
// Size: 0x28
function set_blue(localclientnum, value) {
    [[ self ]]->set_blue(localclientnum, value);
}

// Namespace luielembar_ct/luielembar_ct
// Params 2, eflags: 0x0
// Checksum 0xee111083, Offset: 0x558
// Size: 0x28
function set_bar_percent(localclientnum, value) {
    [[ self ]]->set_bar_percent(localclientnum, value);
}

