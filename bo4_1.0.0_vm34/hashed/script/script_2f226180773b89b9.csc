#using scripts\core_common\lui_shared;

#namespace self_revive_visuals_rush;

// Namespace self_revive_visuals_rush
// Method(s) 7 Total 13
class cself_revive_visuals_rush : cluielem {

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 2, eflags: 0x0
    // Checksum 0xcf6136ed, Offset: 0x320
    // Size: 0x30
    function set_revive_time(localclientnum, value) {
        set_data(localclientnum, "revive_time", value);
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 1, eflags: 0x0
    // Checksum 0x92515773, Offset: 0x2e8
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"self_revive_visuals_rush");
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 1, eflags: 0x0
    // Checksum 0xe618598c, Offset: 0x2a0
    // Size: 0x40
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "revive_time", 0);
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 1, eflags: 0x0
    // Checksum 0x8f1b7281, Offset: 0x270
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 2, eflags: 0x0
    // Checksum 0xe41fc325, Offset: 0x210
    // Size: 0x54
    function setup_clientfields(uid, var_92d5f7cf) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("revive_time", 1, 4, "int", var_92d5f7cf);
    }

}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 2, eflags: 0x0
// Checksum 0x107bf9d5, Offset: 0xa8
// Size: 0x4c
function register(uid, var_92d5f7cf) {
    elem = new cself_revive_visuals_rush();
    [[ elem ]]->setup_clientfields(uid, var_92d5f7cf);
    return elem;
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 1, eflags: 0x0
// Checksum 0x17d94dcf, Offset: 0x100
// Size: 0x40
function register_clientside(uid) {
    elem = new cself_revive_visuals_rush();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 1, eflags: 0x0
// Checksum 0xdaa823fc, Offset: 0x148
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 1, eflags: 0x0
// Checksum 0xf3910c70, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 1, eflags: 0x0
// Checksum 0xcbe5878a, Offset: 0x198
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 2, eflags: 0x0
// Checksum 0x4c6cce10, Offset: 0x1c0
// Size: 0x28
function set_revive_time(localclientnum, value) {
    [[ self ]]->set_revive_time(localclientnum, value);
}

