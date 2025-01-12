#using scripts\core_common\lui_shared;

#namespace cp_skip_scene_menu;

// Namespace cp_skip_scene_menu
// Method(s) 10 Total 16
class ccp_skip_scene_menu : cluielem {

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0x80036c44, Offset: 0x590
    // Size: 0x30
    function set_sceneskipendtime(localclientnum, value) {
        set_data(localclientnum, "sceneSkipEndTime", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0xc334e66d, Offset: 0x558
    // Size: 0x30
    function set_votedtoskip(localclientnum, value) {
        set_data(localclientnum, "votedToSkip", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0x1ccb1369, Offset: 0x520
    // Size: 0x30
    function set_hostisskipping(localclientnum, value) {
        set_data(localclientnum, "hostIsSkipping", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x0
    // Checksum 0x71ce4f17, Offset: 0x4e8
    // Size: 0x30
    function set_showskipbutton(localclientnum, value) {
        set_data(localclientnum, "showSkipButton", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 1, eflags: 0x0
    // Checksum 0xc45c612e, Offset: 0x4b0
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"cp_skip_scene_menu");
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 1, eflags: 0x0
    // Checksum 0x3ff877d3, Offset: 0x410
    // Size: 0x94
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "showSkipButton", 0);
        set_data(localclientnum, "hostIsSkipping", 0);
        set_data(localclientnum, "votedToSkip", 0);
        set_data(localclientnum, "sceneSkipEndTime", 0);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 1, eflags: 0x0
    // Checksum 0x83f6f32d, Offset: 0x3e0
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 5, eflags: 0x0
    // Checksum 0x680d4a0b, Offset: 0x2f0
    // Size: 0xe4
    function setup_clientfields(uid, var_68837b6a, var_97bafd93, var_4fed2538, var_911972bb) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("showSkipButton", 1, 2, "int", var_68837b6a);
        cluielem::add_clientfield("hostIsSkipping", 1, 1, "int", var_97bafd93);
        cluielem::add_clientfield("votedToSkip", 1, 1, "int", var_4fed2538);
        cluielem::add_clientfield("sceneSkipEndTime", 1, 3, "int", var_911972bb);
    }

}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 5, eflags: 0x0
// Checksum 0xc4769e6c, Offset: 0xd8
// Size: 0x70
function register(uid, var_68837b6a, var_97bafd93, var_4fed2538, var_911972bb) {
    elem = new ccp_skip_scene_menu();
    [[ elem ]]->setup_clientfields(uid, var_68837b6a, var_97bafd93, var_4fed2538, var_911972bb);
    return elem;
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x0
// Checksum 0x84392db0, Offset: 0x150
// Size: 0x40
function register_clientside(uid) {
    elem = new ccp_skip_scene_menu();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x0
// Checksum 0x4436ac85, Offset: 0x198
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x0
// Checksum 0x294824c7, Offset: 0x1c0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x0
// Checksum 0xc706b918, Offset: 0x1e8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0xad1181a2, Offset: 0x210
// Size: 0x28
function set_showskipbutton(localclientnum, value) {
    [[ self ]]->set_showskipbutton(localclientnum, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0xeb054d37, Offset: 0x240
// Size: 0x28
function set_hostisskipping(localclientnum, value) {
    [[ self ]]->set_hostisskipping(localclientnum, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0xcff5d52d, Offset: 0x270
// Size: 0x28
function set_votedtoskip(localclientnum, value) {
    [[ self ]]->set_votedtoskip(localclientnum, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0xb6db828f, Offset: 0x2a0
// Size: 0x28
function set_sceneskipendtime(localclientnum, value) {
    [[ self ]]->set_sceneskipendtime(localclientnum, value);
}

