#using scripts\core_common\lui_shared;

#namespace self_revive_visuals;

// Namespace self_revive_visuals
// Method(s) 8 Total 14
class cself_revive_visuals : cluielem {

    // Namespace cself_revive_visuals/self_revive_visuals
    // Params 2, eflags: 0x0
    // Checksum 0xfd0bff52, Offset: 0x410
    // Size: 0x30
    function set_revive_progress(localclientnum, value) {
        set_data(localclientnum, "revive_progress", value);
    }

    // Namespace cself_revive_visuals/self_revive_visuals
    // Params 2, eflags: 0x0
    // Checksum 0xf960f6fd, Offset: 0x3d8
    // Size: 0x30
    function set_self_revive_progress_bar_fill(localclientnum, value) {
        set_data(localclientnum, "self_revive_progress_bar_fill", value);
    }

    // Namespace cself_revive_visuals/self_revive_visuals
    // Params 1, eflags: 0x0
    // Checksum 0x8b12b3a7, Offset: 0x3a0
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"self_revive_visuals");
    }

    // Namespace cself_revive_visuals/self_revive_visuals
    // Params 1, eflags: 0x0
    // Checksum 0xbdbd1aef, Offset: 0x328
    // Size: 0x6c
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "self_revive_progress_bar_fill", 0);
        set_data(localclientnum, "revive_progress", 0);
    }

    // Namespace cself_revive_visuals/self_revive_visuals
    // Params 1, eflags: 0x0
    // Checksum 0x5f69f889, Offset: 0x2f8
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cself_revive_visuals/self_revive_visuals
    // Params 3, eflags: 0x0
    // Checksum 0xa4e09516, Offset: 0x268
    // Size: 0x84
    function setup_clientfields(uid, var_2d1c5d08, var_f45e8d0d) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("self_revive_progress_bar_fill", 1, 5, "float", var_2d1c5d08);
        cluielem::add_clientfield("revive_progress", 1, 5, "float", var_f45e8d0d);
    }

}

// Namespace self_revive_visuals/self_revive_visuals
// Params 3, eflags: 0x0
// Checksum 0x4f0dae0e, Offset: 0xc8
// Size: 0x58
function register(uid, var_2d1c5d08, var_f45e8d0d) {
    elem = new cself_revive_visuals();
    [[ elem ]]->setup_clientfields(uid, var_2d1c5d08, var_f45e8d0d);
    return elem;
}

// Namespace self_revive_visuals/self_revive_visuals
// Params 1, eflags: 0x0
// Checksum 0xb625e731, Offset: 0x128
// Size: 0x40
function register_clientside(uid) {
    elem = new cself_revive_visuals();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace self_revive_visuals/self_revive_visuals
// Params 1, eflags: 0x0
// Checksum 0x63a53721, Offset: 0x170
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace self_revive_visuals/self_revive_visuals
// Params 1, eflags: 0x0
// Checksum 0x9b573fa3, Offset: 0x198
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace self_revive_visuals/self_revive_visuals
// Params 1, eflags: 0x0
// Checksum 0x471d510, Offset: 0x1c0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace self_revive_visuals/self_revive_visuals
// Params 2, eflags: 0x0
// Checksum 0x5123f569, Offset: 0x1e8
// Size: 0x28
function set_self_revive_progress_bar_fill(localclientnum, value) {
    [[ self ]]->set_self_revive_progress_bar_fill(localclientnum, value);
}

// Namespace self_revive_visuals/self_revive_visuals
// Params 2, eflags: 0x0
// Checksum 0x21c6ab21, Offset: 0x218
// Size: 0x28
function set_revive_progress(localclientnum, value) {
    [[ self ]]->set_revive_progress(localclientnum, value);
}

