#using scripts\core_common\lui_shared;

#namespace lui_napalm_strike;

// Namespace lui_napalm_strike
// Method(s) 5 Total 12
class clui_napalm_strike : cluielem {

    // Namespace clui_napalm_strike/lui_napalm_strike
    // Params 2, eflags: 0x0
    // Checksum 0x7f7e7ed, Offset: 0x1c8
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace clui_napalm_strike/lui_napalm_strike
    // Params 1, eflags: 0x0
    // Checksum 0xabe80dbe, Offset: 0x210
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace clui_napalm_strike/lui_napalm_strike
    // Params 0, eflags: 0x0
    // Checksum 0x64c9dfac, Offset: 0x1a0
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("lui_napalm_strike");
    }

}

// Namespace lui_napalm_strike/lui_napalm_strike
// Params 0, eflags: 0x0
// Checksum 0x160881b0, Offset: 0xb0
// Size: 0x34
function register() {
    elem = new clui_napalm_strike();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace lui_napalm_strike/lui_napalm_strike
// Params 2, eflags: 0x0
// Checksum 0xcdc7ef18, Offset: 0xf0
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace lui_napalm_strike/lui_napalm_strike
// Params 1, eflags: 0x0
// Checksum 0x16d8a484, Offset: 0x130
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace lui_napalm_strike/lui_napalm_strike
// Params 1, eflags: 0x0
// Checksum 0x2cbda683, Offset: 0x158
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

