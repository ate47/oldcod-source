#using scripts\core_common\lui_shared;

#namespace self_revive_visuals_rush;

// Namespace self_revive_visuals_rush
// Method(s) 7 Total 13
class cself_revive_visuals_rush : cluielem {

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 1, eflags: 0x0
    // Checksum 0x3cdada5c, Offset: 0x418
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 0, eflags: 0x0
    // Checksum 0x5c668d60, Offset: 0x3a8
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("self_revive_visuals_rush");
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 1, eflags: 0x0
    // Checksum 0x2e017eaf, Offset: 0x350
    // Size: 0x4c
    function setup_clientfields(var_2e62cab3) {
        cluielem::setup_clientfields("self_revive_visuals_rush");
        cluielem::add_clientfield("revive_time", 1, 4, "int", var_2e62cab3);
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 2, eflags: 0x0
    // Checksum 0x9d61264a, Offset: 0x448
    // Size: 0x30
    function set_revive_time(localclientnum, value) {
        set_data(localclientnum, "revive_time", value);
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 1, eflags: 0x0
    // Checksum 0x7858e4f7, Offset: 0x3d0
    // Size: 0x40
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "revive_time", 0);
    }

}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 1, eflags: 0x0
// Checksum 0x704c49fb, Offset: 0xc8
// Size: 0x176
function register(var_2e62cab3) {
    elem = new cself_revive_visuals_rush();
    [[ elem ]]->setup_clientfields(var_2e62cab3);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"self_revive_visuals_rush"])) {
        level.var_ae746e8f[#"self_revive_visuals_rush"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"self_revive_visuals_rush"])) {
        level.var_ae746e8f[#"self_revive_visuals_rush"] = [];
    } else if (!isarray(level.var_ae746e8f[#"self_revive_visuals_rush"])) {
        level.var_ae746e8f[#"self_revive_visuals_rush"] = array(level.var_ae746e8f[#"self_revive_visuals_rush"]);
    }
    level.var_ae746e8f[#"self_revive_visuals_rush"][level.var_ae746e8f[#"self_revive_visuals_rush"].size] = elem;
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 0, eflags: 0x0
// Checksum 0xd7934ae3, Offset: 0x248
// Size: 0x34
function register_clientside() {
    elem = new cself_revive_visuals_rush();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 1, eflags: 0x0
// Checksum 0x4d68e832, Offset: 0x288
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 1, eflags: 0x0
// Checksum 0x81a2f072, Offset: 0x2b0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 1, eflags: 0x0
// Checksum 0x26f3c122, Offset: 0x2d8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 2, eflags: 0x0
// Checksum 0xce27c8c5, Offset: 0x300
// Size: 0x28
function set_revive_time(localclientnum, value) {
    [[ self ]]->set_revive_time(localclientnum, value);
}

