#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/bb_shared;
#using scripts/core_common/bots/bot;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/persistence_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/globallogic_utils;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/gametypes/wager;
#using scripts/mp_common/killstreaks/counteruav;
#using scripts/mp_common/killstreaks/emp;
#using scripts/mp_common/killstreaks/killstreak_weapons;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/scoreevents;
#using scripts/mp_common/util;

#namespace globallogic_score;

// Namespace globallogic_score/globallogic_score
// Params 0, eflags: 0x2
// Checksum 0x75662fe4, Offset: 0xd50
// Size: 0xcc
function autoexec __init__()
{
    level.scoreevents_givekillstats = &givekillstats;
    level.scoreevents_processassist = &processassist;
    clientfield::register( "clientuimodel", "hudItems.lplevel.progress", 1, 5, "float" );
    clientfield::register( "clientuimodel", "hudItems.lplevel.level", 1, 3, "int" );
    clientfield::register( "clientuimodel", "hudItems.lplevel.unlockTokens", 1, 3, "int" );
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0xca6be412, Offset: 0xe28
// Size: 0x8bc
function updatematchbonusscores( winner )
{
    if ( !game.timepassed )
    {
        return;
    }
    
    if ( !level.rankedmatch )
    {
        updatecustomgamewinner( winner );
        return;
    }
    
    if ( level.teambased && isdefined( winner ) )
    {
        if ( winner == "endregulation" )
        {
            return;
        }
    }
    
    if ( !level.timelimit || level.forcedend )
    {
        gamelength = globallogic_utils::gettimepassed() / 1000;
        gamelength = min( gamelength, 1200 );
        
        if ( level.gametype == "twar" && game.roundsplayed > 0 )
        {
            gamelength += level.timelimit * 60;
        }
    }
    else
    {
        gamelength = level.timelimit * 60;
    }
    
    if ( level.teambased )
    {
        winningteam = "tie";
        
        foreach ( team in level.teams )
        {
            if ( winner == team )
            {
                winningteam = team;
                break;
            }
        }
        
        if ( winningteam != "tie" )
        {
            winnerscale = 1;
            loserscale = 0.5;
        }
        else
        {
            winnerscale = 0.75;
            loserscale = 0.75;
        }
        
        players = level.players;
        
        for ( i = 0; i < players.size ; i++ )
        {
            player = players[ i ];
            
            if ( player.timeplayed[ "total" ] < 1 || player.pers[ "participation" ] < 1 )
            {
                player thread rank::endgameupdate();
                continue;
            }
            
            totaltimeplayed = player.timeplayed[ "total" ];
            
            if ( totaltimeplayed > gamelength )
            {
                totaltimeplayed = gamelength;
            }
            
            if ( level.hostforcedend && player ishost() )
            {
                continue;
            }
            
            if ( player.pers[ "score" ] < 0 )
            {
                continue;
            }
            
            spm = player rank::getspm();
            
            if ( winningteam == "tie" )
            {
                playerscore = int( winnerscale * gamelength / 60 * spm * totaltimeplayed / gamelength );
                player thread givematchbonus( "tie", playerscore );
                player.matchbonus = playerscore;
            }
            else if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] == winningteam )
            {
                playerscore = int( winnerscale * gamelength / 60 * spm * totaltimeplayed / gamelength );
                player thread givematchbonus( "win", playerscore );
                player.matchbonus = playerscore;
            }
            else if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] != "spectator" )
            {
                playerscore = int( loserscale * gamelength / 60 * spm * totaltimeplayed / gamelength );
                player thread givematchbonus( "loss", playerscore );
                player.matchbonus = playerscore;
            }
            
            player.pers[ "totalMatchBonus" ] = player.pers[ "totalMatchBonus" ] + player.matchbonus;
        }
        
        return;
    }
    
    if ( isdefined( winner ) )
    {
        winnerscale = 1;
        loserscale = 0.5;
    }
    else
    {
        winnerscale = 0.75;
        loserscale = 0.75;
    }
    
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( player.timeplayed[ "total" ] < 1 || player.pers[ "participation" ] < 1 )
        {
            player thread rank::endgameupdate();
            continue;
        }
        
        totaltimeplayed = player.timeplayed[ "total" ];
        
        if ( totaltimeplayed > gamelength )
        {
            totaltimeplayed = gamelength;
        }
        
        spm = player rank::getspm();
        iswinner = 0;
        
        for ( pidx = 0; pidx < min( level.placement[ "all" ][ 0 ].size, 3 ) ; pidx++ )
        {
            if ( level.placement[ "all" ][ pidx ] != player )
            {
                continue;
            }
            
            iswinner = 1;
        }
        
        if ( iswinner )
        {
            playerscore = int( winnerscale * gamelength / 60 * spm * totaltimeplayed / gamelength );
            player thread givematchbonus( "win", playerscore );
            player.matchbonus = playerscore;
        }
        else
        {
            playerscore = int( loserscale * gamelength / 60 * spm * totaltimeplayed / gamelength );
            player thread givematchbonus( "loss", playerscore );
            player.matchbonus = playerscore;
        }
        
        player.pers[ "totalMatchBonus" ] = player.pers[ "totalMatchBonus" ] + player.matchbonus;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0xcd43ed69, Offset: 0x16f0
// Size: 0x26a
function updatecustomgamewinner( winner )
{
    if ( !level.mpcustommatch )
    {
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( !isdefined( winner ) )
        {
            player.pers[ "victory" ] = 0;
        }
        else if ( level.teambased )
        {
            if ( player.team == winner )
            {
                player.pers[ "victory" ] = 2;
            }
            else if ( winner == "tie" )
            {
                player.pers[ "victory" ] = 1;
            }
            else
            {
                player.pers[ "victory" ] = 0;
            }
        }
        else
        {
            iswinner = 0;
            
            for ( pidx = 0; pidx < min( level.placement[ "all" ].size, 3 ) ; pidx++ )
            {
                if ( level.placement[ "all" ][ pidx ] != player )
                {
                    continue;
                }
                
                iswinner = 1;
            }
            
            if ( iswinner )
            {
                player.pers[ "victory" ] = 2;
            }
            else
            {
                player.pers[ "victory" ] = 0;
            }
        }
        
        player.victory = player.pers[ "victory" ];
        player.pers[ "sbtimeplayed" ] = player.timeplayed[ "total" ];
        player.sbtimeplayed = player.pers[ "sbtimeplayed" ];
    }
}

