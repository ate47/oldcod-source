#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace seeker_mine_prompt;

// Namespace seeker_mine_prompt
// Method(s) 7 Total 14
class cseeker_mine_prompt : cluielem {

    var var_bf9c8c95;
    var var_d5213cbb;

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x60669baf, Offset: 0x2a8
    // Size: 0x3c
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, persistent);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x4c735f6, Offset: 0x2f0
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 0, eflags: 0x0
    // Checksum 0x7933559b, Offset: 0x230
    // Size: 0x6c
    function setup_clientfields() {
        cluielem::setup_clientfields("seeker_mine_prompt");
        cluielem::add_clientfield("progress", 1, 5, "float");
        cluielem::add_clientfield("promptState", 1, 2, "int");
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x1f02c9be, Offset: 0x320
    // Size: 0x44
    function set_progress(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "progress", value);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xa316e643, Offset: 0x370
    // Size: 0x44
    function set_promptstate(player, value) {
        player clientfield::function_9bf78ef8(var_d5213cbb, var_bf9c8c95, "promptState", value);
    }

}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 0, eflags: 0x0
// Checksum 0x8ed9645a, Offset: 0xe0
// Size: 0x34
function register() {
    elem = new cseeker_mine_prompt();
    [[ elem ]]->setup_clientfields();
    return elem;
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 2, eflags: 0x0
// Checksum 0xca2e1c40, Offset: 0x120
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 1, eflags: 0x0
// Checksum 0x7c7778f0, Offset: 0x160
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 1, eflags: 0x0
// Checksum 0xa2ef2991, Offset: 0x188
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_7bfd10e6(player);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 2, eflags: 0x0
// Checksum 0x9c488b6e, Offset: 0x1b0
// Size: 0x28
function set_progress(player, value) {
    [[ self ]]->set_progress(player, value);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 2, eflags: 0x0
// Checksum 0x69b15d5c, Offset: 0x1e0
// Size: 0x28
function set_promptstate(player, value) {
    [[ self ]]->set_promptstate(player, value);
}

