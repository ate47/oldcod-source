#using scripts\core_common\lui_shared;

#namespace blackseajetskideployprompt;

// Namespace blackseajetskideployprompt
// Method(s) 7 Total 14
class class_6b831806 : cluielem {

    // Namespace namespace_6b831806/blackseajetskideployprompt
    // Params 1, eflags: 0x0
    // Checksum 0x8ffc2c76, Offset: 0x428
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_6b831806/blackseajetskideployprompt
    // Params 2, eflags: 0x0
    // Checksum 0x341cf7b0, Offset: 0x458
    // Size: 0x30
    function function_26d9350e(localclientnum, value) {
        set_data(localclientnum, "deployProgress", value);
    }

    // Namespace namespace_6b831806/blackseajetskideployprompt
    // Params 0, eflags: 0x0
    // Checksum 0x8fd14dc7, Offset: 0x3b0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("BlackSeaJetskiDeployPrompt");
    }

    // Namespace namespace_6b831806/blackseajetskideployprompt
    // Params 1, eflags: 0x0
    // Checksum 0x89c38ed7, Offset: 0x358
    // Size: 0x4c
    function setup_clientfields(var_8c9ddf96) {
        cluielem::setup_clientfields("BlackSeaJetskiDeployPrompt");
        cluielem::add_clientfield("deployProgress", 1, 5, "float", var_8c9ddf96);
    }

    // Namespace namespace_6b831806/blackseajetskideployprompt
    // Params 1, eflags: 0x0
    // Checksum 0xbcf66b3b, Offset: 0x3d8
    // Size: 0x48
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "deployProgress", 0);
    }

}

// Namespace blackseajetskideployprompt/blackseajetskideployprompt
// Params 1, eflags: 0x0
// Checksum 0xceedae8a, Offset: 0xd0
// Size: 0x176
function register(var_8c9ddf96) {
    elem = new class_6b831806();
    [[ elem ]]->setup_clientfields(var_8c9ddf96);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"blackseajetskideployprompt"])) {
        level.var_ae746e8f[#"blackseajetskideployprompt"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"blackseajetskideployprompt"])) {
        level.var_ae746e8f[#"blackseajetskideployprompt"] = [];
    } else if (!isarray(level.var_ae746e8f[#"blackseajetskideployprompt"])) {
        level.var_ae746e8f[#"blackseajetskideployprompt"] = array(level.var_ae746e8f[#"blackseajetskideployprompt"]);
    }
    level.var_ae746e8f[#"blackseajetskideployprompt"][level.var_ae746e8f[#"blackseajetskideployprompt"].size] = elem;
}

// Namespace blackseajetskideployprompt/blackseajetskideployprompt
// Params 0, eflags: 0x0
// Checksum 0x89bd5c2, Offset: 0x250
// Size: 0x34
function register_clientside() {
    elem = new class_6b831806();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace blackseajetskideployprompt/blackseajetskideployprompt
// Params 1, eflags: 0x0
// Checksum 0x2fda424a, Offset: 0x290
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace blackseajetskideployprompt/blackseajetskideployprompt
// Params 1, eflags: 0x0
// Checksum 0xe17db5dd, Offset: 0x2b8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace blackseajetskideployprompt/blackseajetskideployprompt
// Params 1, eflags: 0x0
// Checksum 0x18f3ce28, Offset: 0x2e0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace blackseajetskideployprompt/blackseajetskideployprompt
// Params 2, eflags: 0x0
// Checksum 0xb6323ddc, Offset: 0x308
// Size: 0x28
function function_26d9350e(localclientnum, value) {
    [[ self ]]->function_26d9350e(localclientnum, value);
}

