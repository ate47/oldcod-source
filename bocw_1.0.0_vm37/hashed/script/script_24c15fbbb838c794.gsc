#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace interactive_shot;

// Namespace interactive_shot
// Method(s) 6 Total 13
class cinteractive_shot : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cinteractive_shot/interactive_shot
    // Params 2, eflags: 0x0
    // Checksum 0xe160a06f, Offset: 0x238
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 1, eflags: 0x0
    // Checksum 0x5b19a588, Offset: 0x280
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 0, eflags: 0x0
    // Checksum 0xea1034d4, Offset: 0x1e8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("interactive_shot");
        cluielem::function_dcb34c80("string", "text", 1);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 2, eflags: 0x0
    // Checksum 0x93beb1f6, Offset: 0x2b0
    // Size: 0x44
    function set_text(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "text", value);
    }

}

// Namespace interactive_shot/interactive_shot
// Params 0, eflags: 0x0
// Checksum 0xa7079ce8, Offset: 0xc8
// Size: 0x34
function register() {
    elem = new cinteractive_shot();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace interactive_shot/interactive_shot
// Params 2, eflags: 0x0
// Checksum 0xf911a85e, Offset: 0x108
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0x844a1387, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0x1b200b77, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace interactive_shot/interactive_shot
// Params 2, eflags: 0x0
// Checksum 0xa5b30afd, Offset: 0x198
// Size: 0x28
function set_text(player, value) {
    [[ self ]]->set_text(player, value);
}

