#using scripts/core_common/callbacks_shared;
#using scripts/core_common/persistence_shared;
#using scripts/core_common/spectating;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/gametypes/globallogic_ui;
#using scripts/mp_common/util;

#namespace teams;

// Namespace teams/teams
// Params 0, eflags: 0x2
// Checksum 0xe9f57da, Offset: 0x318
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "teams", &__init__, undefined, undefined );
}

// Namespace teams/teams
// Params 0
// Checksum 0x8fa70a9a, Offset: 0x358
// Size: 0x50
function __init__()
{
    callback::on_start_gametype( &init );
    level.getenemyteam = &getenemyteam;
    level.use_team_based_logic_for_locking_on = 1;
}

// Namespace teams/teams
// Params 0
// Checksum 0xdead7aee, Offset: 0x3b0
// Size: 0x25c
function init()
{
    game.strings[ "autobalance" ] = &"MP_AUTOBALANCE_NOW";
    
    if ( getdvarstring( "scr_teambalance" ) == "" )
    {
        setdvar( "scr_teambalance", "0" );
    }
    
    level.teambalance = getdvarint( "scr_teambalance" );
    level.teambalancetimer = 0;
    
    if ( getdvarstring( "scr_timeplayedcap" ) == "" )
    {
        setdvar( "scr_timeplayedcap", "1800" );
    }
    
    level.timeplayedcap = int( getdvarint( "scr_timeplayedcap" ) );
    level.freeplayers = [];
    
    if ( level.teambased )
    {
        level.alliesplayers = [];
        level.axisplayers = [];
        callback::on_connect( &on_player_connect );
        callback::on_joined_team( &on_joined_team );
        callback::on_joined_spectate( &on_joined_spectators );
        level thread update_balance_dvar();
        wait 0.15;
        
        if ( level.onlinegame )
        {
            level thread update_player_times();
        }
        
        return;
    }
    
    callback::on_connect( &on_free_player_connect );
    wait 0.15;
    
    if ( level.onlinegame )
    {
        level thread update_player_times();
    }
}

// Namespace teams/teams
// Params 0
// Checksum 0x7c80a95a, Offset: 0x618
// Size: 0x1c
function on_player_connect()
{
    self thread track_played_time();
}

// Namespace teams/teams
// Params 0
// Checksum 0xd2027406, Offset: 0x640
// Size: 0x1c
function on_free_player_connect()
{
    self thread track_free_played_time();
}

// Namespace teams/teams
// Params 0
// Checksum 0x4936b89f, Offset: 0x668
// Size: 0x4c
function on_joined_team()
{
    println( "joined team: " + self.pers[ "team" ] );
    self update_time();
}

// Namespace teams/teams
// Params 0
// Checksum 0x7ec8ffea, Offset: 0x6c0
// Size: 0x14
function on_joined_spectators()
{
    self.pers[ "teamTime" ] = undefined;
}

