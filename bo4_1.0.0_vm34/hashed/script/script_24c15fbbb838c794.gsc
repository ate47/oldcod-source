#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace interactive_shot;

// Namespace interactive_shot
// Method(s) 6 Total 13
class cinteractive_shot : cluielem {

    var var_57a3d576;

    // Namespace cinteractive_shot/interactive_shot
    // Params 2, eflags: 0x0
    // Checksum 0x4ccc84cc, Offset: 0x2c0
    // Size: 0x3c
    function set_text(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "text", value);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 1, eflags: 0x0
    // Checksum 0x69864947, Offset: 0x290
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 2, eflags: 0x0
    // Checksum 0x384a1bb0, Offset: 0x240
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "interactive_shot", persistent);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 1, eflags: 0x0
    // Checksum 0x359a059e, Offset: 0x1e8
    // Size: 0x4c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::function_52818084("string", "text", 1);
    }

}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0x39d64efa, Offset: 0xc0
// Size: 0x40
function register(uid) {
    elem = new cinteractive_shot();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace interactive_shot/interactive_shot
// Params 2, eflags: 0x0
// Checksum 0xed4c7a7e, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0x1b8865ae, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0x6386f5b7, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace interactive_shot/interactive_shot
// Params 2, eflags: 0x0
// Checksum 0xc2d7aeb7, Offset: 0x198
// Size: 0x28
function set_text(player, value) {
    [[ self ]]->set_text(player, value);
}

