#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/teams/teams;

#namespace arena;

// Namespace arena/arena
// Params 0, eflags: 0x2
// Checksum 0x619524af, Offset: 0x1d0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "arena", &__init__, undefined, undefined );
}

// Namespace arena/arena
// Params 0
// Checksum 0x8ecb3c4, Offset: 0x210
// Size: 0x24
function __init__()
{
    callback::on_connect( &on_connect );
}

// Namespace arena/arena
// Params 0
// Checksum 0x673fb914, Offset: 0x240
// Size: 0xca
function on_connect()
{
    if ( isdefined( self.pers[ "arenaInit" ] ) && self.pers[ "arenaInit" ] == 1 )
    {
        return;
    }
    
    draftenabled = getgametypesetting( "pregameDraftEnabled" ) == 1;
    voteenabled = getgametypesetting( "pregameItemVoteEnabled" ) == 1;
    
    if ( !draftenabled && !voteenabled )
    {
        self arenabeginmatch();
    }
    
    self.pers[ "arenaInit" ] = 1;
}

// Namespace arena/arena
// Params 0
// Checksum 0x3960c802, Offset: 0x318
// Size: 0x172
function update_arena_challenge_seasons()
{
    perseasonwins = self getdstat( "arenaPerSeasonStats", "wins" );
    
    if ( perseasonwins >= getdvarint( "arena_seasonVetChallengeWins" ) )
    {
        arenaslot = arenagetslot();
        currentseason = self getdstat( "arenaStats", arenaslot, "season" );
        seasonvetchallengearraycount = self getdstatarraycount( "arenaChallengeSeasons" );
        
        for ( i = 0; i < seasonvetchallengearraycount ; i++ )
        {
            challengeseason = self getdstat( "arenaChallengeSeasons", i );
            
            if ( challengeseason == currentseason )
            {
                return;
            }
            
            if ( challengeseason == 0 )
            {
                self setdstat( "arenaChallengeSeasons", i, currentseason );
                break;
            }
        }
    }
}

// Namespace arena/arena
// Params 1
// Checksum 0xb8958709, Offset: 0x498
// Size: 0x13e
function match_end( winner )
{
    for ( index = 0; index < level.players.size ; index++ )
    {
        player = level.players[ index ];
        
        if ( isdefined( player.pers[ "arenaInit" ] ) && player.pers[ "arenaInit" ] == 1 )
        {
            if ( winner == "tie" )
            {
                player arenaendmatch( 0 );
                continue;
            }
            
            if ( winner == player.pers[ "team" ] )
            {
                player arenaendmatch( 1 );
                player update_arena_challenge_seasons();
                continue;
            }
            
            player arenaendmatch( -1 );
        }
    }
}

