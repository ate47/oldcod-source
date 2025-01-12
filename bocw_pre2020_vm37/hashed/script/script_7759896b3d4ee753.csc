#using scripts\core_common\lui_shared;

#namespace mp_gamemode_onslaught_2nd_msg;

// Namespace mp_gamemode_onslaught_2nd_msg
// Method(s) 8 Total 14
class class_43514e12 : cluielem {

    // Namespace namespace_43514e12/mp_gamemode_onslaught_2nd_msg
    // Params 1, eflags: 0x0
    // Checksum 0x60102544, Offset: 0x4c8
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_43514e12/mp_gamemode_onslaught_2nd_msg
    // Params 0, eflags: 0x0
    // Checksum 0xaf184a32, Offset: 0x430
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("mp_gamemode_onslaught_2nd_msg");
    }

    // Namespace namespace_43514e12/mp_gamemode_onslaught_2nd_msg
    // Params 2, eflags: 0x0
    // Checksum 0x42a70ffa, Offset: 0x3a8
    // Size: 0x7c
    function setup_clientfields(*var_61963aa5, var_242b1cea) {
        cluielem::setup_clientfields("mp_gamemode_onslaught_2nd_msg");
        cluielem::function_dcb34c80("string", "objective2Text", 1);
        cluielem::add_clientfield("obj2points", 1, 11, "int", var_242b1cea);
    }

    // Namespace namespace_43514e12/mp_gamemode_onslaught_2nd_msg
    // Params 2, eflags: 0x0
    // Checksum 0x7c491033, Offset: 0x4f8
    // Size: 0x30
    function function_9c1c0811(localclientnum, value) {
        set_data(localclientnum, "objective2Text", value);
    }

    // Namespace namespace_43514e12/mp_gamemode_onslaught_2nd_msg
    // Params 2, eflags: 0x0
    // Checksum 0x9f65feea, Offset: 0x530
    // Size: 0x30
    function function_d9092332(localclientnum, value) {
        set_data(localclientnum, "obj2points", value);
    }

    // Namespace namespace_43514e12/mp_gamemode_onslaught_2nd_msg
    // Params 1, eflags: 0x0
    // Checksum 0x132099b3, Offset: 0x458
    // Size: 0x68
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "objective2Text", #"");
        set_data(localclientnum, "obj2points", 0);
    }

}

// Namespace mp_gamemode_onslaught_2nd_msg/mp_gamemode_onslaught_2nd_msg
// Params 2, eflags: 0x0
// Checksum 0x31e244f6, Offset: 0xe8
// Size: 0x17e
function register(var_61963aa5, var_242b1cea) {
    elem = new class_43514e12();
    [[ elem ]]->setup_clientfields(var_61963aa5, var_242b1cea);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"mp_gamemode_onslaught_2nd_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_2nd_msg"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"mp_gamemode_onslaught_2nd_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_2nd_msg"] = [];
    } else if (!isarray(level.var_ae746e8f[#"mp_gamemode_onslaught_2nd_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_2nd_msg"] = array(level.var_ae746e8f[#"mp_gamemode_onslaught_2nd_msg"]);
    }
    level.var_ae746e8f[#"mp_gamemode_onslaught_2nd_msg"][level.var_ae746e8f[#"mp_gamemode_onslaught_2nd_msg"].size] = elem;
}

// Namespace mp_gamemode_onslaught_2nd_msg/mp_gamemode_onslaught_2nd_msg
// Params 0, eflags: 0x0
// Checksum 0xe4a27c06, Offset: 0x270
// Size: 0x34
function register_clientside() {
    elem = new class_43514e12();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace mp_gamemode_onslaught_2nd_msg/mp_gamemode_onslaught_2nd_msg
// Params 1, eflags: 0x0
// Checksum 0x1ca8a50a, Offset: 0x2b0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace mp_gamemode_onslaught_2nd_msg/mp_gamemode_onslaught_2nd_msg
// Params 1, eflags: 0x0
// Checksum 0x73ccee03, Offset: 0x2d8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_gamemode_onslaught_2nd_msg/mp_gamemode_onslaught_2nd_msg
// Params 1, eflags: 0x0
// Checksum 0xd8a6ddbc, Offset: 0x300
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace mp_gamemode_onslaught_2nd_msg/mp_gamemode_onslaught_2nd_msg
// Params 2, eflags: 0x0
// Checksum 0x72ffe049, Offset: 0x328
// Size: 0x28
function function_9c1c0811(localclientnum, value) {
    [[ self ]]->function_9c1c0811(localclientnum, value);
}

// Namespace mp_gamemode_onslaught_2nd_msg/mp_gamemode_onslaught_2nd_msg
// Params 2, eflags: 0x0
// Checksum 0x4d762ad5, Offset: 0x358
// Size: 0x28
function function_d9092332(localclientnum, value) {
    [[ self ]]->function_d9092332(localclientnum, value);
}

