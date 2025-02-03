#using scripts\core_common\lui_shared;

#namespace self_respawn;

// Namespace self_respawn
// Method(s) 7 Total 14
class cself_respawn : cluielem {

    // Namespace cself_respawn/self_respawn
    // Params 2, eflags: 0x0
    // Checksum 0x106ecf8, Offset: 0x448
    // Size: 0x30
    function set_percent(localclientnum, value) {
        set_data(localclientnum, "percent", value);
    }

    // Namespace cself_respawn/self_respawn
    // Params 1, eflags: 0x0
    // Checksum 0x62194555, Offset: 0x418
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cself_respawn/self_respawn
    // Params 0, eflags: 0x0
    // Checksum 0x98a9141, Offset: 0x3a0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("self_respawn");
    }

    // Namespace cself_respawn/self_respawn
    // Params 1, eflags: 0x0
    // Checksum 0x83e19e15, Offset: 0x348
    // Size: 0x4c
    function setup_clientfields(var_1089a5f3) {
        cluielem::setup_clientfields("self_respawn");
        cluielem::add_clientfield("percent", 1, 6, "float", var_1089a5f3);
    }

    // Namespace cself_respawn/self_respawn
    // Params 1, eflags: 0x0
    // Checksum 0xd3772c6, Offset: 0x3c8
    // Size: 0x48
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "percent", 0);
    }

}

// Namespace self_respawn/self_respawn
// Params 1, eflags: 0x0
// Checksum 0x6b1ca211, Offset: 0xc0
// Size: 0x176
function register(var_1089a5f3) {
    elem = new cself_respawn();
    [[ elem ]]->setup_clientfields(var_1089a5f3);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"self_respawn"])) {
        level.var_ae746e8f[#"self_respawn"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"self_respawn"])) {
        level.var_ae746e8f[#"self_respawn"] = [];
    } else if (!isarray(level.var_ae746e8f[#"self_respawn"])) {
        level.var_ae746e8f[#"self_respawn"] = array(level.var_ae746e8f[#"self_respawn"]);
    }
    level.var_ae746e8f[#"self_respawn"][level.var_ae746e8f[#"self_respawn"].size] = elem;
}

// Namespace self_respawn/self_respawn
// Params 0, eflags: 0x0
// Checksum 0xd566be8d, Offset: 0x240
// Size: 0x34
function register_clientside() {
    elem = new cself_respawn();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace self_respawn/self_respawn
// Params 1, eflags: 0x0
// Checksum 0x814a5d03, Offset: 0x280
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace self_respawn/self_respawn
// Params 1, eflags: 0x0
// Checksum 0x151387a, Offset: 0x2a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace self_respawn/self_respawn
// Params 1, eflags: 0x0
// Checksum 0x305c9f96, Offset: 0x2d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace self_respawn/self_respawn
// Params 2, eflags: 0x0
// Checksum 0x46a5334, Offset: 0x2f8
// Size: 0x28
function set_percent(localclientnum, value) {
    [[ self ]]->set_percent(localclientnum, value);
}

