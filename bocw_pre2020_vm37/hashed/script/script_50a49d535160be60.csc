#using scripts\core_common\lui_shared;

#namespace zm_hint_text;

// Namespace zm_hint_text
// Method(s) 8 Total 14
class czm_hint_text : cluielem {

    // Namespace czm_hint_text/zm_hint_text
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8bcdbbe4, Offset: 0x4a0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 0, eflags: 0x1 linked
    // Checksum 0x7c4fd9d2, Offset: 0x400
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("zm_hint_text");
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 1, eflags: 0x1 linked
    // Checksum 0x71f58bd1, Offset: 0x380
    // Size: 0x74
    function setup_clientfields(*textcallback) {
        cluielem::setup_clientfields("zm_hint_text");
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::function_dcb34c80("string", "text", 1);
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 2, eflags: 0x1 linked
    // Checksum 0xcf234746, Offset: 0x588
    // Size: 0x30
    function set_text(localclientnum, value) {
        set_data(localclientnum, "text", value);
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7130dad6, Offset: 0x4d0
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
        assertmsg("<dev string:x38>");
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf9ced961, Offset: 0x428
    // Size: 0x6c
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "text", #"");
    }

}

// Namespace zm_hint_text/zm_hint_text
// Params 1, eflags: 0x1 linked
// Checksum 0xf3c6c40a, Offset: 0xc8
// Size: 0x176
function register(textcallback) {
    elem = new czm_hint_text();
    [[ elem ]]->setup_clientfields(textcallback);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"zm_hint_text"])) {
        level.var_ae746e8f[#"zm_hint_text"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"zm_hint_text"])) {
        level.var_ae746e8f[#"zm_hint_text"] = [];
    } else if (!isarray(level.var_ae746e8f[#"zm_hint_text"])) {
        level.var_ae746e8f[#"zm_hint_text"] = array(level.var_ae746e8f[#"zm_hint_text"]);
    }
    level.var_ae746e8f[#"zm_hint_text"][level.var_ae746e8f[#"zm_hint_text"].size] = elem;
}

// Namespace zm_hint_text/zm_hint_text
// Params 0, eflags: 0x0
// Checksum 0x3d9fc1, Offset: 0x248
// Size: 0x34
function register_clientside() {
    elem = new czm_hint_text();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace zm_hint_text/zm_hint_text
// Params 1, eflags: 0x0
// Checksum 0x459c6d40, Offset: 0x288
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_hint_text/zm_hint_text
// Params 1, eflags: 0x0
// Checksum 0xe8c94162, Offset: 0x2b0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_hint_text/zm_hint_text
// Params 1, eflags: 0x0
// Checksum 0x816edbed, Offset: 0x2d8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_hint_text/zm_hint_text
// Params 2, eflags: 0x0
// Checksum 0xcab75ab8, Offset: 0x300
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace zm_hint_text/zm_hint_text
// Params 2, eflags: 0x0
// Checksum 0x2d981c75, Offset: 0x330
// Size: 0x28
function set_text(localclientnum, value) {
    [[ self ]]->set_text(localclientnum, value);
}

