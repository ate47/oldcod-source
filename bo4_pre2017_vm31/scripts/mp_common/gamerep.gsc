#using scripts/core_common/bots/bot;
#using scripts/core_common/rank_shared;

#namespace gamerep;

// Namespace gamerep/gamerep
// Params 0
// Checksum 0xb8559805, Offset: 0x1e8
// Size: 0xb4
function init()
{
    if ( !isgamerepenabled() )
    {
        return;
    }
    
    if ( isgamerepinitialized() )
    {
        return;
    }
    
    game.gamerepinitialized = 1;
    game.gamerep[ "players" ] = [];
    game.gamerep[ "playerNames" ] = [];
    game.gamerep[ "max" ] = [];
    game.gamerep[ "playerCount" ] = 0;
    gamerepinitializeparams();
}

// Namespace gamerep/gamerep
// Params 0
// Checksum 0x49a2ba9f, Offset: 0x2a8
// Size: 0x30, Type: bool
function isgamerepinitialized()
{
    if ( !isdefined( game.gamerepinitialized ) || !game.gamerepinitialized )
    {
        return false;
    }
    
    return true;
}

// Namespace gamerep/gamerep
// Params 0
// Checksum 0xa96177f7, Offset: 0x2e0
// Size: 0x32, Type: bool
function isgamerepenabled()
{
    if ( bot::is_bot_ranked_match() )
    {
        return false;
    }
    
    if ( !level.rankedmatch )
    {
        return false;
    }
    
    return true;
}

