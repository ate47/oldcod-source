#using scripts\core_common\lui_shared;

#namespace lui_plane_mortar;

// Namespace lui_plane_mortar
// Method(s) 7 Total 14
class class_37d61ee3 : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 2, eflags: 0x0
    // Checksum 0xffa8cf8b, Offset: 0x228
    // Size: 0x3c
    function open(player, flags = 0) {
        cluielem::open_luielem(player, flags);
    }

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 1, eflags: 0x0
    // Checksum 0x4260041b, Offset: 0x270
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 2, eflags: 0x0
    // Checksum 0x5dabeaba, Offset: 0x2a0
    // Size: 0x54
    function function_6c69ff4b(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 1, value, 1);
    }

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 0, eflags: 0x0
    // Checksum 0xe86892f8, Offset: 0x200
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("lui_plane_mortar");
    }

    // Namespace namespace_37d61ee3/lui_plane_mortar
    // Params 2, eflags: 0x0
    // Checksum 0x6a827a2b, Offset: 0x300
    // Size: 0x54
    function function_b172c58e(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 2, value, 1);
    }

}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 0, eflags: 0x0
// Checksum 0xd5ba851c, Offset: 0xb0
// Size: 0x34
function register() {
    elem = new class_37d61ee3();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 2, eflags: 0x0
// Checksum 0xe1ba103e, Offset: 0xf0
// Size: 0x38
function open(player, flags = 0) {
    [[ self ]]->open(player, flags);
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 1, eflags: 0x0
// Checksum 0xf38863ea, Offset: 0x130
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 1, eflags: 0x0
// Checksum 0xa304d7b3, Offset: 0x158
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 2, eflags: 0x0
// Checksum 0xc614ed48, Offset: 0x180
// Size: 0x28
function function_6c69ff4b(player, value) {
    [[ self ]]->function_6c69ff4b(player, value);
}

// Namespace lui_plane_mortar/lui_plane_mortar
// Params 2, eflags: 0x0
// Checksum 0x15fc4d73, Offset: 0x1b0
// Size: 0x28
function function_b172c58e(player, value) {
    [[ self ]]->function_b172c58e(player, value);
}

