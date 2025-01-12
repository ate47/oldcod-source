#using scripts\core_common\lui_shared;

#namespace sr_weapon_upgrade_menu;

// Namespace sr_weapon_upgrade_menu
// Method(s) 5 Total 12
class class_ec90ce81 : cluielem {

    // Namespace namespace_ec90ce81/sr_weapon_upgrade_menu
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7bc5c3b9, Offset: 0x1c8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_ec90ce81/sr_weapon_upgrade_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0x493789eb, Offset: 0x210
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_ec90ce81/sr_weapon_upgrade_menu
    // Params 0, eflags: 0x1 linked
    // Checksum 0xedf25a4e, Offset: 0x1a0
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_weapon_upgrade_menu");
    }

}

// Namespace sr_weapon_upgrade_menu/sr_weapon_upgrade_menu
// Params 0, eflags: 0x1 linked
// Checksum 0x71c8b30e, Offset: 0xb0
// Size: 0x34
function register() {
    elem = new class_ec90ce81();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace sr_weapon_upgrade_menu/sr_weapon_upgrade_menu
// Params 2, eflags: 0x1 linked
// Checksum 0xab93d0f6, Offset: 0xf0
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace sr_weapon_upgrade_menu/sr_weapon_upgrade_menu
// Params 1, eflags: 0x1 linked
// Checksum 0x2f3c9e91, Offset: 0x130
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_weapon_upgrade_menu/sr_weapon_upgrade_menu
// Params 1, eflags: 0x1 linked
// Checksum 0x54a16eec, Offset: 0x158
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

