#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace cp_skip_scene_menu;

// Namespace cp_skip_scene_menu
// Method(s) 9 Total 16
class ccp_skip_scene_menu : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0x424ba4e9, Offset: 0x380
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0xe7bde11b, Offset: 0x448
    // Size: 0x44
    function set_hostisskipping(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "hostIsSkipping", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0x375e4861, Offset: 0x3c8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0x77cc23d0, Offset: 0x498
    // Size: 0x44
    function set_votedtoskip(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "votedToSkip", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0x179dd368, Offset: 0x3f8
    // Size: 0x44
    function set_showskipbutton(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "showSkipButton", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 0, eflags: 0x1 linked
    // Checksum 0xec3fb73e, Offset: 0x2b8
    // Size: 0xbc
    function setup_clientfields() {
        cluielem::setup_clientfields("cp_skip_scene_menu");
        cluielem::add_clientfield("showSkipButton", 1, 2, "int");
        cluielem::add_clientfield("hostIsSkipping", 1, 1, "int");
        cluielem::add_clientfield("votedToSkip", 1, 1, "int");
        cluielem::add_clientfield("sceneSkipEndTime", 1, 3, "int");
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7becd35, Offset: 0x4e8
    // Size: 0x44
    function set_sceneskipendtime(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "sceneSkipEndTime", value);
    }

}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 0, eflags: 0x1 linked
// Checksum 0x62458f32, Offset: 0x108
// Size: 0x34
function register() {
    elem = new ccp_skip_scene_menu();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x1 linked
// Checksum 0x2d020860, Offset: 0x148
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x1 linked
// Checksum 0xfd201144, Offset: 0x188
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x0
// Checksum 0xc0142567, Offset: 0x1b0
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x1 linked
// Checksum 0x2c2df532, Offset: 0x1d8
// Size: 0x28
function set_showskipbutton(player, value) {
    [[ self ]]->set_showskipbutton(player, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x1 linked
// Checksum 0x85516c8f, Offset: 0x208
// Size: 0x28
function set_hostisskipping(player, value) {
    [[ self ]]->set_hostisskipping(player, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x1 linked
// Checksum 0x17265ee9, Offset: 0x238
// Size: 0x28
function set_votedtoskip(player, value) {
    [[ self ]]->set_votedtoskip(player, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x1 linked
// Checksum 0x48ef22b1, Offset: 0x268
// Size: 0x28
function set_sceneskipendtime(player, value) {
    [[ self ]]->set_sceneskipendtime(player, value);
}

