#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_build_progress;

// Namespace zm_build_progress
// Method(s) 6 Total 13
class czm_build_progress : cluielem {

    var var_57a3d576;

    // Namespace czm_build_progress/zm_build_progress
    // Params 2, eflags: 0x0
    // Checksum 0x8139259b, Offset: 0x2c0
    // Size: 0x3c
    function set_progress(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "progress", value);
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 1, eflags: 0x0
    // Checksum 0xa834be47, Offset: 0x290
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 2, eflags: 0x0
    // Checksum 0xbd6ffc73, Offset: 0x240
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_build_progress", persistent);
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 1, eflags: 0x0
    // Checksum 0x6a3f228a, Offset: 0x1e8
    // Size: 0x4c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("progress", 1, 6, "float");
    }

}

// Namespace zm_build_progress/zm_build_progress
// Params 1, eflags: 0x0
// Checksum 0x4c2710b8, Offset: 0xc0
// Size: 0x40
function register(uid) {
    elem = new czm_build_progress();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_build_progress/zm_build_progress
// Params 2, eflags: 0x0
// Checksum 0x85bf7b39, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_build_progress/zm_build_progress
// Params 1, eflags: 0x0
// Checksum 0x5c02ac2e, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_build_progress/zm_build_progress
// Params 1, eflags: 0x0
// Checksum 0x88c0dc13, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_build_progress/zm_build_progress
// Params 2, eflags: 0x0
// Checksum 0x398854ff, Offset: 0x198
// Size: 0x28
function set_progress(player, value) {
    [[ self ]]->set_progress(player, value);
}

