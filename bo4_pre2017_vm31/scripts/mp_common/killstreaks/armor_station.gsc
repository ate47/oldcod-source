#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/turret_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/mp_common/armor;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/armor_station;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/placeables;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace armor_station;

#using_animtree( "mp_emp_power_core" );

// Namespace armor_station/armor_station
// Params 0
// Checksum 0xd270ed78, Offset: 0x730
// Size: 0x274
function init()
{
    bundle = struct::get_script_bundle( "killstreak", "killstreak_armor_station" );
    level.armorstationkillstreakbundle = bundle;
    killstreaks::register( "armor_station", "armor_station", "killstreak_armor_station", "armor_station_used", &activate_station );
    killstreaks::register_strings( "armor_station", &"KILLSTREAK_EARNED_EMP", &"KILLSTREAK_ARMOR_STATION_NOT_AVAILABLE", &"KILLSTREAK_EMP_INBOUND", undefined, &"KILLSTREAK_EMP_HACKED", 0 );
    killstreaks::register_dialog( "armor_station", "mpl_killstreak_emp_activate", "empDialogBundle", undefined, "friendlyEmp", "enemyEmp", "enemyEmpMultiple", "friendlyEmpHacked", "enemyEmpHacked", "requestEmp", "threatEmp" );
    clientfield::register( "scriptmover", "armor_station_init", 1, 1, "int" );
    clientfield::register( "vehicle", "armor_station_deploy", 1, 1, "int" );
    spinanim = %o_turret_emp_core_spin;
    deployanim = %o_turret_emp_core_deploy;
    callback::on_spawned( &onplayerspawned );
    callback::on_connect( &onplayerconnect );
    vehicle::add_main_callback( "armor_station_veh", &initturretvehicle );
    
    if ( true )
    {
        callback::on_spawned( &create_armor_station_watcher );
    }
    
    /#
        level thread monitor_radius_debug();
    #/
    
    /#
        level thread dev_update_script_bundle();
    #/
}

