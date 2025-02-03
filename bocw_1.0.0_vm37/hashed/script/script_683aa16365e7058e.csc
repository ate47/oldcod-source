#using scripts\core_common\lui_shared;

#namespace luielemcounter;

// Namespace luielemcounter
// Method(s) 16 Total 23
class class_1beae0 : cluielem {

    // Namespace namespace_1beae0/luielemcounter
    // Params 1, eflags: 0x0
    // Checksum 0x9d3849e8, Offset: 0x7a8
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0x9a2b3b1f, Offset: 0x9d0
    // Size: 0x30
    function set_horizontal_alignment(localclientnum, value) {
        set_data(localclientnum, "horizontal_alignment", value);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0x47566ff, Offset: 0x928
    // Size: 0x30
    function set_green(localclientnum, value) {
        set_data(localclientnum, "green", value);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0xe60767d1, Offset: 0x880
    // Size: 0x30
    function set_fadeovertime(localclientnum, value) {
        set_data(localclientnum, "fadeOverTime", value);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 0, eflags: 0x0
    // Checksum 0x83da62d2, Offset: 0x618
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("LUIelemCounter");
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0xb70c9366, Offset: 0x998
    // Size: 0x30
    function function_5d4dff63(localclientnum, value) {
        set_data(localclientnum, "number", value);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0x9720ee40, Offset: 0x848
    // Size: 0x30
    function set_height(localclientnum, value) {
        set_data(localclientnum, "height", value);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0xc8d8dde7, Offset: 0x960
    // Size: 0x30
    function set_blue(localclientnum, value) {
        set_data(localclientnum, "blue", value);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 10, eflags: 0x0
    // Checksum 0x26b80ce1, Offset: 0x5a0
    // Size: 0x6c
    function setup_clientfields(*xcallback, *ycallback, *heightcallback, *fadeovertimecallback, *alphacallback, *redcallback, *greencallback, *bluecallback, *var_4cf01ed6, *horizontal_alignmentcallback) {
        cluielem::setup_clientfields("LUIelemCounter");
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0x1bfe8ddf, Offset: 0x810
    // Size: 0x30
    function set_y(localclientnum, value) {
        set_data(localclientnum, "y", value);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0x15518ac7, Offset: 0x8b8
    // Size: 0x30
    function set_alpha(localclientnum, value) {
        set_data(localclientnum, "alpha", value);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0x3190e9a4, Offset: 0x7d8
    // Size: 0x30
    function set_x(localclientnum, value) {
        set_data(localclientnum, "x", value);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 2, eflags: 0x0
    // Checksum 0x484c232, Offset: 0x8f0
    // Size: 0x30
    function set_red(localclientnum, value) {
        set_data(localclientnum, "red", value);
    }

    // Namespace namespace_1beae0/luielemcounter
    // Params 1, eflags: 0x0
    // Checksum 0x3aa2be7d, Offset: 0x640
    // Size: 0x15c
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
        set_data(localclientnum, "number", 0);
        set_data(localclientnum, "horizontal_alignment", 0);
    }

}

// Namespace luielemcounter/luielemcounter
// Params 10, eflags: 0x0
// Checksum 0x7b9032fb, Offset: 0x110
// Size: 0x1ce
function register(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_4cf01ed6, horizontal_alignmentcallback) {
    elem = new class_1beae0();
    [[ elem ]]->setup_clientfields(xcallback, ycallback, heightcallback, fadeovertimecallback, alphacallback, redcallback, greencallback, bluecallback, var_4cf01ed6, horizontal_alignmentcallback);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"luielemcounter"])) {
        level.var_ae746e8f[#"luielemcounter"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"luielemcounter"])) {
        level.var_ae746e8f[#"luielemcounter"] = [];
    } else if (!isarray(level.var_ae746e8f[#"luielemcounter"])) {
        level.var_ae746e8f[#"luielemcounter"] = array(level.var_ae746e8f[#"luielemcounter"]);
    }
    level.var_ae746e8f[#"luielemcounter"][level.var_ae746e8f[#"luielemcounter"].size] = elem;
}

// Namespace luielemcounter/luielemcounter
// Params 0, eflags: 0x0
// Checksum 0x61c46478, Offset: 0x2e8
// Size: 0x34
function register_clientside() {
    elem = new class_1beae0();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace luielemcounter/luielemcounter
// Params 1, eflags: 0x0
// Checksum 0x3c5115b0, Offset: 0x328
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace luielemcounter/luielemcounter
// Params 1, eflags: 0x0
// Checksum 0xef4f2055, Offset: 0x350
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielemcounter/luielemcounter
// Params 1, eflags: 0x0
// Checksum 0xbf111b75, Offset: 0x378
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0xcafecc55, Offset: 0x3a0
// Size: 0x28
function set_x(localclientnum, value) {
    [[ self ]]->set_x(localclientnum, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0xc27a829d, Offset: 0x3d0
// Size: 0x28
function set_y(localclientnum, value) {
    [[ self ]]->set_y(localclientnum, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0x91f7760c, Offset: 0x400
// Size: 0x28
function set_height(localclientnum, value) {
    [[ self ]]->set_height(localclientnum, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0x89322b44, Offset: 0x430
// Size: 0x28
function set_fadeovertime(localclientnum, value) {
    [[ self ]]->set_fadeovertime(localclientnum, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0xbead7374, Offset: 0x460
// Size: 0x28
function set_alpha(localclientnum, value) {
    [[ self ]]->set_alpha(localclientnum, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0xc2ce6f75, Offset: 0x490
// Size: 0x28
function set_red(localclientnum, value) {
    [[ self ]]->set_red(localclientnum, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0xf0b839d2, Offset: 0x4c0
// Size: 0x28
function set_green(localclientnum, value) {
    [[ self ]]->set_green(localclientnum, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0xbfe52040, Offset: 0x4f0
// Size: 0x28
function set_blue(localclientnum, value) {
    [[ self ]]->set_blue(localclientnum, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0xfda212ce, Offset: 0x520
// Size: 0x28
function function_5d4dff63(localclientnum, value) {
    [[ self ]]->function_5d4dff63(localclientnum, value);
}

// Namespace luielemcounter/luielemcounter
// Params 2, eflags: 0x0
// Checksum 0xd974eb7f, Offset: 0x550
// Size: 0x28
function set_horizontal_alignment(localclientnum, value) {
    [[ self ]]->set_horizontal_alignment(localclientnum, value);
}

