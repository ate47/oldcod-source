#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace death_zone;

// Namespace death_zone
// Method(s) 6 Total 13
class cdeath_zone : cluielem {

    var var_57a3d576;

    // Namespace cdeath_zone/death_zone
    // Params 2, eflags: 0x0
    // Checksum 0x824a9eb0, Offset: 0x2b8
    // Size: 0x3c
    function set_shutdown_sec(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "shutdown_sec", value);
    }

    // Namespace cdeath_zone/death_zone
    // Params 1, eflags: 0x0
    // Checksum 0x682baaf7, Offset: 0x288
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cdeath_zone/death_zone
    // Params 2, eflags: 0x0
    // Checksum 0x6e931d15, Offset: 0x238
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "death_zone", persistent);
    }

    // Namespace cdeath_zone/death_zone
    // Params 1, eflags: 0x0
    // Checksum 0x29ca5da, Offset: 0x1e0
    // Size: 0x4c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("shutdown_sec", 1, 9, "int");
    }

}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0xd5592f26, Offset: 0xb8
// Size: 0x40
function register(uid) {
    elem = new cdeath_zone();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace death_zone/death_zone
// Params 2, eflags: 0x0
// Checksum 0x60c003a0, Offset: 0x100
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0x7a31d875, Offset: 0x140
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0xee591e8d, Offset: 0x168
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace death_zone/death_zone
// Params 2, eflags: 0x0
// Checksum 0xfb34dd2b, Offset: 0x190
// Size: 0x28
function set_shutdown_sec(player, value) {
    [[ self ]]->set_shutdown_sec(player, value);
}