// Namespace gamerep/gamerep
// Params 0
// Checksum 0x7ffcccf5, Offset: 0x320
// Size: 0xdda
function gamerepinitializeparams()
{
    threshold_exceeded_score = 0;
    threshold_exceeded_score_per_min = 1;
    threshold_exceeded_kills = 2;
    threshold_exceeded_deaths = 3;
    threshold_exceeded_kd_ratio = 4;
    threshold_exceeded_kills_per_min = 5;
    threshold_exceeded_plants = 6;
    threshold_exceeded_defuses = 7;
    threshold_exceeded_captures = 8;
    threshold_exceeded_defends = 9;
    threshold_exceeded_total_time_played = 10;
    threshold_exceeded_tactical_insertion_use = 11;
    threshold_exceeded_join_attempts = 12;
    threshold_exceeded_xp = 13;
    threshold_exceeded_splitscreen = 14;
    game.gamerep[ "params" ] = [];
    game.gamerep[ "params" ][ 0 ] = "score";
    game.gamerep[ "params" ][ 1 ] = "scorePerMin";
    game.gamerep[ "params" ][ 2 ] = "kills";
    game.gamerep[ "params" ][ 3 ] = "deaths";
    game.gamerep[ "params" ][ 4 ] = "killDeathRatio";
    game.gamerep[ "params" ][ 5 ] = "killsPerMin";
    game.gamerep[ "params" ][ 6 ] = "plants";
    game.gamerep[ "params" ][ 7 ] = "defuses";
    game.gamerep[ "params" ][ 8 ] = "captures";
    game.gamerep[ "params" ][ 9 ] = "defends";
    game.gamerep[ "params" ][ 10 ] = "totalTimePlayed";
    game.gamerep[ "params" ][ 11 ] = "tacticalInsertions";
    game.gamerep[ "params" ][ 12 ] = "joinAttempts";
    game.gamerep[ "params" ][ 13 ] = "xp";
    game.gamerep[ "ignoreParams" ] = [];
    game.gamerep[ "ignoreParams" ][ 0 ] = "totalTimePlayed";
    game.gamerep[ "gameLimit" ] = [];
    game.gamerep[ "gameLimit" ][ "default" ] = [];
    game.gamerep[ "gameLimit" ][ "tdm" ] = [];
    game.gamerep[ "gameLimit" ][ "dm" ] = [];
    game.gamerep[ "gameLimit" ][ "dom" ] = [];
    game.gamerep[ "gameLimit" ][ "hq" ] = [];
    game.gamerep[ "gameLimit" ][ "sd" ] = [];
    game.gamerep[ "gameLimit" ][ "dem" ] = [];
    game.gamerep[ "gameLimit" ][ "ctf" ] = [];
    game.gamerep[ "gameLimit" ][ "koth" ] = [];
    game.gamerep[ "gameLimit" ][ "conf" ] = [];
    game.gamerep[ "gameLimit" ][ "id" ][ "score" ] = threshold_exceeded_score;
    game.gamerep[ "gameLimit" ][ "default" ][ "score" ] = 20000;
    game.gamerep[ "gameLimit" ][ "id" ][ "scorePerMin" ] = threshold_exceeded_score_per_min;
    game.gamerep[ "gameLimit" ][ "default" ][ "scorePerMin" ] = 250;
    game.gamerep[ "gameLimit" ][ "dem" ][ "scorePerMin" ] = 1000;
    game.gamerep[ "gameLimit" ][ "tdm" ][ "scorePerMin" ] = 700;
    game.gamerep[ "gameLimit" ][ "dm" ][ "scorePerMin" ] = 950;
    game.gamerep[ "gameLimit" ][ "dom" ][ "scorePerMin" ] = 1000;
    game.gamerep[ "gameLimit" ][ "sd" ][ "scorePerMin" ] = 200;
    game.gamerep[ "gameLimit" ][ "ctf" ][ "scorePerMin" ] = 600;
    game.gamerep[ "gameLimit" ][ "hq" ][ "scorePerMin" ] = 1000;
    game.gamerep[ "gameLimit" ][ "koth" ][ "scorePerMin" ] = 1000;
    game.gamerep[ "gameLimit" ][ "conf" ][ "scorePerMin" ] = 1000;
    game.gamerep[ "gameLimit" ][ "id" ][ "kills" ] = threshold_exceeded_kills;
    game.gamerep[ "gameLimit" ][ "default" ][ "kills" ] = 75;
    game.gamerep[ "gameLimit" ][ "tdm" ][ "kills" ] = 40;
    game.gamerep[ "gameLimit" ][ "sd" ][ "kills" ] = 15;
    game.gamerep[ "gameLimit" ][ "dm" ][ "kills" ] = 31;
    game.gamerep[ "gameLimit" ][ "id" ][ "deaths" ] = threshold_exceeded_deaths;
    game.gamerep[ "gameLimit" ][ "default" ][ "deaths" ] = 50;
    game.gamerep[ "gameLimit" ][ "dm" ][ "deaths" ] = 15;
    game.gamerep[ "gameLimit" ][ "tdm" ][ "deaths" ] = 40;
    game.gamerep[ "gameLimit" ][ "id" ][ "killDeathRatio" ] = threshold_exceeded_kd_ratio;
    game.gamerep[ "gameLimit" ][ "default" ][ "killDeathRatio" ] = 30;
    game.gamerep[ "gameLimit" ][ "tdm" ][ "killDeathRatio" ] = 50;
    game.gamerep[ "gameLimit" ][ "sd" ][ "killDeathRatio" ] = 20;
    game.gamerep[ "gameLimit" ][ "id" ][ "killsPerMin" ] = threshold_exceeded_kills_per_min;
    game.gamerep[ "gameLimit" ][ "default" ][ "killsPerMin" ] = 15;
    game.gamerep[ "gameLimit" ][ "id" ][ "plants" ] = threshold_exceeded_plants;
    game.gamerep[ "gameLimit" ][ "default" ][ "plants" ] = 10;
    game.gamerep[ "gameLimit" ][ "id" ][ "defuses" ] = threshold_exceeded_defuses;
    game.gamerep[ "gameLimit" ][ "default" ][ "defuses" ] = 10;
    game.gamerep[ "gameLimit" ][ "id" ][ "captures" ] = threshold_exceeded_captures;
    game.gamerep[ "gameLimit" ][ "default" ][ "captures" ] = 30;
    game.gamerep[ "gameLimit" ][ "id" ][ "defends" ] = threshold_exceeded_defends;
    game.gamerep[ "gameLimit" ][ "default" ][ "defends" ] = 50;
    game.gamerep[ "gameLimit" ][ "id" ][ "totalTimePlayed" ] = threshold_exceeded_total_time_played;
    game.gamerep[ "gameLimit" ][ "default" ][ "totalTimePlayed" ] = 600;
    game.gamerep[ "gameLimit" ][ "dom" ][ "totalTimePlayed" ] = 600;
    game.gamerep[ "gameLimit" ][ "dem" ][ "totalTimePlayed" ] = 1140;
    game.gamerep[ "gameLimit" ][ "id" ][ "tacticalInsertions" ] = threshold_exceeded_tactical_insertion_use;
    game.gamerep[ "gameLimit" ][ "default" ][ "tacticalInsertions" ] = 20;
    game.gamerep[ "gameLimit" ][ "id" ][ "joinAttempts" ] = threshold_exceeded_join_attempts;
    game.gamerep[ "gameLimit" ][ "default" ][ "joinAttempts" ] = 3;
    game.gamerep[ "gameLimit" ][ "id" ][ "xp" ] = threshold_exceeded_xp;
    game.gamerep[ "gameLimit" ][ "default" ][ "xp" ] = 25000;
    game.gamerep[ "gameLimit" ][ "id" ][ "splitscreen" ] = threshold_exceeded_splitscreen;
    game.gamerep[ "gameLimit" ][ "default" ][ "splitscreen" ] = 8;
}

