#using scripts/core_common/callbacks_shared;
#using scripts/core_common/hud_util_shared;
#using scripts/core_common/persistence_shared;
#using scripts/core_common/rank_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/globallogic_score;
#using scripts/mp_common/gametypes/loadout;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace wager;

// Namespace wager/wager
// Params 0, eflags: 0x2
// Checksum 0xb64b6360, Offset: 0x4f0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "wager", &__init__, undefined, undefined );
}

// Namespace wager/wager
// Params 0
// Checksum 0xf4309744, Offset: 0x530
// Size: 0x24
function __init__()
{
    callback::on_start_gametype( &init );
}

// Namespace wager/wager
// Params 0
// Checksum 0xf1e041fe, Offset: 0x560
// Size: 0x148
function init()
{
    if ( gamemodeismode( 3 ) )
    {
        level.wagermatch = 1;
        
        if ( !isdefined( game.wager_pot ) )
        {
            game.wager_pot = 0;
            game.wager_initial_pot = 0;
        }
        
        game.dialog[ "wm_u2_online" ] = "boost_gen_02";
        game.dialog[ "wm_in_the_money" ] = "boost_gen_06";
        game.dialog[ "wm_oot_money" ] = "boost_gen_07";
        level.poweruplist = [];
        callback::on_disconnect( &on_disconnect );
        callback::on_spawned( &init_player );
        level thread help_game_end();
    }
    else
    {
        level.wagermatch = 0;
    }
    
    level.takelivesondeath = 1;
}

