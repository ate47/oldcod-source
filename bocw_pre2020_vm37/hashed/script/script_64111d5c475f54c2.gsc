#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_silver_hud;

// Namespace zm_silver_hud
// Method(s) 7 Total 14
class class_5813c56a : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_5813c56a/zm_silver_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5dac2e58, Offset: 0x2a8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_5813c56a/zm_silver_hud
    // Params 1, eflags: 0x1 linked
    // Checksum 0xbef0cc6b, Offset: 0x2f0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_5813c56a/zm_silver_hud
    // Params 0, eflags: 0x1 linked
    // Checksum 0x40d13f9f, Offset: 0x230
    // Size: 0x6c
    function setup_clientfields() {
        cluielem::setup_clientfields("zm_silver_hud");
        cluielem::add_clientfield("_state", 1, 3, "int");
        cluielem::function_dcb34c80("string", "aetherscopeStatus", 1);
    }

    // Namespace namespace_5813c56a/zm_silver_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3c59c88c, Offset: 0x4d0
    // Size: 0x44
    function function_9efecfd1(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "aetherscopeStatus", value);
    }

    // Namespace namespace_5813c56a/zm_silver_hud
    // Params 2, eflags: 0x1 linked
    // Checksum 0x7fffc3df, Offset: 0x320
    // Size: 0x1a4
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 0);
            return;
        }
        if (#"hash_6cf1a586f517c6b0" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 1);
            return;
        }
        if (#"hash_7fc6d62e63e7c7eb" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 2);
            return;
        }
        if (#"hash_78afa944bedce9e5" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 3);
            return;
        }
        if (#"hash_5f0709f7c6680cea" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 4);
            return;
        }
        assertmsg("<dev string:x38>");
    }

}

// Namespace zm_silver_hud/zm_silver_hud
// Params 0, eflags: 0x1 linked
// Checksum 0x178b3f6e, Offset: 0xe0
// Size: 0x34
function register() {
    elem = new class_5813c56a();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace zm_silver_hud/zm_silver_hud
// Params 2, eflags: 0x1 linked
// Checksum 0xca2e1c40, Offset: 0x120
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_silver_hud/zm_silver_hud
// Params 1, eflags: 0x1 linked
// Checksum 0x7c7778f0, Offset: 0x160
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_silver_hud/zm_silver_hud
// Params 1, eflags: 0x1 linked
// Checksum 0xa2ef2991, Offset: 0x188
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace zm_silver_hud/zm_silver_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x8e1d010e, Offset: 0x1b0
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace zm_silver_hud/zm_silver_hud
// Params 2, eflags: 0x1 linked
// Checksum 0x8f5494f7, Offset: 0x1e0
// Size: 0x28
function function_9efecfd1(player, value) {
    [[ self ]]->function_9efecfd1(player, value);
}

