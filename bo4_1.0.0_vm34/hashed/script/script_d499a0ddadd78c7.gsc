#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_towers_pap_hud;

// Namespace zm_towers_pap_hud
// Method(s) 9 Total 16
class czm_towers_pap_hud : cluielem {

    var var_57a3d576;

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 2, eflags: 0x0
    // Checksum 0x5dedcc7f, Offset: 0x4c8
    // Size: 0x3c
    function set_odin_acquired(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "odin_acquired", value);
    }

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 2, eflags: 0x0
    // Checksum 0xd5d323dc, Offset: 0x480
    // Size: 0x3c
    function set_zeus_acquired(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "zeus_acquired", value);
    }

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 2, eflags: 0x0
    // Checksum 0x97c09d3, Offset: 0x438
    // Size: 0x3c
    function set_ra_acquired(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "ra_acquired", value);
    }

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 2, eflags: 0x0
    // Checksum 0x398885c6, Offset: 0x3f0
    // Size: 0x3c
    function set_danu_acquired(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "danu_acquired", value);
    }

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 1, eflags: 0x0
    // Checksum 0xc4eea994, Offset: 0x3c0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 2, eflags: 0x0
    // Checksum 0xcb903b36, Offset: 0x370
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_towers_pap_hud", persistent);
    }

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 1, eflags: 0x0
    // Checksum 0xc29d951a, Offset: 0x2a0
    // Size: 0xc4
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("danu_acquired", 1, 1, "int");
        cluielem::add_clientfield("ra_acquired", 1, 1, "int");
        cluielem::add_clientfield("zeus_acquired", 1, 1, "int");
        cluielem::add_clientfield("odin_acquired", 1, 1, "int");
    }

}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 1, eflags: 0x0
// Checksum 0x5899dc99, Offset: 0xe8
// Size: 0x40
function register(uid) {
    elem = new czm_towers_pap_hud();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 2, eflags: 0x0
// Checksum 0x534ae52e, Offset: 0x130
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 1, eflags: 0x0
// Checksum 0x6cb8f5bf, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 1, eflags: 0x0
// Checksum 0x4cd8ae6d, Offset: 0x198
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 2, eflags: 0x0
// Checksum 0x1d12a27b, Offset: 0x1c0
// Size: 0x28
function set_danu_acquired(player, value) {
    [[ self ]]->set_danu_acquired(player, value);
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 2, eflags: 0x0
// Checksum 0xe4182616, Offset: 0x1f0
// Size: 0x28
function set_ra_acquired(player, value) {
    [[ self ]]->set_ra_acquired(player, value);
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 2, eflags: 0x0
// Checksum 0xc67c44a4, Offset: 0x220
// Size: 0x28
function set_zeus_acquired(player, value) {
    [[ self ]]->set_zeus_acquired(player, value);
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 2, eflags: 0x0
// Checksum 0x19e3453f, Offset: 0x250
// Size: 0x28
function set_odin_acquired(player, value) {
    [[ self ]]->set_odin_acquired(player, value);
}

