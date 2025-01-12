#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_laststand_client;

// Namespace zm_laststand_client
// Method(s) 7 Total 14
class czm_laststand_client : cluielem {

    var var_57a3d576;

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0xdb083a74, Offset: 0x378
    // Size: 0x3c
    function set_revive_progress(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "revive_progress", value);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0xba103dda, Offset: 0x330
    // Size: 0x3c
    function set_bleedout_progress(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "bleedout_progress", value);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 1, eflags: 0x0
    // Checksum 0xb5319efd, Offset: 0x300
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0xa2983b39, Offset: 0x2b0
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_laststand_client", persistent);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 1, eflags: 0x0
    // Checksum 0x2de33bd3, Offset: 0x230
    // Size: 0x74
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("bleedout_progress", 1, 6, "float");
        cluielem::add_clientfield("revive_progress", 1, 5, "float");
    }

}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0xf7962475, Offset: 0xd8
// Size: 0x40
function register(uid) {
    elem = new czm_laststand_client();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0x410db1fe, Offset: 0x120
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0x4ba601be, Offset: 0x160
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0x4823501f, Offset: 0x188
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0xf061c07c, Offset: 0x1b0
// Size: 0x28
function set_bleedout_progress(player, value) {
    [[ self ]]->set_bleedout_progress(player, value);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0x9f60c396, Offset: 0x1e0
// Size: 0x28
function set_revive_progress(player, value) {
    [[ self ]]->set_revive_progress(player, value);
}

