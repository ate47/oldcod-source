#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace luielem_entity_bar;

// Namespace luielem_entity_bar
// Method(s) 13 Total 20
class class_276088fe : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x71404e41, Offset: 0x508
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x5a0c74f7, Offset: 0x820
    // Size: 0x44
    function function_4f6e830d(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "offset_y", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 1, eflags: 0x0
    // Checksum 0x9f4e8eb1, Offset: 0x550
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x239aa839, Offset: 0x7d0
    // Size: 0x44
    function function_61312692(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "offset_x", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0xf09a6c41, Offset: 0x870
    // Size: 0x44
    function function_7ddfdfef(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "offset_z", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 0, eflags: 0x0
    // Checksum 0xa6087ff, Offset: 0x3a0
    // Size: 0x15c
    function setup_clientfields() {
        cluielem::setup_clientfields("LUIelem_entity_bar");
        cluielem::add_clientfield("_state", 1, 3, "int");
        cluielem::add_clientfield("progress_percent", 1, 7, "float");
        cluielem::add_clientfield("entnum", 1, 7, "int");
        cluielem::add_clientfield("offset_x", 1, 6, "int");
        cluielem::add_clientfield("offset_y", 1, 6, "int");
        cluielem::add_clientfield("offset_z", 1, 6, "int");
        cluielem::add_clientfield("entityClamp", 1, 1, "int");
        cluielem::add_clientfield("entityScale", 1, 1, "int");
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x2af0a39b, Offset: 0x910
    // Size: 0x44
    function function_a9793a65(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "entityScale", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x5cdff9eb, Offset: 0x780
    // Size: 0x44
    function set_entnum(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "entnum", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x4438e5f0, Offset: 0x580
    // Size: 0x1a4
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 0);
            return;
        }
        if (#"friendlyblue" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 1);
            return;
        }
        if (#"green" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 2);
            return;
        }
        if (#"yellow" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 3);
            return;
        }
        if (#"red" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 4);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0xce96cb0f, Offset: 0x8c0
    // Size: 0x44
    function function_dfed4b05(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "entityClamp", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0xd49ab730, Offset: 0x730
    // Size: 0x44
    function function_ecacbaa5(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "progress_percent", value);
    }

}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 0, eflags: 0x0
// Checksum 0xfce7924, Offset: 0x130
// Size: 0x34
function register() {
    elem = new class_276088fe();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0xcd520476, Offset: 0x170
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 1, eflags: 0x0
// Checksum 0x2ecba694, Offset: 0x1b0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 1, eflags: 0x0
// Checksum 0x12f52bff, Offset: 0x1d8
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0xbc94c045, Offset: 0x200
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x5868164e, Offset: 0x230
// Size: 0x28
function function_ecacbaa5(player, value) {
    [[ self ]]->function_ecacbaa5(player, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x1be7587d, Offset: 0x260
// Size: 0x28
function set_entnum(player, value) {
    [[ self ]]->set_entnum(player, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0xa9140b2a, Offset: 0x290
// Size: 0x28
function function_61312692(player, value) {
    [[ self ]]->function_61312692(player, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0xdbf554d0, Offset: 0x2c0
// Size: 0x28
function function_4f6e830d(player, value) {
    [[ self ]]->function_4f6e830d(player, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x278380a8, Offset: 0x2f0
// Size: 0x28
function function_7ddfdfef(player, value) {
    [[ self ]]->function_7ddfdfef(player, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0xeeaac616, Offset: 0x320
// Size: 0x28
function function_dfed4b05(player, value) {
    [[ self ]]->function_dfed4b05(player, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0xe2e58a67, Offset: 0x350
// Size: 0x28
function function_a9793a65(player, value) {
    [[ self ]]->function_a9793a65(player, value);
}

