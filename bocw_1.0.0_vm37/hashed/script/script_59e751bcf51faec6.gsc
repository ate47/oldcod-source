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
    // Checksum 0x2cd635e, Offset: 0x238
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cdeath_zone/death_zone
    // Params 2, eflags: 0x0
    // Checksum 0x855be096, Offset: 0x2b0
    // Size: 0x44
    function set_shutdown_sec(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "shutdown_sec", value);
    }

    // Namespace cdeath_zone/death_zone
    // Params 1, eflags: 0x0
    // Checksum 0x444a9105, Offset: 0x280
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cdeath_zone/death_zone
    // Params 0, eflags: 0x0
    // Checksum 0x51cf390, Offset: 0x1e8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("death_zone");
        cluielem::add_clientfield("shutdown_sec", 1, 9, "int");
    }

}

// Namespace death_zone/death_zone
// Params 0, eflags: 0x0
// Checksum 0x97545150, Offset: 0xc8
// Size: 0x34
function register() {
    elem = new cdeath_zone();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace death_zone/death_zone
// Params 2, eflags: 0x0
// Checksum 0xcdc7ef18, Offset: 0x108
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0x16d8a484, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace death_zone/death_zone
// Params 1, eflags: 0x0
// Checksum 0x2cbda683, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace death_zone/death_zone
// Params 2, eflags: 0x0
// Checksum 0x40162292, Offset: 0x198
// Size: 0x28
function set_shutdown_sec(player, value) {
    [[ self ]]->set_shutdown_sec(player, value);
}

