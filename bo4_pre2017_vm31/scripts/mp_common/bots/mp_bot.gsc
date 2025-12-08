#using scripts/core_common/ai/planner_tdm;
#using scripts/core_common/array_shared;
#using scripts/core_common/bots/bot;
#using scripts/core_common/bots/bot_traversals;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/flag_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/player_role;
#using scripts/core_common/rank_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weapons;
#using scripts/core_common/weapons_shared;
#using scripts/mp_common/draft;
#using scripts/mp_common/gametypes/globallogic;
#using scripts/mp_common/gametypes/globallogic_player;
#using scripts/mp_common/killstreaks/emp;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/satellite;
#using scripts/mp_common/killstreaks/uav;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace bot;

// Namespace bot/mp_bot
// Params 0, eflags: 0x2
// Checksum 0xd3caf337, Offset: 0x658
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "bot_mp", &__init__, undefined, undefined );
}

// Namespace bot/mp_bot
// Params 0
// Checksum 0x6b6c9297, Offset: 0x698
// Size: 0x70
function __init__()
{
    callback::on_start_gametype( &init );
    level.onbotconnect = &on_bot_connect;
    level.onbotspawned = &on_bot_spawned;
    level.onbotkilled = &on_bot_killed;
}

// Namespace bot/mp_bot
// Params 0
// Checksum 0xdcefbc20, Offset: 0x710
// Size: 0xbc
function init()
{
    level endon( #"game_ended" );
    level thread init_strategic_command();
    botsoak = isdedicated() && getdvarint( "sv_botsoak", 0 );
    
    if ( level.rankedmatch && !botsoak )
    {
        return;
    }
    
    if ( !botsoak )
    {
        level flag::wait_till( "all_players_connected" );
    }
    
    level thread populate_bots();
}

// Namespace bot/mp_bot
// Params 0
// Checksum 0x418f62c1, Offset: 0x7d8
// Size: 0xca
function init_strategic_command()
{
    gametype = level.gametype;
    teams = level.teams;
    
    if ( isdefined( gametype ) && isdefined( teams ) )
    {
        foreach ( team in teams )
        {
            plannertdm::createcommander( team );
        }
    }
}

// Namespace bot/mp_bot
// Params 0
// Checksum 0xe346042b, Offset: 0x8b0
// Size: 0x2ac
function on_bot_connect()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !self util::function_fbea772b() )
    {
        for ( i = 0; i < 10 ; i++ )
        {
            self botclassadditem( i, "WEAPON_AR_STANDARD" );
            self botclassaddattachment( i, "WEAPON_AR_STANDARD", "reflex", "primaryattachment1" );
            self botclassaddattachment( i, "WEAPON_AR_STANDARD", "steadyaim", "primaryattachment2" );
            self botclassaddattachment( i, "WEAPON_AR_STANDARD", "extclip", "primaryattachment3" );
            self botclassaddattachment( i, "WEAPON_AR_STANDARD", "stalker", "primaryattachment4" );
            self botclassadditem( i, "WEAPON_LAUNCHER_STANDARD" );
            self botclassadditem( i, "WEAPON_FRAGGRENADE" );
            self botclassadditem( i, "WEAPON_WILLY_PETE" );
        }
    }
    
    self set_rank();
    
    switch ( getdvarint( "bot_difficulty", 1 ) )
    {
        case 0:
            self apply_bot_settings( "bot_mp_easy" );
            break;
        case 2:
            self apply_bot_settings( "bot_mp_hard" );
            break;
        case 3:
            self apply_bot_settings( "bot_mp_veteran" );
            break;
        case 1:
        default:
            self apply_bot_settings( "bot_mp_normal" );
            break;
    }
    
    self player_role::clear();
    draft::assign_remaining_players( self );
}

// Namespace bot/mp_bot
// Params 0
// Checksum 0x80f724d1, Offset: 0xb68
// Size: 0x4
function on_bot_spawned()
{
    
}

// Namespace bot/mp_bot
// Params 0
// Checksum 0xae9f8cba, Offset: 0xb78
// Size: 0x6c
function on_bot_killed()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"spawned" );
    self waittill( "death_delay_finished" );
    wait 0.1;
    
    if ( level.playerforcerespawn )
    {
        return;
    }
    
    self thread respawn();
}

// Namespace bot/mp_bot
// Params 0
// Checksum 0x13a2a3f8, Offset: 0xbf0
// Size: 0x58
function respawn()
{
    self endon( #"spawned" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self bottapbutton( 3 );
        wait 0.1;
    }
}

