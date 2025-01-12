#using scripts\core_common\lui_shared;

#namespace zm_trial_weapon_locked;

// Namespace zm_trial_weapon_locked
// Method(s) 7 Total 13
class czm_trial_weapon_locked : cluielem {

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7f23111f, Offset: 0x440
    // Size: 0x6c
    function function_1e74977(localclientnum) {
        current_val = get_data(localclientnum, "show_icon");
        new_val = (current_val + 1) % 2;
        set_data(localclientnum, "show_icon", new_val);
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 1, eflags: 0x1 linked
    // Checksum 0xc15306a9, Offset: 0x410
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa0298be5, Offset: 0x3a0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("zm_trial_weapon_locked");
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3ece344c, Offset: 0x348
    // Size: 0x4c
    function setup_clientfields(var_18c795d0) {
        cluielem::setup_clientfields("zm_trial_weapon_locked");
        cluielem::add_clientfield("show_icon", 1, 1, "counter", var_18c795d0);
    }

    // Namespace czm_trial_weapon_locked/zm_trial_weapon_locked
    // Params 1, eflags: 0x1 linked
    // Checksum 0x391c97ea, Offset: 0x3c8
    // Size: 0x40
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "show_icon", 0);
    }

}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0x45d55d0d, Offset: 0xc8
// Size: 0x176
function register(var_18c795d0) {
    elem = new czm_trial_weapon_locked();
    [[ elem ]]->setup_clientfields(var_18c795d0);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"zm_trial_weapon_locked"])) {
        level.var_ae746e8f[#"zm_trial_weapon_locked"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"zm_trial_weapon_locked"])) {
        level.var_ae746e8f[#"zm_trial_weapon_locked"] = [];
    } else if (!isarray(level.var_ae746e8f[#"zm_trial_weapon_locked"])) {
        level.var_ae746e8f[#"zm_trial_weapon_locked"] = array(level.var_ae746e8f[#"zm_trial_weapon_locked"]);
    }
    level.var_ae746e8f[#"zm_trial_weapon_locked"][level.var_ae746e8f[#"zm_trial_weapon_locked"].size] = elem;
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 0, eflags: 0x1 linked
// Checksum 0x99140d6a, Offset: 0x248
// Size: 0x34
function register_clientside() {
    elem = new czm_trial_weapon_locked();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x1 linked
// Checksum 0x4d68e832, Offset: 0x288
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x0
// Checksum 0x81a2f072, Offset: 0x2b0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x1 linked
// Checksum 0x26f3c122, Offset: 0x2d8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace zm_trial_weapon_locked/zm_trial_weapon_locked
// Params 1, eflags: 0x1 linked
// Checksum 0xb82abfd4, Offset: 0x300
// Size: 0x1c
function function_1e74977(localclientnum) {
    [[ self ]]->function_1e74977(localclientnum);
}

