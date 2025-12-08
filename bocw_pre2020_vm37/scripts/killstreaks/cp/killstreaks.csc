#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace killstreaks;

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x6
// Checksum 0x8d761434, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"killstreaks", &preinit, undefined, undefined, undefined );
}

// Namespace killstreaks/killstreaks
// Params 0, eflags: 0x4
// Checksum 0x3f429e57, Offset: 0xb8
// Size: 0x14
function private preinit()
{
    init_shared();
}

