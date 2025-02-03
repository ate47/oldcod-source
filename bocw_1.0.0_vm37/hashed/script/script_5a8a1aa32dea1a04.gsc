#using scripts\core_common\lui_shared;

#namespace sr_weapon_upgrade_menu;

// Namespace sr_weapon_upgrade_menu
// Method(s) 5 Total 12
class class_ec90ce81 : cluielem {

    // Namespace namespace_ec90ce81/sr_weapon_upgrade_menu
    // Params 2, eflags: 0x0
    // Checksum 0x4b646d40, Offset: 0x1c8
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace namespace_ec90ce81/sr_weapon_upgrade_menu
    // Params 1, eflags: 0x0
    // Checksum 0xbcd05473, Offset: 0x210
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_ec90ce81/sr_weapon_upgrade_menu
    // Params 0, eflags: 0x0
    // Checksum 0xda326e41, Offset: 0x1a0
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_weapon_upgrade_menu");
    }

}

// Namespace sr_weapon_upgrade_menu/sr_weapon_upgrade_menu
// Params 0, eflags: 0x0
// Checksum 0x305ed43a, Offset: 0xb0
// Size: 0x34
function register() {
    elem = new class_ec90ce81();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace sr_weapon_upgrade_menu/sr_weapon_upgrade_menu
// Params 2, eflags: 0x0
// Checksum 0x672bc8a8, Offset: 0xf0
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace sr_weapon_upgrade_menu/sr_weapon_upgrade_menu
// Params 1, eflags: 0x0
// Checksum 0x2194ec3f, Offset: 0x130
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_weapon_upgrade_menu/sr_weapon_upgrade_menu
// Params 1, eflags: 0x0
// Checksum 0x37b19c38, Offset: 0x158
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

