#using scripts\core_common\lui_shared;

#namespace revive_hud;

// Namespace revive_hud
// Method(s) 9 Total 16
class crevive_hud : cluielem {

    // Namespace crevive_hud/revive_hud
    // Params 1, eflags: 0x0
    // Checksum 0x9ee2a7da, Offset: 0x548
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0xf7f04290, Offset: 0x5e8
    // Size: 0x30
    function set_fadetime(localclientnum, value) {
        set_data(localclientnum, "fadeTime", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0x57c9d485, Offset: 0x5b0
    // Size: 0x30
    function set_clientnum(localclientnum, value) {
        set_data(localclientnum, "clientNum", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 0, eflags: 0x0
    // Checksum 0x57d40b6b, Offset: 0x490
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("revive_hud");
    }

    // Namespace crevive_hud/revive_hud
    // Params 3, eflags: 0x0
    // Checksum 0x1629afad, Offset: 0x3d8
    // Size: 0xac
    function setup_clientfields(*textcallback, var_c05c67e2, var_415094af) {
        cluielem::setup_clientfields("revive_hud");
        cluielem::function_dcb34c80("string", "text", 1);
        cluielem::add_clientfield("clientNum", 1, 6, "int", var_c05c67e2);
        cluielem::add_clientfield("fadeTime", 1, 5, "int", var_415094af);
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0x3a341801, Offset: 0x578
    // Size: 0x30
    function set_text(localclientnum, value) {
        set_data(localclientnum, "text", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 1, eflags: 0x0
    // Checksum 0xc7066dd5, Offset: 0x4b8
    // Size: 0x84
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "text", #"");
        set_data(localclientnum, "clientNum", 0);
        set_data(localclientnum, "fadeTime", 0);
    }

}

// Namespace revive_hud/revive_hud
// Params 3, eflags: 0x0
// Checksum 0xf91d8546, Offset: 0xd8
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
// Checksum 0x905567fc, Offset: 0x270
// Size: 0x34
function register_clientside() {
    elem = new crevive_hud();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0x4214b4c2, Offset: 0x2b0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0xd12b069d, Offset: 0x2d8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0x3a7b6cfe, Offset: 0x300
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0x7200e110, Offset: 0x328
// Size: 0x28
function set_text(localclientnum, value) {
    [[ self ]]->set_text(localclientnum, value);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0x7dc674ac, Offset: 0x358
// Size: 0x28
function set_clientnum(localclientnum, value) {
    [[ self ]]->set_clientnum(localclientnum, value);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0x9c10c4e6, Offset: 0x388
// Size: 0x28
function set_fadetime(localclientnum, value) {
    [[ self ]]->set_fadetime(localclientnum, value);
}

