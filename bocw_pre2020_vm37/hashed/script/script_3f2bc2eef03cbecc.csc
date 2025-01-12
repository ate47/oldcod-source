#using scripts\core_common\lui_shared;

#namespace sr_armor_menu;

// Namespace sr_armor_menu
// Method(s) 6 Total 12
class class_8ebbf51b : cluielem {

    // Namespace namespace_8ebbf51b/sr_armor_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0xc7741028, Offset: 0x378
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_8ebbf51b/sr_armor_menu
    // Params 0, eflags: 0x1 linked
    // Checksum 0x24a8cf25, Offset: 0x320
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("sr_armor_menu");
    }

    // Namespace namespace_8ebbf51b/sr_armor_menu
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3b463985, Offset: 0x2f8
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_armor_menu");
    }

    // Namespace namespace_8ebbf51b/sr_armor_menu
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2bf5276e, Offset: 0x348
    // Size: 0x24
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
    }

}

// Namespace sr_armor_menu/sr_armor_menu
// Params 0, eflags: 0x1 linked
// Checksum 0x397ea08, Offset: 0xa8
// Size: 0x16e
function register() {
    elem = new class_8ebbf51b();
    [[ elem ]]->setup_clientfields();
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"sr_armor_menu"])) {
        level.var_ae746e8f[#"sr_armor_menu"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"sr_armor_menu"])) {
        level.var_ae746e8f[#"sr_armor_menu"] = [];
    } else if (!isarray(level.var_ae746e8f[#"sr_armor_menu"])) {
        level.var_ae746e8f[#"sr_armor_menu"] = array(level.var_ae746e8f[#"sr_armor_menu"]);
    }
    level.var_ae746e8f[#"sr_armor_menu"][level.var_ae746e8f[#"sr_armor_menu"].size] = elem;
}

// Namespace sr_armor_menu/sr_armor_menu
// Params 0, eflags: 0x0
// Checksum 0x7ce1471a, Offset: 0x220
// Size: 0x34
function register_clientside() {
    elem = new class_8ebbf51b();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace sr_armor_menu/sr_armor_menu
// Params 1, eflags: 0x0
// Checksum 0x1d3f70a7, Offset: 0x260
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace sr_armor_menu/sr_armor_menu
// Params 1, eflags: 0x0
// Checksum 0xe9546b3a, Offset: 0x288
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_armor_menu/sr_armor_menu
// Params 1, eflags: 0x0
// Checksum 0x479469de, Offset: 0x2b0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

