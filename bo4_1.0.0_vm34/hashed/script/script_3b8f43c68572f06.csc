#using scripts\core_common\lui_shared;

#namespace revive_hud;

// Namespace revive_hud
// Method(s) 9 Total 15
class crevive_hud : cluielem {

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0x66f675a, Offset: 0x4c0
    // Size: 0x30
    function set_fadetime(localclientnum, value) {
        set_data(localclientnum, "fadeTime", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0x41f869e6, Offset: 0x488
    // Size: 0x30
    function set_clientnum(localclientnum, value) {
        set_data(localclientnum, "clientNum", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 2, eflags: 0x0
    // Checksum 0x49492717, Offset: 0x450
    // Size: 0x30
    function set_text(localclientnum, value) {
        set_data(localclientnum, "text", value);
    }

    // Namespace crevive_hud/revive_hud
    // Params 1, eflags: 0x0
    // Checksum 0xb1a8f592, Offset: 0x418
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"revive_hud");
    }

    // Namespace crevive_hud/revive_hud
    // Params 1, eflags: 0x0
    // Checksum 0x8263a101, Offset: 0x388
    // Size: 0x84
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "text", #"");
        set_data(localclientnum, "clientNum", 0);
        set_data(localclientnum, "fadeTime", 0);
    }

    // Namespace crevive_hud/revive_hud
    // Params 1, eflags: 0x0
    // Checksum 0xd0d8e6fb, Offset: 0x358
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace crevive_hud/revive_hud
    // Params 4, eflags: 0x0
    // Checksum 0x2a77f84f, Offset: 0x298
    // Size: 0xb4
    function setup_clientfields(uid, textcallback, var_13af07a1, var_b3fd9949) {
        cluielem::setup_clientfields(uid);
        cluielem::function_52818084("string", "text", 1);
        cluielem::add_clientfield("clientNum", 1, 6, "int", var_13af07a1);
        cluielem::add_clientfield("fadeTime", 1, 5, "int", var_b3fd9949);
    }

}

// Namespace revive_hud/revive_hud
// Params 4, eflags: 0x0
// Checksum 0x2f3098e5, Offset: 0xb8
// Size: 0x64
function register(uid, textcallback, var_13af07a1, var_b3fd9949) {
    elem = new crevive_hud();
    [[ elem ]]->setup_clientfields(uid, textcallback, var_13af07a1, var_b3fd9949);
    return elem;
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0xa708d3d7, Offset: 0x128
// Size: 0x40
function register_clientside(uid) {
    elem = new crevive_hud();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0xb4b7ba73, Offset: 0x170
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0x103963f0, Offset: 0x198
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace revive_hud/revive_hud
// Params 1, eflags: 0x0
// Checksum 0xdede0262, Offset: 0x1c0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0x7fa12bf7, Offset: 0x1e8
// Size: 0x28
function set_text(localclientnum, value) {
    [[ self ]]->set_text(localclientnum, value);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0x28dfd79c, Offset: 0x218
// Size: 0x28
function set_clientnum(localclientnum, value) {
    [[ self ]]->set_clientnum(localclientnum, value);
}

// Namespace revive_hud/revive_hud
// Params 2, eflags: 0x0
// Checksum 0xf4b3f4e6, Offset: 0x248
// Size: 0x28
function set_fadetime(localclientnum, value) {
    [[ self ]]->set_fadetime(localclientnum, value);
}

