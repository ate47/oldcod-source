#using scripts\core_common\lui_shared;

#namespace zm_location;

// Namespace zm_location
// Method(s) 7 Total 13
class czm_location : cluielem {

    // Namespace czm_location/zm_location
    // Params 2, eflags: 0x0
    // Checksum 0x1d13ac04, Offset: 0x338
    // Size: 0x30
    function set_location_name(localclientnum, value) {
        set_data(localclientnum, "location_name", value);
    }

    // Namespace czm_location/zm_location
    // Params 1, eflags: 0x0
    // Checksum 0x169cb58, Offset: 0x300
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_location");
    }

    // Namespace czm_location/zm_location
    // Params 1, eflags: 0x0
    // Checksum 0x3fb61b10, Offset: 0x2a8
    // Size: 0x4c
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "location_name", #"");
    }

    // Namespace czm_location/zm_location
    // Params 1, eflags: 0x0
    // Checksum 0x5cc4f505, Offset: 0x278
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_location/zm_location
    // Params 2, eflags: 0x0
    // Checksum 0x44ba9f02, Offset: 0x218
    // Size: 0x54
    function setup_clientfields(uid, var_2bfeb62b) {
        cluielem::setup_clientfields(uid);
        cluielem::function_52818084("string", "location_name", 1);
    }

}

// Namespace zm_location/zm_location
// Params 2, eflags: 0x0
// Checksum 0x360483e0, Offset: 0xb0
// Size: 0x4c
function register(uid, var_2bfeb62b) {
    elem = new czm_location();
    [[ elem ]]->setup_clientfields(uid, var_2bfeb62b);
    return elem;
}

// Namespace zm_location/zm_location
// Params 1, eflags: 0x0
// Checksum 0xf5d956df, Offset: 0x108
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_location();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_location/zm_location
// Params 1, eflags: 0x0
// Checksum 0xabc3f36e, Offset: 0x150
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_location/zm_location
// Params 1, eflags: 0x0
// Checksum 0x36491ec4, Offset: 0x178
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_location/zm_location
// Params 1, eflags: 0x0
// Checksum 0x252ef65f, Offset: 0x1a0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_location/zm_location
// Params 2, eflags: 0x0
// Checksum 0xea630b5c, Offset: 0x1c8
// Size: 0x28
function set_location_name(localclientnum, value) {
    [[ self ]]->set_location_name(localclientnum, value);
}

