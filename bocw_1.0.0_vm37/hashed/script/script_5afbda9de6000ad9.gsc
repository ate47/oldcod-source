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
    // Checksum 0xfa5b53f1, Offset: 0x388
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0x5de8c6d, Offset: 0x400
    // Size: 0x44
    function set_player_target_active(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "player_target_active", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 1, eflags: 0x0
    // Checksum 0xfd1f4d39, Offset: 0x3d0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0xea0ec47e, Offset: 0x4a0
    // Size: 0x44
    function set_extra_target_2(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "extra_target_2", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 0, eflags: 0x0
    // Checksum 0x518df340, Offset: 0x2c0
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
    // Checksum 0x8de83214, Offset: 0x450
    // Size: 0x44
    function set_extra_target_1(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "extra_target_1", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0x6daa6149, Offset: 0x4f0
    // Size: 0x44
    function set_extra_target_3(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "extra_target_3", value);
    }

}

// Namespace remote_missile_targets/remote_missile_targets
// Params 0, eflags: 0x0
// Checksum 0x8869ca59, Offset: 0x110
// Size: 0x34
function register() {
    elem = new cremote_missile_targets();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0xf686c281, Offset: 0x150
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0xd32cc024, Offset: 0x190
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0xe31f81ed, Offset: 0x1b8
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0x896f24e7, Offset: 0x1e0
// Size: 0x28
function set_player_target_active(player, value) {
    [[ self ]]->set_player_target_active(player, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0x813676d8, Offset: 0x210
// Size: 0x28
function set_extra_target_1(player, value) {
    [[ self ]]->set_extra_target_1(player, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0x198293aa, Offset: 0x240
// Size: 0x28
function set_extra_target_2(player, value) {
    [[ self ]]->set_extra_target_2(player, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0x1137fcf4, Offset: 0x270
// Size: 0x28
function set_extra_target_3(player, value) {
    [[ self ]]->set_extra_target_3(player, value);
}

