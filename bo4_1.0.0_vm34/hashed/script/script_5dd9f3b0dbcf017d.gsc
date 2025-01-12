#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_trial_weapon_locked;

// Namespace zm_trial_weapon_locked
// Method(s) 6 Total 13
class czm_trial_weapon_locked : cluielem {

    var var_57a3d576;

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 1, eflags: 0x0
    // Checksum 0xc44639b6, Offset: 0x2c0
    // Size: 0x34
    function function_74b3c310(player) {
        player clientfield::function_9d68ee55(var_57a3d576, "show_icon");
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 1, eflags: 0x0
    // Checksum 0x16367f4e, Offset: 0x290
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 2, eflags: 0x0
    // Checksum 0x93ba2f78, Offset: 0x240
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_trial_weapon_locked", persistent);
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 1, eflags: 0x0
    // Checksum 0x37d27867, Offset: 0x1e8
    // Size: 0x4c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("show_icon", 1, 1, "counter");
    }

}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0x2aa03c43, Offset: 0xc8
// Size: 0x40
function register(uid) {
    elem = new czm_trial_weapon_locked();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 2, eflags: 0x0
// Checksum 0x6d4f5bd9, Offset: 0x110
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0x29b68e5a, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0xf4cd1be7, Offset: 0x178
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0xc2650d32, Offset: 0x1a0
// Size: 0x1c
function function_74b3c310(player) {
    [[ self ]]->function_74b3c310(player);
}

