#using scripts\core_common\lui_shared;

#namespace doa_textbubble_playername;

// Namespace doa_textbubble_playername
// Method(s) 11 Total 17
class class_42946372 : cluielem {

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 1, eflags: 0x0
    // Checksum 0xa928bee1, Offset: 0x608
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 2, eflags: 0x0
    // Checksum 0xbed72f80, Offset: 0x670
    // Size: 0x30
    function set_clientnum(localclientnum, value) {
        set_data(localclientnum, "clientnum", value);
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 2, eflags: 0x0
    // Checksum 0x91bb3695, Offset: 0x6e0
    // Size: 0x30
    function function_4f6e830d(localclientnum, value) {
        set_data(localclientnum, "offset_y", value);
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 0, eflags: 0x0
    // Checksum 0x472aeed3, Offset: 0x528
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("DOA_TextBubble_PlayerName");
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 2, eflags: 0x0
    // Checksum 0x8d06bd01, Offset: 0x6a8
    // Size: 0x30
    function function_61312692(localclientnum, value) {
        set_data(localclientnum, "offset_x", value);
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 2, eflags: 0x0
    // Checksum 0xf478416f, Offset: 0x718
    // Size: 0x30
    function function_7ddfdfef(localclientnum, value) {
        set_data(localclientnum, "offset_z", value);
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 5, eflags: 0x0
    // Checksum 0x4155ce32, Offset: 0x4d8
    // Size: 0x44
    function setup_clientfields(*var_5a7b4b38, *var_c05c67e2, *var_5957697a, *var_90efc226, *var_b77f41ee) {
        cluielem::setup_clientfields("DOA_TextBubble_PlayerName");
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 2, eflags: 0x0
    // Checksum 0x404093cb, Offset: 0x638
    // Size: 0x30
    function set_entnum(localclientnum, value) {
        set_data(localclientnum, "entnum", value);
    }

    // Namespace namespace_42946372/doa_textbubble_playername
    // Params 1, eflags: 0x0
    // Checksum 0xeb5e972d, Offset: 0x550
    // Size: 0xb0
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "entnum", 0);
        set_data(localclientnum, "clientnum", 0);
        set_data(localclientnum, "offset_x", 0);
        set_data(localclientnum, "offset_y", 0);
        set_data(localclientnum, "offset_z", 0);
    }

}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 4, eflags: 0x0
// Checksum 0x368cd53c, Offset: 0xf0
// Size: 0x6c
function set_offset(localclientnum, offsetx, offsety, offsetz) {
    self function_61312692(localclientnum, offsetx);
    self function_4f6e830d(localclientnum, offsety);
    self function_7ddfdfef(localclientnum, offsetz);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 5, eflags: 0x0
// Checksum 0x2586e28, Offset: 0x168
// Size: 0x19e
function register(var_5a7b4b38, var_c05c67e2, var_5957697a, var_90efc226, var_b77f41ee) {
    elem = new class_42946372();
    [[ elem ]]->setup_clientfields(var_5a7b4b38, var_c05c67e2, var_5957697a, var_90efc226, var_b77f41ee);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"doa_textbubble_playername"])) {
        level.var_ae746e8f[#"doa_textbubble_playername"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"doa_textbubble_playername"])) {
        level.var_ae746e8f[#"doa_textbubble_playername"] = [];
    } else if (!isarray(level.var_ae746e8f[#"doa_textbubble_playername"])) {
        level.var_ae746e8f[#"doa_textbubble_playername"] = array(level.var_ae746e8f[#"doa_textbubble_playername"]);
    }
    level.var_ae746e8f[#"doa_textbubble_playername"][level.var_ae746e8f[#"doa_textbubble_playername"].size] = elem;
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 0, eflags: 0x0
// Checksum 0xdc56673c, Offset: 0x310
// Size: 0x34
function register_clientside() {
    elem = new class_42946372();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 1, eflags: 0x0
// Checksum 0xea7a6f50, Offset: 0x350
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 1, eflags: 0x0
// Checksum 0x9095ad88, Offset: 0x378
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 1, eflags: 0x0
// Checksum 0x72645fce, Offset: 0x3a0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 2, eflags: 0x0
// Checksum 0x5fc2266c, Offset: 0x3c8
// Size: 0x28
function set_entnum(localclientnum, value) {
    [[ self ]]->set_entnum(localclientnum, value);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 2, eflags: 0x0
// Checksum 0xa393ae24, Offset: 0x3f8
// Size: 0x28
function set_clientnum(localclientnum, value) {
    [[ self ]]->set_clientnum(localclientnum, value);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 2, eflags: 0x0
// Checksum 0xd343b1cf, Offset: 0x428
// Size: 0x28
function function_61312692(localclientnum, value) {
    [[ self ]]->function_61312692(localclientnum, value);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 2, eflags: 0x0
// Checksum 0x9b9f77da, Offset: 0x458
// Size: 0x28
function function_4f6e830d(localclientnum, value) {
    [[ self ]]->function_4f6e830d(localclientnum, value);
}

// Namespace doa_textbubble_playername/doa_textbubble_playername
// Params 2, eflags: 0x0
// Checksum 0x2154ff2e, Offset: 0x488
// Size: 0x28
function function_7ddfdfef(localclientnum, value) {
    [[ self ]]->function_7ddfdfef(localclientnum, value);
}

