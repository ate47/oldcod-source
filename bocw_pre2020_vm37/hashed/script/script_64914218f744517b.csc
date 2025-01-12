#using scripts\core_common\lui_shared;

#namespace cp_skip_scene_menu;

// Namespace cp_skip_scene_menu
// Method(s) 10 Total 16
class ccp_skip_scene_menu : cluielem {

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0x63156e98, Offset: 0x5e8
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5cf1d6b1, Offset: 0x650
    // Size: 0x30
    function set_hostisskipping(localclientnum, value) {
        set_data(localclientnum, "hostIsSkipping", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 0, eflags: 0x1 linked
    // Checksum 0x57046bc, Offset: 0x520
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("cp_skip_scene_menu");
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb270199c, Offset: 0x688
    // Size: 0x30
    function set_votedtoskip(localclientnum, value) {
        set_data(localclientnum, "votedToSkip", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0x51cfd6d1, Offset: 0x618
    // Size: 0x30
    function set_showskipbutton(localclientnum, value) {
        set_data(localclientnum, "showSkipButton", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 4, eflags: 0x1 linked
    // Checksum 0x1ecb33ac, Offset: 0x438
    // Size: 0xdc
    function setup_clientfields(var_792f3702, var_69bfc3be, var_b2a12719, var_266fe805) {
        cluielem::setup_clientfields("cp_skip_scene_menu");
        cluielem::add_clientfield("showSkipButton", 1, 2, "int", var_792f3702);
        cluielem::add_clientfield("hostIsSkipping", 1, 1, "int", var_69bfc3be);
        cluielem::add_clientfield("votedToSkip", 1, 1, "int", var_b2a12719);
        cluielem::add_clientfield("sceneSkipEndTime", 1, 3, "int", var_266fe805);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5dd565d, Offset: 0x6c0
    // Size: 0x30
    function set_sceneskipendtime(localclientnum, value) {
        set_data(localclientnum, "sceneSkipEndTime", value);
    }

    // Namespace ccp_skip_scene_menu/cp_skip_scene_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1ac78921, Offset: 0x548
    // Size: 0x94
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "showSkipButton", 0);
        set_data(localclientnum, "hostIsSkipping", 0);
        set_data(localclientnum, "votedToSkip", 0);
        set_data(localclientnum, "sceneSkipEndTime", 0);
    }

}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 4, eflags: 0x1 linked
// Checksum 0xb09bf84e, Offset: 0x100
// Size: 0x196
function register(var_792f3702, var_69bfc3be, var_b2a12719, var_266fe805) {
    elem = new ccp_skip_scene_menu();
    [[ elem ]]->setup_clientfields(var_792f3702, var_69bfc3be, var_b2a12719, var_266fe805);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"cp_skip_scene_menu"])) {
        level.var_ae746e8f[#"cp_skip_scene_menu"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"cp_skip_scene_menu"])) {
        level.var_ae746e8f[#"cp_skip_scene_menu"] = [];
    } else if (!isarray(level.var_ae746e8f[#"cp_skip_scene_menu"])) {
        level.var_ae746e8f[#"cp_skip_scene_menu"] = array(level.var_ae746e8f[#"cp_skip_scene_menu"]);
    }
    level.var_ae746e8f[#"cp_skip_scene_menu"][level.var_ae746e8f[#"cp_skip_scene_menu"].size] = elem;
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 0, eflags: 0x0
// Checksum 0xdc40169c, Offset: 0x2a0
// Size: 0x34
function register_clientside() {
    elem = new ccp_skip_scene_menu();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x0
// Checksum 0xebc8a1c7, Offset: 0x2e0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x0
// Checksum 0x3f5f2cb3, Offset: 0x308
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 1, eflags: 0x0
// Checksum 0xa377506b, Offset: 0x330
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0x41ad9ead, Offset: 0x358
// Size: 0x28
function set_showskipbutton(localclientnum, value) {
    [[ self ]]->set_showskipbutton(localclientnum, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0x4e95f9e, Offset: 0x388
// Size: 0x28
function set_hostisskipping(localclientnum, value) {
    [[ self ]]->set_hostisskipping(localclientnum, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0x5cdce604, Offset: 0x3b8
// Size: 0x28
function set_votedtoskip(localclientnum, value) {
    [[ self ]]->set_votedtoskip(localclientnum, value);
}

// Namespace cp_skip_scene_menu/cp_skip_scene_menu
// Params 2, eflags: 0x0
// Checksum 0x73f32aea, Offset: 0x3e8
// Size: 0x28
function set_sceneskipendtime(localclientnum, value) {
    [[ self ]]->set_sceneskipendtime(localclientnum, value);
}

