#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace sr_message_box;

// Namespace sr_message_box
// Method(s) 6 Total 13
class class_51e5626e : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_51e5626e/sr_message_box
    // Params 2, eflags: 0x0
    // Checksum 0xabdf538, Offset: 0x238
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace namespace_51e5626e/sr_message_box
    // Params 1, eflags: 0x0
    // Checksum 0xbf77d5ed, Offset: 0x280
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_51e5626e/sr_message_box
    // Params 2, eflags: 0x0
    // Checksum 0xb53d5fae, Offset: 0x2b0
    // Size: 0x44
    function function_7a690474(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "messagebox", value);
    }

    // Namespace namespace_51e5626e/sr_message_box
    // Params 0, eflags: 0x0
    // Checksum 0xfd4c8a5f, Offset: 0x1e8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_message_box");
        cluielem::function_dcb34c80("string", "messagebox", 1);
    }

}

// Namespace sr_message_box/sr_message_box
// Params 0, eflags: 0x0
// Checksum 0xaf8dc949, Offset: 0xc8
// Size: 0x34
function register() {
    elem = new class_51e5626e();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace sr_message_box/sr_message_box
// Params 2, eflags: 0x0
// Checksum 0x672bc8a8, Offset: 0x108
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace sr_message_box/sr_message_box
// Params 1, eflags: 0x0
// Checksum 0x2194ec3f, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_message_box/sr_message_box
// Params 1, eflags: 0x0
// Checksum 0x37b19c38, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace sr_message_box/sr_message_box
// Params 2, eflags: 0x0
// Checksum 0xaf357f72, Offset: 0x198
// Size: 0x28
function function_7a690474(player, value) {
    [[ self ]]->function_7a690474(player, value);
}

