#using scripts\core_common\lui_shared;

#namespace zm_arcade_timer;

// Namespace zm_arcade_timer
// Method(s) 10 Total 16
class czm_arcade_timer : cluielem {

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 2, eflags: 0x0
    // Checksum 0xff6983cb, Offset: 0x588
    // Size: 0x30
    function set_title(localclientnum, value) {
        set_data(localclientnum, "title", value);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 2, eflags: 0x0
    // Checksum 0x4c3c0005, Offset: 0x550
    // Size: 0x30
    function set_minutes(localclientnum, value) {
        set_data(localclientnum, "minutes", value);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 2, eflags: 0x0
    // Checksum 0x259f1113, Offset: 0x518
    // Size: 0x30
    function set_seconds(localclientnum, value) {
        set_data(localclientnum, "seconds", value);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 2, eflags: 0x0
    // Checksum 0xb7cefd6f, Offset: 0x4e0
    // Size: 0x30
    function set_showzero(localclientnum, value) {
        set_data(localclientnum, "showzero", value);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 1, eflags: 0x0
    // Checksum 0x2dfb6e1c, Offset: 0x4a8
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_arcade_timer");
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 1, eflags: 0x0
    // Checksum 0xf1ee6718, Offset: 0x3f8
    // Size: 0xa4
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "showzero", 0);
        set_data(localclientnum, "seconds", 0);
        set_data(localclientnum, "minutes", 0);
        set_data(localclientnum, "title", #"");
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 1, eflags: 0x0
    // Checksum 0xaf956be3, Offset: 0x3c8
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_arcade_timer/zm_arcade_timer
    // Params 5, eflags: 0x0
    // Checksum 0xc1f24ee7, Offset: 0x2d8
    // Size: 0xe4
    function setup_clientfields(uid, var_6a2be891, var_f7588fa5, var_563b0bfd, var_6e945820) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("showzero", 1, 1, "int", var_6a2be891);
        cluielem::add_clientfield("seconds", 1, 6, "int", var_f7588fa5);
        cluielem::add_clientfield("minutes", 1, 4, "int", var_563b0bfd);
        cluielem::function_52818084("string", "title", 1);
    }

}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 5, eflags: 0x0
// Checksum 0x13535c5, Offset: 0xc0
// Size: 0x70
function register(uid, var_6a2be891, var_f7588fa5, var_563b0bfd, var_6e945820) {
    elem = new czm_arcade_timer();
    [[ elem ]]->setup_clientfields(uid, var_6a2be891, var_f7588fa5, var_563b0bfd, var_6e945820);
    return elem;
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0x5318ceb5, Offset: 0x138
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_arcade_timer();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0x64846d9f, Offset: 0x180
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0xa7d6a427, Offset: 0x1a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 1, eflags: 0x0
// Checksum 0x443a40f2, Offset: 0x1d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 2, eflags: 0x0
// Checksum 0x593c9442, Offset: 0x1f8
// Size: 0x28
function set_showzero(localclientnum, value) {
    [[ self ]]->set_showzero(localclientnum, value);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 2, eflags: 0x0
// Checksum 0x6d8dd4ad, Offset: 0x228
// Size: 0x28
function set_seconds(localclientnum, value) {
    [[ self ]]->set_seconds(localclientnum, value);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 2, eflags: 0x0
// Checksum 0x1c34274b, Offset: 0x258
// Size: 0x28
function set_minutes(localclientnum, value) {
    [[ self ]]->set_minutes(localclientnum, value);
}

// Namespace zm_arcade_timer/zm_arcade_timer
// Params 2, eflags: 0x0
// Checksum 0xd9b8ed72, Offset: 0x288
// Size: 0x28
function set_title(localclientnum, value) {
    [[ self ]]->set_title(localclientnum, value);
}

