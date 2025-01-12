#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace music;

// Namespace music/music_shared
// Params 0, eflags: 0x2
// Checksum 0x94dd40c2, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"music", &__init__, undefined, undefined);
}

// Namespace music/music_shared
// Params 0, eflags: 0x0
// Checksum 0x92f23f9c, Offset: 0xc8
// Size: 0x64
function __init__() {
    level.activemusicstate = "";
    level.nextmusicstate = "";
    level.musicstates = [];
    util::register_system(#"musiccmd", &musiccmdhandler);
}

// Namespace music/music_shared
// Params 3, eflags: 0x0
// Checksum 0xdc63efbf, Offset: 0x138
// Size: 0x64
function musiccmdhandler(clientnum, state, oldstate) {
    if (state != "death") {
        level._lastmusicstate = state;
    }
    state = tolower(state);
    soundsetmusicstate(state);
}

