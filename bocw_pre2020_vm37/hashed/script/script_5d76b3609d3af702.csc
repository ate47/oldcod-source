#using scripts\core_common\lui_shared;

#namespace doa_textbubble;

// Namespace doa_textbubble
// Method(s) 11 Total 17
class class_b20c2804 : cluielem {

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 1, eflags: 0x0
    // Checksum 0x7011b7f9, Offset: 0x6a0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 2, eflags: 0x0
    // Checksum 0x87088f10, Offset: 0x778
    // Size: 0x30
    function function_4f6e830d(localclientnum, value) {
        set_data(localclientnum, "offset_y", value);
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 0, eflags: 0x0
    // Checksum 0x4f47cb71, Offset: 0x5b0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("DOA_TextBubble");
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 2, eflags: 0x0
    // Checksum 0xf7592fae, Offset: 0x740
    // Size: 0x30
    function function_61312692(localclientnum, value) {
        set_data(localclientnum, "offset_x", value);
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 2, eflags: 0x0
    // Checksum 0x8a2961a1, Offset: 0x7b0
    // Size: 0x30
    function function_7ddfdfef(localclientnum, value) {
        set_data(localclientnum, "offset_z", value);
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 5, eflags: 0x0
    // Checksum 0x46cf9946, Offset: 0x560
    // Size: 0x44
    function setup_clientfields(*var_5a7b4b38, *textcallback, *var_5957697a, *var_90efc226, *var_b77f41ee) {
        cluielem::setup_clientfields("DOA_TextBubble");
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 2, eflags: 0x0
    // Checksum 0x502a429e, Offset: 0x6d0
    // Size: 0x30
    function set_entnum(localclientnum, value) {
        set_data(localclientnum, "entnum", value);
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 2, eflags: 0x0
    // Checksum 0x58c905d3, Offset: 0x708
    // Size: 0x30
    function set_text(localclientnum, value) {
        set_data(localclientnum, "text", value);
    }

    // Namespace namespace_b20c2804/doa_textbubble
    // Params 1, eflags: 0x0
    // Checksum 0xf5113e00, Offset: 0x5d8
    // Size: 0xc0
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "entnum", 0);
        set_data(localclientnum, "text", #"");
        set_data(localclientnum, "offset_x", 0);
        set_data(localclientnum, "offset_y", 0);
        set_data(localclientnum, "offset_z", 0);
    }

}

// Namespace doa_textbubble/doa_textbubble
// Params 4, eflags: 0x0
// Checksum 0x897a9ecc, Offset: 0xe8
// Size: 0x6c
function set_offset(localclientnum, offsetx, offsety, offsetz) {
    self function_61312692(localclientnum, offsetx);
    self function_4f6e830d(localclientnum, offsety);
    self function_7ddfdfef(localclientnum, offsetz);
}

// Namespace doa_textbubble/doa_textbubble
// Params 2, eflags: 0x0
// Checksum 0xb33aa301, Offset: 0x160
// Size: 0x30
function function_78098d4b(localclientnum, value) {
    [[ self ]]->set_data(localclientnum, "boneTag", value);
}

// Namespace doa_textbubble/doa_textbubble
// Params 3, eflags: 0x0
// Checksum 0x56fd327a, Offset: 0x198
// Size: 0x4c
function function_919052d(localclientnum, entnum, bonetag) {
    self set_entnum(localclientnum, entnum);
    self function_78098d4b(localclientnum, bonetag);
}

// Namespace doa_textbubble/doa_textbubble
// Params 5, eflags: 0x0
// Checksum 0xe7fcad2c, Offset: 0x1f0
// Size: 0x19e
function register(var_5a7b4b38, textcallback, var_5957697a, var_90efc226, var_b77f41ee) {
    elem = new class_b20c2804();
    [[ elem ]]->setup_clientfields(var_5a7b4b38, textcallback, var_5957697a, var_90efc226, var_b77f41ee);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"doa_textbubble"])) {
        level.var_ae746e8f[#"doa_textbubble"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"doa_textbubble"])) {
        level.var_ae746e8f[#"doa_textbubble"] = [];
    } else if (!isarray(level.var_ae746e8f[#"doa_textbubble"])) {
        level.var_ae746e8f[#"doa_textbubble"] = array(level.var_ae746e8f[#"doa_textbubble"]);
    }
    level.var_ae746e8f[#"doa_textbubble"][level.var_ae746e8f[#"doa_textbubble"].size] = elem;
}

// Namespace doa_textbubble/doa_textbubble
// Params 0, eflags: 0x0
// Checksum 0xb39465e2, Offset: 0x398
// Size: 0x34
function register_clientside() {
    elem = new class_b20c2804();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace doa_textbubble/doa_textbubble
// Params 1, eflags: 0x0
// Checksum 0x83cd0a86, Offset: 0x3d8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace doa_textbubble/doa_textbubble
// Params 1, eflags: 0x0
// Checksum 0x22cfe564, Offset: 0x400
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace doa_textbubble/doa_textbubble
// Params 1, eflags: 0x0
// Checksum 0x4cbc5ac9, Offset: 0x428
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace doa_textbubble/doa_textbubble
// Params 2, eflags: 0x0
// Checksum 0x5ea38d48, Offset: 0x450
// Size: 0x28
function set_entnum(localclientnum, value) {
    [[ self ]]->set_entnum(localclientnum, value);
}

// Namespace doa_textbubble/doa_textbubble
// Params 2, eflags: 0x0
// Checksum 0x873d4d7a, Offset: 0x480
// Size: 0x28
function set_text(localclientnum, value) {
    [[ self ]]->set_text(localclientnum, value);
}

// Namespace doa_textbubble/doa_textbubble
// Params 2, eflags: 0x0
// Checksum 0xb08d7088, Offset: 0x4b0
// Size: 0x28
function function_61312692(localclientnum, value) {
    [[ self ]]->function_61312692(localclientnum, value);
}

// Namespace doa_textbubble/doa_textbubble
// Params 2, eflags: 0x0
// Checksum 0xada3383, Offset: 0x4e0
// Size: 0x28
function function_4f6e830d(localclientnum, value) {
    [[ self ]]->function_4f6e830d(localclientnum, value);
}

// Namespace doa_textbubble/doa_textbubble
// Params 2, eflags: 0x0
// Checksum 0x20835d15, Offset: 0x510
// Size: 0x28
function function_7ddfdfef(localclientnum, value) {
    [[ self ]]->function_7ddfdfef(localclientnum, value);
}

