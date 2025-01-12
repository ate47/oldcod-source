#using scripts\core_common\lui_shared;

#namespace zm_game_over;

// Namespace zm_game_over
// Method(s) 7 Total 13
class czm_game_over : cluielem {

    // Namespace czm_game_over/zm_game_over
    // Params 2, eflags: 0x0
    // Checksum 0x2c233551, Offset: 0x318
    // Size: 0x30
    function set_rounds(localclientnum, value) {
        set_data(localclientnum, "rounds", value);
    }

    // Namespace czm_game_over/zm_game_over
    // Params 1, eflags: 0x0
    // Checksum 0x52c0daa, Offset: 0x2e0
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_game_over");
    }

    // Namespace czm_game_over/zm_game_over
    // Params 1, eflags: 0x0
    // Checksum 0x1232e1bc, Offset: 0x298
    // Size: 0x40
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "rounds", 0);
    }

    // Namespace czm_game_over/zm_game_over
    // Params 1, eflags: 0x0
    // Checksum 0xcdc179ad, Offset: 0x268
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_game_over/zm_game_over
    // Params 2, eflags: 0x0
    // Checksum 0x1218187e, Offset: 0x208
    // Size: 0x54
    function setup_clientfields(uid, var_34600867) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("rounds", 1, 8, "int", var_34600867);
    }

}

// Namespace zm_game_over/zm_game_over
// Params 2, eflags: 0x0
// Checksum 0x4cde2f28, Offset: 0xa0
// Size: 0x4c
function register(uid, var_34600867) {
    elem = new czm_game_over();
    [[ elem ]]->setup_clientfields(uid, var_34600867);
    return elem;
}

// Namespace zm_game_over/zm_game_over
// Params 1, eflags: 0x0
// Checksum 0xae217d5, Offset: 0xf8
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_game_over();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_game_over/zm_game_over
// Params 1, eflags: 0x0
// Checksum 0xba683cb7, Offset: 0x140
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_game_over/zm_game_over
// Params 1, eflags: 0x0
// Checksum 0x6a2e6dee, Offset: 0x168
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_game_over/zm_game_over
// Params 1, eflags: 0x0
// Checksum 0x581541f7, Offset: 0x190
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_game_over/zm_game_over
// Params 2, eflags: 0x0
// Checksum 0x7fd34c81, Offset: 0x1b8
// Size: 0x28
function set_rounds(localclientnum, value) {
    [[ self ]]->set_rounds(localclientnum, value);
}

