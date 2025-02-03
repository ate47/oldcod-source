#using scripts\core_common\lui_shared;

#namespace zm_laststand_client;

// Namespace zm_laststand_client
// Method(s) 9 Total 16
class czm_laststand_client : cluielem {

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 1, eflags: 0x0
    // Checksum 0x35cb7e16, Offset: 0x568
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 0, eflags: 0x0
    // Checksum 0x44ee1933, Offset: 0x4b0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("zm_laststand_client");
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0x54f4ca5d, Offset: 0x608
    // Size: 0x30
    function set_num_downs(localclientnum, value) {
        set_data(localclientnum, "num_downs", value);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0xb661701d, Offset: 0x598
    // Size: 0x30
    function set_bleedout_progress(localclientnum, value) {
        set_data(localclientnum, "bleedout_progress", value);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 3, eflags: 0x0
    // Checksum 0x6a70878c, Offset: 0x3f8
    // Size: 0xac
    function setup_clientfields(var_a9a4e140, var_e97e7153, var_5db69c99) {
        cluielem::setup_clientfields("zm_laststand_client");
        cluielem::add_clientfield("bleedout_progress", 1, 8, "float", var_a9a4e140);
        cluielem::add_clientfield("revive_progress", 1, 8, "float", var_e97e7153);
        cluielem::add_clientfield("num_downs", 1, 8, "int", var_5db69c99);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0x80a587c6, Offset: 0x5d0
    // Size: 0x30
    function set_revive_progress(localclientnum, value) {
        set_data(localclientnum, "revive_progress", value);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 1, eflags: 0x0
    // Checksum 0x54a7e8da, Offset: 0x4d8
    // Size: 0x88
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "bleedout_progress", 0);
        set_data(localclientnum, "revive_progress", 0);
        set_data(localclientnum, "num_downs", 0);
    }

}

// Namespace zm_laststand_client/zm_laststand_client
// Params 3, eflags: 0x0
// Checksum 0x536782d1, Offset: 0xf8
// Size: 0x18e
function register(var_a9a4e140, var_e97e7153, var_5db69c99) {
    elem = new czm_laststand_client();
    [[ elem ]]->setup_clientfields(var_a9a4e140, var_e97e7153, var_5db69c99);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"zm_laststand_client"])) {
        level.var_ae746e8f[#"zm_laststand_client"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"zm_laststand_client"])) {
        level.var_ae746e8f[#"zm_laststand_client"] = [];
    } else if (!isarray(level.var_ae746e8f[#"zm_laststand_client"])) {
        level.var_ae746e8f[#"zm_laststand_client"] = array(level.var_ae746e8f[#"zm_laststand_client"]);
    }
    level.var_ae746e8f[#"zm_laststand_client"][level.var_ae746e8f[#"zm_laststand_client"].size] = elem;
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 0, eflags: 0x0
// Checksum 0x8570d984, Offset: 0x290
// Size: 0x34
function register_clientside() {
    elem = new czm_laststand_client();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0xfbf2478f, Offset: 0x2d0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0xba6ba8c4, Offset: 0x2f8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0x1cfb2858, Offset: 0x320
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0xd0476509, Offset: 0x348
// Size: 0x28
function set_bleedout_progress(localclientnum, value) {
    [[ self ]]->set_bleedout_progress(localclientnum, value);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0xeb751aa1, Offset: 0x378
// Size: 0x28
function set_revive_progress(localclientnum, value) {
    [[ self ]]->set_revive_progress(localclientnum, value);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0xe7430d40, Offset: 0x3a8
// Size: 0x28
function set_num_downs(localclientnum, value) {
    [[ self ]]->set_num_downs(localclientnum, value);
}

