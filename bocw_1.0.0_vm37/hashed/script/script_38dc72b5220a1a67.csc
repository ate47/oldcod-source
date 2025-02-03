#using scripts\core_common\lui_shared;

#namespace luielembar;

// Namespace luielembar
// Method(s) 16 Total 23
class cluielembar : cluielem {

    // Namespace cluielembar/luielembar
    // Params 1, eflags: 0x0
    // Checksum 0x9ec35942, Offset: 0x7a0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x347bcd78, Offset: 0x958
    // Size: 0x30
    function set_green(localclientnum, value) {
        set_data(localclientnum, "green", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x3b061107, Offset: 0x8b0
    // Size: 0x30
    function set_fadeovertime(localclientnum, value) {
        set_data(localclientnum, "fadeOverTime", value);
    }

    // Namespace cluielembar/luielembar
    // Params 0, eflags: 0x0
    // Checksum 0x25108b4, Offset: 0x608
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("LUIelemBar");
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x83249e00, Offset: 0x878
    // Size: 0x30
    function set_height(localclientnum, value) {
        set_data(localclientnum, "height", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x3434e1e5, Offset: 0x990
    // Size: 0x30
    function set_blue(localclientnum, value) {
        set_data(localclientnum, "blue", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x4fc992c4, Offset: 0x840
    // Size: 0x30
    function set_width(localclientnum, value) {
        set_data(localclientnum, "width", value);
    }

    // Namespace cluielembar/luielembar
    // Params 10, eflags: 0x0
    // Checksum 0x82ff6049, Offset: 0x590
    // Size: 0x6c
    function setup_clientfields(*xcallback, *ycallback, *widthcallback, *heightcallback, *fadeovertimecallback, *alphacallback, *redcallback, *greencallback, *bluecallback, *var_661989d5) {
        cluielem::setup_clientfields("LUIelemBar");
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x939207d0, Offset: 0x808
    // Size: 0x30
    function set_y(localclientnum, value) {
        set_data(localclientnum, "y", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0xb3d26c53, Offset: 0x8e8
    // Size: 0x30
    function set_alpha(localclientnum, value) {
        set_data(localclientnum, "alpha", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0xdda2e05f, Offset: 0x7d0
    // Size: 0x30
    function set_x(localclientnum, value) {
        set_data(localclientnum, "x", value);
    }

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0xe6cd1a60, Offset: 0x920
    // Size: 0x30
    function set_red(localclientnum, value) {
        set_data(localclientnum, "red", value);
    }

    // Namespace cluielembar/luielembar
    // Params 1, eflags: 0x0
    // Checksum 0xdf0b6ef6, Offset: 0x630
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

    // Namespace cluielembar/luielembar
    // Params 2, eflags: 0x0
    // Checksum 0x5b18d682, Offset: 0x9c8
    // Size: 0x30
    function set_bar_percent(localclientnum, value) {
        set_data(localclientnum, "bar_percent", value);
    }

}

// Namespace luielembar/luielembar
// Params 10, eflags: 0x0
// Checksum 0xdcdc6b94, Offset: 0x100
// Size: 0x1ce
function register(xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_661989d5) {
    elem = new cluielembar();
    [[ elem ]]->setup_clientfields(xcallback, ycallback, widthcallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_661989d5);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"luielembar"])) {
        level.var_ae746e8f[#"luielembar"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"luielembar"])) {
        level.var_ae746e8f[#"luielembar"] = [];
    } else if (!isarray(level.var_ae746e8f[#"luielembar"])) {
        level.var_ae746e8f[#"luielembar"] = array(level.var_ae746e8f[#"luielembar"]);
    }
    level.var_ae746e8f[#"luielembar"][level.var_ae746e8f[#"luielembar"].size] = elem;
}

// Namespace luielembar/luielembar
// Params 0, eflags: 0x0
// Checksum 0x28aef718, Offset: 0x2d8
// Size: 0x34
function register_clientside() {
    elem = new cluielembar();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace luielembar/luielembar
// Params 1, eflags: 0x0
// Checksum 0xae99dd78, Offset: 0x318
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace luielembar/luielembar
// Params 1, eflags: 0x0
// Checksum 0xdde59065, Offset: 0x340
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielembar/luielembar
// Params 1, eflags: 0x0
// Checksum 0xc89a3fa3, Offset: 0x368
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xf74e9463, Offset: 0x390
// Size: 0x28
function set_x(localclientnum, value) {
    [[ self ]]->set_x(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0xb2b6163d, Offset: 0x3c0
// Size: 0x28
function set_y(localclientnum, value) {
    [[ self ]]->set_y(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x40b12129, Offset: 0x3f0
// Size: 0x28
function set_width(localclientnum, value) {
    [[ self ]]->set_width(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x9d053ede, Offset: 0x420
// Size: 0x28
function set_height(localclientnum, value) {
    [[ self ]]->set_height(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x2b5d5754, Offset: 0x450
// Size: 0x28
function set_fadeovertime(localclientnum, value) {
    [[ self ]]->set_fadeovertime(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x9796f128, Offset: 0x480
// Size: 0x28
function set_alpha(localclientnum, value) {
    [[ self ]]->set_alpha(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x6f1fbe8a, Offset: 0x4b0
// Size: 0x28
function set_red(localclientnum, value) {
    [[ self ]]->set_red(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x6d8ba1f8, Offset: 0x4e0
// Size: 0x28
function set_green(localclientnum, value) {
    [[ self ]]->set_green(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x716837c, Offset: 0x510
// Size: 0x28
function set_blue(localclientnum, value) {
    [[ self ]]->set_blue(localclientnum, value);
}

// Namespace luielembar/luielembar
// Params 2, eflags: 0x0
// Checksum 0x1cff696, Offset: 0x540
// Size: 0x28
function set_bar_percent(localclientnum, value) {
    [[ self ]]->set_bar_percent(localclientnum, value);
}

