#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace dirtybomb_usebar;

// Namespace dirtybomb_usebar
// Method(s) 7 Total 14
class class_fbe341f : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 2, eflags: 0x0
    // Checksum 0xeda90813, Offset: 0x2a8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 1, eflags: 0x0
    // Checksum 0x98cca453, Offset: 0x2f0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 0, eflags: 0x0
    // Checksum 0x712125da, Offset: 0x230
    // Size: 0x6c
    function setup_clientfields() {
        cluielem::setup_clientfields("DirtyBomb_UseBar");
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::add_clientfield("progressFrac", 1, 10, "float");
    }

    // Namespace namespace_fbe341f/dirtybomb_usebar
    // Params 2, eflags: 0x0
    // Checksum 0x160e4c8a, Offset: 0x320
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
    // Checksum 0xc5506f01, Offset: 0x3f8
    // Size: 0x44
    function function_f0df5702(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "progressFrac", value);
    }

}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 0, eflags: 0x0
// Checksum 0xb64c80d0, Offset: 0xe0
// Size: 0x34
function register() {
    elem = new class_fbe341f();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 2, eflags: 0x0
// Checksum 0x35a9b000, Offset: 0x120
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 1, eflags: 0x0
// Checksum 0x8ae26129, Offset: 0x160
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 1, eflags: 0x0
// Checksum 0x7830f9a3, Offset: 0x188
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 2, eflags: 0x0
// Checksum 0x240086ed, Offset: 0x1b0
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace dirtybomb_usebar/dirtybomb_usebar
// Params 2, eflags: 0x0
// Checksum 0x358b8487, Offset: 0x1e0
// Size: 0x28
function function_f0df5702(player, value) {
    [[ self ]]->function_f0df5702(player, value);
}

