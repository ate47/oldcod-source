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
    // Checksum 0xba240c3d, Offset: 0x508
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x5ceef102, Offset: 0x820
    // Size: 0x44
    function function_4f6e830d(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "offset_y", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 1, eflags: 0x0
    // Checksum 0x9d95cf36, Offset: 0x550
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0xe797941a, Offset: 0x7d0
    // Size: 0x44
    function function_61312692(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "offset_x", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x564f125, Offset: 0x870
    // Size: 0x44
    function function_7ddfdfef(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "offset_z", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 0, eflags: 0x0
    // Checksum 0xedfe4419, Offset: 0x3a0
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
    // Checksum 0xfe29f736, Offset: 0x910
    // Size: 0x44
    function function_a9793a65(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "entityScale", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x7dbb0947, Offset: 0x780
    // Size: 0x44
    function set_entnum(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "entnum", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x693d1305, Offset: 0x580
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
    // Checksum 0xe8d929fa, Offset: 0x8c0
    // Size: 0x44
    function function_dfed4b05(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "entityClamp", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0xbbe4d068, Offset: 0x730
    // Size: 0x44
    function function_ecacbaa5(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "progress_percent", value);
    }

}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 0, eflags: 0x0
// Checksum 0x4e581e10, Offset: 0x130
// Size: 0x34
function register() {
    elem = new class_276088fe();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x1ea1c28, Offset: 0x170
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 1, eflags: 0x0
// Checksum 0x2063d43a, Offset: 0x1b0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 1, eflags: 0x0
// Checksum 0x71e5d92b, Offset: 0x1d8
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x3b5af2e2, Offset: 0x200
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x64325400, Offset: 0x230
// Size: 0x28
function function_ecacbaa5(player, value) {
    [[ self ]]->function_ecacbaa5(player, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x9215a5bf, Offset: 0x260
// Size: 0x28
function set_entnum(player, value) {
    [[ self ]]->set_entnum(player, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x75b91016, Offset: 0x290
// Size: 0x28
function function_61312692(player, value) {
    [[ self ]]->function_61312692(player, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x4cb3d64b, Offset: 0x2c0
// Size: 0x28
function function_4f6e830d(player, value) {
    [[ self ]]->function_4f6e830d(player, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0xf214b409, Offset: 0x2f0
// Size: 0x28
function function_7ddfdfef(player, value) {
    [[ self ]]->function_7ddfdfef(player, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0xe7ebdb39, Offset: 0x320
// Size: 0x28
function function_dfed4b05(player, value) {
    [[ self ]]->function_dfed4b05(player, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x599c4cf4, Offset: 0x350
// Size: 0x28
function function_a9793a65(player, value) {
    [[ self ]]->function_a9793a65(player, value);
}

