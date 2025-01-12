#using scripts\core_common\lui_shared;

#namespace interactive_shot;

// Namespace interactive_shot
// Method(s) 7 Total 13
class cinteractive_shot : cluielem {

    // Namespace cinteractive_shot/interactive_shot
    // Params 2, eflags: 0x0
    // Checksum 0x1b256912, Offset: 0x328
    // Size: 0x30
    function set_text(localclientnum, value) {
        set_data(localclientnum, "text", value);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 1, eflags: 0x0
    // Checksum 0xfb1c15bb, Offset: 0x2f0
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"interactive_shot");
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 1, eflags: 0x0
    // Checksum 0xf06a9a76, Offset: 0x298
    // Size: 0x4c
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "text", #"");
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 1, eflags: 0x0
    // Checksum 0xd7f945f7, Offset: 0x268
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cinteractive_shot/interactive_shot
    // Params 2, eflags: 0x0
    // Checksum 0x368525e4, Offset: 0x208
    // Size: 0x54
    function setup_clientfields(uid, textcallback) {
        cluielem::setup_clientfields(uid);
        cluielem::function_52818084("string", "text", 1);
    }

}

// Namespace interactive_shot/interactive_shot
// Params 2, eflags: 0x0
// Checksum 0x6efefc66, Offset: 0xa0
// Size: 0x4c
function register(uid, textcallback) {
    elem = new cinteractive_shot();
    [[ elem ]]->setup_clientfields(uid, textcallback);
    return elem;
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0xef0f2723, Offset: 0xf8
// Size: 0x40
function register_clientside(uid) {
    elem = new cinteractive_shot();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0x249969ba, Offset: 0x140
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0xe9ad264c, Offset: 0x168
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace interactive_shot/interactive_shot
// Params 1, eflags: 0x0
// Checksum 0x67676746, Offset: 0x190
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace interactive_shot/interactive_shot
// Params 2, eflags: 0x0
// Checksum 0x7d45412d, Offset: 0x1b8
// Size: 0x28
function set_text(localclientnum, value) {
    [[ self ]]->set_text(localclientnum, value);
}

