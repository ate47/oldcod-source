#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace incursion_infiltrationtitlecards;

// Namespace incursion_infiltrationtitlecards
// Method(s) 7 Total 14
class class_7c3faeda : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_7c3faeda/incursion_infiltrationtitlecards
    // Params 2, eflags: 0x0
    // Checksum 0x41ae556, Offset: 0x2b8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_7c3faeda/incursion_infiltrationtitlecards
    // Params 1, eflags: 0x0
    // Checksum 0x326a2bb1, Offset: 0x300
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_7c3faeda/incursion_infiltrationtitlecards
    // Params 0, eflags: 0x0
    // Checksum 0xa4bb716f, Offset: 0x240
    // Size: 0x6c
    function setup_clientfields() {
        cluielem::setup_clientfields("Incursion_InfiltrationTitleCards");
        cluielem::add_clientfield("_state", 1, 4, "int");
        cluielem::add_clientfield("SelectedInfiltration", 1, 3, "int");
    }

    // Namespace namespace_7c3faeda/incursion_infiltrationtitlecards
    // Params 2, eflags: 0x0
    // Checksum 0x7593a77f, Offset: 0x330
    // Size: 0x42c
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 0);
            return;
        }
        if (#"hash_1c7fa28cf1485078" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 1);
            return;
        }
        if (#"hash_41af72ac3698f06f" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 2);
            return;
        }
        if (#"hash_5b1f56f3d27d25f0" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 3);
            return;
        }
        if (#"hash_249ee0339eddec66" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 4);
            return;
        }
        if (#"hash_55a524ad199904e9" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 5);
            return;
        }
        if (#"hash_37b2af92df0bfd42" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 6);
            return;
        }
        if (#"hash_30029804cf01e828" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 7);
            return;
        }
        if (#"hash_386af01523f194e5" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 8);
            return;
        }
        if (#"hash_c5a40437efffe76" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 9);
            return;
        }
        if (#"hash_88bd3835c23cdbc" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 10);
            return;
        }
        if (#"hash_55e75da288d110d4" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 11);
            return;
        }
        if (#"hash_3eb38ea38a92fe35" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 12);
            return;
        }
        if (#"hash_79efd6a9d00cac13" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 13);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace namespace_7c3faeda/incursion_infiltrationtitlecards
    // Params 2, eflags: 0x0
    // Checksum 0x7f5da2ae, Offset: 0x768
    // Size: 0x44
    function function_ee0c7ef6(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "SelectedInfiltration", value);
    }

}

// Namespace incursion_infiltrationtitlecards/incursion_infiltrationtitlecards
// Params 0, eflags: 0x0
// Checksum 0xfb5b97b0, Offset: 0xf0
// Size: 0x34
function register() {
    elem = new class_7c3faeda();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace incursion_infiltrationtitlecards/incursion_infiltrationtitlecards
// Params 2, eflags: 0x0
// Checksum 0x17ff746, Offset: 0x130
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace incursion_infiltrationtitlecards/incursion_infiltrationtitlecards
// Params 1, eflags: 0x0
// Checksum 0x1870d62a, Offset: 0x170
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace incursion_infiltrationtitlecards/incursion_infiltrationtitlecards
// Params 1, eflags: 0x0
// Checksum 0x4fad5457, Offset: 0x198
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace incursion_infiltrationtitlecards/incursion_infiltrationtitlecards
// Params 2, eflags: 0x0
// Checksum 0x1f99fab4, Offset: 0x1c0
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace incursion_infiltrationtitlecards/incursion_infiltrationtitlecards
// Params 2, eflags: 0x0
// Checksum 0x54eb0b62, Offset: 0x1f0
// Size: 0x28
function function_ee0c7ef6(player, value) {
    [[ self ]]->function_ee0c7ef6(player, value);
}

