#using scripts\core_common\lui_shared;

#namespace sr_objective_timer;

// Namespace sr_objective_timer
// Method(s) 5 Total 12
class class_b5586f52 : cluielem {

    // Namespace namespace_b5586f52/sr_objective_timer
    // Params 2, eflags: 0x1 linked
    // Checksum 0xef40e1bb, Offset: 0x1c8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_b5586f52/sr_objective_timer
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8af39177, Offset: 0x210
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_b5586f52/sr_objective_timer
    // Params 0, eflags: 0x1 linked
    // Checksum 0x71262ec8, Offset: 0x1a0
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_objective_timer");
    }

}

// Namespace sr_objective_timer/sr_objective_timer
// Params 0, eflags: 0x1 linked
// Checksum 0xdb87add2, Offset: 0xb0
// Size: 0x34
function register() {
    elem = new class_b5586f52();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace sr_objective_timer/sr_objective_timer
// Params 2, eflags: 0x1 linked
// Checksum 0x35a9b000, Offset: 0xf0
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace sr_objective_timer/sr_objective_timer
// Params 1, eflags: 0x1 linked
// Checksum 0x8ae26129, Offset: 0x130
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_objective_timer/sr_objective_timer
// Params 1, eflags: 0x1 linked
// Checksum 0x7830f9a3, Offset: 0x158
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

