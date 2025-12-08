#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/util;

#namespace events;

// Namespace events/events
// Params 3
// Checksum 0x6f76d457, Offset: 0x110
// Size: 0x74
function add_timed_event( seconds, notify_string, client_notify_string )
{
    assert( seconds >= 0 );
    
    if ( level.timelimit > 0 )
    {
        level thread timed_event_monitor( seconds, notify_string, client_notify_string );
    }
}

// Namespace events/events
// Params 3
// Checksum 0xfa207493, Offset: 0x190
// Size: 0xa2
function timed_event_monitor( seconds, notify_string, client_notify_string )
{
    for ( ;; )
    {
        wait 0.5;
        
        if ( !isdefined( level.starttime ) )
        {
            continue;
        }
        
        millisecs_remaining = globallogic_utils::gettimeremaining();
        seconds_remaining = millisecs_remaining / 1000;
        
        if ( seconds_remaining <= seconds )
        {
            event_notify( notify_string, client_notify_string );
            return;
        }
    }
}

// Namespace events/events
// Params 3
// Checksum 0xfbc6583d, Offset: 0x240
// Size: 0xac
function add_score_event( score, notify_string, client_notify_string )
{
    assert( score >= 0 );
    
    if ( level.scorelimit > 0 )
    {
        if ( level.teambased )
        {
            level thread score_team_event_monitor( score, notify_string, client_notify_string );
            return;
        }
        
        level thread score_event_monitor( score, notify_string, client_notify_string );
    }
}

// Namespace events/events
// Params 3
// Checksum 0x7b7fec74, Offset: 0x2f8
// Size: 0xd4
function add_round_score_event( score, notify_string, client_notify_string )
{
    assert( score >= 0 );
    
    if ( level.roundscorelimit > 0 )
    {
        roundscoretobeat = level.roundscorelimit * game.roundsplayed + score;
        
        if ( level.teambased )
        {
            level thread score_team_event_monitor( roundscoretobeat, notify_string, client_notify_string );
            return;
        }
        
        level thread score_event_monitor( roundscoretobeat, notify_string, client_notify_string );
    }
}

// Namespace events/events
// Params 1
// Checksum 0xf5e5cbcf, Offset: 0x3d8
// Size: 0xae, Type: bool
function any_team_reach_score( score )
{
    foreach ( team in level.teams )
    {
        if ( game.stat[ "teamScores" ][ team ] >= score )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace events/events
// Params 3
// Checksum 0x3af166f2, Offset: 0x490
// Size: 0x62
function score_team_event_monitor( score, notify_string, client_notify_string )
{
    for ( ;; )
    {
        wait 0.5;
        
        if ( any_team_reach_score( score ) )
        {
            event_notify( notify_string, client_notify_string );
            return;
        }
    }
}

// Namespace events/events
// Params 3
// Checksum 0x2ef2f411, Offset: 0x500
// Size: 0xbc
function score_event_monitor( score, notify_string, client_notify_string )
{
    for ( ;; )
    {
        wait 0.5;
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( isdefined( players[ i ].score ) && players[ i ].score >= score )
            {
                event_notify( notify_string, client_notify_string );
                return;
            }
        }
    }
}

// Namespace events/events
// Params 2
// Checksum 0x1323eb5a, Offset: 0x5c8
// Size: 0x4c
function event_notify( notify_string, client_notify_string )
{
    if ( isdefined( notify_string ) )
    {
        level notify( notify_string );
    }
    
    if ( isdefined( client_notify_string ) )
    {
        util::clientnotify( client_notify_string );
    }
}

