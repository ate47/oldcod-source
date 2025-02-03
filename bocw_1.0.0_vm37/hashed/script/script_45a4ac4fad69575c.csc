#using scripts\core_common\lui_shared;

#namespace doa_keytrade;

// Namespace doa_keytrade
// Method(s) 8 Total 15
class class_fd95a9c : cluielem {

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 1, eflags: 0x0
    // Checksum 0x30ebc870, Offset: 0x4c0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 2, eflags: 0x0
    // Checksum 0x319bfd7a, Offset: 0x528
    // Size: 0x30
    function function_3ae8b40f(localclientnum, value) {
        set_data(localclientnum, "confirmBtn", value);
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 0, eflags: 0x0
    // Checksum 0x2b263e49, Offset: 0x418
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("DOA_KeyTrade");
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 2, eflags: 0x0
    // Checksum 0x71056987, Offset: 0x4f0
    // Size: 0x30
    function function_8a6595db(localclientnum, value) {
        set_data(localclientnum, "textBoxHint", value);
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 2, eflags: 0x0
    // Checksum 0x1255163, Offset: 0x390
    // Size: 0x7c
    function setup_clientfields(*var_909954a3, *var_66f4eb53) {
        cluielem::setup_clientfields("DOA_KeyTrade");
        cluielem::function_dcb34c80("string", "textBoxHint", 1);
        cluielem::function_dcb34c80("string", "confirmBtn", 1);
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 1, eflags: 0x0
    // Checksum 0x74a17718, Offset: 0x440
    // Size: 0x74
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "textBoxHint", #"");
        set_data(localclientnum, "confirmBtn", #"");
    }

}

// Namespace doa_keytrade/doa_keytrade
// Params 2, eflags: 0x0
// Checksum 0x3bc5db66, Offset: 0xd0
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
// Checksum 0x6c07ddf6, Offset: 0x258
// Size: 0x34
function register_clientside() {
    elem = new class_fd95a9c();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace doa_keytrade/doa_keytrade
// Params 1, eflags: 0x0
// Checksum 0x75512ca5, Offset: 0x298
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace doa_keytrade/doa_keytrade
// Params 1, eflags: 0x0
// Checksum 0x1221277, Offset: 0x2c0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace doa_keytrade/doa_keytrade
// Params 1, eflags: 0x0
// Checksum 0x31152d7d, Offset: 0x2e8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace doa_keytrade/doa_keytrade
// Params 2, eflags: 0x0
// Checksum 0x874a49d3, Offset: 0x310
// Size: 0x28
function function_8a6595db(localclientnum, value) {
    [[ self ]]->function_8a6595db(localclientnum, value);
}

// Namespace doa_keytrade/doa_keytrade
// Params 2, eflags: 0x0
// Checksum 0x6f802c1e, Offset: 0x340
// Size: 0x28
function function_3ae8b40f(localclientnum, value) {
    [[ self ]]->function_3ae8b40f(localclientnum, value);
}

