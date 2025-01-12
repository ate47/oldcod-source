#using scripts\core_common\lui_shared;

#namespace lui_plane_mortar;

// Namespace lui_plane_mortar
// Method(s) 7 Total 14
class class_37d61ee3 : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 2, eflags: 0x1 linked
    // Checksum 0x738c8eaf, Offset: 0x228
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5cd2c0ff, Offset: 0x270
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 2, eflags: 0x1 linked
    // Checksum 0xef0b8316, Offset: 0x2a0
    // Size: 0x54
    function function_6c69ff4b(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 1, value, 1);
    }

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 0, eflags: 0x1 linked
    // Checksum 0x445f89d3, Offset: 0x200
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("lui_plane_mortar");
    }

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 2, eflags: 0x1 linked
    // Checksum 0x84b36b84, Offset: 0x300
    // Size: 0x54
    function function_b172c58e(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 2, value, 1);
    }

}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 0, eflags: 0x0
// Checksum 0x942ce228, Offset: 0xb0
// Size: 0x34
function register() {
    elem = new class_37d61ee3();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 2, eflags: 0x0
// Checksum 0x2d020860, Offset: 0xf0
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 1, eflags: 0x0
// Checksum 0xfd201144, Offset: 0x130
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 1, eflags: 0x0
// Checksum 0xc0142567, Offset: 0x158
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 2, eflags: 0x0
// Checksum 0x41dadfef, Offset: 0x180
// Size: 0x28
function function_6c69ff4b(player, value) {
    [[ self ]]->function_6c69ff4b(player, value);
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 2, eflags: 0x0
// Checksum 0x29a60f3d, Offset: 0x1b0
// Size: 0x28
function function_b172c58e(player, value) {
    [[ self ]]->function_b172c58e(player, value);
}

