#using scripts\core_common\lui_shared;

#namespace sr_objective_reward_menu;

// Namespace sr_objective_reward_menu
// Method(s) 12 Total 19
class class_51a06b68 : cluielem {

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 1, eflags: 0x0
    // Checksum 0x1a2863ab, Offset: 0x6f8
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x580c09b6, Offset: 0x8c0
    // Size: 0x30
    function function_2d7f3298(localclientnum, value) {
        set_data(localclientnum, "gunindex2", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x2a343beb, Offset: 0x888
    // Size: 0x30
    function function_43ba5f0e(localclientnum, value) {
        set_data(localclientnum, "gunIndex1", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 0, eflags: 0x0
    // Checksum 0xba0dcedc, Offset: 0x5f0
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("sr_objective_reward_menu");
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 5, eflags: 0x0
    // Checksum 0x54b289c7, Offset: 0x4b0
    // Size: 0x134
    function setup_clientfields(var_e4dedc0e, var_c8914fcf, var_2f1b82f5, var_bf555938, var_18d66c99) {
        cluielem::setup_clientfields("sr_objective_reward_menu");
        cluielem::add_clientfield("_state", 1, 2, "int");
        cluielem::add_clientfield("promptProgress", 1, 7, "float", var_e4dedc0e);
        cluielem::add_clientfield("gunIndex1", 1, 4, "int", var_c8914fcf);
        cluielem::add_clientfield("gunindex2", 1, 4, "int", var_2f1b82f5);
        cluielem::add_clientfield("gunindex3", 1, 4, "int", var_bf555938);
        cluielem::add_clientfield("color", 1, 2, "int", var_18d66c99);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x6b7fb2b2, Offset: 0x930
    // Size: 0x30
    function set_color(localclientnum, value) {
        set_data(localclientnum, "color", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x6d5a4631, Offset: 0x8f8
    // Size: 0x30
    function function_ada8b2f1(localclientnum, value) {
        set_data(localclientnum, "gunindex3", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x4f630b82, Offset: 0x850
    // Size: 0x30
    function function_b94196b8(localclientnum, value) {
        set_data(localclientnum, "promptProgress", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x748646cc, Offset: 0x728
    // Size: 0x11c
    function set_state(localclientnum, state_name) {
        if (#"defaultstate" == state_name) {
            set_data(localclientnum, "_state", 0);
            return;
        }
        if (#"gun1selected" == state_name) {
            set_data(localclientnum, "_state", 1);
            return;
        }
        if (#"gun2selected" == state_name) {
            set_data(localclientnum, "_state", 2);
            return;
        }
        if (#"gun3selected" == state_name) {
            set_data(localclientnum, "_state", 3);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 1, eflags: 0x0
    // Checksum 0x2c1a3490, Offset: 0x618
    // Size: 0xd8
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "promptProgress", 0);
        set_data(localclientnum, "gunIndex1", 0);
        set_data(localclientnum, "gunindex2", 0);
        set_data(localclientnum, "gunindex3", 0);
        set_data(localclientnum, "color", 0);
    }

}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 5, eflags: 0x0
// Checksum 0x69d0100a, Offset: 0x110
// Size: 0x19e
function register(var_e4dedc0e, var_c8914fcf, var_2f1b82f5, var_bf555938, var_18d66c99) {
    elem = new class_51a06b68();
    [[ elem ]]->setup_clientfields(var_e4dedc0e, var_c8914fcf, var_2f1b82f5, var_bf555938, var_18d66c99);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"sr_objective_reward_menu"])) {
        level.var_ae746e8f[#"sr_objective_reward_menu"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"sr_objective_reward_menu"])) {
        level.var_ae746e8f[#"sr_objective_reward_menu"] = [];
    } else if (!isarray(level.var_ae746e8f[#"sr_objective_reward_menu"])) {
        level.var_ae746e8f[#"sr_objective_reward_menu"] = array(level.var_ae746e8f[#"sr_objective_reward_menu"]);
    }
    level.var_ae746e8f[#"sr_objective_reward_menu"][level.var_ae746e8f[#"sr_objective_reward_menu"].size] = elem;
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 0, eflags: 0x0
// Checksum 0x2fab0893, Offset: 0x2b8
// Size: 0x34
function register_clientside() {
    elem = new class_51a06b68();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 1, eflags: 0x0
// Checksum 0xb1148935, Offset: 0x2f8
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 1, eflags: 0x0
// Checksum 0xc783dbe4, Offset: 0x320
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 1, eflags: 0x0
// Checksum 0xb1f481bf, Offset: 0x348
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0x3231e278, Offset: 0x370
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0x658b854d, Offset: 0x3a0
// Size: 0x28
function function_b94196b8(localclientnum, value) {
    [[ self ]]->function_b94196b8(localclientnum, value);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0x9adc994e, Offset: 0x3d0
// Size: 0x28
function function_43ba5f0e(localclientnum, value) {
    [[ self ]]->function_43ba5f0e(localclientnum, value);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0x1606847a, Offset: 0x400
// Size: 0x28
function function_2d7f3298(localclientnum, value) {
    [[ self ]]->function_2d7f3298(localclientnum, value);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0x77682699, Offset: 0x430
// Size: 0x28
function function_ada8b2f1(localclientnum, value) {
    [[ self ]]->function_ada8b2f1(localclientnum, value);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0xdda8fd60, Offset: 0x460
// Size: 0x28
function set_color(localclientnum, value) {
    [[ self ]]->set_color(localclientnum, value);
}

