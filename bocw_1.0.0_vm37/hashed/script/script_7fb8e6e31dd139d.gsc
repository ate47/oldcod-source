#using scripts\core_common\lui_shared;

#namespace mp_prop_controls;

// Namespace mp_prop_controls
// Method(s) 5 Total 12
class cmp_prop_controls : cluielem {

    // Namespace cmp_prop_controls/mp_prop_controls
    // Params 2, eflags: 0x0
    // Checksum 0x21f3bf55, Offset: 0x1c8
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cmp_prop_controls/mp_prop_controls
    // Params 1, eflags: 0x0
    // Checksum 0x9f52c185, Offset: 0x210
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cmp_prop_controls/mp_prop_controls
    // Params 0, eflags: 0x0
    // Checksum 0xb08a40c3, Offset: 0x1a0
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("mp_prop_controls");
    }

}

// Namespace mp_prop_controls/mp_prop_controls
// Params 0, eflags: 0x0
// Checksum 0xa4e388ae, Offset: 0xb0
// Size: 0x34
function register() {
    elem = new cmp_prop_controls();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace mp_prop_controls/mp_prop_controls
// Params 2, eflags: 0x0
// Checksum 0xe1ba103e, Offset: 0xf0
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace mp_prop_controls/mp_prop_controls
// Params 1, eflags: 0x0
// Checksum 0xf38863ea, Offset: 0x130
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace mp_prop_controls/mp_prop_controls
// Params 1, eflags: 0x0
// Checksum 0xa304d7b3, Offset: 0x158
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

