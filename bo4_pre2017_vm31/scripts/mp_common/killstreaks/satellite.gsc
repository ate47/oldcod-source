#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/tweakables_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/heatseekingmissile;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/mp_common/gametypes/battlechatter;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace satellite;

// Namespace satellite/satellite
// Params 0
// Checksum 0x411bda76, Offset: 0x6f8
// Size: 0x214
function init()
{
    if ( level.teambased )
    {
        foreach ( team in level.teams )
        {
            level.activesatellites[ team ] = 0;
        }
    }
    else
    {
        level.activesatellites = [];
    }
    
    level.activeplayersatellites = [];
    
    if ( tweakables::gettweakablevalue( "killstreak", "allowradardirection" ) )
    {
        killstreaks::register( "satellite", "satellite", "killstreak_satellite", "uav_used", &activatesatellite );
        killstreaks::register_strings( "satellite", &"KILLSTREAK_EARNED_SATELLITE", &"KILLSTREAK_SATELLITE_NOT_AVAILABLE", &"KILLSTREAK_SATELLITE_INBOUND", undefined, &"KILLSTREAK_SATELLITE_HACKED" );
        killstreaks::register_dialog( "satellite", "mpl_killstreak_satellite", "satelliteDialogBundle", undefined, "friendlySatellite", "enemySatellite", "enemySatelliteMultiple", "friendlySatelliteHacked", "enemySatelliteHacked", "requestSatellite", "threatSatellite" );
    }
    
    callback::on_connect( &onplayerconnect );
    callback::on_spawned( &onplayerspawned );
    level thread satellitetracker();
}

// Namespace satellite/satellite
// Params 0
// Checksum 0x6eb2e988, Offset: 0x918
// Size: 0x6a
function onplayerconnect()
{
    self.entnum = self getentitynumber();
    
    if ( !level.teambased )
    {
        level.activesatellites[ self.entnum ] = 0;
    }
    
    level.activeplayersatellites[ self.entnum ] = 0;
}

// Namespace satellite/satellite
// Params 1
// Checksum 0xaf64192a, Offset: 0x990
// Size: 0x2c
function onplayerspawned( local_client_num )
{
    if ( !level.teambased )
    {
        updateplayersatellitefordm( self );
    }
}

// Namespace satellite/satellite
// Params 0
// Checksum 0x800c4590, Offset: 0x9c8
// Size: 0x5e0, Type: bool
function activatesatellite()
{
    if ( self killstreakrules::iskillstreakallowed( "satellite", self.team ) == 0 )
    {
        return false;
    }
    
    killstreak_id = self killstreakrules::killstreakstart( "satellite", self.team );
    
    if ( killstreak_id == -1 )
    {
        return false;
    }
    
    minflyheight = int( airsupport::getminimumflyheight() );
    zoffset = minflyheight + 5500;
    travelangle = randomfloatrange( isdefined( level.satellite_spawn_from_angle_min ) ? level.satellite_spawn_from_angle_min : 90, isdefined( level.satellite_spawn_from_angle_max ) ? level.satellite_spawn_from_angle_max : 180 );
    travelradius = airsupport::getmaxmapwidth() * 1.5;
    xoffset = sin( travelangle ) * travelradius;
    yoffset = cos( travelangle ) * travelradius;
    satellite = spawn( "script_model", airsupport::getmapcenter() + ( xoffset, yoffset, zoffset ) );
    satellite setmodel( "veh_t7_drone_srv_blimp" );
    satellite setscale( 1 );
    satellite.killstreak_id = killstreak_id;
    satellite.owner = self;
    satellite.ownerentnum = self getentitynumber();
    satellite.team = self.team;
    satellite setteam( self.team );
    satellite setowner( self );
    satellite killstreaks::configure_team( "satellite", killstreak_id, self, undefined, undefined, &configureteampost );
    satellite killstreak_hacking::enable_hacking( "satellite", &hackedprefunction, undefined );
    satellite.targetname = "satellite";
    satellite.maxhealth = 700;
    satellite.lowhealth = 700 * 0.5;
    satellite.health = 99999;
    satellite.leaving = 0;
    satellite setcandamage( 1 );
    satellite thread killstreaks::monitordamage( "satellite", satellite.maxhealth, &destroysatellite, satellite.lowhealth, &onlowhealth, 0, undefined, 0 );
    satellite thread killstreaks::waittillemp( &destroysatellitebyemp );
    satellite.killstreakdamagemodifier = &killstreakdamagemodifier;
    satellite.rocketdamage = satellite.maxhealth / 3 + 1;
    
    /#
    #/
    
    satellite moveto( airsupport::getmapcenter() + ( xoffset * -1, yoffset * -1, zoffset ), 40000 * 0.001 );
    target_set( satellite );
    satellite clientfield::set( "enemyvehicle", 1 );
    satellite thread killstreaks::waitfortimeout( "satellite", 40000, &ontimeout, "death", "crashing" );
    satellite thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile( "death", undefined, 1 );
    satellite thread rotate( 10 );
    self killstreaks::play_killstreak_start_dialog( "satellite", self.team, killstreak_id );
    satellite thread killstreaks::player_killstreak_threat_tracking( "satellite" );
    self addweaponstat( getweapon( "satellite" ), "used", 1 );
    return true;
}

