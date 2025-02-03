#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace cp_skip_scene_menu;

// Namespace cp_skip_scene_menu
// Method(s) 9 Total 16
class ccp_skip_scene_menu : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0x15140be7, Offset: 0x380
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0x9ee822b8, Offset: 0x448
    // Size: 0x44
    function set_hostisskipping(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "hostIsSkipping", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 1, eflags: 0x0
    // Checksum 0xcd253f2, Offset: 0x3c8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0x741464af, Offset: 0x498
    // Size: 0x44
    function set_votedtoskip(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "votedToSkip", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0x4ab3a17f, Offset: 0x3f8
    // Size: 0x44
    function set_showskipbutton(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "showSkipButton", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 0, eflags: 0x0
    // Checksum 0x56077c3b, Offset: 0x2b8
    // Size: 0xbc
    function setup_clientfields() {
        cluielem::setup_clientfields("cp_skip_scene_menu");
        cluielem::add_clientfield("showSkipButton", 1, 2, "int");
        cluielem::add_clientfield("hostIsSkipping", 1, 1, "int");
        cluielem::add_clientfield("votedToSkip", 1, 1, "int");
        cluielem::add_clientfield("sceneSkipEndTime", 1, 3, "int");
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0xe0735668, Offset: 0x4e8
    // Size: 0x44
    function set_sceneskipendtime(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "sceneSkipEndTime", value);
    }

}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 0, eflags: 0x0
// Checksum 0x23d3e806, Offset: 0x108
// Size: 0x34
function register() {
    elem = new ccp_skip_scene_menu();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0xe1ba103e, Offset: 0x148
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x0
// Checksum 0xf38863ea, Offset: 0x188
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x0
// Checksum 0xa304d7b3, Offset: 0x1b0
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0xabe3c795, Offset: 0x1d8
// Size: 0x28
function set_showskipbutton(player, value) {
    [[ self ]]->set_showskipbutton(player, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0xb90b2ec1, Offset: 0x208
// Size: 0x28
function set_hostisskipping(player, value) {
    [[ self ]]->set_hostisskipping(player, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0x9ed4a32b, Offset: 0x238
// Size: 0x28
function set_votedtoskip(player, value) {
    [[ self ]]->set_votedtoskip(player, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0x9442398d, Offset: 0x268
// Size: 0x28
function set_sceneskipendtime(player, value) {
    [[ self ]]->set_sceneskipendtime(player, value);
}

