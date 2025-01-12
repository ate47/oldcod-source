#using scripts\core_common\lui_shared;

#namespace mp_gamemode_onslaught_bossalert_msg;

// Namespace mp_gamemode_onslaught_bossalert_msg
// Method(s) 7 Total 13
class class_442ed2b4 : cluielem {

    // Namespace namespace_442ed2b4/mp_gamemode_onslaught_bossalert_msg
    // Params 1, eflags: 0x0
    // Checksum 0x7ee0b716, Offset: 0x438
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_442ed2b4/mp_gamemode_onslaught_bossalert_msg
    // Params 0, eflags: 0x0
    // Checksum 0xfa5755ba, Offset: 0x3b8
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("mp_gamemode_onslaught_bossalert_msg");
    }

    // Namespace namespace_442ed2b4/mp_gamemode_onslaught_bossalert_msg
    // Params 1, eflags: 0x0
    // Checksum 0xaa32c469, Offset: 0x360
    // Size: 0x4c
    function setup_clientfields(*var_ef8933e3) {
        cluielem::setup_clientfields("mp_gamemode_onslaught_bossalert_msg");
        cluielem::function_dcb34c80("string", "bossAlertText", 1);
    }

    // Namespace namespace_442ed2b4/mp_gamemode_onslaught_bossalert_msg
    // Params 2, eflags: 0x0
    // Checksum 0x4d7bdc22, Offset: 0x468
    // Size: 0x30
    function function_b73d2d7c(localclientnum, value) {
        set_data(localclientnum, "bossAlertText", value);
    }

    // Namespace namespace_442ed2b4/mp_gamemode_onslaught_bossalert_msg
    // Params 1, eflags: 0x0
    // Checksum 0x88594fa7, Offset: 0x3e0
    // Size: 0x4c
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "bossAlertText", #"");
    }

}

// Namespace mp_gamemode_onslaught_bossalert_msg/mp_gamemode_onslaught_bossalert_msg
// Params 1, eflags: 0x0
// Checksum 0x2d343084, Offset: 0xd8
// Size: 0x176
function register(var_ef8933e3) {
    elem = new class_442ed2b4();
    [[ elem ]]->setup_clientfields(var_ef8933e3);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"mp_gamemode_onslaught_bossalert_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_bossalert_msg"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"mp_gamemode_onslaught_bossalert_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_bossalert_msg"] = [];
    } else if (!isarray(level.var_ae746e8f[#"mp_gamemode_onslaught_bossalert_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_bossalert_msg"] = array(level.var_ae746e8f[#"mp_gamemode_onslaught_bossalert_msg"]);
    }
    level.var_ae746e8f[#"mp_gamemode_onslaught_bossalert_msg"][level.var_ae746e8f[#"mp_gamemode_onslaught_bossalert_msg"].size] = elem;
}

// Namespace mp_gamemode_onslaught_bossalert_msg/mp_gamemode_onslaught_bossalert_msg
// Params 0, eflags: 0x0
// Checksum 0xf17e364e, Offset: 0x258
// Size: 0x34
function register_clientside() {
    elem = new class_442ed2b4();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace mp_gamemode_onslaught_bossalert_msg/mp_gamemode_onslaught_bossalert_msg
// Params 1, eflags: 0x0
// Checksum 0x4d68e832, Offset: 0x298
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace mp_gamemode_onslaught_bossalert_msg/mp_gamemode_onslaught_bossalert_msg
// Params 1, eflags: 0x0
// Checksum 0x81a2f072, Offset: 0x2c0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_gamemode_onslaught_bossalert_msg/mp_gamemode_onslaught_bossalert_msg
// Params 1, eflags: 0x0
// Checksum 0x26f3c122, Offset: 0x2e8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace mp_gamemode_onslaught_bossalert_msg/mp_gamemode_onslaught_bossalert_msg
// Params 2, eflags: 0x0
// Checksum 0x2f8fd441, Offset: 0x310
// Size: 0x28
function function_b73d2d7c(localclientnum, value) {
    [[ self ]]->function_b73d2d7c(localclientnum, value);
}

