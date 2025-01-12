#using scripts\core_common\lui_shared;

#namespace wz_wingsuit_hud;

// Namespace wz_wingsuit_hud
// Method(s) 6 Total 12
class cwz_wingsuit_hud : cluielem {

    // Namespace cwz_wingsuit_hud/wz_wingsuit_hud
    // Params 1, eflags: 0x0
    // Checksum 0x5ff9f4fe, Offset: 0x250
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"wz_wingsuit_hud");
    }

    // Namespace cwz_wingsuit_hud/wz_wingsuit_hud
    // Params 1, eflags: 0x0
    // Checksum 0x558bebe6, Offset: 0x220
    // Size: 0x24
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
    }

    // Namespace cwz_wingsuit_hud/wz_wingsuit_hud
    // Params 1, eflags: 0x0
    // Checksum 0x73eef645, Offset: 0x1f0
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cwz_wingsuit_hud/wz_wingsuit_hud
    // Params 1, eflags: 0x0
    // Checksum 0x4d0ec5ba, Offset: 0x1c0
    // Size: 0x24
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
    }

}

// Namespace wz_wingsuit_hud/wz_wingsuit_hud
// Params 1, eflags: 0x0
// Checksum 0x26dc1e0f, Offset: 0x98
// Size: 0x40
function register(uid) {
    elem = new cwz_wingsuit_hud();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace wz_wingsuit_hud/wz_wingsuit_hud
// Params 1, eflags: 0x0
// Checksum 0x469470c3, Offset: 0xe0
// Size: 0x40
function register_clientside(uid) {
    elem = new cwz_wingsuit_hud();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace wz_wingsuit_hud/wz_wingsuit_hud
// Params 1, eflags: 0x0
// Checksum 0x14a30466, Offset: 0x128
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace wz_wingsuit_hud/wz_wingsuit_hud
// Params 1, eflags: 0x0
// Checksum 0xf1dec3f4, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace wz_wingsuit_hud/wz_wingsuit_hud
// Params 1, eflags: 0x0
// Checksum 0x5ca9c6b7, Offset: 0x178
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

