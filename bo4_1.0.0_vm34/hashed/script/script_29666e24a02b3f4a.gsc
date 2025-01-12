#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_towers_challenges_hud;

// Namespace zm_towers_challenges_hud
// Method(s) 9 Total 16
class czm_towers_challenges_hud : cluielem {

    var var_57a3d576;

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 2, eflags: 0x0
    // Checksum 0x7fa43417, Offset: 0x5a0
    // Size: 0x3c
    function set_required_goal(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "required_goal", value);
    }

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 2, eflags: 0x0
    // Checksum 0xe182edf4, Offset: 0x558
    // Size: 0x3c
    function set_challenge_text(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "challenge_text", value);
    }

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 2, eflags: 0x0
    // Checksum 0x20cbe189, Offset: 0x510
    // Size: 0x3c
    function set_progress(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "progress", value);
    }

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 2, eflags: 0x0
    // Checksum 0x232d5, Offset: 0x448
    // Size: 0xbc
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 0);
            return;
        }
        if (#"hidden" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 1);
            return;
        }
        assertmsg("<dev string:x30>");
    }

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 1, eflags: 0x0
    // Checksum 0x325ba204, Offset: 0x418
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 2, eflags: 0x0
    // Checksum 0x1509df39, Offset: 0x3c8
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_towers_challenges_hud", persistent);
    }

    // Namespace czm_towers_challenges_hud/zm_towers_challenges_hud
    // Params 1, eflags: 0x0
    // Checksum 0x8e75ee34, Offset: 0x2f8
    // Size: 0xc4
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::add_clientfield("progress", 1, 7, "int");
        cluielem::function_52818084("string", "challenge_text", 1);
        cluielem::add_clientfield("required_goal", 1, 7, "int");
    }

}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0x9758f354, Offset: 0xf0
// Size: 0x44
function set_challenge_progress(player, value) {
    value = int(value * 100);
    [[ self ]]->set_progress(player, value);
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 1, eflags: 0x0
// Checksum 0xba8a2d0e, Offset: 0x140
// Size: 0x40
function register(uid) {
    elem = new czm_towers_challenges_hud();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0xe76d07f3, Offset: 0x188
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 1, eflags: 0x0
// Checksum 0xcc6734a0, Offset: 0x1c8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 1, eflags: 0x0
// Checksum 0x66780a63, Offset: 0x1f0
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0xc9dcd44d, Offset: 0x218
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0xc55889b6, Offset: 0x248
// Size: 0x28
function set_progress(player, value) {
    [[ self ]]->set_progress(player, value);
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0x32041595, Offset: 0x278
// Size: 0x28
function set_challenge_text(player, value) {
    [[ self ]]->set_challenge_text(player, value);
}

// Namespace zm_towers_challenges_hud/zm_towers_challenges_hud
// Params 2, eflags: 0x0
// Checksum 0xec705339, Offset: 0x2a8
// Size: 0x28
function set_required_goal(player, value) {
    [[ self ]]->set_required_goal(player, value);
}

