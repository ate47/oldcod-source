#using scripts\core_common\lui_shared;

#namespace fail_screen;

// Namespace fail_screen
// Method(s) 6 Total 12
class cfail_screen : cluielem {

    // Namespace cfail_screen/fail_screen
    // Params 1, eflags: 0x0
    // Checksum 0xc26513b, Offset: 0x250
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"fail_screen");
    }

    // Namespace cfail_screen/fail_screen
    // Params 1, eflags: 0x0
    // Checksum 0x67690a6f, Offset: 0x220
    // Size: 0x24
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
    }

    // Namespace cfail_screen/fail_screen
    // Params 1, eflags: 0x0
    // Checksum 0xc610ba6, Offset: 0x1f0
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cfail_screen/fail_screen
    // Params 1, eflags: 0x0
    // Checksum 0x2e816664, Offset: 0x1c0
    // Size: 0x24
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
    }

}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0x34820357, Offset: 0x98
// Size: 0x40
function register(uid) {
    elem = new cfail_screen();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0x9bb6daec, Offset: 0xe0
// Size: 0x40
function register_clientside(uid) {
    elem = new cfail_screen();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0x430b8e5d, Offset: 0x128
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0xacf0cddd, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0x78a1077f, Offset: 0x178
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

