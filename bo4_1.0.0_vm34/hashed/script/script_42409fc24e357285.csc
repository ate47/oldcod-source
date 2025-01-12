#using scripts\core_common\lui_shared;

#namespace zm_game_timer;

// Namespace zm_game_timer
// Method(s) 9 Total 15
class czm_game_timer : cluielem {

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x0
    // Checksum 0x7f2e92b3, Offset: 0x4b0
    // Size: 0x30
    function set_showzero(localclientnum, value) {
        set_data(localclientnum, "showzero", value);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x0
    // Checksum 0x537c58cc, Offset: 0x478
    // Size: 0x30
    function set_minutes(localclientnum, value) {
        set_data(localclientnum, "minutes", value);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 2, eflags: 0x0
    // Checksum 0x3be8e23a, Offset: 0x440
    // Size: 0x30
    function set_seconds(localclientnum, value) {
        set_data(localclientnum, "seconds", value);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 1, eflags: 0x0
    // Checksum 0x8293f377, Offset: 0x408
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_game_timer");
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 1, eflags: 0x0
    // Checksum 0x6cda7fb0, Offset: 0x388
    // Size: 0x78
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "seconds", 0);
        set_data(localclientnum, "minutes", 0);
        set_data(localclientnum, "showzero", 0);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 1, eflags: 0x0
    // Checksum 0xc231ddaa, Offset: 0x358
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_game_timer/zm_game_timer
    // Params 4, eflags: 0x0
    // Checksum 0x10738a48, Offset: 0x298
    // Size: 0xb4
    function setup_clientfields(uid, var_f7588fa5, var_563b0bfd, var_6a2be891) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("seconds", 1, 6, "int", var_f7588fa5);
        cluielem::add_clientfield("minutes", 1, 9, "int", var_563b0bfd);
        cluielem::add_clientfield("showzero", 1, 1, "int", var_6a2be891);
    }

}

// Namespace zm_game_timer/zm_game_timer
// Params 4, eflags: 0x0
// Checksum 0x15fe2719, Offset: 0xb8
// Size: 0x64
function register(uid, var_f7588fa5, var_563b0bfd, var_6a2be891) {
    elem = new czm_game_timer();
    [[ elem ]]->setup_clientfields(uid, var_f7588fa5, var_563b0bfd, var_6a2be891);
    return elem;
}

// Namespace zm_game_timer/zm_game_timer
// Params 1, eflags: 0x0
// Checksum 0xe310fe75, Offset: 0x128
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_game_timer();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_game_timer/zm_game_timer
// Params 1, eflags: 0x0
// Checksum 0x86265264, Offset: 0x170
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_game_timer/zm_game_timer
// Params 1, eflags: 0x0
// Checksum 0xcda21fb0, Offset: 0x198
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_game_timer/zm_game_timer
// Params 1, eflags: 0x0
// Checksum 0xe2ccc002, Offset: 0x1c0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0xb7e2a9bf, Offset: 0x1e8
// Size: 0x28
function set_seconds(localclientnum, value) {
    [[ self ]]->set_seconds(localclientnum, value);
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0x76b2ed4, Offset: 0x218
// Size: 0x28
function set_minutes(localclientnum, value) {
    [[ self ]]->set_minutes(localclientnum, value);
}

// Namespace zm_game_timer/zm_game_timer
// Params 2, eflags: 0x0
// Checksum 0x319830c7, Offset: 0x248
// Size: 0x28
function set_showzero(localclientnum, value) {
    [[ self ]]->set_showzero(localclientnum, value);
}

