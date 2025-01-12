#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace interactive_shot;

// Namespace interactive_shot
// Method(s) 6 Total 13
class cinteractive_shot : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cinteractive_shot/interactive_shot
    // Params 2, eflags: 0x1 linked
    // Checksum 0x744a8a20, Offset: 0x238
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1dec8290, Offset: 0x280
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8aec6e8f, Offset: 0x1e8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("interactive_shot");
        cluielem::function_dcb34c80("string", "text", 1);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3f8972c6, Offset: 0x2b0
    // Size: 0x44
    function set_text(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "text", value);
    }

}

// Namespace interactive_shot/interactive_shot
// Params 0, eflags: 0x1 linked
// Checksum 0xe691fbdc, Offset: 0xc8
// Size: 0x34
function register() {
    elem = new cinteractive_shot();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace interactive_shot/interactive_shot
// Params 2, eflags: 0x1 linked
// Checksum 0x35a9b000, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x1 linked
// Checksum 0x8ae26129, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x1 linked
// Checksum 0x7830f9a3, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace interactive_shot/interactive_shot
// Params 2, eflags: 0x1 linked
// Checksum 0x227d385a, Offset: 0x198
// Size: 0x28
function set_text(player, value) {
    [[ self ]]->set_text(player, value);
}