// Namespace globallogic_score/globallogic_score
// Params 2
// Checksum 0x37ebcebe, Offset: 0x1968
// Size: 0x7c
function givematchbonus( scoretype, score )
{
    self endon( #"disconnect" );
    level waittill( "give_match_bonus" );
    
    if ( scoreevents::shouldaddrankxp( self ) )
    {
        self addrankxpvalue( scoretype, score );
    }
    
    self rank::endgameupdate();
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0x9c5af3ae, Offset: 0x19f0
// Size: 0x13e
function gethighestscoringplayer()
{
    players = level.players;
    winner = undefined;
    tie = 0;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( !isdefined( players[ i ].pointstowin ) )
        {
            continue;
        }
        
        if ( players[ i ].pointstowin < 1 )
        {
            continue;
        }
        
        if ( !isdefined( winner ) || players[ i ].pointstowin > winner.pointstowin )
        {
            winner = players[ i ];
            tie = 0;
            continue;
        }
        
        if ( players[ i ].pointstowin == winner.pointstowin )
        {
            tie = 1;
        }
    }
    
    if ( tie || !isdefined( winner ) )
    {
        return undefined;
    }
    
    return winner;
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0xa973ac18, Offset: 0x1b38
// Size: 0x3c
function resetplayerscorechainandmomentum( player )
{
    player thread _setplayermomentum( self, 0 );
    player thread resetscorechain();
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0x7e0fb615, Offset: 0x1b80
// Size: 0x2c
function resetscorechain()
{
    self notify( #"reset_score_chain" );
    self.scorechain = 0;
    self.rankupdatetotal = 0;
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0xe1b5ae11, Offset: 0x1bb8
// Size: 0x5c
function scorechaintimer()
{
    self notify( #"score_chain_timer" );
    self endon( #"reset_score_chain" );
    self endon( #"score_chain_timer" );
    self endon( #"death" );
    self endon( #"disconnect" );
    wait 20;
    self thread resetscorechain();
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x7eeeecde, Offset: 0x1c20
// Size: 0x54
function roundtonearestfive( score )
{
    rounding = score % 5;
    
    if ( rounding <= 2 )
    {
        return ( score - rounding );
    }
    
    return score + 5 - rounding;
}

// Namespace globallogic_score/globallogic_score
// Params 7
// Checksum 0x40825d59, Offset: 0x1c80
// Size: 0x18c
function giveplayermomentumnotification( score, label, descvalue, countstowardrampage, weapon, combatefficiencybonus, eventindex )
{
    if ( !isdefined( combatefficiencybonus ) )
    {
        combatefficiencybonus = 0;
    }
    
    score += combatefficiencybonus;
    
    if ( score != 0 )
    {
        self luinotifyevent( &"score_event", 4, label, score, combatefficiencybonus, eventindex );
        self luinotifyeventtospectators( &"score_event", 4, label, score, combatefficiencybonus, eventindex );
    }
    
    score = score;
    
    if ( score > 0 && self hasperk( "specialty_earnmoremomentum" ) )
    {
        score = roundtonearestfive( int( score * getdvarfloat( "perk_killstreakMomentumMultiplier" ) + 0.5 ) );
    }
    
    if ( isalive( self ) )
    {
        _setplayermomentum( self, self.pers[ "momentum" ] + score );
    }
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0xf66ef184, Offset: 0x1e18
// Size: 0x54
function resetplayermomentumonspawn()
{
    if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks )
    {
        _setplayermomentum( self, 0 );
        self thread resetscorechain();
    }
}

// Namespace globallogic_score/globallogic_score
// Params 5
// Checksum 0xd67305ba, Offset: 0x1e78
// Size: 0x27c
function giveplayermomentum( event, player, victim, descvalue, weapon )
{
    if ( isdefined( level.disablemomentum ) && level.disablemomentum == 1 )
    {
        return;
    }
    
    score = player rank::getscoreinfovalue( event );
    assert( isdefined( score ) );
    label = rank::getscoreinfolabel( event );
    eventindex = level.scoreinfo[ event ][ "row" ];
    countstowardrampage = rank::doesscoreinfocounttowardrampage( event );
    var_66b8395e = rank::getcombatefficiencyevent( event );
    
    if ( isdefined( var_66b8395e ) && player ability_util::gadget_combat_efficiency_enabled() )
    {
        combatefficiencyscore = player rank::getscoreinfovalue( var_66b8395e );
        assert( isdefined( combatefficiencyscore ) );
        player ability_util::gadget_combat_efficiency_power_drain( combatefficiencyscore );
    }
    
    if ( event == "death" )
    {
        _setplayermomentum( victim, victim.pers[ "momentum" ] + score );
    }
    
    if ( score == 0 )
    {
        return;
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( !isdefined( label ) )
    {
        player giveplayermomentumnotification( score, &"SCORE_BLANK", descvalue, countstowardrampage, weapon, combatefficiencyscore, eventindex );
        return;
    }
    
    player giveplayermomentumnotification( score, label, descvalue, countstowardrampage, weapon, combatefficiencyscore, eventindex );
}

// Namespace globallogic_score/globallogic_score
// Params 5
// Checksum 0x4bb7e403, Offset: 0x2100
// Size: 0x518
function giveplayerscore( event, player, victim, descvalue, weapon )
{
    scorediff = 0;
    momentum = player.pers[ "momentum" ];
    giveplayermomentum( event, player, victim, descvalue, weapon );
    newmomentum = player.pers[ "momentum" ];
    
    if ( level.overrideplayerscore )
    {
        return 0;
    }
    
    pixbeginevent( "level.onPlayerScore" );
    score = player.pers[ "score" ];
    [[ level.onplayerscore ]]( event, player, victim );
    newscore = player.pers[ "score" ];
    pixendevent();
    isusingheropower = 0;
    
    if ( player ability_player::is_using_any_gadget() )
    {
        isusingheropower = 1;
    }
    
    bbprint( "mpplayerscore", "spawnid %d gametime %d type %s player %s delta %d deltamomentum %d team %s isusingheropower %d", getplayerspawnid( player ), gettime(), event, player.name, newscore - score, newmomentum - momentum, player.team, isusingheropower );
    player bb::add_to_stat( "score", newscore - score );
    
    if ( score == newscore )
    {
        return 0;
    }
    
    pixbeginevent( "givePlayerScore" );
    recordplayerstats( player, "score", newscore );
    scorediff = newscore - score;
    challengesenabled = !level.disablechallenges;
    player addplayerstatwithgametype( "score", scorediff );
    
    if ( challengesenabled )
    {
        player addplayerstat( "CAREER_SCORE", scorediff );
    }
    
    if ( level.hardcoremode )
    {
        player addplayerstat( "SCORE_HC", scorediff );
        
        if ( challengesenabled )
        {
            player addplayerstat( "CAREER_SCORE_HC", scorediff );
        }
    }
    
    if ( level.multiteam )
    {
        player addplayerstat( "SCORE_MULTITEAM", scorediff );
        
        if ( challengesenabled )
        {
            player addplayerstat( "CAREER_SCORE_MULTITEAM", scorediff );
        }
    }
    
    if ( !level.disablestattracking && isdefined( player.pers[ "lastHighestScore" ] ) && newscore > player.pers[ "lastHighestScore" ] )
    {
        player setdstat( "HighestStats", "highest_score", newscore );
    }
    
    player persistence::add_recent_stat( 0, 0, "score", scorediff );
    player util::player_contract_event( "score", scorediff );
    
    if ( isdefined( weapon ) && killstreaks::is_killstreak_weapon( weapon ) )
    {
        killstreak = killstreaks::get_from_weapon( weapon );
        killstreakpurchased = 0;
        
        if ( isdefined( killstreak ) && isdefined( level.killstreaks[ killstreak ] ) )
        {
            killstreakpurchased = player util::is_item_purchased( level.killstreaks[ killstreak ].menuname );
        }
        
        player util::player_contract_event( "killstreak_score", scorediff, killstreakpurchased );
    }
    
    pixendevent();
    return scorediff;
}

// Namespace globallogic_score/globallogic_score
// Params 3
// Checksum 0xeb45fbc9, Offset: 0x2620
// Size: 0x154
function default_onplayerscore( event, player, victim )
{
    score = player rank::getscoreinfovalue( event );
    rolescore = player rank::getscoreinfoposition( event );
    assert( isdefined( score ) );
    
    if ( level.wagermatch )
    {
        player thread rank::function_9c4690f5( score );
    }
    
    if ( isdefined( rolescore ) && rolescore )
    {
        _setplayerscore( player, player.pers[ "score" ] + score, player.pers[ "roleScore" ] + score );
        return;
    }
    
    _setplayerscore( player, player.pers[ "score" ] + score, player.pers[ "roleScore" ] );
}

// Namespace globallogic_score/globallogic_score
// Params 3
// Checksum 0xfc04383d, Offset: 0x2780
// Size: 0x180
function _setplayerscore( player, score, rolescore )
{
    if ( score != player.pers[ "score" ] )
    {
        if ( !level.rankedmatch )
        {
            player thread rank::function_9c4690f5( score - player.pers[ "score" ] );
        }
        
        player.pers[ "score" ] = score;
        player.score = player.pers[ "score" ];
        recordplayerstats( player, "score", player.pers[ "score" ] );
        
        if ( level.wagermatch )
        {
            player thread wager::player_scored();
        }
    }
    
    if ( isdefined( rolescore ) && rolescore != player.pers[ "roleScore" ] )
    {
        player.pers[ "roleScore" ] = rolescore;
        player.rolescore = player.pers[ "roleScore" ];
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x2279115d, Offset: 0x2908
// Size: 0x20
function _getplayerscore( player )
{
    return player.pers[ "score" ];
}

// Namespace globallogic_score/globallogic_score
// Params 4
// Checksum 0x60d265c6, Offset: 0x2930
// Size: 0xc4
function function_86cd0629( event, player, victim, weapon )
{
    lp = player rank::function_481d607( event );
    assert( isdefined( lp ) );
    
    if ( lp == 0 )
    {
        return;
    }
    
    function_dd07aaa3( player, player.pers[ "lpSystem" ].total + lp );
    function_d58a3d95( player );
}

// Namespace globallogic_score/globallogic_score
// Params 2
// Checksum 0xac25fd7, Offset: 0x2a00
// Size: 0x64
function function_dd07aaa3( player, lp )
{
    player.pers[ "lpSystem" ].total = lp;
    player.var_b0ef29c1 = player.pers[ "lpSystem" ].total;
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x541e8428, Offset: 0x2a70
// Size: 0x2a
function function_5468045f( player )
{
    return player.pers[ "lpSystem" ].total;
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0xc1d33c38, Offset: 0x2aa8
// Size: 0x164
function function_d58a3d95( player )
{
    var_8ba3eeca = int( tablelookupcolumnforrow( level.var_4712114f, player.pers[ "lpSystem" ].lplevel + 2 + 1, 1 ) );
    
    if ( player.pers[ "lpSystem" ].total >= var_8ba3eeca )
    {
        function_75584869( player );
        var_8ba3eeca = int( tablelookupcolumnforrow( level.var_4712114f, player.pers[ "lpSystem" ].lplevel + 2 + 1, 1 ) );
    }
    
    player.var_14eb85c = function_26d9328e( player );
    player clientfield::set_player_uimodel( "hudItems.lplevel.progress", player.var_14eb85c );
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x22148a65, Offset: 0x2c18
// Size: 0x132
function function_26d9328e( player )
{
    var_8ba3eeca = int( tablelookupcolumnforrow( level.var_4712114f, player.pers[ "lpSystem" ].lplevel + 2 + 1, 1 ) );
    var_4054f9a7 = int( tablelookupcolumnforrow( level.var_4712114f, player.pers[ "lpSystem" ].lplevel + 2, 1 ) );
    var_17f2aca1 = var_8ba3eeca - var_4054f9a7;
    
    if ( var_17f2aca1 > 0 )
    {
        return ( ( player.pers[ "lpSystem" ].total - var_4054f9a7 ) / var_17f2aca1 );
    }
    
    return 1;
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x673a3ab8, Offset: 0x2d58
// Size: 0x18c
function function_75584869( player )
{
    player.pers[ "lpSystem" ].lplevel++;
    player.pers[ "lpSystem" ].tokens = player.pers[ "lpSystem" ].tokens + int( tablelookupcolumnforrow( level.var_4712114f, player.pers[ "lpSystem" ].lplevel + 2, 5 ) );
    player clientfield::set_player_uimodel( "hudItems.lplevel.level", player.pers[ "lpSystem" ].lplevel );
    player.lplevel = player.pers[ "lpSystem" ].lplevel;
    luinotifyevent( &"player_level_up", 1, player.pers[ "lpSystem" ].lplevel );
    player playsoundtoplayer( "uin_mp_level_unlock", player );
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0xd2a3f113, Offset: 0x2ef0
// Size: 0x18a
function playtop3sounds()
{
    waitframe( 1 );
    globallogic::updateplacement();
    
    for ( i = 0; i < level.placement[ "all" ].size ; i++ )
    {
        prevscoreplace = level.placement[ "all" ][ i ].prevscoreplace;
        
        if ( !isdefined( prevscoreplace ) )
        {
            prevscoreplace = 1;
        }
        
        currentscoreplace = i + 1;
        
        for ( j = i - 1; j >= 0 ; j-- )
        {
            if ( level.placement[ "all" ][ i ].score == level.placement[ "all" ][ j ].score )
            {
                currentscoreplace--;
            }
        }
        
        wasinthemoney = prevscoreplace <= 3;
        isinthemoney = currentscoreplace <= 3;
        level.placement[ "all" ][ i ].prevscoreplace = currentscoreplace;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x290dfc8f, Offset: 0x3088
// Size: 0xbc
function setpointstowin( points )
{
    self.pers[ "pointstowin" ] = math::clamp( points, 0, 65000 );
    self.pointstowin = self.pers[ "pointstowin" ];
    self thread globallogic::checkscorelimit();
    self thread globallogic::checkroundscorelimit();
    self thread globallogic::checkplayerscorelimitsoon();
    level thread playtop3sounds();
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0xdea03be5, Offset: 0x3150
// Size: 0x3c
function givepointstowin( points )
{
    self setpointstowin( self.pers[ "pointstowin" ] + points );
}

// Namespace globallogic_score/globallogic_score
// Params 3
// Checksum 0xa805e96d, Offset: 0x3198
// Size: 0x290
function _setplayermomentum( player, momentum, updatescore )
{
    if ( !isdefined( updatescore ) )
    {
        updatescore = 1;
    }
    
    momentum = math::clamp( momentum, 0, 2000 );
    oldmomentum = player.pers[ "momentum" ];
    
    if ( momentum == oldmomentum )
    {
        return;
    }
    
    if ( updatescore )
    {
        player bb::add_to_stat( "momentum", momentum - oldmomentum );
    }
    
    if ( momentum > oldmomentum )
    {
        highestmomentumcost = 0;
        numkillstreaks = 0;
        
        if ( isdefined( player.killstreak ) )
        {
            numkillstreaks = player.killstreak.size;
        }
        
        killstreaktypearray = [];
        
        for ( currentkillstreak = 0; currentkillstreak < numkillstreaks ; currentkillstreak++ )
        {
            killstreaktype = killstreaks::get_by_menu_name( player.killstreak[ currentkillstreak ] );
            
            if ( isdefined( killstreaktype ) )
            {
                momentumcost = level.killstreaks[ killstreaktype ].momentumcost;
                
                if ( momentumcost > highestmomentumcost )
                {
                    highestmomentumcost = momentumcost;
                }
                
                killstreaktypearray[ killstreaktypearray.size ] = killstreaktype;
            }
        }
        
        _giveplayerkillstreakinternal( player, momentum, oldmomentum, killstreaktypearray );
        
        while ( highestmomentumcost > 0 && momentum >= highestmomentumcost )
        {
            oldmomentum = 0;
            momentum -= highestmomentumcost;
            _giveplayerkillstreakinternal( player, momentum, oldmomentum, killstreaktypearray );
        }
    }
    
    player.pers[ "momentum" ] = momentum;
    player.momentum = player.pers[ "momentum" ];
}

// Namespace globallogic_score/globallogic_score
// Params 4
// Checksum 0x9514c66c, Offset: 0x3430
// Size: 0x52a
function _giveplayerkillstreakinternal( player, momentum, oldmomentum, killstreaktypearray )
{
    for ( killstreaktypeindex = 0; killstreaktypeindex < killstreaktypearray.size ; killstreaktypeindex++ )
    {
        killstreaktype = killstreaktypearray[ killstreaktypeindex ];
        momentumcost = level.killstreaks[ killstreaktype ].momentumcost;
        
        if ( momentumcost > oldmomentum && momentumcost <= momentum )
        {
            weapon = killstreaks::get_killstreak_weapon( killstreaktype );
            was_already_at_max_stacking = 0;
            
            if ( isdefined( level.usingscorestreaks ) && level.usingscorestreaks )
            {
                if ( weapon.iscarriedkillstreak )
                {
                    if ( !isdefined( player.pers[ "held_killstreak_ammo_count" ][ weapon ] ) )
                    {
                        player.pers[ "held_killstreak_ammo_count" ][ weapon ] = 0;
                    }
                    
                    if ( !isdefined( player.pers[ "killstreak_quantity" ][ weapon ] ) )
                    {
                        player.pers[ "killstreak_quantity" ][ weapon ] = 0;
                    }
                    
                    currentweapon = player getcurrentweapon();
                    
                    if ( currentweapon == weapon )
                    {
                        if ( player.pers[ "killstreak_quantity" ][ weapon ] < level.scorestreaksmaxstacking )
                        {
                            player.pers[ "killstreak_quantity" ][ weapon ]++;
                        }
                    }
                    else
                    {
                        player.pers[ "held_killstreak_clip_count" ][ weapon ] = weapon.clipsize;
                        player.pers[ "held_killstreak_ammo_count" ][ weapon ] = weapon.maxammo;
                        player loadout::setweaponammooverall( weapon, player.pers[ "held_killstreak_ammo_count" ][ weapon ] );
                    }
                }
                else
                {
                    old_killstreak_quantity = player killstreaks::get_killstreak_quantity( weapon );
                    new_killstreak_quantity = player killstreaks::change_killstreak_quantity( weapon, 1 );
                    was_already_at_max_stacking = new_killstreak_quantity == old_killstreak_quantity;
                    
                    if ( !was_already_at_max_stacking )
                    {
                        player challenges::earnedkillstreak();
                        
                        if ( player ability_util::gadget_is_active( 15 ) )
                        {
                            scoreevents::processscoreevent( "focus_earn_scorestreak", player );
                            player scoreevents::specialistmedalachievement();
                            player scoreevents::specialiststatabilityusage( 4, 1 );
                            
                            if ( player.heroability.name == "gadget_combat_efficiency" )
                            {
                                player addweaponstat( player.heroability, "scorestreaks_earned", 1 );
                                
                                if ( !isdefined( player.scorestreaksearnedperuse ) )
                                {
                                    player.scorestreaksearnedperuse = 0;
                                }
                                
                                player.scorestreaksearnedperuse++;
                                
                                if ( player.scorestreaksearnedperuse >= 3 )
                                {
                                    scoreevents::processscoreevent( "focus_earn_multiscorestreak", player );
                                    player.scorestreaksearnedperuse = 0;
                                }
                            }
                        }
                    }
                }
                
                if ( !was_already_at_max_stacking )
                {
                    player killstreaks::add_to_notification_queue( level.killstreaks[ killstreaktype ].menuname, new_killstreak_quantity, killstreaktype );
                }
                
                continue;
            }
            
            player killstreaks::add_to_notification_queue( level.killstreaks[ killstreaktype ].menuname, 0, killstreaktype );
            activeeventname = "reward_active";
            
            if ( isdefined( weapon ) )
            {
                neweventname = weapon.name + "_active";
                
                if ( scoreevents::isregisteredevent( neweventname ) )
                {
                    activeeventname = neweventname;
                }
            }
        }
    }
}

/#

    // Namespace globallogic_score/globallogic_score
    // Params 0
    // Checksum 0x13528772, Offset: 0x3968
    // Size: 0xf0, Type: dev
    function setplayermomentumdebug()
    {
        setdvar( "<dev string:x28>", 0 );
        
        while ( true )
        {
            wait 1;
            momentumpercent = getdvarfloat( "<dev string:x28>", 0 );
            
            if ( momentumpercent != 0 )
            {
                player = util::gethostplayer();
                
                if ( !isdefined( player ) )
                {
                    return;
                }
                
                if ( isdefined( player.killstreak ) )
                {
                    _setplayermomentum( player, int( 2000 * momentumpercent / 100 ) );
                }
            }
        }
    }

#/

// Namespace globallogic_score/globallogic_score
// Params 4
// Checksum 0xe6583634, Offset: 0x3a60
// Size: 0x14c
function giveteamscore( event, team, player, victim )
{
    if ( level.overrideteamscore )
    {
        return;
    }
    
    pixbeginevent( "level.onTeamScore" );
    teamscore = game.stat[ "teamScores" ][ team ];
    [[ level.onteamscore ]]( event, team );
    pixendevent();
    newscore = game.stat[ "teamScores" ][ team ];
    bbprint( "mpteamscores", "gametime %d event %s team %d diff %d score %d", gettime(), event, team, newscore - teamscore, newscore );
    
    if ( teamscore == newscore )
    {
        return;
    }
    
    updateteamscores( team );
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
}

// Namespace globallogic_score/globallogic_score
// Params 2
// Checksum 0x7fc07f6e, Offset: 0x3bb8
// Size: 0xdc
function giveteamscoreforobjective_delaypostprocessing( team, score )
{
    teamscore = game.stat[ "teamScores" ][ team ];
    onteamscore_incrementscore( score, team );
    newscore = game.stat[ "teamScores" ][ team ];
    bbprint( "mpteamobjscores", "gametime %d  team %d diff %d score %d", gettime(), team, newscore - teamscore, newscore );
    
    if ( teamscore == newscore )
    {
        return;
    }
    
    updateteamscores( team );
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x5314e3e8, Offset: 0x3ca0
// Size: 0xb4
function postprocessteamscores( teams )
{
    foreach ( team in teams )
    {
        onteamscore_postprocess( team );
    }
    
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
}

// Namespace globallogic_score/globallogic_score
// Params 2
// Checksum 0x45fdefac, Offset: 0x3d60
// Size: 0x12c
function giveteamscoreforobjective( team, score )
{
    if ( !isdefined( level.teams[ team ] ) )
    {
        return;
    }
    
    teamscore = game.stat[ "teamScores" ][ team ];
    onteamscore( score, team );
    newscore = game.stat[ "teamScores" ][ team ];
    bbprint( "mpteamobjscores", "gametime %d  team %d diff %d score %d", gettime(), team, newscore - teamscore, newscore );
    
    if ( teamscore == newscore )
    {
        return;
    }
    
    updateteamscores( team );
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
    thread globallogic::checksuddendeathscorelimit( team );
}

// Namespace globallogic_score/globallogic_score
// Params 2
// Checksum 0x6ae8acc7, Offset: 0x3e98
// Size: 0xac
function _setteamscore( team, teamscore )
{
    if ( teamscore == game.stat[ "teamScores" ][ team ] )
    {
        return;
    }
    
    game.stat[ "teamScores" ][ team ] = math::clamp( teamscore, 0, 1000000 );
    updateteamscores( team );
    thread globallogic::checkscorelimit();
    thread globallogic::checkroundscorelimit();
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0xa1cc57cb, Offset: 0x3f50
// Size: 0xcc
function resetteamscores()
{
    if ( level.scoreroundwinbased || util::isfirstround() )
    {
        foreach ( team in level.teams )
        {
            game.stat[ "teamScores" ][ team ] = 0;
        }
    }
    
    updateallteamscores();
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0xf0ec84f1, Offset: 0x4028
// Size: 0x24
function resetallscores()
{
    resetteamscores();
    resetplayerscores();
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0xbdcecab9, Offset: 0x4058
// Size: 0xa6
function resetplayerscores()
{
    players = level.players;
    winner = undefined;
    tie = 0;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( isdefined( players[ i ].pers[ "score" ] ) )
        {
            _setplayerscore( players[ i ], 0 );
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0xde7d0c61, Offset: 0x4108
// Size: 0x54
function updateteamscores( team )
{
    setteamscore( team, game.stat[ "teamScores" ][ team ] );
    level thread globallogic::checkteamscorelimitsoon( team );
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0xca01ad4, Offset: 0x4168
// Size: 0x92
function updateallteamscores()
{
    foreach ( team in level.teams )
    {
        updateteamscores( team );
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x67740dde, Offset: 0x4208
// Size: 0x26
function _getteamscore( team )
{
    return game.stat[ "teamScores" ][ team ];
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0x2e72eb49, Offset: 0x4238
// Size: 0x104
function gethighestteamscoreteam()
{
    score = 0;
    winning_teams = [];
    
    foreach ( team in level.teams )
    {
        team_score = game.stat[ "teamScores" ][ team ];
        
        if ( team_score > score )
        {
            score = team_score;
            winning_teams = [];
        }
        
        if ( team_score == score )
        {
            winning_teams[ team ] = team;
        }
    }
    
    return winning_teams;
}

// Namespace globallogic_score/globallogic_score
// Params 2
// Checksum 0xecd5508a, Offset: 0x4348
// Size: 0xb0, Type: bool
function areteamarraysequal( teamsa, teamsb )
{
    if ( teamsa.size != teamsb.size )
    {
        return false;
    }
    
    foreach ( team in teamsa )
    {
        if ( !isdefined( teamsb[ team ] ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace globallogic_score/globallogic_score
// Params 2
// Checksum 0xa54c9bc, Offset: 0x4400
// Size: 0x44
function onteamscore( score, team )
{
    onteamscore_incrementscore( score, team );
    onteamscore_postprocess( team );
}

// Namespace globallogic_score/globallogic_score
// Params 2
// Checksum 0xff5101d5, Offset: 0x4450
// Size: 0x178
function onteamscore_incrementscore( score, team )
{
    game.stat[ "teamScores" ][ team ] = game.stat[ "teamScores" ][ team ] + score;
    
    if ( game.stat[ "teamScores" ][ team ] < 0 )
    {
        game.stat[ "teamScores" ][ team ] = 0;
    }
    
    if ( level.clampscorelimit )
    {
        if ( level.scorelimit && game.stat[ "teamScores" ][ team ] > level.scorelimit )
        {
            game.stat[ "teamScores" ][ team ] = level.scorelimit;
        }
        
        if ( level.roundscorelimit && game.stat[ "teamScores" ][ team ] > util::get_current_round_score_limit() )
        {
            game.stat[ "teamScores" ][ team ] = util::get_current_round_score_limit();
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x982a9aca, Offset: 0x45d0
// Size: 0x27c
function onteamscore_postprocess( team )
{
    if ( level.splitscreen )
    {
        return;
    }
    
    if ( level.scorelimit == 1 )
    {
        return;
    }
    
    iswinning = gethighestteamscoreteam();
    
    if ( iswinning.size == 0 )
    {
        return;
    }
    
    if ( gettime() - level.laststatustime < 5000 )
    {
        return;
    }
    
    if ( areteamarraysequal( iswinning, level.waswinning ) )
    {
        return;
    }
    
    if ( iswinning.size == 1 )
    {
        level.laststatustime = gettime();
        
        foreach ( team in iswinning )
        {
            if ( isdefined( level.waswinning[ team ] ) )
            {
                if ( level.waswinning.size == 1 )
                {
                    continue;
                }
            }
            
            globallogic_audio::leader_dialog( "lead_taken", team, undefined, "status" );
        }
    }
    else
    {
        return;
    }
    
    if ( level.waswinning.size == 1 )
    {
        foreach ( team in level.waswinning )
        {
            if ( isdefined( iswinning[ team ] ) )
            {
                if ( iswinning.size == 1 )
                {
                    continue;
                }
                
                if ( level.waswinning.size > 1 )
                {
                    continue;
                }
            }
            
            globallogic_audio::leader_dialog( "lead_lost", team, undefined, "status" );
        }
    }
    
    level.waswinning = iswinning;
}

// Namespace globallogic_score/globallogic_score
// Params 2
// Checksum 0x603195ec, Offset: 0x4858
// Size: 0x6c
function default_onteamscore( event, team )
{
    score = rank::getscoreinfovalue( event );
    assert( isdefined( score ) );
    onteamscore( score, team );
}

// Namespace globallogic_score/globallogic_score
// Params 2
// Checksum 0xf829c23d, Offset: 0x48d0
// Size: 0x94
function initpersstat( dataname, record_stats )
{
    if ( !isdefined( self.pers[ dataname ] ) )
    {
        self.pers[ dataname ] = 0;
    }
    
    if ( !isdefined( record_stats ) || record_stats == 1 )
    {
        recordplayerstats( self, dataname, int( self.pers[ dataname ] ) );
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0xa83ef2b5, Offset: 0x4970
// Size: 0x1c
function getpersstat( dataname )
{
    return self.pers[ dataname ];
}

// Namespace globallogic_score/globallogic_score
// Params 4
// Checksum 0x57fd1ed1, Offset: 0x4998
// Size: 0xf4
function incpersstat( dataname, increment, record_stats, includegametype )
{
    pixbeginevent( "incPersStat" );
    self.pers[ dataname ] += increment;
    
    if ( isdefined( includegametype ) && includegametype )
    {
        self addplayerstatwithgametype( dataname, increment );
    }
    else
    {
        self addplayerstat( dataname, increment );
    }
    
    if ( !isdefined( record_stats ) || record_stats == 1 )
    {
        self thread threadedrecordplayerstats( dataname );
    }
    
    pixendevent();
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0xd695924e, Offset: 0x4a98
// Size: 0x44
function threadedrecordplayerstats( dataname )
{
    self endon( #"disconnect" );
    waittillframeend();
    recordplayerstats( self, dataname, self.pers[ dataname ] );
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0xb9bd31d6, Offset: 0x4ae8
// Size: 0x2ec
function updatewinstats( winner )
{
    winner addplayerstatwithgametype( "losses", -1 );
    winner addplayerstatwithgametype( "wins", 1 );
    
    if ( level.hardcoremode )
    {
        winner addplayerstat( "wins_HC", 1 );
    }
    
    if ( level.multiteam )
    {
        winner addplayerstat( "wins_MULTITEAM", 1 );
    }
    
    winner updatestatratio( "wlratio", "wins", "losses" );
    restorewinstreaks( winner );
    winner addplayerstatwithgametype( "cur_win_streak", 1 );
    winner notify( #"win" );
    winner.lootxpmultiplier = 1;
    cur_gamemode_win_streak = winner persistence::function_2369852e( "cur_win_streak" );
    gamemode_win_streak = winner persistence::function_2369852e( "win_streak" );
    cur_win_streak = winner getdstat( "playerstatslist", "cur_win_streak", "StatValue" );
    
    if ( !level.disablestattracking && cur_win_streak > winner getdstat( "HighestStats", "win_streak" ) )
    {
        winner setdstat( "HighestStats", "win_streak", cur_win_streak );
    }
    
    if ( cur_gamemode_win_streak > gamemode_win_streak )
    {
        winner persistence::function_e885624a( "win_streak", cur_gamemode_win_streak );
    }
    
    if ( bot::is_bot_ranked_match() )
    {
        combattrainingwins = winner getdstat( "combatTrainingWins" );
        winner setdstat( "combatTrainingWins", combattrainingwins + 1 );
    }
    
    updateweaponcontractwin( winner );
    updatecontractwin( winner );
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0x1a9ebc76, Offset: 0x4de0
// Size: 0x50, Type: bool
function canupdateweaponcontractstats()
{
    if ( getdvarint( "enable_weapon_contract", 0 ) == 0 )
    {
        return false;
    }
    
    if ( !level.rankedmatch && !level.arenamatch )
    {
        return false;
    }
    
    return true;
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x9ffc2a6d, Offset: 0x4e38
// Size: 0x7c
function updateweaponcontractstart( player )
{
    if ( !canupdateweaponcontractstats() )
    {
        return;
    }
    
    if ( player getdstat( "weaponContractData", "startTimestamp" ) == 0 )
    {
        player setdstat( "weaponContractData", "startTimestamp", getutc() );
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0xfd31c508, Offset: 0x4ec0
// Size: 0x144
function updateweaponcontractwin( winner )
{
    if ( !canupdateweaponcontractstats() )
    {
        return;
    }
    
    matcheswon = winner getdstat( "weaponContractData", "currentValue" ) + 1;
    winner setdstat( "weaponContractData", "currentValue", matcheswon );
    
    if ( ( isdefined( winner getdstat( "weaponContractData", "completeTimestamp" ) ) ? winner getdstat( "weaponContractData", "completeTimestamp" ) : 0 ) == 0 )
    {
        targetvalue = getdvarint( "weapon_contract_target_value", 100 );
        
        if ( matcheswon >= targetvalue )
        {
            winner setdstat( "weaponContractData", "completeTimestamp", getutc() );
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0x93f1b618, Offset: 0x5010
// Size: 0x112
function updateweaponcontractplayed()
{
    if ( !canupdateweaponcontractstats() )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.pers[ "team" ] ) )
        {
            continue;
        }
        
        matchesplayed = player getdstat( "weaponContractData", "matchesPlayed" ) + 1;
        player setdstat( "weaponContractData", "matchesPlayed", matchesplayed );
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x40026269, Offset: 0x5130
// Size: 0xb2
function updatecontractwin( winner )
{
    if ( !isdefined( level.updatecontractwinevents ) )
    {
        return;
    }
    
    foreach ( contractwinevent in level.updatecontractwinevents )
    {
        if ( !isdefined( contractwinevent ) )
        {
            continue;
        }
        
        [[ contractwinevent ]]( winner );
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x8ac2f454, Offset: 0x51f0
// Size: 0xb6
function registercontractwinevent( event )
{
    if ( !isdefined( level.updatecontractwinevents ) )
    {
        level.updatecontractwinevents = [];
    }
    
    if ( !isdefined( level.updatecontractwinevents ) )
    {
        level.updatecontractwinevents = [];
    }
    else if ( !isarray( level.updatecontractwinevents ) )
    {
        level.updatecontractwinevents = array( level.updatecontractwinevents );
    }
    
    level.updatecontractwinevents[ level.updatecontractwinevents.size ] = event;
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0xfe8750fd, Offset: 0x52b0
// Size: 0x6c
function updatelossstats( loser )
{
    loser addplayerstatwithgametype( "losses", 1 );
    loser updatestatratio( "wlratio", "wins", "losses" );
    loser notify( #"loss" );
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0xc87e1320, Offset: 0x5328
// Size: 0x7c
function updatelosslatejoinstats( loser )
{
    loser addplayerstatwithgametype( "losses", -1 );
    loser addplayerstatwithgametype( "losses_late_join", 1 );
    loser updatestatratio( "wlratio", "wins", "losses" );
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x7049252e, Offset: 0x53b0
// Size: 0xcc
function updatetiestats( loser )
{
    loser addplayerstatwithgametype( "losses", -1 );
    loser addplayerstatwithgametype( "ties", 1 );
    loser updatestatratio( "wlratio", "wins", "losses" );
    
    if ( !level.disablestattracking )
    {
        loser setdstat( "playerstatslist", "cur_win_streak", "StatValue", 0 );
    }
    
    loser notify( #"tie" );
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x9be27f0f, Offset: 0x5488
// Size: 0x4e6
function updatewinlossstats( winner )
{
    if ( !util::waslastround() && !level.hostforcedend )
    {
        return;
    }
    
    players = level.players;
    updateweaponcontractplayed();
    
    if ( isdefined( winner ) && !isplayer( winner ) && ( !isdefined( winner ) || winner == "tie" ) )
    {
        for ( i = 0; i < players.size ; i++ )
        {
            if ( !isdefined( players[ i ].pers[ "team" ] ) )
            {
                continue;
            }
            
            if ( level.hostforcedend && players[ i ] ishost() )
            {
                continue;
            }
            
            updatetiestats( players[ i ] );
        }
        
        return;
    }
    
    if ( isplayer( winner ) )
    {
        if ( level.hostforcedend && winner ishost() )
        {
            return;
        }
        
        updatewinstats( winner );
        
        if ( !level.teambased )
        {
            placement = level.placement[ "all" ];
            topthreeplayers = min( 3, placement.size );
            
            for ( index = 1; index < topthreeplayers ; index++ )
            {
                nexttopplayer = placement[ index ];
                updatewinstats( nexttopplayer );
            }
            
            for ( i = 0; i < players.size ; i++ )
            {
                if ( winner == players[ i ] )
                {
                    continue;
                }
                
                for ( index = 1; index < topthreeplayers ; index++ )
                {
                    if ( players[ i ] == placement[ index ] )
                    {
                        break;
                    }
                }
                
                if ( index < topthreeplayers )
                {
                    continue;
                }
                
                if ( level.rankedmatch && !level.leaguematch && players[ i ].pers[ "lateJoin" ] === 1 )
                {
                    updatelosslatejoinstats( players[ i ] );
                }
            }
        }
        
        return;
    }
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( !isdefined( players[ i ].pers[ "team" ] ) )
        {
            continue;
        }
        
        if ( level.hostforcedend && players[ i ] ishost() )
        {
            continue;
        }
        
        if ( winner == "tie" )
        {
            updatetiestats( players[ i ] );
            continue;
        }
        
        if ( players[ i ].pers[ "team" ] == winner )
        {
            updatewinstats( players[ i ] );
            continue;
        }
        
        if ( level.rankedmatch && !level.leaguematch && players[ i ].pers[ "lateJoin" ] === 1 )
        {
            updatelosslatejoinstats( players[ i ] );
        }
        
        if ( !level.disablestattracking )
        {
            players[ i ] setdstat( "playerstatslist", "cur_win_streak", "StatValue", 0 );
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0xaa99ae24, Offset: 0x5978
// Size: 0xec
function backupandclearwinstreaks()
{
    if ( isdefined( level.freerun ) && level.freerun )
    {
        return;
    }
    
    self.pers[ "winStreak" ] = self getdstat( "playerstatslist", "cur_win_streak", "StatValue" );
    
    if ( !level.disablestattracking )
    {
        self setdstat( "playerstatslist", "cur_win_streak", "StatValue", 0 );
    }
    
    self.pers[ "winStreakForGametype" ] = persistence::function_2369852e( "cur_win_streak" );
    self persistence::function_e885624a( "cur_win_streak", 0 );
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0xd5fddc10, Offset: 0x5a70
// Size: 0x8c
function restorewinstreaks( winner )
{
    if ( !level.disablestattracking )
    {
        winner setdstat( "playerstatslist", "cur_win_streak", "StatValue", winner.pers[ "winStreak" ] );
    }
    
    winner persistence::function_e885624a( "cur_win_streak", winner.pers[ "winStreakForGametype" ] );
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x3cbeec2d, Offset: 0x5b08
// Size: 0x72
function inckillstreaktracker( weapon )
{
    self endon( #"disconnect" );
    waittillframeend();
    
    if ( weapon.name == "artillery" )
    {
        self.pers[ "artillery_kills" ]++;
    }
    
    if ( weapon.name == "dog_bite" )
    {
        self.pers[ "dog_kills" ]++;
    }
}

// Namespace globallogic_score/globallogic_score
// Params 6
// Checksum 0xd62806ba, Offset: 0x5b88
// Size: 0x4a4
function trackattackerkill( name, rank, xp, prestige, xuid, weapon )
{
    self endon( #"disconnect" );
    attacker = self;
    waittillframeend();
    pixbeginevent( "trackAttackerKill" );
    
    if ( !isdefined( attacker.pers[ "killed_players" ][ name ] ) )
    {
        attacker.pers[ "killed_players" ][ name ] = 0;
    }
    
    if ( !isdefined( attacker.pers[ "killed_players_with_specialist" ][ name ] ) )
    {
        attacker.pers[ "killed_players_with_specialist" ][ name ] = 0;
    }
    
    if ( !isdefined( attacker.killedplayerscurrent[ name ] ) )
    {
        attacker.killedplayerscurrent[ name ] = 0;
    }
    
    if ( !isdefined( attacker.pers[ "nemesis_tracking" ][ name ] ) )
    {
        attacker.pers[ "nemesis_tracking" ][ name ] = 0;
    }
    
    attacker.pers[ "killed_players" ][ name ]++;
    attacker.killedplayerscurrent[ name ]++;
    attacker.pers[ "nemesis_tracking" ][ name ] = attacker.pers[ "nemesis_tracking" ][ name ] + 1;
    
    if ( attacker.pers[ "nemesis_name" ] == name )
    {
        attacker challenges::killednemesis();
    }
    
    if ( weapon.isheavyweapon )
    {
        attacker.pers[ "killed_players_with_specialist" ][ name ]++;
    }
    
    if ( attacker.pers[ "nemesis_name" ] == "" || attacker.pers[ "nemesis_tracking" ][ name ] > attacker.pers[ "nemesis_tracking" ][ attacker.pers[ "nemesis_name" ] ] )
    {
        attacker.pers[ "nemesis_name" ] = name;
        attacker.pers[ "nemesis_rank" ] = rank;
        attacker.pers[ "nemesis_rankIcon" ] = prestige;
        attacker.pers[ "nemesis_xp" ] = xp;
        attacker.pers[ "nemesis_xuid" ] = xuid;
    }
    else if ( isdefined( attacker.pers[ "nemesis_name" ] ) && attacker.pers[ "nemesis_name" ] == name )
    {
        attacker.pers[ "nemesis_rank" ] = rank;
        attacker.pers[ "nemesis_xp" ] = xp;
    }
    
    if ( !isdefined( attacker.lastkilledvictim ) || !isdefined( attacker.lastkilledvictimcount ) )
    {
        attacker.lastkilledvictim = name;
        attacker.lastkilledvictimcount = 0;
    }
    
    if ( attacker.lastkilledvictim == name )
    {
        attacker.lastkilledvictimcount++;
        
        if ( attacker.lastkilledvictimcount >= 5 )
        {
            attacker.lastkilledvictimcount = 0;
            attacker addplayerstat( "streaker", 1 );
        }
    }
    else
    {
        attacker.lastkilledvictim = name;
        attacker.lastkilledvictimcount = 1;
    }
    
    pixendevent();
}

// Namespace globallogic_score/globallogic_score
// Params 5
// Checksum 0x63640ccc, Offset: 0x6038
// Size: 0x364
function trackattackeedeath( attackername, rank, xp, prestige, xuid )
{
    self endon( #"disconnect" );
    waittillframeend();
    pixbeginevent( "trackAttackeeDeath" );
    
    if ( !isdefined( self.pers[ "killed_by" ][ attackername ] ) )
    {
        self.pers[ "killed_by" ][ attackername ] = 0;
    }
    
    self.pers[ "killed_by" ][ attackername ]++;
    
    if ( !isdefined( self.pers[ "nemesis_tracking" ][ attackername ] ) )
    {
        self.pers[ "nemesis_tracking" ][ attackername ] = 0;
    }
    
    self.pers[ "nemesis_tracking" ][ attackername ] = self.pers[ "nemesis_tracking" ][ attackername ] + 1.5;
    
    if ( self.pers[ "nemesis_name" ] == "" || self.pers[ "nemesis_tracking" ][ attackername ] > self.pers[ "nemesis_tracking" ][ self.pers[ "nemesis_name" ] ] )
    {
        self.pers[ "nemesis_name" ] = attackername;
        self.pers[ "nemesis_rank" ] = rank;
        self.pers[ "nemesis_rankIcon" ] = prestige;
        self.pers[ "nemesis_xp" ] = xp;
        self.pers[ "nemesis_xuid" ] = xuid;
    }
    else if ( isdefined( self.pers[ "nemesis_name" ] ) && self.pers[ "nemesis_name" ] == attackername )
    {
        self.pers[ "nemesis_rank" ] = rank;
        self.pers[ "nemesis_xp" ] = xp;
    }
    
    if ( self.pers[ "nemesis_name" ] == attackername && self.pers[ "nemesis_tracking" ][ attackername ] >= 2 )
    {
        self setclientuivisibilityflag( "killcam_nemesis", 1 );
    }
    else
    {
        self setclientuivisibilityflag( "killcam_nemesis", 0 );
    }
    
    selfkillstowardsattacker = 0;
    
    if ( isdefined( self.pers[ "killed_players" ][ attackername ] ) )
    {
        selfkillstowardsattacker = self.pers[ "killed_players" ][ attackername ];
    }
    
    self luinotifyevent( &"track_victim_death", 2, self.pers[ "killed_by" ][ attackername ], selfkillstowardsattacker );
    pixendevent();
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0xbb146b19, Offset: 0x63a8
// Size: 0x6, Type: bool
function default_iskillboosting()
{
    return false;
}

// Namespace globallogic_score/globallogic_score
// Params 3
// Checksum 0x565efce6, Offset: 0x63b8
// Size: 0x1dc
function givekillstats( smeansofdeath, weapon, evictim )
{
    self endon( #"disconnect" );
    self.kills += 1;
    waittillframeend();
    
    if ( level.rankedmatch && self [[ level.iskillboosting ]]() )
    {
        /#
            self iprintlnbold( "<dev string:x3b>" );
        #/
        
        return;
    }
    
    pixbeginevent( "giveKillStats" );
    self incpersstat( "kills", 1, 1, 1 );
    self.kills = self getpersstat( "kills" );
    self updatestatratio( "kdratio", "kills", "deaths" );
    attacker = self;
    
    if ( smeansofdeath == "MOD_HEAD_SHOT" && !killstreaks::is_killstreak_weapon( weapon ) )
    {
        attacker thread incpersstat( "headshots", 1, 1, 0 );
        attacker.headshots = attacker.pers[ "headshots" ];
        
        if ( isdefined( evictim ) )
        {
            evictim recordkillmodifier( "headshot" );
        }
    }
    
    pixendevent();
}

// Namespace globallogic_score/globallogic_score
// Params 3
// Checksum 0x9ce7fc68, Offset: 0x65a0
// Size: 0x1ec
function setinflictorstat( einflictor, eattacker, weapon )
{
    if ( !isdefined( eattacker ) )
    {
        return;
    }
    
    weaponpickedup = 0;
    
    if ( isdefined( eattacker.pickedupweapons ) && isdefined( eattacker.pickedupweapons[ weapon ] ) )
    {
        weaponpickedup = 1;
    }
    
    if ( !isdefined( einflictor ) )
    {
        eattacker addweaponstat( weapon, "hits", 1, eattacker.class_num, weaponpickedup );
        return;
    }
    
    if ( !isdefined( einflictor.playeraffectedarray ) )
    {
        einflictor.playeraffectedarray = [];
    }
    
    foundnewplayer = 1;
    
    for ( i = 0; i < einflictor.playeraffectedarray.size ; i++ )
    {
        if ( einflictor.playeraffectedarray[ i ] == self )
        {
            foundnewplayer = 0;
            break;
        }
    }
    
    if ( foundnewplayer )
    {
        einflictor.playeraffectedarray[ einflictor.playeraffectedarray.size ] = self;
        
        if ( weapon.rootweapon.name == "tabun_gas" )
        {
            eattacker addweaponstat( weapon, "used", 1 );
        }
        
        eattacker addweaponstat( weapon, "hits", 1, eattacker.class_num, weaponpickedup );
    }
}

// Namespace globallogic_score/globallogic_score
// Params 1
// Checksum 0x859fac5c, Offset: 0x6798
// Size: 0x114
function processshieldassist( killedplayer )
{
    self endon( #"disconnect" );
    killedplayer endon( #"disconnect" );
    waitframe( 1 );
    util::waittillslowprocessallowed();
    
    if ( !isdefined( level.teams[ self.pers[ "team" ] ] ) )
    {
        return;
    }
    
    if ( self.pers[ "team" ] == killedplayer.pers[ "team" ] )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    self incpersstat( "assists", 1, 1, 1 );
    self.assists = self getpersstat( "assists" );
    scoreevents::processscoreevent( "shield_assist", self, killedplayer, "riotshield" );
}

// Namespace globallogic_score/globallogic_score
// Params 4
// Checksum 0x3be55e20, Offset: 0x68b8
// Size: 0x314
function processassist( killedplayer, damagedone, weapon, assist_level )
{
    if ( !isdefined( assist_level ) )
    {
        assist_level = undefined;
    }
    
    self endon( #"disconnect" );
    killedplayer endon( #"disconnect" );
    waitframe( 1 );
    util::waittillslowprocessallowed();
    
    if ( !isdefined( level.teams[ self.pers[ "team" ] ] ) )
    {
        return;
    }
    
    if ( self.pers[ "team" ] == killedplayer.pers[ "team" ] )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    assist_level = "assist";
    assist_level_value = int( ceil( damagedone / 25 ) );
    
    if ( assist_level_value < 1 )
    {
        assist_level_value = 1;
    }
    else if ( assist_level_value > 3 )
    {
        assist_level_value = 3;
    }
    
    assist_level = assist_level + "_" + assist_level_value * 25;
    self incpersstat( "assists", 1, 1, 1 );
    self.assists = self getpersstat( "assists" );
    
    if ( isdefined( weapon ) )
    {
        weaponpickedup = 0;
        
        if ( isdefined( self.pickedupweapons ) && isdefined( self.pickedupweapons[ weapon ] ) )
        {
            weaponpickedup = 1;
        }
        
        self addweaponstat( weapon, "assists", 1, self.class_num, weaponpickedup );
    }
    
    switch ( weapon.name )
    {
        case #"concussion_grenade":
        case #"hash_2c20207":
            assist_level = "assist_concussion";
            break;
        case #"flash_grenade":
        case #"hash_d18176a7":
            assist_level = "assist_flash";
            break;
        case #"emp_grenade":
        case #"hash_f94b9d73":
            assist_level = "assist_emp";
            break;
        case #"gun_mini_turret":
            assist_level = "mini_turret_assist";
            break;
        case #"proximity_grenade":
        case #"proximity_grenade_aoe":
            assist_level = "assist_proximity";
            break;
    }
    
    self challenges::assisted();
    scoreevents::processscoreevent( assist_level, self, killedplayer, weapon );
}

// Namespace globallogic_score/globallogic_score
// Params 3
// Checksum 0x1f020000, Offset: 0x6bd8
// Size: 0x60a
function processkillstreakassists( attacker, inflictor, weapon )
{
    if ( !isdefined( attacker ) || !isdefined( attacker.team ) || self util::isenemyplayer( attacker ) == 0 )
    {
        return;
    }
    
    if ( attacker.classname == "trigger_hurt" || self == attacker || attacker.classname == "worldspawn" )
    {
        return;
    }
    
    enemycuavactive = 0;
    
    if ( attacker hasperk( "specialty_immunecounteruav" ) == 0 )
    {
        foreach ( team in level.teams )
        {
            if ( team == attacker.team )
            {
                continue;
            }
            
            if ( counteruav::teamhasactivecounteruav( team ) )
            {
                enemycuavactive = 1;
            }
        }
    }
    
    foreach ( player in level.players )
    {
        if ( player.team != attacker.team )
        {
            continue;
        }
        
        if ( player.team == "spectator" )
        {
            continue;
        }
        
        if ( player == attacker )
        {
            continue;
        }
        
        if ( player.sessionstate != "playing" )
        {
            continue;
        }
        
        assert( isdefined( level.activeplayercounteruavs[ player.entnum ] ) );
        assert( isdefined( level.activeplayeruavs[ player.entnum ] ) );
        assert( isdefined( level.activeplayersatellites[ player.entnum ] ) );
        is_killstreak_weapon = killstreaks::is_killstreak_weapon( weapon );
        
        if ( level.activeplayercounteruavs[ player.entnum ] > 0 && !is_killstreak_weapon )
        {
            scoregiven = scoreevents::processscoreevent( "counter_uav_assist", player );
            
            if ( isdefined( scoregiven ) )
            {
                player challenges::earnedcuavassistscore( scoregiven );
                killstreakindex = level.killstreakindices[ "killstreak_counteruav" ];
                killstreaks::killstreak_assist( player, self, killstreakindex );
            }
        }
        
        if ( enemycuavactive == 0 )
        {
            activeuav = level.activeplayeruavs[ player.entnum ];
            
            if ( level.forceradar == 1 )
            {
                activeuav--;
            }
            
            if ( activeuav > 0 && !is_killstreak_weapon )
            {
                scoregiven = scoreevents::processscoreevent( "uav_assist", player );
                
                if ( isdefined( scoregiven ) )
                {
                    player challenges::earneduavassistscore( scoregiven );
                    killstreakindex = level.killstreakindices[ "killstreak_uav" ];
                    killstreaks::killstreak_assist( player, self, killstreakindex );
                }
            }
            
            if ( level.activeplayersatellites[ player.entnum ] > 0 && !is_killstreak_weapon )
            {
                scoregiven = scoreevents::processscoreevent( "satellite_assist", player );
                
                if ( isdefined( scoregiven ) )
                {
                    player challenges::earnedsatelliteassistscore( scoregiven );
                    killstreakindex = level.killstreakindices[ "killstreak_satellite" ];
                    killstreaks::killstreak_assist( player, self, killstreakindex );
                }
            }
        }
        
        if ( player emp::hasactiveemp() )
        {
            scoregiven = scoreevents::processscoreevent( "emp_assist", player );
            
            if ( isdefined( scoregiven ) )
            {
                player challenges::earnedempassistscore( scoregiven );
                killstreakindex = level.killstreakindices[ "killstreak_emp" ];
                killstreaks::killstreak_assist( player, self, killstreakindex );
            }
        }
    }
}

// Namespace globallogic_score/globallogic_score
// Params 0
// Checksum 0xd370d9cd, Offset: 0x71f0
// Size: 0xba
function updateteamscorebyroundswon()
{
    if ( level.scoreroundwinbased )
    {
        foreach ( team in level.teams )
        {
            [[ level._setteamscore ]]( team, game.stat[ "roundswon" ][ team ] );
        }
    }
}

/#

    // Namespace globallogic_score/globallogic_score
    // Params 0
    // Checksum 0x64223cfe, Offset: 0x72b8
    // Size: 0xe0, Type: dev
    function function_4e01d1c3()
    {
        self endon( #"death" );
        self endon( #"disconnect" );
        level endon( #"game_ended" );
        
        while ( level.inprematchperiod )
        {
            waitframe( 1 );
        }
        
        for ( ;; )
        {
            wait 5;
            
            if ( isdefined( level.teams[ level.players[ 0 ].pers[ "<dev string:x82>" ] ] ) )
            {
                self rank::giverankxp( "<dev string:x87>", int( min( getdvarint( "<dev string:x8c>" ), 50 ) ) );
            }
        }
    }

#/
