#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace spectrerisingindicator;

// Namespace spectrerisingindicator
// Method(s) 7 Total 14
class cspectrerisingindicator : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cspectrerisingindicator/spectrerisingindicator
    // Params 2, eflags: 0x0
    // Checksum 0x60669baf, Offset: 0x2a0
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cspectrerisingindicator/spectrerisingindicator
    // Params 2, eflags: 0x0
    // Checksum 0xb7a22836, Offset: 0x318
    // Size: 0x44
    function set_clientnum(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "clientnum", value);
    }

    // Namespace cspectrerisingindicator/spectrerisingindicator
    // Params 1, eflags: 0x0
    // Checksum 0x4c735f6, Offset: 0x2e8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cspectrerisingindicator/spectrerisingindicator
    // Params 2, eflags: 0x0
    // Checksum 0xdd6eaee5, Offset: 0x368
    // Size: 0x44
    function set_isalive(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "isAlive", value);
    }

    // Namespace cspectrerisingindicator/spectrerisingindicator
    // Params 0, eflags: 0x0
    // Checksum 0xc18ce90f, Offset: 0x228
    // Size: 0x6c
    function setup_clientfields() {
        cluielem::setup_clientfields("SpectreRisingIndicator");
        cluielem::add_clientfield("clientnum", 1, 7, "int");
        cluielem::add_clientfield("isAlive", 1, 1, "int");
    }

}

// Namespace spectrerisingindicator/spectrerisingindicator
// Params 0, eflags: 0x0
// Checksum 0x33485a6a, Offset: 0xd8
// Size: 0x34
function register() {
    elem = new cspectrerisingindicator();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace spectrerisingindicator/spectrerisingindicator
// Params 2, eflags: 0x0
// Checksum 0xca2e1c40, Offset: 0x118
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace spectrerisingindicator/spectrerisingindicator
// Params 1, eflags: 0x0
// Checksum 0x7c7778f0, Offset: 0x158
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace spectrerisingindicator/spectrerisingindicator
// Params 1, eflags: 0x0
// Checksum 0xa2ef2991, Offset: 0x180
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace spectrerisingindicator/spectrerisingindicator
// Params 2, eflags: 0x0
// Checksum 0x4e0be2ad, Offset: 0x1a8
// Size: 0x28
function set_clientnum(player, value) {
    [[ self ]]->set_clientnum(player, value);
}

// Namespace spectrerisingindicator/spectrerisingindicator
// Params 2, eflags: 0x0
// Checksum 0xe9da86e5, Offset: 0x1d8
// Size: 0x28
function set_isalive(player, value) {
    [[ self ]]->set_isalive(player, value);
}

