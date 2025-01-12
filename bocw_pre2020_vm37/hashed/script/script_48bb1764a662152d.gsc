#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace vehicleturretoverheat;

// Namespace vehicleturretoverheat
// Method(s) 7 Total 14
class cvehicleturretoverheat : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cvehicleturretoverheat/vehicleturretoverheat
    // Params 2, eflags: 0x0
    // Checksum 0xd94a58b, Offset: 0x2a8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cvehicleturretoverheat/vehicleturretoverheat
    // Params 1, eflags: 0x0
    // Checksum 0x30f7489b, Offset: 0x2f0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cvehicleturretoverheat/vehicleturretoverheat
    // Params 0, eflags: 0x0
    // Checksum 0x8b7a1854, Offset: 0x230
    // Size: 0x6c
    function setup_clientfields() {
        cluielem::setup_clientfields("VehicleTurretOverheat");
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::add_clientfield("bar_percent", 1, 6, "float", 0);
    }

    // Namespace cvehicleturretoverheat/vehicleturretoverheat
    // Params 2, eflags: 0x0
    // Checksum 0xea920637, Offset: 0x320
    // Size: 0xcc
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 0);
            return;
        }
        if (#"overheat" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 1);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace cvehicleturretoverheat/vehicleturretoverheat
    // Params 2, eflags: 0x0
    // Checksum 0x91ff1ba4, Offset: 0x3f8
    // Size: 0x44
    function set_bar_percent(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "bar_percent", value);
    }

}

// Namespace vehicleturretoverheat/vehicleturretoverheat
// Params 0, eflags: 0x0
// Checksum 0xc01dc217, Offset: 0xe0
// Size: 0x34
function register() {
    elem = new cvehicleturretoverheat();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace vehicleturretoverheat/vehicleturretoverheat
// Params 2, eflags: 0x0
// Checksum 0xab93d0f6, Offset: 0x120
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace vehicleturretoverheat/vehicleturretoverheat
// Params 1, eflags: 0x0
// Checksum 0x2f3c9e91, Offset: 0x160
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace vehicleturretoverheat/vehicleturretoverheat
// Params 1, eflags: 0x0
// Checksum 0x54a16eec, Offset: 0x188
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace vehicleturretoverheat/vehicleturretoverheat
// Params 2, eflags: 0x0
// Checksum 0xc5929020, Offset: 0x1b0
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace vehicleturretoverheat/vehicleturretoverheat
// Params 2, eflags: 0x0
// Checksum 0xfbfae1f, Offset: 0x1e0
// Size: 0x28
function set_bar_percent(player, value) {
    [[ self ]]->set_bar_percent(player, value);
}