// Namespace satellite/satellite
// Params 1
// Checksum 0x63286dca, Offset: 0xfb0
// Size: 0x34
function hackedprefunction( hacker )
{
    satellite = self;
    satellite resetactivesatellite();
}

// Namespace satellite/satellite
// Params 2
// Checksum 0xaf201792, Offset: 0xff0
// Size: 0xc4
function configureteampost( owner, ishacked )
{
    satellite = self;
    satellite thread teams::waituntilteamchangesingleton( owner, "Satellite_watch_team_change", &onteamchange, self.entnum, "delete", "death", "leaving" );
    
    if ( ishacked == 0 )
    {
        satellite teams::hidetosameteam();
    }
    else
    {
        satellite setvisibletoall();
    }
    
    satellite addactivesatellite();
}

// Namespace satellite/satellite
// Params 1
// Checksum 0x1c11436b, Offset: 0x10c0
// Size: 0x46
function rotate( duration )
{
    self endon( #"death" );
    
    while ( true )
    {
        self rotateyaw( -360, duration );
        wait duration;
    }
}

// Namespace satellite/satellite
// Params 2
// Checksum 0x89f91217, Offset: 0x1110
// Size: 0x14
function onlowhealth( attacker, weapon )
{
    
}

// Namespace satellite/satellite
// Params 2
// Checksum 0x6bb9f76, Offset: 0x1130
// Size: 0x2c
function onteamchange( entnum, event )
{
    destroysatellite( undefined, undefined );
}

// Namespace satellite/satellite
// Params 0
// Checksum 0xcf072752, Offset: 0x1168
// Size: 0xb4
function ontimeout()
{
    self killstreaks::play_pilot_dialog_on_owner( "timeout", "satellite" );
    self.leaving = 1;
    self removeactivesatellite();
    airsupport::leave( 10 );
    wait 10;
    
    if ( target_istarget( self ) )
    {
        target_remove( self );
    }
    
    self delete();
}

// Namespace satellite/satellite
// Params 2
// Checksum 0x426093a1, Offset: 0x1228
// Size: 0x3c
function destroysatellitebyemp( attacker, arg )
{
    destroysatellite( attacker, getweapon( "emp" ) );
}

// Namespace satellite/satellite
// Params 2
// Checksum 0xb9f966b6, Offset: 0x1270
// Size: 0x25c
function destroysatellite( attacker, weapon )
{
    if ( !isdefined( attacker ) )
    {
        attacker = undefined;
    }
    
    if ( !isdefined( weapon ) )
    {
        weapon = undefined;
    }
    
    attacker = self [[ level.figure_out_attacker ]]( attacker );
    
    if ( !isdefined( self.owner ) || isdefined( attacker ) && self.owner util::isenemyplayer( attacker ) )
    {
        challenges::destroyedaircraft( attacker, weapon, 0 );
        scoreevents::processscoreevent( "destroyed_satellite", attacker, self.owner, weapon );
        attacker challenges::addflyswatterstat( weapon, self );
        luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_SATELLITE", attacker.entnum );
        
        if ( !self.leaving )
        {
            self killstreaks::play_destroyed_dialog_on_owner( "satellite", self.killstreak_id );
        }
    }
    
    self notify( #"crashing" );
    params = level.killstreakbundle[ "satellite" ];
    
    if ( isdefined( params.ksexplosionfx ) )
    {
        playfxontag( params.ksexplosionfx, self, "tag_origin" );
    }
    
    self setmodel( "tag_origin" );
    
    if ( target_istarget( self ) )
    {
        target_remove( self );
    }
    
    wait 0.5;
    
    if ( !self.leaving )
    {
        self removeactivesatellite();
    }
    
    self delete();
}

// Namespace satellite/satellite
// Params 1
// Checksum 0x2bb22180, Offset: 0x14d8
// Size: 0x20, Type: bool
function hassatellite( team_or_entnum )
{
    return level.activesatellites[ team_or_entnum ] > 0;
}

// Namespace satellite/satellite
// Params 0
// Checksum 0xe5ae3e6f, Offset: 0x1500
// Size: 0x6c
function addactivesatellite()
{
    if ( level.teambased )
    {
        level.activesatellites[ self.team ]++;
    }
    else
    {
        level.activesatellites[ self.ownerentnum ]++;
    }
    
    level.activeplayersatellites[ self.ownerentnum ]++;
    level notify( #"satellite_update" );
}

// Namespace satellite/satellite
// Params 0
// Checksum 0xae8f6294, Offset: 0x1578
// Size: 0x44
function removeactivesatellite()
{
    self resetactivesatellite();
    killstreakrules::killstreakstop( "satellite", self.originalteam, self.killstreak_id );
}

// Namespace satellite/satellite
// Params 0
// Checksum 0xc8bc65dd, Offset: 0x15c8
// Size: 0x1b4
function resetactivesatellite()
{
    if ( level.teambased )
    {
        level.activesatellites[ self.team ]--;
        assert( level.activesatellites[ self.team ] >= 0 );
        
        if ( level.activesatellites[ self.team ] < 0 )
        {
            level.activesatellites[ self.team ] = 0;
        }
    }
    else if ( isdefined( self.ownerentnum ) )
    {
        level.activesatellites[ self.ownerentnum ]--;
        assert( level.activesatellites[ self.ownerentnum ] >= 0 );
        
        if ( level.activesatellites[ self.ownerentnum ] < 0 )
        {
            level.activesatellites[ self.ownerentnum ] = 0;
        }
    }
    
    assert( isdefined( self.ownerentnum ) );
    level.activeplayersatellites[ self.ownerentnum ]--;
    assert( level.activeplayersatellites[ self.ownerentnum ] >= 0 );
    level notify( #"satellite_update" );
}

// Namespace satellite/satellite
// Params 0
// Checksum 0xec2f377e, Offset: 0x1788
// Size: 0x1aa
function satellitetracker()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( "satellite_update" );
        
        if ( level.teambased )
        {
            foreach ( team in level.teams )
            {
                activesatellites = level.activesatellites[ team ];
                activesatellitesanduavs = activesatellites + ( isdefined( level.activeuavs ) ? level.activeuavs[ team ] : 0 );
                setteamsatellite( team, activesatellites > 0 );
                util::set_team_radar( team, activesatellitesanduavs > 0 );
            }
            
            continue;
        }
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            updateplayersatellitefordm( level.players[ i ] );
        }
    }
}

// Namespace satellite/satellite
// Params 1
// Checksum 0x9638f6ac, Offset: 0x1940
// Size: 0xec
function updateplayersatellitefordm( player )
{
    if ( !isdefined( player.entnum ) )
    {
        player.entnum = player getentitynumber();
    }
    
    activesatellites = level.activesatellites[ player.entnum ];
    activesatellitesanduavs = activesatellites + ( isdefined( level.activeuavs ) ? level.activeuavs[ player.entnum ] : 0 );
    player setclientuivisibilityflag( "radar_client", activesatellitesanduavs > 0 );
    player.hassatellite = activesatellites > 0;
}

// Namespace satellite/satellite
// Params 12
// Checksum 0xb5aa3bf3, Offset: 0x1a38
// Size: 0xa0
function killstreakdamagemodifier( damage, attacker, direction, point, smeansofdeath, tagname, modelname, partname, weapon, flags, inflictor, chargelevel )
{
    if ( smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" )
    {
        return 0;
    }
    
    if ( smeansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        return 0;
    }
    
    return damage;
}

