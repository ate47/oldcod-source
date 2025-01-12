#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace insertion_passenger_count;

// Namespace insertion_passenger_count
// Method(s) 6 Total 13
class cinsertion_passenger_count : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 2, eflags: 0x0
    // Checksum 0x6722c027, Offset: 0x240
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 1, eflags: 0x0
    // Checksum 0x4295617c, Offset: 0x288
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 0, eflags: 0x0
    // Checksum 0x879bbdb9, Offset: 0x1f0
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("insertion_passenger_count");
        cluielem::add_clientfield("count", 1, 7, "int");
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 2, eflags: 0x0
    // Checksum 0x55482f73, Offset: 0x2b8
    // Size: 0x44
    function set_count(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "count", value);
    }

}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 0, eflags: 0x0
// Checksum 0x90674316, Offset: 0xd0
// Size: 0x34
function register() {
    elem = new cinsertion_passenger_count();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 2, eflags: 0x0
// Checksum 0x17ff746, Offset: 0x110
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0x1870d62a, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0x4fad5457, Offset: 0x178
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 2, eflags: 0x0
// Checksum 0x91b4f129, Offset: 0x1a0
// Size: 0x28
function set_count(player, value) {
    [[ self ]]->set_count(player, value);
}

