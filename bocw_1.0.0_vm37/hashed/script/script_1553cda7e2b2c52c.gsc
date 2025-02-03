#using scripts\core_common\lui_shared;

#namespace pitch_and_yaw_meters;

// Namespace pitch_and_yaw_meters
// Method(s) 5 Total 12
class class_98cc868d : cluielem {

    // Namespace namespace_98cc868d/pitch_and_yaw_meters
    // Params 2, eflags: 0x0
    // Checksum 0x1ff56522, Offset: 0x1c8
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace namespace_98cc868d/pitch_and_yaw_meters
    // Params 1, eflags: 0x0
    // Checksum 0xa1293454, Offset: 0x210
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_98cc868d/pitch_and_yaw_meters
    // Params 0, eflags: 0x0
    // Checksum 0xc8b8e3c2, Offset: 0x1a0
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("pitch_and_yaw_meters");
    }

}

// Namespace pitch_and_yaw_meters/pitch_and_yaw_meters
// Params 0, eflags: 0x0
// Checksum 0xba8b6078, Offset: 0xb0
// Size: 0x34
function register() {
    elem = new class_98cc868d();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace pitch_and_yaw_meters/pitch_and_yaw_meters
// Params 2, eflags: 0x0
// Checksum 0x1ea1c28, Offset: 0xf0
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace pitch_and_yaw_meters/pitch_and_yaw_meters
// Params 1, eflags: 0x0
// Checksum 0x2063d43a, Offset: 0x130
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace pitch_and_yaw_meters/pitch_and_yaw_meters
// Params 1, eflags: 0x0
// Checksum 0x71e5d92b, Offset: 0x158
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

