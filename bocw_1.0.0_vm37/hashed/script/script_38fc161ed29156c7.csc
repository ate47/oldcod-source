#using scripts\core_common\lui_shared;

#namespace success_screen;

// Namespace success_screen
// Method(s) 6 Total 13
class csuccess_screen : cluielem {

    // Namespace csuccess_screen/success_screen
    // Params 1, eflags: 0x0
    // Checksum 0xeac02c1d, Offset: 0x378
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace csuccess_screen/success_screen
    // Params 0, eflags: 0x0
    // Checksum 0xef34c382, Offset: 0x320
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("success_screen");
    }

    // Namespace csuccess_screen/success_screen
    // Params 0, eflags: 0x0
    // Checksum 0xc5939c91, Offset: 0x2f8
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("success_screen");
    }

    // Namespace csuccess_screen/success_screen
    // Params 1, eflags: 0x0
    // Checksum 0xa1348942, Offset: 0x348
    // Size: 0x24
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
    }

}

// Namespace success_screen/success_screen
// Params 0, eflags: 0x0
// Checksum 0x1fd0ec8e, Offset: 0xa8
// Size: 0x16e
function register() {
    elem = new csuccess_screen();
    [[ elem ]]->setup_clientfields();
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"success_screen"])) {
        level.var_ae746e8f[#"success_screen"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"success_screen"])) {
        level.var_ae746e8f[#"success_screen"] = [];
    } else if (!isarray(level.var_ae746e8f[#"success_screen"])) {
        level.var_ae746e8f[#"success_screen"] = array(level.var_ae746e8f[#"success_screen"]);
    }
    level.var_ae746e8f[#"success_screen"][level.var_ae746e8f[#"success_screen"].size] = elem;
}

// Namespace success_screen/success_screen
// Params 0, eflags: 0x0
// Checksum 0x20d510e2, Offset: 0x220
// Size: 0x34
function register_clientside() {
    elem = new csuccess_screen();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0x4567ddaa, Offset: 0x260
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0x5bb3347d, Offset: 0x288
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0xee6672d0, Offset: 0x2b0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

