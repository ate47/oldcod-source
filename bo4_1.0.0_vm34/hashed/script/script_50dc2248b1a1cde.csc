#using scripts\core_common\lui_shared;

#namespace zm_towers_challenges_hud;

// Namespace zm_towers_challenges_hud
// Method(s) 10 Total 16
class czm_towers_challenges_hud : cluielem {

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 2, eflags: 0x0
    // Checksum 0xebcc196d, Offset: 0x608
    // Size: 0x30
    function set_required_goal(localclientnum, value) {
        set_data(localclientnum, "required_goal", value);
    }

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 2, eflags: 0x0
    // Checksum 0xdb9bae89, Offset: 0x5d0
    // Size: 0x30
    function set_challenge_text(localclientnum, value) {
        set_data(localclientnum, "challenge_text", value);
    }

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 2, eflags: 0x0
    // Checksum 0x9e784c6c, Offset: 0x598
    // Size: 0x30
    function set_progress(localclientnum, value) {
        set_data(localclientnum, "progress", value);
    }

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 2, eflags: 0x0
    // Checksum 0xa4624d73, Offset: 0x4e0
    // Size: 0xac
    function set_state(localclientnum, state_name) {
        if (#"defaultstate" == state_name) {
            set_data(localclientnum, "_state", 0);
            return;
        }
        if (#"hidden" == state_name) {
            set_data(localclientnum, "_state", 1);
            return;
        }
        assertmsg("<dev string:x30>");
    }

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 1, eflags: 0x0
    // Checksum 0xcd552c20, Offset: 0x4a8
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_towers_challenges_hud");
    }

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 1, eflags: 0x0
    // Checksum 0x33578449, Offset: 0x3f8
    // Size: 0xa8
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "progress", 0);
        set_data(localclientnum, "challenge_text", #"");
        set_data(localclientnum, "required_goal", 0);
    }

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 1, eflags: 0x0
    // Checksum 0x3504c91, Offset: 0x3c8
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 4, eflags: 0x0
    // Checksum 0x7a303749, Offset: 0x2e0
    // Size: 0xdc
    function setup_clientfields(uid, progresscallback, var_bbd72b6b, var_d2a439c1) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::add_clientfield("progress", 1, 7, "int", progresscallback);
        cluielem::function_52818084("string", "challenge_text", 1);
        cluielem::add_clientfield("required_goal", 1, 7, "int", var_d2a439c1);
    }

}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 4, eflags: 0x0
// Checksum 0x3efe0688, Offset: 0xd0
// Size: 0x64
function register(uid, progresscallback, var_bbd72b6b, var_d2a439c1) {
    elem = new czm_towers_challenges_hud();
    [[ elem ]]->setup_clientfields(uid, progresscallback, var_bbd72b6b, var_d2a439c1);
    return elem;
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 1, eflags: 0x0
// Checksum 0x7f609df5, Offset: 0x140
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_towers_challenges_hud();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 1, eflags: 0x0
// Checksum 0x507de99a, Offset: 0x188
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 1, eflags: 0x0
// Checksum 0xb09f0b4d, Offset: 0x1b0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 1, eflags: 0x0
// Checksum 0xf10d439a, Offset: 0x1d8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0xfe5a33f8, Offset: 0x200
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0xa7909382, Offset: 0x230
// Size: 0x28
function set_progress(localclientnum, value) {
    [[ self ]]->set_progress(localclientnum, value);
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0x6e29a869, Offset: 0x260
// Size: 0x28
function set_challenge_text(localclientnum, value) {
    [[ self ]]->set_challenge_text(localclientnum, value);
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0xb527ed53, Offset: 0x290
// Size: 0x28
function set_required_goal(localclientnum, value) {
    [[ self ]]->set_required_goal(localclientnum, value);
}

