#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/tweakables_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/heatseekingmissile;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_detect;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace uav;

// Namespace uav/uav
// Params 0
// Checksum 0x65f9ba78, Offset: 0x700
// Size: 0x27c
function init()
{
    if ( level.teambased )
    {
        foreach ( team in level.teams )
        {
            level.activeuavs[ team ] = 0;
        }
    }
    else
    {
        level.activeuavs = [];
    }
    
    level.activeplayeruavs = [];
    level.spawneduavs = [];
    
    if ( tweakables::gettweakablevalue( "killstreak", "allowradar" ) )
    {
        killstreaks::register( "uav", "uav", "killstreak_uav", "uav_used", &activateuav );
        killstreaks::register_strings( "uav", &"KILLSTREAK_EARNED_RADAR", &"KILLSTREAK_RADAR_NOT_AVAILABLE", &"KILLSTREAK_RADAR_INBOUND", undefined, &"KILLSTREAK_RADAR_HACKED" );
        killstreaks::register_dialog( "uav", "mpl_killstreak_radar", "uavDialogBundle", "uavPilotDialogBundle", "friendlyUav", "enemyUav", "enemyUavMultiple", "friendlyUavHacked", "enemyUavHacked", "requestUav", "threatUav" );
    }
    
    level thread uavtracker();
    callback::on_connect( &onplayerconnect );
    callback::on_spawned( &onplayerspawned );
    callback::on_joined_team( &onplayerjoinedteam );
    setmatchflag( "radar_allies", 0 );
    setmatchflag( "radar_axis", 0 );
}

// Namespace uav/uav
// Params 1
// Checksum 0xe66ee03d, Offset: 0x988
// Size: 0x34
function hackedprefunction( hacker )
{
    uav = self;
    uav resetactiveuav();
}

// Namespace uav/uav
// Params 2
// Checksum 0x5c386cb6, Offset: 0x9c8
// Size: 0xcc
function configureteampost( owner, ishacked )
{
    uav = self;
    uav thread teams::waituntilteamchangesingleton( owner, "UAV_watch_team_change", &onteamchange, owner.entnum, "delete", "death", "leaving" );
    
    if ( ishacked == 0 )
    {
        uav teams::hidetosameteam();
    }
    else
    {
        uav setvisibletoall();
    }
    
    owner addactiveuav();
}

// Namespace uav/uav
// Params 0
// Checksum 0xec8d4e24, Offset: 0xaa0
// Size: 0x698, Type: bool
function activateuav()
{
    assert( isdefined( level.players ) );
    
    if ( self killstreakrules::iskillstreakallowed( "uav", self.team ) == 0 )
    {
        return false;
    }
    
    killstreak_id = self killstreakrules::killstreakstart( "uav", self.team );
    
    if ( killstreak_id == -1 )
    {
        return false;
    }
    
    rotator = level.airsupport_rotator;
    attach_angle = -90;
    uav = spawn( "script_model", rotator gettagorigin( "tag_origin" ) );
    
    if ( !isdefined( level.spawneduavs ) )
    {
        level.spawneduavs = [];
    }
    else if ( !isarray( level.spawneduavs ) )
    {
        level.spawneduavs = array( level.spawneduavs );
    }
    
    level.spawneduavs[ level.spawneduavs.size ] = uav;
    uav setmodel( "veh_t7_drone_uav_enemy_vista" );
    uav.targetname = "uav";
    uav killstreaks::configure_team( "uav", killstreak_id, self, undefined, undefined, &configureteampost );
    uav killstreak_hacking::enable_hacking( "uav", &hackedprefunction, undefined );
    uav clientfield::set( "enemyvehicle", 1 );
    killstreak_detect::killstreaktargetset( uav );
    uav setdrawinfrared( 1 );
    uav.killstreak_id = killstreak_id;
    uav.leaving = 0;
    uav.health = 99999;
    uav.maxhealth = 700;
    uav.lowhealth = 700 * 0.5;
    uav setcandamage( 1 );
    uav thread killstreaks::monitordamage( "uav", uav.maxhealth, &destroyuav, uav.lowhealth, &onlowhealth, 0, undefined, 1 );
    uav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile( "crashing", undefined, 1 );
    uav.rocketdamage = uav.maxhealth + 1;
    minflyheight = int( airsupport::getminimumflyheight() );
    zoffset = minflyheight + ( isdefined( level.uav_z_offset ) ? level.uav_z_offset : 2500 );
    angle = randomint( 360 );
    radiusoffset = ( isdefined( level.uav_rotation_radius ) ? level.uav_rotation_radius : 4000 ) + randomint( isdefined( level.uav_rotation_random_offset ) ? level.uav_rotation_random_offset : 1000 );
    xoffset = cos( angle ) * radiusoffset;
    yoffset = sin( angle ) * radiusoffset;
    anglevector = vectornormalize( ( xoffset, yoffset, zoffset ) );
    anglevector *= zoffset;
    uav linkto( rotator, "tag_origin", anglevector, ( 0, angle + attach_angle, 0 ) );
    self addweaponstat( getweapon( "uav" ), "used", 1 );
    uav thread killstreaks::waitfortimeout( "uav", 25000, &ontimeout, "delete", "death", "crashing" );
    uav thread killstreaks::waitfortimecheck( 25000 / 2, &ontimecheck, "delete", "death", "crashing" );
    uav thread startuavfx();
    self killstreaks::play_killstreak_start_dialog( "uav", self.team, killstreak_id );
    uav killstreaks::play_pilot_dialog_on_owner( "arrive", "uav", killstreak_id );
    uav thread killstreaks::player_killstreak_threat_tracking( "uav" );
    return true;
}

