#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace abilities;

// Namespace abilities/abilities
// Params 0, eflags: 0x6
// Checksum 0x208036b1, Offset: 0x98
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"cp_abilities", &preinit, undefined, undefined, undefined );
}

// Namespace abilities/abilities
// Params 0, eflags: 0x4
// Checksum 0xbea10511, Offset: 0xe0
// Size: 0x54
function private preinit()
{
    clientfield::register_clientuimodel( "playerAbilities.inRange", #"player_abilities", #"inrange", 1, 1, "int", undefined, 0, 0 );
}

