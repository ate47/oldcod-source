#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace mp_gamemode_onslaught_bossalert_msg;

// Namespace mp_gamemode_onslaught_bossalert_msg
// Method(s) 6 Total 13
class class_442ed2b4 : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_442ed2b4/mp_gamemode_onslaught_bossalert_msg
    // Params 2, eflags: 0x0
    // Checksum 0x9f97df77, Offset: 0x250
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_442ed2b4/mp_gamemode_onslaught_bossalert_msg
    // Params 1, eflags: 0x0
    // Checksum 0xf982f2f5, Offset: 0x298
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_442ed2b4/mp_gamemode_onslaught_bossalert_msg
    // Params 0, eflags: 0x0
    // Checksum 0xf7b69b01, Offset: 0x200
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("mp_gamemode_onslaught_bossalert_msg");
        cluielem::function_dcb34c80("string", "bossAlertText", 1);
    }

    // Namespace namespace_442ed2b4/mp_gamemode_onslaught_bossalert_msg
    // Params 2, eflags: 0x0
    // Checksum 0x4592a6d4, Offset: 0x2c8
    // Size: 0x44
    function function_b73d2d7c(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "bossAlertText", value);
    }

}

// Namespace mp_gamemode_onslaught_bossalert_msg/mp_gamemode_onslaught_bossalert_msg
// Params 0, eflags: 0x0
// Checksum 0x38642cc2, Offset: 0xe0
// Size: 0x34
function register() {
    elem = new class_442ed2b4();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace mp_gamemode_onslaught_bossalert_msg/mp_gamemode_onslaught_bossalert_msg
// Params 2, eflags: 0x0
// Checksum 0xab93d0f6, Offset: 0x120
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace mp_gamemode_onslaught_bossalert_msg/mp_gamemode_onslaught_bossalert_msg
// Params 1, eflags: 0x0
// Checksum 0x2f3c9e91, Offset: 0x160
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_gamemode_onslaught_bossalert_msg/mp_gamemode_onslaught_bossalert_msg
// Params 1, eflags: 0x0
// Checksum 0x54a16eec, Offset: 0x188
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace mp_gamemode_onslaught_bossalert_msg/mp_gamemode_onslaught_bossalert_msg
// Params 2, eflags: 0x0
// Checksum 0x27a14ca4, Offset: 0x1b0
// Size: 0x28
function function_b73d2d7c(player, value) {
    [[ self ]]->function_b73d2d7c(player, value);
}

