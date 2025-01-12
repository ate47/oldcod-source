#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace self_revive_visuals;

// Namespace self_revive_visuals
// Method(s) 7 Total 14
class cself_revive_visuals : cluielem {

    var var_57a3d576;

    // Namespace cself_revive_visuals/self_revive_visuals
    // Params 2, eflags: 0x0
    // Checksum 0x9143e1d7, Offset: 0x388
    // Size: 0x3c
    function set_revive_progress(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "revive_progress", value);
    }

    // Namespace cself_revive_visuals/self_revive_visuals
    // Params 2, eflags: 0x0
    // Checksum 0x602aee1a, Offset: 0x340
    // Size: 0x3c
    function set_self_revive_progress_bar_fill(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "self_revive_progress_bar_fill", value);
    }

    // Namespace cself_revive_visuals/self_revive_visuals
    // Params 1, eflags: 0x0
    // Checksum 0xf293ad28, Offset: 0x310
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cself_revive_visuals/self_revive_visuals
    // Params 2, eflags: 0x0
    // Checksum 0x170aa43f, Offset: 0x2c0
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "self_revive_visuals", persistent);
    }

    // Namespace cself_revive_visuals/self_revive_visuals
    // Params 1, eflags: 0x0
    // Checksum 0xfe384183, Offset: 0x240
    // Size: 0x74
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("self_revive_progress_bar_fill", 1, 5, "float");
        cluielem::add_clientfield("revive_progress", 1, 5, "float");
    }

}

// Namespace self_revive_visuals/self_revive_visuals
// Params 1, eflags: 0x0
// Checksum 0x61ad307, Offset: 0xe8
// Size: 0x40
function register(uid) {
    elem = new cself_revive_visuals();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace self_revive_visuals/self_revive_visuals
// Params 2, eflags: 0x0
// Checksum 0x40fd09d3, Offset: 0x130
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace self_revive_visuals/self_revive_visuals
// Params 1, eflags: 0x0
// Checksum 0x42f88e16, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace self_revive_visuals/self_revive_visuals
// Params 1, eflags: 0x0
// Checksum 0xa8b10a9d, Offset: 0x198
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace self_revive_visuals/self_revive_visuals
// Params 2, eflags: 0x0
// Checksum 0x57c71169, Offset: 0x1c0
// Size: 0x28
function set_self_revive_progress_bar_fill(player, value) {
    [[ self ]]->set_self_revive_progress_bar_fill(player, value);
}

// Namespace self_revive_visuals/self_revive_visuals
// Params 2, eflags: 0x0
// Checksum 0x6f485044, Offset: 0x1f0
// Size: 0x28
function set_revive_progress(player, value) {
    [[ self ]]->set_revive_progress(player, value);
}

