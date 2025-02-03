#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace music;

// Namespace music/music_shared
// Params 0, eflags: 0x6
// Checksum 0xd0a0bc5c, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"music", &preinit, undefined, undefined, undefined);
}

// Namespace music/music_shared
// Params 0, eflags: 0x4
// Checksum 0xbe7426b2, Offset: 0xc8
// Size: 0x64
function private preinit() {
    level.activemusicstate = "";
    level.nextmusicstate = "";
    level.musicstates = [];
    util::register_system(#"musiccmd", &musiccmdhandler);
}

// Namespace music/music_shared
// Params 3, eflags: 0x0
// Checksum 0x5523529f, Offset: 0x138
// Size: 0x6c
function musiccmdhandler(*clientnum, state, *oldstate) {
    if (oldstate != "death") {
        level._lastmusicstate = oldstate;
    }
    oldstate = tolower(oldstate);
    soundsetmusicstate(oldstate);
}

