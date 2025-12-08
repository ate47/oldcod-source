#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;

#namespace namespace_9b5aa273;

// Namespace namespace_9b5aa273/namespace_9b5aa273
// Params 0, eflags: 0x6
// Checksum 0x329ea5f2, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"hash_2b0f887705d6f3e", &preinit, undefined, undefined, undefined );
}

// Namespace namespace_9b5aa273/namespace_9b5aa273
// Params 0, eflags: 0x4
// Checksum 0xfaf7eb0a, Offset: 0xe0
// Size: 0x2c
function private preinit()
{
    serverfield::register( "can_show_hold_breath_hint", 1, 1, "int" );
}

