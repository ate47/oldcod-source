#using scripts\core_common\lui_shared;

#namespace prototype_self_revive;

// Namespace prototype_self_revive
// Method(s) 5 Total 12
class cprototype_self_revive : cluielem {

    // Namespace cprototype_self_revive/prototype_self_revive
    // Params 2, eflags: 0x0
    // Checksum 0x3557280c, Offset: 0x1c8
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace cprototype_self_revive/prototype_self_revive
    // Params 1, eflags: 0x0
    // Checksum 0x2f0729fa, Offset: 0x210
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cprototype_self_revive/prototype_self_revive
    // Params 0, eflags: 0x0
    // Checksum 0x29a33c2c, Offset: 0x1a0
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("prototype_self_revive");
    }

}

// Namespace prototype_self_revive/prototype_self_revive
// Params 0, eflags: 0x0
// Checksum 0x94230dc8, Offset: 0xb0
// Size: 0x34
function register() {
    elem = new cprototype_self_revive();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace prototype_self_revive/prototype_self_revive
// Params 2, eflags: 0x0
// Checksum 0x696041e, Offset: 0xf0
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace prototype_self_revive/prototype_self_revive
// Params 1, eflags: 0x0
// Checksum 0x72df0a5e, Offset: 0x130
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace prototype_self_revive/prototype_self_revive
// Params 1, eflags: 0x0
// Checksum 0xc1ffdb45, Offset: 0x158
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

