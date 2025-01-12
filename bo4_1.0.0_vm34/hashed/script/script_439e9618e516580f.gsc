#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace cp_skip_scene_menu;

// Namespace cp_skip_scene_menu
// Method(s) 9 Total 16
class ccp_skip_scene_menu : cluielem {

    var var_57a3d576;

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0x606caf32, Offset: 0x4d0
    // Size: 0x3c
    function set_sceneskipendtime(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "sceneSkipEndTime", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0x8e0e74f2, Offset: 0x488
    // Size: 0x3c
    function set_votedtoskip(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "votedToSkip", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0xdfa23cb7, Offset: 0x440
    // Size: 0x3c
    function set_hostisskipping(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "hostIsSkipping", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0x35677120, Offset: 0x3f8
    // Size: 0x3c
    function set_showskipbutton(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "showSkipButton", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 1, eflags: 0x0
    // Checksum 0x377fe4a5, Offset: 0x3c8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0xf17e4683, Offset: 0x378
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "cp_skip_scene_menu", persistent);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 1, eflags: 0x0
    // Checksum 0xa4e55498, Offset: 0x2a8
    // Size: 0xc4
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("showSkipButton", 1, 2, "int");
        cluielem::add_clientfield("hostIsSkipping", 1, 1, "int");
        cluielem::add_clientfield("votedToSkip", 1, 1, "int");
        cluielem::add_clientfield("sceneSkipEndTime", 1, 3, "int");
    }

}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x0
// Checksum 0x39a16814, Offset: 0xf0
// Size: 0x40
function register(uid) {
    elem = new ccp_skip_scene_menu();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0x88d49b9e, Offset: 0x138
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x0
// Checksum 0x379f992f, Offset: 0x178
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x0
// Checksum 0x9d92d204, Offset: 0x1a0
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0x2af77771, Offset: 0x1c8
// Size: 0x28
function set_showskipbutton(player, value) {
    [[ self ]]->set_showskipbutton(player, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0xd6fba797, Offset: 0x1f8
// Size: 0x28
function set_hostisskipping(player, value) {
    [[ self ]]->set_hostisskipping(player, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0x9a0bc607, Offset: 0x228
// Size: 0x28
function set_votedtoskip(player, value) {
    [[ self ]]->set_votedtoskip(player, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0x7279b2df, Offset: 0x258
// Size: 0x28
function set_sceneskipendtime(player, value) {
    [[ self ]]->set_sceneskipendtime(player, value);
}

