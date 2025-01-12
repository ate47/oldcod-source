#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_location;

// Namespace zm_location
// Method(s) 6 Total 13
class czm_location : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace czm_location/zm_location
    // Params 2, eflags: 0x1 linked
    // Checksum 0x9f97df77, Offset: 0x238
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace czm_location/zm_location
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf982f2f5, Offset: 0x280
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_location/zm_location
    // Params 0, eflags: 0x1 linked
    // Checksum 0x83763104, Offset: 0x1e8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("zm_location");
        cluielem::function_dcb34c80("string", "location_name", 1);
    }

    // Namespace czm_location/zm_location
    // Params 2, eflags: 0x1 linked
    // Checksum 0x8af27c02, Offset: 0x2b0
    // Size: 0x44
    function set_location_name(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "location_name", value);
    }

}

// Namespace zm_location/zm_location
// Params 0, eflags: 0x1 linked
// Checksum 0x412b0426, Offset: 0xc8
// Size: 0x34
function register() {
    elem = new czm_location();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace zm_location/zm_location
// Params 2, eflags: 0x1 linked
// Checksum 0xab93d0f6, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_location/zm_location
// Params 1, eflags: 0x1 linked
// Checksum 0x2f3c9e91, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_location/zm_location
// Params 1, eflags: 0x1 linked
// Checksum 0x54a16eec, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace zm_location/zm_location
// Params 2, eflags: 0x1 linked
// Checksum 0x8a746bcb, Offset: 0x198
// Size: 0x28
function set_location_name(player, value) {
    [[ self ]]->set_location_name(player, value);
}

