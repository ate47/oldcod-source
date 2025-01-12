#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_zod_wonderweapon_quest;

// Namespace zm_zod_wonderweapon_quest
// Method(s) 9 Total 16
class czm_zod_wonderweapon_quest : cluielem {

    var var_57a3d576;

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 2, eflags: 0x0
    // Checksum 0x15da3555, Offset: 0x4b8
    // Size: 0x3c
    function set_decay(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "decay", value);
    }

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 2, eflags: 0x0
    // Checksum 0x59296dc9, Offset: 0x470
    // Size: 0x3c
    function set_purity(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "purity", value);
    }

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 2, eflags: 0x0
    // Checksum 0x56a42238, Offset: 0x428
    // Size: 0x3c
    function set_plasma(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "plasma", value);
    }

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 2, eflags: 0x0
    // Checksum 0x3e696c66, Offset: 0x3e0
    // Size: 0x3c
    function set_radiance(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "radiance", value);
    }

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 1, eflags: 0x0
    // Checksum 0xedb03b11, Offset: 0x3b0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 2, eflags: 0x0
    // Checksum 0xb8681cc6, Offset: 0x360
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_zod_wonderweapon_quest", persistent);
    }

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 1, eflags: 0x0
    // Checksum 0x3b70304a, Offset: 0x290
    // Size: 0xc4
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("radiance", 1, 1, "int");
        cluielem::add_clientfield("plasma", 1, 1, "int");
        cluielem::add_clientfield("purity", 1, 1, "int");
        cluielem::add_clientfield("decay", 1, 1, "int");
    }

}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 1, eflags: 0x0
// Checksum 0x97be843f, Offset: 0xd8
// Size: 0x40
function register(uid) {
    elem = new czm_zod_wonderweapon_quest();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 2, eflags: 0x0
// Checksum 0x5ed416d7, Offset: 0x120
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 1, eflags: 0x0
// Checksum 0x14b8df2f, Offset: 0x160
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 1, eflags: 0x0
// Checksum 0xb760025, Offset: 0x188
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 2, eflags: 0x0
// Checksum 0xc039af48, Offset: 0x1b0
// Size: 0x28
function set_radiance(player, value) {
    [[ self ]]->set_radiance(player, value);
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 2, eflags: 0x0
// Checksum 0xd5c166b, Offset: 0x1e0
// Size: 0x28
function set_plasma(player, value) {
    [[ self ]]->set_plasma(player, value);
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 2, eflags: 0x0
// Checksum 0x2be03f40, Offset: 0x210
// Size: 0x28
function set_purity(player, value) {
    [[ self ]]->set_purity(player, value);
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 2, eflags: 0x0
// Checksum 0xbfb7264f, Offset: 0x240
// Size: 0x28
function set_decay(player, value) {
    [[ self ]]->set_decay(player, value);
}