// Namespace wager/wager
// Params 0
// Checksum 0x164038f6, Offset: 0x6b0
// Size: 0x10c
function init_player()
{
    self endon( #"disconnect" );
    
    if ( !isdefined( self.pers[ "wager" ] ) )
    {
        self.pers[ "wager" ] = 1;
        self.pers[ "wager_sideBetWinnings" ] = 0;
        self.pers[ "wager_sideBetLosses" ] = 0;
    }
    
    if ( isdefined( level.firstplaceonradar ) && ( isdefined( level.inthemoneyonradar ) && level.inthemoneyonradar || level.firstplaceonradar ) )
    {
        self.pers[ "hasRadar" ] = 1;
        self.hasspyplane = 1;
    }
    else
    {
        self.pers[ "hasRadar" ] = 0;
        self.hasspyplane = 0;
    }
    
    self thread deduct_player_ante();
}

// Namespace wager/wager
// Params 0
// Checksum 0x26254ed2, Offset: 0x7c8
// Size: 0x30
function on_disconnect()
{
    level endon( #"game_ended" );
    self endon( #"player_eliminated" );
    level notify( #"player_eliminated" );
}

// Namespace wager/wager
// Params 0
// Checksum 0x6e0d1258, Offset: 0x800
// Size: 0x1ac
function deduct_player_ante()
{
    if ( isdefined( self.pers[ "hasPaidWagerAnte" ] ) )
    {
        return;
    }
    
    waittillframeend();
    codpoints = self rank::getcodpointsstat();
    wagerbet = getdvarint( "scr_wagerBet" );
    
    if ( wagerbet > codpoints )
    {
        wagerbet = codpoints;
    }
    
    codpoints -= wagerbet;
    self rank::setcodpointsstat( codpoints );
    
    if ( !self islocaltohost() )
    {
        self increment_escrow_for_player( wagerbet );
    }
    
    game.wager_pot += wagerbet;
    game.wager_initial_pot += wagerbet;
    self.pers[ "hasPaidWagerAnte" ] = 1;
    self addplayerstat( "LIFETIME_BUYIN", wagerbet );
    self add_recent_earnings_to_stat( 0 - wagerbet );
    
    if ( isdefined( level.onwagerplayerante ) )
    {
        [[ level.onwagerplayerante ]]( self, wagerbet );
    }
    
    self thread persistence::upload_stats_soon();
}

// Namespace wager/wager
// Params 1
// Checksum 0xfaf1305b, Offset: 0x9b8
// Size: 0xe6
function increment_escrow_for_player( amount )
{
    if ( !isdefined( self ) || !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( game.escrows ) )
    {
        game.escrows = [];
    }
    
    playerxuid = self getxuid();
    
    if ( !isdefined( playerxuid ) )
    {
        return;
    }
    
    escrowstruct = spawnstruct();
    escrowstruct.xuid = playerxuid;
    escrowstruct.amount = amount;
    game.escrows[ game.escrows.size ] = escrowstruct;
}

// Namespace wager/wager
// Params 0
// Checksum 0x3ac2c11f, Offset: 0xaa8
// Size: 0x94
function clear_escrows()
{
    if ( !isdefined( game.escrows ) )
    {
        return;
    }
    
    escrows = game.escrows;
    numescrows = escrows.size;
    
    for ( i = 0; i < numescrows ; i++ )
    {
        escrowstruct = escrows[ i ];
    }
    
    game.escrows = [];
}

// Namespace wager/wager
// Params 1
// Checksum 0x2b55fc78, Offset: 0xb48
// Size: 0x64
function add_recent_earnings_to_stat( recentearnings )
{
    currearnings = self persistence::get_recent_stat( 1, 0, "score" );
    self persistence::set_recent_stat( 1, 0, "score", currearnings + recentearnings );
}

// Namespace wager/wager
// Params 0
// Checksum 0x20b415f5, Offset: 0xbb8
// Size: 0x14
function prematch_period()
{
    if ( !level.wagermatch )
    {
        return;
    }
}

// Namespace wager/wager
// Params 0
// Checksum 0xc2172189, Offset: 0xbd8
// Size: 0x50
function finalize_round()
{
    if ( level.wagermatch == 0 )
    {
        return;
    }
    
    determine_winnings();
    
    if ( isdefined( level.onwagerfinalizeround ) )
    {
        [[ level.onwagerfinalizeround ]]();
    }
}

// Namespace wager/wager
// Params 0
// Checksum 0xefa5092a, Offset: 0xc30
// Size: 0x74
function determine_winnings()
{
    shouldcalculatewinnings = !isdefined( level.dontcalcwagerwinnings ) || !level.dontcalcwagerwinnings;
    
    if ( !shouldcalculatewinnings )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        calculate_free_for_all_payouts();
        return;
    }
    
    calculate_team_payouts();
}

// Namespace wager/wager
// Params 0
// Checksum 0xb3d9f5d7, Offset: 0xcb0
// Size: 0x334
function calculate_free_for_all_payouts()
{
    playerrankings = level.placement[ "all" ];
    payoutpercentages = array( 0.5, 0.3, 0.2 );
    
    if ( playerrankings.size == 2 )
    {
        payoutpercentages = array( 0.7, 0.3 );
    }
    else if ( playerrankings.size == 1 )
    {
        payoutpercentages = array( 1 );
    }
    
    set_winnings_on_players( level.players, 0 );
    
    if ( isdefined( level.hostforcedend ) && level.hostforcedend )
    {
        wagerbet = getdvarint( "scr_wagerBet" );
        
        for ( i = 0; i < playerrankings.size ; i++ )
        {
            if ( !playerrankings[ i ] islocaltohost() )
            {
                playerrankings[ i ].wagerwinnings = wagerbet;
            }
        }
        
        return;
    }
    
    if ( level.players.size == 1 )
    {
        game.escrows = undefined;
        return;
    }
    
    currentpayoutpercentage = 0;
    cumulativepayoutpercentage = payoutpercentages[ 0 ];
    playergroup = [];
    playergroup[ playergroup.size ] = playerrankings[ 0 ];
    
    for ( i = 1; i < playerrankings.size ; i++ )
    {
        if ( playerrankings[ i ].pers[ "score" ] < playergroup[ 0 ].pers[ "score" ] )
        {
            set_winnings_on_players( playergroup, int( game.wager_pot * cumulativepayoutpercentage / playergroup.size ) );
            playergroup = [];
            cumulativepayoutpercentage = 0;
        }
        
        playergroup[ playergroup.size ] = playerrankings[ i ];
        currentpayoutpercentage++;
        
        if ( isdefined( payoutpercentages[ currentpayoutpercentage ] ) )
        {
            cumulativepayoutpercentage += payoutpercentages[ currentpayoutpercentage ];
        }
    }
    
    set_winnings_on_players( playergroup, int( game.wager_pot * cumulativepayoutpercentage / playergroup.size ) );
}

// Namespace wager/wager
// Params 0
// Checksum 0x6883ff6e, Offset: 0xff0
// Size: 0x17e
function calculate_places_based_on_score()
{
    level.playerplaces = array( [], [], [] );
    playerrankings = level.placement[ "all" ];
    placementscores = array( playerrankings[ 0 ].pers[ "score" ], -1, -1 );
    currentplace = 0;
    
    for ( index = 0; index < playerrankings.size && currentplace < placementscores.size ; index++ )
    {
        player = playerrankings[ index ];
        
        if ( player.pers[ "score" ] < placementscores[ currentplace ] )
        {
            currentplace++;
            
            if ( currentplace >= level.playerplaces.size )
            {
                break;
            }
            
            placementscores[ currentplace ] = player.pers[ "score" ];
        }
        
        level.playerplaces[ currentplace ][ level.playerplaces[ currentplace ].size ] = player;
    }
}

// Namespace wager/wager
// Params 0
// Checksum 0x17979a51, Offset: 0x1178
// Size: 0x184
function calculate_team_payouts()
{
    winner = globallogic::determineteamwinnerbygamestat( "teamScores" );
    
    if ( winner == "tie" )
    {
        calculate_free_for_all_payouts();
        return;
    }
    
    playersonwinningteam = [];
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        player = level.players[ index ];
        player.wagerwinnings = 0;
        
        if ( player.pers[ "team" ] == winner )
        {
            playersonwinningteam[ playersonwinningteam.size ] = player;
        }
    }
    
    if ( playersonwinningteam.size == 0 )
    {
        set_winnings_on_players( level.players, getdvarint( "scr_wagerBet" ) );
        return;
    }
    
    winningssplit = int( game.wager_pot / playersonwinningteam.size );
    set_winnings_on_players( playersonwinningteam, winningssplit );
}

// Namespace wager/wager
// Params 2
// Checksum 0x757231d9, Offset: 0x1308
// Size: 0x56
function set_winnings_on_players( players, amount )
{
    for ( index = 0; index < players.size ; index++ )
    {
        players[ index ].wagerwinnings = amount;
    }
}

// Namespace wager/wager
// Params 0
// Checksum 0xa41b9d92, Offset: 0x1368
// Size: 0x18c
function finalize_game()
{
    level.wagergamefinalized = 1;
    
    if ( level.wagermatch == 0 )
    {
        return;
    }
    
    determine_winnings();
    determine_top_earners();
    players = level.players;
    wait 0.5;
    playerrankings = level.wagertopearners;
    
    for ( index = 0; index < players.size ; index++ )
    {
        player = players[ index ];
        
        if ( isdefined( player.pers[ "wager_sideBetWinnings" ] ) )
        {
            pay_out_winnings( player, player.wagerwinnings + player.pers[ "wager_sideBetWinnings" ] );
        }
        else
        {
            pay_out_winnings( player, player.wagerwinnings );
        }
        
        if ( player.wagerwinnings > 0 )
        {
            globallogic_score::updatewinstats( player );
        }
    }
    
    clear_escrows();
}

// Namespace wager/wager
// Params 2
// Checksum 0x2a21c852, Offset: 0x1500
// Size: 0xa4
function pay_out_winnings( player, winnings )
{
    if ( winnings == 0 )
    {
        return;
    }
    
    codpoints = player rank::getcodpointsstat();
    player rank::setcodpointsstat( codpoints + winnings );
    player addplayerstat( "LIFETIME_EARNINGS", winnings );
    player add_recent_earnings_to_stat( winnings );
}

// Namespace wager/wager
// Params 0
// Checksum 0x76339dbe, Offset: 0x15b0
// Size: 0x240
function determine_top_earners()
{
    topwinnings = array( -1, -1, -1 );
    level.wagertopearners = [];
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        player = level.players[ index ];
        
        if ( !isdefined( player.wagerwinnings ) )
        {
            player.wagerwinnings = 0;
        }
        
        if ( player.wagerwinnings > topwinnings[ 0 ] )
        {
            topwinnings[ 2 ] = topwinnings[ 1 ];
            topwinnings[ 1 ] = topwinnings[ 0 ];
            topwinnings[ 0 ] = player.wagerwinnings;
            level.wagertopearners[ 2 ] = level.wagertopearners[ 1 ];
            level.wagertopearners[ 1 ] = level.wagertopearners[ 0 ];
            level.wagertopearners[ 0 ] = player;
            continue;
        }
        
        if ( player.wagerwinnings > topwinnings[ 1 ] )
        {
            topwinnings[ 2 ] = topwinnings[ 1 ];
            topwinnings[ 1 ] = player.wagerwinnings;
            level.wagertopearners[ 2 ] = level.wagertopearners[ 1 ];
            level.wagertopearners[ 1 ] = player;
            continue;
        }
        
        if ( player.wagerwinnings > topwinnings[ 2 ] )
        {
            topwinnings[ 2 ] = player.wagerwinnings;
            level.wagertopearners[ 2 ] = player;
        }
    }
}

// Namespace wager/wager
// Params 0
// Checksum 0xa219e6e3, Offset: 0x17f8
// Size: 0x40
function post_round_side_bet()
{
    if ( isdefined( level.sidebet ) && level.sidebet )
    {
        level notify( #"side_bet_begin" );
        level waittill( "side_bet_end" );
    }
}

// Namespace wager/wager
// Params 0
// Checksum 0x9fc6df50, Offset: 0x1840
// Size: 0x64
function side_bet_timer()
{
    level endon( #"side_bet_end" );
    secondstowait = ( level.sidebetendtime - gettime() ) / 1000;
    
    if ( secondstowait < 0 )
    {
        secondstowait = 0;
    }
    
    wait secondstowait;
    level notify( #"side_bet_end" );
}

// Namespace wager/wager
// Params 0
// Checksum 0x7ebd04f3, Offset: 0x18b0
// Size: 0x68
function side_bet_all_bets_placed()
{
    secondsleft = ( level.sidebetendtime - gettime() ) / 1000;
    
    if ( secondsleft <= 3 )
    {
        return;
    }
    
    level.sidebetendtime = gettime() + 3000;
    wait 3;
    level notify( #"side_bet_end" );
}

// Namespace wager/wager
// Params 3
// Checksum 0xcedbb6e4, Offset: 0x1920
// Size: 0x1e4
function setup_blank_random_player( takeweapons, chooserandombody, weapon )
{
    if ( !isdefined( chooserandombody ) || chooserandombody )
    {
        if ( !isdefined( self.pers[ "wagerBodyAssigned" ] ) )
        {
            self assign_random_body();
            self.pers[ "wagerBodyAssigned" ] = 1;
        }
        
        self teams::set_player_model( self.team, weapon );
    }
    
    self clearperks();
    self.killstreak = [];
    self.pers[ "killstreaks" ] = [];
    self.pers[ "killstreak_has_been_used" ] = [];
    self.pers[ "killstreak_unique_id" ] = [];
    
    if ( !isdefined( takeweapons ) || takeweapons )
    {
        self takeallweapons();
    }
    
    if ( isdefined( self.pers[ "hasRadar" ] ) && self.pers[ "hasRadar" ] )
    {
        self.hasspyplane = 1;
    }
    
    if ( isdefined( self.powerups ) && isdefined( self.powerups.size ) )
    {
        for ( i = 0; i < self.powerups.size ; i++ )
        {
            self apply_powerup( self.powerups[ i ] );
        }
    }
    
    self set_radar_visibility();
}

// Namespace wager/wager
// Params 0
// Checksum 0x80f724d1, Offset: 0x1b10
// Size: 0x4
function assign_random_body()
{
    
}

// Namespace wager/wager
// Params 4
// Checksum 0x67fc5526, Offset: 0x1b20
// Size: 0xf6
function queue_popup( message, points, submessage, announcement )
{
    self endon( #"disconnect" );
    size = self.wagernotifyqueue.size;
    self.wagernotifyqueue[ size ] = spawnstruct();
    self.wagernotifyqueue[ size ].message = message;
    self.wagernotifyqueue[ size ].points = points;
    self.wagernotifyqueue[ size ].submessage = submessage;
    self.wagernotifyqueue[ size ].announcement = announcement;
    self notify( #"received award" );
}

// Namespace wager/wager
// Params 0
// Checksum 0xad17ddef, Offset: 0x1c20
// Size: 0x248
function help_game_end()
{
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        level waittill( "player_eliminated" );
        
        if ( !isdefined( level.numlives ) || !level.numlives )
        {
            continue;
        }
        
        waitframe( 1 );
        players = level.players;
        playersleft = 0;
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( isdefined( players[ i ].pers[ "lives" ] ) && players[ i ].pers[ "lives" ] > 0 )
            {
                playersleft++;
            }
        }
        
        if ( playersleft == 2 )
        {
            for ( i = 0; i < players.size ; i++ )
            {
                players[ i ] queue_popup( &"MP_HEADS_UP", 0, &"MP_U2_ONLINE", "wm_u2_online" );
                players[ i ].pers[ "hasRadar" ] = 1;
                players[ i ].hasspyplane = 1;
                
                if ( level.teambased )
                {
                    assert( isdefined( players[ i ].team ) );
                    level.activeplayeruavs[ players[ i ].team ]++;
                }
                else
                {
                    level.activeplayeruavs[ players[ i ] getentitynumber() ]++;
                }
                
                level.activeplayeruavs[ players[ i ] getentitynumber() ]++;
            }
        }
    }
}

// Namespace wager/wager
// Params 0
// Checksum 0x68847340, Offset: 0x1e70
// Size: 0x14c
function set_radar_visibility()
{
    prevscoreplace = self.prevscoreplace;
    
    if ( !isdefined( prevscoreplace ) )
    {
        prevscoreplace = 1;
    }
    
    if ( isdefined( level.inthemoneyonradar ) && level.inthemoneyonradar )
    {
        if ( prevscoreplace <= 3 && isdefined( self.score ) && self.score > 0 )
        {
            self unsetperk( "specialty_gpsjammer" );
        }
        else
        {
            self setperk( "specialty_gpsjammer" );
        }
        
        return;
    }
    
    if ( isdefined( level.firstplaceonradar ) && level.firstplaceonradar )
    {
        if ( prevscoreplace == 1 && isdefined( self.score ) && self.score > 0 )
        {
            self unsetperk( "specialty_gpsjammer" );
            return;
        }
        
        self setperk( "specialty_gpsjammer" );
    }
}

// Namespace wager/wager
// Params 0
// Checksum 0xcc23b8d4, Offset: 0x1fc8
// Size: 0x266
function player_scored()
{
    self notify( #"wager_player_scored" );
    self endon( #"wager_player_scored" );
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
        
        if ( !wasinthemoney && isinthemoney )
        {
            level.placement[ "all" ][ i ] announcer( "wm_in_the_money" );
        }
        else if ( wasinthemoney && !isinthemoney )
        {
            level.placement[ "all" ][ i ] announcer( "wm_oot_money" );
        }
        
        level.placement[ "all" ][ i ].prevscoreplace = currentscoreplace;
        level.placement[ "all" ][ i ] set_radar_visibility();
    }
}

// Namespace wager/wager
// Params 2
// Checksum 0x40833310, Offset: 0x2238
// Size: 0x34
function announcer( dialog, group )
{
    self globallogic_audio::leader_dialog_on_player( dialog, group );
}

// Namespace wager/wager
// Params 4
// Checksum 0x13dfa6cb, Offset: 0x2278
// Size: 0xa4
function create_powerup( name, type, displayname, iconmaterial )
{
    powerup = spawnstruct();
    powerup.name = [];
    powerup.name[ 0 ] = name;
    powerup.type = type;
    powerup.displayname = displayname;
    powerup.iconmaterial = iconmaterial;
    return powerup;
}

// Namespace wager/wager
// Params 4
// Checksum 0x2ec13080, Offset: 0x2328
// Size: 0x126
function add_powerup( name, type, displayname, iconmaterial )
{
    if ( !isdefined( level.poweruplist ) )
    {
        level.poweruplist = [];
    }
    
    for ( i = 0; i < level.poweruplist.size ; i++ )
    {
        if ( level.poweruplist[ i ].displayname == displayname )
        {
            level.poweruplist[ i ].name[ level.poweruplist[ i ].name.size ] = name;
            return;
        }
    }
    
    powerup = create_powerup( name, type, displayname, iconmaterial );
    level.poweruplist[ level.poweruplist.size ] = powerup;
}

// Namespace wager/wager
// Params 1
// Checksum 0xa5cdf4a5, Offset: 0x2458
// Size: 0x52
function copy_powerup( powerup )
{
    return create_powerup( powerup.name[ 0 ], powerup.type, powerup.displayname, powerup.iconmaterial );
}

// Namespace wager/wager
// Params 1
// Checksum 0x8d9049a4, Offset: 0x24b8
// Size: 0x2fe
function apply_powerup( powerup )
{
    weapon = level.weaponnone;
    
    switch ( powerup.type )
    {
        case #"equipment":
        case #"primary":
        case #"primary_grenade":
        case #"secondary":
        case #"hash_b2df521e":
            weapon = getweapon( powerup.name[ 0 ] );
            break;
    }
    
    switch ( powerup.type )
    {
        case #"primary":
            self giveweapon( weapon );
            self switchtoweapon( weapon );
            break;
        case #"secondary":
            self giveweapon( weapon );
            break;
        case #"equipment":
            self giveweapon( weapon );
            self loadout::setweaponammooverall( weapon, 1 );
            self setactionslot( 1, "weapon", weapon );
            break;
        case #"primary_grenade":
            self setoffhandprimaryclass( weapon );
            self giveweapon( weapon );
            self setweaponammoclip( weapon, 2 );
            break;
        case #"hash_b2df521e":
            self setoffhandsecondaryclass( weapon );
            self giveweapon( weapon );
            self setweaponammoclip( weapon, 2 );
            break;
        case #"perk":
            for ( i = 0; i < powerup.name.size ; i++ )
            {
                self setperk( powerup.name[ i ] );
            }
            
            break;
        case #"killstreak":
            self killstreaks::give( powerup.name[ 0 ] );
            break;
        case #"hash_8f3f7751":
            self.scoremultiplier = powerup.name[ 0 ];
            break;
    }
}

// Namespace wager/wager
// Params 2
// Checksum 0x4486076f, Offset: 0x27c0
// Size: 0x134
function give_powerup( powerup, doanimation )
{
    if ( !isdefined( self.powerups ) )
    {
        self.powerups = [];
    }
    
    powerupindex = self.powerups.size;
    self.powerups[ powerupindex ] = copy_powerup( powerup );
    
    for ( i = 0; i < powerup.name.size ; i++ )
    {
        self.powerups[ powerupindex ].name[ self.powerups[ powerupindex ].name.size ] = powerup.name[ i ];
    }
    
    self apply_powerup( self.powerups[ powerupindex ] );
    self thread show_powerup_message( powerupindex, doanimation );
}

// Namespace wager/wager
// Params 1
// Checksum 0xd229a1a1, Offset: 0x2900
// Size: 0x2dc
function pulse_powerup_icon( powerupindex )
{
    if ( !isdefined( self ) || !isdefined( self.powerups ) || !isdefined( self.powerups[ powerupindex ] ) || !isdefined( self.powerups[ powerupindex ].hud_elem_icon ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    self endon( #"delete" );
    self endon( #"clearing_powerups" );
    pulsepercent = 1.5;
    pulsetime = 0.5;
    hud_elem = self.powerups[ powerupindex ].hud_elem_icon;
    
    if ( isdefined( hud_elem.animating ) && hud_elem.animating )
    {
        return;
    }
    
    origx = hud_elem.x;
    origy = hud_elem.y;
    origwidth = hud_elem.width;
    origheight = hud_elem.height;
    bigwidth = origwidth * pulsepercent;
    bigheight = origheight * pulsepercent;
    xoffset = ( bigwidth - origwidth ) / 2;
    yoffset = ( bigheight - origheight ) / 2;
    hud_elem scaleovertime( 0.05, int( bigwidth ), int( bigheight ) );
    hud_elem moveovertime( 0.05 );
    hud_elem.x = origx - xoffset;
    hud_elem.y = origy - yoffset;
    waitframe( 1 );
    hud_elem scaleovertime( pulsetime, origwidth, origheight );
    hud_elem moveovertime( pulsetime );
    hud_elem.x = origx;
    hud_elem.y = origy;
}

// Namespace wager/wager
// Params 2
// Checksum 0x56bfc2d5, Offset: 0x2be8
// Size: 0xad0
function show_powerup_message( powerupindex, doanimation )
{
    self endon( #"disconnect" );
    self endon( #"delete" );
    self endon( #"clearing_powerups" );
    
    if ( !isdefined( doanimation ) )
    {
        doanimation = 1;
    }
    
    wasinprematch = level.inprematchperiod;
    powerupstarty = 320;
    powerupspacing = 40;
    
    if ( self issplitscreen() )
    {
        powerupstarty = 120;
        powerupspacing = 35;
    }
    
    if ( isdefined( self.powerups[ powerupindex ].hud_elem ) )
    {
        self.powerups[ powerupindex ].hud_elem destroy();
    }
    
    self.powerups[ powerupindex ].hud_elem = newclienthudelem( self );
    self.powerups[ powerupindex ].hud_elem.fontscale = 1.5;
    self.powerups[ powerupindex ].hud_elem.x = -125;
    self.powerups[ powerupindex ].hud_elem.y = powerupstarty - powerupspacing * powerupindex;
    self.powerups[ powerupindex ].hud_elem.alignx = "left";
    self.powerups[ powerupindex ].hud_elem.aligny = "middle";
    self.powerups[ powerupindex ].hud_elem.horzalign = "user_right";
    self.powerups[ powerupindex ].hud_elem.vertalign = "user_top";
    self.powerups[ powerupindex ].hud_elem.color = ( 1, 1, 1 );
    self.powerups[ powerupindex ].hud_elem.foreground = 1;
    self.powerups[ powerupindex ].hud_elem.hidewhendead = 0;
    self.powerups[ powerupindex ].hud_elem.hidewheninmenu = 1;
    self.powerups[ powerupindex ].hud_elem.hidewheninkillcam = 1;
    self.powerups[ powerupindex ].hud_elem.archived = 0;
    self.powerups[ powerupindex ].hud_elem.alpha = 0;
    self.powerups[ powerupindex ].hud_elem settext( self.powerups[ powerupindex ].displayname );
    bigiconsize = 40;
    iconsize = 32;
    
    if ( isdefined( self.powerups[ powerupindex ].hud_elem_icon ) )
    {
        self.powerups[ powerupindex ].hud_elem_icon destroy();
    }
    
    if ( doanimation )
    {
        self.powerups[ powerupindex ].hud_elem_icon = self hud::createicon( self.powerups[ powerupindex ].iconmaterial, bigiconsize, bigiconsize );
        self.powerups[ powerupindex ].hud_elem_icon.animating = 1;
    }
    else
    {
        self.powerups[ powerupindex ].hud_elem_icon = self hud::createicon( self.powerups[ powerupindex ].iconmaterial, iconsize, iconsize );
    }
    
    self.powerups[ powerupindex ].hud_elem_icon.x = self.powerups[ powerupindex ].hud_elem.x - 5 - iconsize / 2 - bigiconsize / 2;
    self.powerups[ powerupindex ].hud_elem_icon.y = powerupstarty - powerupspacing * powerupindex - bigiconsize / 2;
    self.powerups[ powerupindex ].hud_elem_icon.horzalign = "user_right";
    self.powerups[ powerupindex ].hud_elem_icon.vertalign = "user_top";
    self.powerups[ powerupindex ].hud_elem_icon.color = ( 1, 1, 1 );
    self.powerups[ powerupindex ].hud_elem_icon.foreground = 1;
    self.powerups[ powerupindex ].hud_elem_icon.hidewhendead = 0;
    self.powerups[ powerupindex ].hud_elem_icon.hidewheninmenu = 1;
    self.powerups[ powerupindex ].hud_elem_icon.hidewheninkillcam = 1;
    self.powerups[ powerupindex ].hud_elem_icon.archived = 0;
    self.powerups[ powerupindex ].hud_elem_icon.alpha = 1;
    
    if ( !wasinprematch && doanimation )
    {
        self thread queue_popup( self.powerups[ powerupindex ].displayname, 0, &"MP_BONUS_ACQUIRED" );
    }
    
    pulsetime = 0.5;
    
    if ( doanimation )
    {
        self.powerups[ powerupindex ].hud_elem fadeovertime( pulsetime );
        self.powerups[ powerupindex ].hud_elem_icon scaleovertime( pulsetime, iconsize, iconsize );
        self.powerups[ powerupindex ].hud_elem_icon.width = iconsize;
        self.powerups[ powerupindex ].hud_elem_icon.height = iconsize;
        self.powerups[ powerupindex ].hud_elem_icon moveovertime( pulsetime );
    }
    
    self.powerups[ powerupindex ].hud_elem.alpha = 1;
    self.powerups[ powerupindex ].hud_elem_icon.x = self.powerups[ powerupindex ].hud_elem.x - 5 - iconsize;
    self.powerups[ powerupindex ].hud_elem_icon.y = powerupstarty - powerupspacing * powerupindex - iconsize / 2;
    
    if ( doanimation )
    {
        wait pulsetime;
    }
    
    if ( level.inprematchperiod )
    {
        level waittill( "prematch_over" );
    }
    else if ( doanimation )
    {
        wait pulsetime;
    }
    
    if ( wasinprematch && doanimation )
    {
        self thread queue_popup( self.powerups[ powerupindex ].displayname, 0, &"MP_BONUS_ACQUIRED" );
    }
    
    wait 1.5;
    
    for ( i = 0; i <= powerupindex ; i++ )
    {
        self.powerups[ i ].hud_elem fadeovertime( 0.25 );
        self.powerups[ i ].hud_elem.alpha = 0;
    }
    
    wait 0.25;
    
    for ( i = 0; i <= powerupindex ; i++ )
    {
        self.powerups[ i ].hud_elem_icon moveovertime( 0.25 );
        self.powerups[ i ].hud_elem_icon.x = 0 - iconsize;
        self.powerups[ i ].hud_elem_icon.horzalign = "user_right";
    }
    
    self.powerups[ powerupindex ].hud_elem_icon.animating = 0;
}

// Namespace wager/wager
// Params 0
// Checksum 0xcca2dea7, Offset: 0x36c0
// Size: 0xfc
function clear_powerups()
{
    self notify( #"clearing_powerups" );
    
    if ( isdefined( self.powerups ) && isdefined( self.powerups.size ) )
    {
        for ( i = 0; i < self.powerups.size ; i++ )
        {
            if ( isdefined( self.powerups[ i ].hud_elem ) )
            {
                self.powerups[ i ].hud_elem destroy();
            }
            
            if ( isdefined( self.powerups[ i ].hud_elem_icon ) )
            {
                self.powerups[ i ].hud_elem_icon destroy();
            }
        }
    }
    
    self.powerups = [];
}

// Namespace wager/wager
// Params 3
// Checksum 0x9c19451, Offset: 0x37c8
// Size: 0xc8
function track_weapon_usage( name, incvalue, statname )
{
    if ( !isdefined( self.wagerweaponusage ) )
    {
        self.wagerweaponusage = [];
    }
    
    if ( !isdefined( self.wagerweaponusage[ name ] ) )
    {
        self.wagerweaponusage[ name ] = [];
    }
    
    if ( !isdefined( self.wagerweaponusage[ name ][ statname ] ) )
    {
        self.wagerweaponusage[ name ][ statname ] = 0;
    }
    
    self.wagerweaponusage[ name ][ statname ] += incvalue;
}

// Namespace wager/wager
// Params 1
// Checksum 0x801e4b57, Offset: 0x3898
// Size: 0x146
function get_highest_weapon_usage( statname )
{
    if ( !isdefined( self.wagerweaponusage ) )
    {
        return undefined;
    }
    
    bestweapon = undefined;
    highestvalue = 0;
    wagerweaponsused = getarraykeys( self.wagerweaponusage );
    
    for ( i = 0; i < wagerweaponsused.size ; i++ )
    {
        weaponstats = self.wagerweaponusage[ wagerweaponsused[ i ] ];
        
        if ( !isdefined( weaponstats[ statname ] ) || !getbaseweaponitemindex( [[ level.get_base_weapon_param ]]( wagerweaponsused[ i ] ) ) )
        {
            continue;
        }
        
        if ( !isdefined( bestweapon ) || weaponstats[ statname ] > highestvalue )
        {
            bestweapon = wagerweaponsused[ i ];
            highestvalue = weaponstats[ statname ];
        }
    }
    
    return bestweapon;
}

// Namespace wager/wager
// Params 0
// Checksum 0xac6d05b5, Offset: 0x39e8
// Size: 0x17e
function set_after_action_report_stats()
{
    topweapon = self get_highest_weapon_usage( "kills" );
    topkills = 0;
    
    if ( isdefined( topweapon ) )
    {
        topkills = self.wagerweaponusage[ topweapon ][ "kills" ];
    }
    else
    {
        topweapon = self get_highest_weapon_usage( "timeUsed" );
    }
    
    if ( !isdefined( topweapon ) )
    {
        topweapon = "";
    }
    
    self persistence::set_after_action_report_stat( "topWeaponItemIndex", getbaseweaponitemindex( [[ level.get_base_weapon_param ]]( topweapon ) ) );
    self persistence::set_after_action_report_stat( "topWeaponKills", topkills );
    
    if ( isdefined( level.onwagerawards ) )
    {
        self [[ level.onwagerawards ]]();
        return;
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        self persistence::set_after_action_report_stat( "wagerAwards", 0, i );
    }
}

