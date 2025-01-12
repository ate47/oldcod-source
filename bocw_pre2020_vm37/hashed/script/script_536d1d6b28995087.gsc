#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace mp_gamemode_onslaught_2nd_msg;

// Namespace mp_gamemode_onslaught_2nd_msg
// Method(s) 7 Total 14
class class_43514e12 : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_43514e12/mp_gamemode_onslaught_2nd_msg
    // Params 2, eflags: 0x0
    // Checksum 0x8c5d59d1, Offset: 0x2b8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_43514e12/mp_gamemode_onslaught_2nd_msg
    // Params 1, eflags: 0x0
    // Checksum 0x58c41e8d, Offset: 0x300
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_43514e12/mp_gamemode_onslaught_2nd_msg
    // Params 0, eflags: 0x0
    // Checksum 0x3f1d41f, Offset: 0x240
    // Size: 0x6c
    function setup_clientfields() {
        cluielem::setup_clientfields("mp_gamemode_onslaught_2nd_msg");
        cluielem::function_dcb34c80("string", "objective2Text", 1);
        cluielem::add_clientfield("obj2points", 1, 11, "int");
    }

    // Namespace namespace_43514e12/mp_gamemode_onslaught_2nd_msg
    // Params 2, eflags: 0x0
    // Checksum 0x511deb54, Offset: 0x330
    // Size: 0x44
    function function_9c1c0811(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "objective2Text", value);
    }

    // Namespace namespace_43514e12/mp_gamemode_onslaught_2nd_msg
    // Params 2, eflags: 0x0
    // Checksum 0x970e2860, Offset: 0x380
    // Size: 0x44
    function function_d9092332(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "obj2points", value);
    }

}

// Namespace mp_gamemode_onslaught_2nd_msg/mp_gamemode_onslaught_2nd_msg
// Params 0, eflags: 0x0
// Checksum 0x33575ef6, Offset: 0xf0
// Size: 0x34
function register() {
    elem = new class_43514e12();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace mp_gamemode_onslaught_2nd_msg/mp_gamemode_onslaught_2nd_msg
// Params 2, eflags: 0x0
// Checksum 0xab93d0f6, Offset: 0x130
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace mp_gamemode_onslaught_2nd_msg/mp_gamemode_onslaught_2nd_msg
// Params 1, eflags: 0x0
// Checksum 0x2f3c9e91, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_gamemode_onslaught_2nd_msg/mp_gamemode_onslaught_2nd_msg
// Params 1, eflags: 0x0
// Checksum 0x54a16eec, Offset: 0x198
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace mp_gamemode_onslaught_2nd_msg/mp_gamemode_onslaught_2nd_msg
// Params 2, eflags: 0x0
// Checksum 0x8b2b2773, Offset: 0x1c0
// Size: 0x28
function function_9c1c0811(player, value) {
    [[ self ]]->function_9c1c0811(player, value);
}

// Namespace mp_gamemode_onslaught_2nd_msg/mp_gamemode_onslaught_2nd_msg
// Params 2, eflags: 0x0
// Checksum 0xb8095bfe, Offset: 0x1f0
// Size: 0x28
function function_d9092332(player, value) {
    [[ self ]]->function_d9092332(player, value);
}

