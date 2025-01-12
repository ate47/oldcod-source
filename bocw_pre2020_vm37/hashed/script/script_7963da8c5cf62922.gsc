#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace sr_message_box;

// Namespace sr_message_box
// Method(s) 6 Total 13
class class_51e5626e : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_51e5626e/sr_message_box
    // Params 2, eflags: 0x1 linked
    // Checksum 0x9f97df77, Offset: 0x238
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_51e5626e/sr_message_box
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf982f2f5, Offset: 0x280
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_51e5626e/sr_message_box
    // Params 2, eflags: 0x1 linked
    // Checksum 0x190a9c9e, Offset: 0x2b0
    // Size: 0x44
    function function_7a690474(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "messagebox", value);
    }

    // Namespace namespace_51e5626e/sr_message_box
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9db0d004, Offset: 0x1e8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_message_box");
        cluielem::function_dcb34c80("string", "messagebox", 1);
    }

}

// Namespace sr_message_box/sr_message_box
// Params 0, eflags: 0x1 linked
// Checksum 0xee1bae7d, Offset: 0xc8
// Size: 0x34
function register() {
    elem = new class_51e5626e();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace sr_message_box/sr_message_box
// Params 2, eflags: 0x1 linked
// Checksum 0xab93d0f6, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace sr_message_box/sr_message_box
// Params 1, eflags: 0x1 linked
// Checksum 0x2f3c9e91, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_message_box/sr_message_box
// Params 1, eflags: 0x1 linked
// Checksum 0x54a16eec, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace sr_message_box/sr_message_box
// Params 2, eflags: 0x1 linked
// Checksum 0x28fb4dd5, Offset: 0x198
// Size: 0x28
function function_7a690474(player, value) {
    [[ self ]]->function_7a690474(player, value);
}

