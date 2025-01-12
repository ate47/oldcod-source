#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace remote_missile_targets;

// Namespace remote_missile_targets
// Method(s) 9 Total 16
class cremote_missile_targets : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0xad04fcff, Offset: 0x388
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0x58f0fe7a, Offset: 0x400
    // Size: 0x44
    function set_player_target_active(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "player_target_active", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 1, eflags: 0x0
    // Checksum 0xc69356aa, Offset: 0x3d0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0xe9d68301, Offset: 0x4a0
    // Size: 0x44
    function set_extra_target_2(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "extra_target_2", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 0, eflags: 0x0
    // Checksum 0xebb53845, Offset: 0x2c0
    // Size: 0xbc
    function setup_clientfields() {
        cluielem::setup_clientfields("remote_missile_targets");
        cluielem::add_clientfield("player_target_active", 1, 16, "int");
        cluielem::add_clientfield("extra_target_1", 1, 10, "int");
        cluielem::add_clientfield("extra_target_2", 1, 10, "int");
        cluielem::add_clientfield("extra_target_3", 1, 10, "int");
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0xf4bdf1b7, Offset: 0x450
    // Size: 0x44
    function set_extra_target_1(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "extra_target_1", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0x8a67fa14, Offset: 0x4f0
    // Size: 0x44
    function set_extra_target_3(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "extra_target_3", value);
    }

}

// Namespace remote_missile_targets/remote_missile_targets
// Params 0, eflags: 0x0
// Checksum 0xc9ffad6d, Offset: 0x110
// Size: 0x34
function register() {
    elem = new cremote_missile_targets();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0x3a3edadf, Offset: 0x150
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0xdd84b28a, Offset: 0x190
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0x800f7339, Offset: 0x1b8
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0xea11640, Offset: 0x1e0
// Size: 0x28
function set_player_target_active(player, value) {
    [[ self ]]->set_player_target_active(player, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0xbd6c3496, Offset: 0x210
// Size: 0x28
function set_extra_target_1(player, value) {
    [[ self ]]->set_extra_target_1(player, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0x90706e68, Offset: 0x240
// Size: 0x28
function set_extra_target_2(player, value) {
    [[ self ]]->set_extra_target_2(player, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0xcd9ae7c8, Offset: 0x270
// Size: 0x28
function set_extra_target_3(player, value) {
    [[ self ]]->set_extra_target_3(player, value);
}

