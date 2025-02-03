#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace self_respawn;

// Namespace self_respawn
// Method(s) 6 Total 13
class cself_respawn : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cself_respawn/self_respawn
    // Params 2, eflags: 0x0
    // Checksum 0xfc52c0f5, Offset: 0x2b0
    // Size: 0x44
    function set_percent(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "percent", value);
    }

    // Namespace cself_respawn/self_respawn
    // Params 2, eflags: 0x0
    // Checksum 0x4dc8613f, Offset: 0x238
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cself_respawn/self_respawn
    // Params 1, eflags: 0x0
    // Checksum 0xb9208dfc, Offset: 0x280
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cself_respawn/self_respawn
    // Params 0, eflags: 0x0
    // Checksum 0xd69cf9cd, Offset: 0x1e8
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("self_respawn");
        cluielem::add_clientfield("percent", 1, 6, "float");
    }

}

// Namespace self_respawn/self_respawn
// Params 0, eflags: 0x0
// Checksum 0xde0f4519, Offset: 0xc8
// Size: 0x34
function register() {
    elem = new cself_respawn();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace self_respawn/self_respawn
// Params 2, eflags: 0x0
// Checksum 0xe1ba103e, Offset: 0x108
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace self_respawn/self_respawn
// Params 1, eflags: 0x0
// Checksum 0xf38863ea, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace self_respawn/self_respawn
// Params 1, eflags: 0x0
// Checksum 0xa304d7b3, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace self_respawn/self_respawn
// Params 2, eflags: 0x0
// Checksum 0x6ed0edaf, Offset: 0x198
// Size: 0x28
function set_percent(player, value) {
    [[ self ]]->set_percent(player, value);
}

