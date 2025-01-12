#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace wz_wingsuit_hud;

// Namespace wz_wingsuit_hud
// Method(s) 5 Total 12
class cwz_wingsuit_hud : cluielem {

    // Namespace cwz_wingsuit_hud/wz_wingsuit_hud
    // Params 1, eflags: 0x0
    // Checksum 0xc20e29c6, Offset: 0x228
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cwz_wingsuit_hud/wz_wingsuit_hud
    // Params 2, eflags: 0x0
    // Checksum 0x6402571e, Offset: 0x1d8
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "wz_wingsuit_hud", persistent);
    }

    // Namespace cwz_wingsuit_hud/wz_wingsuit_hud
    // Params 1, eflags: 0x0
    // Checksum 0xe98851fc, Offset: 0x1a8
    // Size: 0x24
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
    }

}

// Namespace wz_wingsuit_hud/wz_wingsuit_hud
// Params 1, eflags: 0x0
// Checksum 0xc18b3fa0, Offset: 0xb0
// Size: 0x40
function register(uid) {
    elem = new cwz_wingsuit_hud();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace wz_wingsuit_hud/wz_wingsuit_hud
// Params 2, eflags: 0x0
// Checksum 0xa3feac53, Offset: 0xf8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace wz_wingsuit_hud/wz_wingsuit_hud
// Params 1, eflags: 0x0
// Checksum 0x2a3e84e1, Offset: 0x138
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace wz_wingsuit_hud/wz_wingsuit_hud
// Params 1, eflags: 0x0
// Checksum 0x9e8e281d, Offset: 0x160
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

