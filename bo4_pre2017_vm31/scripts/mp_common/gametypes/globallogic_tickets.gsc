#using scripts/core_common/bb_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/persistence_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/gametypes/wager;
#using scripts/mp_common/util;

#namespace tickets;

// Namespace tickets/globallogic_tickets
// Params 0, eflags: 0x2
// Checksum 0x5cf4bc38, Offset: 0x320
// Size: 0x24
function autoexec __init__()
{
    callback::on_player_killed( &on_player_killed );
}

// Namespace tickets/globallogic_tickets
// Params 1
// Checksum 0xa144744, Offset: 0x350
// Size: 0x5c
function reset_match_start( total_stages )
{
    if ( game.tickets_initialized === 1 )
    {
        return;
    }
    
    reset_stages( total_stages );
    reset_tickets();
    game.tickets_initialized = 1;
}

// Namespace tickets/globallogic_tickets
// Params 1
// Checksum 0x1b8eb5f9, Offset: 0x3b8
// Size: 0x106
function reset_stages( total_stages )
{
    game.stat[ "stagetickets" ] = [];
    
    foreach ( team in level.teams )
    {
        game.stat[ "stagetickets" ][ team ] = [];
        
        for ( stage = 0; stage < total_stages ; stage++ )
        {
            game.stat[ "stagetickets" ][ team ][ stage ] = 0;
        }
    }
}

// Namespace tickets/globallogic_tickets
// Params 0
// Checksum 0x941a61ce, Offset: 0x4c8
// Size: 0xb2
function reset_tickets()
{
    game.stat[ "tickets" ] = [];
    
    foreach ( team in level.teams )
    {
        game.stat[ "tickets" ][ team ] = 0;
    }
}

// Namespace tickets/globallogic_tickets
// Params 2
// Checksum 0x70d9da98, Offset: 0x588
// Size: 0x5c
function setup_mission_ticket_logic( team, zone_index )
{
    setup_stage_start_tickets( team, zone_index );
    thread setup_death_penalties( team );
    thread watch_time_penalties( team );
}

// Namespace tickets/globallogic_tickets
// Params 2
// Checksum 0x5606ed6c, Offset: 0x5f0
// Size: 0x64
function setup_stage_start_tickets( team, zone_index )
{
    reset_tickets();
    zone_start_tickets = get_zone_start_tickets( zone_index );
    set_tickets( team, zone_start_tickets );
}

// Namespace tickets/globallogic_tickets
// Params 1
// Checksum 0xa30dae34, Offset: 0x660
// Size: 0x58
function get_zone_start_tickets( zone_index )
{
    return isdefined( getgametypesetting( "ticketsGivenAtStageStart_" + zone_index ) ) ? getgametypesetting( "ticketsGivenAtStageStart_" + zone_index ) : 0;
}

// Namespace tickets/globallogic_tickets
// Params 1
// Checksum 0xa76523e4, Offset: 0x6c0
// Size: 0x158
function watch_time_penalties( team )
{
    level notify( #"tickets_watch_time_penalties" );
    level endon( #"tickets_watch_time_penalties" );
    level endon( #"mission_ended" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        penalty_interval = isdefined( getgametypesetting( "ticketsLostOnTimeInterval" ) ) ? getgametypesetting( "ticketsLostOnTimeInterval" ) : 0;
        
        if ( penalty_interval <= 0 )
        {
            wait 0.5;
            continue;
        }
        
        frames_to_wait = int( ceil( penalty_interval / 0.05 ) );
        waitframe( frames_to_wait );
        lose_tickets( team, isdefined( getgametypesetting( "ticketsLostOnTimeAmount" ) ) ? getgametypesetting( "ticketsLostOnTimeAmount" ) : 0 );
    }
}

// Namespace tickets/globallogic_tickets
// Params 1
// Checksum 0x77ed2bce, Offset: 0x820
// Size: 0x1c
function setup_death_penalties( team )
{
    level.ticket_death_penalty_team = team;
}

// Namespace tickets/globallogic_tickets
// Params 0
// Checksum 0xe0a47aa0, Offset: 0x848
// Size: 0x11c
function on_player_killed()
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.team ) )
    {
        return;
    }
    
    if ( !isdefined( level.ticket_death_penalty_team ) )
    {
        return;
    }
    
    if ( level.ticket_death_penalty_team == player.team )
    {
        death_penalty = isdefined( getgametypesetting( "ticketsLostOnDeath" ) ) ? getgametypesetting( "ticketsLostOnDeath" ) : 0;
        
        if ( death_penalty > 0 )
        {
            lose_tickets( player.team, death_penalty );
            level notify( #"ticket_death", { #team:player.team } );
        }
    }
}

// Namespace tickets/globallogic_tickets
// Params 2
// Checksum 0x43da5a8e, Offset: 0x970
// Size: 0x74
function set_tickets( team, tickets )
{
    original_total = game.stat[ "tickets" ][ team ];
    game.stat[ "tickets" ][ team ] = tickets;
    notify_tickets_updated( team, original_total );
}

