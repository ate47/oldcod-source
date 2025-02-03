#using scripts\core_common\lui_shared;

#namespace initial_black;

// Namespace initial_black
// Method(s) 7 Total 14
class cinitial_black : cluielem {

    // Namespace cinitial_black/initial_black
    // Params 1, eflags: 0x0
    // Checksum 0x92de379a, Offset: 0x410
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cinitial_black/initial_black
    // Params 2, eflags: 0x0
    // Checksum 0x5a14422e, Offset: 0x440
    // Size: 0x30
    function function_2eb3f6e8(localclientnum, value) {
        set_data(localclientnum, "developer_mode", value);
    }

    // Namespace cinitial_black/initial_black
    // Params 0, eflags: 0x0
    // Checksum 0x1fa01a1d, Offset: 0x3a0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("initial_black");
    }

    // Namespace cinitial_black/initial_black
    // Params 1, eflags: 0x0
    // Checksum 0x81d8537a, Offset: 0x348
    // Size: 0x4c
    function setup_clientfields(var_e303eae1) {
        cluielem::setup_clientfields("initial_black");
        cluielem::add_clientfield("developer_mode", 1, 1, "int", var_e303eae1);
    }

    // Namespace cinitial_black/initial_black
    // Params 1, eflags: 0x0
    // Checksum 0x61e21380, Offset: 0x3c8
    // Size: 0x40
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "developer_mode", 0);
    }

}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x0
// Checksum 0x907029ef, Offset: 0xc0
// Size: 0x176
function register(var_e303eae1) {
    elem = new cinitial_black();
    [[ elem ]]->setup_clientfields(var_e303eae1);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"initial_black"])) {
        level.var_ae746e8f[#"initial_black"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"initial_black"])) {
        level.var_ae746e8f[#"initial_black"] = [];
    } else if (!isarray(level.var_ae746e8f[#"initial_black"])) {
        level.var_ae746e8f[#"initial_black"] = array(level.var_ae746e8f[#"initial_black"]);
    }
    level.var_ae746e8f[#"initial_black"][level.var_ae746e8f[#"initial_black"].size] = elem;
}

// Namespace initial_black/initial_black
// Params 0, eflags: 0x0
// Checksum 0xeb983c97, Offset: 0x240
// Size: 0x34
function register_clientside() {
    elem = new cinitial_black();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x0
// Checksum 0x1dc1f992, Offset: 0x280
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x0
// Checksum 0xf61c59a2, Offset: 0x2a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x0
// Checksum 0x65611201, Offset: 0x2d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace initial_black/initial_black
// Params 2, eflags: 0x0
// Checksum 0xdbcd8c, Offset: 0x2f8
// Size: 0x28
function function_2eb3f6e8(localclientnum, value) {
    [[ self ]]->function_2eb3f6e8(localclientnum, value);
}

