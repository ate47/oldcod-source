#using scripts\core_common\lui_shared;

#namespace vehicleturretdurability;

// Namespace vehicleturretdurability
// Method(s) 7 Total 13
class cvehicleturretdurability : cluielem {

    // Namespace cvehicleturretdurability/vehicleturretdurability
    // Params 1, eflags: 0x0
    // Checksum 0xe92e7da6, Offset: 0x420
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cvehicleturretdurability/vehicleturretdurability
    // Params 0, eflags: 0x0
    // Checksum 0xb9e22a56, Offset: 0x3a8
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("VehicleTurretDurability");
    }

    // Namespace cvehicleturretdurability/vehicleturretdurability
    // Params 1, eflags: 0x0
    // Checksum 0xa767eb62, Offset: 0x350
    // Size: 0x4c
    function setup_clientfields(var_661989d5) {
        cluielem::setup_clientfields("VehicleTurretDurability");
        cluielem::add_clientfield("bar_percent", 1, 6, "float", var_661989d5);
    }

    // Namespace cvehicleturretdurability/vehicleturretdurability
    // Params 1, eflags: 0x0
    // Checksum 0xdfb33a90, Offset: 0x3d0
    // Size: 0x48
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "bar_percent", 0);
    }

    // Namespace cvehicleturretdurability/vehicleturretdurability
    // Params 2, eflags: 0x0
    // Checksum 0x4bbdb585, Offset: 0x450
    // Size: 0x30
    function set_bar_percent(localclientnum, value) {
        set_data(localclientnum, "bar_percent", value);
    }

}

// Namespace vehicleturretdurability/vehicleturretdurability
// Params 1, eflags: 0x0
// Checksum 0xb99d17a9, Offset: 0xc8
// Size: 0x176
function register(var_661989d5) {
    elem = new cvehicleturretdurability();
    [[ elem ]]->setup_clientfields(var_661989d5);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"vehicleturretdurability"])) {
        level.var_ae746e8f[#"vehicleturretdurability"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"vehicleturretdurability"])) {
        level.var_ae746e8f[#"vehicleturretdurability"] = [];
    } else if (!isarray(level.var_ae746e8f[#"vehicleturretdurability"])) {
        level.var_ae746e8f[#"vehicleturretdurability"] = array(level.var_ae746e8f[#"vehicleturretdurability"]);
    }
    level.var_ae746e8f[#"vehicleturretdurability"][level.var_ae746e8f[#"vehicleturretdurability"].size] = elem;
}

// Namespace vehicleturretdurability/vehicleturretdurability
// Params 0, eflags: 0x0
// Checksum 0x3b8561a2, Offset: 0x248
// Size: 0x34
function register_clientside() {
    elem = new cvehicleturretdurability();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace vehicleturretdurability/vehicleturretdurability
// Params 1, eflags: 0x0
// Checksum 0x459c6d40, Offset: 0x288
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace vehicleturretdurability/vehicleturretdurability
// Params 1, eflags: 0x0
// Checksum 0xe8c94162, Offset: 0x2b0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace vehicleturretdurability/vehicleturretdurability
// Params 1, eflags: 0x0
// Checksum 0x816edbed, Offset: 0x2d8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace vehicleturretdurability/vehicleturretdurability
// Params 2, eflags: 0x0
// Checksum 0x4af354c8, Offset: 0x300
// Size: 0x28
function set_bar_percent(localclientnum, value) {
    [[ self ]]->set_bar_percent(localclientnum, value);
}

