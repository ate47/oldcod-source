#using scripts\core_common\lui_shared;

#namespace zm_game_over;

// Namespace zm_game_over
// Method(s) 8 Total 14
class czm_game_over : cluielem {

    // Namespace czm_game_over/zm_game_over
    // Params 1, eflags: 0x1 linked
    // Checksum 0xecbcea2a, Offset: 0x488
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace czm_game_over/zm_game_over
    // Params 0, eflags: 0x1 linked
    // Checksum 0x50278e7b, Offset: 0x3f8
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("zm_game_over");
    }

    // Namespace czm_game_over/zm_game_over
    // Params 1, eflags: 0x1 linked
    // Checksum 0x45666955, Offset: 0x378
    // Size: 0x74
    function setup_clientfields(var_ddbc37b7) {
        cluielem::setup_clientfields("zm_game_over");
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::add_clientfield("rounds", 1, 8, "int", var_ddbc37b7);
    }

    // Namespace czm_game_over/zm_game_over
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2b752d37, Offset: 0x570
    // Size: 0x30
    function set_rounds(localclientnum, value) {
        set_data(localclientnum, "rounds", value);
    }

    // Namespace czm_game_over/zm_game_over
    // Params 2, eflags: 0x1 linked
    // Checksum 0xcb8f3e5d, Offset: 0x4b8
    // Size: 0xac
    function set_state(localclientnum, state_name) {
        if (#"defaultstate" == state_name) {
            set_data(localclientnum, "_state", 0);
            return;
        }
        if (#"gatewayopened" == state_name) {
            set_data(localclientnum, "_state", 1);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace czm_game_over/zm_game_over
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8f99c506, Offset: 0x420
    // Size: 0x60
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "rounds", 0);
    }

}

// Namespace zm_game_over/zm_game_over
// Params 1, eflags: 0x1 linked
// Checksum 0x7f6cd819, Offset: 0xc0
// Size: 0x176
function register(var_ddbc37b7) {
    elem = new czm_game_over();
    [[ elem ]]->setup_clientfields(var_ddbc37b7);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"zm_game_over"])) {
        level.var_ae746e8f[#"zm_game_over"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"zm_game_over"])) {
        level.var_ae746e8f[#"zm_game_over"] = [];
    } else if (!isarray(level.var_ae746e8f[#"zm_game_over"])) {
        level.var_ae746e8f[#"zm_game_over"] = array(level.var_ae746e8f[#"zm_game_over"]);
    }
    level.var_ae746e8f[#"zm_game_over"][level.var_ae746e8f[#"zm_game_over"].size] = elem;
}

// Namespace zm_game_over/zm_game_over
// Params 0, eflags: 0x0
// Checksum 0xa40022bc, Offset: 0x240
// Size: 0x34
function register_clientside() {
    elem = new czm_game_over();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace zm_game_over/zm_game_over
// Params 1, eflags: 0x0
// Checksum 0x459c6d40, Offset: 0x280
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_game_over/zm_game_over
// Params 1, eflags: 0x0
// Checksum 0xe8c94162, Offset: 0x2a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_game_over/zm_game_over
// Params 1, eflags: 0x0
// Checksum 0x816edbed, Offset: 0x2d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_game_over/zm_game_over
// Params 2, eflags: 0x0
// Checksum 0xcab75ab8, Offset: 0x2f8
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace zm_game_over/zm_game_over
// Params 2, eflags: 0x0
// Checksum 0xdb12c6ca, Offset: 0x328
// Size: 0x28
function set_rounds(localclientnum, value) {
    [[ self ]]->set_rounds(localclientnum, value);
}

