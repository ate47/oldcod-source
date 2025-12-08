#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/satellite;
#using scripts/mp_common/util;

#namespace planemortar;

// Namespace planemortar/planemortar
// Params 0
// Checksum 0x5b66056b, Offset: 0x6e8
// Size: 0x15c
function init()
{
    level.planemortarexhaustfx = "killstreaks/fx_ls_exhaust_afterburner";
    clientfield::register( "scriptmover", "planemortar_contrail", 1, 1, "int" );
    killstreaks::register( "planemortar", "planemortar", "killstreak_planemortar", "planemortar_used", &usekillstreakplanemortar, 1 );
    killstreaks::register_strings( "planemortar", &"MP_EARNED_PLANEMORTAR", &"KILLSTREAK_PLANEMORTAR_NOT_AVAILABLE", &"MP_WAR_PLANEMORTAR_INBOUND", &"MP_WAR_PLANEMORTAR_INBOUND_NEAR_YOUR_POSITION", &"KILLSTREAK_PLANEMORTAR_HACKED" );
    killstreaks::register_dialog( "planemortar", "mpl_killstreak_planemortar", "planeMortarDialogBundle", "planeMortarPilotDialogBundle", "friendlyPlaneMortar", "enemyPlaneMortar", "enemyPlaneMortarMultiple", "friendlyPlaneMortarHacked", "enemyPlaneMortarHacked", "requestPlaneMortar" );
    killstreaks::set_team_kill_penalty_scale( "planemortar", level.teamkillreducedpenalty );
}

// Namespace planemortar/planemortar
// Params 1
// Checksum 0x274da234, Offset: 0x850
// Size: 0x76, Type: bool
function usekillstreakplanemortar( hardpointtype )
{
    if ( self killstreakrules::iskillstreakallowed( hardpointtype, self.team ) == 0 )
    {
        return false;
    }
    
    result = self selectplanemortarlocation( hardpointtype );
    
    if ( !isdefined( result ) || !result )
    {
        return false;
    }
    
    return true;
}

