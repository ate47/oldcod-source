#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lui_shared;

#namespace player_insertion_choice;

// Namespace player_insertion_choice
// Method(s) 6 Total 13
class cplayer_insertion_choice : cluielem {

    var var_57a3d576;

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 2, eflags: 0x0
    // Checksum 0x2cffd21d, Offset: 0x2c0
    // Size: 0x13c
    function set_state(player, state_name) {
        if (#"defaultstate" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 0);
            return;
        }
        if (#"groundvehicle" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 1);
            return;
        }
        if (#"halojump" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 2);
            return;
        }
        if (#"heli" == state_name) {
            player clientfield::function_8fe7322a(var_57a3d576, "_state", 3);
            return;
        }
        assertmsg("<dev string:x30>");
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 1, eflags: 0x0
    // Checksum 0xff8b18e7, Offset: 0x290
    // Size: 0x24
    function close(player) {
        cluielem::close_luielem(player);
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 2, eflags: 0x0
    // Checksum 0x2287c366, Offset: 0x240
    // Size: 0x44
    function open(player, persistent = 0) {
        cluielem::open_luielem(player, "player_insertion_choice", persistent);
    }

    // Namespace cplayer_insertion_choice/player_insertion_choice
    // Params 1, eflags: 0x0
    // Checksum 0x2b10378f, Offset: 0x1e8
    // Size: 0x4c
    function setup_clientfields(uid) {
        cluielem::setup_clientfields(uid);
        cluielem::add_clientfield("_state", 1, 2, "int");
    }

}

// Namespace player_insertion_choice/player_insertion_choice
// Params 1, eflags: 0x0
// Checksum 0xbcd81160, Offset: 0xc0
// Size: 0x40
function register(uid) {
    elem = new cplayer_insertion_choice();
    [[ elem ]]->setup_clientfields(uid);
    return elem;
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 2, eflags: 0x0
// Checksum 0x802e10d1, Offset: 0x108
// Size: 0x38
function open(player, persistent = 0) {
    [[ self ]]->open(player, persistent);
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 1, eflags: 0x0
// Checksum 0x23e135c1, Offset: 0x148
// Size: 0x1c
function close(player) {
    [[ self ]]->close(player);
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 1, eflags: 0x0
// Checksum 0xaec766b, Offset: 0x170
// Size: 0x1a
function is_open(player) {
    return [[ self ]]->function_76692f88(player);
}

// Namespace player_insertion_choice/player_insertion_choice
// Params 2, eflags: 0x0
// Checksum 0xd961bac4, Offset: 0x198
// Size: 0x28
function set_state(player, state_name) {
    [[ self ]]->set_state(player, state_name);
}

