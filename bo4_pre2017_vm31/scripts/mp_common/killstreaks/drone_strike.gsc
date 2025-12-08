#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/hacker_tool;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/planemortar;
#using scripts/mp_common/killstreaks/satellite;
#using scripts/mp_common/util;

#namespace drone_strike;

// Namespace drone_strike/drone_strike
// Params 0
// Checksum 0x375ca9f1, Offset: 0x738
// Size: 0x114
function init()
{
    killstreaks::register( "drone_strike", "drone_strike", "killstreak_drone_strike", "drone_strike_used", &activatedronestrike, 1 );
    killstreaks::register_strings( "drone_strike", &"KILLSTREAK_DRONE_STRIKE_EARNED", &"KILLSTREAK_DRONE_STRIKE_NOT_AVAILABLE", &"KILLSTREAK_DRONE_STRIKE_INBOUND", &"KILLSTREAK_DRONE_STRIKE_INBOUND_NEAR_PLAYER", &"KILLSTREAK_DRONE_STRIKE_HACKED" );
    killstreaks::register_dialog( "drone_strike", "mpl_killstreak_drone_strike", "droneStrikeDialogBundle", undefined, "friendlyDroneStrike", "enemyDroneStrike", "enemyDroneStrikeMultiple", "friendlyDroneStrikeHacked", "enemyDroneStrikeHacked", "requestDroneStrike", "threatDroneStrike" );
    killstreaks::set_team_kill_penalty_scale( "drone_strike", level.teamkillreducedpenalty );
}

// Namespace drone_strike/drone_strike
// Params 0
// Checksum 0x37eb6f69, Offset: 0x858
// Size: 0x76, Type: bool
function activatedronestrike()
{
    if ( self killstreakrules::iskillstreakallowed( "drone_strike", self.team ) == 0 )
    {
        return false;
    }
    
    result = self selectdronestrikepath();
    
    if ( !isdefined( result ) || !result )
    {
        return false;
    }
    
    return true;
}