// Namespace teams/teams
// Params 0
// Checksum 0x36932419, Offset: 0x6e0
// Size: 0x2ac
function track_played_time()
{
    self endon( #"disconnect" );
    
    if ( !isdefined( self.pers[ "totalTimePlayed" ] ) )
    {
        self.pers[ "totalTimePlayed" ] = 0;
    }
    
    foreach ( team in level.teams )
    {
        self.timeplayed[ team ] = 0;
    }
    
    self.timeplayed[ "free" ] = 0;
    self.timeplayed[ "other" ] = 0;
    self.timeplayed[ "alive" ] = 0;
    
    if ( !isdefined( self.timeplayed[ "total" ] ) || !( level.gametype == "twar" && 0 < game.roundsplayed && 0 < self.timeplayed[ "total" ] ) )
    {
        self.timeplayed[ "total" ] = 0;
    }
    
    while ( level.inprematchperiod )
    {
        waitframe( 1 );
    }
    
    for ( ;; )
    {
        if ( game.state == "playing" )
        {
            if ( isdefined( level.teams[ self.sessionteam ] ) )
            {
                self.timeplayed[ self.sessionteam ]++;
                self.timeplayed[ "total" ]++;
                
                if ( level.mpcustommatch )
                {
                    self.pers[ "sbtimeplayed" ] = self.timeplayed[ "total" ];
                    self.sbtimeplayed = self.pers[ "sbtimeplayed" ];
                }
                
                if ( isalive( self ) )
                {
                    self.timeplayed[ "alive" ]++;
                }
            }
            else if ( self.sessionteam == "spectator" )
            {
                self.timeplayed[ "other" ]++;
            }
        }
        
        wait 1;
    }
}

// Namespace teams/teams
// Params 0
// Checksum 0x7f9cf143, Offset: 0x998
// Size: 0xa8
function update_player_times()
{
    nexttoupdate = 0;
    
    for ( ;; )
    {
        nexttoupdate++;
        
        if ( nexttoupdate >= level.players.size )
        {
            nexttoupdate = 0;
        }
        
        if ( isdefined( level.players[ nexttoupdate ] ) )
        {
            level.players[ nexttoupdate ] update_played_time();
            level.players[ nexttoupdate ] persistence::check_contract_expirations();
        }
        
        wait 1;
    }
}

// Namespace teams/teams
// Params 0
// Checksum 0xfff3771d, Offset: 0xa48
// Size: 0x452
function update_played_time()
{
    pixbeginevent( "updatePlayedTime" );
    
    if ( level.rankedmatch || level.leaguematch )
    {
        foreach ( team in level.teams )
        {
            if ( self.timeplayed[ team ] )
            {
                if ( level.teambased )
                {
                    self addplayerstat( "time_played_" + team, int( min( self.timeplayed[ team ], level.timeplayedcap ) ) );
                }
                
                self addplayerstatwithgametype( "time_played_total", int( min( self.timeplayed[ team ], level.timeplayedcap ) ) );
            }
        }
        
        if ( self.timeplayed[ "other" ] )
        {
            self addplayerstat( "time_played_other", int( min( self.timeplayed[ "other" ], level.timeplayedcap ) ) );
            self addplayerstatwithgametype( "time_played_total", int( min( self.timeplayed[ "other" ], level.timeplayedcap ) ) );
        }
        
        if ( self.timeplayed[ "alive" ] )
        {
            timealive = int( min( self.timeplayed[ "alive" ], level.timeplayedcap ) );
            self persistence::increment_contract_times( timealive );
            self addplayerstat( "time_played_alive", timealive );
        }
    }
    
    if ( level.onlinegame )
    {
        timealive = int( min( self.timeplayed[ "alive" ], level.timeplayedcap ) );
        self.pers[ "time_played_alive" ] = self.pers[ "time_played_alive" ] + timealive;
    }
    
    pixendevent();
    
    if ( game.state == "postgame" )
    {
        return;
    }
    
    foreach ( team in level.teams )
    {
        self.timeplayed[ team ] = 0;
    }
    
    self.timeplayed[ "other" ] = 0;
    self.timeplayed[ "alive" ] = 0;
}

// Namespace teams/teams
// Params 0
// Checksum 0x6ccb2480, Offset: 0xea8
// Size: 0x32
function update_time()
{
    if ( game.state != "playing" )
    {
        return;
    }
    
    self.pers[ "teamTime" ] = gettime();
}

// Namespace teams/teams
// Params 0
// Checksum 0x59da1549, Offset: 0xee8
// Size: 0xda
function update_balance_dvar()
{
    for ( ;; )
    {
        teambalance = getdvarint( "scr_teambalance" );
        
        if ( level.teambalance != teambalance )
        {
            level.teambalance = getdvarint( "scr_teambalance" );
        }
        
        timeplayedcap = getdvarint( "scr_timeplayedcap" );
        
        if ( level.timeplayedcap != timeplayedcap )
        {
            level.timeplayedcap = int( getdvarint( "scr_timeplayedcap" ) );
        }
        
        wait 1;
    }
}

// Namespace teams/teams
// Params 1
// Checksum 0xf29944d5, Offset: 0xfd0
// Size: 0x192
function change( team )
{
    if ( self.sessionstate != "dead" )
    {
        self.switching_teams = 1;
        self.switchedteamsresetgadgets = 1;
        self.joining_team = team;
        self.leaving_team = self.pers[ "team" ];
        self suicide();
    }
    
    self.pers[ "team" ] = team;
    self.team = team;
    self.pers[ "weapon" ] = undefined;
    self.pers[ "spawnweapon" ] = undefined;
    self.pers[ "savedmodel" ] = undefined;
    self.pers[ "teamTime" ] = undefined;
    self.sessionteam = self.pers[ "team" ];
    self globallogic_ui::updateobjectivetext();
    self spectating::set_permissions();
    self setclientscriptmainmenu( game.menu[ "menu_start_menu" ] );
    self openmenu( game.menu[ "menu_start_menu" ] );
    self notify( #"end_respawn" );
}

// Namespace teams/teams
// Params 0
// Checksum 0xf0d1d707, Offset: 0x1170
// Size: 0x180
function count_players()
{
    players = level.players;
    playercounts = [];
    
    foreach ( team in level.teams )
    {
        playercounts[ team ] = 0;
    }
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        team = player.pers[ "team" ];
        
        if ( isdefined( team ) && isdefined( level.teams[ team ] ) )
        {
            playercounts[ team ]++;
        }
    }
    
    return playercounts;
}

// Namespace teams/teams
// Params 0
// Checksum 0x1f7fcdc6, Offset: 0x12f8
// Size: 0x1b0
function track_free_played_time()
{
    self endon( #"disconnect" );
    
    foreach ( team in level.teams )
    {
        self.timeplayed[ team ] = 0;
    }
    
    self.timeplayed[ "other" ] = 0;
    self.timeplayed[ "total" ] = 0;
    self.timeplayed[ "alive" ] = 0;
    
    for ( ;; )
    {
        if ( game.state == "playing" )
        {
            team = self.pers[ "team" ];
            
            if ( isdefined( team ) && isdefined( level.teams[ team ] ) && self.sessionteam != "spectator" )
            {
                self.timeplayed[ team ]++;
                self.timeplayed[ "total" ]++;
                
                if ( isalive( self ) )
                {
                    self.timeplayed[ "alive" ]++;
                }
            }
            else
            {
                self.timeplayed[ "other" ]++;
            }
        }
        
        wait 1;
    }
}

// Namespace teams/teams
// Params 2
// Checksum 0x29911819, Offset: 0x14b0
// Size: 0x44
function set_player_model( team, weapon )
{
    self detachall();
    self setmovespeedscale( 1 );
}

// Namespace teams/teams
// Params 1
// Checksum 0x1c74156c, Offset: 0x1500
// Size: 0x6c
function get_flag_model( teamref )
{
    assert( isdefined( game.flagmodels ) );
    assert( isdefined( game.flagmodels[ teamref ] ) );
    return game.flagmodels[ teamref ];
}

// Namespace teams/teams
// Params 1
// Checksum 0x4df0496f, Offset: 0x1578
// Size: 0x6c
function get_flag_carry_model( teamref )
{
    assert( isdefined( game.carry_flagmodels ) );
    assert( isdefined( game.carry_flagmodels[ teamref ] ) );
    return game.carry_flagmodels[ teamref ];
}

// Namespace teams/teams
// Params 1
// Checksum 0x858ca21f, Offset: 0x15f0
// Size: 0x60
function getteamindex( team )
{
    if ( !isdefined( team ) )
    {
        return 0;
    }
    
    if ( team == "free" )
    {
        return 0;
    }
    
    if ( team == "allies" )
    {
        return 1;
    }
    
    if ( team == "axis" )
    {
        return 2;
    }
    
    return 0;
}

// Namespace teams/teams
// Params 1
// Checksum 0x3f980372, Offset: 0x1658
// Size: 0xc2
function getenemyteam( player_team )
{
    foreach ( team in level.teams )
    {
        if ( team == player_team )
        {
            continue;
        }
        
        if ( team == "spectator" )
        {
            continue;
        }
        
        return team;
    }
    
    return util::getotherteam( player_team );
}

// Namespace teams/teams
// Params 0
// Checksum 0xd6dc59ac, Offset: 0x1728
// Size: 0x14c
function getenemyplayers()
{
    enemies = [];
    
    foreach ( player in level.players )
    {
        if ( player.team == "spectator" )
        {
            continue;
        }
        
        if ( !level.teambased && ( level.teambased && player.team != self.team || player != self ) )
        {
            if ( !isdefined( enemies ) )
            {
                enemies = [];
            }
            else if ( !isarray( enemies ) )
            {
                enemies = array( enemies );
            }
            
            enemies[ enemies.size ] = player;
        }
    }
    
    return enemies;
}

// Namespace teams/teams
// Params 0
// Checksum 0xbe2c0d37, Offset: 0x1880
// Size: 0x10c
function getfriendlyplayers()
{
    friendlies = [];
    
    foreach ( player in level.players )
    {
        if ( player.team == self.team && player != self )
        {
            if ( !isdefined( friendlies ) )
            {
                friendlies = [];
            }
            else if ( !isarray( friendlies ) )
            {
                friendlies = array( friendlies );
            }
            
            friendlies[ friendlies.size ] = player;
        }
    }
    
    return friendlies;
}

// Namespace teams/teams
// Params 6
// Checksum 0x9442d40, Offset: 0x1998
// Size: 0xbc
function waituntilteamchange( player, callback, arg, end_condition1, end_condition2, end_condition3 )
{
    if ( isdefined( end_condition1 ) )
    {
        self endon( end_condition1 );
    }
    
    if ( isdefined( end_condition2 ) )
    {
        self endon( end_condition2 );
    }
    
    if ( isdefined( end_condition3 ) )
    {
        self endon( end_condition3 );
    }
    
    event = player waittill( "joined_team", "disconnect", "joined_spectators" );
    
    if ( isdefined( callback ) )
    {
        self [[ callback ]]( arg, event );
    }
}

// Namespace teams/teams
// Params 7
// Checksum 0x622b7e34, Offset: 0x1a60
// Size: 0xd8
function waituntilteamchangesingleton( player, singletonstring, callback, arg, end_condition1, end_condition2, end_condition3 )
{
    self notify( singletonstring );
    self endon( singletonstring );
    
    if ( isdefined( end_condition1 ) )
    {
        self endon( end_condition1 );
    }
    
    if ( isdefined( end_condition2 ) )
    {
        self endon( end_condition2 );
    }
    
    if ( isdefined( end_condition3 ) )
    {
        self endon( end_condition3 );
    }
    
    event = player waittill( "joined_team", "disconnect", "joined_spectators" );
    
    if ( isdefined( callback ) )
    {
        self thread [[ callback ]]( arg, event );
    }
}

// Namespace teams/teams
// Params 0
// Checksum 0xdbc5197, Offset: 0x1b40
// Size: 0x6c
function hidetosameteam()
{
    if ( level.teambased )
    {
        self setvisibletoallexceptteam( self.team );
        return;
    }
    
    self setvisibletoall();
    self setinvisibletoplayer( self.owner );
}

