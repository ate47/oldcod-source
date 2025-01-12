#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace remote_missile_targets;

// Namespace remote_missile_targets
// Method(s) 9 Total 16
class cremote_missile_targets : cluielem {

    var var_57a3d576;

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0xbf243c15, Offset: 0x4e0
    // Size: 0x3c
    function set_extra_target_3(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "extra_target_3", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0x830a643f, Offset: 0x498
    // Size: 0x3c
    function set_extra_target_2(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "extra_target_2", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0x81a50226, Offset: 0x450
    // Size: 0x3c
    function set_extra_target_1(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "extra_target_1", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0x30ab1275, Offset: 0x408
    // Size: 0x3c
    function set_player_target_active(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "player_target_active", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 1, eflags: 0x0
    // Checksum 0x8c15442c, Offset: 0x3d8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0x824f60b5, Offset: 0x388
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "remote_missile_targets", persistent);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 1, eflags: 0x0
    // Checksum 0x38436ed7, Offset: 0x2b8
    // Size: 0xc4
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("player_target_active", 1, 16, "int");
        cluielem::add_clientfield("extra_target_1", 1, 10, "int");
        cluielem::add_clientfield("extra_target_2", 1, 10, "int");
        cluielem::add_clientfield("extra_target_3", 1, 10, "int");
    }

}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0x58ba8011, Offset: 0x100
// Size: 0x40
function register(uid) {
    elem = new cremote_missile_targets();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0x5c863c5d, Offset: 0x148
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0xfe854b70, Offset: 0x188
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0x6653f96b, Offset: 0x1b0
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0x5dbc7fc0, Offset: 0x1d8
// Size: 0x28
function set_player_target_active(player, value) {
    [[ self ]]->set_player_target_active(player, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0x228ae0a7, Offset: 0x208
// Size: 0x28
function set_extra_target_1(player, value) {
    [[ self ]]->set_extra_target_1(player, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0xb9380c47, Offset: 0x238
// Size: 0x28
function set_extra_target_2(player, value) {
    [[ self ]]->set_extra_target_2(player, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0x880cdc91, Offset: 0x268
// Size: 0x28
function set_extra_target_3(player, value) {
    [[ self ]]->set_extra_target_3(player, value);
}