// Namespace bot/mp_bot
// Params 0
// Checksum 0xa3d61edd, Offset: 0xc50
// Size: 0xd4
function populate_bots()
{
    level endon( #"game_ended" );
    
    if ( level.teambased )
    {
        maxallies = getdvarint( "bot_maxAllies", 0 );
        maxaxis = getdvarint( "bot_maxAxis", 0 );
        level thread monitor_bot_team_population( maxallies, maxaxis );
        return;
    }
    
    maxfree = getdvarint( "bot_maxFree", 0 );
    level thread monitor_bot_population( maxfree );
}

// Namespace bot/mp_bot
// Params 2
// Checksum 0xb1ed7f28, Offset: 0xd30
// Size: 0x150
function monitor_bot_team_population( maxallies, maxaxis )
{
    level endon( #"game_ended" );
    
    if ( !maxallies && !maxaxis )
    {
        return;
    }
    
    fill_balanced_teams( maxallies, maxaxis );
    
    while ( true )
    {
        wait 3;
        allies = getplayers( "allies" );
        axis = getplayers( "axis" );
        
        if ( allies.size > maxallies && remove_best_bot( allies ) )
        {
            continue;
        }
        
        if ( axis.size > maxaxis && remove_best_bot( axis ) )
        {
            continue;
        }
        
        if ( allies.size < maxallies || axis.size < maxaxis )
        {
            add_balanced_bot( allies, maxallies, axis, maxaxis );
        }
    }
}

// Namespace bot/mp_bot
// Params 2
// Checksum 0xb38a73c, Offset: 0xe88
// Size: 0xec
function fill_balanced_teams( maxallies, maxaxis )
{
    allies = getplayers( "allies" );
    
    for ( axis = getplayers( "axis" ); ( allies.size < maxallies || axis.size < maxaxis ) && add_balanced_bot( allies, maxallies, axis, maxaxis ) ; axis = getplayers( "axis" ) )
    {
        waitframe( 1 );
        allies = getplayers( "allies" );
    }
}

// Namespace bot/mp_bot
// Params 4
// Checksum 0x8e70556f, Offset: 0xf80
// Size: 0xb6, Type: bool
function add_balanced_bot( allies, maxallies, axis, maxaxis )
{
    bot = undefined;
    
    if ( allies.size <= axis.size || allies.size < maxallies && axis.size >= maxaxis )
    {
        bot = add_bot( "allies" );
    }
    else if ( axis.size < maxaxis )
    {
        bot = add_bot( "axis" );
    }
    
    return isdefined( bot );
}

// Namespace bot/mp_bot
// Params 1
// Checksum 0xa7ac0c41, Offset: 0x1040
// Size: 0xf8
function monitor_bot_population( maxfree )
{
    level endon( #"game_ended" );
    
    if ( !maxfree )
    {
        return;
    }
    
    for ( players = getplayers(); players.size < maxfree ; players = getplayers() )
    {
        add_bot();
        waitframe( 1 );
    }
    
    while ( true )
    {
        wait 3;
        players = getplayers();
        
        if ( players.size < maxfree )
        {
            add_bot();
            continue;
        }
        
        if ( players.size > maxfree )
        {
            remove_best_bot( players );
        }
    }
}

// Namespace bot/mp_bot
// Params 1
// Checksum 0x5eda7244, Offset: 0x1140
// Size: 0x180, Type: bool
function remove_best_bot( players )
{
    bots = filter_bots( players );
    
    if ( !bots.size )
    {
        return false;
    }
    
    bestbots = [];
    
    foreach ( bot in bots )
    {
        if ( bot.sessionstate == "spectator" )
        {
            continue;
        }
        
        if ( bot.sessionstate == "dead" )
        {
            bestbots[ bestbots.size ] = bot;
        }
    }
    
    if ( bestbots.size )
    {
        remove_bot( bestbots[ randomint( bestbots.size ) ] );
    }
    else
    {
        remove_bot( bots[ randomint( bots.size ) ] );
    }
    
    return true;
}

// Namespace bot/mp_bot
// Params 0
// Checksum 0xccfa43cd, Offset: 0x12c8
// Size: 0x1fe
function use_killstreak()
{
    if ( !level.loadoutkillstreaksenabled || self emp::enemyempactive() )
    {
        return;
    }
    
    weapons = self getweaponslist();
    inventoryweapon = self getinventoryweapon();
    
    foreach ( weapon in weapons )
    {
        killstreak = killstreaks::get_killstreak_for_weapon( weapon );
        
        if ( !isdefined( killstreak ) )
        {
            continue;
        }
        
        if ( weapon != inventoryweapon && !self getweaponammoclip( weapon ) )
        {
            continue;
        }
        
        if ( self killstreakrules::iskillstreakallowed( killstreak, self.team ) )
        {
            useweapon = weapon;
            break;
        }
    }
    
    if ( !isdefined( useweapon ) )
    {
        return;
    }
    
    killstreak_ref = killstreaks::get_menu_name( killstreak );
    
    switch ( killstreak_ref )
    {
        case #"killstreak_counteruav":
        case #"killstreak_helicopter_player_gunner":
        case #"killstreak_raps":
        case #"killstreak_satellite":
        case #"killstreak_sentinel":
        case #"killstreak_uav":
            self switchtoweapon( useweapon );
            break;
    }
}

// Namespace bot/mp_bot
// Params 0
// Checksum 0xe93a53d9, Offset: 0x14d0
// Size: 0x32c
function set_rank()
{
    players = getplayers();
    ranks = [];
    bot_ranks = [];
    human_ranks = [];
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( players[ i ] == self )
        {
            continue;
        }
        
        if ( isdefined( players[ i ].pers[ "rank" ] ) )
        {
            if ( players[ i ] isbot() )
            {
                bot_ranks[ bot_ranks.size ] = players[ i ].pers[ "rank" ];
                continue;
            }
            
            human_ranks[ human_ranks.size ] = players[ i ].pers[ "rank" ];
        }
    }
    
    if ( !human_ranks.size )
    {
        human_ranks[ human_ranks.size ] = 10;
    }
    
    human_avg = math::array_average( human_ranks );
    
    while ( bot_ranks.size + human_ranks.size < 5 )
    {
        r = human_avg + randomintrange( -5, 5 );
        rank = math::clamp( r, 0, level.maxrank );
        human_ranks[ human_ranks.size ] = rank;
    }
    
    ranks = arraycombine( human_ranks, bot_ranks, 1, 0 );
    avg = math::array_average( ranks );
    s = math::array_std_deviation( ranks, avg );
    rank = int( math::random_normal_distribution( avg, s, 0, level.maxrank ) );
    
    while ( !isdefined( self.pers[ "codpoints" ] ) )
    {
        wait 0.1;
    }
    
    self.pers[ "rank" ] = rank;
    self.pers[ "rankxp" ] = rank::getrankinfominxp( rank );
    self setrank( rank );
    self rank::syncxpstat();
}

