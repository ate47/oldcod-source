#using scripts\core_common\lui_shared;

#namespace mp_gamemode_onslaught_score_msg;

// Namespace mp_gamemode_onslaught_score_msg
// Method(s) 14 Total 20
class class_e22be003 : cluielem {

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 1, eflags: 0x0
    // Checksum 0xb4edad54, Offset: 0x840
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 2, eflags: 0x0
    // Checksum 0x87a1abc2, Offset: 0x950
    // Size: 0x30
    function function_2a0b1f84(localclientnum, value) {
        set_data(localclientnum, "score3Points", value);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 2, eflags: 0x0
    // Checksum 0x14bb568e, Offset: 0x8a8
    // Size: 0x30
    function function_4b3ad4c4(localclientnum, value) {
        set_data(localclientnum, "scorePoints", value);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 2, eflags: 0x0
    // Checksum 0xdccd9006, Offset: 0x870
    // Size: 0x30
    function function_4b560c24(localclientnum, value) {
        set_data(localclientnum, "scoreText", value);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 1, eflags: 0x0
    // Checksum 0xcef89fee, Offset: 0xa78
    // Size: 0x6c
    function function_4bfdafeb(localclientnum) {
        current_val = get_data(localclientnum, "moveorb");
        new_val = (current_val + 1) % 2;
        set_data(localclientnum, "moveorb", new_val);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 0, eflags: 0x0
    // Checksum 0x400d6016, Offset: 0x6f0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("mp_gamemode_onslaught_score_msg");
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 8, eflags: 0x0
    // Checksum 0xa1c645e2, Offset: 0x548
    // Size: 0x19c
    function setup_clientfields(*var_ae3230db, var_3b37d9b6, *var_edd1ee8c, var_215262d5, var_964ac54, var_a286206c, var_aaae2990, var_43f41525) {
        cluielem::setup_clientfields("mp_gamemode_onslaught_score_msg");
        cluielem::function_dcb34c80("string", "scoreText", 1);
        cluielem::add_clientfield("scorePoints", 1, 11, "int", var_edd1ee8c);
        cluielem::function_dcb34c80("string", "score2Text", 1);
        cluielem::add_clientfield("score2Points", 1, 11, "int", var_215262d5);
        cluielem::add_clientfield("score3Points", 1, 8, "int", var_964ac54);
        cluielem::add_clientfield("powerup", 1, 1, "counter", var_a286206c);
        cluielem::add_clientfield("lowpower", 1, 1, "counter", var_aaae2990);
        cluielem::add_clientfield("moveorb", 1, 1, "counter", var_43f41525);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 1, eflags: 0x0
    // Checksum 0x303e957c, Offset: 0x988
    // Size: 0x6c
    function function_94b2b0bd(localclientnum) {
        current_val = get_data(localclientnum, "powerup");
        new_val = (current_val + 1) % 2;
        set_data(localclientnum, "powerup", new_val);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 2, eflags: 0x0
    // Checksum 0xaaa20402, Offset: 0x918
    // Size: 0x30
    function function_955431ec(localclientnum, value) {
        set_data(localclientnum, "score2Points", value);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 1, eflags: 0x0
    // Checksum 0x25258ba4, Offset: 0xa00
    // Size: 0x6c
    function function_d74c17ab(localclientnum) {
        current_val = get_data(localclientnum, "lowpower");
        new_val = (current_val + 1) % 2;
        set_data(localclientnum, "lowpower", new_val);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 1, eflags: 0x0
    // Checksum 0x3dcfe585, Offset: 0x718
    // Size: 0x120
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "scoreText", #"");
        set_data(localclientnum, "scorePoints", 0);
        set_data(localclientnum, "score2Text", #"");
        set_data(localclientnum, "score2Points", 0);
        set_data(localclientnum, "score3Points", 0);
        set_data(localclientnum, "powerup", 0);
        set_data(localclientnum, "lowpower", 0);
        set_data(localclientnum, "moveorb", 0);
    }

    // Namespace namespace_e22be003/mp_gamemode_onslaught_score_msg
    // Params 2, eflags: 0x0
    // Checksum 0x461cd9ce, Offset: 0x8e0
    // Size: 0x30
    function function_fc075317(localclientnum, value) {
        set_data(localclientnum, "score2Text", value);
    }

}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 8, eflags: 0x0
// Checksum 0x7ad3341, Offset: 0x140
// Size: 0x1be
function register(var_ae3230db, var_3b37d9b6, var_edd1ee8c, var_215262d5, var_964ac54, var_a286206c, var_aaae2990, var_43f41525) {
    elem = new class_e22be003();
    [[ elem ]]->setup_clientfields(var_ae3230db, var_3b37d9b6, var_edd1ee8c, var_215262d5, var_964ac54, var_a286206c, var_aaae2990, var_43f41525);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"mp_gamemode_onslaught_score_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_score_msg"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"mp_gamemode_onslaught_score_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_score_msg"] = [];
    } else if (!isarray(level.var_ae746e8f[#"mp_gamemode_onslaught_score_msg"])) {
        level.var_ae746e8f[#"mp_gamemode_onslaught_score_msg"] = array(level.var_ae746e8f[#"mp_gamemode_onslaught_score_msg"]);
    }
    level.var_ae746e8f[#"mp_gamemode_onslaught_score_msg"][level.var_ae746e8f[#"mp_gamemode_onslaught_score_msg"].size] = elem;
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 0, eflags: 0x0
// Checksum 0xfd9f29c5, Offset: 0x308
// Size: 0x34
function register_clientside() {
    elem = new class_e22be003();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 1, eflags: 0x0
// Checksum 0x4e72b3c9, Offset: 0x348
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 1, eflags: 0x0
// Checksum 0x4164f001, Offset: 0x370
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 1, eflags: 0x0
// Checksum 0x13829f83, Offset: 0x398
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 2, eflags: 0x0
// Checksum 0x38512c78, Offset: 0x3c0
// Size: 0x28
function function_4b560c24(localclientnum, value) {
    [[ self ]]->function_4b560c24(localclientnum, value);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 2, eflags: 0x0
// Checksum 0xab381bc8, Offset: 0x3f0
// Size: 0x28
function function_4b3ad4c4(localclientnum, value) {
    [[ self ]]->function_4b3ad4c4(localclientnum, value);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 2, eflags: 0x0
// Checksum 0x6b197b48, Offset: 0x420
// Size: 0x28
function function_fc075317(localclientnum, value) {
    [[ self ]]->function_fc075317(localclientnum, value);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 2, eflags: 0x0
// Checksum 0x4334db17, Offset: 0x450
// Size: 0x28
function function_955431ec(localclientnum, value) {
    [[ self ]]->function_955431ec(localclientnum, value);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 2, eflags: 0x0
// Checksum 0x9d80d665, Offset: 0x480
// Size: 0x28
function function_2a0b1f84(localclientnum, value) {
    [[ self ]]->function_2a0b1f84(localclientnum, value);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 1, eflags: 0x0
// Checksum 0x278250a2, Offset: 0x4b0
// Size: 0x1c
function function_94b2b0bd(localclientnum) {
    [[ self ]]->function_94b2b0bd(localclientnum);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 1, eflags: 0x0
// Checksum 0xa77a9aaa, Offset: 0x4d8
// Size: 0x1c
function function_d74c17ab(localclientnum) {
    [[ self ]]->function_d74c17ab(localclientnum);
}

// Namespace mp_gamemode_onslaught_score_msg/mp_gamemode_onslaught_score_msg
// Params 1, eflags: 0x0
// Checksum 0x80bb0239, Offset: 0x500
// Size: 0x1c
function function_4bfdafeb(localclientnum) {
    [[ self ]]->function_4bfdafeb(localclientnum);
}

