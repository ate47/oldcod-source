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
#using scripts/mp_common/killstreaks/helicopter;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_detect;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/satellite;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace counteruav;

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x53e5b33e, Offset: 0x7b8
// Size: 0x354
function init()
{
    level.activecounteruavs = [];
    level.counter_uav_positions = generaterandompoints( 20 );
    level.counter_uav_position_index = [];
    level.counter_uav_offsets = buildoffsetlist( ( 0, 0, 0 ), 3, 450, 450 );
    
    if ( level.teambased )
    {
        foreach ( team in level.teams )
        {
            level.activecounteruavs[ team ] = 0;
            level.counter_uav_position_index[ team ] = 0;
            level thread movementmanagerthink( team );
        }
    }
    else
    {
        level.activecounteruavs = [];
    }
    
    level.activeplayercounteruavs = [];
    level.counter_uav_entities = [];
    
    if ( tweakables::gettweakablevalue( "killstreak", "allowcounteruav" ) )
    {
        killstreaks::register( "counteruav", "counteruav", "killstreak_counteruav", "counteruav_used", &activatecounteruav );
        killstreaks::register_strings( "counteruav", &"KILLSTREAK_EARNED_COUNTERUAV", &"KILLSTREAK_COUNTERUAV_NOT_AVAILABLE", &"KILLSTREAK_COUNTERUAV_INBOUND", undefined, &"KILLSTREAK_COUNTERUAV_HACKED" );
        killstreaks::register_dialog( "counteruav", "mpl_killstreak_radar", "counterUavDialogBundle", "counterUavPilotDialogBundle", "friendlyCounterUav", "enemyCounterUav", "enemyCounterUavMultiple", "friendlyCounterUavHacked", "enemyCounterUavHacked", "requestCounterUav", "threatCounterUav" );
    }
    
    clientfield::register( "toplayer", "counteruav", 1, 1, "int" );
    level thread watchcounteruavs();
    callback::on_connect( &onplayerconnect );
    callback::on_spawned( &onplayerspawned );
    callback::on_joined_team( &onplayerjoinedteam );
    
    /#
        if ( getdvarint( "scr_cuav_offset_debug" ) )
        {
            level thread waitanddebugdrawoffsetlist();
        }
    #/
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x6708e4c5, Offset: 0xb18
// Size: 0xa6
function onplayerconnect()
{
    self.entnum = self getentitynumber();
    
    if ( !level.teambased )
    {
        level.activecounteruavs[ self.entnum ] = 0;
        level.counter_uav_position_index[ self.entnum ] = 0;
        self thread movementmanagerthink( self.entnum );
    }
    
    level.activeplayercounteruavs[ self.entnum ] = 0;
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0xa71ac926, Offset: 0xbc8
// Size: 0x5c
function onplayerspawned()
{
    if ( self enemycounteruavactive() )
    {
        self clientfield::set_to_player( "counteruav", 1 );
        return;
    }
    
    self clientfield::set_to_player( "counteruav", 0 );
}

// Namespace counteruav/counteruav
// Params 1
// Checksum 0x83afbd45, Offset: 0xc30
// Size: 0x160
function generaterandompoints( count )
{
    points = [];
    
    for ( i = 0; i < count ; i++ )
    {
        point = airsupport::getrandommappoint( isdefined( level.cuav_map_x_offset ) ? level.cuav_map_x_offset : 0, isdefined( level.cuav_map_y_offset ) ? level.cuav_map_y_offset : 0, isdefined( level.cuav_map_x_percentage ) ? level.cuav_map_x_percentage : 0.5, isdefined( level.cuav_map_y_percentage ) ? level.cuav_map_y_percentage : 0.5 );
        minflyheight = airsupport::getminimumflyheight();
        point += ( 0, 0, minflyheight + ( isdefined( level.counter_uav_position_z_offset ) ? level.counter_uav_position_z_offset : 1000 ) );
        points[ i ] = point;
    }
    
    return points;
}

// Namespace counteruav/counteruav
// Params 1
// Checksum 0xee872bec, Offset: 0xd98
// Size: 0x13e
function movementmanagerthink( teamorentnum )
{
    while ( true )
    {
        level waittill( "counter_uav_updated" );
        activecount = 0;
        
        while ( level.activecounteruavs[ teamorentnum ] > 0 )
        {
            if ( activecount == 0 )
            {
                activecount = level.activecounteruavs[ teamorentnum ];
            }
            
            currentindex = level.counter_uav_position_index[ teamorentnum ];
            
            for ( newindex = currentindex; newindex == currentindex ; newindex = randomintrange( 0, 20 ) )
            {
            }
            
            destination = level.counter_uav_positions[ newindex ];
            level.counter_uav_position_index[ teamorentnum ] = newindex;
            level notify( "counter_uav_move_" + teamorentnum );
            wait 5 + randomintrange( 5, 10 );
        }
    }
}

// Namespace counteruav/counteruav
// Params 1
// Checksum 0xdba12121, Offset: 0xee0
// Size: 0x64
function getcurrentposition( teamorentnum )
{
    baseposition = level.counter_uav_positions[ level.counter_uav_position_index[ teamorentnum ] ];
    offset = level.counter_uav_offsets[ self.cuav_offset_index ];
    return baseposition + offset;
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0xc71b793d, Offset: 0xf50
// Size: 0x2c
function assignfirstavailableoffsetindex()
{
    self.cuav_offset_index = getfirstavailableoffsetindex();
    maintaincouteruaventities();
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x249845e5, Offset: 0xf88
// Size: 0x13e
function getfirstavailableoffsetindex()
{
    available_offsets = [];
    
    for ( i = 0; i < level.counter_uav_offsets.size ; i++ )
    {
        available_offsets[ i ] = 1;
    }
    
    foreach ( cuav in level.counter_uav_entities )
    {
        if ( isdefined( cuav ) )
        {
            available_offsets[ cuav.cuav_offset_index ] = 0;
        }
    }
    
    for ( i = 0; i < available_offsets.size ; i++ )
    {
        if ( available_offsets[ i ] )
        {
            return i;
        }
    }
    
    /#
        util::warning( "Max counter-uav available offset slots reached. Using slot 0 for now." );
    #/
    
    return 0;
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0xcf289aa, Offset: 0x10d0
// Size: 0x6e
function maintaincouteruaventities()
{
    for ( i = level.counter_uav_entities.size; i >= 0 ; i-- )
    {
        if ( !isdefined( level.counter_uav_entities[ i ] ) )
        {
            arrayremoveindex( level.counter_uav_entities, i );
        }
    }
}

/#

    // Namespace counteruav/counteruav
    // Params 0
    // Checksum 0x7f1d3af4, Offset: 0x1148
    // Size: 0x2c, Type: dev
    function waitanddebugdrawoffsetlist()
    {
        level endon( #"game_ended" );
        wait 10;
        debugdrawoffsetlist();
    }

    // Namespace counteruav/counteruav
    // Params 0
    // Checksum 0x6fb49bee, Offset: 0x1180
    // Size: 0xe2, Type: dev
    function debugdrawoffsetlist()
    {
        baseposition = level.counter_uav_positions[ 0 ];
        
        foreach ( offset in level.counter_uav_offsets )
        {
            util::debug_sphere( baseposition + offset, 24, ( 0.95, 0.05, 0.05 ), 0.75, 9999999 );
        }
    }

#/

// Namespace counteruav/counteruav
// Params 4
// Checksum 0x1177aa97, Offset: 0x1270
// Size: 0x15e
function buildoffsetlist( startoffset, depth, offset_x, offset_y )
{
    offsets = [];
    
    for ( col = 0; col < depth ; col++ )
    {
        itemcount = math::pow( 2, col );
        startingindex = itemcount - 1;
        
        for ( i = 0; i < itemcount ; i++ )
        {
            x = offset_x * col;
            y = 0;
            
            if ( itemcount > 1 )
            {
                y = i * offset_y;
                total_y = offset_y * startingindex;
                y -= total_y / 2;
            }
            
            offsets[ startingindex + i ] = startoffset + ( x, y, 0 );
        }
    }
    
    return offsets;
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x4fa26b6, Offset: 0x13d8
// Size: 0x338, Type: bool
function activatecounteruav()
{
    if ( self killstreakrules::iskillstreakallowed( "counteruav", self.team ) == 0 )
    {
        return false;
    }
    
    killstreak_id = self killstreakrules::killstreakstart( "counteruav", self.team );
    
    if ( killstreak_id == -1 )
    {
        return false;
    }
    
    counteruav = spawncounteruav( self, killstreak_id );
    
    if ( !isdefined( counteruav ) )
    {
        return false;
    }
    
    counteruav setscale( 1 );
    counteruav clientfield::set( "enemyvehicle", 1 );
    counteruav.killstreak_id = killstreak_id;
    counteruav thread killstreaks::waittillemp( &destroycounteruavbyemp );
    counteruav thread killstreaks::waitfortimeout( "counteruav", 30000, &ontimeout, "delete", "death", "crashing" );
    counteruav thread killstreaks::waitfortimecheck( 30000 / 2, &ontimecheck, "delete", "death", "crashing" );
    counteruav thread util::waittillendonthreaded( "death", &destroycounteruav, "delete", "leaving" );
    counteruav setcandamage( 1 );
    counteruav thread killstreaks::monitordamage( "counteruav", 700, &destroycounteruav, 700 * 0.5, &onlowhealth, 0, undefined, 1 );
    counteruav playloopsound( "veh_uav_engine_loop", 1 );
    counteruav thread listenformove();
    self killstreaks::play_killstreak_start_dialog( "counteruav", self.team, killstreak_id );
    counteruav killstreaks::play_pilot_dialog_on_owner( "arrive", "counteruav", killstreak_id );
    counteruav thread killstreaks::player_killstreak_threat_tracking( "counteruav" );
    self addweaponstat( getweapon( "counteruav" ), "used", 1 );
    return true;
}

// Namespace counteruav/counteruav
// Params 1
// Checksum 0xa9a8f597, Offset: 0x1718
// Size: 0x34
function hackedprefunction( hacker )
{
    cuav = self;
    cuav resetactivecounteruav();
}

// Namespace counteruav/counteruav
// Params 2
// Checksum 0xad77fd7c, Offset: 0x1758
// Size: 0x24a
function spawncounteruav( owner, killstreak_id )
{
    minflyheight = airsupport::getminimumflyheight();
    cuav = spawnvehicle( "veh_counteruav_mp", airsupport::getmapcenter() + ( 0, 0, minflyheight + ( isdefined( level.counter_uav_position_z_offset ) ? level.counter_uav_position_z_offset : 1000 ) ), ( 0, 0, 0 ), "counteruav" );
    cuav assignfirstavailableoffsetindex();
    cuav killstreaks::configure_team( "counteruav", killstreak_id, owner, undefined, undefined, &configureteampost );
    cuav killstreak_hacking::enable_hacking( "counteruav", &hackedprefunction, undefined );
    cuav.targetname = "counteruav";
    killstreak_detect::killstreaktargetset( cuav );
    cuav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile( "crashing", undefined, 1 );
    cuav.maxhealth = 700;
    cuav.health = 99999;
    cuav.rocketdamage = 700 + 1;
    cuav setdrawinfrared( 1 );
    
    if ( !isdefined( level.counter_uav_entities ) )
    {
        level.counter_uav_entities = [];
    }
    else if ( !isarray( level.counter_uav_entities ) )
    {
        level.counter_uav_entities = array( level.counter_uav_entities );
    }
    
    level.counter_uav_entities[ level.counter_uav_entities.size ] = cuav;
    return cuav;
}

// Namespace counteruav/counteruav
// Params 2
// Checksum 0x60de8ff1, Offset: 0x19b0
// Size: 0xc4
function configureteampost( owner, ishacked )
{
    cuav = self;
    
    if ( ishacked == 0 )
    {
        cuav teams::hidetosameteam();
    }
    else
    {
        cuav setvisibletoall();
    }
    
    cuav thread teams::waituntilteamchangesingleton( owner, "CUAV_watch_team_change", &onteamchange, self.entnum, "death", "leaving", "crashing" );
    cuav addactivecounteruav();
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x6ac69f45, Offset: 0x1a80
// Size: 0x6a
function listenformove()
{
    self endon( #"death" );
    self endon( #"leaving" );
    
    while ( true )
    {
        self thread counteruavmove();
        level waittill( "counter_uav_move_" + self.team, "counter_uav_move_" + self.ownerentnum );
    }
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x152b85a8, Offset: 0x1af8
// Size: 0x164
function counteruavmove()
{
    self endon( #"death" );
    self endon( #"leaving" );
    level endon( "counter_uav_move_" + self.team );
    destination = ( 0, 0, 0 );
    
    if ( level.teambased )
    {
        destination = self getcurrentposition( self.team );
    }
    else
    {
        destination = self getcurrentposition( self.ownerentnum );
    }
    
    lookangles = vectortoangles( destination - self.origin );
    rotationaccelerationduration = 0.5 * 0.2;
    rotationdecelerationduration = 0.5 * 0.2;
    travelaccelerationduration = 5 * 0.2;
    traveldecelerationduration = 5 * 0.2;
    self setvehgoalpos( destination, 1, 0 );
}

// Namespace counteruav/counteruav
// Params 1
// Checksum 0x32a6c7cc, Offset: 0x1c68
// Size: 0x4c
function playfx( name )
{
    self endon( #"death" );
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        playfxontag( name, self, "tag_origin" );
    }
}

// Namespace counteruav/counteruav
// Params 2
// Checksum 0x3962eb7, Offset: 0x1cc0
// Size: 0x84
function onlowhealth( attacker, weapon )
{
    self.is_damaged = 1;
    params = level.killstreakbundle[ "counteruav" ];
    
    if ( isdefined( params.fxlowhealth ) )
    {
        playfxontag( params.fxlowhealth, self, "tag_origin" );
    }
}

// Namespace counteruav/counteruav
// Params 2
// Checksum 0x44929243, Offset: 0x1d50
// Size: 0x2c
function onteamchange( entnum, event )
{
    destroycounteruav( undefined, undefined );
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0xce9fd982, Offset: 0x1d88
// Size: 0x14
function onplayerjoinedteam()
{
    hideallcounteruavstosameteam();
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x38364297, Offset: 0x1da8
// Size: 0x9c
function ontimeout()
{
    self.leaving = 1;
    self killstreaks::play_pilot_dialog_on_owner( "timeout", "counteruav" );
    self airsupport::leave( 5 );
    wait 5;
    self removeactivecounteruav();
    target_remove( self );
    self delete();
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x1833c749, Offset: 0x1e50
// Size: 0x34
function ontimecheck()
{
    self killstreaks::play_pilot_dialog_on_owner( "timecheck", "counteruav", self.killstreak_id );
}

// Namespace counteruav/counteruav
// Params 2
// Checksum 0xedda20a0, Offset: 0x1e90
// Size: 0x3c
function destroycounteruavbyemp( attacker, arg )
{
    destroycounteruav( attacker, getweapon( "emp" ) );
}

// Namespace counteruav/counteruav
// Params 2
// Checksum 0x8c166fb9, Offset: 0x1ed8
// Size: 0x1a4
function destroycounteruav( attacker, weapon )
{
    if ( self.leaving !== 1 )
    {
        self killstreaks::play_destroyed_dialog_on_owner( "counteruav", self.killstreak_id );
    }
    
    attacker = self [[ level.figure_out_attacker ]]( attacker );
    
    if ( !isdefined( self.owner ) || isdefined( attacker ) && self.owner util::isenemyplayer( attacker ) )
    {
        challenges::destroyedaircraft( attacker, weapon, 0 );
        scoreevents::processscoreevent( "destroyed_counter_uav", attacker, self.owner, weapon );
        luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_COUNTERUAV", attacker.entnum );
        attacker challenges::addflyswatterstat( weapon, self );
    }
    
    self playsound( "evt_helicopter_midair_exp" );
    self removeactivecounteruav();
    target_remove( self );
    self thread deletecounteruav();
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x5fc609c8, Offset: 0x2088
// Size: 0xbc
function deletecounteruav()
{
    self notify( #"crashing" );
    params = level.killstreakbundle[ "counteruav" ];
    
    if ( isdefined( params.ksexplosionfx ) )
    {
        self thread playfx( params.ksexplosionfx );
    }
    
    wait 0.1;
    self setmodel( "tag_origin" );
    wait 0.2;
    self notify( #"delete" );
    self delete();
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x3f1e686b, Offset: 0x2150
// Size: 0x16c, Type: bool
function enemycounteruavactive()
{
    if ( level.teambased )
    {
        foreach ( team in level.teams )
        {
            if ( team == self.team )
            {
                continue;
            }
            
            if ( teamhasactivecounteruav( team ) )
            {
                return true;
            }
        }
    }
    else
    {
        enemies = self teams::getenemyplayers();
        
        foreach ( player in enemies )
        {
            if ( player hasactivecounteruav() )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0xc41ecfa9, Offset: 0x22c8
// Size: 0x20, Type: bool
function hasactivecounteruav()
{
    return level.activecounteruavs[ self.entnum ] > 0;
}

// Namespace counteruav/counteruav
// Params 1
// Checksum 0x5bca0f9a, Offset: 0x22f0
// Size: 0x20, Type: bool
function teamhasactivecounteruav( team )
{
    return level.activecounteruavs[ team ] > 0;
}

// Namespace counteruav/counteruav
// Params 1
// Checksum 0xc508d809, Offset: 0x2318
// Size: 0x20, Type: bool
function hasindexactivecounteruav( team_or_entnum )
{
    return level.activecounteruavs[ team_or_entnum ] > 0;
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0xe4e0425b, Offset: 0x2340
// Size: 0x1e0
function addactivecounteruav()
{
    if ( level.teambased )
    {
        level.activecounteruavs[ self.team ]++;
        
        foreach ( team in level.teams )
        {
            if ( team == self.team )
            {
                continue;
            }
            
            if ( satellite::hassatellite( team ) )
            {
                self.owner challenges::blockedsatellite();
            }
        }
    }
    else
    {
        level.activecounteruavs[ self.ownerentnum ]++;
        keys = getarraykeys( level.activecounteruavs );
        
        for ( i = 0; i < keys.size ; i++ )
        {
            if ( keys[ i ] == self.ownerentnum )
            {
                continue;
            }
            
            if ( satellite::hassatellite( keys[ i ] ) )
            {
                self.owner challenges::blockedsatellite();
                break;
            }
        }
    }
    
    level.activeplayercounteruavs[ self.ownerentnum ]++;
    level notify( #"counter_uav_updated" );
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x6ebd3e05, Offset: 0x2528
// Size: 0x5c
function removeactivecounteruav()
{
    cuav = self;
    cuav resetactivecounteruav();
    cuav killstreakrules::killstreakstop( "counteruav", self.originalteam, self.killstreak_id );
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x5e694031, Offset: 0x2590
// Size: 0x1ac
function resetactivecounteruav()
{
    if ( level.teambased )
    {
        level.activecounteruavs[ self.team ]--;
        assert( level.activecounteruavs[ self.team ] >= 0 );
        
        if ( level.activecounteruavs[ self.team ] < 0 )
        {
            level.activecounteruavs[ self.team ] = 0;
        }
    }
    else if ( isdefined( self.owner ) )
    {
        assert( isdefined( self.ownerentnum ) );
        
        if ( !isdefined( self.ownerentnum ) )
        {
            self.ownerentnum = self.owner getentitynumber();
        }
        
        level.activecounteruavs[ self.ownerentnum ]--;
        assert( level.activecounteruavs[ self.ownerentnum ] >= 0 );
        
        if ( level.activecounteruavs[ self.ownerentnum ] < 0 )
        {
            level.activecounteruavs[ self.ownerentnum ] = 0;
        }
    }
    
    level.activeplayercounteruavs[ self.ownerentnum ]--;
    level notify( #"counter_uav_updated" );
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0x6e94864b, Offset: 0x2748
// Size: 0xee
function watchcounteruavs()
{
    while ( true )
    {
        level waittill( "counter_uav_updated" );
        
        foreach ( player in level.players )
        {
            if ( player enemycounteruavactive() )
            {
                player clientfield::set_to_player( "counteruav", 1 );
                continue;
            }
            
            player clientfield::set_to_player( "counteruav", 0 );
        }
    }
}

// Namespace counteruav/counteruav
// Params 0
// Checksum 0xd7679e13, Offset: 0x2840
// Size: 0x9a
function hideallcounteruavstosameteam()
{
    foreach ( counteruav in level.counter_uav_entities )
    {
        if ( isdefined( counteruav ) )
        {
            counteruav teams::hidetosameteam();
        }
    }
}

