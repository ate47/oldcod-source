#using scripts\core_common\lui_shared;

#namespace insertion_passenger_count;

// Namespace insertion_passenger_count
// Method(s) 7 Total 13
class cinsertion_passenger_count : cluielem {

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 2, eflags: 0x0
    // Checksum 0x4ce1bd5e, Offset: 0x318
    // Size: 0x30
    function set_count(localclientnum, value) {
        set_data(localclientnum, "count", value);
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 1, eflags: 0x0
    // Checksum 0x6a05ed5d, Offset: 0x2e0
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"insertion_passenger_count");
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 1, eflags: 0x0
    // Checksum 0x528a5424, Offset: 0x298
    // Size: 0x40
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "count", 0);
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 1, eflags: 0x0
    // Checksum 0xe5609b0a, Offset: 0x268
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cinsertion_passenger_count/insertion_passenger_count
    // Params 2, eflags: 0x0
    // Checksum 0xc8f00cbd, Offset: 0x208
    // Size: 0x54
    function setup_clientfields(uid, var_1b98496b) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("count", 1, 6, "int", var_1b98496b);
    }

}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 2, eflags: 0x0
// Checksum 0xc551ffe6, Offset: 0xa0
// Size: 0x4c
function register(uid, var_1b98496b) {
    elem = new cinsertion_passenger_count();
    [[ elem ]]->setup_clientfields(uid, var_1b98496b);
    return elem;
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0x56c355fa, Offset: 0xf8
// Size: 0x40
function register_clientside(uid) {
    elem = new cinsertion_passenger_count();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0x7c5a9cdc, Offset: 0x140
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0xe317a942, Offset: 0x168
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 1, eflags: 0x0
// Checksum 0x5d2122b5, Offset: 0x190
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace insertion_passenger_count/insertion_passenger_count
// Params 2, eflags: 0x0
// Checksum 0x1fb02d29, Offset: 0x1b8
// Size: 0x28
function set_count(localclientnum, value) {
    [[ self ]]->set_count(localclientnum, value);
}

