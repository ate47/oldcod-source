#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace remote_missile_target_lockon;

// Namespace remote_missile_target_lockon
// Method(s) 7 Total 14
class cremote_missile_target_lockon : cluielem {

    var var_57a3d576;

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x4429995, Offset: 0x378
    // Size: 0x3c
    function set_target_locked(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "target_locked", value);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x8e098d22, Offset: 0x330
    // Size: 0x3c
    function set_clientnum(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "clientnum", value);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 1, eflags: 0x0
    // Checksum 0xf00218ba, Offset: 0x300
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0xc5b38d33, Offset: 0x2b0
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "remote_missile_target_lockon", persistent);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 1, eflags: 0x0
    // Checksum 0xdea5f25b, Offset: 0x230
    // Size: 0x74
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("clientnum", 1, 6, "int");
        cluielem::add_clientfield("target_locked", 1, 1, "int");
    }

}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 1, eflags: 0x0
// Checksum 0x71bd38e7, Offset: 0xd8
// Size: 0x40
function register(uid) {
    elem = new cremote_missile_target_lockon();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0xb7ec82cd, Offset: 0x120
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 1, eflags: 0x0
// Checksum 0x84389f84, Offset: 0x160
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 1, eflags: 0x0
// Checksum 0x68ac7131, Offset: 0x188
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0xf5874cac, Offset: 0x1b0
// Size: 0x28
function set_clientnum(player, value) {
    [[ self ]]->set_clientnum(player, value);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0xa6df154, Offset: 0x1e0
// Size: 0x28
function set_target_locked(player, value) {
    [[ self ]]->set_target_locked(player, value);
}

