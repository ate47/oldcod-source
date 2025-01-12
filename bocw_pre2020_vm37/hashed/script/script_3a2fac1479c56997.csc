#using scripts\core_common\lui_shared;

#namespace zm_build_progress;

// Namespace zm_build_progress
// Method(s) 7 Total 13
class czm_build_progress : cluielem {

    // Namespace czm_build_progress/zm_build_progress
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe9afa7e1, Offset: 0x418
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5c668d60, Offset: 0x3a0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("zm_build_progress");
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb1e0d5c1, Offset: 0x348
    // Size: 0x4c
    function setup_clientfields(progresscallback) {
        cluielem::setup_clientfields("zm_build_progress");
        cluielem::add_clientfield("progress", 1, 6, "float", progresscallback);
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa36332c6, Offset: 0x448
    // Size: 0x30
    function set_progress(localclientnum, value) {
        set_data(localclientnum, "progress", value);
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2e4692b9, Offset: 0x3c8
    // Size: 0x48
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "progress", 0);
    }

}

// Namespace zm_build_progress/zm_build_progress
// Params 1, eflags: 0x1 linked
// Checksum 0x7ae84d44, Offset: 0xc0
// Size: 0x176
function register(progresscallback) {
    elem = new czm_build_progress();
    [[ elem ]]->setup_clientfields(progresscallback);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"zm_build_progress"])) {
        level.var_ae746e8f[#"zm_build_progress"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"zm_build_progress"])) {
        level.var_ae746e8f[#"zm_build_progress"] = [];
    } else if (!isarray(level.var_ae746e8f[#"zm_build_progress"])) {
        level.var_ae746e8f[#"zm_build_progress"] = array(level.var_ae746e8f[#"zm_build_progress"]);
    }
    level.var_ae746e8f[#"zm_build_progress"][level.var_ae746e8f[#"zm_build_progress"].size] = elem;
}

// Namespace zm_build_progress/zm_build_progress
// Params 0, eflags: 0x0
// Checksum 0xc97f6457, Offset: 0x240
// Size: 0x34
function register_clientside() {
    elem = new czm_build_progress();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace zm_build_progress/zm_build_progress
// Params 1, eflags: 0x0
// Checksum 0x4d68e832, Offset: 0x280
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_build_progress/zm_build_progress
// Params 1, eflags: 0x0
// Checksum 0x81a2f072, Offset: 0x2a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_build_progress/zm_build_progress
// Params 1, eflags: 0x0
// Checksum 0x26f3c122, Offset: 0x2d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_build_progress/zm_build_progress
// Params 2, eflags: 0x0
// Checksum 0xdfe982a5, Offset: 0x2f8
// Size: 0x28
function set_progress(localclientnum, value) {
    [[ self ]]->set_progress(localclientnum, value);
}

