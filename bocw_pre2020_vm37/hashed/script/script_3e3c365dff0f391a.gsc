#using scripts\core_common\lui_shared;

#namespace fail_screen;

// Namespace fail_screen
// Method(s) 5 Total 12
class cfail_screen : cluielem {

    // Namespace cfail_screen/fail_screen
    // Params 2, eflags: 0x0
    // Checksum 0xfc811bb1, Offset: 0x1c0
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cfail_screen/fail_screen
    // Params 1, eflags: 0x0
    // Checksum 0xacdf911a, Offset: 0x208
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cfail_screen/fail_screen
    // Params 0, eflags: 0x0
    // Checksum 0xb57c47c5, Offset: 0x198
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("fail_screen");
    }

}

// Namespace fail_screen/fail_screen
// Params 0, eflags: 0x0
// Checksum 0x9494122a, Offset: 0xa8
// Size: 0x34
function register() {
    elem = new cfail_screen();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace fail_screen/fail_screen
// Params 2, eflags: 0x0
// Checksum 0x3a3edadf, Offset: 0xe8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0xdd84b28a, Offset: 0x128
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0x800f7339, Offset: 0x150
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

