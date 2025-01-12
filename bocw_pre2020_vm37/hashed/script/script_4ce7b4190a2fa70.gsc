#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace sr_objective_reward_menu;

// Namespace sr_objective_reward_menu
// Method(s) 11 Total 18
class class_51a06b68 : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x70102457, Offset: 0x440
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0xa99bdd18, Offset: 0x6c0
    // Size: 0x44
    function function_2d7f3298(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "gunindex2", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x3b3e0e7e, Offset: 0x670
    // Size: 0x44
    function function_43ba5f0e(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "gunIndex1", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 1, eflags: 0x0
    // Checksum 0xda9d4fa, Offset: 0x488
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 0, eflags: 0x0
    // Checksum 0x50915ca5, Offset: 0x328
    // Size: 0x10c
    function setup_clientfields() {
        cluielem::setup_clientfields("sr_objective_reward_menu");
        cluielem::add_clientfield("_state", 1, 2, "int");
        cluielem::add_clientfield("promptProgress", 1, 7, "float");
        cluielem::add_clientfield("gunIndex1", 1, 4, "int");
        cluielem::add_clientfield("gunindex2", 1, 4, "int");
        cluielem::add_clientfield("gunindex3", 1, 4, "int");
        cluielem::add_clientfield("color", 1, 2, "int");
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x9a50dda8, Offset: 0x760
    // Size: 0x44
    function set_color(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "color", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0xb66d225b, Offset: 0x710
    // Size: 0x44
    function function_ada8b2f1(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "gunindex3", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0xf7f43c83, Offset: 0x620
    // Size: 0x44
    function function_b94196b8(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "promptProgress", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x66ba44a4, Offset: 0x4b8
    // Size: 0x15c
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 0);
            return;
        }
        if (#"gun1selected" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 1);
            return;
        }
        if (#"gun2selected" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 2);
            return;
        }
        if (#"gun3selected" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 3);
            return;
        }
        assertmsg("<dev string:x38>");
    }

}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 0, eflags: 0x0
// Checksum 0xfda3d2a, Offset: 0x118
// Size: 0x34
function register() {
    elem = new class_51a06b68();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0xcd520476, Offset: 0x158
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 1, eflags: 0x0
// Checksum 0x2ecba694, Offset: 0x198
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 1, eflags: 0x0
// Checksum 0x12f52bff, Offset: 0x1c0
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0xbc94c045, Offset: 0x1e8
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0xede229bb, Offset: 0x218
// Size: 0x28
function function_b94196b8(player, value) {
    [[ self ]]->function_b94196b8(player, value);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0xa95ddb5c, Offset: 0x248
// Size: 0x28
function function_43ba5f0e(player, value) {
    [[ self ]]->function_43ba5f0e(player, value);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0x314716b, Offset: 0x278
// Size: 0x28
function function_2d7f3298(player, value) {
    [[ self ]]->function_2d7f3298(player, value);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0xe8809225, Offset: 0x2a8
// Size: 0x28
function function_ada8b2f1(player, value) {
    [[ self ]]->function_ada8b2f1(player, value);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0x1bfa13f4, Offset: 0x2d8
// Size: 0x28
function set_color(player, value) {
    [[ self ]]->set_color(player, value);
}

