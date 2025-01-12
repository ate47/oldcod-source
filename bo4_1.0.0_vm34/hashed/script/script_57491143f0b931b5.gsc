#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace seeker_mine_prompt;

// Namespace seeker_mine_prompt
// Method(s) 7 Total 14
class cseeker_mine_prompt : cluielem {

    var var_57a3d576;

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x92897d81, Offset: 0x370
    // Size: 0x3c
    function set_promptstate(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "promptState", value);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x39026504, Offset: 0x328
    // Size: 0x3c
    function set_progress(player, value) {
        player clientfield::function_8fe7322a(var_57a3d576, "progress", value);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x88eafe85, Offset: 0x2f8
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xe2a1b536, Offset: 0x2a8
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "seeker_mine_prompt", persistent);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x7a8b192e, Offset: 0x228
    // Size: 0x74
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("progress", 1, 5, "float");
        cluielem::add_clientfield("promptState", 1, 2, "int");
    }

}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 1, eflags: 0x0
// Checksum 0x609f8b45, Offset: 0xd0
// Size: 0x40
function register(uid) {
    elem = new cseeker_mine_prompt();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 2, eflags: 0x0
// Checksum 0x8ef58c71, Offset: 0x118
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 1, eflags: 0x0
// Checksum 0xdfa1dc46, Offset: 0x158
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 1, eflags: 0x0
// Checksum 0xe722cc67, Offset: 0x180
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 2, eflags: 0x0
// Checksum 0xc35ef490, Offset: 0x1a8
// Size: 0x28
function set_progress(player, value) {
    [[ self ]]->set_progress(player, value);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 2, eflags: 0x0
// Checksum 0x208290dd, Offset: 0x1d8
// Size: 0x28
function set_promptstate(player, value) {
    [[ self ]]->set_promptstate(player, value);
}

