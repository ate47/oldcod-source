#using scripts\core_common\lui_shared;

#namespace zm_game_timer;

// Namespace zm_game_timer
// Method(s) 9 Total 15
class czm_game_timer : cluielem {

    // Namespace czm_game_timer/zm_game_timer
    // Params 1, eflags: 0x0
    // Checksum 0x937dfb92, Offset: 0x530
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x0
    // Checksum 0xeb6de7c6, Offset: 0x598
    // Size: 0x30
    function set_minutes(localclientnum, value) {
        set_data(localclientnum, "minutes", value);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 0, eflags: 0x0
    // Checksum 0x39187675, Offset: 0x488
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("zm_game_timer");
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x0
    // Checksum 0xe5ca770f, Offset: 0x5d0
    // Size: 0x30
    function set_showzero(localclientnum, value) {
        set_data(localclientnum, "showzero", value);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 3, eflags: 0x0
    // Checksum 0x79310e78, Offset: 0x3d0
    // Size: 0xac
    function setup_clientfields(var_b1de907e, var_359a4d9a, var_8fd8bfaa) {
        cluielem::setup_clientfields("zm_game_timer");
        cluielem::add_clientfield("seconds", 1, 6, "int", var_b1de907e);
        cluielem::add_clientfield("minutes", 1, 9, "int", var_359a4d9a);
        cluielem::add_clientfield("showzero", 1, 1, "int", var_8fd8bfaa);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x0
    // Checksum 0xb091aa69, Offset: 0x560
    // Size: 0x30
    function set_seconds(localclientnum, value) {
        set_data(localclientnum, "seconds", value);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 1, eflags: 0x0
    // Checksum 0x2749d2, Offset: 0x4b0
    // Size: 0x78
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "seconds", 0);
        set_data(localclientnum, "minutes", 0);
        set_data(localclientnum, "showzero", 0);
    }

}

// Namespace zm_game_timer/zm_game_timer
// Params 3, eflags: 0x0
// Checksum 0x93f762e9, Offset: 0xd0
// Size: 0x18e
function register(var_b1de907e, var_359a4d9a, var_8fd8bfaa) {
    elem = new czm_game_timer();
    [[ elem ]]->setup_clientfields(var_b1de907e, var_359a4d9a, var_8fd8bfaa);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"zm_game_timer"])) {
        level.var_ae746e8f[#"zm_game_timer"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"zm_game_timer"])) {
        level.var_ae746e8f[#"zm_game_timer"] = [];
    } else if (!isarray(level.var_ae746e8f[#"zm_game_timer"])) {
        level.var_ae746e8f[#"zm_game_timer"] = array(level.var_ae746e8f[#"zm_game_timer"]);
    }
    level.var_ae746e8f[#"zm_game_timer"][level.var_ae746e8f[#"zm_game_timer"].size] = elem;
}

// Namespace zm_game_timer/zm_game_timer
// Params 0, eflags: 0x0
// Checksum 0xb83ec009, Offset: 0x268
// Size: 0x34
function register_clientside() {
    elem = new czm_game_timer();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace zm_game_timer/zm_game_timer
// Params 1, eflags: 0x0
// Checksum 0x98b486d2, Offset: 0x2a8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_game_timer/zm_game_timer
// Params 1, eflags: 0x0
// Checksum 0x2bbd320f, Offset: 0x2d0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_game_timer/zm_game_timer
// Params 1, eflags: 0x0
// Checksum 0xd4e223c8, Offset: 0x2f8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0xe22f3305, Offset: 0x320
// Size: 0x28
function set_seconds(localclientnum, value) {
    [[ self ]]->set_seconds(localclientnum, value);
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0xa8a7fcb4, Offset: 0x350
// Size: 0x28
function set_minutes(localclientnum, value) {
    [[ self ]]->set_minutes(localclientnum, value);
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0xd7ce9eef, Offset: 0x380
// Size: 0x28
function set_showzero(localclientnum, value) {
    [[ self ]]->set_showzero(localclientnum, value);
}

