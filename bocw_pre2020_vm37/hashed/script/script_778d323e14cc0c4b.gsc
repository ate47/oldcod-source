#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace blood;

// Namespace blood/blood
// Params 0, eflags: 0x6
// Checksum 0x6ae04589, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"blood", &preload, undefined, undefined, undefined );
}

// Namespace blood/blood
// Params 0
// Checksum 0x7a0137bb, Offset: 0xd0
// Size: 0x54
function preload()
{
    if ( sessionmodeiscampaigngame() )
    {
        clientfield::register( "world", "" + #"hash_7dc38a630ed68eb3", 1, 1, "int" );
    }
}

