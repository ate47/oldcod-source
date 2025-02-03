#using scripts\core_common\lui_shared;

#namespace pitch_and_yaw_meters;

// Namespace pitch_and_yaw_meters
// Method(s) 6 Total 13
class class_98cc868d : cluielem {

    // Namespace namespace_98cc868d/pitch_and_yaw_meters
    // Params 1, eflags: 0x0
    // Checksum 0x36215cf9, Offset: 0x380
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace namespace_98cc868d/pitch_and_yaw_meters
    // Params 0, eflags: 0x0
    // Checksum 0xb10a24c0, Offset: 0x328
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("pitch_and_yaw_meters");
    }

    // Namespace namespace_98cc868d/pitch_and_yaw_meters
    // Params 0, eflags: 0x0
    // Checksum 0xdc1c29a1, Offset: 0x300
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("pitch_and_yaw_meters");
    }

    // Namespace namespace_98cc868d/pitch_and_yaw_meters
    // Params 1, eflags: 0x0
    // Checksum 0xc047929d, Offset: 0x350
    // Size: 0x24
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
    }

}

// Namespace pitch_and_yaw_meters/pitch_and_yaw_meters
// Params 0, eflags: 0x0
// Checksum 0xc539ef41, Offset: 0xb0
// Size: 0x16e
function register() {
    elem = new class_98cc868d();
    [[ elem ]]->setup_clientfields();
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"pitch_and_yaw_meters"])) {
        level.var_ae746e8f[#"pitch_and_yaw_meters"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"pitch_and_yaw_meters"])) {
        level.var_ae746e8f[#"pitch_and_yaw_meters"] = [];
    } else if (!isarray(level.var_ae746e8f[#"pitch_and_yaw_meters"])) {
        level.var_ae746e8f[#"pitch_and_yaw_meters"] = array(level.var_ae746e8f[#"pitch_and_yaw_meters"]);
    }
    level.var_ae746e8f[#"pitch_and_yaw_meters"][level.var_ae746e8f[#"pitch_and_yaw_meters"].size] = elem;
}

// Namespace pitch_and_yaw_meters/pitch_and_yaw_meters
// Params 0, eflags: 0x0
// Checksum 0x560818d9, Offset: 0x228
// Size: 0x34
function register_clientside() {
    elem = new class_98cc868d();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace pitch_and_yaw_meters/pitch_and_yaw_meters
// Params 1, eflags: 0x0
// Checksum 0x97897ca9, Offset: 0x268
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace pitch_and_yaw_meters/pitch_and_yaw_meters
// Params 1, eflags: 0x0
// Checksum 0x2922fed6, Offset: 0x290
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace pitch_and_yaw_meters/pitch_and_yaw_meters
// Params 1, eflags: 0x0
// Checksum 0x97726289, Offset: 0x2b8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

