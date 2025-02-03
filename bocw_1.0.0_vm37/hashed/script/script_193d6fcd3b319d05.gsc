#using scripts\core_common\lui_shared;

#namespace sr_objective_timer;

// Namespace sr_objective_timer
// Method(s) 5 Total 12
class class_b5586f52 : cluielem {

    // Namespace namespace_b5586f52/sr_objective_timer
    // Params 2, eflags: 0x0
    // Checksum 0xdfe14f42, Offset: 0x1c8
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace namespace_b5586f52/sr_objective_timer
    // Params 1, eflags: 0x0
    // Checksum 0x7f144cef, Offset: 0x210
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_b5586f52/sr_objective_timer
    // Params 0, eflags: 0x0
    // Checksum 0x46e61ac7, Offset: 0x1a0
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_objective_timer");
    }

}

// Namespace sr_objective_timer/sr_objective_timer
// Params 0, eflags: 0x0
// Checksum 0x9a11cae6, Offset: 0xb0
// Size: 0x34
function register() {
    elem = new class_b5586f52();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace sr_objective_timer/sr_objective_timer
// Params 2, eflags: 0x0
// Checksum 0xf911a85e, Offset: 0xf0
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace sr_objective_timer/sr_objective_timer
// Params 1, eflags: 0x0
// Checksum 0x844a1387, Offset: 0x130
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_objective_timer/sr_objective_timer
// Params 1, eflags: 0x0
// Checksum 0x1b200b77, Offset: 0x158
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

