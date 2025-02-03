#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace full_screen_black;

// Namespace full_screen_black
// Method(s) 12 Total 19
class cfull_screen_black : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x7d09203e, Offset: 0x698
    // Size: 0x44
    function set_endalpha(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "endAlpha", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x9909b327, Offset: 0x490
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x765dc27b, Offset: 0x558
    // Size: 0x44
    function set_green(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "green", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x7986beff, Offset: 0x5f8
    // Size: 0x44
    function set_fadeovertime(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "fadeOverTime", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 1, eflags: 0x0
    // Checksum 0x25fc787d, Offset: 0x4d8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x8930f269, Offset: 0x5a8
    // Size: 0x44
    function set_blue(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "blue", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 0, eflags: 0x0
    // Checksum 0x3054f8de, Offset: 0x350
    // Size: 0x134
    function setup_clientfields() {
        cluielem::setup_clientfields("full_screen_black");
        cluielem::add_clientfield("red", 1, 3, "float");
        cluielem::add_clientfield("green", 1, 3, "float");
        cluielem::add_clientfield("blue", 1, 3, "float");
        cluielem::add_clientfield("fadeOverTime", 1, 12, "int");
        cluielem::add_clientfield("startAlpha", 1, 5, "float");
        cluielem::add_clientfield("endAlpha", 1, 5, "float");
        cluielem::add_clientfield("drawHUD", 1, 1, "int");
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x17b2ba24, Offset: 0x648
    // Size: 0x44
    function set_startalpha(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "startAlpha", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x711e7c50, Offset: 0x6e8
    // Size: 0x44
    function set_drawhud(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "drawHUD", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x3485e2ed, Offset: 0x508
    // Size: 0x44
    function set_red(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "red", value);
    }

}

// Namespace full_screen_black/full_screen_black
// Params 0, eflags: 0x0
// Checksum 0x62095848, Offset: 0x110
// Size: 0x34
function register() {
    elem = new cfull_screen_black();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x672bc8a8, Offset: 0x150
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0x2194ec3f, Offset: 0x190
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0x37b19c38, Offset: 0x1b8
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xb6af0175, Offset: 0x1e0
// Size: 0x28
function set_red(player, value) {
    [[ self ]]->set_red(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x1bbb7d5, Offset: 0x210
// Size: 0x28
function set_green(player, value) {
    [[ self ]]->set_green(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x4e2286dc, Offset: 0x240
// Size: 0x28
function set_blue(player, value) {
    [[ self ]]->set_blue(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x4a78f36e, Offset: 0x270
// Size: 0x28
function set_fadeovertime(player, value) {
    [[ self ]]->set_fadeovertime(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x6c5f5dc1, Offset: 0x2a0
// Size: 0x28
function set_startalpha(player, value) {
    [[ self ]]->set_startalpha(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x41f65865, Offset: 0x2d0
// Size: 0x28
function set_endalpha(player, value) {
    [[ self ]]->set_endalpha(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x651e186d, Offset: 0x300
// Size: 0x28
function set_drawhud(player, value) {
    [[ self ]]->set_drawhud(player, value);
}

