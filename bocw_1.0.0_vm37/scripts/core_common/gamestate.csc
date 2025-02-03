#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace gamestate;

// Namespace gamestate/gamestate
// Params 0, eflags: 0x6
// Checksum 0x25f20c68, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"gamestate", &preinit, undefined, undefined, undefined);
}

// Namespace gamestate/gamestate
// Params 0, eflags: 0x4
// Checksum 0xc12b4563, Offset: 0xb8
// Size: 0x2c
function private preinit() {
    if (!isdefined(game.state)) {
        game.state = #"pregame";
    }
}

// Namespace gamestate/event_f7d4a05b
// Params 1, eflags: 0x40
// Checksum 0x4b8dc56f, Offset: 0xf0
// Size: 0x122
function event_handler[event_f7d4a05b] function_69452d92(eventstruct) {
    if (eventstruct.gamestate != game.state) {
        game.state = eventstruct.gamestate;
        callback::callback(#"hash_1184c2c2ed4c24b3", eventstruct);
        switch (eventstruct.gamestate) {
        case #"playing":
            callback::callback(#"on_game_playing", eventstruct);
            break;
        case #"postgame":
            callback::callback(#"hash_3ca80e35288a78d0", eventstruct);
            break;
        case #"shutdown":
            callback::callback(#"hash_1b5be9017cd4b5fa", eventstruct);
            break;
        }
    }
}