// Namespace uav/uav
// Params 2
// Checksum 0xe1fbbc42, Offset: 0x1140
// Size: 0x84
function onlowhealth( attacker, weapon )
{
    self.is_damaged = 1;
    params = level.killstreakbundle[ "uav" ];
    
    if ( isdefined( params.fxlowhealth ) )
    {
        playfxontag( params.fxlowhealth, self, "tag_origin" );
    }
}

// Namespace uav/uav
// Params 2
// Checksum 0x26ce5139, Offset: 0x11d0
// Size: 0x2c
function onteamchange( entnum, event )
{
    destroyuav( undefined, undefined );
}

// Namespace uav/uav
// Params 2
// Checksum 0xc0314d82, Offset: 0x1208
// Size: 0x284
function destroyuav( attacker, weapon )
{
    attacker = self [[ level.figure_out_attacker ]]( attacker );
    
    if ( !isdefined( self.owner ) || isdefined( attacker ) && self.owner util::isenemyplayer( attacker ) )
    {
        challenges::destroyedaircraft( attacker, weapon, 0 );
        scoreevents::processscoreevent( "destroyed_uav", attacker, self.owner, weapon );
        luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_UAV", attacker.entnum );
        attacker challenges::addflyswatterstat( weapon, self );
    }
    
    if ( !self.leaving )
    {
        self removeactiveuav();
        self killstreaks::play_destroyed_dialog_on_owner( "uav", self.killstreak_id );
    }
    
    self notify( #"crashing" );
    self playsound( "evt_helicopter_midair_exp" );
    params = level.killstreakbundle[ "uav" ];
    
    if ( isdefined( params.ksexplosionfx ) )
    {
        playfxontag( params.ksexplosionfx, self, "tag_origin" );
    }
    
    self stoploopsound();
    self setmodel( "tag_origin" );
    target_remove( self );
    self unlink();
    wait 0.5;
    arrayremovevalue( level.spawneduavs, self );
    self notify( #"delete" );
    self delete();
}

// Namespace uav/uav
// Params 0
// Checksum 0xbd89a830, Offset: 0x1498
// Size: 0x6a
function onplayerconnect()
{
    self.entnum = self getentitynumber();
    
    if ( !level.teambased )
    {
        level.activeuavs[ self.entnum ] = 0;
    }
    
    level.activeplayeruavs[ self.entnum ] = 0;
}

// Namespace uav/uav
// Params 0
// Checksum 0x54c46e2, Offset: 0x1510
// Size: 0x48
function onplayerspawned()
{
    self endon( #"disconnect" );
    
    if ( level.teambased == 0 || level.multiteam == 1 )
    {
        level notify( #"uav_update" );
    }
}

// Namespace uav/uav
// Params 0
// Checksum 0x86dc31c9, Offset: 0x1560
// Size: 0x14
function onplayerjoinedteam()
{
    hidealluavstosameteam();
}

// Namespace uav/uav
// Params 0
// Checksum 0xd8f773a, Offset: 0x1580
// Size: 0x10c
function ontimeout()
{
    playafterburnerfx();
    
    if ( isdefined( self.is_damaged ) && self.is_damaged )
    {
        playfxontag( "killstreaks/fx_uav_damage_trail", self, "tag_body" );
    }
    
    self killstreaks::play_pilot_dialog_on_owner( "timeout", "uav" );
    self.leaving = 1;
    self removeactiveuav();
    airsupport::leave( 10 );
    wait 10;
    target_remove( self );
    arrayremovevalue( level.spawneduavs, self );
    self delete();
}

// Namespace uav/uav
// Params 0
// Checksum 0x841c509b, Offset: 0x1698
// Size: 0x34
function ontimecheck()
{
    self killstreaks::play_pilot_dialog_on_owner( "timecheck", "uav", self.killstreak_id );
}

// Namespace uav/uav
// Params 0
// Checksum 0x33e86954, Offset: 0x16d8
// Size: 0x84
function startuavfx()
{
    self endon( #"death" );
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        playfxontag( "killstreaks/fx_uav_lights", self, "tag_origin" );
        playfxontag( "killstreaks/fx_uav_bunner", self, "tag_origin" );
        self playloopsound( "veh_uav_engine_loop", 1 );
    }
}

// Namespace uav/uav
// Params 0
// Checksum 0x3437cc9, Offset: 0x1768
// Size: 0xa4
function playafterburnerfx()
{
    self endon( #"death" );
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        playfxontag( "killstreaks/fx_uav_bunner", self, "tag_origin" );
        self stoploopsound();
        team = util::getotherteam( self.team );
        self playsoundtoteam( "veh_kls_uav_afterburner", team );
    }
}

// Namespace uav/uav
// Params 1
// Checksum 0x218acffc, Offset: 0x1818
// Size: 0x20, Type: bool
function hasuav( team_or_entnum )
{
    return level.activeuavs[ team_or_entnum ] > 0;
}

// Namespace uav/uav
// Params 0
// Checksum 0x28572f10, Offset: 0x1840
// Size: 0xe4
function addactiveuav()
{
    if ( level.teambased )
    {
        assert( isdefined( self.team ) );
        level.activeuavs[ self.team ]++;
    }
    else
    {
        assert( isdefined( self.entnum ) );
        
        if ( !isdefined( self.entnum ) )
        {
            self.entnum = self getentitynumber();
        }
        
        level.activeuavs[ self.entnum ]++;
    }
    
    level.activeplayeruavs[ self.entnum ]++;
    level notify( #"uav_update" );
}

// Namespace uav/uav
// Params 0
// Checksum 0xe5ebdf43, Offset: 0x1930
// Size: 0x5c
function removeactiveuav()
{
    uav = self;
    uav resetactiveuav();
    uav killstreakrules::killstreakstop( "uav", self.originalteam, self.killstreak_id );
}

// Namespace uav/uav
// Params 0
// Checksum 0xe204b788, Offset: 0x1998
// Size: 0x23c
function resetactiveuav()
{
    if ( level.teambased )
    {
        level.activeuavs[ self.team ]--;
        assert( level.activeuavs[ self.team ] >= 0 );
        
        if ( level.activeuavs[ self.team ] < 0 )
        {
            level.activeuavs[ self.team ] = 0;
        }
    }
    else if ( isdefined( self.owner ) )
    {
        assert( isdefined( self.owner.entnum ) );
        
        if ( !isdefined( self.owner.entnum ) )
        {
            self.owner.entnum = self.owner getentitynumber();
        }
        
        level.activeuavs[ self.owner.entnum ]--;
        assert( level.activeuavs[ self.owner.entnum ] >= 0 );
        
        if ( level.activeuavs[ self.owner.entnum ] < 0 )
        {
            level.activeuavs[ self.owner.entnum ] = 0;
        }
    }
    
    if ( isdefined( self.owner ) )
    {
        level.activeplayeruavs[ self.owner.entnum ]--;
        assert( level.activeplayeruavs[ self.owner.entnum ] >= 0 );
    }
    
    level notify( #"uav_update" );
}

// Namespace uav/uav
// Params 0
// Checksum 0xe36acc3, Offset: 0x1be0
// Size: 0x2de
function uavtracker()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( "uav_update" );
        
        if ( level.teambased )
        {
            foreach ( team in level.teams )
            {
                activeuavs = level.activeuavs[ team ];
                activeuavsandsatellites = activeuavs + ( isdefined( level.activesatellites ) ? level.activesatellites[ team ] : 0 );
                setteamspyplane( team, int( min( activeuavs, 2 ) ) );
                util::set_team_radar( team, activeuavsandsatellites > 0 );
            }
            
            continue;
        }
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            assert( isdefined( player.entnum ) );
            
            if ( !isdefined( player.entnum ) )
            {
                player.entnum = player getentitynumber();
            }
            
            activeuavs = level.activeuavs[ player.entnum ];
            activeuavsandsatellites = activeuavs + ( isdefined( level.activesatellites ) ? level.activesatellites[ player.entnum ] : 0 );
            player setclientuivisibilityflag( "radar_client", activeuavsandsatellites > 0 );
            player.hasspyplane = int( min( activeuavs, 2 ) );
        }
    }
}

// Namespace uav/uav
// Params 0
// Checksum 0x6568ef33, Offset: 0x1ec8
// Size: 0x9a
function hidealluavstosameteam()
{
    foreach ( uav in level.spawneduavs )
    {
        if ( isdefined( uav ) )
        {
            uav teams::hidetosameteam();
        }
    }
}

