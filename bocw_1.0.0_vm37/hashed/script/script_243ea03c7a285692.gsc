#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace revive_hud;

// Namespace revive_hud
// Method(s) 8 Total 15
class crevive_hud : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0x3b5d8a42, Offset: 0x300
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0xdeb18b1, Offset: 0x418
    // Size: 0x44
    function set_fadetime(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "fadeTime", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0x5b737180, Offset: 0x3c8
    // Size: 0x44
    function set_clientnum(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "clientNum", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 1, eflags: 0x0
    // Checksum 0x1c409863, Offset: 0x348
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace crevive_hud/revive_hud
    // Params 0, eflags: 0x0
    // Checksum 0x1c79a2a, Offset: 0x260
    // Size: 0x94
    function setup_clientfields() {
        cluielem::setup_clientfields("revive_hud");
        cluielem::function_dcb34c80("string", "text", 1);
        cluielem::add_clientfield("clientNum", 1, 6, "int");
        cluielem::add_clientfield("fadeTime", 1, 5, "int");
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0xdb75d2d2, Offset: 0x378
    // Size: 0x44
    function set_text(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "text", value);
    }

}

// Namespace revive_hud/revive_hud
// Params 0, eflags: 0x0
// Checksum 0x1ad631c0, Offset: 0xe0
// Size: 0x34
function register() {
    elem = new crevive_hud();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0x1ea1c28, Offset: 0x120
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0x2063d43a, Offset: 0x160
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0x71e5d92b, Offset: 0x188
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0x3d274c55, Offset: 0x1b0
// Size: 0x28
function set_text(player, value) {
    [[ self ]]->set_text(player, value);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0xecd3759e, Offset: 0x1e0
// Size: 0x28
function set_clientnum(player, value) {
    [[ self ]]->set_clientnum(player, value);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0x9e371ef1, Offset: 0x210
// Size: 0x28
function set_fadetime(player, value) {
    [[ self ]]->set_fadetime(player, value);
}

