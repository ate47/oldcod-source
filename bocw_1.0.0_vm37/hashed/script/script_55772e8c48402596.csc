#using scripts\core_common\lui_shared;

#namespace sr_message_box;

// Namespace sr_message_box
// Method(s) 7 Total 14
class class_51e5626e : cluielem {

    // Namespace namespace_51e5626e/sr_message_box
    // Params 1, eflags: 0x0
    // Checksum 0x47c907a, Offset: 0x420
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_51e5626e/sr_message_box
    // Params 0, eflags: 0x0
    // Checksum 0x1c6fe92e, Offset: 0x3a0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("sr_message_box");
    }

    // Namespace namespace_51e5626e/sr_message_box
    // Params 2, eflags: 0x0
    // Checksum 0x1517d89d, Offset: 0x450
    // Size: 0x30
    function function_7a690474(localclientnum, value) {
        set_data(localclientnum, "messagebox", value);
    }

    // Namespace namespace_51e5626e/sr_message_box
    // Params 1, eflags: 0x0
    // Checksum 0x425c5e69, Offset: 0x348
    // Size: 0x4c
    function setup_clientfields(*var_50fe5991) {
        cluielem::setup_clientfields("sr_message_box");
        cluielem::function_dcb34c80("string", "messagebox", 1);
    }

    // Namespace namespace_51e5626e/sr_message_box
    // Params 1, eflags: 0x0
    // Checksum 0x1760a92c, Offset: 0x3c8
    // Size: 0x4c
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "messagebox", #"");
    }

}

// Namespace sr_message_box/sr_message_box
// Params 1, eflags: 0x0
// Checksum 0x3c33ea1d, Offset: 0xc0
// Size: 0x176
function register(var_50fe5991) {
    elem = new class_51e5626e();
    [[ elem ]]->setup_clientfields(var_50fe5991);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"sr_message_box"])) {
        level.var_ae746e8f[#"sr_message_box"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"sr_message_box"])) {
        level.var_ae746e8f[#"sr_message_box"] = [];
    } else if (!isarray(level.var_ae746e8f[#"sr_message_box"])) {
        level.var_ae746e8f[#"sr_message_box"] = array(level.var_ae746e8f[#"sr_message_box"]);
    }
    level.var_ae746e8f[#"sr_message_box"][level.var_ae746e8f[#"sr_message_box"].size] = elem;
}

// Namespace sr_message_box/sr_message_box
// Params 0, eflags: 0x0
// Checksum 0x59a663, Offset: 0x240
// Size: 0x34
function register_clientside() {
    elem = new class_51e5626e();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace sr_message_box/sr_message_box
// Params 1, eflags: 0x0
// Checksum 0x1dc1f992, Offset: 0x280
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace sr_message_box/sr_message_box
// Params 1, eflags: 0x0
// Checksum 0xf61c59a2, Offset: 0x2a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_message_box/sr_message_box
// Params 1, eflags: 0x0
// Checksum 0x65611201, Offset: 0x2d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace sr_message_box/sr_message_box
// Params 2, eflags: 0x0
// Checksum 0xf5231180, Offset: 0x2f8
// Size: 0x28
function function_7a690474(localclientnum, value) {
    [[ self ]]->function_7a690474(localclientnum, value);
}

