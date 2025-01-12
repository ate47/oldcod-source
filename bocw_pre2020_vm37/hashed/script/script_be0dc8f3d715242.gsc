#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace mp_gamemode_onslaught_endscore_msg;

// Namespace mp_gamemode_onslaught_endscore_msg
// Method(s) 9 Total 16
class class_4868ccea : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 2, eflags: 0x0
    // Checksum 0x17b4a674, Offset: 0x388
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 2, eflags: 0x0
    // Checksum 0x86913469, Offset: 0x450
    // Size: 0x44
    function function_4b3ad4c4(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "scorePoints", value);
    }

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 2, eflags: 0x0
    // Checksum 0xe35a51bf, Offset: 0x400
    // Size: 0x44
    function function_4b560c24(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "scoreText", value);
    }

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 1, eflags: 0x0
    // Checksum 0xd57a3a6f, Offset: 0x3d0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 0, eflags: 0x0
    // Checksum 0xb7bc975c, Offset: 0x2c0
    // Size: 0xbc
    function setup_clientfields() {
        cluielem::setup_clientfields("mp_gamemode_onslaught_endscore_msg");
        cluielem::function_dcb34c80("string", "scoreText", 1);
        cluielem::add_clientfield("scorePoints", 1, 11, "int");
        cluielem::function_dcb34c80("string", "score2Text", 1);
        cluielem::add_clientfield("score2Points", 1, 11, "int");
    }

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 2, eflags: 0x0
    // Checksum 0xd97862f5, Offset: 0x4f0
    // Size: 0x44
    function function_955431ec(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "score2Points", value);
    }

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 2, eflags: 0x0
    // Checksum 0xc8ba8786, Offset: 0x4a0
    // Size: 0x44
    function function_fc075317(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "score2Text", value);
    }

}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 0, eflags: 0x0
// Checksum 0xac6e1775, Offset: 0x110
// Size: 0x34
function register() {
    elem = new class_4868ccea();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 2, eflags: 0x0
// Checksum 0xca2e1c40, Offset: 0x150
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 1, eflags: 0x0
// Checksum 0x7c7778f0, Offset: 0x190
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 1, eflags: 0x0
// Checksum 0xa2ef2991, Offset: 0x1b8
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 2, eflags: 0x0
// Checksum 0x6cd04514, Offset: 0x1e0
// Size: 0x28
function function_4b560c24(player, value) {
    [[ self ]]->function_4b560c24(player, value);
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 2, eflags: 0x0
// Checksum 0x15bacf07, Offset: 0x210
// Size: 0x28
function function_4b3ad4c4(player, value) {
    [[ self ]]->function_4b3ad4c4(player, value);
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 2, eflags: 0x0
// Checksum 0x94b359c8, Offset: 0x240
// Size: 0x28
function function_fc075317(player, value) {
    [[ self ]]->function_fc075317(player, value);
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 2, eflags: 0x0
// Checksum 0x58bb8ab0, Offset: 0x270
// Size: 0x28
function function_955431ec(player, value) {
    [[ self ]]->function_955431ec(player, value);
}

