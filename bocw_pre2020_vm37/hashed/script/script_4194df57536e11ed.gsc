#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace initial_black;

// Namespace initial_black
// Method(s) 6 Total 13
class cinitial_black : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cinitial_black/initial_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0xef7ac1b6, Offset: 0x238
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cinitial_black/initial_black
    // Params 2, eflags: 0x1 linked
    // Checksum 0x166ace02, Offset: 0x2b0
    // Size: 0x44
    function function_2eb3f6e8(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "developer_mode", value);
    }

    // Namespace cinitial_black/initial_black
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe8bf2ec, Offset: 0x280
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cinitial_black/initial_black
    // Params 0, eflags: 0x1 linked
    // Checksum 0x33b32c2f, Offset: 0x1e8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("initial_black");
        cluielem::add_clientfield("developer_mode", 1, 1, "int");
    }

}

// Namespace initial_black/initial_black
// Params 0, eflags: 0x1 linked
// Checksum 0x5da3489, Offset: 0xc8
// Size: 0x34
function register() {
    elem = new cinitial_black();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace initial_black/initial_black
// Params 2, eflags: 0x1 linked
// Checksum 0xab93d0f6, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x1 linked
// Checksum 0x2f3c9e91, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x0
// Checksum 0x54a16eec, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace initial_black/initial_black
// Params 2, eflags: 0x0
// Checksum 0xdd0391d9, Offset: 0x198
// Size: 0x28
function function_2eb3f6e8(player, value) {
    [[ self ]]->function_2eb3f6e8(player, value);
}

