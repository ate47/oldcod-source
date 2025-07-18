#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace mp_infect_timer;

// Namespace mp_infect_timer
// Method(s) 6 Total 13
class cmp_infect_timer : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cmp_infect_timer/mp_infect_timer
    // Params 2, eflags: 0x0
    // Checksum 0xa9ea1d07, Offset: 0x248
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cmp_infect_timer/mp_infect_timer
    // Params 1, eflags: 0x0
    // Checksum 0xd7630d52, Offset: 0x290
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cmp_infect_timer/mp_infect_timer
    // Params 2, eflags: 0x0
    // Checksum 0xbe007918, Offset: 0x2c0
    // Size: 0x44
    function function_8c8674a4(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "infectionTimeRemaining", value);
    }

    // Namespace cmp_infect_timer/mp_infect_timer
    // Params 0, eflags: 0x0
    // Checksum 0xd0118a17, Offset: 0x1f8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("mp_infect_timer");
        cluielem::add_clientfield("infectionTimeRemaining", 1, 4, "int", 0);
    }

}

// Namespace mp_infect_timer/mp_infect_timer
// Params 0, eflags: 0x0
// Checksum 0x70d5c55c, Offset: 0xd8
// Size: 0x34
function register() {
    elem = new cmp_infect_timer();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace mp_infect_timer/mp_infect_timer
// Params 2, eflags: 0x0
// Checksum 0xe1ba103e, Offset: 0x118
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace mp_infect_timer/mp_infect_timer
// Params 1, eflags: 0x0
// Checksum 0xf38863ea, Offset: 0x158
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_infect_timer/mp_infect_timer
// Params 1, eflags: 0x0
// Checksum 0xa304d7b3, Offset: 0x180
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace mp_infect_timer/mp_infect_timer
// Params 2, eflags: 0x0
// Checksum 0xd9330a05, Offset: 0x1a8
// Size: 0x28
function function_8c8674a4(player, value) {
    [[ self ]]->function_8c8674a4(player, value);
}

