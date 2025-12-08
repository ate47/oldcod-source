#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace globallogic_player;

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x6
// Checksum 0x9d138d5d, Offset: 0xb0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"globallogic_player", &preinit, undefined, undefined, undefined );
}

// Namespace globallogic_player/globallogic_player
// Params 0, eflags: 0x4
// Checksum 0xcb1da90b, Offset: 0xf8
// Size: 0x4c
function private preinit()
{
    clientfield::register( "toplayer", "player_damage_type", 1, 1, "int", &player_damage_type_changed, 0, 0 );
}

// Namespace globallogic_player/globallogic_player
// Params 7
// Checksum 0x27a4e3a8, Offset: 0x150
// Size: 0xd4
function player_damage_type_changed( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( !self function_21c0fa55() )
    {
        return;
    }
    
    if ( bwastimejump )
    {
        self setdamagedirectionindicator( 1 );
        setsoundcontext( "plr_impact", "flesh" );
        return;
    }
    
    self setdamagedirectionindicator( 0 );
    setsoundcontext( "plr_impact", "flesh" );
}

