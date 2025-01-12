#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace death_zone;

// Namespace death_zone
// Method(s) 6 Total 13
class cdeath_zone : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cdeath_zone/death_zone
    // Params 2, eflags: 0x0
    // Checksum 0x6722c027, Offset: 0x238
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cdeath_zone/death_zone
    // Params 2, eflags: 0x0
    // Checksum 0xb0709bf2, Offset: 0x2b0
    // Size: 0x44
    function set_shutdown_sec(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "shutdown_sec", value);
    }

    // Namespace cdeath_zone/death_zone
    // Params 1, eflags: 0x0
    // Checksum 0x4295617c, Offset: 0x280
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cdeath_zone/death_zone
    // Params 0, eflags: 0x0
    // Checksum 0xc3aec8c5, Offset: 0x1e8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("death_zone");
        cluielem::add_clientfield("shutdown_sec", 1, 9, "int");
    }

}

// Namespace death_zone/death_zone
// Params 0, eflags: 0x0
// Checksum 0xd6c23664, Offset: 0xc8
// Size: 0x34
function register() {
    elem = new cdeath_zone();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace death_zone/death_zone
// Params 2, eflags: 0x0
// Checksum 0x17ff746, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0x1870d62a, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0x4fad5457, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace death_zone/death_zone
// Params 2, eflags: 0x0
// Checksum 0xc7d81035, Offset: 0x198
// Size: 0x28
function set_shutdown_sec(player, value) {
    [[ self ]]->set_shutdown_sec(player, value);
}