// Namespace gamerep/gamerep
// Params 0
// Checksum 0xc1b5422d, Offset: 0x1108
// Size: 0x2ca
function gamerepplayerconnected()
{
    if ( !isgamerepenabled() )
    {
        return;
    }
    
    name = self.name;
    
    /#
    #/
    
    if ( !isdefined( game.gamerep[ "players" ][ name ] ) )
    {
        game.gamerep[ "players" ][ name ] = [];
        
        for ( j = 0; j < game.gamerep[ "params" ].size ; j++ )
        {
            paramname = game.gamerep[ "params" ][ j ];
            game.gamerep[ "players" ][ name ][ paramname ] = 0;
        }
        
        game.gamerep[ "players" ][ name ][ "splitscreen" ] = self issplitscreen();
        game.gamerep[ "players" ][ name ][ "joinAttempts" ] = 1;
        game.gamerep[ "players" ][ name ][ "connected" ] = 1;
        game.gamerep[ "players" ][ name ][ "xpStart" ] = self rank::getrankxpstat();
        game.gamerep[ "playerNames" ][ game.gamerep[ "playerCount" ] ] = name;
        game.gamerep[ "playerCount" ]++;
        return;
    }
    
    if ( !game.gamerep[ "players" ][ name ][ "connected" ] )
    {
        game.gamerep[ "players" ][ name ][ "joinAttempts" ]++;
        game.gamerep[ "players" ][ name ][ "connected" ] = 1;
        game.gamerep[ "players" ][ name ][ "xpStart" ] = self rank::getrankxpstat();
    }
}

// Namespace gamerep/gamerep
// Params 0
// Checksum 0x666023bc, Offset: 0x13e0
// Size: 0xc6
function gamerepplayerdisconnected()
{
    if ( !isgamerepenabled() )
    {
        return;
    }
    
    name = self.name;
    
    if ( !isdefined( game.gamerep[ "players" ][ name ] ) || !isdefined( self.pers[ "summary" ] ) )
    {
        return;
    }
    
    /#
    #/
    
    self gamerepupdatenonpersistentplayerinformation();
    self gamerepupdatepersistentplayerinformation();
    game.gamerep[ "players" ][ name ][ "connected" ] = 0;
}

// Namespace gamerep/gamerep
// Params 0
// Checksum 0x30b4dc45, Offset: 0x14b0
// Size: 0x102
function gamerepupdatenonpersistentplayerinformation()
{
    name = self.name;
    
    if ( !isdefined( game.gamerep[ "players" ][ name ] ) )
    {
        return;
    }
    
    game.gamerep[ "players" ][ name ][ "totalTimePlayed" ] = game.gamerep[ "players" ][ name ][ "totalTimePlayed" ] + self.timeplayed[ "total" ];
    
    if ( isdefined( self.tacticalinsertioncount ) )
    {
        game.gamerep[ "players" ][ name ][ "tacticalInsertions" ] = game.gamerep[ "players" ][ name ][ "tacticalInsertions" ] + self.tacticalinsertioncount;
    }
}

