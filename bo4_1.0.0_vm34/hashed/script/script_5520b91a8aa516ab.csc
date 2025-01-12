#using scripts\core_common\lui_shared;

#namespace remote_missile_target_lockon;

// Namespace remote_missile_target_lockon
// Method(s) 8 Total 14
class cremote_missile_target_lockon : cluielem {

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0xb4597367, Offset: 0x3e8
    // Size: 0x30
    function set_target_locked(localclientnum, value) {
        set_data(localclientnum, "target_locked", value);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 2, eflags: 0x0
    // Checksum 0x127100a5, Offset: 0x3b0
    // Size: 0x30
    function set_clientnum(localclientnum, value) {
        set_data(localclientnum, "clientnum", value);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 1, eflags: 0x0
    // Checksum 0xe19e941f, Offset: 0x378
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"remote_missile_target_lockon");
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 1, eflags: 0x0
    // Checksum 0xaa2edb04, Offset: 0x310
    // Size: 0x5c
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "clientnum", 0);
        set_data(localclientnum, "target_locked", 0);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 1, eflags: 0x0
    // Checksum 0xba738db8, Offset: 0x2e0
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cremote_missile_target_lockon/remote_missile_target_lockon
    // Params 3, eflags: 0x0
    // Checksum 0xd042a7f2, Offset: 0x250
    // Size: 0x84
    function setup_clientfields(uid, var_13af07a1, var_8f126a66) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("clientnum", 1, 6, "int", var_13af07a1);
        cluielem::add_clientfield("target_locked", 1, 1, "int", var_8f126a66);
    }

}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 3, eflags: 0x0
// Checksum 0x8cbafe6a, Offset: 0xb0
// Size: 0x58
function register(uid, var_13af07a1, var_8f126a66) {
    elem = new cremote_missile_target_lockon();
    [[ elem ]]->setup_clientfields(uid, var_13af07a1, var_8f126a66);
    return elem;
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 1, eflags: 0x0
// Checksum 0x7a1cf837, Offset: 0x110
// Size: 0x40
function register_clientside(uid) {
    elem = new cremote_missile_target_lockon();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 1, eflags: 0x0
// Checksum 0xdc6eb524, Offset: 0x158
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 1, eflags: 0x0
// Checksum 0xd870f70b, Offset: 0x180
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 1, eflags: 0x0
// Checksum 0x29ba30a1, Offset: 0x1a8
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0xec806b7d, Offset: 0x1d0
// Size: 0x28
function set_clientnum(localclientnum, value) {
    [[ self ]]->set_clientnum(localclientnum, value);
}

// Namespace remote_missile_target_lockon/remote_missile_target_lockon
// Params 2, eflags: 0x0
// Checksum 0xf7327c69, Offset: 0x200
// Size: 0x28
function set_target_locked(localclientnum, value) {
    [[ self ]]->set_target_locked(localclientnum, value);
}

