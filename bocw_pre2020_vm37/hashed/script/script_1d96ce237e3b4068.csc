#using scripts\core_common\lui_shared;

#namespace lui_plane_mortar;

// Namespace lui_plane_mortar
// Method(s) 8 Total 14
class class_37d61ee3 : cluielem {

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 1, eflags: 0x1 linked
    // Checksum 0xabb6d744, Offset: 0x458
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 0, eflags: 0x1 linked
    // Checksum 0xde3eadf3, Offset: 0x3c8
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("lui_plane_mortar");
    }

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 2, eflags: 0x1 linked
    // Checksum 0x94174db9, Offset: 0x488
    // Size: 0x30
    function function_6c69ff4b(localclientnum, value) {
        set_data(localclientnum, "selectorIndex", value);
    }

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 2, eflags: 0x1 linked
    // Checksum 0xbddb8bd9, Offset: 0x390
    // Size: 0x2c
    function setup_clientfields(*var_828e1f01, *var_a9fceeac) {
        cluielem::setup_clientfields("lui_plane_mortar");
    }

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb898783e, Offset: 0x4c0
    // Size: 0x30
    function function_b172c58e(localclientnum, value) {
        set_data(localclientnum, "selectorsAvailable", value);
    }

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5cafe338, Offset: 0x3f0
    // Size: 0x5c
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "selectorIndex", 0);
        set_data(localclientnum, "selectorsAvailable", 0);
    }

}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 2, eflags: 0x0
// Checksum 0x6c671700, Offset: 0xd0
// Size: 0x17e
function register(var_828e1f01, var_a9fceeac) {
    elem = new class_37d61ee3();
    [[ elem ]]->setup_clientfields(var_828e1f01, var_a9fceeac);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"lui_plane_mortar"])) {
        level.var_ae746e8f[#"lui_plane_mortar"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"lui_plane_mortar"])) {
        level.var_ae746e8f[#"lui_plane_mortar"] = [];
    } else if (!isarray(level.var_ae746e8f[#"lui_plane_mortar"])) {
        level.var_ae746e8f[#"lui_plane_mortar"] = array(level.var_ae746e8f[#"lui_plane_mortar"]);
    }
    level.var_ae746e8f[#"lui_plane_mortar"][level.var_ae746e8f[#"lui_plane_mortar"].size] = elem;
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 0, eflags: 0x0
// Checksum 0xf1c50b99, Offset: 0x258
// Size: 0x34
function register_clientside() {
    elem = new class_37d61ee3();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 1, eflags: 0x0
// Checksum 0xfc5dbfd1, Offset: 0x298
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 1, eflags: 0x0
// Checksum 0x163cc8d7, Offset: 0x2c0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 1, eflags: 0x0
// Checksum 0xdc2011cc, Offset: 0x2e8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 2, eflags: 0x0
// Checksum 0xb658bb0c, Offset: 0x310
// Size: 0x28
function function_6c69ff4b(localclientnum, value) {
    [[ self ]]->function_6c69ff4b(localclientnum, value);
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 2, eflags: 0x0
// Checksum 0xcf4c147a, Offset: 0x340
// Size: 0x28
function function_b172c58e(localclientnum, value) {
    [[ self ]]->function_b172c58e(localclientnum, value);
}