// Namespace tickets/globallogic_tickets
// Params 2
// Checksum 0xb0879fae, Offset: 0x9f0
// Size: 0xa4
function earn_tickets( team, tickets )
{
    original_total = game.stat[ "tickets" ][ team ];
    game.stat[ "tickets" ][ team ] = game.stat[ "tickets" ][ team ] + tickets;
    clamp_tickets( team );
    notify_tickets_updated( team, original_total );
}

// Namespace tickets/globallogic_tickets
// Params 2
// Checksum 0x7391e636, Offset: 0xaa0
// Size: 0xa4
function lose_tickets( team, tickets )
{
    original_total = game.stat[ "tickets" ][ team ];
    game.stat[ "tickets" ][ team ] = game.stat[ "tickets" ][ team ] - tickets;
    clamp_tickets( team );
    notify_tickets_updated( team, original_total );
}

// Namespace tickets/globallogic_tickets
// Params 2
// Checksum 0x985b99af, Offset: 0xb50
// Size: 0x180
function notify_tickets_updated( team, original_total )
{
    if ( original_total != game.stat[ "tickets" ][ team ] )
    {
        level notify( #"tickets_updated", { #team:team, #total_tickets:game.stat[ "tickets" ][ team ] } );
        low_ticket_threshold = 30;
        very_low_ticket_threshold = 10;
        
        /#
            if ( getdvarint( "<dev string:x28>", 0 ) > 0 )
            {
                low_ticket_threshold = -1;
                very_low_ticket_threshold = -1;
            }
        #/
        
        low_tickets_enabled = level.low_tickets_enabled === 1;
        level.low_ticket_count = game.stat[ "tickets" ][ team ] <= low_ticket_threshold && !level.inprematchperiod && low_tickets_enabled;
        level.very_low_ticket_count = game.stat[ "tickets" ][ team ] <= very_low_ticket_threshold && !level.inprematchperiod && low_tickets_enabled;
    }
}

// Namespace tickets/globallogic_tickets
// Params 1, eflags: 0x4
// Checksum 0x438163bd, Offset: 0xcd8
// Size: 0x60
function private clamp_tickets( team )
{
    game.stat[ "tickets" ][ team ] = math::clamp( game.stat[ "tickets" ][ team ], 0, 2147483647 );
}

// Namespace tickets/globallogic_tickets
// Params 2
// Checksum 0xc426365a, Offset: 0xd40
// Size: 0x6c
function commit_tickets( team, stage )
{
    game.stat[ "stagetickets" ][ team ][ stage ] = game.stat[ "tickets" ][ team ];
    notify_stage_tickets_updated( team, stage );
}

// Namespace tickets/globallogic_tickets
// Params 2
// Checksum 0xa80d3a49, Offset: 0xdb8
// Size: 0x5c
function award_stage_win( team, stage )
{
    earned_tickets = get_stage_win_tickets( stage );
    
    if ( earned_tickets > 0 )
    {
        earn_tickets( team, earned_tickets );
    }
}

// Namespace tickets/globallogic_tickets
// Params 1
// Checksum 0xd372a95b, Offset: 0xe20
// Size: 0x58
function get_stage_win_tickets( stage )
{
    return isdefined( getgametypesetting( "ticketsEarnedAtStageWin_" + stage ) ) ? getgametypesetting( "ticketsEarnedAtStageWin_" + stage ) : 0;
}

// Namespace tickets/globallogic_tickets
// Params 1
// Checksum 0xab6f87db, Offset: 0xe80
// Size: 0x4e
function get_tickets( team )
{
    if ( !isdefined( game.tickets_initialized ) || !game.tickets_initialized )
    {
        return 0;
    }
    
    return game.stat[ "tickets" ][ team ];
}

// Namespace tickets/globallogic_tickets
// Params 2
// Checksum 0x5d6b85cf, Offset: 0xed8
// Size: 0x5c
function get_stage_tickets( team, stage )
{
    if ( !isdefined( game.tickets_initialized ) || !game.tickets_initialized )
    {
        return 0;
    }
    
    return game.stat[ "stagetickets" ][ team ][ stage ];
}

// Namespace tickets/globallogic_tickets
// Params 2
// Checksum 0x304e60d9, Offset: 0xf40
// Size: 0x64
function notify_stage_tickets_updated( team, stage )
{
    level notify( #"tickets_stage_updated", { #team:team, #zone_number:stage, #total_tickets:game.stat[ "stagetickets" ][ team ][ stage ] } );
}

// Namespace tickets/globallogic_tickets
// Params 2
// Checksum 0x751ca14d, Offset: 0xfb0
// Size: 0x78
function get_total_tickets( team, total_stages )
{
    team_total = 0;
    
    for ( i = 0; i < total_stages ; i++ )
    {
        team_total += get_stage_tickets( team, i );
    }
    
    return team_total;
}

