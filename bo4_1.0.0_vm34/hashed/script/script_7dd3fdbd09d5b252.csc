#using scripts\core_common\lui_shared;

#namespace death_zone;

// Namespace death_zone
// Method(s) 7 Total 13
class cdeath_zone : cluielem {

    // Namespace cdeath_zone/death_zone
    // Params 2, eflags: 0x0
    // Checksum 0xdb98c6d6, Offset: 0x320
    // Size: 0x30
    function set_shutdown_sec(localclientnum, value) {
        set_data(localclientnum, "shutdown_sec", value);
    }

    // Namespace cdeath_zone/death_zone
    // Params 1, eflags: 0x0
    // Checksum 0x1ba25e26, Offset: 0x2e8
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"death_zone");
    }

    // Namespace cdeath_zone/death_zone
    // Params 1, eflags: 0x0
    // Checksum 0x3c100ff9, Offset: 0x2a0
    // Size: 0x40
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "shutdown_sec", 0);
    }

    // Namespace cdeath_zone/death_zone
    // Params 1, eflags: 0x0
    // Checksum 0xd304cfb9, Offset: 0x270
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cdeath_zone/death_zone
    // Params 2, eflags: 0x0
    // Checksum 0x482a4d82, Offset: 0x210
    // Size: 0x54
    function setup_clientfields(uid, var_730d2848) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("shutdown_sec", 1, 9, "int", var_730d2848);
    }

}

// Namespace death_zone/death_zone
// Params 2, eflags: 0x0
// Checksum 0xd7e0f17b, Offset: 0xa8
// Size: 0x4c
function register(uid, var_730d2848) {
    elem = new cdeath_zone();
    [[ elem ]]->setup_clientfields(uid, var_730d2848);
    return elem;
}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0xa5ec3858, Offset: 0x100
// Size: 0x40
function register_clientside(uid) {
    elem = new cdeath_zone();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0x4846c25d, Offset: 0x148
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0x91115445, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0xbc41b40c, Offset: 0x198
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace death_zone/death_zone
// Params 2, eflags: 0x0
// Checksum 0xb8340ca8, Offset: 0x1c0
// Size: 0x28
function set_shutdown_sec(localclientnum, value) {
    [[ self ]]->set_shutdown_sec(localclientnum, value);
}

