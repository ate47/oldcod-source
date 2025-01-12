#using scripts\core_common\lui_shared;

#namespace zm_laststand_client;

// Namespace zm_laststand_client
// Method(s) 9 Total 15
class czm_laststand_client : cluielem {

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1295ec2f, Offset: 0x568
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd2e955a9, Offset: 0x4b0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("zm_laststand_client");
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x1 linked
    // Checksum 0xf0f4dc6d, Offset: 0x608
    // Size: 0x30
    function set_num_downs(localclientnum, value) {
        set_data(localclientnum, "num_downs", value);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x1 linked
    // Checksum 0x91ab8a82, Offset: 0x598
    // Size: 0x30
    function set_bleedout_progress(localclientnum, value) {
        set_data(localclientnum, "bleedout_progress", value);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 3, eflags: 0x1 linked
    // Checksum 0xb904fd96, Offset: 0x3f8
    // Size: 0xac
    function setup_clientfields(var_a9a4e140, var_e97e7153, var_5db69c99) {
        cluielem::setup_clientfields("zm_laststand_client");
        cluielem::add_clientfield("bleedout_progress", 1, 6, "float", var_a9a4e140);
        cluielem::add_clientfield("revive_progress", 1, 5, "float", var_e97e7153);
        cluielem::add_clientfield("num_downs", 1, 8, "int", var_5db69c99);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x1 linked
    // Checksum 0x89c83e47, Offset: 0x5d0
    // Size: 0x30
    function set_revive_progress(localclientnum, value) {
        set_data(localclientnum, "revive_progress", value);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5d9e1062, Offset: 0x4d8
    // Size: 0x88
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "bleedout_progress", 0);
        set_data(localclientnum, "revive_progress", 0);
        set_data(localclientnum, "num_downs", 0);
    }

}

// Namespace zm_laststand_client/zm_laststand_client
// Params 3, eflags: 0x1 linked
// Checksum 0x27b62bb9, Offset: 0xf8
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
// Checksum 0x5b4a20f8, Offset: 0x290
// Size: 0x34
function register_clientside() {
    elem = new czm_laststand_client();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0x395354d9, Offset: 0x2d0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0xfc4683e5, Offset: 0x2f8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0x36c15cfa, Offset: 0x320
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0x981520bb, Offset: 0x348
// Size: 0x28
function set_bleedout_progress(localclientnum, value) {
    [[ self ]]->set_bleedout_progress(localclientnum, value);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0x3d30125d, Offset: 0x378
// Size: 0x28
function set_revive_progress(localclientnum, value) {
    [[ self ]]->set_revive_progress(localclientnum, value);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0x92ec5d76, Offset: 0x3a8
// Size: 0x28
function set_num_downs(localclientnum, value) {
    [[ self ]]->set_num_downs(localclientnum, value);
}

