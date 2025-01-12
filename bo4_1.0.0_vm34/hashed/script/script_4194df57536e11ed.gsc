#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace initial_black;

// Namespace initial_black
// Method(s) 5 Total 12
class cinitial_black : cluielem {

    // Namespace cinitial_black/initial_black
    // Params 1, eflags: 0x0
    // Checksum 0xf136e5a8, Offset: 0x228
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cinitial_black/initial_black
    // Params 2, eflags: 0x0
    // Checksum 0x6969df3f, Offset: 0x1d8
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "initial_black", persistent);
    }

    // Namespace cinitial_black/initial_black
    // Params 1, eflags: 0x0
    // Checksum 0xff897ed7, Offset: 0x1a8
    // Size: 0x24
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
    }

}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x0
// Checksum 0xc7568490, Offset: 0xb0
// Size: 0x40
function register(uid) {
    elem = new cinitial_black();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace initial_black/initial_black
// Params 2, eflags: 0x0
// Checksum 0xaa3869de, Offset: 0xf8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x0
// Checksum 0x3a798c1d, Offset: 0x138
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace initial_black/initial_black
// Params 1, eflags: 0x0
// Checksum 0x79e3d495, Offset: 0x160
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

