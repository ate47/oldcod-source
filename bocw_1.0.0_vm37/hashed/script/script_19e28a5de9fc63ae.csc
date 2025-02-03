#using scripts\core_common\lui_shared;

#namespace fail_screen;

// Namespace fail_screen
// Method(s) 6 Total 13
class cfail_screen : cluielem {

    // Namespace cfail_screen/fail_screen
    // Params 1, eflags: 0x0
    // Checksum 0xed23407a, Offset: 0x378
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cfail_screen/fail_screen
    // Params 0, eflags: 0x0
    // Checksum 0xc624847c, Offset: 0x320
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("fail_screen");
    }

    // Namespace cfail_screen/fail_screen
    // Params 0, eflags: 0x0
    // Checksum 0x787dc64f, Offset: 0x2f8
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("fail_screen");
    }

    // Namespace cfail_screen/fail_screen
    // Params 1, eflags: 0x0
    // Checksum 0x71318d26, Offset: 0x348
    // Size: 0x24
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
    }

}

// Namespace fail_screen/fail_screen
// Params 0, eflags: 0x0
// Checksum 0x41a2bb1e, Offset: 0xa8
// Size: 0x16e
function register() {
    elem = new cfail_screen();
    [[ elem ]]->setup_clientfields();
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"fail_screen"])) {
        level.var_ae746e8f[#"fail_screen"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"fail_screen"])) {
        level.var_ae746e8f[#"fail_screen"] = [];
    } else if (!isarray(level.var_ae746e8f[#"fail_screen"])) {
        level.var_ae746e8f[#"fail_screen"] = array(level.var_ae746e8f[#"fail_screen"]);
    }
    level.var_ae746e8f[#"fail_screen"][level.var_ae746e8f[#"fail_screen"].size] = elem;
}

// Namespace fail_screen/fail_screen
// Params 0, eflags: 0x0
// Checksum 0xb232745f, Offset: 0x220
// Size: 0x34
function register_clientside() {
    elem = new cfail_screen();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0x4d75ee64, Offset: 0x260
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0x3a0ecd95, Offset: 0x288
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace fail_screen/fail_screen
// Params 1, eflags: 0x0
// Checksum 0x3c9c6153, Offset: 0x2b0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

