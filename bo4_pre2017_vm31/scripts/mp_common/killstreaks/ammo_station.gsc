#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/gameobjects_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/turret_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/ammo_station;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/placeables;
#using scripts/mp_common/killstreaks/supplydrop;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace ammo_station;

#using_animtree( "mp_emp_power_core" );

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0xd37305af, Offset: 0x810
// Size: 0x264
function init()
{
    init_as_killstreak = 0;
    bundle = getscriptbundle( "killstreak_ammo_station" );
    level.ammostationkillstreakbundle = bundle;
    killstreaks::register( "ammo_station", "ammo_station", "killstreak_ammo_station", "ammo_station_used", &activate_station );
    killstreaks::register_strings( "ammo_station", &"KILLSTREAK_EARNED_EMP", &"KILLSTREAK_AMMO_STATION_NOT_AVAILABLE", &"KILLSTREAK_AMMO_STATION_INBOUND", undefined, &"KILLSTREAK_AMMO_STATION_HACKED", 0 );
    killstreaks::register_dialog( "ammo_station", "mpl_killstreak_emp_activate", "empDialogBundle", undefined, "friendlyEmp", "enemyEmp", "enemyEmpMultiple", "friendlyEmpHacked", "enemyEmpHacked", "requestEmp", "threatEmp" );
    clientfield::register( "scriptmover", "ammo_station_init", 1, 1, "int" );
    clientfield::register( "vehicle", "ammo_station_deploy", 1, 1, "int" );
    spinanim = %o_turret_emp_core_spin;
    deployanim = %o_turret_emp_core_deploy;
    callback::on_spawned( &onplayerspawned );
    callback::on_connect( &onplayerconnect );
    vehicle::add_main_callback( "ammo_station", &initturretvehicle );
    
    if ( false )
    {
        callback::on_spawned( &create_ammo_station_watcher );
    }
    
    /#
        level thread dev_update_script_bundle();
    #/
}

