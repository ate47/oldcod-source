#using scripts\core_common\system_shared;

#namespace hawk;

// Namespace hawk/hawk
// Params 0, eflags: 0x6
// Checksum 0x6e8943a, Offset: 0x68
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hawk", &preinit, undefined, undefined, undefined );
}

// Namespace hawk/hawk
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0xb0
// Size: 0x4
function private preinit()
{
    
}

