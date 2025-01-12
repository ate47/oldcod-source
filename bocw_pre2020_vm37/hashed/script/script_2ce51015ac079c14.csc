#using scripts\core_common\lui_shared;

#namespace player_insertion_choice;

// Namespace player_insertion_choice
// Method(s) 7 Total 13
class cplayer_insertion_choice : cluielem {

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 1, eflags: 0x0
    // Checksum 0x7b67cf17, Offset: 0x410
    // Size: 0x24
    function open(localclientnum) {
        cluielem::open(localclientnum);
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 0, eflags: 0x0
    // Checksum 0x95bb87df, Offset: 0x398
    // Size: 0x1c
    function register_clientside() {
        cluielem::register_clientside("player_insertion_choice");
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 0, eflags: 0x0
    // Checksum 0x46ae02ba, Offset: 0x348
    // Size: 0x44
    function setup_clientfields() {
        cluielem::setup_clientfields("player_insertion_choice");
        cluielem::add_clientfield("_state", 1, 2, "int");
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 2, eflags: 0x0
    // Checksum 0x6121b37f, Offset: 0x440
    // Size: 0x11c
    function set_state(localclientnum, state_name) {
        if (#"defaultstate" == state_name) {
            set_data(localclientnum, "_state", 0);
            return;
        }
        if (#"groundvehicle" == state_name) {
            set_data(localclientnum, "_state", 1);
            return;
        }
        if (#"halojump" == state_name) {
            set_data(localclientnum, "_state", 2);
            return;
        }
        if (#"heli" == state_name) {
            set_data(localclientnum, "_state", 3);
            return;
        }
        assertmsg("<dev string:x38>");
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 1, eflags: 0x0
    // Checksum 0x7a91f070, Offset: 0x3c0
    // Size: 0x44
    function function_fa582112(localclientnum) {
        cluielem::function_fa582112(localclientnum);
        set_state(localclientnum, #"defaultstate");
    }

}

// Namespace player_insertion_choice/player_insertion_choice
// Params 0, eflags: 0x0
// Checksum 0x43e14697, Offset: 0xc8
// Size: 0x16e
function register() {
    elem = new cplayer_insertion_choice();
    [[ elem ]]->setup_clientfields();
    if (!isdefined(level.var_ae746e8f)) {
        level.var_ae746e8f = associativearray();
    }
    if (!isdefined(level.var_ae746e8f[#"player_insertion_choice"])) {
        level.var_ae746e8f[#"player_insertion_choice"] = [];
    }
    if (!isdefined(level.var_ae746e8f[#"player_insertion_choice"])) {
        level.var_ae746e8f[#"player_insertion_choice"] = [];
    } else if (!isarray(level.var_ae746e8f[#"player_insertion_choice"])) {
        level.var_ae746e8f[#"player_insertion_choice"] = array(level.var_ae746e8f[#"player_insertion_choice"]);
    }
    level.var_ae746e8f[#"player_insertion_choice"][level.var_ae746e8f[#"player_insertion_choice"].size] = elem;
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 0, eflags: 0x0
// Checksum 0xe83024f9, Offset: 0x240
// Size: 0x34
function register_clientside() {
    elem = new cplayer_insertion_choice();
    [[ elem ]]->register_clientside();
    return elem;
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 1, eflags: 0x0
// Checksum 0xb3af6fee, Offset: 0x280
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 1, eflags: 0x0
// Checksum 0x978e69d, Offset: 0x2a8
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 1, eflags: 0x0
// Checksum 0x6f3b3860, Offset: 0x2d0
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 2, eflags: 0x0
// Checksum 0x9e78d7b6, Offset: 0x2f8
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

