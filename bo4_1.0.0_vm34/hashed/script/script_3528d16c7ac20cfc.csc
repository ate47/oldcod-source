#using scripts\core_common\lui_shared;

#namespace mp_laststand_client;

// Namespace mp_laststand_client
// Method(s) 8 Total 14
class cmp_laststand_client : cluielem {

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0x3fdc84a5, Offset: 0x408
    // Size: 0x30
    function set_revive_progress(localclientnum, value) {
        set_data(localclientnum, "revive_progress", value);
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0xdb4d085e, Offset: 0x3d0
    // Size: 0x30
    function set_bleedout_progress(localclientnum, value) {
        set_data(localclientnum, "bleedout_progress", value);
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 1, eflags: 0x0
    // Checksum 0x5f0a8dbe, Offset: 0x398
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"mp_laststand_client");
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 1, eflags: 0x0
    // Checksum 0xec89392a, Offset: 0x320
    // Size: 0x6c
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "bleedout_progress", 0);
        set_data(localclientnum, "revive_progress", 0);
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 1, eflags: 0x0
    // Checksum 0xa47546b0, Offset: 0x2f0
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cmp_laststand_client/mp_laststand_client
    // Params 3, eflags: 0x0
    // Checksum 0x8d763444, Offset: 0x260
    // Size: 0x84
    function setup_clientfields(uid, var_466bcfc, var_f45e8d0d) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("bleedout_progress", 1, 6, "float", var_466bcfc);
        cluielem::add_clientfield("revive_progress", 1, 5, "float", var_f45e8d0d);
    }

}

// Namespace mp_laststand_client/mp_laststand_client
// Params 3, eflags: 0x0
// Checksum 0x989d036a, Offset: 0xc0
// Size: 0x58
function register(uid, var_466bcfc, var_f45e8d0d) {
    elem = new cmp_laststand_client();
    [[ elem ]]->setup_clientfields(uid, var_466bcfc, var_f45e8d0d);
    return elem;
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 1, eflags: 0x0
// Checksum 0x4c22e07d, Offset: 0x120
// Size: 0x40
function register_clientside(uid) {
    elem = new cmp_laststand_client();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 1, eflags: 0x0
// Checksum 0xcb9fe38e, Offset: 0x168
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 1, eflags: 0x0
// Checksum 0xa52921f4, Offset: 0x190
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 1, eflags: 0x0
// Checksum 0x5e1d9a13, Offset: 0x1b8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 2, eflags: 0x0
// Checksum 0xe44d2c21, Offset: 0x1e0
// Size: 0x28
function set_bleedout_progress(localclientnum, value) {
    [[ self ]]->set_bleedout_progress(localclientnum, value);
}

// Namespace mp_laststand_client/mp_laststand_client
// Params 2, eflags: 0x0
// Checksum 0x99c966de, Offset: 0x210
// Size: 0x28
function set_revive_progress(localclientnum, value) {
    [[ self ]]->set_revive_progress(localclientnum, value);
}

