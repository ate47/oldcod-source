#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace self_revive_visuals_rush;

// Namespace self_revive_visuals_rush
// Method(s) 6 Total 13
class cself_revive_visuals_rush : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 2, eflags: 0x0
    // Checksum 0xef7ac1b6, Offset: 0x240
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 1, eflags: 0x0
    // Checksum 0xe8bf2ec, Offset: 0x288
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 0, eflags: 0x0
    // Checksum 0x77c05f3a, Offset: 0x1f0
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("self_revive_visuals_rush");
        cluielem::add_clientfield("revive_time", 1, 4, "int");
    }

    // Namespace cself_revive_visuals_rush/self_revive_visuals_rush
    // Params 2, eflags: 0x0
    // Checksum 0xfa2ebcf, Offset: 0x2b8
    // Size: 0x44
    function set_revive_time(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "revive_time", value);
    }

}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 0, eflags: 0x0
// Checksum 0x1e89506f, Offset: 0xd0
// Size: 0x34
function register() {
    elem = new cself_revive_visuals_rush();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 2, eflags: 0x0
// Checksum 0xab93d0f6, Offset: 0x110
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 1, eflags: 0x0
// Checksum 0x2f3c9e91, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 1, eflags: 0x0
// Checksum 0x54a16eec, Offset: 0x178
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace self_revive_visuals_rush/self_revive_visuals_rush
// Params 2, eflags: 0x0
// Checksum 0xc6095020, Offset: 0x1a0
// Size: 0x28
function set_revive_time(player, value) {
    [[ self ]]->set_revive_time(player, value);
}

