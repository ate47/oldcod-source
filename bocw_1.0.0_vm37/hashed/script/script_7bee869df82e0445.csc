#using scripts\core_common\lui_shared;

#namespace remote_missile_targets;

// Namespace remote_missile_targets
// Method(s) 10 Total 17
class cremote_missile_targets : cluielem {

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 1, eflags: 0x0
    // Checksum 0xed4fdb08, Offset: 0x5f0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0x214f610, Offset: 0x620
    // Size: 0x30
    function set_player_target_active(localclientnum, value) {
        set_data(localclientnum, "player_target_active", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 0, eflags: 0x0
    // Checksum 0x6e564fd, Offset: 0x528
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("remote_missile_targets");
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0x4150e276, Offset: 0x690
    // Size: 0x30
    function set_extra_target_2(localclientnum, value) {
        set_data(localclientnum, "extra_target_2", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 4, eflags: 0x0
    // Checksum 0x359de013, Offset: 0x440
    // Size: 0xdc
    function setup_clientfields(var_9318c80d, var_82a5247c, var_afbc846a, var_4c87c083) {
        cluielem::setup_clientfields("remote_missile_targets");
        cluielem::add_clientfield("player_target_active", 1, 16, "int", var_9318c80d);
        cluielem::add_clientfield("extra_target_1", 1, 10, "int", var_82a5247c);
        cluielem::add_clientfield("extra_target_2", 1, 10, "int", var_afbc846a);
        cluielem::add_clientfield("extra_target_3", 1, 10, "int", var_4c87c083);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0xb13f3907, Offset: 0x658
    // Size: 0x30
    function set_extra_target_1(localclientnum, value) {
        set_data(localclientnum, "extra_target_1", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 2, eflags: 0x0
    // Checksum 0x27e9c66c, Offset: 0x6c8
    // Size: 0x30
    function set_extra_target_3(localclientnum, value) {
        set_data(localclientnum, "extra_target_3", value);
    }

    // Namespace cremote_missile_targets/remote_missile_targets
    // Params 1, eflags: 0x0
    // Checksum 0x398372d4, Offset: 0x550
    // Size: 0x94
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "player_target_active", 0);
        set_data(localclientnum, "extra_target_1", 0);
        set_data(localclientnum, "extra_target_2", 0);
        set_data(localclientnum, "extra_target_3", 0);
    }

}

// Namespace remote_missile_targets/remote_missile_targets
// Params 4, eflags: 0x0
// Checksum 0xf1d87b6f, Offset: 0x108
// Size: 0x196
function register(var_9318c80d, var_82a5247c, var_afbc846a, var_4c87c083) {
    elem = new cremote_missile_targets();
    [[ elem ]]->setup_clientfields(var_9318c80d, var_82a5247c, var_afbc846a, var_4c87c083);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"remote_missile_targets"])) {
        level.var_ae746e8f[#"remote_missile_targets"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"remote_missile_targets"])) {
        level.var_ae746e8f[#"remote_missile_targets"] = [];
    } else if (!isarray(level.var_ae746e8f[#"remote_missile_targets"])) {
        level.var_ae746e8f[#"remote_missile_targets"] = array(level.var_ae746e8f[#"remote_missile_targets"]);
    }
    level.var_ae746e8f[#"remote_missile_targets"][level.var_ae746e8f[#"remote_missile_targets"].size] = elem;
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 0, eflags: 0x0
// Checksum 0x7e808c44, Offset: 0x2a8
// Size: 0x34
function register_clientside() {
    elem = new cremote_missile_targets();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0x898008f4, Offset: 0x2e8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0x89bd4542, Offset: 0x310
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 1, eflags: 0x0
// Checksum 0xaf00b28b, Offset: 0x338
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0xffe142ae, Offset: 0x360
// Size: 0x28
function set_player_target_active(localclientnum, value) {
    [[ self ]]->set_player_target_active(localclientnum, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0x19de9c2e, Offset: 0x390
// Size: 0x28
function set_extra_target_1(localclientnum, value) {
    [[ self ]]->set_extra_target_1(localclientnum, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0xd6198f2a, Offset: 0x3c0
// Size: 0x28
function set_extra_target_2(localclientnum, value) {
    [[ self ]]->set_extra_target_2(localclientnum, value);
}

// Namespace remote_missile_targets/remote_missile_targets
// Params 2, eflags: 0x0
// Checksum 0xb2690f07, Offset: 0x3f0
// Size: 0x28
function set_extra_target_3(localclientnum, value) {
    [[ self ]]->set_extra_target_3(localclientnum, value);
}

