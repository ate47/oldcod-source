#using script_44b0b8420eabacad;
#using scripts\core_common\math_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_utils;
#using scripts\cp_common\util;

#namespace globallogic_defaults;

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0xd0362711, Offset: 0x130
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
// Checksum 0x76d81892, Offset: 0x178
// Size: 0x354
function default_onforfeit( team )
{
    level.gameforfeited = 1;
    level notify( #"forfeit in progress" );
    level endon( #"forfeit in progress", #"abort forfeit" );
    forfeit_delay = 20;
    announcement( game.strings[ #"opponent_forfeiting_in" ], forfeit_delay, 0 );
    wait 10;
    announcement( game.strings[ #"opponent_forfeiting_in" ], 10, 0 );
    wait 10;
    endreason = #"";
    
    if ( level.multiteam )
    {
        setdvar( #"ui_text_endreason", game.strings[ #"other_teams_forfeited" ] );
        endreason = game.strings[ #"other_teams_forfeited" ];
        winner = team;
    }
    else if ( !isdefined( team ) )
    {
        setdvar( #"ui_text_endreason", game.strings[ #"players_forfeited" ] );
        endreason = game.strings[ #"players_forfeited" ];
        winner = level.players[ 0 ];
    }
    else if ( isdefined( level.teams[ team ] ) )
    {
        endreason = game.strings[ team + "_forfeited" ];
        setdvar( #"ui_text_endreason", endreason );
        winner = getwinningteamfromloser( team );
    }
    else
    {
        assert( isdefined( team ), "<dev string:x38>" );
        assert( 0, "<dev string:x59>" + team + "<dev string:x6c>" );
        winner = "tie";
    }
    
    level.forcedend = 1;
    
    /#
        if ( isplayer( winner ) )
        {
            print( "<dev string:x86>" + winner getxuid() + "<dev string:x98>" + winner.name + "<dev string:x9d>" );
        }
        else
        {
            globallogic_utils::logteamwinstring( "<dev string:xa2>", winner );
        }
    #/
    
    thread globallogic::endgame( winner, endreason );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0x123251c5, Offset: 0x4d8
// Size: 0xc4
function default_ondeadevent( team )
{
    if ( team == "all" )
    {
        winner = level.var_c20ad7aa;
        globallogic_utils::logteamwinstring( "team eliminated", winner );
        thread globallogic::endgame( winner, #"hash_25a63494a0fec424" );
        return;
    }
    
    winner = getwinningteamfromloser( team );
    globallogic_utils::logteamwinstring( "team eliminated", winner );
    thread globallogic::endgame( winner, #"hash_25a63494a0fec424" );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0x5e27bfe2, Offset: 0x5a8
// Size: 0x19c
function function_9fd1cc80( team )
{
    if ( isdefined( level.teams[ team ] ) )
    {
        eliminatedstring = game.strings[ #"enemies_eliminated" ];
        iprintln( eliminatedstring );
        setdvar( #"ui_text_endreason", eliminatedstring );
        winner = globallogic::determineteamwinnerbygamestat( "teamScores" );
        globallogic_utils::logteamwinstring( "team eliminated", winner );
        thread globallogic::endgame( winner, eliminatedstring );
        return;
    }
    
    setdvar( #"ui_text_endreason", game.strings[ #"tie" ] );
    globallogic_utils::logteamwinstring( "tie" );
    
    if ( level.teambased )
    {
        thread globallogic::endgame( "tie", game.strings[ #"tie" ] );
        return;
    }
    
    thread globallogic::endgame( undefined, game.strings[ #"tie" ] );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0xc3278fbc, Offset: 0x750
// Size: 0xe, Type: bool
function function_8fd32d09( *team )
{
    return false;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0xb0d945dd, Offset: 0x768
// Size: 0xc8, Type: bool
function function_b8fe203b( team )
{
    if ( function_8fd32d09( team ) )
    {
        return true;
    }
    
    if ( level.playercount[ team ] == 1 && function_a1ef346b( team ).size == 1 )
    {
        assert( function_a1ef346b( team ).size == 1 );
        
        if ( function_a1ef346b( team )[ 0 ].lives > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0xb49639d3, Offset: 0x838
// Size: 0x9c
function function_b322d0f3( team )
{
    if ( function_b8fe203b( team ) )
    {
        return;
    }
    
    if ( team == "all" )
    {
        thread globallogic::endgame( level.var_c20ad7aa, #"hash_25a63494a0fec424" );
        return;
    }
    
    thread globallogic::endgame( util::getotherteam( team ), #"hash_25a63494a0fec424" );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0x2c28687f, Offset: 0x8e0
// Size: 0xc
function default_onalivecountchange( *team )
{
    
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0x49a3f862, Offset: 0x8f8
// Size: 0x10
function default_onroundendgame( winner )
{
    return winner;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 1
// Checksum 0xc38bf0fc, Offset: 0x910
// Size: 0xc
function default_ononeleftevent( *team )
{
    
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0
// Checksum 0xfe7f4de, Offset: 0x928
// Size: 0x114
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
        /#
            if ( isdefined( winner ) )
            {
                print( "<dev string:xad>" + winner.name );
            }
            else
            {
                print( "<dev string:xc2>" );
            }
        #/
    }
    
    setdvar( #"ui_text_endreason", game.strings[ #"time_limit_reached" ] );
    thread globallogic::endgame( winner, game.strings[ #"time_limit_reached" ] );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0
// Checksum 0xfbd7a331, Offset: 0xa48
// Size: 0x130, Type: bool
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
        /#
            if ( isdefined( winner ) )
            {
                print( "<dev string:xd5>" + winner.name );
            }
            else
            {
                print( "<dev string:xea>" );
            }
        #/
    }
    
    setdvar( #"ui_text_endreason", game.strings[ #"score_limit_reached" ] );
    thread globallogic::endgame( winner, game.strings[ #"score_limit_reached" ] );
    return true;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 2
// Checksum 0x616e0af4, Offset: 0xb80
// Size: 0x17c
function default_onspawnspectator( origin, angles )
{
    if ( isdefined( origin ) && isdefined( angles ) )
    {
        self spawn( origin, angles );
        return;
    }
    
    spawnpointname = "cp_global_intermission";
    spawnpoints = struct::get_array( spawnpointname, "targetname" );
    assert( spawnpoints.size, "<dev string:xfd>" + spawnpointname + "<dev string:x10e>" );
    spawnpoint = spawning::get_spawnpoint_random( spawnpoints );
    assert( isdefined( spawnpoint.origin ), "<dev string:x148>" + spawnpointname + "<dev string:x15d>" );
    assert( isdefined( spawnpoint.angles ), "<dev string:x148>" + spawnpointname + "<dev string:x171>" + spawnpoint.origin + "<dev string:x17a>" );
    self spawn( spawnpoint.origin, spawnpoint.angles );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0
// Checksum 0x92b6ee6d, Offset: 0xd08
// Size: 0xac
function default_onspawnintermission()
{
    spawnpointname = "cp_global_intermission";
    spawnpoints = struct::get_array( spawnpointname, "targetname" );
    spawnpoint = spawnpoints[ 0 ];
    
    if ( isdefined( spawnpoint ) )
    {
        self spawn( spawnpoint.origin, spawnpoint.angles );
        return;
    }
    
    /#
        util::error( "<dev string:x18c>" + spawnpointname + "<dev string:x193>" );
    #/
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 0
// Checksum 0xa47231d6, Offset: 0xdc0
// Size: 0x6a
function default_gettimelimit()
{
    var_a25a9aa9 = getgametypesetting( #"timelimit" );
    
    if ( !isdefined( var_a25a9aa9 ) )
    {
        var_a25a9aa9 = level.timelimitmax;
    }
    
    return math::clamp( var_a25a9aa9, level.timelimitmin, level.timelimitmax );
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 4
// Checksum 0x5c790e3, Offset: 0xe38
// Size: 0x26, Type: bool
function default_getteamkillpenalty( *einflictor, *attacker, *smeansofdeath, *weapon )
{
    return false;
}

// Namespace globallogic_defaults/globallogic_defaults
// Params 4
// Checksum 0xdbc7c938, Offset: 0xe68
// Size: 0x26, Type: bool
function default_getteamkillscore( *einflictor, *attacker, *smeansofdeath, *weapon )
{
    return false;
}

