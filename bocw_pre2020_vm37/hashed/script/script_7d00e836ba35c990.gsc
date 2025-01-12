#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace mp_gamemode_onslaught_msg;

// Namespace mp_gamemode_onslaught_msg
// Method(s) 7 Total 14
class class_c24030b9 : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_c24030b9/mp_gamemode_onslaught_msg
    // Params 2, eflags: 0x0
    // Checksum 0x611497cc, Offset: 0x2b8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_c24030b9/mp_gamemode_onslaught_msg
    // Params 2, eflags: 0x0
    // Checksum 0x230dce0c, Offset: 0x380
    // Size: 0x44
    function set_objpoints(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "objpoints", value);
    }

    // Namespace namespace_c24030b9/mp_gamemode_onslaught_msg
    // Params 1, eflags: 0x0
    // Checksum 0x9e7c0e3b, Offset: 0x300
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_c24030b9/mp_gamemode_onslaught_msg
    // Params 0, eflags: 0x0
    // Checksum 0xcf6d26e2, Offset: 0x240
    // Size: 0x6c
    function setup_clientfields() {
        cluielem::setup_clientfields("mp_gamemode_onslaught_msg");
        cluielem::function_dcb34c80("string", "objectiveText", 1);
        cluielem::add_clientfield("objpoints", 1, 11, "int");
    }

    // Namespace namespace_c24030b9/mp_gamemode_onslaught_msg
    // Params 2, eflags: 0x0
    // Checksum 0xccc2f8a9, Offset: 0x330
    // Size: 0x44
    function set_objectivetext(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "objectiveText", value);
    }

}

// Namespace mp_gamemode_onslaught_msg/mp_gamemode_onslaught_msg
// Params 0, eflags: 0x0
// Checksum 0xc70a3538, Offset: 0xf0
// Size: 0x34
function register() {
    elem = new class_c24030b9();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace mp_gamemode_onslaught_msg/mp_gamemode_onslaught_msg
// Params 2, eflags: 0x0
// Checksum 0x2d020860, Offset: 0x130
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace mp_gamemode_onslaught_msg/mp_gamemode_onslaught_msg
// Params 1, eflags: 0x0
// Checksum 0xfd201144, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_gamemode_onslaught_msg/mp_gamemode_onslaught_msg
// Params 1, eflags: 0x0
// Checksum 0xc0142567, Offset: 0x198
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace mp_gamemode_onslaught_msg/mp_gamemode_onslaught_msg
// Params 2, eflags: 0x0
// Checksum 0xb9f89ad0, Offset: 0x1c0
// Size: 0x28
function set_objectivetext(player, value) {
    [[ self ]]->set_objectivetext(player, value);
}

// Namespace mp_gamemode_onslaught_msg/mp_gamemode_onslaught_msg
// Params 2, eflags: 0x0
// Checksum 0xdca3be25, Offset: 0x1f0
// Size: 0x28
function set_objpoints(player, value) {
    [[ self ]]->set_objpoints(player, value);
}

