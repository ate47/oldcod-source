#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace revive_hud;

// Namespace revive_hud
// Method(s) 8 Total 15
class crevive_hud : cluielem {

    var var_57a3d576;

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0xb9fe0db9, Offset: 0x410
    // Size: 0x3c
    function set_fadetime(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "fadeTime", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0xfb665baa, Offset: 0x3c8
    // Size: 0x3c
    function set_clientnum(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "clientNum", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0x5ee1a157, Offset: 0x380
    // Size: 0x3c
    function set_text(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "text", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 1, eflags: 0x0
    // Checksum 0x49a6d54b, Offset: 0x350
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0x2bfd0898, Offset: 0x300
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "revive_hud", persistent);
    }

    // Namespace crevive_hud/revive_hud
    // Params 1, eflags: 0x0
    // Checksum 0xe06bfbcb, Offset: 0x258
    // Size: 0x9c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::function_52818084("string", "text", 1);
        cluielem::add_clientfield("clientNum", 1, 6, "int");
        cluielem::add_clientfield("fadeTime", 1, 5, "int");
    }

}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0x3e06fbb6, Offset: 0xd0
// Size: 0x40
function register(uid) {
    elem = new crevive_hud();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0xaa1ffec1, Offset: 0x118
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0x3565c02e, Offset: 0x158
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0xf81fe365, Offset: 0x180
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0x9c5ce7f0, Offset: 0x1a8
// Size: 0x28
function set_text(player, value) {
    [[ self ]]->set_text(player, value);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0xdbc614c6, Offset: 0x1d8
// Size: 0x28
function set_clientnum(player, value) {
    [[ self ]]->set_clientnum(player, value);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0xf0d5aab5, Offset: 0x208
// Size: 0x28
function set_fadetime(player, value) {
    [[ self ]]->set_fadetime(player, value);
}

