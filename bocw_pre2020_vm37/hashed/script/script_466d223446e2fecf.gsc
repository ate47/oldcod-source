#using scripts\core_common\lui_shared;

#namespace doa_textbubble_playername;

// Namespace doa_textbubble_playername
// Method(s) 10 Total 17
class class_42946372 : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 2, eflags: 0x0
    // Checksum 0x2267751a, Offset: 0x2c0
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 2, eflags: 0x0
    // Checksum 0x4d52b181, Offset: 0x390
    // Size: 0x4c
    function set_clientnum(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 2, value, 0);
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 2, eflags: 0x0
    // Checksum 0x8562271f, Offset: 0x440
    // Size: 0x4c
    function function_4f6e830d(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 4, value, 0);
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 1, eflags: 0x0
    // Checksum 0xe0e443a7, Offset: 0x308
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 2, eflags: 0x0
    // Checksum 0x67b5b34f, Offset: 0x3e8
    // Size: 0x4c
    function function_61312692(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 3, value, 0);
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 2, eflags: 0x0
    // Checksum 0xa54b2399, Offset: 0x498
    // Size: 0x4c
    function function_7ddfdfef(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 5, value, 0);
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 0, eflags: 0x0
    // Checksum 0x7b4ec939, Offset: 0x298
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("DOA_TextBubble_PlayerName");
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 2, eflags: 0x0
    // Checksum 0xe3f72040, Offset: 0x338
    // Size: 0x4c
    function set_entnum(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 1, value, 0);
    }

}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 0, eflags: 0x0
// Checksum 0x6e0f03d4, Offset: 0xb8
// Size: 0x34
function register() {
    elem = new class_42946372();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 2, eflags: 0x0
// Checksum 0x17ff746, Offset: 0xf8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 1, eflags: 0x0
// Checksum 0x1870d62a, Offset: 0x138
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 1, eflags: 0x0
// Checksum 0x4fad5457, Offset: 0x160
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 2, eflags: 0x0
// Checksum 0x64932003, Offset: 0x188
// Size: 0x28
function set_entnum(player, value) {
    [[ self ]]->set_entnum(player, value);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 2, eflags: 0x0
// Checksum 0x5c2d27cf, Offset: 0x1b8
// Size: 0x28
function set_clientnum(player, value) {
    [[ self ]]->set_clientnum(player, value);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 2, eflags: 0x0
// Checksum 0xb7cc99d0, Offset: 0x1e8
// Size: 0x28
function function_61312692(player, value) {
    [[ self ]]->function_61312692(player, value);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 2, eflags: 0x0
// Checksum 0x101c8031, Offset: 0x218
// Size: 0x28
function function_4f6e830d(player, value) {
    [[ self ]]->function_4f6e830d(player, value);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 2, eflags: 0x0
// Checksum 0x84363d35, Offset: 0x248
// Size: 0x28
function function_7ddfdfef(player, value) {
    [[ self ]]->function_7ddfdfef(player, value);
}

