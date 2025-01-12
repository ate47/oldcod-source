#using scripts\core_common\lui_shared;

#namespace doa_keytrade;

// Namespace doa_keytrade
// Method(s) 8 Total 14
class class_fd95a9c : cluielem {

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 1, eflags: 0x0
    // Checksum 0x3c74d4cc, Offset: 0x4c0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 2, eflags: 0x0
    // Checksum 0x8af1d3a1, Offset: 0x528
    // Size: 0x30
    function function_3ae8b40f(localclientnum, value) {
        set_data(localclientnum, "confirmBtn", value);
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 0, eflags: 0x0
    // Checksum 0x8505b365, Offset: 0x418
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("DOA_KeyTrade");
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 2, eflags: 0x0
    // Checksum 0xb15ea8d3, Offset: 0x4f0
    // Size: 0x30
    function function_8a6595db(localclientnum, value) {
        set_data(localclientnum, "textBoxHint", value);
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 2, eflags: 0x0
    // Checksum 0x33182aff, Offset: 0x390
    // Size: 0x7c
    function setup_clientfields(*var_909954a3, *var_66f4eb53) {
        cluielem::setup_clientfields("DOA_KeyTrade");
        cluielem::function_dcb34c80("string", "textBoxHint", 1);
        cluielem::function_dcb34c80("string", "confirmBtn", 1);
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 1, eflags: 0x0
    // Checksum 0x73c40fbd, Offset: 0x440
    // Size: 0x74
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "textBoxHint", #"");
        set_data(localclientnum, "confirmBtn", #"");
    }

}

// Namespace doa_keytrade/doa_keytrade
// Params 2, eflags: 0x0
// Checksum 0x35683ce4, Offset: 0xd0
// Size: 0x17e
function register(var_909954a3, var_66f4eb53) {
    elem = new class_fd95a9c();
    [[ elem ]]->setup_clientfields(var_909954a3, var_66f4eb53);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"doa_keytrade"])) {
        level.var_ae746e8f[#"doa_keytrade"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"doa_keytrade"])) {
        level.var_ae746e8f[#"doa_keytrade"] = [];
    } else if (!isarray(level.var_ae746e8f[#"doa_keytrade"])) {
        level.var_ae746e8f[#"doa_keytrade"] = array(level.var_ae746e8f[#"doa_keytrade"]);
    }
    level.var_ae746e8f[#"doa_keytrade"][level.var_ae746e8f[#"doa_keytrade"].size] = elem;
}

// Namespace doa_keytrade/doa_keytrade
// Params 0, eflags: 0x0
// Checksum 0xd84acbae, Offset: 0x258
// Size: 0x34
function register_clientside() {
    elem = new class_fd95a9c();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace doa_keytrade/doa_keytrade
// Params 1, eflags: 0x0
// Checksum 0xad0c105e, Offset: 0x298
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace doa_keytrade/doa_keytrade
// Params 1, eflags: 0x0
// Checksum 0x53447f52, Offset: 0x2c0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace doa_keytrade/doa_keytrade
// Params 1, eflags: 0x0
// Checksum 0xc9c6682b, Offset: 0x2e8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace doa_keytrade/doa_keytrade
// Params 2, eflags: 0x0
// Checksum 0xa786542f, Offset: 0x310
// Size: 0x28
function function_8a6595db(localclientnum, value) {
    [[ self ]]->function_8a6595db(localclientnum, value);
}

// Namespace doa_keytrade/doa_keytrade
// Params 2, eflags: 0x0
// Checksum 0x7ecdb6a3, Offset: 0x340
// Size: 0x28
function function_3ae8b40f(localclientnum, value) {
    [[ self ]]->function_3ae8b40f(localclientnum, value);
}

