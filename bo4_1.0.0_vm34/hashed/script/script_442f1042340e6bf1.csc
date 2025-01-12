#using scripts\core_common\lui_shared;

#namespace zm_zod_wonderweapon_quest;

// Namespace zm_zod_wonderweapon_quest
// Method(s) 10 Total 16
class czm_zod_wonderweapon_quest : cluielem {

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 2, eflags: 0x0
    // Checksum 0x3a7608e2, Offset: 0x570
    // Size: 0x30
    function set_decay(localclientnum, value) {
        set_data(localclientnum, "decay", value);
    }

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 2, eflags: 0x0
    // Checksum 0xd15aec4d, Offset: 0x538
    // Size: 0x30
    function set_purity(localclientnum, value) {
        set_data(localclientnum, "purity", value);
    }

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 2, eflags: 0x0
    // Checksum 0x1deded7, Offset: 0x500
    // Size: 0x30
    function set_plasma(localclientnum, value) {
        set_data(localclientnum, "plasma", value);
    }

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 2, eflags: 0x0
    // Checksum 0x9b7d342b, Offset: 0x4c8
    // Size: 0x30
    function set_radiance(localclientnum, value) {
        set_data(localclientnum, "radiance", value);
    }

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 1, eflags: 0x0
    // Checksum 0x4fa1df, Offset: 0x490
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_zod_wonderweapon_quest");
    }

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 1, eflags: 0x0
    // Checksum 0xe17feedb, Offset: 0x3f0
    // Size: 0x94
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "radiance", 0);
        set_data(localclientnum, "plasma", 0);
        set_data(localclientnum, "purity", 0);
        set_data(localclientnum, "decay", 0);
    }

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 1, eflags: 0x0
    // Checksum 0x22c2ab5f, Offset: 0x3c0
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
    // Params 5, eflags: 0x0
    // Checksum 0xfe6c6605, Offset: 0x2d0
    // Size: 0xe4
    function setup_clientfields(uid, var_6e57dcc7, var_c783da62, var_87c1afe3, var_8517a7c0) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("radiance", 1, 1, "int", var_6e57dcc7);
        cluielem::add_clientfield("plasma", 1, 1, "int", var_c783da62);
        cluielem::add_clientfield("purity", 1, 1, "int", var_87c1afe3);
        cluielem::add_clientfield("decay", 1, 1, "int", var_8517a7c0);
    }

}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 5, eflags: 0x0
// Checksum 0x8588a3c5, Offset: 0xb8
// Size: 0x70
function register(uid, var_6e57dcc7, var_c783da62, var_87c1afe3, var_8517a7c0) {
    elem = new czm_zod_wonderweapon_quest();
    [[ elem ]]->setup_clientfields(uid, var_6e57dcc7, var_c783da62, var_87c1afe3, var_8517a7c0);
    return elem;
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 1, eflags: 0x0
// Checksum 0x829a581a, Offset: 0x130
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_zod_wonderweapon_quest();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 1, eflags: 0x0
// Checksum 0xd240528, Offset: 0x178
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 1, eflags: 0x0
// Checksum 0x477bcb7a, Offset: 0x1a0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 1, eflags: 0x0
// Checksum 0x4371f73b, Offset: 0x1c8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 2, eflags: 0x0
// Checksum 0x955de364, Offset: 0x1f0
// Size: 0x28
function set_radiance(localclientnum, value) {
    [[ self ]]->set_radiance(localclientnum, value);
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 2, eflags: 0x0
// Checksum 0xd23a9083, Offset: 0x220
// Size: 0x28
function set_plasma(localclientnum, value) {
    [[ self ]]->set_plasma(localclientnum, value);
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 2, eflags: 0x0
// Checksum 0xe431fdff, Offset: 0x250
// Size: 0x28
function set_purity(localclientnum, value) {
    [[ self ]]->set_purity(localclientnum, value);
}

// Namespace zm_zod_wonderweapon_quest/zm_zod_wonderweapon_quest
// Params 2, eflags: 0x0
// Checksum 0x45fb354f, Offset: 0x280
// Size: 0x28
function set_decay(localclientnum, value) {
    [[ self ]]->set_decay(localclientnum, value);
}

