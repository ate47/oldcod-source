#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_trial_timer;

// Namespace zm_trial_timer
// Method(s) 6 Total 13
class czm_trial_timer : cluielem {

    var var_57a3d576;

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 2, eflags: 0x0
    // Checksum 0x9ba6485e, Offset: 0x2c0
    // Size: 0x3c
    function set_timer_text(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "timer_text", value);
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 1, eflags: 0x0
    // Checksum 0x75dd6d08, Offset: 0x290
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 2, eflags: 0x0
    // Checksum 0xeb01b983, Offset: 0x240
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_trial_timer", persistent);
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 1, eflags: 0x0
    // Checksum 0x488bf0f7, Offset: 0x1e8
    // Size: 0x4c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::function_52818084("string", "timer_text", 1);
    }

}

// Namespace zm_trial_timer/zm_trial_timer
// Params 1, eflags: 0x0
// Checksum 0xbfdbd6a4, Offset: 0xc0
// Size: 0x40
function register(uid) {
    elem = new czm_trial_timer();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 2, eflags: 0x0
// Checksum 0x8aaddc5a, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 1, eflags: 0x0
// Checksum 0x32a445b3, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 1, eflags: 0x0
// Checksum 0x3e543fbb, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 2, eflags: 0x0
// Checksum 0xc5eec272, Offset: 0x198
// Size: 0x28
function set_timer_text(player, value) {
    [[ self ]]->set_timer_text(player, value);
}

