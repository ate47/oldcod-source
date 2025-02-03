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
    // Checksum 0x832bc260, Offset: 0x440
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0xeb6d2892, Offset: 0x6c0
    // Size: 0x44
    function function_2d7f3298(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "gunindex2", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x5918ad5a, Offset: 0x670
    // Size: 0x44
    function function_43ba5f0e(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "gunIndex1", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 1, eflags: 0x0
    // Checksum 0xfe45db75, Offset: 0x488
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 0, eflags: 0x0
    // Checksum 0x88dd75ce, Offset: 0x328
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
    // Checksum 0x7cde27ec, Offset: 0x760
    // Size: 0x44
    function set_color(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "color", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x5c6112ff, Offset: 0x710
    // Size: 0x44
    function function_ada8b2f1(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "gunindex3", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x8bda0cad, Offset: 0x620
    // Size: 0x44
    function function_b94196b8(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "promptProgress", value);
    }

    // Namespace namespace_51a06b68/sr_objective_reward_menu
    // Params 2, eflags: 0x0
    // Checksum 0x3f15b571, Offset: 0x4b8
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
// Checksum 0x4e4c5a1e, Offset: 0x118
// Size: 0x34
function register() {
    elem = new class_51a06b68();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0x1ea1c28, Offset: 0x158
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 1, eflags: 0x0
// Checksum 0x2063d43a, Offset: 0x198
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 1, eflags: 0x0
// Checksum 0x71e5d92b, Offset: 0x1c0
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0x3b5af2e2, Offset: 0x1e8
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0xd1b86bf5, Offset: 0x218
// Size: 0x28
function function_b94196b8(player, value) {
    [[ self ]]->function_b94196b8(player, value);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0x20af269e, Offset: 0x248
// Size: 0x28
function function_43ba5f0e(player, value) {
    [[ self ]]->function_43ba5f0e(player, value);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0xdfb96a57, Offset: 0x278
// Size: 0x28
function function_2d7f3298(player, value) {
    [[ self ]]->function_2d7f3298(player, value);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0x7fc610be, Offset: 0x2a8
// Size: 0x28
function function_ada8b2f1(player, value) {
    [[ self ]]->function_ada8b2f1(player, value);
}

// Namespace sr_objective_reward_menu/sr_objective_reward_menu
// Params 2, eflags: 0x0
// Checksum 0xce6d2755, Offset: 0x2d8
// Size: 0x28
function set_color(player, value) {
    [[ self ]]->set_color(player, value);
}

