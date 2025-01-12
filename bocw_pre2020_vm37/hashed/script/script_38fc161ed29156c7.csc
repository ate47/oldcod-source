#using scripts\core_common\lui_shared;

#namespace success_screen;

// Namespace success_screen
// Method(s) 6 Total 12
class csuccess_screen : cluielem {

    // Namespace csuccess_screen/success_screen
    // Params 1, eflags: 0x0
    // Checksum 0xb502f0c2, Offset: 0x378
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace csuccess_screen/success_screen
    // Params 0, eflags: 0x0
    // Checksum 0xb6c3af0f, Offset: 0x320
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("success_screen");
    }

    // Namespace csuccess_screen/success_screen
    // Params 0, eflags: 0x0
    // Checksum 0xa225067f, Offset: 0x2f8
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("success_screen");
    }

    // Namespace csuccess_screen/success_screen
    // Params 1, eflags: 0x0
    // Checksum 0x3b60537e, Offset: 0x348
    // Size: 0x24
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
    }

}

// Namespace success_screen/success_screen
// Params 0, eflags: 0x0
// Checksum 0x65ed6901, Offset: 0xa8
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
// Checksum 0x58063267, Offset: 0x220
// Size: 0x34
function register_clientside() {
    elem = new csuccess_screen();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0x2f24cb7f, Offset: 0x260
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0xfe358745, Offset: 0x288
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace success_screen/success_screen
// Params 1, eflags: 0x0
// Checksum 0x3a06b5f7, Offset: 0x2b0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

