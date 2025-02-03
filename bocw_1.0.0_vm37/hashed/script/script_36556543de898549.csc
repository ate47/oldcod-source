#using scripts\core_common\lui_shared;

#namespace seeker_mine_prompt;

// Namespace seeker_mine_prompt
// Method(s) 8 Total 15
class cseeker_mine_prompt : cluielem {

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 1, eflags: 0x0
    // Checksum 0xcc30b24e, Offset: 0x4b8
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 0, eflags: 0x0
    // Checksum 0x9e1357bd, Offset: 0x420
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("seeker_mine_prompt");
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xba10ebc8, Offset: 0x398
    // Size: 0x7c
    function setup_clientfields(progresscallback, var_ca3086f0) {
        cluielem::setup_clientfields("seeker_mine_prompt");
        cluielem::add_clientfield("progress", 1, 5, "float", progresscallback);
        cluielem::add_clientfield("promptState", 1, 2, "int", var_ca3086f0);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xe018df24, Offset: 0x4e8
    // Size: 0x30
    function set_progress(localclientnum, value) {
        set_data(localclientnum, "progress", value);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 2, eflags: 0x0
    // Checksum 0xef540739, Offset: 0x520
    // Size: 0x30
    function set_promptstate(localclientnum, value) {
        set_data(localclientnum, "promptState", value);
    }

    // Namespace cseeker_mine_prompt/seeker_mine_prompt
    // Params 1, eflags: 0x0
    // Checksum 0xd6bbf346, Offset: 0x448
    // Size: 0x64
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_data(localclientnum, "progress", 0);
        set_data(localclientnum, "promptState", 0);
    }

}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 2, eflags: 0x0
// Checksum 0xf7c7dd47, Offset: 0xd8
// Size: 0x17e
function register(progresscallback, var_ca3086f0) {
    elem = new cseeker_mine_prompt();
    [[ elem ]]->setup_clientfields(progresscallback, var_ca3086f0);
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"seeker_mine_prompt"])) {
        level.var_ae746e8f[#"seeker_mine_prompt"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"seeker_mine_prompt"])) {
        level.var_ae746e8f[#"seeker_mine_prompt"] = [];
    } else if (!isarray(level.var_ae746e8f[#"seeker_mine_prompt"])) {
        level.var_ae746e8f[#"seeker_mine_prompt"] = array(level.var_ae746e8f[#"seeker_mine_prompt"]);
    }
    level.var_ae746e8f[#"seeker_mine_prompt"][level.var_ae746e8f[#"seeker_mine_prompt"].size] = elem;
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 0, eflags: 0x0
// Checksum 0x83ce26e1, Offset: 0x260
// Size: 0x34
function register_clientside() {
    elem = new cseeker_mine_prompt();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 1, eflags: 0x0
// Checksum 0x1e090b3c, Offset: 0x2a0
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 1, eflags: 0x0
// Checksum 0x3286b065, Offset: 0x2c8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 1, eflags: 0x0
// Checksum 0x8b9b9b30, Offset: 0x2f0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 2, eflags: 0x0
// Checksum 0xd77a1202, Offset: 0x318
// Size: 0x28
function set_progress(localclientnum, value) {
    [[ self ]]->set_progress(localclientnum, value);
}

// Namespace seeker_mine_prompt/seeker_mine_prompt
// Params 2, eflags: 0x0
// Checksum 0x86e1cb06, Offset: 0x348
// Size: 0x28
function set_promptstate(localclientnum, value) {
    [[ self ]]->set_promptstate(localclientnum, value);
}

