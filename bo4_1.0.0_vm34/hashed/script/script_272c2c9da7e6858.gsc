#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace lower_message;

// Namespace lower_message
// Method(s) 8 Total 15
class clower_message : cluielem {

    var var_57a3d576;

    // Namespace clower_message/lower_message
    // Params 2, eflags: 0x0
    // Checksum 0x6c23c88, Offset: 0x4e0
    // Size: 0x3c
    function set_countdowntimeseconds(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "countdownTimeSeconds", value);
    }

    // Namespace clower_message/lower_message
    // Params 2, eflags: 0x0
    // Checksum 0x3e0b6c67, Offset: 0x498
    // Size: 0x3c
    function set_message(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "message", value);
    }

    // Namespace clower_message/lower_message
    // Params 2, eflags: 0x0
    // Checksum 0x68aaba02, Offset: 0x390
    // Size: 0xfc
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 0);
            return;
        }
        if (#"visible" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 1);
            return;
        }
        if (#"hash_45bfcb1cd8c9b50a" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 2);
            return;
        }
        assertmsg("<dev string:x30>");
    }

    // Namespace clower_message/lower_message
    // Params 1, eflags: 0x0
    // Checksum 0x8387741b, Offset: 0x360
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace clower_message/lower_message
    // Params 2, eflags: 0x0
    // Checksum 0x7b4d49d, Offset: 0x310
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "lower_message", persistent);
    }

    // Namespace clower_message/lower_message
    // Params 1, eflags: 0x0
    // Checksum 0x7184381, Offset: 0x268
    // Size: 0x9c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("_state", 1, 2, "int");
        cluielem::function_52818084("string", "message", 1);
        cluielem::add_clientfield("countdownTimeSeconds", 1, 5, "int");
    }

}

// Namespace lower_message/lower_message
// Params 1, eflags: 0x0
// Checksum 0x106b2b6b, Offset: 0xe0
// Size: 0x40
function register(uid) {
    elem = new clower_message();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace lower_message/lower_message
// Params 2, eflags: 0x0
// Checksum 0xa48d769b, Offset: 0x128
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace lower_message/lower_message
// Params 1, eflags: 0x0
// Checksum 0x3983174b, Offset: 0x168
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace lower_message/lower_message
// Params 1, eflags: 0x0
// Checksum 0xda58f5e5, Offset: 0x190
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace lower_message/lower_message
// Params 2, eflags: 0x0
// Checksum 0xb73850bf, Offset: 0x1b8
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace lower_message/lower_message
// Params 2, eflags: 0x0
// Checksum 0x5034c73a, Offset: 0x1e8
// Size: 0x28
function set_message(player, value) {
    [[ self ]]->set_message(player, value);
}

// Namespace lower_message/lower_message
// Params 2, eflags: 0x0
// Checksum 0x9cb055c, Offset: 0x218
// Size: 0x28
function set_countdowntimeseconds(player, value) {
    [[ self ]]->set_countdowntimeseconds(player, value);
}

