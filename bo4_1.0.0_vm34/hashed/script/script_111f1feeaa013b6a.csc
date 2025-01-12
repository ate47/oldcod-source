#using scripts\core_common\lui_shared;

#namespace bountyhunterbuy;

// Namespace bountyhunterbuy
// Method(s) 6 Total 12
class cbountyhunterbuy : cluielem {

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 1, eflags: 0x0
    // Checksum 0x7ce56900, Offset: 0x250
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"bountyhunterbuy");
    }

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 1, eflags: 0x0
    // Checksum 0x36e2c5ec, Offset: 0x220
    // Size: 0x24
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
    }

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 1, eflags: 0x0
    // Checksum 0xbc0ae48a, Offset: 0x1f0
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cbountyhunterbuy/bountyhunterbuy
    // Params 1, eflags: 0x0
    // Checksum 0x59598d40, Offset: 0x1c0
    // Size: 0x24
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
    }

}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1, eflags: 0x0
// Checksum 0x775dbfa, Offset: 0x98
// Size: 0x40
function register(uid) {
    elem = new cbountyhunterbuy();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1, eflags: 0x0
// Checksum 0xc4f4652b, Offset: 0xe0
// Size: 0x40
function register_clientside(uid) {
    elem = new cbountyhunterbuy();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1, eflags: 0x0
// Checksum 0x19f4db20, Offset: 0x128
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1, eflags: 0x0
// Checksum 0x17b37a65, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace bountyhunterbuy/bountyhunterbuy
// Params 1, eflags: 0x0
// Checksum 0x1be272e0, Offset: 0x178
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

