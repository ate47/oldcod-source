#using scripts\core_common\lui_shared;

#namespace success_screen;

// Namespace success_screen
// Method(s) 6 Total 12
class csuccess_screen : cluielem {

    // Namespace csuccess_screen/success_screen
    // Params 1, eflags: 0x0
    // Checksum 0xb1d6f720, Offset: 0x250
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"success_screen");
    }

    // Namespace csuccess_screen/success_screen
    // Params 1, eflags: 0x0
    // Checksum 0x582dab33, Offset: 0x220
    // Size: 0x24
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
    }

    // Namespace csuccess_screen/success_screen
    // Params 1, eflags: 0x0
    // Checksum 0x1edd4c3b, Offset: 0x1f0
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace csuccess_screen/success_screen
    // Params 1, eflags: 0x0
    // Checksum 0xf8c5fbca, Offset: 0x1c0
    // Size: 0x24
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
    }

}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0xfc7afba1, Offset: 0x98
// Size: 0x40
function register(uid) {
    elem = new csuccess_screen();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0x7f22967e, Offset: 0xe0
// Size: 0x40
function register_clientside(uid) {
    elem = new csuccess_screen();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0x3fae5f1a, Offset: 0x128
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0x98258126, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0xac6472fb, Offset: 0x178
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

