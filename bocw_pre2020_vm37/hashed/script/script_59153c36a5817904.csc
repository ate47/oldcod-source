#using scripts\core_common\lui_shared;

#namespace mp_gamemode_onslaught_msg;

// Namespace mp_gamemode_onslaught_msg
// Method(s) 8 Total 14
class class_c24030b9 : cluielem {

    // Namespace namespace_c24030b9/mp_gamemode_onslaught_msg
    // Params 1, eflags: 0x0
    // Checksum 0xda3a1226, Offset: 0x4c8
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_c24030b9/mp_gamemode_onslaught_msg
    // Params 2, eflags: 0x0
    // Checksum 0xf618b064, Offset: 0x530
    // Size: 0x30
    function set_objpoints(localclientnum, value) {
        set_data(localclientnum, "objpoints", value);
    }

    // Namespace namespace_c24030b9/mp_gamemode_onslaught_msg
    // Params 0, eflags: 0x0
    // Checksum 0xdc48b6e8, Offset: 0x430
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("mp_gamemode_onslaught_msg");
    }

    // Namespace namespace_c24030b9/mp_gamemode_onslaught_msg
    // Params 2, eflags: 0x0
    // Checksum 0x8c45286d, Offset: 0x3a8
    // Size: 0x7c
    function setup_clientfields(*var_a584bc49, var_ea26adc8) {
        cluielem::setup_clientfields("mp_gamemode_onslaught_msg");
        cluielem::function_dcb34c80("string", "objectiveText", 1);
        cluielem::add_clientfield("objpoints", 1, 11, "int", var_ea26adc8);
    }

    // Namespace namespace_c24030b9/mp_gamemode_onslaught_msg
    // Params 2, eflags: 0x0
    // Checksum 0x5e45fa04, Offset: 0x4f8
    // Size: 0x30
    function set_objectivetext(localclientnum, value) {
        set_data(localclientnum, "objectiveText", value);
    }

    // Namespace namespace_c24030b9/mp_gamemode_onslaught_msg
    // Params 1, eflags: 0x0
    // Checksum 0xf8a23d3e, Offset: 0x458
    // Size: 0x68
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "objectiveText", #"");
        set_data(localclientnum, "objpoints", 0);
    }

}

// Namespace mp_gamemode_onslaught_msg/mp_gamemode_onslaught_msg
// Params 2, eflags: 0x0
// Checksum 0xebb7599c, Offset: 0xe8
// Size: 0x17e
function register(var_a584bc49, var_ea26adc8) {
    elem = new class_c24030b9();
    [[ elem ]]->setup_clientfields(var_a584bc49, var_ea26adc8);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"mp_gamemode_onslaught_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_msg"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"mp_gamemode_onslaught_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_msg"] = [];
    } else if (!isarray(level.var_ae746e8f[#"mp_gamemode_onslaught_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_msg"] = array(level.var_ae746e8f[#"mp_gamemode_onslaught_msg"]);
    }
    level.var_ae746e8f[#"mp_gamemode_onslaught_msg"][level.var_ae746e8f[#"mp_gamemode_onslaught_msg"].size] = elem;
}

// Namespace mp_gamemode_onslaught_msg/mp_gamemode_onslaught_msg
// Params 0, eflags: 0x0
// Checksum 0xea467eca, Offset: 0x270
// Size: 0x34
function register_clientside() {
    elem = new class_c24030b9();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace mp_gamemode_onslaught_msg/mp_gamemode_onslaught_msg
// Params 1, eflags: 0x0
// Checksum 0x315b08d9, Offset: 0x2b0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace mp_gamemode_onslaught_msg/mp_gamemode_onslaught_msg
// Params 1, eflags: 0x0
// Checksum 0xd22b3c08, Offset: 0x2d8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_gamemode_onslaught_msg/mp_gamemode_onslaught_msg
// Params 1, eflags: 0x0
// Checksum 0x2846769, Offset: 0x300
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace mp_gamemode_onslaught_msg/mp_gamemode_onslaught_msg
// Params 2, eflags: 0x0
// Checksum 0xb8a13fb7, Offset: 0x328
// Size: 0x28
function set_objectivetext(localclientnum, value) {
    [[ self ]]->set_objectivetext(localclientnum, value);
}

// Namespace mp_gamemode_onslaught_msg/mp_gamemode_onslaught_msg
// Params 2, eflags: 0x0
// Checksum 0xbe8edf99, Offset: 0x358
// Size: 0x28
function set_objpoints(localclientnum, value) {
    [[ self ]]->set_objpoints(localclientnum, value);
}

