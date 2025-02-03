#using scripts\core_common\lui_shared;

#namespace remote_missile_target_lockon;

// Namespace remote_missile_target_lockon
// Method(s) 11 Total 18
class cremote_missile_target_lockon : cluielem {

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 1, eflags: 0x0
    // Checksum 0xa94f41d8, Offset: 0x598
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0xd61f910e, Offset: 0x600
    // Size: 0x30
    function set_target_locked(localclientnum, value) {
        set_data(localclientnum, "target_locked", value);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x3f1902cc, Offset: 0x5c8
    // Size: 0x30
    function set_clientnum(localclientnum, value) {
        set_data(localclientnum, "clientnum", value);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0xca1f7d30, Offset: 0x638
    // Size: 0x30
    function set_ishawktag(localclientnum, value) {
        set_data(localclientnum, "isHawkTag", value);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 0, eflags: 0x0
    // Checksum 0x518bdf59, Offset: 0x4b8
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("remote_missile_target_lockon");
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x5737d06a, Offset: 0x6a8
    // Size: 0x30
    function function_7c227f6d(localclientnum, value) {
        set_data(localclientnum, "isVehicle", value);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 5, eflags: 0x0
    // Checksum 0x28390457, Offset: 0x468
    // Size: 0x44
    function setup_clientfields(*var_c05c67e2, *var_486334bd, *var_683d075d, *killedcallback, *var_f1a86fa1) {
        cluielem::setup_clientfields("remote_missile_target_lockon");
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x582d49a, Offset: 0x670
    // Size: 0x30
    function set_killed(localclientnum, value) {
        set_data(localclientnum, "killed", value);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 1, eflags: 0x0
    // Checksum 0x4a809034, Offset: 0x4e0
    // Size: 0xb0
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "clientnum", 0);
        set_data(localclientnum, "target_locked", 0);
        set_data(localclientnum, "isHawkTag", 0);
        set_data(localclientnum, "killed", 0);
        set_data(localclientnum, "isVehicle", 0);
    }

}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 5, eflags: 0x0
// Checksum 0xa5e9c243, Offset: 0xf8
// Size: 0x19e
function register(var_c05c67e2, var_486334bd, var_683d075d, killedcallback, var_f1a86fa1) {
    elem = new cremote_missile_target_lockon();
    [[ elem ]]->setup_clientfields(var_c05c67e2, var_486334bd, var_683d075d, killedcallback, var_f1a86fa1);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"remote_missile_target_lockon"])) {
        level.var_ae746e8f[#"remote_missile_target_lockon"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"remote_missile_target_lockon"])) {
        level.var_ae746e8f[#"remote_missile_target_lockon"] = [];
    } else if (!isarray(level.var_ae746e8f[#"remote_missile_target_lockon"])) {
        level.var_ae746e8f[#"remote_missile_target_lockon"] = array(level.var_ae746e8f[#"remote_missile_target_lockon"]);
    }
    level.var_ae746e8f[#"remote_missile_target_lockon"][level.var_ae746e8f[#"remote_missile_target_lockon"].size] = elem;
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 0, eflags: 0x0
// Checksum 0x5c16aaa9, Offset: 0x2a0
// Size: 0x34
function register_clientside() {
    elem = new cremote_missile_target_lockon();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 1, eflags: 0x0
// Checksum 0x2cc90300, Offset: 0x2e0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 1, eflags: 0x0
// Checksum 0xa0fffd47, Offset: 0x308
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 1, eflags: 0x0
// Checksum 0x169195de, Offset: 0x330
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0x521f13b3, Offset: 0x358
// Size: 0x28
function set_clientnum(localclientnum, value) {
    [[ self ]]->set_clientnum(localclientnum, value);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0xebde2586, Offset: 0x388
// Size: 0x28
function set_target_locked(localclientnum, value) {
    [[ self ]]->set_target_locked(localclientnum, value);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0x6c1e623a, Offset: 0x3b8
// Size: 0x28
function set_ishawktag(localclientnum, value) {
    [[ self ]]->set_ishawktag(localclientnum, value);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0x1df1d584, Offset: 0x3e8
// Size: 0x28
function set_killed(localclientnum, value) {
    [[ self ]]->set_killed(localclientnum, value);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0xf1527f5d, Offset: 0x418
// Size: 0x28
function function_7c227f6d(localclientnum, value) {
    [[ self ]]->function_7c227f6d(localclientnum, value);
}

