#using scripts\core_common\lui_shared;

#namespace seeker_mine_prompt;

// Namespace seeker_mine_prompt
// Method(s) 8 Total 14
class cseeker_mine_prompt : cluielem {

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 2, eflags: 0x0
    // Checksum 0x92f0379a, Offset: 0x3f8
    // Size: 0x30
    function set_promptstate(localclientnum, value) {
        set_data(localclientnum, "promptState", value);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xcdd8862, Offset: 0x3c0
    // Size: 0x30
    function set_progress(localclientnum, value) {
        set_data(localclientnum, "progress", value);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 1, eflags: 0x0
    // Checksum 0x63dc66d4, Offset: 0x388
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"seeker_mine_prompt");
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 1, eflags: 0x0
    // Checksum 0xbfc4929c, Offset: 0x318
    // Size: 0x64
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_data(localclientnum, "progress", 0);
        set_data(localclientnum, "promptState", 0);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 1, eflags: 0x0
    // Checksum 0xee68b399, Offset: 0x2e8
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 3, eflags: 0x0
    // Checksum 0x90c01939, Offset: 0x258
    // Size: 0x84
    function setup_clientfields(uid, progresscallback, var_19c23f0b) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("progress", 1, 5, "float", progresscallback);
        cluielem::add_clientfield("promptState", 1, 2, "int", var_19c23f0b);
    }

}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 3, eflags: 0x0
// Checksum 0x96c43741, Offset: 0xb8
// Size: 0x58
function register(uid, progresscallback, var_19c23f0b) {
    elem = new cseeker_mine_prompt();
    [[ elem ]]->setup_clientfields(uid, progresscallback, var_19c23f0b);
    return elem;
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 1, eflags: 0x0
// Checksum 0x186b3a4b, Offset: 0x118
// Size: 0x40
function register_clientside(uid) {
    elem = new cseeker_mine_prompt();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 1, eflags: 0x0
// Checksum 0xf375be93, Offset: 0x160
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 1, eflags: 0x0
// Checksum 0x6f433510, Offset: 0x188
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 1, eflags: 0x0
// Checksum 0xdd1cdf4e, Offset: 0x1b0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 2, eflags: 0x0
// Checksum 0x6d2ce3f3, Offset: 0x1d8
// Size: 0x28
function set_progress(localclientnum, value) {
    [[ self ]]->set_progress(localclientnum, value);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 2, eflags: 0x0
// Checksum 0xf695a131, Offset: 0x208
// Size: 0x28
function set_promptstate(localclientnum, value) {
    [[ self ]]->set_promptstate(localclientnum, value);
}

