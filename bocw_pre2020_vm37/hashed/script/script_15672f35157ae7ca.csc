#using scripts\core_common\lui_shared;

#namespace luielem_entity_bar;

// Namespace luielem_entity_bar
// Method(s) 14 Total 20
class class_276088fe : cluielem {

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 1, eflags: 0x0
    // Checksum 0x937dfa45, Offset: 0x950
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0xc241f5bd, Offset: 0xb88
    // Size: 0x30
    function function_4f6e830d(localclientnum, value) {
        set_data(localclientnum, "offset_y", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 0, eflags: 0x0
    // Checksum 0x1fed6325, Offset: 0x810
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("LUIelem_entity_bar");
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0xa10b57f0, Offset: 0xb50
    // Size: 0x30
    function function_61312692(localclientnum, value) {
        set_data(localclientnum, "offset_x", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0xdd5002c2, Offset: 0xbc0
    // Size: 0x30
    function function_7ddfdfef(localclientnum, value) {
        set_data(localclientnum, "offset_z", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 9, eflags: 0x0
    // Checksum 0xb1a130ce, Offset: 0x660
    // Size: 0x1a4
    function setup_clientfields(var_aabf01c7, var_5a7b4b38, *var_bda3bf84, *var_f228b5fa, var_5957697a, var_90efc226, var_b77f41ee, var_255edd98, var_2c8aa656) {
        cluielem::setup_clientfields("LUIelem_entity_bar");
        cluielem::add_clientfield("_state", 1, 3, "int");
        cluielem::add_clientfield("progress_percent", 1, 7, "float", var_bda3bf84);
        cluielem::add_clientfield("entnum", 1, 7, "int", var_f228b5fa);
        cluielem::add_clientfield("offset_x", 1, 6, "int", var_5957697a);
        cluielem::add_clientfield("offset_y", 1, 6, "int", var_90efc226);
        cluielem::add_clientfield("offset_z", 1, 6, "int", var_b77f41ee);
        cluielem::add_clientfield("entityClamp", 1, 1, "int", var_255edd98);
        cluielem::add_clientfield("entityScale", 1, 1, "int", var_2c8aa656);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x4a2232ab, Offset: 0xc30
    // Size: 0x30
    function function_a9793a65(localclientnum, value) {
        set_data(localclientnum, "entityScale", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x3979e90b, Offset: 0xb18
    // Size: 0x30
    function set_entnum(localclientnum, value) {
        set_data(localclientnum, "entnum", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x86fdd95, Offset: 0x980
    // Size: 0x154
    function set_state(localclientnum, state_name) {
        if (#"defaultstate" == state_name) {
            set_data(localclientnum, "_state", 0);
            return;
        }
        if (#"friendlyblue" == state_name) {
            set_data(localclientnum, "_state", 1);
            return;
        }
        if (#"green" == state_name) {
            set_data(localclientnum, "_state", 2);
            return;
        }
        if (#"yellow" == state_name) {
            set_data(localclientnum, "_state", 3);
            return;
        }
        if (#"red" == state_name) {
            set_data(localclientnum, "_state", 4);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x48e791fb, Offset: 0xbf8
    // Size: 0x30
    function function_dfed4b05(localclientnum, value) {
        set_data(localclientnum, "entityClamp", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 2, eflags: 0x0
    // Checksum 0x5d6fccec, Offset: 0xae0
    // Size: 0x30
    function function_ecacbaa5(localclientnum, value) {
        set_data(localclientnum, "progress_percent", value);
    }

    // Namespace namespace_276088fe/luielem_entity_bar
    // Params 1, eflags: 0x0
    // Checksum 0xd6b375f0, Offset: 0x838
    // Size: 0x110
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "progress_percent", 0);
        set_data(localclientnum, "entnum", 0);
        set_data(localclientnum, "offset_x", 0);
        set_data(localclientnum, "offset_y", 0);
        set_data(localclientnum, "offset_z", 0);
        set_data(localclientnum, "entityClamp", 0);
        set_data(localclientnum, "entityScale", 0);
    }

}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0xe7c7d213, Offset: 0x130
// Size: 0x30
function function_78098d4b(localclientnum, value) {
    [[ self ]]->set_data(localclientnum, "boneTag", value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 3, eflags: 0x0
// Checksum 0x48cd2627, Offset: 0x168
// Size: 0x4c
function function_919052d(localclientnum, entnum, bonetag) {
    self set_entnum(localclientnum, entnum);
    self function_78098d4b(localclientnum, bonetag);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 4, eflags: 0x0
// Checksum 0xe73008e7, Offset: 0x1c0
// Size: 0x6c
function set_offset(localclientnum, offsetx, offsety, offsetz) {
    self function_61312692(localclientnum, offsetx);
    self function_4f6e830d(localclientnum, offsety);
    self function_7ddfdfef(localclientnum, offsetz);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 9, eflags: 0x0
// Checksum 0xe635412f, Offset: 0x238
// Size: 0x1c6
function register(var_aabf01c7, var_5a7b4b38, var_bda3bf84, var_f228b5fa, var_5957697a, var_90efc226, var_b77f41ee, var_255edd98, var_2c8aa656) {
    elem = new class_276088fe();
    [[ elem ]]->setup_clientfields(var_aabf01c7, var_5a7b4b38, var_bda3bf84, var_f228b5fa, var_5957697a, var_90efc226, var_b77f41ee, var_255edd98, var_2c8aa656);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"luielem_entity_bar"])) {
        level.var_ae746e8f[#"luielem_entity_bar"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"luielem_entity_bar"])) {
        level.var_ae746e8f[#"luielem_entity_bar"] = [];
    } else if (!isarray(level.var_ae746e8f[#"luielem_entity_bar"])) {
        level.var_ae746e8f[#"luielem_entity_bar"] = array(level.var_ae746e8f[#"luielem_entity_bar"]);
    }
    level.var_ae746e8f[#"luielem_entity_bar"][level.var_ae746e8f[#"luielem_entity_bar"].size] = elem;
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 0, eflags: 0x0
// Checksum 0x374577f2, Offset: 0x408
// Size: 0x34
function register_clientside() {
    elem = new class_276088fe();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 1, eflags: 0x0
// Checksum 0x664e1482, Offset: 0x448
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 1, eflags: 0x0
// Checksum 0x34e7650e, Offset: 0x470
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 1, eflags: 0x0
// Checksum 0x341ea4b0, Offset: 0x498
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x6059285a, Offset: 0x4c0
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x7a969c9, Offset: 0x4f0
// Size: 0x28
function function_ecacbaa5(localclientnum, value) {
    [[ self ]]->function_ecacbaa5(localclientnum, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x4d76d0ab, Offset: 0x520
// Size: 0x28
function set_entnum(localclientnum, value) {
    [[ self ]]->set_entnum(localclientnum, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x382f670a, Offset: 0x550
// Size: 0x28
function function_61312692(localclientnum, value) {
    [[ self ]]->function_61312692(localclientnum, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x1ad2cec5, Offset: 0x580
// Size: 0x28
function function_4f6e830d(localclientnum, value) {
    [[ self ]]->function_4f6e830d(localclientnum, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0xfb8e4eee, Offset: 0x5b0
// Size: 0x28
function function_7ddfdfef(localclientnum, value) {
    [[ self ]]->function_7ddfdfef(localclientnum, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0x569d1c90, Offset: 0x5e0
// Size: 0x28
function function_dfed4b05(localclientnum, value) {
    [[ self ]]->function_dfed4b05(localclientnum, value);
}

// Namespace luielem_entity_bar/luielem_entity_bar
// Params 2, eflags: 0x0
// Checksum 0xfae9a438, Offset: 0x610
// Size: 0x28
function function_a9793a65(localclientnum, value) {
    [[ self ]]->function_a9793a65(localclientnum, value);
}

