#using scripts\core_common\lui_shared;

#namespace remote_missile_targets;

// Namespace remote_missile_targets
// Method(s) 10 Total 16
class cremote_missile_targets : cluielem {

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0x2c2103b, Offset: 0x598
    // Size: 0x30
    function set_extra_target_3(localclientnum, value) {
        set_data(localclientnum, "extra_target_3", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0xf5f2de62, Offset: 0x560
    // Size: 0x30
    function set_extra_target_2(localclientnum, value) {
        set_data(localclientnum, "extra_target_2", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0xd56b9835, Offset: 0x528
    // Size: 0x30
    function set_extra_target_1(localclientnum, value) {
        set_data(localclientnum, "extra_target_1", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0x34097c26, Offset: 0x4f0
    // Size: 0x30
    function set_player_target_active(localclientnum, value) {
        set_data(localclientnum, "player_target_active", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 1, eflags: 0x0
    // Checksum 0x2caf4cd7, Offset: 0x4b8
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"remote_missile_targets");
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 1, eflags: 0x0
    // Checksum 0x69ba605, Offset: 0x418
    // Size: 0x94
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "player_target_active", 0);
        set_data(localclientnum, "extra_target_1", 0);
        set_data(localclientnum, "extra_target_2", 0);
        set_data(localclientnum, "extra_target_3", 0);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 1, eflags: 0x0
    // Checksum 0x107bc0ef, Offset: 0x3e8
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 5, eflags: 0x0
    // Checksum 0x3c5cd802, Offset: 0x2f8
    // Size: 0xe4
    function setup_clientfields(uid, var_e06994a2, var_aecd9fd2, var_79bd7b45, var_9feff018) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("player_target_active", 1, 16, "int", var_e06994a2);
        cluielem::add_clientfield("extra_target_1", 1, 10, "int", var_aecd9fd2);
        cluielem::add_clientfield("extra_target_2", 1, 10, "int", var_79bd7b45);
        cluielem::add_clientfield("extra_target_3", 1, 10, "int", var_9feff018);
    }

}

// Namespace remote_missile_targets/remote_missile_targets
// Params 5, eflags: 0x0
// Checksum 0x22f5cb52, Offset: 0xe0
// Size: 0x70
function register(uid, var_e06994a2, var_aecd9fd2, var_79bd7b45, var_9feff018) {
    elem = new cremote_missile_targets();
    [[ elem ]]->setup_clientfields(uid, var_e06994a2, var_aecd9fd2, var_79bd7b45, var_9feff018);
    return elem;
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0xc82e5cb6, Offset: 0x158
// Size: 0x40
function register_clientside(uid) {
    elem = new cremote_missile_targets();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0x9275cf40, Offset: 0x1a0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0x641deed4, Offset: 0x1c8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0x86227ac5, Offset: 0x1f0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0x4183dacc, Offset: 0x218
// Size: 0x28
function set_player_target_active(localclientnum, value) {
    [[ self ]]->set_player_target_active(localclientnum, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0xaec78530, Offset: 0x248
// Size: 0x28
function set_extra_target_1(localclientnum, value) {
    [[ self ]]->set_extra_target_1(localclientnum, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0xcedf14, Offset: 0x278
// Size: 0x28
function set_extra_target_2(localclientnum, value) {
    [[ self ]]->set_extra_target_2(localclientnum, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0x1c8a4313, Offset: 0x2a8
// Size: 0x28
function set_extra_target_3(localclientnum, value) {
    [[ self ]]->set_extra_target_3(localclientnum, value);
}

