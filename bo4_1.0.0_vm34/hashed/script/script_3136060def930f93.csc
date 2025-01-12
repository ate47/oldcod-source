#using scripts\core_common\lui_shared;

#namespace zm_towers_pap_hud;

// Namespace zm_towers_pap_hud
// Method(s) 10 Total 16
class czm_towers_pap_hud : cluielem {

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 2, eflags: 0x0
    // Checksum 0x86478c3a, Offset: 0x588
    // Size: 0x30
    function set_odin_acquired(localclientnum, value) {
        set_data(localclientnum, "odin_acquired", value);
    }

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 2, eflags: 0x0
    // Checksum 0x6dabf000, Offset: 0x550
    // Size: 0x30
    function set_zeus_acquired(localclientnum, value) {
        set_data(localclientnum, "zeus_acquired", value);
    }

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 2, eflags: 0x0
    // Checksum 0x8ae16876, Offset: 0x518
    // Size: 0x30
    function set_ra_acquired(localclientnum, value) {
        set_data(localclientnum, "ra_acquired", value);
    }

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 2, eflags: 0x0
    // Checksum 0xb3e7d76a, Offset: 0x4e0
    // Size: 0x30
    function set_danu_acquired(localclientnum, value) {
        set_data(localclientnum, "danu_acquired", value);
    }

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 1, eflags: 0x0
    // Checksum 0xe850ec9f, Offset: 0x4a8
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_towers_pap_hud");
    }

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 1, eflags: 0x0
    // Checksum 0xafd030e6, Offset: 0x408
    // Size: 0x94
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "danu_acquired", 0);
        set_data(localclientnum, "ra_acquired", 0);
        set_data(localclientnum, "zeus_acquired", 0);
        set_data(localclientnum, "odin_acquired", 0);
    }

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 1, eflags: 0x0
    // Checksum 0x30aa6452, Offset: 0x3d8
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_towers_pap_hud/zm_towers_pap_hud
    // Params 5, eflags: 0x0
    // Checksum 0x87ad2d5b, Offset: 0x2e8
    // Size: 0xe4
    function setup_clientfields(uid, var_2d85e973, var_54a997b0, var_fae757c4, var_588b07d5) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("danu_acquired", 1, 1, "int", var_2d85e973);
        cluielem::add_clientfield("ra_acquired", 1, 1, "int", var_54a997b0);
        cluielem::add_clientfield("zeus_acquired", 1, 1, "int", var_fae757c4);
        cluielem::add_clientfield("odin_acquired", 1, 1, "int", var_588b07d5);
    }

}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 5, eflags: 0x0
// Checksum 0x4493d341, Offset: 0xd0
// Size: 0x70
function register(uid, var_2d85e973, var_54a997b0, var_fae757c4, var_588b07d5) {
    elem = new czm_towers_pap_hud();
    [[ elem ]]->setup_clientfields(uid, var_2d85e973, var_54a997b0, var_fae757c4, var_588b07d5);
    return elem;
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 1, eflags: 0x0
// Checksum 0xeddc2593, Offset: 0x148
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_towers_pap_hud();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 1, eflags: 0x0
// Checksum 0x1efbfecf, Offset: 0x190
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 1, eflags: 0x0
// Checksum 0x3213f02e, Offset: 0x1b8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 1, eflags: 0x0
// Checksum 0x4dd95917, Offset: 0x1e0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 2, eflags: 0x0
// Checksum 0x30b8e75c, Offset: 0x208
// Size: 0x28
function set_danu_acquired(localclientnum, value) {
    [[ self ]]->set_danu_acquired(localclientnum, value);
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 2, eflags: 0x0
// Checksum 0x7551e8ed, Offset: 0x238
// Size: 0x28
function set_ra_acquired(localclientnum, value) {
    [[ self ]]->set_ra_acquired(localclientnum, value);
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 2, eflags: 0x0
// Checksum 0x9921d212, Offset: 0x268
// Size: 0x28
function set_zeus_acquired(localclientnum, value) {
    [[ self ]]->set_zeus_acquired(localclientnum, value);
}

// Namespace zm_towers_pap_hud/zm_towers_pap_hud
// Params 2, eflags: 0x0
// Checksum 0xd8704039, Offset: 0x298
// Size: 0x28
function set_odin_acquired(localclientnum, value) {
    [[ self ]]->set_odin_acquired(localclientnum, value);
}

