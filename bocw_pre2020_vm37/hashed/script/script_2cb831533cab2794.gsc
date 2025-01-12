#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace zm_hint_text;

// Namespace zm_hint_text
// Method(s) 7 Total 14
class czm_hint_text : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace czm_hint_text/zm_hint_text
    // Params 2, eflags: 0x1 linked
    // Checksum 0x3dfc2a63, Offset: 0x298
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 1, eflags: 0x1 linked
    // Checksum 0x94ab4cc0, Offset: 0x2e0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc31af001, Offset: 0x220
    // Size: 0x6c
    function setup_clientfields() {
        cluielem::setup_clientfields("zm_hint_text");
        cluielem::add_clientfield("_state", 1, 1, "int");
        cluielem::function_dcb34c80("string", "text", 1);
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 2, eflags: 0x1 linked
    // Checksum 0xec2be2c2, Offset: 0x3e8
    // Size: 0x44
    function set_text(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "text", value);
    }

    // Namespace czm_hint_text/zm_hint_text
    // Params 2, eflags: 0x1 linked
    // Checksum 0xa140e907, Offset: 0x310
    // Size: 0xcc
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 0);
            return;
        }
        if (#"visible" == state_name) {
            player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "_state", 1);
            return;
        }
        assertmsg("<dev string:x38>");
    }

}

// Namespace zm_hint_text/zm_hint_text
// Params 0, eflags: 0x1 linked
// Checksum 0xe8dae756, Offset: 0xd0
// Size: 0x34
function register() {
    elem = new czm_hint_text();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace zm_hint_text/zm_hint_text
// Params 2, eflags: 0x1 linked
// Checksum 0xf9df25c3, Offset: 0x110
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace zm_hint_text/zm_hint_text
// Params 1, eflags: 0x1 linked
// Checksum 0x94bac228, Offset: 0x150
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace zm_hint_text/zm_hint_text
// Params 1, eflags: 0x1 linked
// Checksum 0x2ab077a3, Offset: 0x178
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace zm_hint_text/zm_hint_text
// Params 2, eflags: 0x1 linked
// Checksum 0x6c46f716, Offset: 0x1a0
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

// Namespace zm_hint_text/zm_hint_text
// Params 2, eflags: 0x1 linked
// Checksum 0xa6f92b9f, Offset: 0x1d0
// Size: 0x28
function set_text(player, value) {
    [[ self ]]->set_text(player, value);
}
