#using scripts\core_common\lui_shared;

#namespace debug_center_screen;

// Namespace debug_center_screen
// Method(s) 6 Total 13
class cdebug_center_screen : cluielem {

    // Namespace cdebug_center_screen/debug_center_screen
    // Params 1, eflags: 0x0
    // Checksum 0xed23407a, Offset: 0x380
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cdebug_center_screen/debug_center_screen
    // Params 0, eflags: 0x0
    // Checksum 0xc624847c, Offset: 0x328
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("debug_center_screen");
    }

    // Namespace cdebug_center_screen/debug_center_screen
    // Params 0, eflags: 0x0
    // Checksum 0x787dc64f, Offset: 0x300
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("debug_center_screen");
    }

    // Namespace cdebug_center_screen/debug_center_screen
    // Params 1, eflags: 0x0
    // Checksum 0x71318d26, Offset: 0x350
    // Size: 0x24
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
    }

}

// Namespace debug_center_screen/debug_center_screen
// Params 0, eflags: 0x0
// Checksum 0xe43c7132, Offset: 0xb0
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
// Checksum 0x7c82db8, Offset: 0x228
// Size: 0x34
function register_clientside() {
    elem = new cdebug_center_screen();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace debug_center_screen/debug_center_screen
// Params 1, eflags: 0x0
// Checksum 0x4d75ee64, Offset: 0x268
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace debug_center_screen/debug_center_screen
// Params 1, eflags: 0x0
// Checksum 0x3a0ecd95, Offset: 0x290
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace debug_center_screen/debug_center_screen
// Params 1, eflags: 0x0
// Checksum 0x3c9c6153, Offset: 0x2b8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