// Namespace gamerep/gamerep
// Params 0
// Checksum 0x42f50493, Offset: 0x15c0
// Size: 0x47a
function gamerepupdatepersistentplayerinformation()
{
    name = self.name;
    
    if ( !isdefined( game.gamerep[ "players" ][ name ] ) )
    {
        return;
    }
    
    if ( game.gamerep[ "players" ][ name ][ "totalTimePlayed" ] != 0 )
    {
        timeplayed = game.gamerep[ "players" ][ name ][ "totalTimePlayed" ];
    }
    else
    {
        timeplayed = 1;
    }
    
    game.gamerep[ "players" ][ name ][ "score" ] = self.score;
    game.gamerep[ "players" ][ name ][ "scorePerMin" ] = int( game.gamerep[ "players" ][ name ][ "score" ] / timeplayed / 60 );
    game.gamerep[ "players" ][ name ][ "kills" ] = self.kills;
    game.gamerep[ "players" ][ name ][ "deaths" ] = self.deaths;
    
    if ( game.gamerep[ "players" ][ name ][ "deaths" ] != 0 )
    {
        game.gamerep[ "players" ][ name ][ "killDeathRatio" ] = int( game.gamerep[ "players" ][ name ][ "kills" ] / game.gamerep[ "players" ][ name ][ "deaths" ] * 100 );
    }
    else
    {
        game.gamerep[ "players" ][ name ][ "killDeathRatio" ] = game.gamerep[ "players" ][ name ][ "kills" ] * 100;
    }
    
    game.gamerep[ "players" ][ name ][ "killsPerMin" ] = int( game.gamerep[ "players" ][ name ][ "kills" ] / timeplayed / 60 );
    game.gamerep[ "players" ][ name ][ "plants" ] = self.plants;
    game.gamerep[ "players" ][ name ][ "defuses" ] = self.defuses;
    game.gamerep[ "players" ][ name ][ "captures" ] = self.captures;
    game.gamerep[ "players" ][ name ][ "defends" ] = self.defends;
    game.gamerep[ "players" ][ name ][ "xp" ] = self rank::getrankxpstat() - game.gamerep[ "players" ][ name ][ "xpStart" ];
    game.gamerep[ "players" ][ name ][ "xpStart" ] = self rank::getrankxpstat();
}

// Namespace gamerep/gamerep
// Params 2
// Checksum 0x7e2076dd, Offset: 0x1a48
// Size: 0x8c
function getparamvalueforplayer( playername, paramname )
{
    if ( isdefined( game.gamerep[ "players" ][ playername ][ paramname ] ) )
    {
        return game.gamerep[ "players" ][ playername ][ paramname ];
    }
    
    assertmsg( "<dev string:x28>" + paramname + "<dev string:x3b>" );
}

