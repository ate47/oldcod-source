#using scripts\core_common\system_shared;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace helicopter;

// Namespace helicopter/helicopter
// Params 0, eflags: 0x6
// Checksum 0x2b077def, Offset: 0xa0
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"helicopter", &preinit, undefined, undefined, #"killstreaks" );
}

// Namespace helicopter/helicopter
// Params 0, eflags: 0x4
// Checksum 0x29d4d24f, Offset: 0xf0
// Size: 0x74
function private preinit()
{
    if ( sessionmodeismultiplayergame() || sessionmodeiswarzonegame() )
    {
        killstreaks::register_killstreak( "killstreak_helicopter_comlink" + "_cp", &usekillstreakhelicopter );
    }
    
    init_shared();
}

