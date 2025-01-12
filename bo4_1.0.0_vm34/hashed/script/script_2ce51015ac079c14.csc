#using scripts\core_common\lui_shared;

#namespace player_insertion_choice;

// Namespace player_insertion_choice
// Method(s) 7 Total 13
class cplayer_insertion_choice : cluielem {

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 2, eflags: 0x0
    // Checksum 0x369791fd, Offset: 0x308
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
        assertmsg("<dev string:x30>");
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 1, eflags: 0x0
    // Checksum 0x1790c501, Offset: 0x2d0
    // Size: 0x2c
    function open(localclientnum) {
        cluielem::open(localclientnum, #"player_insertion_choice");
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 1, eflags: 0x0
    // Checksum 0x9230e318, Offset: 0x280
    // Size: 0x44
    function function_cf9c4603(localclientnum) {
        cluielem::function_cf9c4603(localclientnum);
        set_state(localclientnum, #"defaultstate");
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 1, eflags: 0x0
    // Checksum 0xe6a709fd, Offset: 0x250
    // Size: 0x24
    function register_clientside(uid) {
        cluielem::register_clientside(uid);
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 1, eflags: 0x0
    // Checksum 0x9510bd4d, Offset: 0x1f8
    // Size: 0x4c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("_state", 1, 2, "int");
    }

}

// Namespace player_insertion_choice/player_insertion_choice
// Params 1, eflags: 0x0
// Checksum 0x8a779b9, Offset: 0xa0
// Size: 0x40
function register(uid) {
    elem = new cplayer_insertion_choice();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 1, eflags: 0x0
// Checksum 0xc0bb3a55, Offset: 0xe8
// Size: 0x40
function register_clientside(uid) {
    elem = new cplayer_insertion_choice();
    [[ elem ]]->register_clientside(uid);
    return elem;
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 1, eflags: 0x0
// Checksum 0x9ea4fd62, Offset: 0x130
// Size: 0x1c
function open(player) {
    [[ self ]]->open(player);
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 1, eflags: 0x0
// Checksum 0x781fea29, Offset: 0x158
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 1, eflags: 0x0
// Checksum 0x8c27aac4, Offset: 0x180
// Size: 0x1a
function is_open(localclientnum) {
    return [[ self ]]->is_open(localclientnum);
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 2, eflags: 0x0
// Checksum 0x3d64b944, Offset: 0x1a8
// Size: 0x28
function set_state(localclientnum, state_name) {
    [[ self ]]->set_state(localclientnum, state_name);
}

