#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/struct;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/util;

#namespace globallogic_defaults;

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0x88b4b1bb, Offset: 0x3c8
// Size: 0x3a
function getwinningteamfromloser( losing_team )
{
    if ( level.multiteam )
    {
        return "tie";
    }
    
    return util::getotherteam( losing_team );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0xd56322b1, Offset: 0x410
// Size: 0x344
function default_onforfeit( team )
{
    level.gameforfeited = 1;
    level notify( #"hash_d343f3a0" );
    level endon( #"hash_d343f3a0" );
    level endon( #"hash_577494dc" );
    forfeit_delay = 20;
    announcement( game.strings[ "opponent_forfeiting_in" ], forfeit_delay, 0 );
    wait 10;
    announcement( game.strings[ "opponent_forfeiting_in" ], 10, 0 );
    wait 10;
    endreason = &"";
    
    if ( level.multiteam )
    {
        setdvar( "ui_text_endreason", game.strings[ "other_teams_forfeited" ] );
        endreason = game.strings[ "other_teams_forfeited" ];
        winner = team;
    }
    else if ( !isdefined( team ) )
    {
        setdvar( "ui_text_endreason", game.strings[ "players_forfeited" ] );
        endreason = game.strings[ "players_forfeited" ];
        winner = level.players[ 0 ];
    }
    else if ( isdefined( level.teams[ team ] ) )
    {
        endreason = game.strings[ team + "_forfeited" ];
        setdvar( "ui_text_endreason", endreason );
        winner = getwinningteamfromloser( team );
    }
    else
    {
        assert( isdefined( team ), "<dev string:x28>" );
        assert( 0, "<dev string:x46>" + team + "<dev string:x56>" );
        winner = "tie";
    }
    
    level.forcedend = 1;
    
    /#
        if ( isplayer( winner ) )
        {
            print( "<dev string:x6d>" + winner getxuid() + "<dev string:x7c>" + winner.name + "<dev string:x7e>" );
        }
        else
        {
            globallogic_utils::logteamwinstring( "<dev string:x80>", winner );
        }
    #/
    
    thread globallogic::endgame( winner, endreason );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0xf259cd8e, Offset: 0x760
// Size: 0x18c
function default_ondeadevent( team )
{
    if ( isdefined( level.teams[ team ] ) )
    {
        eliminatedstring = game.strings[ team + "_eliminated" ];
        iprintln( eliminatedstring );
        setdvar( "ui_text_endreason", eliminatedstring );
        winner = getwinningteamfromloser( team );
        globallogic_utils::logteamwinstring( "team eliminated", winner );
        thread globallogic::endgame( winner, eliminatedstring );
        return;
    }
    
    setdvar( "ui_text_endreason", game.strings[ "tie" ] );
    globallogic_utils::logteamwinstring( "tie" );
    
    if ( level.teambased )
    {
        thread globallogic::endgame( "tie", game.strings[ "tie" ] );
        return;
    }
    
    thread globallogic::endgame( undefined, game.strings[ "tie" ] );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0x2981fdde, Offset: 0x8f8
// Size: 0x184
function function_45c10f52( team )
{
    if ( isdefined( level.teams[ team ] ) )
    {
        eliminatedstring = game.strings[ "enemies_eliminated" ];
        iprintln( eliminatedstring );
        setdvar( "ui_text_endreason", eliminatedstring );
        winner = globallogic::determineteamwinnerbygamestat( "teamScores" );
        globallogic_utils::logteamwinstring( "team eliminated", winner );
        thread globallogic::endgame( winner, eliminatedstring );
        return;
    }
    
    setdvar( "ui_text_endreason", game.strings[ "tie" ] );
    globallogic_utils::logteamwinstring( "tie" );
    
    if ( level.teambased )
    {
        thread globallogic::endgame( "tie", game.strings[ "tie" ] );
        return;
    }
    
    thread globallogic::endgame( undefined, game.strings[ "tie" ] );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0x29a1cb50, Offset: 0xa88
// Size: 0xc
function default_onalivecountchange( team )
{
    
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0xcaa19282, Offset: 0xaa0
// Size: 0x10
function default_onroundendgame( winner )
{
    return winner;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0x653eb39e, Offset: 0xab8
// Size: 0xc4
function function_417075b7( roundwinner )
{
    if ( isdefined( game.overtime_round ) )
    {
        if ( isdefined( level.doubleovertime ) && level.doubleovertime && isdefined( roundwinner ) && roundwinner != "tie" )
        {
            return roundwinner;
        }
        
        return globallogic::determineteamwinnerbygamestat( "overtimeroundswon" );
    }
    
    if ( level.scoreroundwinbased )
    {
        winner = globallogic::determineteamwinnerbygamestat( "roundswon" );
    }
    else
    {
        winner = globallogic::determineteamwinnerbyteamscore();
    }
    
    return winner;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0xe70a4b2, Offset: 0xb88
// Size: 0x176
function default_ononeleftevent( team )
{
    if ( !level.teambased )
    {
        winner = globallogic_score::gethighestscoringplayer();
        
        /#
            if ( isdefined( winner ) )
            {
                print( "<dev string:x88>" + winner.name );
            }
            else
            {
                print( "<dev string:x9e>" );
            }
        #/
        
        thread globallogic::endgame( winner, &"MP_ENEMIES_ELIMINATED" );
        return;
    }
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        player = level.players[ index ];
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.pers[ "team" ] ) || player.pers[ "team" ] != team )
        {
            continue;
        }
        
        player globallogic_audio::leader_dialog_on_player( "sudden_death" );
    }
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0
// Checksum 0xebd50fb4, Offset: 0xd08
// Size: 0xfc
function default_ontimelimit()
{
    winner = undefined;
    
    if ( level.teambased )
    {
        winner = globallogic::determineteamwinnerbygamestat( "teamScores" );
        globallogic_utils::logteamwinstring( "time limit", winner );
    }
    else
    {
        winner = globallogic_score::gethighestscoringplayer();
        
        /#
            if ( isdefined( winner ) )
            {
                print( "<dev string:xbb>" + winner.name );
            }
            else
            {
                print( "<dev string:xcd>" );
            }
        #/
    }
    
    thread globallogic::endgame( winner, game.strings[ "time_limit_reached" ] );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0
// Checksum 0xbad78a8a, Offset: 0xe10
// Size: 0x140, Type: bool
function default_onscorelimit()
{
    if ( !level.endgameonscorelimit )
    {
        return false;
    }
    
    winner = undefined;
    
    if ( level.teambased )
    {
        winner = globallogic::determineteamwinnerbygamestat( "teamScores" );
        globallogic_utils::logteamwinstring( "scorelimit", winner );
    }
    else
    {
        winner = globallogic_score::gethighestscoringplayer();
        
        /#
            if ( isdefined( winner ) )
            {
                print( "<dev string:xdd>" + winner.name );
            }
            else
            {
                print( "<dev string:xef>" );
            }
        #/
    }
    
    setdvar( "ui_text_endreason", game.strings[ "score_limit_reached" ] );
    thread globallogic::endgame( winner, game.strings[ "score_limit_reached" ] );
    return true;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0
// Checksum 0xc63b0f71, Offset: 0xf58
// Size: 0x130, Type: bool
function default_onroundscorelimit()
{
    winner = undefined;
    
    if ( level.teambased )
    {
        winner = globallogic::determineteamwinnerbygamestat( "teamScores" );
        globallogic_utils::logteamwinstring( "roundscorelimit", winner );
    }
    else
    {
        winner = globallogic_score::gethighestscoringplayer();
        
        /#
            if ( isdefined( winner ) )
            {
                print( "<dev string:xff>" + winner.name );
            }
            else
            {
                print( "<dev string:x116>" );
            }
        #/
    }
    
    setdvar( "ui_text_endreason", game.strings[ "round_score_limit_reached" ] );
    thread globallogic::endgame( winner, game.strings[ "round_score_limit_reached" ] );
    return true;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 2
// Checksum 0xd06f6f89, Offset: 0x1090
// Size: 0xdc
function default_onspawnspectator( origin, angles )
{
    if ( isdefined( origin ) && isdefined( angles ) )
    {
        self spawn( origin, angles );
        return;
    }
    
    spawnpoints = spawning::get_spawnpoint_array( "mp_global_intermission" );
    assert( spawnpoints.size, "<dev string:x12b>" );
    spawnpoint = spawning::get_spawnpoint_random( spawnpoints );
    self spawn( spawnpoint.origin, spawnpoint.angles );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0x6d3d8698, Offset: 0x1178
// Size: 0x9c
function default_onspawnintermission( endgame )
{
    if ( isdefined( endgame ) && endgame )
    {
        return;
    }
    
    spawnpoint = spawning::get_random_intermission_point();
    
    if ( isdefined( spawnpoint ) )
    {
        self spawn( spawnpoint.origin, spawnpoint.angles );
        return;
    }
    
    /#
        util::error( "<dev string:x185>" );
    #/
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0
// Checksum 0x6b0c6188, Offset: 0x1220
// Size: 0x42
function default_gettimelimit()
{
    return math::clamp( getgametypesetting( "timeLimit" ), level.timelimitmin, level.timelimitmax );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 4
// Checksum 0x70d99de1, Offset: 0x1270
// Size: 0x76
function default_getteamkillpenalty( einflictor, attacker, smeansofdeath, weapon )
{
    teamkill_penalty = 1;
    
    if ( killstreaks::is_killstreak_weapon( weapon ) )
    {
        teamkill_penalty *= killstreaks::get_killstreak_team_kill_penalty_scale( weapon );
    }
    
    return teamkill_penalty;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 4
// Checksum 0xddce8994, Offset: 0x12f0
// Size: 0x42
function default_getteamkillscore( einflictor, attacker, smeansofdeath, weapon )
{
    return attacker rank::getscoreinfovalue( "team_kill" );
}

