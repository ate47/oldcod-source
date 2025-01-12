#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_hint_text;

// Namespace zm_hint_text
// Method(s) 7 Total 14
class czm_hint_text : cluielem {

    var var_57a3d576;

    // Namespace czm_hint_text/zm_hint_text
    // Params 2, eflags: 0x0
    // Checksum 0xde259a38, Offset: 0x3e0
    // Size: 0x3c
    function set_text(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "text", value);
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 2, eflags: 0x0
    // Checksum 0xbbd6126f, Offset: 0x318
    // Size: 0xbc
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 0);
            return;
        }
        if (#"visible" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 1);
            return;
        }
        assertmsg("<dev string:x30>");
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 1, eflags: 0x0
    // Checksum 0x171a5331, Offset: 0x2e8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 2, eflags: 0x0
    // Checksum 0x2ac517a3, Offset: 0x298
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "zm_hint_text", persistent);
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 1, eflags: 0x0
    // Checksum 0xf95e9673, Offset: 0x218
    // Size: 0x74
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::function_52818084("string", "text", 1);
    }

}

// Namespace zm_hint_text/zm_hint_text
// Params 1, eflags: 0x0
// Checksum 0xbc789d7a, Offset: 0xc0
// Size: 0x40
function register(uid) {
    elem = new czm_hint_text();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace zm_hint_text/zm_hint_text
// Params 2, eflags: 0x0
// Checksum 0x8b81270c, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_hint_text/zm_hint_text
// Params 1, eflags: 0x0
// Checksum 0xd2208d4a, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_hint_text/zm_hint_text
// Params 1, eflags: 0x0
// Checksum 0x8d3c3ce4, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace zm_hint_text/zm_hint_text
// Params 2, eflags: 0x0
// Checksum 0x63ea2275, Offset: 0x198
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace zm_hint_text/zm_hint_text
// Params 2, eflags: 0x0
// Checksum 0x62a42063, Offset: 0x1c8
// Size: 0x28
function set_text(player, value) {
    [[ self ]]->set_text(player, value);
}

