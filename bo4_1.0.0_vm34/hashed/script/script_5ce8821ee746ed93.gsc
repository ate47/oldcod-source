#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace success_screen;

// Namespace success_screen
// Method(s) 5 Total 12
class csuccess_screen : cluielem {

    // Namespace csuccess_screen/success_screen
    // Params 1, eflags: 0x0
    // Checksum 0x6bc9e9bf, Offset: 0x228
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace csuccess_screen/success_screen
    // Params 2, eflags: 0x0
    // Checksum 0x560dd1a1, Offset: 0x1d8
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "success_screen", persistent);
    }

    // Namespace csuccess_screen/success_screen
    // Params 1, eflags: 0x0
    // Checksum 0x5d9efb4, Offset: 0x1a8
    // Size: 0x24
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
    }

}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0xc37668e1, Offset: 0xb0
// Size: 0x40
function register(uid) {
    elem = new csuccess_screen();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace success_screen/success_screen
// Params 2, eflags: 0x0
// Checksum 0xe16badba, Offset: 0xf8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0x230086c9, Offset: 0x138
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0x24e84fc4, Offset: 0x160
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

