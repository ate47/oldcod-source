#using scripts\core_common\lui_shared;

#namespace remote_missile_target_lockon;

// Namespace remote_missile_target_lockon
// Method(s) 10 Total 17
class cremote_missile_target_lockon : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x75614167, Offset: 0x2c0
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x6723e44d, Offset: 0x390
    // Size: 0x4c
    function set_target_locked(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 2, value, 0);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x18831989, Offset: 0x338
    // Size: 0x4c
    function set_clientnum(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 1, value, 0);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0xbf3bcf58, Offset: 0x3e8
    // Size: 0x4c
    function set_ishawktag(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 3, value, 0);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 1, eflags: 0x0
    // Checksum 0x67936e3d, Offset: 0x308
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x29f8b34f, Offset: 0x498
    // Size: 0x4c
    function function_7c227f6d(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 5, value, 0);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 0, eflags: 0x0
    // Checksum 0xa7147799, Offset: 0x298
    // Size: 0x1c
    function setup_clientfields() {
        cluielem::setup_clientfields("remote_missile_target_lockon");
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x2822ebd, Offset: 0x440
    // Size: 0x4c
    function set_killed(player, value) {
        player lui::function_bb6bcb89(hash(var_d5213cbb), var_bf9c8c95, 4, value, 0);
    }

}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 0, eflags: 0x0
// Checksum 0x3c31335e, Offset: 0xb8
// Size: 0x34
function register() {
    elem = new cremote_missile_target_lockon();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0xcd520476, Offset: 0xf8
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 1, eflags: 0x0
// Checksum 0x2ecba694, Offset: 0x138
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 1, eflags: 0x0
// Checksum 0x12f52bff, Offset: 0x160
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0x7c8223e6, Offset: 0x188
// Size: 0x28
function set_clientnum(player, value) {
    [[ self ]]->set_clientnum(player, value);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0x9574fccf, Offset: 0x1b8
// Size: 0x28
function set_target_locked(player, value) {
    [[ self ]]->set_target_locked(player, value);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0xf5ad0c1e, Offset: 0x1e8
// Size: 0x28
function set_ishawktag(player, value) {
    [[ self ]]->set_ishawktag(player, value);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0x994bc917, Offset: 0x218
// Size: 0x28
function set_killed(player, value) {
    [[ self ]]->set_killed(player, value);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0x36dbac87, Offset: 0x248
// Size: 0x28
function function_7c227f6d(player, value) {
    [[ self ]]->function_7c227f6d(player, value);
}

