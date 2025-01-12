#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace fail_screen;

// Namespace fail_screen
// Method(s) 5 Total 12
class cfail_screen : cluielem {

    // Namespace cfail_screen/fail_screen
    // Params 1, eflags: 0x0
    // Checksum 0x9daef5ed, Offset: 0x220
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cfail_screen/fail_screen
    // Params 2, eflags: 0x0
    // Checksum 0xba6bde3e, Offset: 0x1d0
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "fail_screen", persistent);
    }

    // Namespace cfail_screen/fail_screen
    // Params 1, eflags: 0x0
    // Checksum 0x525ccddc, Offset: 0x1a0
    // Size: 0x24
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
    }

}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0x5e8353f6, Offset: 0xa8
// Size: 0x40
function register(uid) {
    elem = new cfail_screen();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace fail_screen/fail_screen
// Params 2, eflags: 0x0
// Checksum 0x614cab1f, Offset: 0xf0
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0xd5a74455, Offset: 0x130
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0x4b7e4b7d, Offset: 0x158
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

