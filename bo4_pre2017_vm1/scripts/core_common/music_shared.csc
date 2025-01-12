#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace music;

// Namespace music/music_shared
// Params 0, eflags: 0x2
// Checksum 0x70d2a0b1, Offset: 0xe0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("music", &__init__, undefined, undefined);
}

// Namespace music/music_shared
// Params 0, eflags: 0x0
// Checksum 0x97bb4451, Offset: 0x120
// Size: 0x64
function __init__() {
    level.activemusicstate = "";
    level.nextmusicstate = "";
    level.musicstates = [];
    util::register_system("musicCmd", &musiccmdhandler);
}

// Namespace music/music_shared
// Params 3, eflags: 0x0
// Checksum 0x527aafe8, Offset: 0x190
// Size: 0x6c
function musiccmdhandler(clientnum, state, oldstate) {
    if (state != "death") {
        level._lastmusicstate = state;
    }
    state = tolower(state);
    soundsetmusicstate(state);
}

