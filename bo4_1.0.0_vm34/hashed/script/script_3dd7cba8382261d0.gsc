#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_arcade_keys;

// Namespace zm_arcade_keys
// Method(s) 6 Total 13
class czm_arcade_keys : cluielem {

    var var_57a3d576;

    // Namespace czm_arcade_keys/zm_arcade_keys
    // Params 2, eflags: 0x0
    // Checksum 0x9485563e, Offset: 0x2c0
    // Size: 0x3c
    function set_key_count(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "key_count", value);
    }

    // Namespace czm_arcade_keys/zm_arcade_keys
    // Params 1, eflags: 0x0
    // Checksum 0x605b5bc3, Offset: 0x290
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_arcade_keys/zm_arcade_keys
    // Params 2, eflags: 0x0
    // Checksum 0x5a678664, Offset: 0x240
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_arcade_keys", persistent);
    }

    // Namespace czm_arcade_keys/zm_arcade_keys
    // Params 1, eflags: 0x0
    // Checksum 0xe679896, Offset: 0x1e8
    // Size: 0x4c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("key_count", 1, 4, "int");
    }

}

// Namespace zm_arcade_keys/zm_arcade_keys
// Params 1, eflags: 0x0
// Checksum 0x50bd214c, Offset: 0xc0
// Size: 0x40
function register(uid) {
    elem = new czm_arcade_keys();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_arcade_keys/zm_arcade_keys
// Params 2, eflags: 0x0
// Checksum 0x42e80ca9, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_arcade_keys/zm_arcade_keys
// Params 1, eflags: 0x0
// Checksum 0xe289aaa1, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_arcade_keys/zm_arcade_keys
// Params 1, eflags: 0x0
// Checksum 0x299a9e76, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_arcade_keys/zm_arcade_keys
// Params 2, eflags: 0x0
// Checksum 0xfe8cd366, Offset: 0x198
// Size: 0x28
function set_key_count(player, value) {
    [[ self ]]->set_key_count(player, value);
}

