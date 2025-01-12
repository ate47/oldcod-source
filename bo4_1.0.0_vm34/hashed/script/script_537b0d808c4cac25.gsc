#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace self_revive_visuals_rush;

// Namespace self_revive_visuals_rush
// Method(s) 6 Total 13
class cself_revive_visuals_rush : cluielem {

    var var_57a3d576;

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 2, eflags: 0x0
    // Checksum 0x4b5d43f3, Offset: 0x2c8
    // Size: 0x3c
    function set_revive_time(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "revive_time", value);
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 1, eflags: 0x0
    // Checksum 0x3d952b0a, Offset: 0x298
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 2, eflags: 0x0
    // Checksum 0x23539301, Offset: 0x248
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "self_revive_visuals_rush", persistent);
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 1, eflags: 0x0
    // Checksum 0x25b63a2d, Offset: 0x1f0
    // Size: 0x4c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("revive_time", 1, 4, "int");
    }

}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 1, eflags: 0x0
// Checksum 0xe4ee34de, Offset: 0xc8
// Size: 0x40
function register(uid) {
    elem = new cself_revive_visuals_rush();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 2, eflags: 0x0
// Checksum 0x59c42807, Offset: 0x110
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 1, eflags: 0x0
// Checksum 0x15a89ff3, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 1, eflags: 0x0
// Checksum 0xc3c5bf96, Offset: 0x178
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 2, eflags: 0x0
// Checksum 0xa4b50d85, Offset: 0x1a0
// Size: 0x28
function set_revive_time(player, value) {
    [[ self ]]->set_revive_time(player, value);
}

