#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_trial_timer;

// Namespace zm_trial_timer
// Method(s) 7 Total 14
class czm_trial_timer : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 2, eflags: 0x1 linked
    // Checksum 0x6dde145f, Offset: 0x2b0
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 1, eflags: 0x1 linked
    // Checksum 0xc39e9f2f, Offset: 0x2f8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 2, eflags: 0x1 linked
    // Checksum 0x235183d4, Offset: 0x378
    // Size: 0x44
    function set_under_round_rules(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "under_round_rules", value);
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 2, eflags: 0x1 linked
    // Checksum 0xbc70c76c, Offset: 0x328
    // Size: 0x44
    function set_timer_text(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "timer_text", value);
    }

    // Namespace czm_trial_timer/zm_trial_timer
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdbbbd11d, Offset: 0x238
    // Size: 0x6c
    function setup_clientfields() {
        cluielem::setup_clientfields("zm_trial_timer");
        cluielem::function_dcb34c80("string", "timer_text", 1);
        cluielem::add_clientfield("under_round_rules", 1, 1, "int");
    }

}

// Namespace zm_trial_timer/zm_trial_timer
// Params 0, eflags: 0x1 linked
// Checksum 0x3fde74d5, Offset: 0xe8
// Size: 0x34
function register() {
    elem = new czm_trial_timer();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 2, eflags: 0x1 linked
// Checksum 0x35a9b000, Offset: 0x128
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 1, eflags: 0x1 linked
// Checksum 0x8ae26129, Offset: 0x168
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 1, eflags: 0x1 linked
// Checksum 0x7830f9a3, Offset: 0x190
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 2, eflags: 0x1 linked
// Checksum 0x66702639, Offset: 0x1b8
// Size: 0x28
function set_timer_text(player, value) {
    [[ self ]]->set_timer_text(player, value);
}

// Namespace zm_trial_timer/zm_trial_timer
// Params 2, eflags: 0x1 linked
// Checksum 0xac586797, Offset: 0x1e8
// Size: 0x28
function set_under_round_rules(player, value) {
    [[ self ]]->set_under_round_rules(player, value);
}

