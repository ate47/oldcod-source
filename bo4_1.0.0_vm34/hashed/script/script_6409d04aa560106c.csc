#using scripts\core_common\lui_shared;

#namespace zm_laststand_client;

// Namespace zm_laststand_client
// Method(s) 8 Total 14
class czm_laststand_client : cluielem {

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0x90a95b52, Offset: 0x408
    // Size: 0x30
    function set_revive_progress(localclientnum, value) {
        set_data(localclientnum, "revive_progress", value);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0x57c31e35, Offset: 0x3d0
    // Size: 0x30
    function set_bleedout_progress(localclientnum, value) {
        set_data(localclientnum, "bleedout_progress", value);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 1, eflags: 0x0
    // Checksum 0xf936374a, Offset: 0x398
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_laststand_client");
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 1, eflags: 0x0
    // Checksum 0xf5814f32, Offset: 0x320
    // Size: 0x6c
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "bleedout_progress", 0);
        set_data(localclientnum, "revive_progress", 0);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 1, eflags: 0x0
    // Checksum 0x161eeb78, Offset: 0x2f0
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 3, eflags: 0x0
    // Checksum 0x51e4dfac, Offset: 0x260
    // Size: 0x84
    function setup_clientfields(uid, var_466bcfc, var_f45e8d0d) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("bleedout_progress", 1, 6, "float", var_466bcfc);
        cluielem::add_clientfield("revive_progress", 1, 5, "float", var_f45e8d0d);
    }

}

// Namespace zm_laststand_client/zm_laststand_client
// Params 3, eflags: 0x0
// Checksum 0xffbb8597, Offset: 0xc0
// Size: 0x58
function register(uid, var_466bcfc, var_f45e8d0d) {
    elem = new czm_laststand_client();
    [[ elem ]]->setup_clientfields(uid, var_466bcfc, var_f45e8d0d);
    return elem;
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0x42717145, Offset: 0x120
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_laststand_client();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0xe4f74ec8, Offset: 0x168
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0xf85059ae, Offset: 0x190
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0xca381ae7, Offset: 0x1b8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0x69b21c5, Offset: 0x1e0
// Size: 0x28
function set_bleedout_progress(localclientnum, value) {
    [[ self ]]->set_bleedout_progress(localclientnum, value);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0x959c0035, Offset: 0x210
// Size: 0x28
function set_revive_progress(localclientnum, value) {
    [[ self ]]->set_revive_progress(localclientnum, value);
}

