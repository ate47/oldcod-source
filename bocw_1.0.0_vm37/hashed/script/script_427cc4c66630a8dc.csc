#using scripts\core_common\lui_shared;

#namespace prototype_self_revive;

// Namespace prototype_self_revive
// Method(s) 6 Total 13
class cprototype_self_revive : cluielem {

    // Namespace cprototype_self_revive/prototype_self_revive
    // Params 1, eflags: 0x0
    // Checksum 0x98b6ccf7, Offset: 0x380
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cprototype_self_revive/prototype_self_revive
    // Params 0, eflags: 0x0
    // Checksum 0x7d5fa3a8, Offset: 0x328
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("prototype_self_revive");
    }

    // Namespace cprototype_self_revive/prototype_self_revive
    // Params 0, eflags: 0x0
    // Checksum 0x5cf0a36b, Offset: 0x300
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("prototype_self_revive");
    }

    // Namespace cprototype_self_revive/prototype_self_revive
    // Params 1, eflags: 0x0
    // Checksum 0xb1a1fd52, Offset: 0x350
    // Size: 0x24
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
    }

}

// Namespace prototype_self_revive/prototype_self_revive
// Params 0, eflags: 0x0
// Checksum 0xd0b618e, Offset: 0xb0
// Size: 0x16e
function register() {
    elem = new cprototype_self_revive();
    [[ elem ]]->setup_clientfields();
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"prototype_self_revive"])) {
        level.var_ae746e8f[#"prototype_self_revive"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"prototype_self_revive"])) {
        level.var_ae746e8f[#"prototype_self_revive"] = [];
    } else if (!isarray(level.var_ae746e8f[#"prototype_self_revive"])) {
        level.var_ae746e8f[#"prototype_self_revive"] = array(level.var_ae746e8f[#"prototype_self_revive"]);
    }
    level.var_ae746e8f[#"prototype_self_revive"][level.var_ae746e8f[#"prototype_self_revive"].size] = elem;
}

// Namespace prototype_self_revive/prototype_self_revive
// Params 0, eflags: 0x0
// Checksum 0x167e7f49, Offset: 0x228
// Size: 0x34
function register_clientside() {
    elem = new cprototype_self_revive();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace prototype_self_revive/prototype_self_revive
// Params 1, eflags: 0x0
// Checksum 0x777c6672, Offset: 0x268
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace prototype_self_revive/prototype_self_revive
// Params 1, eflags: 0x0
// Checksum 0x4cd2d802, Offset: 0x290
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace prototype_self_revive/prototype_self_revive
// Params 1, eflags: 0x0
// Checksum 0x93f4aef9, Offset: 0x2b8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

