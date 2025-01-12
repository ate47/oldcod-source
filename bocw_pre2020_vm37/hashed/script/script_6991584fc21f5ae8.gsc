#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace doa_keytrade;

// Namespace doa_keytrade
// Method(s) 7 Total 14
class class_fd95a9c : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 2, eflags: 0x0
    // Checksum 0x23fb6b3e, Offset: 0x2a0
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 2, eflags: 0x0
    // Checksum 0x79ca0a44, Offset: 0x368
    // Size: 0x44
    function function_3ae8b40f(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "confirmBtn", value);
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 1, eflags: 0x0
    // Checksum 0x913d4a09, Offset: 0x2e8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 2, eflags: 0x0
    // Checksum 0x3584bf3a, Offset: 0x318
    // Size: 0x44
    function function_8a6595db(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "textBoxHint", value);
    }

    // Namespace namespace_fd95a9c/doa_keytrade
    // Params 0, eflags: 0x0
    // Checksum 0xc6fb16d2, Offset: 0x228
    // Size: 0x6c
    function setup_clientfields() {
        cluielem::setup_clientfields("DOA_KeyTrade");
        cluielem::function_dcb34c80("string", "textBoxHint", 1);
        cluielem::function_dcb34c80("string", "confirmBtn", 1);
    }

}

// Namespace doa_keytrade/doa_keytrade
// Params 0, eflags: 0x0
// Checksum 0x7ace8495, Offset: 0xd8
// Size: 0x34
function register() {
    elem = new class_fd95a9c();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace doa_keytrade/doa_keytrade
// Params 2, eflags: 0x0
// Checksum 0x3a3edadf, Offset: 0x118
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace doa_keytrade/doa_keytrade
// Params 1, eflags: 0x0
// Checksum 0xdd84b28a, Offset: 0x158
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace doa_keytrade/doa_keytrade
// Params 1, eflags: 0x0
// Checksum 0x800f7339, Offset: 0x180
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace doa_keytrade/doa_keytrade
// Params 2, eflags: 0x0
// Checksum 0x4323e349, Offset: 0x1a8
// Size: 0x28
function function_8a6595db(player, value) {
    [[ self ]]->function_8a6595db(player, value);
}

// Namespace doa_keytrade/doa_keytrade
// Params 2, eflags: 0x0
// Checksum 0x38a23818, Offset: 0x1d8
// Size: 0x28
function function_3ae8b40f(player, value) {
    [[ self ]]->function_3ae8b40f(player, value);
}

