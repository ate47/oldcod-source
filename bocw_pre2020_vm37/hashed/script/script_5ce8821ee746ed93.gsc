#using scripts\core_common\lui_shared;

#namespace success_screen;

// Namespace success_screen
// Method(s) 5 Total 12
class csuccess_screen : cluielem {

    // Namespace csuccess_screen/success_screen
    // Params 2, eflags: 0x0
    // Checksum 0x7bc5c3b9, Offset: 0x1c0
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace csuccess_screen/success_screen
    // Params 1, eflags: 0x0
    // Checksum 0x493789eb, Offset: 0x208
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace csuccess_screen/success_screen
    // Params 0, eflags: 0x0
    // Checksum 0xedf25a4e, Offset: 0x198
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("success_screen");
    }

}

// Namespace success_screen/success_screen
// Params 0, eflags: 0x0
// Checksum 0x6879f1f, Offset: 0xa8
// Size: 0x34
function register() {
    elem = new csuccess_screen();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace success_screen/success_screen
// Params 2, eflags: 0x0
// Checksum 0xab93d0f6, Offset: 0xe8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0x2f3c9e91, Offset: 0x128
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0x54a16eec, Offset: 0x150
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

