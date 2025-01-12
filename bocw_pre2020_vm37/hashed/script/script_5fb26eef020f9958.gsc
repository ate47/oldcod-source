#using scripts\core_common\lui_shared;

#namespace sr_armor_menu;

// Namespace sr_armor_menu
// Method(s) 5 Total 12
class class_8ebbf51b : cluielem {

    // Namespace namespace_8ebbf51b/sr_armor_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5f686f5, Offset: 0x1c0
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_8ebbf51b/sr_armor_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0xdae0f462, Offset: 0x208
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_8ebbf51b/sr_armor_menu
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1e630823, Offset: 0x198
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_armor_menu");
    }

}

// Namespace sr_armor_menu/sr_armor_menu
// Params 0, eflags: 0x1 linked
// Checksum 0xc7f9702a, Offset: 0xa8
// Size: 0x34
function register() {
    elem = new class_8ebbf51b();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace sr_armor_menu/sr_armor_menu
// Params 2, eflags: 0x1 linked
// Checksum 0xca2e1c40, Offset: 0xe8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace sr_armor_menu/sr_armor_menu
// Params 1, eflags: 0x1 linked
// Checksum 0x7c7778f0, Offset: 0x128
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_armor_menu/sr_armor_menu
// Params 1, eflags: 0x1 linked
// Checksum 0xa2ef2991, Offset: 0x150
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

