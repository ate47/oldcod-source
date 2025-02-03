#using scripts\core_common\lui_shared;

#namespace vip_notify_text;

// Namespace vip_notify_text
// Method(s) 8 Total 15
class class_302a48fc : cluielem {

    // Namespace namespace_302a48fc/vip_notify_text
    // Params 1, eflags: 0x0
    // Checksum 0x68c1af95, Offset: 0x4c0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_302a48fc/vip_notify_text
    // Params 0, eflags: 0x0
    // Checksum 0x67dc93e, Offset: 0x420
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("vip_notify_text");
    }

    // Namespace namespace_302a48fc/vip_notify_text
    // Params 2, eflags: 0x0
    // Checksum 0x142f0d6a, Offset: 0x398
    // Size: 0x7c
    function setup_clientfields(*var_42fe6185, alphacallback) {
        cluielem::setup_clientfields("vip_notify_text");
        cluielem::function_dcb34c80("string", "vipmessage", 1);
        cluielem::add_clientfield("alpha", 1, 8, "float", alphacallback);
    }

    // Namespace namespace_302a48fc/vip_notify_text
    // Params 2, eflags: 0x0
    // Checksum 0xbacfaa1e, Offset: 0x528
    // Size: 0x30
    function set_alpha(localclientnum, value) {
        set_data(localclientnum, "alpha", value);
    }

    // Namespace namespace_302a48fc/vip_notify_text
    // Params 2, eflags: 0x0
    // Checksum 0x1ed5db4b, Offset: 0x4f0
    // Size: 0x30
    function function_d01a102c(localclientnum, value) {
        set_data(localclientnum, "vipmessage", value);
    }

    // Namespace namespace_302a48fc/vip_notify_text
    // Params 1, eflags: 0x0
    // Checksum 0x4b3235a, Offset: 0x448
    // Size: 0x70
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "vipmessage", #"");
        set_data(localclientnum, "alpha", 0);
    }

}

// Namespace vip_notify_text/vip_notify_text
// Params 2, eflags: 0x0
// Checksum 0xe5736640, Offset: 0xd8
// Size: 0x17e
function register(var_42fe6185, alphacallback) {
    elem = new class_302a48fc();
    [[ elem ]]->setup_clientfields(var_42fe6185, alphacallback);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"vip_notify_text"])) {
        level.var_ae746e8f[#"vip_notify_text"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"vip_notify_text"])) {
        level.var_ae746e8f[#"vip_notify_text"] = [];
    } else if (!isarray(level.var_ae746e8f[#"vip_notify_text"])) {
        level.var_ae746e8f[#"vip_notify_text"] = array(level.var_ae746e8f[#"vip_notify_text"]);
    }
    level.var_ae746e8f[#"vip_notify_text"][level.var_ae746e8f[#"vip_notify_text"].size] = elem;
}

// Namespace vip_notify_text/vip_notify_text
// Params 0, eflags: 0x0
// Checksum 0x7968f50, Offset: 0x260
// Size: 0x34
function register_clientside() {
    elem = new class_302a48fc();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace vip_notify_text/vip_notify_text
// Params 1, eflags: 0x0
// Checksum 0x806d8532, Offset: 0x2a0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace vip_notify_text/vip_notify_text
// Params 1, eflags: 0x0
// Checksum 0x314dc44b, Offset: 0x2c8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace vip_notify_text/vip_notify_text
// Params 1, eflags: 0x0
// Checksum 0xaccac2cb, Offset: 0x2f0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace vip_notify_text/vip_notify_text
// Params 2, eflags: 0x0
// Checksum 0x45d1c1a4, Offset: 0x318
// Size: 0x28
function function_d01a102c(localclientnum, value) {
    [[ self ]]->function_d01a102c(localclientnum, value);
}

// Namespace vip_notify_text/vip_notify_text
// Params 2, eflags: 0x0
// Checksum 0x1b09c024, Offset: 0x348
// Size: 0x28
function set_alpha(localclientnum, value) {
    [[ self ]]->set_alpha(localclientnum, value);
}

