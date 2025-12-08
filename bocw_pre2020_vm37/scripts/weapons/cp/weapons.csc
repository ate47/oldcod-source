#using scripts\core_common\system_shared;
#using scripts\weapons\weapons;

#namespace weapons;

// Namespace weapons/weapons
// Params 0, eflags: 0x6
// Checksum 0x5bc44f66, Offset: 0x70
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"weapons", &preinit, undefined, undefined, undefined );
}

// Namespace weapons/weapons
// Params 0, eflags: 0x4
// Checksum 0x3f429e57, Offset: 0xb8
// Size: 0x14
function private preinit()
{
    init_shared();
}

