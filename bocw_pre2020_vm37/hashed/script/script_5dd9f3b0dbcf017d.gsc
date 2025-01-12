#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_trial_weapon_locked;

// Namespace zm_trial_weapon_locked
// Method(s) 6 Total 13
class czm_trial_weapon_locked : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 1, eflags: 0x0
    // Checksum 0xce1663a7, Offset: 0x2b0
    // Size: 0x3c
    function function_1e74977(player) {
        player clientfield::function_bb878fc3(var_d5213cbb, var_bf9c8c95, "show_icon");
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 2, eflags: 0x0
    // Checksum 0xa19164ba, Offset: 0x238
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 1, eflags: 0x0
    // Checksum 0x867f3d4e, Offset: 0x280
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 0, eflags: 0x0
    // Checksum 0xb44d34d9, Offset: 0x1e8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("zm_trial_weapon_locked");
        cluielem::add_clientfield("show_icon", 1, 1, "counter");
    }

}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 0, eflags: 0x0
// Checksum 0x500e17e6, Offset: 0xd0
// Size: 0x34
function register() {
    elem = new czm_trial_weapon_locked();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 2, eflags: 0x0
// Checksum 0xab93d0f6, Offset: 0x110
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0x2f3c9e91, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0x54a16eec, Offset: 0x178
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0x23bb693b, Offset: 0x1a0
// Size: 0x1c
function function_1e74977(player) {
    [[ self ]]->function_1e74977(player);
}

