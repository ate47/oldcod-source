#using scripts\core_common\lui_shared;

#namespace lower_message;

// Namespace lower_message
// Method(s) 9 Total 15
class clower_message : cluielem {

    // Namespace clower_message/lower_message
    // Params 2, eflags: 0x0
    // Checksum 0xcb8b5208, Offset: 0x570
    // Size: 0x30
    function set_countdowntimeseconds(localclientnum, value) {
        set_data(localclientnum, "countdownTimeSeconds", value);
    }

    // Namespace clower_message/lower_message
    // Params 2, eflags: 0x0
    // Checksum 0x777f8f3c, Offset: 0x538
    // Size: 0x30
    function set_message(localclientnum, value) {
        set_data(localclientnum, "message", value);
    }

    // Namespace clower_message/lower_message
    // Params 2, eflags: 0x0
    // Checksum 0x1986c579, Offset: 0x448
    // Size: 0xe4
    function set_state(localclientnum, state_name) {
        if (#"defaultstate" == state_name) {
            set_data(localclientnum, "_state", 0);
            return;
        }
        if (#"visible" == state_name) {
            set_data(localclientnum, "_state", 1);
            return;
        }
        if (#"hash_45bfcb1cd8c9b50a" == state_name) {
            set_data(localclientnum, "_state", 2);
            return;
        }
        assertmsg("<dev string:x30>");
    }

    // Namespace clower_message/lower_message
    // Params 1, eflags: 0x0
    // Checksum 0x46df9eb9, Offset: 0x410
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"lower_message");
    }

    // Namespace clower_message/lower_message
    // Params 1, eflags: 0x0
    // Checksum 0xf1a03c2, Offset: 0x380
    // Size: 0x88
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "message", #"");
        set_data(localclientnum, "countdownTimeSeconds", 0);
    }

    // Namespace clower_message/lower_message
    // Params 1, eflags: 0x0
    // Checksum 0x835d9c51, Offset: 0x350
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace clower_message/lower_message
    // Params 3, eflags: 0x0
    // Checksum 0xa96642f8, Offset: 0x298
    // Size: 0xac
    function setup_clientfields(uid, var_524f4343, var_a46e67bd) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("_state", 1, 2, "int");
        cluielem::function_52818084("string", "message", 1);
        cluielem::add_clientfield("countdownTimeSeconds", 1, 5, "int", var_a46e67bd);
    }

}

// Namespace lower_message/lower_message
// Params 3, eflags: 0x0
// Checksum 0x80b71aa5, Offset: 0xc8
// Size: 0x58
function register(uid, var_524f4343, var_a46e67bd) {
    elem = new clower_message();
    [[ elem ]]->setup_clientfields(uid, var_524f4343, var_a46e67bd);
    return elem;
}

// Namespace lower_message/lower_message
// Params 1, eflags: 0x0
// Checksum 0xa6269ad1, Offset: 0x128
// Size: 0x40
function register_clientside(uid) {
    elem = new clower_message();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace lower_message/lower_message
// Params 1, eflags: 0x0
// Checksum 0x10186946, Offset: 0x170
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace lower_message/lower_message
// Params 1, eflags: 0x0
// Checksum 0x58dcb9d9, Offset: 0x198
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace lower_message/lower_message
// Params 1, eflags: 0x0
// Checksum 0x8e0ad1bd, Offset: 0x1c0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace lower_message/lower_message
// Params 2, eflags: 0x0
// Checksum 0x4ee9644c, Offset: 0x1e8
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace lower_message/lower_message
// Params 2, eflags: 0x0
// Checksum 0x9cf6a6f9, Offset: 0x218
// Size: 0x28
function set_message(localclientnum, value) {
    [[ self ]]->set_message(localclientnum, value);
}

// Namespace lower_message/lower_message
// Params 2, eflags: 0x0
// Checksum 0x56277168, Offset: 0x248
// Size: 0x28
function set_countdowntimeseconds(localclientnum, value) {
    [[ self ]]->set_countdowntimeseconds(localclientnum, value);
}

