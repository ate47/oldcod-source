#using scripts\core_common\lui_shared;

#namespace zm_arcade_keys;

// Namespace zm_arcade_keys
// Method(s) 7 Total 13
class czm_arcade_keys : cluielem {

    // Namespace czm_arcade_keys/zm_arcade_keys
    // Params 2, eflags: 0x0
    // Checksum 0xb9ce30e1, Offset: 0x320
    // Size: 0x30
    function set_key_count(localclientnum, value) {
        set_data(localclientnum, "key_count", value);
    }

    // Namespace czm_arcade_keys/zm_arcade_keys
    // Params 1, eflags: 0x0
    // Checksum 0xea464c7f, Offset: 0x2e8
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_arcade_keys");
    }

    // Namespace czm_arcade_keys/zm_arcade_keys
    // Params 1, eflags: 0x0
    // Checksum 0x4adb3dba, Offset: 0x2a0
    // Size: 0x40
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "key_count", 0);
    }

    // Namespace czm_arcade_keys/zm_arcade_keys
    // Params 1, eflags: 0x0
    // Checksum 0xf7b68ece, Offset: 0x270
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_arcade_keys/zm_arcade_keys
    // Params 2, eflags: 0x0
    // Checksum 0x1c47bf0f, Offset: 0x210
    // Size: 0x54
    function setup_clientfields(uid, var_68328047) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("key_count", 1, 4, "int", var_68328047);
    }

}

// Namespace zm_arcade_keys/zm_arcade_keys
// Params 2, eflags: 0x0
// Checksum 0xaee1b401, Offset: 0xa8
// Size: 0x4c
function register(uid, var_68328047) {
    elem = new czm_arcade_keys();
    [[ elem ]]->setup_clientfields(uid, var_68328047);
    return elem;
}

// Namespace zm_arcade_keys/zm_arcade_keys
// Params 1, eflags: 0x0
// Checksum 0x4054f767, Offset: 0x100
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_arcade_keys();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_arcade_keys/zm_arcade_keys
// Params 1, eflags: 0x0
// Checksum 0x8e63c27, Offset: 0x148
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_arcade_keys/zm_arcade_keys
// Params 1, eflags: 0x0
// Checksum 0xfaa05a52, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_arcade_keys/zm_arcade_keys
// Params 1, eflags: 0x0
// Checksum 0x1757cd6c, Offset: 0x198
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_arcade_keys/zm_arcade_keys
// Params 2, eflags: 0x0
// Checksum 0x471c9379, Offset: 0x1c0
// Size: 0x28
function set_key_count(localclientnum, value) {
    [[ self ]]->set_key_count(localclientnum, value);
}

