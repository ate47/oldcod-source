#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace music;

// Namespace music/music_shared
// Params 0, eflags: 0x6
// Checksum 0x19985692, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"music", &preinit, undefined, undefined, undefined );
}

// Namespace music/music_shared
// Params 0, eflags: 0x4
// Checksum 0xa290c8d1, Offset: 0xc8
// Size: 0x64
function private preinit()
{
    level.activemusicstate = "";
    level.nextmusicstate = "";
    level.musicstates = [];
    util::register_system( #"musiccmd", &musiccmdhandler );
}

// Namespace music/music_shared
// Params 3
// Checksum 0xc554ba49, Offset: 0x138
// Size: 0x6c
function musiccmdhandler( *clientnum, state, *oldstate )
{
    if ( oldstate != "death" )
    {
        level._lastmusicstate = oldstate;
    }
    
    oldstate = tolower( oldstate );
    soundsetmusicstate( oldstate );
}

