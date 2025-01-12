#using scripts\core_common\lui_shared;

#namespace doa_textbubble;

// Namespace doa_textbubble
// Method(s) 10 Total 17
class class_b20c2804 : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 2, eflags: 0x0
    // Checksum 0xba46710b, Offset: 0x2c0
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 2, eflags: 0x0
    // Checksum 0x7cdf37aa, Offset: 0x458
    // Size: 0x4c
    function function_4f6e830d(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 4, value, 0);
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 1, eflags: 0x0
    // Checksum 0x12cddf2f, Offset: 0x308
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 2, eflags: 0x0
    // Checksum 0x9067133a, Offset: 0x400
    // Size: 0x4c
    function function_61312692(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 3, value, 0);
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 2, eflags: 0x0
    // Checksum 0xb260591a, Offset: 0x4b0
    // Size: 0x4c
    function function_7ddfdfef(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 5, value, 0);
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 0, eflags: 0x0
    // Checksum 0x7b003baf, Offset: 0x298
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("DOA_TextBubble");
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 2, eflags: 0x0
    // Checksum 0xd823d535, Offset: 0x338
    // Size: 0x4c
    function set_entnum(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 1, value, 0);
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 2, eflags: 0x0
    // Checksum 0x169b78f1, Offset: 0x390
    // Size: 0x64
    function set_text(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 2, function_f2d511a6("string", value), 0);
    }

}

// Namespace doa_textbubble/doa_textbubble
// Params 0, eflags: 0x0
// Checksum 0x4638c8ad, Offset: 0xb8
// Size: 0x34
function register() {
    elem = new class_b20c2804();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace doa_textbubble/doa_textbubble
// Params 2, eflags: 0x0
// Checksum 0x2d020860, Offset: 0xf8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace doa_textbubble/doa_textbubble
// Params 1, eflags: 0x0
// Checksum 0xfd201144, Offset: 0x138
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace doa_textbubble/doa_textbubble
// Params 1, eflags: 0x0
// Checksum 0xc0142567, Offset: 0x160
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace doa_textbubble/doa_textbubble
// Params 2, eflags: 0x0
// Checksum 0x28d957d, Offset: 0x188
// Size: 0x28
function set_entnum(player, value) {
    [[ self ]]->set_entnum(player, value);
}

// Namespace doa_textbubble/doa_textbubble
// Params 2, eflags: 0x0
// Checksum 0x31a7db50, Offset: 0x1b8
// Size: 0x28
function set_text(player, value) {
    [[ self ]]->set_text(player, value);
}

// Namespace doa_textbubble/doa_textbubble
// Params 2, eflags: 0x0
// Checksum 0x790d049, Offset: 0x1e8
// Size: 0x28
function function_61312692(player, value) {
    [[ self ]]->function_61312692(player, value);
}

// Namespace doa_textbubble/doa_textbubble
// Params 2, eflags: 0x0
// Checksum 0x5a89e666, Offset: 0x218
// Size: 0x28
function function_4f6e830d(player, value) {
    [[ self ]]->function_4f6e830d(player, value);
}

// Namespace doa_textbubble/doa_textbubble
// Params 2, eflags: 0x0
// Checksum 0x51822cea, Offset: 0x248
// Size: 0x28
function function_7ddfdfef(player, value) {
    [[ self ]]->function_7ddfdfef(player, value);
}

