#using scripts\core_common\lui_shared;

#namespace zm_build_progress;

// Namespace zm_build_progress
// Method(s) 7 Total 13
class czm_build_progress : cluielem {

    // Namespace czm_build_progress/zm_build_progress
    // Params 2, eflags: 0x0
    // Checksum 0x37980f4d, Offset: 0x328
    // Size: 0x30
    function set_progress(localclientnum, value) {
        set_data(localclientnum, "progress", value);
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 1, eflags: 0x0
    // Checksum 0x9c612ee3, Offset: 0x2f0
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_build_progress");
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 1, eflags: 0x0
    // Checksum 0xd63eb5e9, Offset: 0x2a0
    // Size: 0x48
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "progress", 0);
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 1, eflags: 0x0
    // Checksum 0x33c2725b, Offset: 0x270
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 2, eflags: 0x0
    // Checksum 0x8f145acb, Offset: 0x210
    // Size: 0x54
    function setup_clientfields(uid, progresscallback) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("progress", 1, 6, "float", progresscallback);
    }

}

// Namespace zm_build_progress/zm_build_progress
// Params 2, eflags: 0x0
// Checksum 0xa26b35e1, Offset: 0xa8
// Size: 0x4c
function register(uid, progresscallback) {
    elem = new czm_build_progress();
    [[ elem ]]->setup_clientfields(uid, progresscallback);
    return elem;
}

// Namespace zm_build_progress/zm_build_progress
// Params 1, eflags: 0x0
// Checksum 0x9d33d645, Offset: 0x100
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_build_progress();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_build_progress/zm_build_progress
// Params 1, eflags: 0x0
// Checksum 0xb298a483, Offset: 0x148
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_build_progress/zm_build_progress
// Params 1, eflags: 0x0
// Checksum 0xb2610636, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_build_progress/zm_build_progress
// Params 1, eflags: 0x0
// Checksum 0x266e64b7, Offset: 0x198
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_build_progress/zm_build_progress
// Params 2, eflags: 0x0
// Checksum 0xafa4a16d, Offset: 0x1c0
// Size: 0x28
function set_progress(localclientnum, value) {
    [[ self ]]->set_progress(localclientnum, value);
}

