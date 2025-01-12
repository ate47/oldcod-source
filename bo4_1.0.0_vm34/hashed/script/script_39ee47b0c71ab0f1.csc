#using scripts\core_common\lui_shared;

#namespace zm_trial_weapon_locked;

// Namespace zm_trial_weapon_locked
// Method(s) 7 Total 13
class czm_trial_weapon_locked : cluielem {

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 1, eflags: 0x0
    // Checksum 0xc91f29e9, Offset: 0x318
    // Size: 0x6c
    function function_74b3c310(localclientnum) {
        current_val = get_data(localclientnum, "show_icon");
        new_val = (current_val + 1) % 2;
        set_data(localclientnum, "show_icon", new_val);
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 1, eflags: 0x0
    // Checksum 0x12841ac9, Offset: 0x2e0
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"zm_trial_weapon_locked");
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 1, eflags: 0x0
    // Checksum 0x2c739947, Offset: 0x298
    // Size: 0x40
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "show_icon", 0);
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 1, eflags: 0x0
    // Checksum 0xfce687de, Offset: 0x268
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 2, eflags: 0x0
    // Checksum 0x26a0da0c, Offset: 0x208
    // Size: 0x54
    function setup_clientfields(uid, var_fea97e1b) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("show_icon", 1, 1, "counter", var_fea97e1b);
    }

}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 2, eflags: 0x0
// Checksum 0x897adceb, Offset: 0xa8
// Size: 0x4c
function register(uid, var_fea97e1b) {
    elem = new czm_trial_weapon_locked();
    [[ elem ]]->setup_clientfields(uid, var_fea97e1b);
    return elem;
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0xc7f17e35, Offset: 0x100
// Size: 0x40
function register_clientside(uid) {
    elem = new czm_trial_weapon_locked();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0xda2e9446, Offset: 0x148
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0xf6f0f9cd, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0x28bf7, Offset: 0x198
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0xd953df6c, Offset: 0x1c0
// Size: 0x1c
function function_74b3c310(localclientnum) {
    [[ self ]]->function_74b3c310(localclientnum);
}

