#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_location;

// Namespace zm_location
// Method(s) 6 Total 13
class czm_location : cluielem {

    var var_57a3d576;

    // Namespace czm_location/zm_location
    // Params 2, eflags: 0x0
    // Checksum 0x5c3858aa, Offset: 0x2c0
    // Size: 0x3c
    function set_location_name(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "location_name", value);
    }

    // Namespace czm_location/zm_location
    // Params 1, eflags: 0x0
    // Checksum 0xa4d095a6, Offset: 0x290
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_location/zm_location
    // Params 2, eflags: 0x0
    // Checksum 0x535c0021, Offset: 0x240
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_location", persistent);
    }

    // Namespace czm_location/zm_location
    // Params 1, eflags: 0x0
    // Checksum 0x7815bb2e, Offset: 0x1e8
    // Size: 0x4c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::function_52818084("string", "location_name", 1);
    }

}

// Namespace zm_location/zm_location
// Params 1, eflags: 0x0
// Checksum 0x6c0f4974, Offset: 0xc0
// Size: 0x40
function register(uid) {
    elem = new czm_location();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_location/zm_location
// Params 2, eflags: 0x0
// Checksum 0x17b31c19, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_location/zm_location
// Params 1, eflags: 0x0
// Checksum 0xec57f3b5, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_location/zm_location
// Params 1, eflags: 0x0
// Checksum 0xe82ee129, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_location/zm_location
// Params 2, eflags: 0x0
// Checksum 0x6b103411, Offset: 0x198
// Size: 0x28
function set_location_name(player, value) {
    [[ self ]]->set_location_name(player, value);
}

