#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\planemortar_shared;

#namespace planemortar;

// Namespace planemortar/planemortar
// Params 0, eflags: 0x6
// Checksum 0xfab0d099, Offset: 0xa8
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"planemortar", &preinit, undefined, undefined, #"killstreaks" );
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x4
// Checksum 0xd117128e, Offset: 0xf8
// Size: 0x44
function private preinit()
{
    init_shared();
    killstreaks::register_killstreak( "killstreak_planemortar" + "_cp", &usekillstreakplanemortar );
}

