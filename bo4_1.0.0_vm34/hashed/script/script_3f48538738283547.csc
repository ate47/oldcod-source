#using scripts\core_common\lui_shared;

#namespace zm_towers_crowd_meter;

// Namespace zm_towers_crowd_meter
// Method(s) 8 Total 14
class czm_towers_crowd_meter : cluielem {

    // Namespace czm_towers_crowd_meter/zm_towers_crowd_meter
    // Params 2, eflags: 0x0
    // Checksum 0x47644a5d, Offset: 0x648
    // Size: 0x30
    function set_visible(localclientnum, value) {
        set_data(localclientnum, "visible", value);
    }

    // Namespace czm_towers_crowd_meter/zm_towers_crowd_meter
    // Params 2, eflags: 0x0
    // Checksum 0x10d7a398, Offset: 0x398
    // Size: 0x2a4
    function set_state(localclientnum, state_name) {
        if (#"defaultstate" == state_name) {
            set_data(localclientnum, "_state", 0);
            return;
        }
        if (#"crowd_loathes" == state_name) {
            set_data(localclientnum, "_state", 1);
            return;
        }
        if (#"crowd_hates" == state_name) {
            set_data(localclientnum, "_state", 2);
            return;
        }
        if (#"crowd_no_love" == state_name) {
            set_data(localclientnum, "_state", 3);
            return;
        }
        if (#"crowd_warm_up" == state_name) {
            set_data(localclientnum, "_state", 4);
            return;
        }
        if (#"crowd_likes" == state_name) {
            set_data(localclientnum, "_state", 5);
            return;
        }
        if (#"crowd_loves" == state_name) {
            set_data(localclientnum, "_state", 6);
            return;
        }
        if (#"crowd_power_up_available_good" == state_name) {
            set_data(localclientnum, "_state", 7);
            return;
        }
        if (#"crowd_power_up_available_bad" == state_name) {
            set_data(localclientnum, "_state", 8);
            return;
        }
        if (#"crowd_power_up_available_good_partial" == state_name) {
            set_data(localclientnum, "_state", 9);
            return;
        }
        if (#"crowd_power_up_available_bad_partial" == state_name) {
            set_data(localclientnum, "_state", 10);
            return;
        }
        assertmsg("<dev string:x30>");
    }

    // Namespace czm_towers_crowd_meter/zm_towers_crowd_meter
    // Params 1, eflags: 0x0
    // Checksum 0xba2abdf8, Offset: 0x360
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_towers_crowd_meter");
    }

    // Namespace czm_towers_crowd_meter/zm_towers_crowd_meter
    // Params 1, eflags: 0x0
    // Checksum 0x6757fa1, Offset: 0x2f8
    // Size: 0x60
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "visible", 0);
    }

    // Namespace czm_towers_crowd_meter/zm_towers_crowd_meter
    // Params 1, eflags: 0x0
    // Checksum 0xb724223c, Offset: 0x2c8
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_towers_crowd_meter/zm_towers_crowd_meter
    // Params 2, eflags: 0x0
    // Checksum 0xb6ecd5f8, Offset: 0x240
    // Size: 0x7c
    function setup_clientfields(uid, var_1d32b384) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("_state", 1, 4, "int");
        cluielem::add_clientfield("visible", 1, 1, "int", var_1d32b384);
    }

}

// Namespace zm_towers_crowd_meter/zm_towers_crowd_meter
// Params 2, eflags: 0x0
// Checksum 0x871a9c6e, Offset: 0xa8
// Size: 0x4c
function register(uid, var_1d32b384) {
    elem = new czm_towers_crowd_meter();
    [[ elem ]]->setup_clientfields(uid, var_1d32b384);
    return elem;
}

// Namespace zm_towers_crowd_meter/zm_towers_crowd_meter
// Params 1, eflags: 0x0
// Checksum 0xd70d99d7, Offset: 0x100
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_towers_crowd_meter();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_towers_crowd_meter/zm_towers_crowd_meter
// Params 1, eflags: 0x0
// Checksum 0xa90f65c8, Offset: 0x148
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_towers_crowd_meter/zm_towers_crowd_meter
// Params 1, eflags: 0x0
// Checksum 0x1be526a0, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_towers_crowd_meter/zm_towers_crowd_meter
// Params 1, eflags: 0x0
// Checksum 0xa85a46a7, Offset: 0x198
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_towers_crowd_meter/zm_towers_crowd_meter
// Params 2, eflags: 0x0
// Checksum 0x5201f97, Offset: 0x1c0
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace zm_towers_crowd_meter/zm_towers_crowd_meter
// Params 2, eflags: 0x0
// Checksum 0xaf872caa, Offset: 0x1f0
// Size: 0x28
function set_visible(localclientnum, value) {
    [[ self ]]->set_visible(localclientnum, value);
}

