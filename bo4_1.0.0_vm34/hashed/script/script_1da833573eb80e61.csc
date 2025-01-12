#using scripts\core_common\lui_shared;

#namespace initial_black;

// Namespace initial_black
// Method(s) 6 Total 12
class cinitial_black : cluielem {

    // Namespace cinitial_black/initial_black
    // Params 1, eflags: 0x0
    // Checksum 0x27f2cb72, Offset: 0x250
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"initial_black");
    }

    // Namespace cinitial_black/initial_black
    // Params 1, eflags: 0x0
    // Checksum 0x7b2622b5, Offset: 0x220
    // Size: 0x24
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
    }

    // Namespace cinitial_black/initial_black
    // Params 1, eflags: 0x0
    // Checksum 0x4eaad87a, Offset: 0x1f0
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cinitial_black/initial_black
    // Params 1, eflags: 0x0
    // Checksum 0x4b83ba97, Offset: 0x1c0
    // Size: 0x24
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
    }

}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x0
// Checksum 0x18c7ff63, Offset: 0x98
// Size: 0x40
function register(uid) {
    elem = new cinitial_black();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x0
// Checksum 0x12cb33e1, Offset: 0xe0
// Size: 0x40
function register_clientside(uid) {
    elem = new cinitial_black();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x0
// Checksum 0xc9e177f1, Offset: 0x128
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x0
// Checksum 0x3f993fd9, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x0
// Checksum 0xf5f9456f, Offset: 0x178
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

