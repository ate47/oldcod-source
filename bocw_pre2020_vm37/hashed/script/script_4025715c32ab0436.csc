#using scripts\core_common\lui_shared;

#namespace zm_silver_hud;

// Namespace zm_silver_hud
// Method(s) 8 Total 14
class class_5813c56a : cluielem {

    // Namespace namespace_5813c56a/zm_silver_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7742b8c6, Offset: 0x4b0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_5813c56a/zm_silver_hud
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1122856d, Offset: 0x410
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("zm_silver_hud");
    }

    // Namespace namespace_5813c56a/zm_silver_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3af6e7d5, Offset: 0x390
    // Size: 0x74
    function setup_clientfields(*var_a7dcee14) {
        cluielem::setup_clientfields("zm_silver_hud");
        cluielem::add_clientfield("_state", 1, 3, "int");
        cluielem::function_dcb34c80("string", "aetherscopeStatus", 1);
    }

    // Namespace namespace_5813c56a/zm_silver_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb4d22dc9, Offset: 0x640
    // Size: 0x30
    function function_9efecfd1(localclientnum, value) {
        set_data(localclientnum, "aetherscopeStatus", value);
    }

    // Namespace namespace_5813c56a/zm_silver_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb6937368, Offset: 0x4e0
    // Size: 0x154
    function set_state(localclientnum, state_name) {
        if (#"defaultstate" == state_name) {
            set_data(localclientnum, "_state", 0);
            return;
        }
        if (#"hash_6cf1a586f517c6b0" == state_name) {
            set_data(localclientnum, "_state", 1);
            return;
        }
        if (#"hash_7fc6d62e63e7c7eb" == state_name) {
            set_data(localclientnum, "_state", 2);
            return;
        }
        if (#"hash_78afa944bedce9e5" == state_name) {
            set_data(localclientnum, "_state", 3);
            return;
        }
        if (#"hash_5f0709f7c6680cea" == state_name) {
            set_data(localclientnum, "_state", 4);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace namespace_5813c56a/zm_silver_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2eccb87, Offset: 0x438
    // Size: 0x6c
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "aetherscopeStatus", #"");
    }

}

// Namespace zm_silver_hud/zm_silver_hud
// Params 1, eflags: 0x1 linked
// Checksum 0x7fdc6fc9, Offset: 0xd8
// Size: 0x176
function register(var_a7dcee14) {
    elem = new class_5813c56a();
    [[ elem ]]->setup_clientfields(var_a7dcee14);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"zm_silver_hud"])) {
        level.var_ae746e8f[#"zm_silver_hud"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"zm_silver_hud"])) {
        level.var_ae746e8f[#"zm_silver_hud"] = [];
    } else if (!isarray(level.var_ae746e8f[#"zm_silver_hud"])) {
        level.var_ae746e8f[#"zm_silver_hud"] = array(level.var_ae746e8f[#"zm_silver_hud"]);
    }
    level.var_ae746e8f[#"zm_silver_hud"][level.var_ae746e8f[#"zm_silver_hud"].size] = elem;
}

// Namespace zm_silver_hud/zm_silver_hud
// Params 0, eflags: 0x0
// Checksum 0x3b08bfaa, Offset: 0x258
// Size: 0x34
function register_clientside() {
    elem = new class_5813c56a();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace zm_silver_hud/zm_silver_hud
// Params 1, eflags: 0x0
// Checksum 0x7f7353ea, Offset: 0x298
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_silver_hud/zm_silver_hud
// Params 1, eflags: 0x0
// Checksum 0x96c31c0d, Offset: 0x2c0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_silver_hud/zm_silver_hud
// Params 1, eflags: 0x0
// Checksum 0x5b611d0b, Offset: 0x2e8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_silver_hud/zm_silver_hud
// Params 2, eflags: 0x0
// Checksum 0x5a003698, Offset: 0x310
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace zm_silver_hud/zm_silver_hud
// Params 2, eflags: 0x0
// Checksum 0x4a6c900a, Offset: 0x340
// Size: 0x28
function function_9efecfd1(localclientnum, value) {
    [[ self ]]->function_9efecfd1(localclientnum, value);
}

