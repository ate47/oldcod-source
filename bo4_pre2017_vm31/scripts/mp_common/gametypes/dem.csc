#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/mp_common/gametypes/globallogic;

#namespace dem;

// Namespace dem/GameType_Init
// Params 1, eflags: 0x40
// Checksum 0x1f583abe, Offset: 0x110
// Size: 0x6c
function event_handler[GameType_Init] main( eventstruct )
{
    callback::on_spawned( &on_player_spawned );
    
    if ( getgametypesetting( "silentPlant" ) != 0 )
    {
        setsoundcontext( "bomb_plant", "silent" );
    }
}

// Namespace dem/dem
// Params 0
// Checksum 0x80f724d1, Offset: 0x188
// Size: 0x4
function onprecachegametype()
{
    
}

// Namespace dem/dem
// Params 0
// Checksum 0x80f724d1, Offset: 0x198
// Size: 0x4
function onstartgametype()
{
    
}

// Namespace dem/dem
// Params 1
// Checksum 0xe2134710, Offset: 0x1a8
// Size: 0x24
function on_player_spawned( localclientnum )
{
    self thread globallogic::function_17f0b9e4( localclientnum );
}

