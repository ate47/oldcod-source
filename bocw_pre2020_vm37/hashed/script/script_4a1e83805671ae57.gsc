#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace stim_count;

// Namespace stim_count
// Method(s) 6 Total 13
class class_44eccfcc : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_44eccfcc/stim_count
    // Params 2, eflags: 0x1 linked
    // Checksum 0x9851dbf8, Offset: 0x228
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_44eccfcc/stim_count
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb8bcb09a, Offset: 0x270
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_44eccfcc/stim_count
    // Params 2, eflags: 0x1 linked
    // Checksum 0x76d3c44a, Offset: 0x2a0
    // Size: 0x44
    function function_6eef7f4f(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "stim_count", value);
    }

    // Namespace namespace_44eccfcc/stim_count
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd3c0004b, Offset: 0x1d8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("stim_count");
        cluielem::add_clientfield("stim_count", 1, 4, "int", 0);
    }

}

// Namespace stim_count/stim_count
// Params 0, eflags: 0x0
// Checksum 0x29dbe8e8, Offset: 0xb8
// Size: 0x34
function register() {
    elem = new class_44eccfcc();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace stim_count/stim_count
// Params 2, eflags: 0x1 linked
// Checksum 0x17ff746, Offset: 0xf8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace stim_count/stim_count
// Params 1, eflags: 0x0
// Checksum 0x1870d62a, Offset: 0x138
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace stim_count/stim_count
// Params 1, eflags: 0x1 linked
// Checksum 0x4fad5457, Offset: 0x160
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace stim_count/stim_count
// Params 2, eflags: 0x1 linked
// Checksum 0x99b12a3c, Offset: 0x188
// Size: 0x28
function function_6eef7f4f(player, value) {
    [[ self ]]->function_6eef7f4f(player, value);
}