/#

    // Namespace ammo_station/ammo_station
    // Params 0
    // Checksum 0x9a203e83, Offset: 0xa80
    // Size: 0x78, Type: dev
    function dev_update_script_bundle()
    {
        level endon( #"game_ended" );
        waitframe( int( 60 ) );
        
        while ( true )
        {
            level.ammostationkillstreakbundle = getscriptbundle( "killstreak_ammo_station" );
            waitframe( int( 10 ) );
        }
    }

#/

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0x2bf44e2d, Offset: 0xb00
// Size: 0xec
function initturretvehicle()
{
    turretvehicle = self;
    turretvehicle killstreaks::setup_health( "ammo_station" );
    turretvehicle.damagetaken = 0;
    turretvehicle.health = turretvehicle.maxhealth;
    turretvehicle clientfield::set( "enemyvehicle", 1 );
    turretvehicle.soundmod = "drone_land";
    turretvehicle.overridevehicledamage = &on_station_damage;
    turretvehicle.overridevehiclekilled = &on_station_death;
    target_set( turretvehicle, ( 0, 0, 36 ) );
}

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0x80f724d1, Offset: 0xbf8
// Size: 0x4
function onplayerspawned()
{
    
}

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0xb5d9db05, Offset: 0xc08
// Size: 0x24
function onplayerconnect()
{
    self.entnum = self getentitynumber();
}

// Namespace ammo_station/ammo_station
// Params 1
// Checksum 0xb01c70b8, Offset: 0xc38
// Size: 0xd0
function activate_station( killstreak_type )
{
    success = 0;
    
    if ( true )
    {
        success = activate_station_as_placeble();
    }
    else
    {
        success = activate_station_as_thrown();
    }
    
    if ( success )
    {
        slot = self gadgetgetslot( getweapon( "ammo_station" ) );
        self gadgetpowerreset( slot );
        self gadgetcharging( slot, 1 );
    }
    
    return success;
}

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0xccd6f0d1, Offset: 0xd10
// Size: 0x8, Type: bool
function activate_station_as_thrown()
{
    return true;
}

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0xede70051, Offset: 0xd20
// Size: 0x1fc, Type: bool
function activate_station_as_placeble()
{
    player = self;
    killstreakid = player killstreakrules::killstreakstart( "ammo_station", player.team, 0, 0 );
    
    if ( killstreakid == -1 )
    {
        return false;
    }
    
    bundle = level.ammostationkillstreakbundle;
    stationbase = player placeables::spawnplaceable( "ammo_station", killstreakid, &on_place_station, &on_cancel_placement, undefined, &on_shutdown, undefined, undefined, "p7_ammo_resupply_02_box_new", "p7_ammo_resupply_02_box_new", "p7_ammo_resupply_02_box_new", 1, "", undefined, undefined, 0, bundle.ksplaceablehint, bundle.ksplaceableinvalidlocationhint );
    stationbase thread util::ghost_wait_show_to_player( player );
    stationbase.othermodel thread util::ghost_wait_show_to_others( player );
    stationbase clientfield::set( "ammo_station_init", 1 );
    stationbase.othermodel clientfield::set( "ammo_station_init", 1 );
    event = stationbase waittill( "placed", "cancelled", "death", "disconnect" );
    
    if ( event._notify != "placed" )
    {
        return false;
    }
    
    return true;
}

// Namespace ammo_station/ammo_station
// Params 1
// Checksum 0x320648d5, Offset: 0xf28
// Size: 0x33c
function on_place_station( station )
{
    player = self;
    assert( isplayer( player ) );
    assert( !isdefined( station.vehicle ) );
    self shutdown_active_station();
    station.vehicle = spawnvehicle( "ammo_station", station.origin, station.angles );
    station.vehicle thread util::ghost_wait_show( 0.05 );
    station.vehicle.killstreaktype = station.killstreaktype;
    station.vehicle.owner = player;
    station.vehicle setowner( player );
    station.vehicle.ownerentnum = player.entnum;
    station.vehicle.parentstruct = station;
    player addweaponstat( getweapon( "ammo_station" ), "used", 1 );
    station.vehicle killstreaks::configure_team( "ammo_station", station.killstreakid, player );
    station.vehicle killstreak_hacking::enable_hacking( "ammo_station", &hackedcallbackpre, &hackedcallbackpost );
    station thread killstreaks::waitfortimeout( "ammo_station", int( ( isdefined( level.ammostationkillstreakbundle.ksduration ) ? level.ammostationkillstreakbundle.ksduration : 5 ) * 1000 ), &on_timeout, "death" );
    
    if ( issentient( station.vehicle ) == 0 )
    {
        station.vehicle makesentient();
    }
    
    station.vehicle vehicle::disconnect_paths( 0, 0 );
    player thread deploy_ammo_station( station );
}

// Namespace ammo_station/ammo_station
// Params 1
// Checksum 0x3dc66e7, Offset: 0x1270
// Size: 0x35c
function deploy_ammo_station( station )
{
    player = self;
    player endon( #"disconnect" );
    player endon( #"joined_team" );
    player endon( #"joined_spectators" );
    station endon( #"death" );
    station.vehicle useanimtree( #animtree );
    station.vehicle setanim( %o_turret_emp_core_deploy, 1 );
    length = getanimlength( %o_turret_emp_core_deploy );
    station.vehicle clientfield::set( "ammo_station_deploy", 1 );
    wait length * 0.75;
    station.vehicle thread play_ammo_station_fx();
    station.vehicle playsound( "mpl_emp_turret_activate" );
    station.vehicle setanim( %o_turret_emp_core_spin, 1 );
    
    if ( !isdefined( level.ammo_stations ) )
    {
        level.ammo_stations = [];
    }
    
    if ( !isdefined( level.ammo_stations[ player.team ] ) )
    {
        level.ammo_stations[ player.team ] = [];
    }
    
    if ( !isdefined( level.ammo_stations[ player.team ] ) )
    {
        level.ammo_stations[ player.team ] = [];
    }
    else if ( !isarray( level.ammo_stations[ player.team ] ) )
    {
        level.ammo_stations[ player.team ] = array( level.ammo_stations[ player.team ] );
    }
    
    level.ammo_stations[ player.team ][ level.ammo_stations[ player.team ].size ] = station;
    spawn_ammo_trigger( station, player );
    player.pers[ #"hash_d29f58ab" ] = station;
    wait length * 0.25;
    station.vehicle clearanim( %o_turret_emp_core_deploy, 0 );
}

// Namespace ammo_station/ammo_station
// Params 2
// Checksum 0x22b83275, Offset: 0x15d8
// Size: 0x134
function spawn_ammo_trigger( station, player )
{
    pos = station.origin + ( 0, 0, 15 );
    station.ammo_trigger = spawn( "trigger_radius_use", pos );
    station.ammo_trigger setcursorhint( "HINT_NOICON", station );
    station.ammo_trigger sethintstring( &"KILLSTREAK_AMMO_STATION_RESUPPLY_HINT" );
    station.ammo_trigger setteamfortrigger( player.team );
    station.ammo_trigger.owner = player;
    station thread watch_ammo_resupply();
    station.ammo_trigger thread watch_ammo_trigger_shutdown( station );
}

// Namespace ammo_station/ammo_station
// Params 2
// Checksum 0xa8e6c5fd, Offset: 0x1718
// Size: 0x1ac
function create_use_object( station, team )
{
    pos = station.origin + ( 0, 0, 15 );
    trigger = spawn( "trigger_radius_use", pos );
    visuals = [];
    use_object = gameobjects::create_use_object( team, trigger, visuals, ( 0, 0, 0 ), istring( "KILLSTREAK_AMMO_STATION" ), 1, 1 );
    use_object gameobjects::allow_use( "friendly" );
    use_object gameobjects::set_use_time( 2 );
    use_object gameobjects::set_use_hint_text( &"KILLSTREAK_AMMO_STATION_RESUPPLY_HINT" );
    label = use_object gameobjects::get_label();
    use_object.label = label;
    use_object gameobjects::set_visible_team( "friendly" );
    use_object.onuse = &resupply_ammo;
    station.use_object = use_object;
}

// Namespace ammo_station/ammo_station
// Params 1
// Checksum 0x56081193, Offset: 0x18d0
// Size: 0x84
function hackedcallbackpre( hacker )
{
    station_vehicle = self;
    station_vehicle clientfield::set( "enemyvehicle", 2 );
    station_vehicle.parentstruct killstreaks::configure_team( "ammo_station", station_vehicle.parentstruct.killstreakid, hacker, undefined, undefined, undefined, 1 );
}

// Namespace ammo_station/ammo_station
// Params 1
// Checksum 0x3f24c732, Offset: 0x1960
// Size: 0xc
function hackedcallbackpost( hacker )
{
    
}

// Namespace ammo_station/ammo_station
// Params 1
// Checksum 0xac730d8, Offset: 0x1978
// Size: 0x54
function done_station_fx( fxtagorigin )
{
    if ( !isdefined( fxtagorigin ) )
    {
        return;
    }
    
    playfx( "killstreaks/fx_emp_exp_death", fxtagorigin );
    playsoundatposition( "mpl_emp_turret_deactivate", fxtagorigin );
}

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0x5ab4e424, Offset: 0x19d8
// Size: 0x1a
function play_ammo_station_fx()
{
    emp_vehicle = self;
    waitframe( 1 );
}

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0xadf14ccc, Offset: 0x1a00
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

// Namespace ammo_station/ammo_station
// Params 1
// Checksum 0xb7d8f1a, Offset: 0x1a90
// Size: 0x4c
function on_cancel_placement( station )
{
    stop_station( station.team, station.ownerentnum, station.originalteam, station.killstreakid );
}

// Namespace ammo_station/ammo_station
// Params 15
// Checksum 0x58116c73, Offset: 0x1ae8
// Size: 0x168
function on_station_damage( einflictor, attacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    empdamage = 0;
    idamage = self killstreaks::ondamageperweapon( "ammo_station", attacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1 );
    self.damagetaken += idamage;
    
    if ( self.damagetaken > self.maxhealth && !isdefined( self.will_die ) )
    {
        self.will_die = 1;
        self thread ondeathafterframeend( attacker, weapon );
    }
    
    return idamage;
}

// Namespace ammo_station/ammo_station
// Params 8
// Checksum 0x3ed288b4, Offset: 0x1c58
// Size: 0x64
function on_station_death( inflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    self ondeath( attacker, weapon );
}

// Namespace ammo_station/ammo_station
// Params 2
// Checksum 0xe97e4f88, Offset: 0x1cc8
// Size: 0x3c
function ondeathafterframeend( attacker, weapon )
{
    waittillframeend();
    
    if ( isdefined( self ) )
    {
        self ondeath( attacker, weapon );
    }
}

// Namespace ammo_station/ammo_station
// Params 2
// Checksum 0xaa541ccd, Offset: 0x1d10
// Size: 0x174
function ondeath( attacker, weapon )
{
    emp_vehicle = self;
    fxtagorigin = self gettagorigin( "tag_fx" );
    done_station_fx( fxtagorigin );
    
    if ( !isdefined( emp_vehicle.owner ) || isdefined( attacker ) && isplayer( attacker ) && emp_vehicle.owner util::isenemyplayer( attacker ) )
    {
        scoreevents::processscoreevent( "destroyed_ammo_station", attacker, emp_vehicle.owner, weapon );
    }
    
    if ( isdefined( attacker ) && isdefined( emp_vehicle.owner ) && attacker != emp_vehicle.owner )
    {
        emp_vehicle killstreaks::play_destroyed_dialog_on_owner( "ammo_station", emp_vehicle.parentstruct.killstreakid );
    }
    
    shutdown_station( emp_vehicle.parentstruct );
}

// Namespace ammo_station/ammo_station
// Params 1
// Checksum 0x74ed4363, Offset: 0x1e90
// Size: 0x24
function on_shutdown( station )
{
    shutdown_station( station );
}

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0x15d7a985, Offset: 0x1ec0
// Size: 0x4c
function shutdown_active_station()
{
    if ( isdefined( self.pers[ #"hash_d29f58ab" ] ) )
    {
        shutdown_station( self.pers[ #"hash_d29f58ab" ] );
    }
    
    self.pers[ #"hash_d29f58ab" ] = undefined;
}

// Namespace ammo_station/ammo_station
// Params 1
// Checksum 0x11b23aff, Offset: 0x1f18
// Size: 0x164
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
        station.vehicle clientfield::set( "ammo_station_deploy", 0 );
    }
    
    stop_station( station.team, station.ownerentnum, station.originalteam, station.killstreakid );
    arrayremovevalue( level.ammo_stations[ station.team ], station );
    
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

// Namespace ammo_station/ammo_station
// Params 4
// Checksum 0x16dad1f4, Offset: 0x2088
// Size: 0x54
function stop_station( currentteam, currentownerentnum, originalteam, killstreakid )
{
    stop_station_effect( currentteam, currentownerentnum );
    stop_station_rule( originalteam, killstreakid );
}

// Namespace ammo_station/ammo_station
// Params 2
// Checksum 0xb6f48a60, Offset: 0x20e8
// Size: 0x14
function stop_station_effect( team, ownerentnum )
{
    
}

// Namespace ammo_station/ammo_station
// Params 2
// Checksum 0xd948979d, Offset: 0x2108
// Size: 0x34
function stop_station_rule( killstreakoriginalteam, killstreakid )
{
    killstreakrules::killstreakstop( "ammo_station", killstreakoriginalteam, killstreakid );
}

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0x9486faac, Offset: 0x2148
// Size: 0x134
function create_ammo_station_watcher()
{
    watcher = self weaponobjects::createuseweaponobjectwatcher( "ammo_station", self.team );
    watcher.activatesound = "wpn_claymore_alert";
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.activationdelay = 0.1;
    watcher.headicon = 0;
    watcher.enemydestroy = 1;
    watcher.onspawn = &on_ammo_station_spawn;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 1;
}

// Namespace ammo_station/ammo_station
// Params 2
// Checksum 0x1fe4c480, Offset: 0x2288
// Size: 0x114
function on_ammo_station_spawn( watcher, player )
{
    self endon( #"death" );
    self thread weaponobjects::commononspawnuseweaponobject( watcher, player );
    
    if ( !( isdefined( self.previouslyhacked ) && self.previouslyhacked ) )
    {
        if ( isdefined( player ) )
        {
            player addweaponstat( self.weapon, "used", 1 );
        }
        
        self playloopsound( "uin_c4_air_alarm_loop" );
        self waittilltimeout( 10, "stationary" );
        delaytimesec = self.weapon.proximityalarmactivationdelay / 1000;
        
        if ( delaytimesec > 0 )
        {
            wait delaytimesec;
        }
        
        self stoploopsound( 0.1 );
    }
}

// Namespace ammo_station/ammo_station
// Params 1
// Checksum 0x6c36841d, Offset: 0x23a8
// Size: 0x84
function watch_ammo_trigger_shutdown( station )
{
    station waittill( "cancelled", "picked_up", "death", "delete_placeable_trigger", "hacker_delete_placeable_trigger" );
    station.ammo_trigger notify( #"trigger", { #cmd:"delete_trigger" } );
    station.ammo_trigger delete();
}

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0x34d90b64, Offset: 0x2438
// Size: 0x4e8
function watch_ammo_resupply()
{
    station = self;
    
    if ( !isdefined( station.ammo_resupplies_given ) )
    {
        station.ammo_resupplies_given = 0;
    }
    
    assert( isdefined( station.ammo_trigger ) );
    trigger = station.ammo_trigger;
    max_resupply_per_player = 3;
    
    while ( isdefined( trigger ) )
    {
        waitresult = trigger waittill( "trigger" );
        
        if ( isstring( waitresult.cmd ) )
        {
            if ( waitresult.cmd == "delete_trigger" )
            {
                return;
            }
            
            continue;
        }
        
        player = waitresult.activator;
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player isusingoffhand() )
        {
            continue;
        }
        
        if ( !player isonground() )
        {
            continue;
        }
        
        if ( isdefined( trigger.triggerteam ) && player.team != trigger.triggerteam )
        {
            continue;
        }
        
        can_try_to_give_ammo = player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed() && !player attackbuttonpressed() && !( isdefined( player.isplanting ) && player.isplanting ) && !( isdefined( player.isdefusing ) && player.isdefusing ) && !player isremotecontrolling() && !isdefined( player.holding_placeable );
        
        if ( can_try_to_give_ammo )
        {
            if ( !isdefined( station.last_ammo_resupply_time ) )
            {
                station.last_ammo_resupply_time = [];
            }
            
            playerentnum = player getentitynumber();
            
            if ( isdefined( station.last_ammo_resupply_time[ playerentnum ] ) )
            {
                time_before_resupply = get_ammo_station_cooldown_ms();
                
                if ( station.last_ammo_resupply_time[ playerentnum ] + time_before_resupply > gettime() )
                {
                    continue;
                }
            }
            
            useent = player supplydrop::spawnuseent();
            player.useent = useent;
            result = useent supplydrop::useholdthink( player, int( ( isdefined( level.ammostationkillstreakbundle.ksammostationusetime ) ? level.ammostationkillstreakbundle.ksammostationusetime : 0.5 ) * 1000 ) );
            
            if ( isdefined( useent ) )
            {
                useent delete();
            }
            
            if ( !result )
            {
                continue;
            }
            
            if ( isdefined( station ) )
            {
                max_resupply = isdefined( level.ammostationkillstreakbundle.ksammostationmaxresupplies ) ? level.ammostationkillstreakbundle.ksammostationmaxresupplies : 1;
                
                if ( station.ammo_resupplies_given < max_resupply )
                {
                    resupply_ammo( player, station );
                    station thread hide_ammo_trigger_during_cooldown( player );
                }
                
                if ( station.ammo_resupplies_given >= max_resupply )
                {
                    shutdown_station( station );
                }
            }
        }
    }
}

// Namespace ammo_station/ammo_station
// Params 1
// Checksum 0xdcb61b09, Offset: 0x2928
// Size: 0x12c
function hide_ammo_trigger_during_cooldown( player )
{
    station = self;
    station endon( #"death" );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    
    if ( !isdefined( station.ammo_trigger ) )
    {
        return;
    }
    
    station.ammo_trigger setinvisibletoplayer( player, 1 );
    wait_frames = int( get_ammo_station_cooldown() / 0.05 );
    waitframe( wait_frames );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isdefined( station.ammo_trigger ) )
    {
        return;
    }
    
    station.ammo_trigger setinvisibletoplayer( player, 0 );
}

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0xa458a7d9, Offset: 0x2a60
// Size: 0x32
function get_ammo_station_cooldown_ms()
{
    return int( get_ammo_station_cooldown() * 1000 );
}

// Namespace ammo_station/ammo_station
// Params 0
// Checksum 0x831e3b1f, Offset: 0x2aa0
// Size: 0x36
function get_ammo_station_cooldown()
{
    return isdefined( level.ammostationkillstreakbundle.ksammostationresupplycooldown ) ? level.ammostationkillstreakbundle.ksammostationresupplycooldown : 10;
}

// Namespace ammo_station/ammo_station
// Params 2
// Checksum 0x51b969fe, Offset: 0x2ae0
// Size: 0x14c
function resupply_ammo( player, station )
{
    primary_weapons = player getweaponslistprimaries();
    
    foreach ( weapon in primary_weapons )
    {
        player resupply_weapon_ammo( weapon );
    }
    
    if ( !isdefined( station.last_ammo_resupply_time ) )
    {
        station.last_ammo_resupply_time = [];
    }
    
    station.last_ammo_resupply_time[ player getentitynumber() ] = gettime();
    scoreevents::processscoreevent( "ammo_restore_assist", station.vehicle.owner );
    station.ammo_resupplies_given++;
}

// Namespace ammo_station/ammo_station
// Params 1
// Checksum 0x8761e6c3, Offset: 0x2c38
// Size: 0xc4
function resupply_weapon_ammo( weapon )
{
    player = self;
    new_ammo = ( isdefined( level.ammostationkillstreakbundle.ksammostationclipsperresupply ) ? level.ammostationkillstreakbundle.ksammostationclipsperresupply : 0 ) * weapon.clipsize;
    stockammo = player getweaponammostock( weapon );
    player setweaponammostock( weapon, int( stockammo + new_ammo ) );
}

