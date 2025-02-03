#using scripts\core_common\lui_shared;

#namespace fail_screen;

// Namespace fail_screen
// Method(s) 5 Total 12
class cfail_screen : cluielem {

    // Namespace cfail_screen/fail_screen
    // Params 2, eflags: 0x0
    // Checksum 0xcc20b548, Offset: 0x1c0
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cfail_screen/fail_screen
    // Params 1, eflags: 0x0
    // Checksum 0x59384c82, Offset: 0x208
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cfail_screen/fail_screen
    // Params 0, eflags: 0x0
    // Checksum 0x82bc73ca, Offset: 0x198
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("fail_screen");
    }

}

// Namespace fail_screen/fail_screen
// Params 0, eflags: 0x0
// Checksum 0xd502751e, Offset: 0xa8
// Size: 0x34
function register() {
    elem = new cfail_screen();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace fail_screen/fail_screen
// Params 2, eflags: 0x0
// Checksum 0xf686c281, Offset: 0xe8
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0xd32cc024, Offset: 0x128
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0xe31f81ed, Offset: 0x150
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

