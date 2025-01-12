#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace insertion_passenger_count;

// Namespace insertion_passenger_count
// Method(s) 6 Total 13
class cinsertion_passenger_count : cluielem {

    var var_57a3d576;

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 2, eflags: 0x0
    // Checksum 0xadb8c3e4, Offset: 0x2c0
    // Size: 0x3c
    function set_count(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "count", value);
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 1, eflags: 0x0
    // Checksum 0x6dff534f, Offset: 0x290
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 2, eflags: 0x0
    // Checksum 0x2d9ea5ca, Offset: 0x240
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "insertion_passenger_count", persistent);
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 1, eflags: 0x0
    // Checksum 0x30c355a6, Offset: 0x1e8
    // Size: 0x4c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("count", 1, 6, "int");
    }

}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0x4df6544b, Offset: 0xc0
// Size: 0x40
function register(uid) {
    elem = new cinsertion_passenger_count();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 2, eflags: 0x0
// Checksum 0xda763082, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0x70be4f1b, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0xb7621adc, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 2, eflags: 0x0
// Checksum 0x1b5cae2f, Offset: 0x198
// Size: 0x28
function set_count(player, value) {
    [[ self ]]->set_count(player, value);
}

