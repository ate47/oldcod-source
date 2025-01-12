#using scripts\core_common\lui_shared;

#namespace vehicleturretoverheat;

// Namespace vehicleturretoverheat
// Method(s) 8 Total 14
class cvehicleturretoverheat : cluielem {

    // Namespace cvehicleturretoverheat/vehicleturretoverheat
    // Params 1, eflags: 0x0
    // Checksum 0x7626133b, Offset: 0x4a8
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cvehicleturretoverheat/vehicleturretoverheat
    // Params 0, eflags: 0x0
    // Checksum 0xc0f8431a, Offset: 0x410
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("VehicleTurretOverheat");
    }

    // Namespace cvehicleturretoverheat/vehicleturretoverheat
    // Params 1, eflags: 0x0
    // Checksum 0xbdca3adf, Offset: 0x390
    // Size: 0x74
    function setup_clientfields(var_661989d5) {
        cluielem::setup_clientfields("VehicleTurretOverheat");
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::add_clientfield("bar_percent", 1, 6, "float", var_661989d5);
    }

    // Namespace cvehicleturretoverheat/vehicleturretoverheat
    // Params 2, eflags: 0x0
    // Checksum 0xf4b89765, Offset: 0x4d8
    // Size: 0xac
    function set_state(localclientnum, state_name) {
        if (#"defaultstate" == state_name) {
            set_data(localclientnum, "_state", 0);
            return;
        }
        if (#"overheat" == state_name) {
            set_data(localclientnum, "_state", 1);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace cvehicleturretoverheat/vehicleturretoverheat
    // Params 1, eflags: 0x0
    // Checksum 0x7e6ffea9, Offset: 0x438
    // Size: 0x68
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_state(localclientnum, #"defaultstate");
        set_data(localclientnum, "bar_percent", 0);
    }

    // Namespace cvehicleturretoverheat/vehicleturretoverheat
    // Params 2, eflags: 0x0
    // Checksum 0xcb58bce, Offset: 0x590
    // Size: 0x30
    function set_bar_percent(localclientnum, value) {
        set_data(localclientnum, "bar_percent", value);
    }

}

// Namespace vehicleturretoverheat/vehicleturretoverheat
// Params 1, eflags: 0x0
// Checksum 0x9d4838d8, Offset: 0xd8
// Size: 0x176
function register(var_661989d5) {
    elem = new cvehicleturretoverheat();
    [[ elem ]]->setup_clientfields(var_661989d5);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"vehicleturretoverheat"])) {
        level.var_ae746e8f[#"vehicleturretoverheat"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"vehicleturretoverheat"])) {
        level.var_ae746e8f[#"vehicleturretoverheat"] = [];
    } else if (!isarray(level.var_ae746e8f[#"vehicleturretoverheat"])) {
        level.var_ae746e8f[#"vehicleturretoverheat"] = array(level.var_ae746e8f[#"vehicleturretoverheat"]);
    }
    level.var_ae746e8f[#"vehicleturretoverheat"][level.var_ae746e8f[#"vehicleturretoverheat"].size] = elem;
}

// Namespace vehicleturretoverheat/vehicleturretoverheat
// Params 0, eflags: 0x0
// Checksum 0x907d89b, Offset: 0x258
// Size: 0x34
function register_clientside() {
    elem = new cvehicleturretoverheat();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace vehicleturretoverheat/vehicleturretoverheat
// Params 1, eflags: 0x0
// Checksum 0x4d68e832, Offset: 0x298
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace vehicleturretoverheat/vehicleturretoverheat
// Params 1, eflags: 0x0
// Checksum 0x81a2f072, Offset: 0x2c0
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace vehicleturretoverheat/vehicleturretoverheat
// Params 1, eflags: 0x0
// Checksum 0x26f3c122, Offset: 0x2e8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace vehicleturretoverheat/vehicleturretoverheat
// Params 2, eflags: 0x0
// Checksum 0xcdbc08c5, Offset: 0x310
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

// Namespace vehicleturretoverheat/vehicleturretoverheat
// Params 2, eflags: 0x0
// Checksum 0xf978ef44, Offset: 0x340
// Size: 0x28
function set_bar_percent(localclientnum, value) {
    [[ self ]]->set_bar_percent(localclientnum, value);
}

