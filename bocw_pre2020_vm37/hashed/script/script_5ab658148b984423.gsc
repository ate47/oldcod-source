#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_build_progress;

// Namespace zm_build_progress
// Method(s) 6 Total 13
class czm_build_progress : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace czm_build_progress/zm_build_progress
    // Params 2, eflags: 0x1 linked
    // Checksum 0xef7ac1b6, Offset: 0x238
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe8bf2ec, Offset: 0x280
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 0, eflags: 0x1 linked
    // Checksum 0xecc7fe2e, Offset: 0x1e8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("zm_build_progress");
        cluielem::add_clientfield("progress", 1, 6, "float");
    }

    // Namespace czm_build_progress/zm_build_progress
    // Params 2, eflags: 0x1 linked
    // Checksum 0x34faeadb, Offset: 0x2b0
    // Size: 0x44
    function set_progress(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "progress", value);
    }

}

// Namespace zm_build_progress/zm_build_progress
// Params 0, eflags: 0x1 linked
// Checksum 0x657edb, Offset: 0xc8
// Size: 0x34
function register() {
    elem = new czm_build_progress();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace zm_build_progress/zm_build_progress
// Params 2, eflags: 0x1 linked
// Checksum 0xab93d0f6, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_build_progress/zm_build_progress
// Params 1, eflags: 0x1 linked
// Checksum 0x2f3c9e91, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_build_progress/zm_build_progress
// Params 1, eflags: 0x1 linked
// Checksum 0x54a16eec, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace zm_build_progress/zm_build_progress
// Params 2, eflags: 0x1 linked
// Checksum 0xd7c71a40, Offset: 0x198
// Size: 0x28
function set_progress(player, value) {
    [[ self ]]->set_progress(player, value);
}

