#using scripts\core_common\lui_shared;

#namespace zm_hint_text;

// Namespace zm_hint_text
// Method(s) 8 Total 14
class czm_hint_text : cluielem {

    // Namespace czm_hint_text/zm_hint_text
    // Params 2, eflags: 0x0
    // Checksum 0x6f21ff97, Offset: 0x468
    // Size: 0x30
    function set_text(localclientnum, value) {
        set_data(localclientnum, "text", value);
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 2, eflags: 0x0
    // Checksum 0x2f9f4ea, Offset: 0x3b0
    // Size: 0xac
    function set_state(localclientnum, state_name) {
        if (#"defaultstate" == state_name) {
            set_data(localclientnum, "_state", 0);
            return;
        }
        if (#"visible" == state_name) {
            set_data(localclientnum, "_state", 1);
            return;
        }
        assertmsg("<dev string:x30>");
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 1, eflags: 0x0
    // Checksum 0x5368abe5, Offset: 0x378
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_hint_text");
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 1, eflags: 0x0
    // Checksum 0x3058d32, Offset: 0x300
    // Size: 0x6c
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "text", #"");
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 1, eflags: 0x0
    // Checksum 0x3c299d2b, Offset: 0x2d0
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 2, eflags: 0x0
    // Checksum 0x765e31ea, Offset: 0x248
    // Size: 0x7c
    function setup_clientfields(uid, textcallback) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::function_52818084("string", "text", 1);
    }

}

// Namespace zm_hint_text/zm_hint_text
// Params 2, eflags: 0x0
// Checksum 0xeb1a84ec, Offset: 0xb0
// Size: 0x4c
function register(uid, textcallback) {
    elem = new czm_hint_text();
    [[ elem ]]->setup_clientfields(uid, textcallback);
    return elem;
}

// Namespace zm_hint_text/zm_hint_text
// Params 1, eflags: 0x0
// Checksum 0x825f2f1f, Offset: 0x108
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_hint_text();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_hint_text/zm_hint_text
// Params 1, eflags: 0x0
// Checksum 0x98c0bedd, Offset: 0x150
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_hint_text/zm_hint_text
// Params 1, eflags: 0x0
// Checksum 0xe918e8b, Offset: 0x178
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_hint_text/zm_hint_text
// Params 1, eflags: 0x0
// Checksum 0x3d10d73a, Offset: 0x1a0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_hint_text/zm_hint_text
// Params 2, eflags: 0x0
// Checksum 0x5b9a4d42, Offset: 0x1c8
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace zm_hint_text/zm_hint_text
// Params 2, eflags: 0x0
// Checksum 0x5a821cfe, Offset: 0x1f8
// Size: 0x28
function set_text(localclientnum, value) {
    [[ self ]]->set_text(localclientnum, value);
}

