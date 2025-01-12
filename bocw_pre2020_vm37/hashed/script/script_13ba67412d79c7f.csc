#using scripts\core_common\lui_shared;

#namespace zm_trial_timer;

// Namespace zm_trial_timer
// Method(s) 8 Total 14
class czm_trial_timer : cluielem {

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2251a5ef, Offset: 0x4c0
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe8576c16, Offset: 0x428
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("zm_trial_timer");
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 2, eflags: 0x1 linked
    // Checksum 0xfd3038d6, Offset: 0x528
    // Size: 0x30
    function set_under_round_rules(localclientnum, value) {
        set_data(localclientnum, "under_round_rules", value);
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 2, eflags: 0x1 linked
    // Checksum 0xb2601c4a, Offset: 0x4f0
    // Size: 0x30
    function set_timer_text(localclientnum, value) {
        set_data(localclientnum, "timer_text", value);
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 2, eflags: 0x1 linked
    // Checksum 0x4a500b1f, Offset: 0x3a0
    // Size: 0x7c
    function setup_clientfields(*var_96b8e5ea, var_33be6591) {
        cluielem::setup_clientfields("zm_trial_timer");
        cluielem::function_dcb34c80("string", "timer_text", 1);
        cluielem::add_clientfield("under_round_rules", 1, 1, "int", var_33be6591);
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 1, eflags: 0x1 linked
    // Checksum 0x29411ea, Offset: 0x450
    // Size: 0x68
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "timer_text", #"");
        set_data(localclientnum, "under_round_rules", 0);
    }

}

// Namespace zm_trial_timer/zm_trial_timer
// Params 2, eflags: 0x1 linked
// Checksum 0x50a6f1b5, Offset: 0xe0
// Size: 0x17e
function register(var_96b8e5ea, var_33be6591) {
    elem = new czm_trial_timer();
    [[ elem ]]->setup_clientfields(var_96b8e5ea, var_33be6591);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"zm_trial_timer"])) {
        level.var_ae746e8f[#"zm_trial_timer"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"zm_trial_timer"])) {
        level.var_ae746e8f[#"zm_trial_timer"] = [];
    } else if (!isarray(level.var_ae746e8f[#"zm_trial_timer"])) {
        level.var_ae746e8f[#"zm_trial_timer"] = array(level.var_ae746e8f[#"zm_trial_timer"]);
    }
    level.var_ae746e8f[#"zm_trial_timer"][level.var_ae746e8f[#"zm_trial_timer"].size] = elem;
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 0, eflags: 0x0
// Checksum 0x8d78176b, Offset: 0x268
// Size: 0x34
function register_clientside() {
    elem = new czm_trial_timer();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 1, eflags: 0x0
// Checksum 0x52cda098, Offset: 0x2a8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 1, eflags: 0x0
// Checksum 0xf6104570, Offset: 0x2d0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 1, eflags: 0x0
// Checksum 0xf48f4072, Offset: 0x2f8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 2, eflags: 0x0
// Checksum 0xd770ba23, Offset: 0x320
// Size: 0x28
function set_timer_text(localclientnum, value) {
    [[ self ]]->set_timer_text(localclientnum, value);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 2, eflags: 0x0
// Checksum 0x57b7c9f1, Offset: 0x350
// Size: 0x28
function set_under_round_rules(localclientnum, value) {
    [[ self ]]->set_under_round_rules(localclientnum, value);
}

