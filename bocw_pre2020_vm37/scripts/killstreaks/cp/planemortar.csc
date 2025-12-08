#using scripts\core_common\system_shared;
#using scripts\killstreaks\planemortar_shared;

#namespace planemortar;

// Namespace planemortar/planemortar
// Params 0, eflags: 0x6
// Checksum 0x78a8492f, Offset: 0x70
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"planemortar", &preinit, undefined, undefined, #"killstreaks" );
}

// Namespace planemortar/planemortar
// Params 0, eflags: 0x4
// Checksum 0x3f429e57, Offset: 0xc0
// Size: 0x14
function private preinit()
{
    init_shared();
}

