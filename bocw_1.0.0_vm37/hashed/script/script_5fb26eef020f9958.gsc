#using scripts\core_common\lui_shared;

#namespace sr_armor_menu;

// Namespace sr_armor_menu
// Method(s) 5 Total 12
class class_8ebbf51b : cluielem {

    // Namespace namespace_8ebbf51b/sr_armor_menu
    // Params 2, eflags: 0x0
    // Checksum 0x3557280c, Offset: 0x1c0
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace namespace_8ebbf51b/sr_armor_menu
    // Params 1, eflags: 0x0
    // Checksum 0x2f0729fa, Offset: 0x208
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_8ebbf51b/sr_armor_menu
    // Params 0, eflags: 0x0
    // Checksum 0x29a33c2c, Offset: 0x198
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_armor_menu");
    }

}

// Namespace sr_armor_menu/sr_armor_menu
// Params 0, eflags: 0x0
// Checksum 0x866f171e, Offset: 0xa8
// Size: 0x34
function register() {
    elem = new class_8ebbf51b();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace sr_armor_menu/sr_armor_menu
// Params 2, eflags: 0x0
// Checksum 0x696041e, Offset: 0xe8
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace sr_armor_menu/sr_armor_menu
// Params 1, eflags: 0x0
// Checksum 0x72df0a5e, Offset: 0x128
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_armor_menu/sr_armor_menu
// Params 1, eflags: 0x0
// Checksum 0xc1ffdb45, Offset: 0x150
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

