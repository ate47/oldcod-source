#using scripts\core_common\lui_shared;

#namespace mp_gamemode_onslaught_endscore_msg;

// Namespace mp_gamemode_onslaught_endscore_msg
// Method(s) 10 Total 16
class class_4868ccea : cluielem {

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 1, eflags: 0x0
    // Checksum 0x9d36c95d, Offset: 0x608
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 2, eflags: 0x0
    // Checksum 0x9c6598b0, Offset: 0x670
    // Size: 0x30
    function function_4b3ad4c4(localclientnum, value) {
        set_data(localclientnum, "scorePoints", value);
    }

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 2, eflags: 0x0
    // Checksum 0xde8cf4eb, Offset: 0x638
    // Size: 0x30
    function function_4b560c24(localclientnum, value) {
        set_data(localclientnum, "scoreText", value);
    }

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 0, eflags: 0x0
    // Checksum 0xa0cbc640, Offset: 0x528
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("mp_gamemode_onslaught_endscore_msg");
    }

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 4, eflags: 0x0
    // Checksum 0x233472a8, Offset: 0x440
    // Size: 0xdc
    function setup_clientfields(*var_ae3230db, var_3b37d9b6, *var_edd1ee8c, var_215262d5) {
        cluielem::setup_clientfields("mp_gamemode_onslaught_endscore_msg");
        cluielem::function_dcb34c80("string", "scoreText", 1);
        cluielem::add_clientfield("scorePoints", 1, 11, "int", var_edd1ee8c);
        cluielem::function_dcb34c80("string", "score2Text", 1);
        cluielem::add_clientfield("score2Points", 1, 11, "int", var_215262d5);
    }

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 2, eflags: 0x0
    // Checksum 0xcac0ebfd, Offset: 0x6e0
    // Size: 0x30
    function function_955431ec(localclientnum, value) {
        set_data(localclientnum, "score2Points", value);
    }

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 1, eflags: 0x0
    // Checksum 0x8e21cac8, Offset: 0x550
    // Size: 0xb0
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "scoreText", #"");
        set_data(localclientnum, "scorePoints", 0);
        set_data(localclientnum, "score2Text", #"");
        set_data(localclientnum, "score2Points", 0);
    }

    // Namespace namespace_4868ccea/mp_gamemode_onslaught_endscore_msg
    // Params 2, eflags: 0x0
    // Checksum 0x7e12b2cc, Offset: 0x6a8
    // Size: 0x30
    function function_fc075317(localclientnum, value) {
        set_data(localclientnum, "score2Text", value);
    }

}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 4, eflags: 0x0
// Checksum 0xad3a66ef, Offset: 0x108
// Size: 0x196
function register(var_ae3230db, var_3b37d9b6, var_edd1ee8c, var_215262d5) {
    elem = new class_4868ccea();
    [[ elem ]]->setup_clientfields(var_ae3230db, var_3b37d9b6, var_edd1ee8c, var_215262d5);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"mp_gamemode_onslaught_endscore_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_endscore_msg"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"mp_gamemode_onslaught_endscore_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_endscore_msg"] = [];
    } else if (!isarray(level.var_ae746e8f[#"mp_gamemode_onslaught_endscore_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_endscore_msg"] = array(level.var_ae746e8f[#"mp_gamemode_onslaught_endscore_msg"]);
    }
    level.var_ae746e8f[#"mp_gamemode_onslaught_endscore_msg"][level.var_ae746e8f[#"mp_gamemode_onslaught_endscore_msg"].size] = elem;
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 0, eflags: 0x0
// Checksum 0x9725753c, Offset: 0x2a8
// Size: 0x34
function register_clientside() {
    elem = new class_4868ccea();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 1, eflags: 0x0
// Checksum 0x1c696df0, Offset: 0x2e8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 1, eflags: 0x0
// Checksum 0x7c1d698e, Offset: 0x310
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 1, eflags: 0x0
// Checksum 0x37994dd3, Offset: 0x338
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 2, eflags: 0x0
// Checksum 0x249d9a94, Offset: 0x360
// Size: 0x28
function function_4b560c24(localclientnum, value) {
    [[ self ]]->function_4b560c24(localclientnum, value);
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 2, eflags: 0x0
// Checksum 0x63902b31, Offset: 0x390
// Size: 0x28
function function_4b3ad4c4(localclientnum, value) {
    [[ self ]]->function_4b3ad4c4(localclientnum, value);
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 2, eflags: 0x0
// Checksum 0x4416974e, Offset: 0x3c0
// Size: 0x28
function function_fc075317(localclientnum, value) {
    [[ self ]]->function_fc075317(localclientnum, value);
}

// Namespace mp_gamemode_onslaught_endscore_msg/mp_gamemode_onslaught_endscore_msg
// Params 2, eflags: 0x0
// Checksum 0xc9c1d5b3, Offset: 0x3f0
// Size: 0x28
function function_955431ec(localclientnum, value) {
    [[ self ]]->function_955431ec(localclientnum, value);
}