// Namespace drone_strike/drone_strike
// Params 0
// Checksum 0xdbc63c76, Offset: 0x8d8
// Size: 0x192
function selectdronestrikepath()
{
    self beginlocationnapalmselection( "map_directional_selector" );
    self.selectinglocation = 1;
    self thread airsupport::endselectionthink();
    locations = [];
    
    if ( !isdefined( self.pers[ "drone_strike_radar_used" ] ) || !self.pers[ "drone_strike_radar_used" ] )
    {
        self thread planemortar::singleradarsweep();
    }
    
    location = self waitforlocationselection();
    
    if ( !isdefined( self ) )
    {
        return 0;
    }
    
    if ( !isdefined( location.origin ) )
    {
        self.pers[ "drone_strike_radar_used" ] = 1;
        self notify( #"cancel_selection" );
        return 0;
    }
    
    if ( self killstreakrules::iskillstreakallowed( "drone_strike", self.team ) == 0 )
    {
        self.pers[ "drone_strike_radar_used" ] = 1;
        self notify( #"cancel_selection" );
        return 0;
    }
    
    self.pers[ "drone_strike_radar_used" ] = 0;
    return self airsupport::finishhardpointlocationusage( location, &dronestrikelocationselected );
}

// Namespace drone_strike/drone_strike
// Params 0
// Checksum 0xebf45340, Offset: 0xa78
// Size: 0x94
function waitforlocationselection()
{
    self endon( #"emp_jammed" );
    self endon( #"emp_grenaded" );
    waitresult = self waittill( "confirm_location" );
    locationinfo = spawnstruct();
    locationinfo.origin = waitresult.position;
    locationinfo.yaw = waitresult.yaw;
    return locationinfo;
}

// Namespace drone_strike/drone_strike
// Params 1
// Checksum 0xb4a3cd9c, Offset: 0xb18
// Size: 0x160, Type: bool
function dronestrikelocationselected( location )
{
    team = self.team;
    killstreak_id = self killstreakrules::killstreakstart( "drone_strike", team, 0, 1 );
    
    if ( killstreak_id == -1 )
    {
        return false;
    }
    
    self killstreaks::play_killstreak_start_dialog( "drone_strike", team, killstreak_id );
    self addweaponstat( getweapon( "drone_strike" ), "used", 1 );
    spawn_influencer = level influencers::create_enemy_influencer( "artillery", location.origin, team );
    self thread watchforkillstreakend( team, spawn_influencer, killstreak_id );
    self thread startdronestrike( location.origin, location.yaw, team, killstreak_id );
    return true;
}

// Namespace drone_strike/drone_strike
// Params 3
// Checksum 0x8b532eab, Offset: 0xc80
// Size: 0x6c
function watchforkillstreakend( team, influencer, killstreak_id )
{
    self waittill( "disconnect", "joined_team", "joined_spectators", "drone_strike_complete", "emp_jammed" );
    killstreakrules::killstreakstop( "drone_strike", team, killstreak_id );
}

// Namespace drone_strike/drone_strike
// Params 4
// Checksum 0xf2b77a2a, Offset: 0xcf8
// Size: 0x3b2
function startdronestrike( position, yaw, team, killstreak_id )
{
    self endon( #"emp_jammed" );
    self endon( #"joined_team" );
    self endon( #"joined_spectators" );
    self endon( #"disconnect" );
    angles = ( 0, yaw, 0 );
    direction = anglestoforward( angles );
    height = airsupport::getminimumflyheight() + 3000;
    selectedposition = ( position[ 0 ], position[ 1 ], height );
    startpoint = selectedposition + vectorscale( direction, -14000 );
    endpoint = selectedposition + vectorscale( direction, -6000 );
    tracestartpos = ( position[ 0 ], position[ 1 ], height );
    traceendpos = ( position[ 0 ], position[ 1 ], height * -1 );
    trace = bullettrace( tracestartpos, traceendpos, 0, undefined );
    targetpoint = trace[ "fraction" ] < 1 ? trace[ "position" ] : ( position[ 0 ], position[ 1 ], 0 );
    initialoffset = vectorscale( direction, ( 12 * 0.5 - 1 ) * 500 ) * -1;
    
    for ( i = 0; i < 12 ; i++ )
    {
        right = anglestoright( angles );
        rightoffset = vectorscale( right, 300 );
        leftoffset = vectorscale( right, 900 );
        forwardoffset = endpoint + initialoffset + vectorscale( direction, i * 500 );
        self thread spawndrone( startpoint + rightoffset, forwardoffset + rightoffset, targetpoint, angles, self.team, killstreak_id );
        self thread spawndrone( startpoint - rightoffset, forwardoffset - rightoffset, targetpoint, angles, self.team, killstreak_id );
        self thread spawndrone( startpoint + leftoffset, forwardoffset + leftoffset, targetpoint, angles, self.team, killstreak_id );
        wait 1;
        self playsound( "mpl_thunder_flyover_wash" );
    }
    
    wait 3;
    self notify( #"drone_strike_complete" );
}

// Namespace drone_strike/drone_strike
// Params 6
// Checksum 0x5fccad3a, Offset: 0x10b8
// Size: 0x534
function spawndrone( startpoint, endpoint, targetpoint, angles, team, killstreak_id )
{
    drone = spawnplane( self, "script_model", startpoint );
    drone.team = team;
    drone.targetname = "drone_strike";
    drone setowner( self );
    drone.owner = self;
    drone.owner thread watchownerevents( drone );
    drone killstreaks::configure_team( "drone_strike", killstreak_id, self );
    drone killstreak_hacking::enable_hacking( "drone_strike" );
    target_set( drone );
    drone endon( #"delete" );
    drone endon( #"death" );
    drone.angles = angles;
    drone setmodel( "veh_t7_drone_rolling_thunder" );
    drone setenemymodel( "veh_t7_drone_rolling_thunder" );
    drone notsolid();
    playfxontag( "killstreaks/fx_rolling_thunder_thruster_trails", drone, "tag_fx" );
    drone clientfield::set( "enemyvehicle", 1 );
    drone setupdamagehandling();
    drone thread watchforemp( self );
    drone moveto( endpoint, 1.8, 0, 0 );
    wait 1.8;
    weapon = getweapon( "drone_strike" );
    velocity = drone getvelocity();
    halfgravity = 386;
    dxy = abs( -6000 );
    dz = endpoint[ 2 ] - targetpoint[ 2 ];
    dvxy = dxy * sqrt( halfgravity / dz );
    nvel = vectornormalize( velocity );
    launchvel = nvel * dvxy;
    bomb = self magicmissile( weapon, drone.origin, launchvel );
    target_set( bomb );
    bomb killstreaks::configure_team( "drone_strike", killstreak_id, self );
    bomb killstreak_hacking::enable_hacking( "drone_strike" );
    drone notify( #"hackertool_update_ent", { #entity:bomb } );
    bomb clientfield::set( "enemyvehicle", 1 );
    bomb.targetname = "drone_strike";
    bomb setowner( self );
    bomb.owner = self;
    bomb.team = team;
    bomb playsound( "mpl_thunder_incoming_start" );
    bomb setupdamagehandling();
    bomb thread watchforemp( self );
    bomb.owner thread watchownerevents( bomb );
    waitframe( 1 );
    drone hide();
    waitframe( 1 );
    drone delete();
}

// Namespace drone_strike/drone_strike
// Params 0
// Checksum 0xf6986982, Offset: 0x15f8
// Size: 0xf4
function setupdamagehandling()
{
    drone = self;
    drone setcandamage( 1 );
    drone.maxhealth = killstreak_bundles::get_max_health( "drone_strike" );
    drone.lowhealth = killstreak_bundles::get_low_health( "drone_strike" );
    drone.health = drone.maxhealth;
    drone thread killstreaks::monitordamage( "drone_strike", drone.maxhealth, &destroydroneplane, drone.lowhealth, undefined, 0, &empdamagedrone, 1 );
}

// Namespace drone_strike/drone_strike
// Params 2
// Checksum 0x87d334bd, Offset: 0x16f8
// Size: 0x1ac
function destroydroneplane( attacker, weapon )
{
    self endon( #"death" );
    attacker = self [[ level.figure_out_attacker ]]( attacker );
    
    if ( !isdefined( self.owner ) || isdefined( attacker ) && self.owner util::isenemyplayer( attacker ) )
    {
        challenges::destroyedaircraft( attacker, weapon, 0 );
        attacker challenges::addflyswatterstat( weapon, self );
        scoreevents::processscoreevent( "destroyed_rolling_thunder_drone", attacker, self.owner, weapon );
        luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_ROLLING_THUNDER_DRONE", attacker.entnum );
    }
    
    params = level.killstreakbundle[ "drone_strike" ];
    
    if ( isdefined( params.ksexplosionfx ) )
    {
        playfxontag( params.ksexplosionfx, self, "tag_origin" );
    }
    
    self setmodel( "tag_origin" );
    wait 0.5;
    self delete();
}

// Namespace drone_strike/drone_strike
// Params 1
// Checksum 0xb5f24bc1, Offset: 0x18b0
// Size: 0x7c
function watchownerevents( bomb )
{
    player = self;
    bomb endon( #"death" );
    player waittill( "disconnect", "joined_team", "joined_spectators" );
    
    if ( isdefined( isalive( bomb ) ) )
    {
        bomb delete();
    }
}

// Namespace drone_strike/drone_strike
// Params 1
// Checksum 0xedba0b57, Offset: 0x1938
// Size: 0x74
function watchforemp( owner )
{
    self endon( #"delete" );
    self endon( #"death" );
    waitresult = self waittill( "emp_deployed" );
    thread dronestrikeawardempscoreevent( waitresult.attacker, self );
    self blowupdronestrike();
}

// Namespace drone_strike/drone_strike
// Params 1
// Checksum 0x34fb6aeb, Offset: 0x19b8
// Size: 0x3c
function empdamagedrone( attacker )
{
    thread dronestrikeawardempscoreevent( attacker, self );
    self blowupdronestrike();
}

// Namespace drone_strike/drone_strike
// Params 2
// Checksum 0xd4a10534, Offset: 0x1a00
// Size: 0x164
function dronestrikeawardempscoreevent( attacker, victim )
{
    owner = self.owner;
    attacker endon( #"disconnect" );
    attacker notify( #"dronestrikeawardscoreevent_singleton" );
    attacker endon( #"dronestrikeawardscoreevent_singleton" );
    waittillframeend();
    attacker = self [[ level.figure_out_attacker ]]( attacker );
    scoreevents::processscoreevent( "destroyed_rolling_thunder_all_drones", attacker, victim, getweapon( "emp" ) );
    challenges::destroyedaircraft( attacker, getweapon( "emp" ), 0 );
    attacker challenges::addflyswatterstat( getweapon( "emp" ), self );
    luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_ROLLING_THUNDER_ALL_DRONES", attacker.entnum );
    owner globallogic_audio::play_taacom_dialog( "destroyed", "drone_strike" );
}

// Namespace drone_strike/drone_strike
// Params 0
// Checksum 0xc106e838, Offset: 0x1b70
// Size: 0x7c
function blowupdronestrike()
{
    params = level.killstreakbundle[ "drone_strike" ];
    
    if ( isdefined( self ) && isdefined( params.ksexplosionfx ) )
    {
        playfx( params.ksexplosionfx, self.origin );
    }
    
    self delete();
}

