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
    // Checksum 0x2cd635e, Offset: 0x240
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 1, eflags: 0x0
    // Checksum 0x444a9105, Offset: 0x288
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 0, eflags: 0x0
    // Checksum 0x412986ec, Offset: 0x1f0
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("insertion_passenger_count");
        cluielem::add_clientfield("count", 1, 7, "int");
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 2, eflags: 0x0
    // Checksum 0x60635417, Offset: 0x2b8
    // Size: 0x44
    function set_count(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "count", value);
    }

}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 0, eflags: 0x0
// Checksum 0xd1f12422, Offset: 0xd0
// Size: 0x34
function register() {
    elem = new cinsertion_passenger_count();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 2, eflags: 0x0
// Checksum 0xcdc7ef18, Offset: 0x110
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0x16d8a484, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0x2cbda683, Offset: 0x178
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 2, eflags: 0x0
// Checksum 0x167ac38e, Offset: 0x1a0
// Size: 0x28
function set_count(player, value) {
    [[ self ]]->set_count(player, value);
}

