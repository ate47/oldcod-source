#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_laststand_client;

// Namespace zm_laststand_client
// Method(s) 8 Total 15
class czm_laststand_client : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0x798dae6b, Offset: 0x320
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 1, eflags: 0x0
    // Checksum 0xdd8b4b83, Offset: 0x368
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0x129d1532, Offset: 0x438
    // Size: 0x44
    function set_num_downs(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "num_downs", value);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0x55b3b3d5, Offset: 0x398
    // Size: 0x44
    function set_bleedout_progress(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "bleedout_progress", value);
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 0, eflags: 0x0
    // Checksum 0x5a6e7026, Offset: 0x280
    // Size: 0x94
    function setup_clientfields() {
        cluielem::setup_clientfields("zm_laststand_client");
        cluielem::add_clientfield("bleedout_progress", 1, 8, "float");
        cluielem::add_clientfield("revive_progress", 1, 8, "float");
        cluielem::add_clientfield("num_downs", 1, 8, "int");
    }

    // Namespace czm_laststand_client/zm_laststand_client
    // Params 2, eflags: 0x0
    // Checksum 0xbd1486dc, Offset: 0x3e8
    // Size: 0x44
    function set_revive_progress(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "revive_progress", value);
    }

}

// Namespace zm_laststand_client/zm_laststand_client
// Params 0, eflags: 0x0
// Checksum 0x23159d59, Offset: 0x100
// Size: 0x34
function register() {
    elem = new czm_laststand_client();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0xe1ba103e, Offset: 0x140
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0xf38863ea, Offset: 0x180
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 1, eflags: 0x0
// Checksum 0xa304d7b3, Offset: 0x1a8
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0xc3769582, Offset: 0x1d0
// Size: 0x28
function set_bleedout_progress(player, value) {
    [[ self ]]->set_bleedout_progress(player, value);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0x40edf9ea, Offset: 0x200
// Size: 0x28
function set_revive_progress(player, value) {
    [[ self ]]->set_revive_progress(player, value);
}

// Namespace zm_laststand_client/zm_laststand_client
// Params 2, eflags: 0x0
// Checksum 0xdabcf1d4, Offset: 0x230
// Size: 0x28
function set_num_downs(player, value) {
    [[ self ]]->set_num_downs(player, value);
}

