#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace friendicons;

// Namespace friendicons/friendicons
// Params 0, eflags: 0x2
// Checksum 0x687195b1, Offset: 0x128
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "friendicons", &__init__, undefined, undefined );
}

// Namespace friendicons/friendicons
// Params 0
// Checksum 0x21766c78, Offset: 0x168
// Size: 0x24
function __init__()
{
    callback::on_start_gametype( &init );
}

// Namespace friendicons/friendicons
// Params 0
// Checksum 0x132040a4, Offset: 0x198
// Size: 0xde
function init()
{
    if ( !level.teambased )
    {
        return;
    }
    
    if ( getdvarstring( "scr_drawfriend" ) == "" )
    {
        setdvar( "scr_drawfriend", "0" );
    }
    
    level.drawfriend = getdvarint( "scr_drawfriend" );
    callback::on_spawned( &on_player_spawned );
    callback::on_player_killed( &on_player_killed );
    
    for ( ;; )
    {
        updatefriendiconsettings();
        wait 5;
    }
}

// Namespace friendicons/friendicons
// Params 0
// Checksum 0xa3056865, Offset: 0x280
// Size: 0x20
function on_player_killed()
{
    self endon( #"disconnect" );
    self.headicon = "";
}

// Namespace friendicons/friendicons
// Params 0
// Checksum 0x86211cdd, Offset: 0x2a8
// Size: 0x24
function on_player_spawned()
{
    self endon( #"disconnect" );
    self thread showfriendicon();
}

// Namespace friendicons/friendicons
// Params 0
// Checksum 0x4b5f9c16, Offset: 0x2d8
// Size: 0x60
function showfriendicon()
{
    if ( level.drawfriend )
    {
        team = self.pers[ "team" ];
        self.headicon = game.headicon[ team ];
        self.headiconteam = team;
    }
}

// Namespace friendicons/friendicons
// Params 0
// Checksum 0xafddf18e, Offset: 0x340
// Size: 0x5c
function updatefriendiconsettings()
{
    drawfriend = getdvarfloat( "scr_drawfriend" );
    
    if ( level.drawfriend != drawfriend )
    {
        level.drawfriend = drawfriend;
        updatefriendicons();
    }
}

// Namespace friendicons/friendicons
// Params 0
// Checksum 0x8ad1f337, Offset: 0x3a8
// Size: 0x234
function updatefriendicons()
{
    assert( isdefined( game.headicon[ "<dev string:x28>" ] ), "<dev string:x2f>" );
    assert( isdefined( game.headicon[ "<dev string:x75>" ] ), "<dev string:x7a>" );
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] != "spectator" && player.sessionstate == "playing" )
        {
            if ( level.drawfriend )
            {
                team = self.pers[ "team" ];
                self.headicon = game.headicon[ team ];
                self.headiconteam = team;
                continue;
            }
            
            players = level.players;
            
            for ( i = 0; i < players.size ; i++ )
            {
                player = players[ i ];
                
                if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] != "spectator" && player.sessionstate == "playing" )
                {
                    player.headicon = "";
                }
            }
        }
    }
}

