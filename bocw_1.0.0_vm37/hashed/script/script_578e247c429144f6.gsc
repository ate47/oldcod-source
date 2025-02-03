#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace vehicleturretdurability;

// Namespace vehicleturretdurability
// Method(s) 6 Total 13
class cvehicleturretdurability : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cvehicleturretdurability/vehicleturretdurability
    // Params 2, eflags: 0x0
    // Checksum 0x2ebab59f, Offset: 0x240
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cvehicleturretdurability/vehicleturretdurability
    // Params 1, eflags: 0x0
    // Checksum 0xaad9f741, Offset: 0x288
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cvehicleturretdurability/vehicleturretdurability
    // Params 0, eflags: 0x0
    // Checksum 0x45c865d3, Offset: 0x1f0
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("VehicleTurretDurability");
        cluielem::add_clientfield("bar_percent", 1, 6, "float", 0);
    }

    // Namespace cvehicleturretdurability/vehicleturretdurability
    // Params 2, eflags: 0x0
    // Checksum 0xa7b9362b, Offset: 0x2b8
    // Size: 0x44
    function set_bar_percent(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "bar_percent", value);
    }

}

// Namespace vehicleturretdurability/vehicleturretdurability
// Params 0, eflags: 0x0
// Checksum 0x92f47e01, Offset: 0xd0
// Size: 0x34
function register() {
    elem = new cvehicleturretdurability();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace vehicleturretdurability/vehicleturretdurability
// Params 2, eflags: 0x0
// Checksum 0x35673d9d, Offset: 0x110
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace vehicleturretdurability/vehicleturretdurability
// Params 1, eflags: 0x0
// Checksum 0x9a12b086, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace vehicleturretdurability/vehicleturretdurability
// Params 1, eflags: 0x0
// Checksum 0x49a08577, Offset: 0x178
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace vehicleturretdurability/vehicleturretdurability
// Params 2, eflags: 0x0
// Checksum 0x6bcccbc1, Offset: 0x1a0
// Size: 0x28
function set_bar_percent(player, value) {
    [[ self ]]->set_bar_percent(player, value);
}

