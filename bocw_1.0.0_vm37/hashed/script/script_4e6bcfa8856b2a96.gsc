#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace dirtybomb_usebar;

// Namespace dirtybomb_usebar
// Method(s) 8 Total 15
class class_fbe341f : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 2, eflags: 0x0
    // Checksum 0x3c2c4695, Offset: 0x310
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 2, eflags: 0x0
    // Checksum 0x56deb84, Offset: 0x4b0
    // Size: 0x44
    function function_4aa46834(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "activatorCount", value);
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 1, eflags: 0x0
    // Checksum 0x7bd6205e, Offset: 0x358
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 0, eflags: 0x0
    // Checksum 0xc80583eb, Offset: 0x270
    // Size: 0x94
    function setup_clientfields() {
        cluielem::setup_clientfields("DirtyBomb_UseBar");
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::add_clientfield("progressFrac", 1, 10, "float");
        cluielem::add_clientfield("activatorCount", 1, 3, "int", 0);
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 2, eflags: 0x0
    // Checksum 0x290a0a40, Offset: 0x388
    // Size: 0xcc
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 0);
            return;
        }
        if (#"detonating" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 1);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 2, eflags: 0x0
    // Checksum 0xec257e07, Offset: 0x460
    // Size: 0x44
    function function_f0df5702(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "progressFrac", value);
    }

}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 0, eflags: 0x0
// Checksum 0x1f52a28, Offset: 0xf0
// Size: 0x34
function register() {
    elem = new class_fbe341f();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 2, eflags: 0x0
// Checksum 0x1ea1c28, Offset: 0x130
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 1, eflags: 0x0
// Checksum 0x2063d43a, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 1, eflags: 0x0
// Checksum 0x71e5d92b, Offset: 0x198
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 2, eflags: 0x0
// Checksum 0x3b5af2e2, Offset: 0x1c0
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 2, eflags: 0x0
// Checksum 0x8e6b78ae, Offset: 0x1f0
// Size: 0x28
function function_f0df5702(player, value) {
    [[ self ]]->function_f0df5702(player, value);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 2, eflags: 0x0
// Checksum 0x6daaf36d, Offset: 0x220
// Size: 0x28
function function_4aa46834(player, value) {
    [[ self ]]->function_4aa46834(player, value);
}