/#

    // Namespace armor_station/armor_station
    // Params 0
    // Checksum 0x1e0104d8, Offset: 0x9b0
    // Size: 0x78, Type: dev
    function dev_update_script_bundle()
    {
        level endon( #"game_ended" );
        waitframe( int( 60 ) );
        
        while ( true )
        {
            level.armorstationkillstreakbundle = getscriptbundle( "killstreak_armor_station" );
            waitframe( int( 10 ) );
        }
    }

#/

// Namespace armor_station/armor_station
// Params 0
// Checksum 0xe3937183, Offset: 0xa30
// Size: 0xec
function initturretvehicle()
{
    turretvehicle = self;
    turretvehicle killstreaks::setup_health( "armor_station" );
    turretvehicle.damagetaken = 0;
    turretvehicle.health = turretvehicle.maxhealth;
    turretvehicle clientfield::set( "enemyvehicle", 1 );
    turretvehicle.soundmod = "drone_land";
    turretvehicle.overridevehicledamage = &on_station_damage;
    turretvehicle.overridevehiclekilled = &on_station_death;
    target_set( turretvehicle, ( 0, 0, 36 ) );
}

// Namespace armor_station/armor_station
// Params 0
// Checksum 0x80f724d1, Offset: 0xb28
// Size: 0x4
function onplayerspawned()
{
    
}

// Namespace armor_station/armor_station
// Params 0
// Checksum 0x4a067a31, Offset: 0xb38
// Size: 0x24
function onplayerconnect()
{
    self.entnum = self getentitynumber();
}

// Namespace armor_station/armor_station
// Params 1
// Checksum 0x1ade400e, Offset: 0xb68
// Size: 0xc0
function activate_station( killstreak_type )
{
    success = 0;
    
    if ( false )
    {
        success = self activate_station_as_placeble();
    }
    else
    {
        success = 1;
    }
    
    if ( success )
    {
        slot = self gadgetgetslot( getweapon( "armor_station" ) );
        self gadgetpowerset( slot, 0 );
        self gadgetcharging( slot, 0 );
    }
    
    return success;
}

// Namespace armor_station/armor_station
// Params 0
// Checksum 0x9087ae20, Offset: 0xc30
// Size: 0x4c
function shutdown_active_station()
{
    if ( isdefined( self.pers[ "active_armor_station" ] ) )
    {
        shutdown_station( self.pers[ "active_armor_station" ] );
    }
    
    self.pers[ "active_armor_station" ] = undefined;
}

// Namespace armor_station/armor_station
// Params 1
// Checksum 0x35200d9b, Offset: 0xc88
// Size: 0x150, Type: bool
function activate_station_as_thrown( thrown_object )
{
    player = self;
    killstreakid = player killstreakrules::killstreakstart( "armor_station", player.team, 0, 0 );
    
    if ( killstreakid == -1 )
    {
        return false;
    }
    
    original_team = player.team;
    thrown_object waittilltimeout( 8, "stationary", "death" );
    
    if ( !isdefined( thrown_object ) )
    {
        stop_station_rule( original_team, killstreakid );
        return false;
    }
    
    station_base = spawn( "script_model", thrown_object.origin );
    station_base killstreaks::configure_team( "armor_station", killstreakid, player );
    player on_place_station( station_base );
    thrown_object delete();
    return true;
}

// Namespace armor_station/armor_station
// Params 0
// Checksum 0xd5375d11, Offset: 0xde0
// Size: 0x1fc, Type: bool
function activate_station_as_placeble()
{
    player = self;
    killstreakid = player killstreakrules::killstreakstart( "armor_station", player.team, 0, 0 );
    
    if ( killstreakid == -1 )
    {
        return false;
    }
    
    bundle = level.armorstationkillstreakbundle;
    stationbase = player placeables::spawnplaceable( "armor_station", killstreakid, &on_place_station, &on_cancel_placement, undefined, &on_shutdown, undefined, undefined, "p8_armor_station", "p8_armor_station", "p8_armor_station", 1, "", undefined, undefined, 0, bundle.ksplaceablehint, bundle.ksplaceableinvalidlocationhint );
    stationbase thread util::ghost_wait_show_to_player( player );
    stationbase.othermodel thread util::ghost_wait_show_to_others( player );
    stationbase clientfield::set( "armor_station_init", 1 );
    stationbase.othermodel clientfield::set( "armor_station_init", 1 );
    event = stationbase waittill( "placed", "cancelled", "death", "disconnect" );
    
    if ( event._notify != "placed" )
    {
        return false;
    }
    
    return true;
}

// Namespace armor_station/armor_station
// Params 1
// Checksum 0x80a31632, Offset: 0xfe8
// Size: 0x34e
function on_place_station( station )
{
    player = self;
    assert( isplayer( player ) );
    assert( !isdefined( station.vehicle ) );
    self shutdown_active_station();
    station.vehicle = spawnvehicle( "armor_station_veh", station.origin, station.angles );
    station.vehicle thread util::ghost_wait_show( 0.05 );
    station.vehicle.killstreaktype = station.killstreaktype;
    station.vehicle.owner = player;
    station.vehicle setowner( player );
    station.vehicle.ownerentnum = player.entnum;
    station.vehicle.parentstruct = station;
    player addweaponstat( getweapon( "armor_station" ), "used", 1 );
    station.vehicle killstreaks::configure_team( "armor_station", station.killstreakid, player );
    station.vehicle killstreak_hacking::enable_hacking( "armor_station", &hackedcallbackpre, &hackedcallbackpost );
    station thread killstreaks::waitfortimeout( "armor_station", int( ( isdefined( level.armorstationkillstreakbundle.ksduration ) ? level.armorstationkillstreakbundle.ksduration : 10 ) * 1000 ), &on_timeout, "death" );
    
    if ( issentient( station.vehicle ) == 0 )
    {
        station.vehicle makesentient();
    }
    
    station.vehicle vehicle::disconnect_paths( 0, 0 );
    player thread deploy_armor_station( station );
    player.pers[ "active_armor_station" ] = station;
}

// Namespace armor_station/armor_station
// Params 1
// Checksum 0xfc5b90da, Offset: 0x1340
// Size: 0x29c
function deploy_armor_station( station )
{
    player = self;
    player endon( #"disconnect" );
    player endon( #"joined_team" );
    player endon( #"joined_spectators" );
    station endon( #"death" );
    station.vehicle useanimtree( #animtree );
    station.vehicle clientfield::set( "armor_station_deploy", 1 );
    station.vehicle thread play_armor_station_fx();
    station.vehicle playsound( "mpl_emp_turret_activate" );
    
    if ( !isdefined( level.armor_stations ) )
    {
        level.armor_stations = [];
    }
    
    if ( !isdefined( level.armor_stations[ player.team ] ) )
    {
        level.armor_stations[ player.team ] = [];
    }
    
    if ( !isdefined( level.armor_stations[ player.team ] ) )
    {
        level.armor_stations[ player.team ] = [];
    }
    else if ( !isarray( level.armor_stations[ player.team ] ) )
    {
        level.armor_stations[ player.team ] = array( level.armor_stations[ player.team ] );
    }
    
    level.armor_stations[ player.team ][ level.armor_stations[ player.team ].size ] = station;
    station.vehicle playloopsound( "mpl_armor_station_active_loop", 0.5 );
    wait 0.25;
    level thread monitor_armor_regen();
}

// Namespace armor_station/armor_station
// Params 1
// Checksum 0x8a1028da, Offset: 0x15e8
// Size: 0x84
function hackedcallbackpre( hacker )
{
    station_vehicle = self;
    station_vehicle clientfield::set( "enemyvehicle", 2 );
    station_vehicle.parentstruct killstreaks::configure_team( "armor_station", station_vehicle.parentstruct.killstreakid, hacker, undefined, undefined, undefined, 1 );
}

// Namespace armor_station/armor_station
// Params 1
// Checksum 0xf6647e09, Offset: 0x1678
// Size: 0xc
function hackedcallbackpost( hacker )
{
    
}

// Namespace armor_station/armor_station
// Params 1
// Checksum 0xbd5b7171, Offset: 0x1690
// Size: 0xc
function done_station_fx( fxtagorigin )
{
    
}

// Namespace armor_station/armor_station
// Params 0
// Checksum 0x18e88085, Offset: 0x16a8
// Size: 0x1a
function play_armor_station_fx()
{
    emp_vehicle = self;
    waitframe( 1 );
}

// Namespace armor_station/armor_station
// Params 0
// Checksum 0x6df76921, Offset: 0x16d0
// Size: 0x84
function on_timeout()
{
    station = self;
    
    if ( isdefined( station.vehicle ) )
    {
        fxtagorigin = station.vehicle gettagorigin( "tag_fx" );
        done_station_fx( fxtagorigin );
    }
    
    shutdown_station( station );
}

// Namespace armor_station/armor_station
// Params 1
// Checksum 0x7775dde4, Offset: 0x1760
// Size: 0x4c
function on_cancel_placement( station )
{
    stop_station( station.team, station.ownerentnum, station.originalteam, station.killstreakid );
}

// Namespace armor_station/armor_station
// Params 15
// Checksum 0x85874817, Offset: 0x17b8
// Size: 0x168
function on_station_damage( einflictor, attacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    empdamage = 0;
    idamage = self killstreaks::ondamageperweapon( "armor_station", attacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1 );
    self.damagetaken += idamage;
    
    if ( self.damagetaken > self.maxhealth && !isdefined( self.will_die ) )
    {
        self.will_die = 1;
        self thread ondeathafterframeend( attacker, weapon );
    }
    
    return idamage;
}

// Namespace armor_station/armor_station
// Params 8
// Checksum 0xc39518b6, Offset: 0x1928
// Size: 0x64
function on_station_death( inflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    self ondeath( attacker, weapon );
}

// Namespace armor_station/armor_station
// Params 2
// Checksum 0x6047e464, Offset: 0x1998
// Size: 0x3c
function ondeathafterframeend( attacker, weapon )
{
    waittillframeend();
    
    if ( isdefined( self ) )
    {
        self ondeath( attacker, weapon );
    }
}

// Namespace armor_station/armor_station
// Params 2
// Checksum 0xf80a1f08, Offset: 0x19e0
// Size: 0x174
function ondeath( attacker, weapon )
{
    emp_vehicle = self;
    fxtagorigin = self gettagorigin( "tag_fx" );
    done_station_fx( fxtagorigin );
    
    if ( !isdefined( emp_vehicle.owner ) || isdefined( attacker ) && isplayer( attacker ) && emp_vehicle.owner util::isenemyplayer( attacker ) )
    {
        scoreevents::processscoreevent( "destroyed_armor_regen_station", attacker, emp_vehicle.owner, weapon );
    }
    
    if ( isdefined( attacker ) && isdefined( emp_vehicle.owner ) && attacker != emp_vehicle.owner )
    {
        emp_vehicle killstreaks::play_destroyed_dialog_on_owner( "armor_station", emp_vehicle.parentstruct.killstreakid );
    }
    
    shutdown_station( emp_vehicle.parentstruct );
}

// Namespace armor_station/armor_station
// Params 1
// Checksum 0x4e249a8c, Offset: 0x1b60
// Size: 0x24
function on_shutdown( station )
{
    shutdown_station( station );
}

// Namespace armor_station/armor_station
// Params 0
// Checksum 0xbf4b2cb7, Offset: 0x1b90
// Size: 0xfc, Type: bool
function any_armor_stations_exist()
{
    if ( !isdefined( level.armor_stations ) )
    {
        return false;
    }
    
    foreach ( team in level.teams )
    {
        if ( !isdefined( team ) )
        {
            continue;
        }
        
        if ( !isdefined( level.armor_stations[ team ] ) )
        {
            continue;
        }
        
        arrayremovevalue( level.armor_stations[ team ], undefined );
        
        if ( level.armor_stations[ team ].size > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace armor_station/armor_station
// Params 1
// Checksum 0x36778caf, Offset: 0x1c98
// Size: 0x96, Type: bool
function any_armor_stations_exist_for_team( team )
{
    if ( !isdefined( level.armor_stations ) )
    {
        return false;
    }
    
    if ( !isdefined( team ) )
    {
        return false;
    }
    
    if ( !isdefined( level.armor_stations[ team ] ) )
    {
        return false;
    }
    
    arrayremovevalue( level.armor_stations[ team ], undefined );
    
    if ( level.armor_stations[ team ].size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace armor_station/armor_station
// Params 0
// Checksum 0x71a6e4dc, Offset: 0x1d38
// Size: 0x23a
function get_nearby_armor_station()
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        return undefined;
    }
    
    if ( !isdefined( player.team ) )
    {
        return undefined;
    }
    
    if ( !isdefined( level.armorstationkillstreakbundle ) )
    {
        return undefined;
    }
    
    if ( !isdefined( level.armor_stations ) )
    {
        return undefined;
    }
    
    if ( !isdefined( level.armor_stations[ player.team ] ) )
    {
        return undefined;
    }
    
    armor_regen_radius = isdefined( level.armorstationkillstreakbundle.ksarmorregenradius ) ? level.armorstationkillstreakbundle.ksarmorregenradius : 0;
    dist_sq = armor_regen_radius * armor_regen_radius;
    max_armor_boosts = isdefined( level.armorstationkillstreakbundle.ksarmorregenmaxboosts ) ? level.armorstationkillstreakbundle.ksarmorregenmaxboosts : 0;
    
    foreach ( station in level.armor_stations[ player.team ] )
    {
        if ( !isdefined( station ) )
        {
            continue;
        }
        
        if ( distancesquared( station.origin, player.origin ) > dist_sq )
        {
            continue;
        }
        
        if ( !isdefined( station.armor_boosts_given ) )
        {
            station.armor_boosts_given = 0;
        }
        
        if ( station.armor_boosts_given < max_armor_boosts )
        {
            return station;
        }
    }
    
    return undefined;
}

// Namespace armor_station/armor_station
// Params 0
// Checksum 0x9b2a72f5, Offset: 0x1f80
// Size: 0x4e
function get_regen_delay_multiplier()
{
    if ( !isdefined( level.armorstationkillstreakbundle ) || !isdefined( level.armorstationkillstreakbundle.ksarmorregendelaymultiplier ) )
    {
        return 1;
    }
    
    return level.armorstationkillstreakbundle.ksarmorregendelaymultiplier;
}

// Namespace armor_station/armor_station
// Params 0
// Checksum 0x136f26ea, Offset: 0x1fd8
// Size: 0x4e
function get_regen_time_multiplier()
{
    if ( !isdefined( level.armorstationkillstreakbundle ) || !isdefined( level.armorstationkillstreakbundle.ksarmorregentimemultiplier ) )
    {
        return 1;
    }
    
    return level.armorstationkillstreakbundle.ksarmorregentimemultiplier;
}

// Namespace armor_station/armor_station
// Params 1
// Checksum 0x8e1d9107, Offset: 0x2030
// Size: 0x184
function shutdown_station( station )
{
    if ( !isdefined( station ) )
    {
        return;
    }
    
    if ( isdefined( station.already_shutdown ) )
    {
        return;
    }
    
    station.already_shutdown = 1;
    
    if ( isdefined( station.vehicle ) )
    {
        station.vehicle clientfield::set( "armor_station_deploy", 0 );
        station.vehicle stoploopsound( 3 );
    }
    
    stop_station( station.team, station.ownerentnum, station.originalteam, station.killstreakid );
    arrayremovevalue( level.armor_stations[ station.team ], station );
    
    if ( isdefined( station.othermodel ) )
    {
        station.othermodel delete();
    }
    
    if ( isdefined( station.vehicle ) )
    {
        station.vehicle delete();
    }
    
    station delete();
}

// Namespace armor_station/armor_station
// Params 4
// Checksum 0xcd1eb768, Offset: 0x21c0
// Size: 0x54
function stop_station( currentteam, currentownerentnum, originalteam, killstreakid )
{
    stop_station_effect( currentteam, currentownerentnum );
    stop_station_rule( originalteam, killstreakid );
}

// Namespace armor_station/armor_station
// Params 2
// Checksum 0x4f221150, Offset: 0x2220
// Size: 0x14
function stop_station_effect( team, ownerentnum )
{
    
}

// Namespace armor_station/armor_station
// Params 2
// Checksum 0x5793ad68, Offset: 0x2240
// Size: 0x34
function stop_station_rule( killstreakoriginalteam, killstreakid )
{
    killstreakrules::killstreakstop( "armor_station", killstreakoriginalteam, killstreakid );
}

// Namespace armor_station/armor_station
// Params 0
// Checksum 0xf2aaeb6e, Offset: 0x2280
// Size: 0x124
function create_armor_station_watcher()
{
    watcher = self weaponobjects::createuseweaponobjectwatcher( "armor_station", self.team );
    watcher.activatesound = "wpn_claymore_alert";
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.activationdelay = 0.1;
    watcher.headicon = 0;
    watcher.enemydestroy = 1;
    watcher.onspawn = &on_armor_station_spawn;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 1;
}

// Namespace armor_station/armor_station
// Params 2
// Checksum 0xd919e516, Offset: 0x23b0
// Size: 0x2c
function on_armor_station_spawn( watcher, player )
{
    player thread activate_station_as_thrown( self );
}

// Namespace armor_station/armor_station
// Params 0
// Checksum 0x25f787e3, Offset: 0x23e8
// Size: 0x382
function monitor_armor_regen()
{
    level notify( #"monitor_armor_regen_singleton" );
    level endon( #"monitor_armor_regen_singleton" );
    level endon( #"game_ended" );
    
    while ( any_armor_stations_exist() )
    {
        boost_bars = isdefined( level.armorstationkillstreakbundle.ksarmorregenboostbars ) ? level.armorstationkillstreakbundle.ksarmorregenboostbars : 0.25;
        last_damage_threshold_ms = armor::get_damage_time_threshold_ms( isdefined( level.armorstationkillstreakbundle.ksarmorregentimenotdamaged ) ? level.armorstationkillstreakbundle.ksarmorregentimenotdamaged : 0.5 );
        max_armor_boosts = isdefined( level.armorstationkillstreakbundle.ksarmorregenmaxboosts ) ? level.armorstationkillstreakbundle.ksarmorregenmaxboosts : 10;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !player armor::has_armor_bar_capability() )
            {
                continue;
            }
            
            if ( player armor::at_peak_armor_bars() )
            {
                continue;
            }
            
            nearby_armor_station = player get_nearby_armor_station();
            
            if ( !isdefined( nearby_armor_station ) )
            {
                continue;
            }
            
            player armor::boost_armor( boost_bars, last_damage_threshold_ms );
            player playsoundtoplayer( "mpl_armor_station_recharge", player );
            
            if ( !isdefined( nearby_armor_station.owner ) || player != nearby_armor_station.owner )
            {
                scoreevents::processscoreevent( "armor_regen_assist", nearby_armor_station.owner );
            }
            
            if ( !isdefined( nearby_armor_station.armor_boosts_given ) )
            {
                nearby_armor_station.armor_boosts_given = 0;
            }
            
            nearby_armor_station.armor_boosts_given++;
            
            if ( nearby_armor_station.armor_boosts_given >= max_armor_boosts )
            {
                shutdown_station( nearby_armor_station );
            }
        }
        
        boost_interval = isdefined( level.armorstationkillstreakbundle.ksarmorregenboostinterval ) ? level.armorstationkillstreakbundle.ksarmorregenboostinterval : 0.25;
        frames_to_wait = int( boost_interval / 0.05 );
        waitframe( frames_to_wait );
    }
}

/#

    // Namespace armor_station/armor_station
    // Params 0
    // Checksum 0xc5ff2d67, Offset: 0x2778
    // Size: 0x244, Type: dev
    function monitor_radius_debug()
    {
        level endon( #"game_ended" );
        update_interval = 0.2;
        
        while ( true )
        {
            wait update_interval;
            
            if ( !isdefined( level.armor_stations ) )
            {
                continue;
            }
            
            if ( !isdefined( level.teams ) )
            {
                continue;
            }
            
            if ( !isdefined( level.armorstationkillstreakbundle ) )
            {
                return 0;
            }
            
            armorregenradius = isdefined( level.armorstationkillstreakbundle.ksarmorregenradius ) ? level.armorstationkillstreakbundle.ksarmorregenradius : 0;
            duration = int( update_interval / 0.05 ) + 1;
            
            foreach ( team in level.teams )
            {
                if ( !isdefined( team ) )
                {
                    continue;
                }
                
                if ( !isdefined( level.armor_stations[ team ] ) )
                {
                    continue;
                }
                
                foreach ( station in level.armor_stations[ team ] )
                {
                    circle( station.origin + ( 0, 0, 10 ), armorregenradius, ( 0, 1, 0 ), 0, 1, duration );
                }
            }
        }
    }

#/
