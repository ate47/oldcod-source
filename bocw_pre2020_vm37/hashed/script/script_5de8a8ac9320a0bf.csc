#using scripts\core_common\lui_shared;

#namespace debug_center_screen;

// Namespace debug_center_screen
// Method(s) 6 Total 12
class cdebug_center_screen : cluielem {

    // Namespace cdebug_center_screen/debug_center_screen
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb2e19ca5, Offset: 0x380
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cdebug_center_screen/debug_center_screen
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9fd3e8f1, Offset: 0x328
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("debug_center_screen");
    }

    // Namespace cdebug_center_screen/debug_center_screen
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1fcb5ca1, Offset: 0x300
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("debug_center_screen");
    }

    // Namespace cdebug_center_screen/debug_center_screen
    // Params 1, eflags: 0x1 linked
    // Checksum 0xeb65571a, Offset: 0x350
    // Size: 0x24
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
    }

}

// Namespace debug_center_screen/debug_center_screen
// Params 0, eflags: 0x1 linked
// Checksum 0x9e01f4bd, Offset: 0xb0
// Size: 0x16e
function register() {
    elem = new cdebug_center_screen();
    [[ elem ]]->setup_clientfields();
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"debug_center_screen"])) {
        level.var_ae746e8f[#"debug_center_screen"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"debug_center_screen"])) {
        level.var_ae746e8f[#"debug_center_screen"] = [];
    } else if (!isarray(level.var_ae746e8f[#"debug_center_screen"])) {
        level.var_ae746e8f[#"debug_center_screen"] = array(level.var_ae746e8f[#"debug_center_screen"]);
    }
    level.var_ae746e8f[#"debug_center_screen"][level.var_ae746e8f[#"debug_center_screen"].size] = elem;
}

// Namespace debug_center_screen/debug_center_screen
// Params 0, eflags: 0x0
// Checksum 0x7f1b0f3d, Offset: 0x228
// Size: 0x34
function register_clientside() {
    elem = new cdebug_center_screen();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace debug_center_screen/debug_center_screen
// Params 1, eflags: 0x0
// Checksum 0x2736f8b1, Offset: 0x268
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace debug_center_screen/debug_center_screen
// Params 1, eflags: 0x0
// Checksum 0x9f887ead, Offset: 0x290
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace debug_center_screen/debug_center_screen
// Params 1, eflags: 0x0
// Checksum 0xe8fca674, Offset: 0x2b8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

