#using script_35ae72be7b4fec10;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace namespace_ecee8af;

// Namespace namespace_ecee8af/namespace_ecee8af
// Params 0, eflags: 0x6
// Checksum 0xdf3d173d, Offset: 0x78
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_1176c65c6cb322ff", undefined, &init_postload, undefined, undefined );
}

// Namespace namespace_ecee8af/namespace_ecee8af
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0xc0
// Size: 0x4
function private init_postload()
{
    
}

