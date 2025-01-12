#using scripts\core_common\lui_shared;

#namespace revive_hud;

// Namespace revive_hud
// Method(s) 9 Total 15
class crevive_hud : cluielem {

    // Namespace crevive_hud/revive_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7a1517fc, Offset: 0x548
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0xfbd30c38, Offset: 0x5e8
    // Size: 0x30
    function set_fadetime(localclientnum, value) {
        set_data(localclientnum, "fadeTime", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x6ecf8f0, Offset: 0x5b0
    // Size: 0x30
    function set_clientnum(localclientnum, value) {
        set_data(localclientnum, "clientNum", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 0, eflags: 0x1 linked
    // Checksum 0x88974221, Offset: 0x490
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("revive_hud");
    }

    // Namespace crevive_hud/revive_hud
    // Params 3, eflags: 0x1 linked
    // Checksum 0x712271d1, Offset: 0x3d8
    // Size: 0xac
    function setup_clientfields(*textcallback, var_c05c67e2, var_415094af) {
        cluielem::setup_clientfields("revive_hud");
        cluielem::function_dcb34c80("string", "text", 1);
        cluielem::add_clientfield("clientNum", 1, 6, "int", var_c05c67e2);
        cluielem::add_clientfield("fadeTime", 1, 5, "int", var_415094af);
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7f2ba8d8, Offset: 0x578
    // Size: 0x30
    function set_text(localclientnum, value) {
        set_data(localclientnum, "text", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0xbd35f95e, Offset: 0x4b8
    // Size: 0x84
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "text", #"");
        set_data(localclientnum, "clientNum", 0);
        set_data(localclientnum, "fadeTime", 0);
    }

}

// Namespace revive_hud/revive_hud
// Params 3, eflags: 0x1 linked
// Checksum 0x8dcc2c2e, Offset: 0xd8
// Size: 0x18e
function register(textcallback, var_c05c67e2, var_415094af) {
    elem = new crevive_hud();
    [[ elem ]]->setup_clientfields(textcallback, var_c05c67e2, var_415094af);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"revive_hud"])) {
        level.var_ae746e8f[#"revive_hud"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"revive_hud"])) {
        level.var_ae746e8f[#"revive_hud"] = [];
    } else if (!isarray(level.var_ae746e8f[#"revive_hud"])) {
        level.var_ae746e8f[#"revive_hud"] = array(level.var_ae746e8f[#"revive_hud"]);
    }
    level.var_ae746e8f[#"revive_hud"][level.var_ae746e8f[#"revive_hud"].size] = elem;
}

// Namespace revive_hud/revive_hud
// Params 0, eflags: 0x0
// Checksum 0x4e6f9e80, Offset: 0x270
// Size: 0x34
function register_clientside() {
    elem = new crevive_hud();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0x80b5a794, Offset: 0x2b0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0x97062dbc, Offset: 0x2d8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0x1041185c, Offset: 0x300
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0x3a52a4a2, Offset: 0x328
// Size: 0x28
function set_text(localclientnum, value) {
    [[ self ]]->set_text(localclientnum, value);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0xab837c50, Offset: 0x358
// Size: 0x28
function set_clientnum(localclientnum, value) {
    [[ self ]]->set_clientnum(localclientnum, value);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0xe9bf94d0, Offset: 0x388
// Size: 0x28
function set_fadetime(localclientnum, value) {
    [[ self ]]->set_fadetime(localclientnum, value);
}

