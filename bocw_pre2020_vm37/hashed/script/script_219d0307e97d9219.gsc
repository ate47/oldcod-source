#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace mp_gamemode_onslaught_score_msg;

// Namespace mp_gamemode_onslaught_score_msg
// Method(s) 13 Total 20
class class_e22be003 : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 2, eflags: 0x0
    // Checksum 0xada45bbc, Offset: 0x508
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 2, eflags: 0x0
    // Checksum 0x8c160c6b, Offset: 0x6c0
    // Size: 0x44
    function function_2a0b1f84(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "score3Points", value);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 2, eflags: 0x0
    // Checksum 0xebe6e159, Offset: 0x5d0
    // Size: 0x44
    function function_4b3ad4c4(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "scorePoints", value);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 2, eflags: 0x0
    // Checksum 0xc27039f4, Offset: 0x580
    // Size: 0x44
    function function_4b560c24(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "scoreText", value);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 1, eflags: 0x0
    // Checksum 0x904a2aa8, Offset: 0x7a0
    // Size: 0x3c
    function function_4bfdafeb(player) {
        player clientfield::function_bb878fc3(var_d5213cbb, var_bf9c8c95, "moveorb");
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 1, eflags: 0x0
    // Checksum 0xe945870f, Offset: 0x550
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 0, eflags: 0x0
    // Checksum 0x9187dd82, Offset: 0x3a0
    // Size: 0x15c
    function setup_clientfields() {
        cluielem::setup_clientfields("mp_gamemode_onslaught_score_msg");
        cluielem::function_dcb34c80("string", "scoreText", 1);
        cluielem::add_clientfield("scorePoints", 1, 11, "int");
        cluielem::function_dcb34c80("string", "score2Text", 1);
        cluielem::add_clientfield("score2Points", 1, 11, "int");
        cluielem::add_clientfield("score3Points", 1, 8, "int");
        cluielem::add_clientfield("powerup", 1, 1, "counter");
        cluielem::add_clientfield("lowpower", 1, 1, "counter");
        cluielem::add_clientfield("moveorb", 1, 1, "counter");
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 1, eflags: 0x0
    // Checksum 0x37deabd4, Offset: 0x710
    // Size: 0x3c
    function function_94b2b0bd(player) {
        player clientfield::function_bb878fc3(var_d5213cbb, var_bf9c8c95, "powerup");
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 2, eflags: 0x0
    // Checksum 0xe3135bac, Offset: 0x670
    // Size: 0x44
    function function_955431ec(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "score2Points", value);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 1, eflags: 0x0
    // Checksum 0xf4bc4ec6, Offset: 0x758
    // Size: 0x3c
    function function_d74c17ab(player) {
        player clientfield::function_bb878fc3(var_d5213cbb, var_bf9c8c95, "lowpower");
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 2, eflags: 0x0
    // Checksum 0x2d85e010, Offset: 0x620
    // Size: 0x44
    function function_fc075317(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "score2Text", value);
    }

}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 0, eflags: 0x0
// Checksum 0xfe8409b0, Offset: 0x148
// Size: 0x34
function register() {
    elem = new class_e22be003();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 2, eflags: 0x0
// Checksum 0xf9df25c3, Offset: 0x188
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 1, eflags: 0x0
// Checksum 0x94bac228, Offset: 0x1c8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 1, eflags: 0x0
// Checksum 0x2ab077a3, Offset: 0x1f0
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 2, eflags: 0x0
// Checksum 0x8e8bb30c, Offset: 0x218
// Size: 0x28
function function_4b560c24(player, value) {
    [[ self ]]->function_4b560c24(player, value);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 2, eflags: 0x0
// Checksum 0x26837650, Offset: 0x248
// Size: 0x28
function function_4b3ad4c4(player, value) {
    [[ self ]]->function_4b3ad4c4(player, value);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 2, eflags: 0x0
// Checksum 0x504ab592, Offset: 0x278
// Size: 0x28
function function_fc075317(player, value) {
    [[ self ]]->function_fc075317(player, value);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 2, eflags: 0x0
// Checksum 0xff031fb7, Offset: 0x2a8
// Size: 0x28
function function_955431ec(player, value) {
    [[ self ]]->function_955431ec(player, value);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 2, eflags: 0x0
// Checksum 0xb1a722a3, Offset: 0x2d8
// Size: 0x28
function function_2a0b1f84(player, value) {
    [[ self ]]->function_2a0b1f84(player, value);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 1, eflags: 0x0
// Checksum 0x6340e8fa, Offset: 0x308
// Size: 0x1c
function function_94b2b0bd(player) {
    [[ self ]]->function_94b2b0bd(player);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 1, eflags: 0x0
// Checksum 0x86c469e9, Offset: 0x330
// Size: 0x1c
function function_d74c17ab(player) {
    [[ self ]]->function_d74c17ab(player);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 1, eflags: 0x0
// Checksum 0xbfd612c4, Offset: 0x358
// Size: 0x1c
function function_4bfdafeb(player) {
    [[ self ]]->function_4bfdafeb(player);
}