// Namespace gamerep/gamerep
// Params 1
// Checksum 0x3f2e9476, Offset: 0x1ae0
// Size: 0x104, Type: bool
function isgamerepparamvalid( paramname )
{
    gametype = level.gametype;
    
    if ( !isdefined( game.gamerep ) )
    {
        return false;
    }
    
    if ( !isdefined( game.gamerep[ "gameLimit" ] ) )
    {
        return false;
    }
    
    if ( !isdefined( game.gamerep[ "gameLimit" ][ gametype ] ) )
    {
        return false;
    }
    
    if ( !isdefined( game.gamerep[ "gameLimit" ][ gametype ][ paramname ] ) )
    {
        return false;
    }
    
    if ( !isdefined( game.gamerep[ "gameLimit" ][ gametype ][ paramname ] ) && !isdefined( game.gamerep[ "gameLimit" ][ "default" ][ paramname ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace gamerep/gamerep
// Params 1
// Checksum 0xd9faec2f, Offset: 0x1bf0
// Size: 0x34, Type: bool
function isgamerepparamignoredforreporting( paramname )
{
    if ( isdefined( game.gamerep[ "ignoreParams" ][ paramname ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace gamerep/gamerep
// Params 1
// Checksum 0xfd21a65e, Offset: 0x1c30
// Size: 0x10c
function getgamerepparamlimit( paramname )
{
    gametype = level.gametype;
    
    if ( isdefined( game.gamerep[ "gameLimit" ][ gametype ] ) )
    {
        if ( isdefined( game.gamerep[ "gameLimit" ][ gametype ][ paramname ] ) )
        {
            return game.gamerep[ "gameLimit" ][ gametype ][ paramname ];
        }
    }
    
    if ( isdefined( game.gamerep[ "gameLimit" ][ "default" ][ paramname ] ) )
    {
        return game.gamerep[ "gameLimit" ][ "default" ][ paramname ];
    }
    
    assertmsg( "<dev string:x51>" + paramname + "<dev string:x6f>" );
}

// Namespace gamerep/gamerep
// Params 2
// Checksum 0xacc0513, Offset: 0x1d48
// Size: 0x9c
function setmaximumparamvalueforcurrentgame( paramname, value )
{
    if ( !isdefined( game.gamerep[ "max" ][ paramname ] ) )
    {
        game.gamerep[ "max" ][ paramname ] = value;
        return;
    }
    
    if ( game.gamerep[ "max" ][ paramname ] < value )
    {
        game.gamerep[ "max" ][ paramname ] = value;
    }
}

// Namespace gamerep/gamerep
// Params 0
// Checksum 0xa69929a7, Offset: 0x1df0
// Size: 0x8e
function gamerepupdateinformationforround()
{
    if ( !isgamerepenabled() )
    {
        return;
    }
    
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        player gamerepupdatenonpersistentplayerinformation();
    }
}

// Namespace gamerep/gamerep
// Params 0
// Checksum 0x2262aaf4, Offset: 0x1e88
// Size: 0x2fc
function gamerepanalyzeandreport()
{
    if ( !isgamerepenabled() )
    {
        return;
    }
    
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        player gamerepupdatepersistentplayerinformation();
    }
    
    splitscreenplayercount = 0;
    
    for ( i = 0; i < game.gamerep[ "playerNames" ].size ; i++ )
    {
        playername = game.gamerep[ "playerNames" ][ i ];
        
        for ( j = 0; j < game.gamerep[ "params" ].size ; j++ )
        {
            paramname = game.gamerep[ "params" ][ j ];
            
            if ( isgamerepparamvalid( paramname ) )
            {
                setmaximumparamvalueforcurrentgame( paramname, getparamvalueforplayer( playername, paramname ) );
            }
        }
        
        paramname = "splitscreen";
        splitscreenplayercount += getparamvalueforplayer( playername, paramname );
    }
    
    setmaximumparamvalueforcurrentgame( paramname, splitscreenplayercount );
    
    for ( j = 0; j < game.gamerep[ "params" ].size ; j++ )
    {
        paramname = game.gamerep[ "params" ][ j ];
        
        if ( isgamerepparamvalid( paramname ) && game.gamerep[ "max" ][ paramname ] >= getgamerepparamlimit( paramname ) )
        {
            gamerepprepareandreport( paramname );
        }
    }
    
    paramname = "splitscreen";
    
    if ( game.gamerep[ "max" ][ paramname ] >= getgamerepparamlimit( paramname ) )
    {
        gamerepprepareandreport( paramname );
    }
}

// Namespace gamerep/gamerep
// Params 1
// Checksum 0x4fd18227, Offset: 0x2190
// Size: 0x8c
function gamerepprepareandreport( paramname )
{
    if ( !isdefined( game.gamerep[ "gameLimit" ][ "id" ][ paramname ] ) )
    {
        return;
    }
    
    if ( isgamerepparamignoredforreporting( paramname ) )
    {
        return;
    }
    
    gamerepthresholdexceeded( game.gamerep[ "gameLimit" ][ "id" ][ paramname ] );
}

