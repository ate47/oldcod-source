#using scripts\core_common\lui_shared;

#namespace zm_trial_timer;

// Namespace zm_trial_timer
// Method(s) 7 Total 13
class czm_trial_timer : cluielem {

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 2, eflags: 0x0
    // Checksum 0xa8aeb1b, Offset: 0x330
    // Size: 0x30
    function set_timer_text(localclientnum, value) {
        set_data(localclientnum, "timer_text", value);
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 1, eflags: 0x0
    // Checksum 0xdac6c7fb, Offset: 0x2f8
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_trial_timer");
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 1, eflags: 0x0
    // Checksum 0x360e6c07, Offset: 0x2a0
    // Size: 0x4c
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "timer_text", #"");
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 1, eflags: 0x0
    // Checksum 0x4e37fc47, Offset: 0x270
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 2, eflags: 0x0
    // Checksum 0x203ab298, Offset: 0x210
    // Size: 0x54
    function setup_clientfields(uid, var_252d747f) {
        cluielem::setup_clientfields(uid);
        cluielem::function_52818084("string", "timer_text", 1);
    }

}

// Namespace zm_trial_timer/zm_trial_timer
// Params 2, eflags: 0x0
// Checksum 0x64bd40c1, Offset: 0xa8
// Size: 0x4c
function register(uid, var_252d747f) {
    elem = new czm_trial_timer();
    [[ elem ]]->setup_clientfields(uid, var_252d747f);
    return elem;
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 1, eflags: 0x0
// Checksum 0x68d32dd7, Offset: 0x100
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_trial_timer();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 1, eflags: 0x0
// Checksum 0x444bc40a, Offset: 0x148
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 1, eflags: 0x0
// Checksum 0x575f5f1a, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 1, eflags: 0x0
// Checksum 0x20396fb6, Offset: 0x198
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 2, eflags: 0x0
// Checksum 0x85d9c7f0, Offset: 0x1c0
// Size: 0x28
function set_timer_text(localclientnum, value) {
    [[ self ]]->set_timer_text(localclientnum, value);
}

