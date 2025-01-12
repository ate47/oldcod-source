#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace mp_laststand_client;

// Namespace mp_laststand_client
// Method(s) 7 Total 14
class cmp_laststand_client : cluielem {

    var var_57a3d576;

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0x8a379d23, Offset: 0x378
    // Size: 0x3c
    function set_revive_progress(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "revive_progress", value);
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0x99d2ca8d, Offset: 0x330
    // Size: 0x3c
    function set_bleedout_progress(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "bleedout_progress", value);
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 1, eflags: 0x0
    // Checksum 0xc0ce7dcd, Offset: 0x300
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0xfab7cc0d, Offset: 0x2b0
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "mp_laststand_client", persistent);
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 1, eflags: 0x0
    // Checksum 0x77e9ed0f, Offset: 0x230
    // Size: 0x74
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("bleedout_progress", 1, 6, "float");
        cluielem::add_clientfield("revive_progress", 1, 5, "float");
    }

}

// Namespace mp_laststand_client/mp_laststand_client
// Params 1, eflags: 0x0
// Checksum 0xafb674ea, Offset: 0xd8
// Size: 0x40
function register(uid) {
    elem = new cmp_laststand_client();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 2, eflags: 0x0
// Checksum 0x855badbc, Offset: 0x120
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 1, eflags: 0x0
// Checksum 0xe5537b88, Offset: 0x160
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 1, eflags: 0x0
// Checksum 0x82ac46dc, Offset: 0x188
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 2, eflags: 0x0
// Checksum 0x57d6de1f, Offset: 0x1b0
// Size: 0x28
function set_bleedout_progress(player, value) {
    [[ self ]]->set_bleedout_progress(player, value);
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 2, eflags: 0x0
// Checksum 0x348cae05, Offset: 0x1e0
// Size: 0x28
function set_revive_progress(player, value) {
    [[ self ]]->set_revive_progress(player, value);
}

