#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace full_screen_black;

// Namespace full_screen_black
// Method(s) 12 Total 19
class cfull_screen_black : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0x280959d9, Offset: 0x698
    // Size: 0x44
    function set_endalpha(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "endAlpha", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0xf3e259ac, Offset: 0x490
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0xcaef24a0, Offset: 0x558
    // Size: 0x44
    function set_green(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "green", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0x181a421f, Offset: 0x5f8
    // Size: 0x44
    function set_fadeovertime(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "fadeOverTime", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3ec8acd8, Offset: 0x4d8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0x939a70c0, Offset: 0x5a8
    // Size: 0x44
    function set_blue(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "blue", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 0, eflags: 0x1 linked
    // Checksum 0x23fd103c, Offset: 0x350
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
    // Params 2, eflags: 0x1 linked
    // Checksum 0x44f63ddf, Offset: 0x648
    // Size: 0x44
    function set_startalpha(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "startAlpha", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0x8032f04d, Offset: 0x6e8
    // Size: 0x44
    function set_drawhud(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "drawHUD", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0xd34879b0, Offset: 0x508
    // Size: 0x44
    function set_red(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "red", value);
    }

}

// Namespace full_screen_black/full_screen_black
// Params 0, eflags: 0x1 linked
// Checksum 0x239f3f7c, Offset: 0x110
// Size: 0x34
function register() {
    elem = new cfull_screen_black();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xab93d0f6, Offset: 0x150
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0x2f3c9e91, Offset: 0x190
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0x54a16eec, Offset: 0x1b8
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x316133d2, Offset: 0x1e0
// Size: 0x28
function set_red(player, value) {
    [[ self ]]->set_red(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x3de1f59b, Offset: 0x210
// Size: 0x28
function set_green(player, value) {
    [[ self ]]->set_green(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xc7d07b1e, Offset: 0x240
// Size: 0x28
function set_blue(player, value) {
    [[ self ]]->set_blue(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x96d5e852, Offset: 0x270
// Size: 0x28
function set_fadeovertime(player, value) {
    [[ self ]]->set_fadeovertime(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xfb19df5a, Offset: 0x2a0
// Size: 0x28
function set_startalpha(player, value) {
    [[ self ]]->set_startalpha(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x94616cc4, Offset: 0x2d0
// Size: 0x28
function set_endalpha(player, value) {
    [[ self ]]->set_endalpha(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x6c5f0542, Offset: 0x300
// Size: 0x28
function set_drawhud(player, value) {
    [[ self ]]->set_drawhud(player, value);
}

