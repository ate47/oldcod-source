#using scripts\core_common\lui_shared;

#namespace full_screen_black;

// Namespace full_screen_black
// Method(s) 13 Total 19
class cfull_screen_black : cluielem {

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2ab26d81, Offset: 0x8f0
    // Size: 0x30
    function set_endalpha(localclientnum, value) {
        set_data(localclientnum, "endAlpha", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 1, eflags: 0x1 linked
    // Checksum 0x4292dd86, Offset: 0x7a8
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0x568c3e61, Offset: 0x810
    // Size: 0x30
    function set_green(localclientnum, value) {
        set_data(localclientnum, "green", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3100c7f4, Offset: 0x880
    // Size: 0x30
    function set_fadeovertime(localclientnum, value) {
        set_data(localclientnum, "fadeOverTime", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4888b1b4, Offset: 0x668
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("full_screen_black");
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0x8519e73d, Offset: 0x848
    // Size: 0x30
    function set_blue(localclientnum, value) {
        set_data(localclientnum, "blue", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 7, eflags: 0x1 linked
    // Checksum 0x3b9af871, Offset: 0x4f0
    // Size: 0x16c
    function setup_clientfields(redcallback, greencallback, bluecallback, fadeovertimecallback, var_b046940, var_34291db, var_32445b2) {
        cluielem::setup_clientfields("full_screen_black");
        cluielem::add_clientfield("red", 1, 3, "float", redcallback);
        cluielem::add_clientfield("green", 1, 3, "float", greencallback);
        cluielem::add_clientfield("blue", 1, 3, "float", bluecallback);
        cluielem::add_clientfield("fadeOverTime", 1, 12, "int", fadeovertimecallback);
        cluielem::add_clientfield("startAlpha", 1, 5, "float", var_b046940);
        cluielem::add_clientfield("endAlpha", 1, 5, "float", var_34291db);
        cluielem::add_clientfield("drawHUD", 1, 1, "int", var_32445b2);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb0867a1b, Offset: 0x8b8
    // Size: 0x30
    function set_startalpha(localclientnum, value) {
        set_data(localclientnum, "startAlpha", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0xcc7ce2ab, Offset: 0x928
    // Size: 0x30
    function set_drawhud(localclientnum, value) {
        set_data(localclientnum, "drawHUD", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0x62920018, Offset: 0x7d8
    // Size: 0x30
    function set_red(localclientnum, value) {
        set_data(localclientnum, "red", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa1919b74, Offset: 0x690
    // Size: 0x110
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "red", 0);
        set_data(localclientnum, "green", 0);
        set_data(localclientnum, "blue", 0);
        set_data(localclientnum, "fadeOverTime", 0);
        set_data(localclientnum, "startAlpha", 0);
        set_data(localclientnum, "endAlpha", 0);
        set_data(localclientnum, "drawHUD", 0);
    }

}

// Namespace full_screen_black/full_screen_black
// Params 7, eflags: 0x1 linked
// Checksum 0xbc46267e, Offset: 0x108
// Size: 0x1b6
function register(redcallback, greencallback, bluecallback, fadeovertimecallback, var_b046940, var_34291db, var_32445b2) {
    elem = new cfull_screen_black();
    [[ elem ]]->setup_clientfields(redcallback, greencallback, bluecallback, fadeovertimecallback, var_b046940, var_34291db, var_32445b2);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"full_screen_black"])) {
        level.var_ae746e8f[#"full_screen_black"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"full_screen_black"])) {
        level.var_ae746e8f[#"full_screen_black"] = [];
    } else if (!isarray(level.var_ae746e8f[#"full_screen_black"])) {
        level.var_ae746e8f[#"full_screen_black"] = array(level.var_ae746e8f[#"full_screen_black"]);
    }
    level.var_ae746e8f[#"full_screen_black"][level.var_ae746e8f[#"full_screen_black"].size] = elem;
}

// Namespace full_screen_black/full_screen_black
// Params 0, eflags: 0x1 linked
// Checksum 0x3ac07171, Offset: 0x2c8
// Size: 0x34
function register_clientside() {
    elem = new cfull_screen_black();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0x403fba50, Offset: 0x308
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0x33d33c4d, Offset: 0x330
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0x371e22b6, Offset: 0x358
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x84badd7f, Offset: 0x380
// Size: 0x28
function set_red(localclientnum, value) {
    [[ self ]]->set_red(localclientnum, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xc66364e1, Offset: 0x3b0
// Size: 0x28
function set_green(localclientnum, value) {
    [[ self ]]->set_green(localclientnum, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xc07eabef, Offset: 0x3e0
// Size: 0x28
function set_blue(localclientnum, value) {
    [[ self ]]->set_blue(localclientnum, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x2af759b4, Offset: 0x410
// Size: 0x28
function set_fadeovertime(localclientnum, value) {
    [[ self ]]->set_fadeovertime(localclientnum, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xf540f1d5, Offset: 0x440
// Size: 0x28
function set_startalpha(localclientnum, value) {
    [[ self ]]->set_startalpha(localclientnum, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x3b42483a, Offset: 0x470
// Size: 0x28
function set_endalpha(localclientnum, value) {
    [[ self ]]->set_endalpha(localclientnum, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xca187b47, Offset: 0x4a0
// Size: 0x28
function set_drawhud(localclientnum, value) {
    [[ self ]]->set_drawhud(localclientnum, value);
}

