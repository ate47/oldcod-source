#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_towers_crowd_meter;

// Namespace zm_towers_crowd_meter
// Method(s) 7 Total 14
class czm_towers_crowd_meter : cluielem {

    var var_57a3d576;

    // Namespace czm_towers_crowd_meter/zm_towers_crowd_meter
    // Params 2, eflags: 0x0
    // Checksum 0x703e3f00, Offset: 0x628
    // Size: 0x3c
    function set_visible(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "visible", value);
    }

    // Namespace czm_towers_crowd_meter/zm_towers_crowd_meter
    // Params 2, eflags: 0x0
    // Checksum 0xaef85d8d, Offset: 0x320
    // Size: 0x2fc
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 0);
            return;
        }
        if (#"crowd_loathes" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 1);
            return;
        }
        if (#"crowd_hates" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 2);
            return;
        }
        if (#"crowd_no_love" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 3);
            return;
        }
        if (#"crowd_warm_up" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 4);
            return;
        }
        if (#"crowd_likes" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 5);
            return;
        }
        if (#"crowd_loves" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 6);
            return;
        }
        if (#"crowd_power_up_available_good" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 7);
            return;
        }
        if (#"crowd_power_up_available_bad" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 8);
            return;
        }
        if (#"crowd_power_up_available_good_partial" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 9);
            return;
        }
        if (#"crowd_power_up_available_bad_partial" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 10);
            return;
        }
        assertmsg("<dev string:x30>");
    }

    // Namespace czm_towers_crowd_meter/zm_towers_crowd_meter
    // Params 1, eflags: 0x0
    // Checksum 0x61797637, Offset: 0x2f0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_towers_crowd_meter/zm_towers_crowd_meter
    // Params 2, eflags: 0x0
    // Checksum 0x1c499de, Offset: 0x2a0
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_towers_crowd_meter", persistent);
    }

    // Namespace czm_towers_crowd_meter/zm_towers_crowd_meter
    // Params 1, eflags: 0x0
    // Checksum 0x44fcacea, Offset: 0x220
    // Size: 0x74
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("_state", 1, 4, "int");
        cluielem::add_clientfield("visible", 1, 1, "int");
    }

}

// Namespace zm_towers_crowd_meter/zm_towers_crowd_meter
// Params 1, eflags: 0x0
// Checksum 0x8ccbb7e9, Offset: 0xc8
// Size: 0x40
function register(uid) {
    elem = new czm_towers_crowd_meter();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_towers_crowd_meter/zm_towers_crowd_meter
// Params 2, eflags: 0x0
// Checksum 0x2e506a6b, Offset: 0x110
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_towers_crowd_meter/zm_towers_crowd_meter
// Params 1, eflags: 0x0
// Checksum 0xe0113db, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_towers_crowd_meter/zm_towers_crowd_meter
// Params 1, eflags: 0x0
// Checksum 0x2d46a008, Offset: 0x178
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_towers_crowd_meter/zm_towers_crowd_meter
// Params 2, eflags: 0x0
// Checksum 0xe352c7b9, Offset: 0x1a0
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace zm_towers_crowd_meter/zm_towers_crowd_meter
// Params 2, eflags: 0x0
// Checksum 0xf423833a, Offset: 0x1d0
// Size: 0x28
function set_visible(player, value) {
    [[ self ]]->set_visible(player, value);
}

