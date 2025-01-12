#using scripts\core_common\lui_shared;

#namespace debug_center_screen;

// Namespace debug_center_screen
// Method(s) 5 Total 12
class cdebug_center_screen : cluielem {

    // Namespace cdebug_center_screen/debug_center_screen
    // Params 2, eflags: 0x0
    // Checksum 0xfc811bb1, Offset: 0x1c8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cdebug_center_screen/debug_center_screen
    // Params 1, eflags: 0x0
    // Checksum 0xacdf911a, Offset: 0x210
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cdebug_center_screen/debug_center_screen
    // Params 0, eflags: 0x0
    // Checksum 0xb57c47c5, Offset: 0x1a0
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("debug_center_screen");
    }

}

// Namespace debug_center_screen/debug_center_screen
// Params 0, eflags: 0x0
// Checksum 0x216e4bcd, Offset: 0xb0
// Size: 0x34
function register() {
    elem = new cdebug_center_screen();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace debug_center_screen/debug_center_screen
// Params 2, eflags: 0x0
// Checksum 0x3a3edadf, Offset: 0xf0
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace debug_center_screen/debug_center_screen
// Params 1, eflags: 0x0
// Checksum 0xdd84b28a, Offset: 0x130
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace debug_center_screen/debug_center_screen
// Params 1, eflags: 0x0
// Checksum 0x800f7339, Offset: 0x158
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

