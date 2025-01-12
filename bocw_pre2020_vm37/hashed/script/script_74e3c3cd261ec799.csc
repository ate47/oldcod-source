#using scripts\core_common\lui_shared;

#namespace sr_objective_timer;

// Namespace sr_objective_timer
// Method(s) 6 Total 12
class class_b5586f52 : cluielem {

    // Namespace namespace_b5586f52/sr_objective_timer
    // Params 1, eflags: 0x1 linked
    // Checksum 0xfa8b05b4, Offset: 0x380
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_b5586f52/sr_objective_timer
    // Params 0, eflags: 0x1 linked
    // Checksum 0x96fee3b4, Offset: 0x328
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("sr_objective_timer");
    }

    // Namespace namespace_b5586f52/sr_objective_timer
    // Params 0, eflags: 0x1 linked
    // Checksum 0x90742a4, Offset: 0x300
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_objective_timer");
    }

    // Namespace namespace_b5586f52/sr_objective_timer
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd3d5e8f6, Offset: 0x350
    // Size: 0x24
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
    }

}

// Namespace sr_objective_timer/sr_objective_timer
// Params 0, eflags: 0x1 linked
// Checksum 0x6f7135b1, Offset: 0xb0
// Size: 0x16e
function register() {
    elem = new class_b5586f52();
    [[ elem ]]->setup_clientfields();
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"sr_objective_timer"])) {
        level.var_ae746e8f[#"sr_objective_timer"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"sr_objective_timer"])) {
        level.var_ae746e8f[#"sr_objective_timer"] = [];
    } else if (!isarray(level.var_ae746e8f[#"sr_objective_timer"])) {
        level.var_ae746e8f[#"sr_objective_timer"] = array(level.var_ae746e8f[#"sr_objective_timer"]);
    }
    level.var_ae746e8f[#"sr_objective_timer"][level.var_ae746e8f[#"sr_objective_timer"].size] = elem;
}

// Namespace sr_objective_timer/sr_objective_timer
// Params 0, eflags: 0x0
// Checksum 0xe41cd800, Offset: 0x228
// Size: 0x34
function register_clientside() {
    elem = new class_b5586f52();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace sr_objective_timer/sr_objective_timer
// Params 1, eflags: 0x0
// Checksum 0xf8846315, Offset: 0x268
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace sr_objective_timer/sr_objective_timer
// Params 1, eflags: 0x0
// Checksum 0x94a56ca8, Offset: 0x290
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_objective_timer/sr_objective_timer
// Params 1, eflags: 0x0
// Checksum 0xd2c7ddc1, Offset: 0x2b8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