// Namespace planemortar/planemortar
// Params 0
// Checksum 0xb76a7a4f, Offset: 0x8d0
// Size: 0x42
function waittill_confirm_location()
{
    self endon( #"emp_jammed" );
    self endon( #"emp_grenaded" );
    waitresult = self waittill( "confirm_location" );
    return waitresult.position;
}

// Namespace planemortar/planemortar
// Params 1
// Checksum 0x58dfcbfa, Offset: 0x920
// Size: 0x20a
function selectplanemortarlocation( hardpointtype )
{
    self beginlocationmortarselection( "map_mortar_selector", 800, "map_mortar_selector_done" );
    self.selectinglocation = 1;
    self thread airsupport::endselectionthink();
    locations = [];
    
    if ( !isdefined( self.pers[ "mortarRadarUsed" ] ) || !self.pers[ "mortarRadarUsed" ] )
    {
        self thread singleradarsweep();
        otherteam = util::getotherteam( self.team );
        globallogic_audio::leader_dialog( "enemyPlaneMortarUsed", otherteam );
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        location = self waittill_confirm_location();
        
        if ( !isdefined( self ) )
        {
            return 0;
        }
        
        if ( !isdefined( location ) )
        {
            self.pers[ "mortarRadarUsed" ] = 1;
            self notify( #"cancel_selection" );
            return 0;
        }
        
        locations[ i ] = location;
    }
    
    if ( self killstreakrules::iskillstreakallowed( hardpointtype, self.team ) == 0 )
    {
        self.pers[ "mortarRadarUsed" ] = 1;
        self notify( #"cancel_selection" );
        return 0;
    }
    
    self.pers[ "mortarRadarUsed" ] = 0;
    return self airsupport::finishhardpointlocationusage( locations, &useplanemortar );
}

// Namespace planemortar/planemortar
// Params 1
// Checksum 0x4ebaaf6b, Offset: 0xb38
// Size: 0x8a
function waitplaybacktime( soundalias )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    playbacktime = soundgetplaybacktime( soundalias );
    
    if ( playbacktime >= 0 )
    {
        waittime = playbacktime * 0.001;
        wait waittime;
    }
    else
    {
        wait 1;
    }
    
    self notify( soundalias );
}

// Namespace planemortar/planemortar
// Params 0
// Checksum 0xd805d033, Offset: 0xbd0
// Size: 0xdc
function singleradarsweep()
{
    self endon( #"disconnect" );
    self endon( #"cancel_selection" );
    wait 0.5;
    self playlocalsound( "mpl_killstreak_satellite" );
    
    if ( level.teambased )
    {
        has_satellite = satellite::hassatellite( self.team );
    }
    else
    {
        has_satellite = satellite::hassatellite( self.entnum );
    }
    
    if ( self.hasspyplane == 0 && !has_satellite && !level.forceradar )
    {
        self thread doradarsweep();
    }
}

// Namespace planemortar/planemortar
// Params 0
// Checksum 0x7b4ceee, Offset: 0xcb8
// Size: 0x4c
function doradarsweep()
{
    self setclientuivisibilityflag( "g_compassShowEnemies", 1 );
    wait 0.2;
    self setclientuivisibilityflag( "g_compassShowEnemies", 0 );
}

// Namespace planemortar/planemortar
// Params 1
// Checksum 0xaa77e9c3, Offset: 0xd10
// Size: 0x158, Type: bool
function useplanemortar( positions )
{
    team = self.team;
    killstreak_id = self killstreakrules::killstreakstart( "planemortar", team, 0, 1 );
    
    if ( killstreak_id == -1 )
    {
        return false;
    }
    
    self killstreaks::play_killstreak_start_dialog( "planemortar", team, killstreak_id );
    self.planemortarpilotindex = killstreaks::get_random_pilot_index( "planemortar" );
    self killstreaks::play_pilot_dialog( "arrive", "planemortar", undefined, self.planemortarpilotindex );
    self addweaponstat( getweapon( "planemortar" ), "used", 1 );
    self thread planemortar_watchforendnotify( team, killstreak_id );
    self thread doplanemortar( positions, team, killstreak_id );
    return true;
}

// Namespace planemortar/planemortar
// Params 3
// Checksum 0x5eba6efa, Offset: 0xe70
// Size: 0x1a4
function doplanemortar( positions, team, killstreak_id )
{
    self endon( #"emp_jammed" );
    self endon( #"disconnect" );
    yaw = randomintrange( 0, 360 );
    odd = 0;
    wait 1.25;
    
    foreach ( position in positions )
    {
        level influencers::create_enemy_influencer( "artillery", position, team );
        self thread dobombrun( position, yaw, team );
        
        if ( odd == 0 )
        {
            yaw = ( yaw + 35 ) % 360;
        }
        else
        {
            yaw = ( yaw + 290 ) % 360;
        }
        
        odd = ( odd + 1 ) % 2;
        wait 0.8;
    }
    
    self notify( #"planemortarcomplete" );
    wait 1;
    self thread plane_mortar_bda_dialog();
}

// Namespace planemortar/planemortar
// Params 0
// Checksum 0x3a474fbe, Offset: 0x1020
// Size: 0x19e
function plane_mortar_bda_dialog()
{
    if ( isdefined( self.planemortarbda ) )
    {
        if ( self.planemortarbda === 1 )
        {
            bdadialog = "kill1";
        }
        else if ( self.planemortarbda === 2 )
        {
            bdadialog = "kill2";
        }
        else if ( self.planemortarbda === 3 )
        {
            bdadialog = "kill3";
        }
        else if ( isdefined( self.planemortarbda ) && self.planemortarbda > 3 )
        {
            bdadialog = "killMultiple";
        }
        
        self killstreaks::play_pilot_dialog( bdadialog, "planemortar", undefined, self.planemortarpilotindex );
        
        if ( battlechatter::dialog_chance( "taacomPilotKillConfirmChance" ) )
        {
            self killstreaks::play_taacom_dialog_response( "killConfirmed", "planemortar", undefined, self.planemortarpilotindex );
        }
        else
        {
            self globallogic_audio::play_taacom_dialog( "confirmHit" );
        }
    }
    else
    {
        killstreaks::play_pilot_dialog( "killNone", "planemortar", undefined, self.planemortarpilotindex );
        globallogic_audio::play_taacom_dialog( "confirmMiss" );
    }
    
    self.planemortarbda = undefined;
}

// Namespace planemortar/planemortar
// Params 2
// Checksum 0xabfe8c4a, Offset: 0x11c8
// Size: 0x5c
function planemortar_watchforendnotify( team, killstreak_id )
{
    self waittill( "disconnect", "joined_team", "joined_spectators", "planemortarcomplete", "emp_jammed" );
    planemortar_killstreakstop( team, killstreak_id );
}

// Namespace planemortar/planemortar
// Params 2
// Checksum 0x14974482, Offset: 0x1230
// Size: 0x34
function planemortar_killstreakstop( team, killstreak_id )
{
    killstreakrules::killstreakstop( "planemortar", team, killstreak_id );
}

// Namespace planemortar/planemortar
// Params 3
// Checksum 0xec509a41, Offset: 0x1270
// Size: 0x4dc
function dobombrun( position, yaw, team )
{
    self endon( #"emp_jammed" );
    player = self;
    angles = ( 0, yaw, 0 );
    direction = anglestoforward( angles );
    height = airsupport::getminimumflyheight() + 2000;
    position = ( position[ 0 ], position[ 1 ], height );
    startpoint = position + vectorscale( direction, -12000 );
    endpoint = position + vectorscale( direction, 18000 );
    height = airsupport::getnoflyzoneheightcrossed( startpoint, endpoint, height );
    startpoint = ( startpoint[ 0 ], startpoint[ 1 ], height );
    position = ( position[ 0 ], position[ 1 ], height );
    endpoint = ( endpoint[ 0 ], endpoint[ 1 ], height );
    plane = spawnplane( self, "script_model", startpoint );
    plane.team = team;
    plane.targetname = "plane_mortar";
    plane.owner = self;
    plane endon( #"delete" );
    plane endon( #"death" );
    plane thread planewatchforemp( self );
    plane.angles = angles;
    plane setmodel( "veh_t7_mil_vtol_fighter_mp" );
    plane setenemymodel( "veh_t7_mil_vtol_fighter_mp_dark" );
    plane clientfield::set( "planemortar_contrail", 1 );
    plane clientfield::set( "enemyvehicle", 1 );
    plane playsound( "mpl_lightning_flyover_boom" );
    plane setdrawinfrared( 1 );
    plane.killcament = spawn( "script_model", plane.origin + ( 0, 0, 700 ) + vectorscale( direction, -1500 ) );
    plane.killcament util::deleteaftertime( 2 * 3 );
    plane.killcament.angles = ( 15, yaw, 0 );
    plane.killcament.starttime = gettime();
    plane.killcament linkto( plane );
    start = ( position[ 0 ], position[ 1 ], plane.origin[ 2 ] );
    impact = bullettrace( start, start + ( 0, 0, -100000 ), 1, plane );
    plane moveto( endpoint, 2 * 5 / 4, 0, 0 );
    plane.killcament thread followbomb( plane, position, direction, impact, player );
    wait 2 / 2;
    
    if ( isdefined( self ) )
    {
        self thread dropbomb( plane, position );
    }
    
    wait 2 * 3 / 4;
    plane plane_cleanupondeath();
}

// Namespace planemortar/planemortar
// Params 5
// Checksum 0x3914528a, Offset: 0x1758
// Size: 0xc4
function followbomb( plane, position, direction, impact, player )
{
    player endon( #"emp_jammed" );
    wait 2 * 5 / 12;
    plane.killcament unlink();
    plane.killcament moveto( impact[ "position" ] + ( 0, 0, 1000 ) + vectorscale( direction, -600 ), 0.8, 0, 0.2 );
}

// Namespace planemortar/planemortar
// Params 1
// Checksum 0x8805245a, Offset: 0x1828
// Size: 0xb2
function lookatexplosion( bomb )
{
    while ( isdefined( self ) && isdefined( bomb ) )
    {
        angles = vectortoangles( vectornormalize( bomb.origin - self.origin ) );
        self.angles = ( max( angles[ 0 ], 15 ), angles[ 1 ], angles[ 2 ] );
        waitframe( 1 );
    }
}

// Namespace planemortar/planemortar
// Params 1
// Checksum 0x56525871, Offset: 0x18e8
// Size: 0x74
function planewatchforemp( owner )
{
    self endon( #"delete" );
    self endon( #"death" );
    waitresult = self waittill( "emp_deployed" );
    thread planeawardscoreevent( waitresult.attacker, self );
    self plane_cleanupondeath();
}

// Namespace planemortar/planemortar
// Params 2
// Checksum 0x2618de21, Offset: 0x1968
// Size: 0x124
function planeawardscoreevent( attacker, plane )
{
    attacker endon( #"disconnect" );
    attacker notify( #"planeawardscoreevent_singleton" );
    attacker endon( #"planeawardscoreevent_singleton" );
    waittillframeend();
    
    if ( !isdefined( plane.owner ) || isdefined( attacker ) && plane.owner util::isenemyplayer( attacker ) )
    {
        challenges::destroyedaircraft( attacker, getweapon( "emp" ), 0 );
        scoreevents::processscoreevent( "destroyed_plane_mortar", attacker, plane.owner, getweapon( "emp" ) );
        attacker challenges::addflyswatterstat( getweapon( "emp" ), plane );
    }
}

// Namespace planemortar/planemortar
// Params 0
// Checksum 0xbf950d2e, Offset: 0x1a98
// Size: 0x1c
function plane_cleanupondeath()
{
    self delete();
}

// Namespace planemortar/planemortar
// Params 2
// Checksum 0x498bed5d, Offset: 0x1ac0
// Size: 0x26c
function dropbomb( plane, bombposition )
{
    if ( !isdefined( plane.owner ) )
    {
        return;
    }
    
    targets = getplayers();
    
    foreach ( target in targets )
    {
        if ( plane.owner util::isenemyplayer( target ) && distance2dsquared( target.origin, bombposition ) < 250000 )
        {
            if ( bullettracepassed( ( target.origin[ 0 ], target.origin[ 1 ], plane.origin[ 2 ] ), target.origin, 0, plane ) )
            {
                bombposition = target.origin;
                break;
            }
        }
    }
    
    bombposition = ( bombposition[ 0 ], bombposition[ 1 ], plane.origin[ 2 ] );
    bomb = self magicmissile( getweapon( "planemortar" ), bombposition, ( 0, 0, -5000 ) );
    bomb.soundmod = "heli";
    bomb playsound( "mpl_lightning_bomb_incoming" );
    bomb.killcament = plane.killcament;
    plane.killcament thread lookatexplosion( bomb );
}

