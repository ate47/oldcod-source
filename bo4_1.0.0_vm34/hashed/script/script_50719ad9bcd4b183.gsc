#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace full_screen_black;

// Namespace full_screen_black
// Method(s) 11 Total 18
class cfull_screen_black : cluielem {

    var var_57a3d576;

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x83604be7, Offset: 0x608
    // Size: 0x3c
    function set_endalpha(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "endAlpha", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x5434e35b, Offset: 0x5c0
    // Size: 0x3c
    function set_startalpha(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "startAlpha", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x88760746, Offset: 0x578
    // Size: 0x3c
    function set_fadeovertime(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "fadeOverTime", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x637894a, Offset: 0x530
    // Size: 0x3c
    function set_blue(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "blue", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0xd899e78b, Offset: 0x4e8
    // Size: 0x3c
    function set_green(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "green", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x44c6c7e, Offset: 0x4a0
    // Size: 0x3c
    function set_red(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "red", value);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 1, eflags: 0x0
    // Checksum 0x8a14a054, Offset: 0x470
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 2, eflags: 0x0
    // Checksum 0x1bcb97d0, Offset: 0x420
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "full_screen_black", persistent);
    }

    // Namespace cfull_screen_black/full_screen_black
    // Params 1, eflags: 0x0
    // Checksum 0xebedc5db, Offset: 0x300
    // Size: 0x114
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("red", 1, 3, "float");
        cluielem::add_clientfield("green", 1, 3, "float");
        cluielem::add_clientfield("blue", 1, 3, "float");
        cluielem::add_clientfield("fadeOverTime", 1, 12, "int");
        cluielem::add_clientfield("startAlpha", 1, 5, "float");
        cluielem::add_clientfield("endAlpha", 1, 5, "float");
    }

}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0xbc7f968b, Offset: 0xe8
// Size: 0x40
function register(uid) {
    elem = new cfull_screen_black();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xa775b0be, Offset: 0x130
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0x476f2d1e, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace full_screen_black/full_screen_black
// Params 1, eflags: 0x0
// Checksum 0x224afe8a, Offset: 0x198
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x4098529, Offset: 0x1c0
// Size: 0x28
function set_red(player, value) {
    [[ self ]]->set_red(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xd1db6ab3, Offset: 0x1f0
// Size: 0x28
function set_green(player, value) {
    [[ self ]]->set_green(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x1660bfef, Offset: 0x220
// Size: 0x28
function set_blue(player, value) {
    [[ self ]]->set_blue(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0x46ca4201, Offset: 0x250
// Size: 0x28
function set_fadeovertime(player, value) {
    [[ self ]]->set_fadeovertime(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xde5b3c85, Offset: 0x280
// Size: 0x28
function set_startalpha(player, value) {
    [[ self ]]->set_startalpha(player, value);
}

// Namespace full_screen_black/full_screen_black
// Params 2, eflags: 0x0
// Checksum 0xc796c087, Offset: 0x2b0
// Size: 0x28
function set_endalpha(player, value) {
    [[ self ]]->set_endalpha(player, value);
}

