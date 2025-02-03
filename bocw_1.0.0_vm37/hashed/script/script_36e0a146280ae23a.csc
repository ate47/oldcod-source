#using scripts\core_common\lui_shared;

#namespace sr_crafting_table_menu;

// Namespace sr_crafting_table_menu
// Method(s) 6 Total 13
class class_e1dc992f : cluielem {

    // Namespace namespace_e1dc992f/sr_crafting_table_menu
    // Params 1, eflags: 0x0
    // Checksum 0xeac02c1d, Offset: 0x380
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_e1dc992f/sr_crafting_table_menu
    // Params 0, eflags: 0x0
    // Checksum 0xef34c382, Offset: 0x328
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("sr_crafting_table_menu");
    }

    // Namespace namespace_e1dc992f/sr_crafting_table_menu
    // Params 0, eflags: 0x0
    // Checksum 0xc5939c91, Offset: 0x300
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_crafting_table_menu");
    }

    // Namespace namespace_e1dc992f/sr_crafting_table_menu
    // Params 1, eflags: 0x0
    // Checksum 0xa1348942, Offset: 0x350
    // Size: 0x24
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
    }

}

// Namespace sr_crafting_table_menu/sr_crafting_table_menu
// Params 0, eflags: 0x0
// Checksum 0x6eabf212, Offset: 0xb0
// Size: 0x16e
function register() {
    elem = new class_e1dc992f();
    [[ elem ]]->setup_clientfields();
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"sr_crafting_table_menu"])) {
        level.var_ae746e8f[#"sr_crafting_table_menu"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"sr_crafting_table_menu"])) {
        level.var_ae746e8f[#"sr_crafting_table_menu"] = [];
    } else if (!isarray(level.var_ae746e8f[#"sr_crafting_table_menu"])) {
        level.var_ae746e8f[#"sr_crafting_table_menu"] = array(level.var_ae746e8f[#"sr_crafting_table_menu"]);
    }
    level.var_ae746e8f[#"sr_crafting_table_menu"][level.var_ae746e8f[#"sr_crafting_table_menu"].size] = elem;
}

// Namespace sr_crafting_table_menu/sr_crafting_table_menu
// Params 0, eflags: 0x0
// Checksum 0x2afdd071, Offset: 0x228
// Size: 0x34
function register_clientside() {
    elem = new class_e1dc992f();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace sr_crafting_table_menu/sr_crafting_table_menu
// Params 1, eflags: 0x0
// Checksum 0x4567ddaa, Offset: 0x268
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace sr_crafting_table_menu/sr_crafting_table_menu
// Params 1, eflags: 0x0
// Checksum 0x5bb3347d, Offset: 0x290
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_crafting_table_menu/sr_crafting_table_menu
// Params 1, eflags: 0x0
// Checksum 0xee6672d0, Offset: 0x2b8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

