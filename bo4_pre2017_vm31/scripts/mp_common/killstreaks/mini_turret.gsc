#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_ai_shared;
#using scripts/core_common/vehicle_death_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/weaponobjects;
#using scripts/mp_common/gametypes/globallogic_audio;
#using scripts/mp_common/gametypes/hostmigration;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/emp;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/placeables;
#using scripts/mp_common/killstreaks/remote_weapons;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace mini_turret;

#using_animtree( "mp_autoturret" );

// Namespace mini_turret/mini_turret
// Params 0
// Checksum 0x2b9ab20c, Offset: 0x968
// Size: 0x254
function init()
{
    killstreaks::register( "mini_turret", "mini_turret", "killstreak_mini_turret", "mini_turret_used", &activateturret );
    killstreaks::register_alt_weapon( "mini_turret", "gun_mini_turret" );
    killstreaks::register_strings( "mini_turret", &"KILLSTREAK_EARNED_AUTO_TURRET", &"KILLSTREAK_AUTO_TURRET_NOT_AVAILABLE", &"KILLSTREAK_AUTO_TURRET_INBOUND", undefined, &"KILLSTREAK_AUTO_TURRET_HACKED", 0 );
    killstreaks::register_dialog( "mini_turret", "mpl_killstreak_auto_turret", "turretDialogBundle", undefined, "friendlyTurret", "enemyTurret", "enemyTurretMultiple", "friendlyTurretHacked", "enemyTurretHacked", "requestTurret", "threatTurret" );
    killstreaks::allow_assists( "mini_turret", 1 );
    level.killstreaks[ "mini_turret" ].threatonkill = 1;
    clientfield::register( "vehicle", "mini_turret_open", 1, 1, "int" );
    clientfield::register( "scriptmover", "mini_turret_init", 1, 1, "int" );
    clientfield::register( "scriptmover", "mini_turret_close", 1, 1, "int" );
    level.autoturretopenanim = %o_turret_sentry_deploy;
    level.autoturretcloseanim = %o_turret_sentry_close;
    vehicle::add_main_callback( "mini_turret", &initturret );
    callback::add_weapon_watcher( &createturretwatcher );
}

// Namespace mini_turret/mini_turret
// Params 0
// Checksum 0x4f581e23, Offset: 0xbc8
// Size: 0x160
function initturret()
{
    turretvehicle = self;
    turretvehicle.dontfreeme = 1;
    turretvehicle.damage_on_death = 0;
    turretvehicle.delete_on_death = undefined;
    turretvehicle.maxhealth = 2000;
    turretvehicle.damagetaken = 0;
    tablehealth = killstreak_bundles::get_max_health( "mini_turret" );
    
    if ( isdefined( tablehealth ) )
    {
        turretvehicle.maxhealth = tablehealth;
    }
    
    turretvehicle.health = turretvehicle.maxhealth;
    turretvehicle.maxsightdistsqrd = 2500 * 2500;
    turretvehicle turretsetontargettolerance( 0, 15 );
    turretvehicle clientfield::set( "enemyvehicle", 1 );
    turretvehicle.soundmod = "mini_turret";
    turretvehicle.overridevehicledamage = &onturretdamage;
    turretvehicle.overridevehiclekilled = &onturretdeath;
}

// Namespace mini_turret/mini_turret
// Params 0
// Checksum 0x8c6f8d2, Offset: 0xd30
// Size: 0x48, Type: bool
function activateturret()
{
    player = self;
    assert( isplayer( player ) );
    return true;
}

// Namespace mini_turret/mini_turret
// Params 0
// Checksum 0x2eb12045, Offset: 0xd80
// Size: 0x144
function createturretwatcher()
{
    watcher = self weaponobjects::createuseweaponobjectwatcher( "mini_turret", self.team );
    watcher.altdetonate = 1;
    watcher.watchforfire = 1;
    watcher.headicon = 0;
    watcher.onspawn = &miniturretspawn;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 1;
    watcher.ownergetsassist = 1;
    watcher.detonatestationary = 1;
    watcher.detonationdelay = getdvarfloat( "scr_satchel_detonation_delay", 0 );
    watcher.detonationsound = "wpn_claymore_alert";
    watcher.proximityalarmactivatesound = "uin_c4_enemy_detection_alert";
    watcher.immunespecialty = "specialty_immunetriggerc4";
}

// Namespace mini_turret/mini_turret
// Params 2
// Checksum 0x8512d272, Offset: 0xed0
// Size: 0x144
function miniturretspawn( watcher, owner )
{
    self endon( #"death" );
    self thread weaponobjects::onspawnuseweaponobject( watcher, owner );
    
    if ( !( isdefined( self.previouslyhacked ) && self.previouslyhacked ) )
    {
        if ( isdefined( owner ) )
        {
            owner addweaponstat( self.weapon, "used", 1 );
        }
        
        self playloopsound( "uin_c4_air_alarm_loop" );
        self waittilltimeout( 10, "stationary" );
        owner onplaceturret( self );
        delaytimesec = self.weapon.proximityalarmactivationdelay / 1000;
        
        if ( delaytimesec > 0 )
        {
            wait delaytimesec;
        }
        
        self stoploopsound( 0.1 );
        self delete();
    }
}

// Namespace mini_turret/mini_turret
// Params 1
// Checksum 0x8ea356b8, Offset: 0x1020
// Size: 0x7a4
function onplaceturret( turret )
{
    player = self;
    assert( isplayer( player ) );
    killstreakid = self killstreakrules::killstreakstart( "mini_turret", player.team, 0, 0 );
    
    if ( killstreakid == -1 )
    {
        return 0;
    }
    
    if ( isdefined( turret.vehicle ) )
    {
        turret.vehicle.origin = turret.origin;
        turret.vehicle.angles = turret.angles;
        turret.vehicle thread util::ghost_wait_show( 0.05 );
        turret.vehicle playsound( "mpl_turret_startup" );
    }
    else
    {
        turret.vehicle = spawnvehicle( "mini_turret", turret.origin, turret.angles, "dynamic_spawn_ai" );
        turret.vehicle.owner = player;
        turret.vehicle setowner( player );
        turret.vehicle.ownerentnum = player.entnum;
        turret.vehicle.parentstruct = turret;
        turret.vehicle.controlled = 0;
        turret.vehicle.treat_owner_damage_as_friendly_fire = 1;
        turret.vehicle.ignore_team_kills = 1;
        turret.vehicle.deal_no_crush_damage = 1;
        turret.vehicle.team = player.team;
        turret.vehicle setteam( player.team );
        turret.vehicle.use_non_teambased_enemy_selection = 1;
        turret.vehicle.waittill_turret_on_target_delay = 0.25;
        turret.vehicle.ignore_vehicle_underneath_splash_scalar = 1;
        turret.vehicle killstreaks::configure_team( "mini_turret", killstreakid, player, "small_vehicle" );
        turret.vehicle killstreak_hacking::enable_hacking( "mini_turret", &hackedcallbackpre, &hackedcallbackpost );
        turret.vehicle thread turret_watch_owner_events();
        turret.vehicle thread turret_laser_watch();
        turret.vehicle thread setup_death_watch_for_new_targets();
        turret.vehicle thread watchturretshutdown( killstreakid, player );
        turret.vehicle createturretinfluencer( "turret" );
        turret.vehicle createturretinfluencer( "turret_close" );
        turret.vehicle thread util::ghost_wait_show( 0.05 );
        
        if ( issentient( turret.vehicle ) == 0 )
        {
            turret.vehicle makesentient();
        }
        
        player killstreaks::play_killstreak_start_dialog( "mini_turret", player.pers[ "team" ], turret.killstreakid );
        level thread popups::displaykillstreakteammessagetoall( "mini_turret", player );
        player addweaponstat( getweapon( "mini_turret" ), "used", 1 );
        turret.vehicle.killstreak_end_time = gettime() + level.killstreakbundle[ "mini_turret" ].ksduration + 5000;
    }
    
    if ( !isdefined( player.mini_turrets ) )
    {
        player.mini_turrets = [];
    }
    
    maxallowed = level.killstreakbundle[ "mini_turret" ].ksmaxallowed;
    
    if ( player.mini_turrets.size == maxallowed )
    {
        player.mini_turrets[ maxallowed - 1 ] onshutdown();
    }
    
    array::push_front( player.mini_turrets, turret.vehicle );
    
    foreach ( player in level.players )
    {
        turret.vehicle respectnottargetedbysentryperk( player );
    }
    
    turret.vehicle.turret_enabled = 1;
    target_set( turret.vehicle, ( 0, 0, 36 ) );
    turret.vehicle unlink();
    turret.vehicle vehicle::disconnect_paths( 0, 0 );
    turret.vehicle thread turretscanning();
}

// Namespace mini_turret/mini_turret
// Params 1
// Checksum 0x5e204ab1, Offset: 0x17d0
// Size: 0x6c
function respectnottargetedbysentryperk( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    turretvehicle = self;
    turretvehicle setignoreent( player, player hasperk( "specialty_nottargetedbysentry" ) );
}

// Namespace mini_turret/mini_turret
// Params 1
// Checksum 0xd71fcfc4, Offset: 0x1848
// Size: 0x12c
function hackedcallbackpre( hacker )
{
    turretvehicle = self;
    turretvehicle clientfield::set( "enemyvehicle", 2 );
    turretvehicle.owner clientfield::set_to_player( "static_postfx", 0 );
    
    if ( turretvehicle.controlled === 1 )
    {
        visionset_mgr::deactivate( "visionset", "turret_visionset", turretvehicle.owner );
    }
    
    turretvehicle.owner remote_weapons::removeandassignnewremotecontroltrigger( turretvehicle.usetrigger );
    turretvehicle remote_weapons::endremotecontrolweaponuse( 1 );
    turretvehicle.owner unlink();
    turretvehicle clientfield::set( "vehicletransition", 0 );
}

// Namespace mini_turret/mini_turret
// Params 1
// Checksum 0x42d0c1d0, Offset: 0x1980
// Size: 0x70
function hackedcallbackpost( hacker )
{
    turretvehicle = self;
    hacker remote_weapons::useremoteweapon( turretvehicle, "mini_turret", 0 );
    turretvehicle notify( #"watchremotecontroldeactivate_remoteweapons" );
    turretvehicle.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now( turretvehicle );
}

// Namespace mini_turret/mini_turret
// Params 1
// Checksum 0x4d4dc657, Offset: 0x19f8
// Size: 0x44
function play_deploy_anim_after_wait( wait_time )
{
    turret = self;
    turret endon( #"death" );
    wait wait_time;
    turret play_deploy_anim();
}

// Namespace mini_turret/mini_turret
// Params 0
// Checksum 0x45465036, Offset: 0x1a48
// Size: 0x9c
function play_deploy_anim()
{
    turret = self;
    turret clientfield::set( "auto_turret_close", 0 );
    turret.othermodel clientfield::set( "auto_turret_close", 0 );
    
    if ( isdefined( turret.vehicle ) )
    {
        turret.vehicle clientfield::set( "auto_turret_open", 1 );
    }
}

// Namespace mini_turret/mini_turret
// Params 1
// Checksum 0x8a2f1ab, Offset: 0x1af0
// Size: 0x1c
function oncancelplacement( turret )
{
    turret notify( #"mini_turret_shutdown" );
}

// Namespace mini_turret/mini_turret
// Params 1
// Checksum 0xd79f509, Offset: 0x1b18
// Size: 0x1dc
function onpickupturret( turret )
{
    player = self;
    turret.vehicle ghost();
    turret.vheicle.turret_enabled = 0;
    turret.vehicle linkto( turret );
    target_remove( turret.vehicle );
    turret clientfield::set( "auto_turret_close", 1 );
    turret.othermodel clientfield::set( "auto_turret_close", 1 );
    
    if ( isdefined( turret.vehicle ) )
    {
        turret.vehicle notify( #"end_turret_scanning" );
        turret.vehicle turretsettargetangles( 0, ( 0, 0, 0 ) );
        turret.vehicle clientfield::set( "auto_turret_open", 0 );
        
        if ( isdefined( turret.vehicle.usetrigger ) )
        {
            turret.vehicle.usetrigger delete();
            turret.vehicle playsound( "mpl_turret_down" );
        }
        
        turret.vehicle vehicle::connect_paths();
    }
}

// Namespace mini_turret/mini_turret
// Params 15
// Checksum 0x4dc9ce0, Offset: 0x1d00
// Size: 0x1e8
function onturretdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    empdamage = int( idamage + self.healthdefault * 1 + 0.5 );
    idamage = self killstreaks::ondamageperweapon( "mini_turret", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1 );
    self.damagetaken += idamage;
    
    if ( self.controlled )
    {
        self.owner vehicle::update_damage_as_occupant( self.damagetaken, self.maxhealth );
    }
    
    if ( self.damagetaken > self.maxhealth && !isdefined( self.will_die ) )
    {
        self.will_die = 1;
        self thread ondeathafterframeend( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime );
    }
    
    return idamage;
}

// Namespace mini_turret/mini_turret
// Params 8
// Checksum 0x6b9a26c4, Offset: 0x1ef0
// Size: 0x7c
function onturretdeath( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    self ondeath( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime );
}

// Namespace mini_turret/mini_turret
// Params 8
// Checksum 0x67e66133, Offset: 0x1f78
// Size: 0x84
function ondeathafterframeend( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    waittillframeend();
    
    if ( isdefined( self ) )
    {
        self ondeath( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime );
    }
}

// Namespace mini_turret/mini_turret
// Params 8
// Checksum 0x80062b4d, Offset: 0x2008
// Size: 0x3fc
function ondeath( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    turretvehicle = self;
    
    if ( turretvehicle.dead === 1 )
    {
        return;
    }
    
    turretvehicle.dead = 1;
    turretvehicle disabledriverfiring( 1 );
    turretvehicle.turret_enabled = 0;
    turretvehicle vehicle::connect_paths();
    eattacker = self [[ level.figure_out_attacker ]]( eattacker );
    
    if ( isdefined( turretvehicle.parentstruct ) )
    {
        turretvehicle.parentstruct placeables::forceshutdown();
        
        if ( turretvehicle.parentstruct.killstreaktimedout === 1 && isdefined( turretvehicle.owner ) )
        {
            turretvehicle.owner globallogic_audio::play_taacom_dialog( "timeout", turretvehicle.parentstruct.killstreaktype );
        }
        else if ( isdefined( eattacker ) && isdefined( turretvehicle.owner ) && eattacker != turretvehicle.owner )
        {
            turretvehicle.parentstruct killstreaks::play_destroyed_dialog_on_owner( turretvehicle.parentstruct.killstreaktype, turretvehicle.parentstruct.killstreakid );
        }
    }
    
    if ( !isdefined( self.owner ) || isdefined( eattacker ) && isplayer( eattacker ) && self.owner util::isenemyplayer( eattacker ) )
    {
        scoreevents::processscoreevent( "destroyed_mini_turret", eattacker, self, weapon );
        eattacker challenges::destroyscorestreak( weapon, turretvehicle.controlled, 1, 0 );
        eattacker challenges::destroynonairscorestreak_poststatslock( weapon );
        eattacker addplayerstat( "destroy_turret", 1 );
        eattacker addweaponstat( weapon, "destroy_turret", 1 );
    }
    
    turretvehicle playsound( "mpl_m_turret_exp" );
    wait 0.1;
    turretvehicle ghost();
    turretvehicle notsolid();
    turretvehicle waittilltimeout( 2, "remote_weapon_end" );
    
    if ( isdefined( turretvehicle ) )
    {
        while ( turretvehicle.controlled || isdefined( turretvehicle ) && !isdefined( turretvehicle.owner ) )
        {
            waitframe( 1 );
        }
        
        turretvehicle.dontfreeme = undefined;
        wait 0.5;
        
        if ( isdefined( turretvehicle ) )
        {
            turretvehicle delete();
        }
    }
}

// Namespace mini_turret/mini_turret
// Params 0
// Checksum 0x9229a492, Offset: 0x2410
// Size: 0x12
function onshutdown()
{
    self notify( #"mini_turret_shutdown" );
}

// Namespace mini_turret/mini_turret
// Params 1
// Checksum 0x9606f4a7, Offset: 0x2430
// Size: 0x78
function enableturretafterwait( wait_time )
{
    self endon( #"death" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner endon( #"joined_team" );
        self.owner endon( #"disconnect" );
        self.owner endon( #"joined_spectators" );
    }
    
    wait wait_time;
    self.turret_enabled = 1;
}

// Namespace mini_turret/mini_turret
// Params 1
// Checksum 0xe6e30f12, Offset: 0x24b0
// Size: 0xca
function createturretinfluencer( name )
{
    turret = self;
    preset = getinfluencerpreset( name );
    
    if ( !isdefined( preset ) )
    {
        return;
    }
    
    projected_point = turret.origin + vectorscale( anglestoforward( turret.angles ), preset[ "radius" ] * 0.7 );
    return influencers::create_enemy_influencer( name, turret.origin, turret.team );
}

// Namespace mini_turret/mini_turret
// Params 0
// Checksum 0x9125caec, Offset: 0x2588
// Size: 0x124
function turret_watch_owner_events()
{
    self notify( #"turret_watch_owner_events_singleton" );
    self endon( #"tturet_watch_owner_events_singleton" );
    self endon( #"death" );
    self.owner waittill( "joined_team", "disconnect", "joined_spectators" );
    self makevehicleusable();
    self.controlled = 0;
    
    if ( isdefined( self.owner ) )
    {
        self.owner unlink();
        self clientfield::set( "vehicletransition", 0 );
    }
    
    self makevehicleunusable();
    
    if ( isdefined( self.owner ) )
    {
        self.owner killstreaks::clear_using_remote();
    }
    
    self.abandoned = 1;
    self onshutdown();
}

// Namespace mini_turret/mini_turret
// Params 0
// Checksum 0x5ce2ed0b, Offset: 0x26b8
// Size: 0xe0
function turret_laser_watch()
{
    veh = self;
    veh endon( #"death" );
    
    while ( true )
    {
        laser_should_be_on = !veh.controlled && isdefined( veh.enemy );
        
        if ( laser_should_be_on )
        {
            if ( islaseron( veh ) == 0 )
            {
                veh vehicle::enable_laser( 1, 0 );
            }
        }
        else if ( islaseron( veh ) )
        {
            veh vehicle::enable_laser( 0, 0 );
        }
        
        wait 0.25;
    }
}

// Namespace mini_turret/mini_turret
// Params 0
// Checksum 0xd459a2ed, Offset: 0x27a0
// Size: 0xac
function setup_death_watch_for_new_targets()
{
    turretvehicle = self;
    turretvehicle endon( #"death" );
    
    for ( old_target = undefined; true ; old_target = waitresult.target )
    {
        waitresult = turretvehicle waittill( "has_new_target" );
        
        if ( isdefined( old_target ) )
        {
            old_target notify( #"abort_death_watch" );
        }
        
        waitresult.target thread target_death_watch( turretvehicle );
    }
}

// Namespace mini_turret/mini_turret
// Params 1
// Checksum 0xc7d34a85, Offset: 0x2858
// Size: 0x7c
function target_death_watch( turretvehicle )
{
    target = self;
    target endon( #"abort_death_watch" );
    turretvehicle endon( #"death" );
    target waittill( "death", "disconnect", "joined_team", "joined_spectators" );
    turretvehicle clearenemy();
}

// Namespace mini_turret/mini_turret
// Params 0
// Checksum 0xdb93a164, Offset: 0x28e0
// Size: 0x18
function get_killstreak_bundle()
{
    return level.killstreakbundle[ "mini_turret" ];
}

// Namespace mini_turret/mini_turret
// Params 0
// Checksum 0xfc865404, Offset: 0x2900
// Size: 0x554
function turretscanning()
{
    veh = self;
    turret_index = 0;
    veh endon( #"death" );
    veh endon( #"end_turret_scanning" );
    veh.turret_target = undefined;
    wait 0.8;
    self playsound( "mpl_turret_startup" );
    bundle = get_killstreak_bundle();
    min_burst_time = bundle.ksburstfiremintime;
    max_burst_time = bundle.ksburstfiremaxtime;
    min_pause_time = bundle.ksburstfiredelaymintime;
    max_pause_time = bundle.ksburstfiredelaymaxtime;
    burst_fire_enabled = bundle.ksburstfireenabled;
    
    while ( true )
    {
        /#
            bundle = get_killstreak_bundle();
            min_burst_time = bundle.ksburstfiremintime;
            max_burst_time = bundle.ksburstfiremaxtime;
            min_pause_time = bundle.ksburstfiredelaymintime;
            max_pause_time = bundle.ksburstfiredelaymaxtime;
            burst_fire_enabled = bundle.ksburstfireenabled;
        #/
        
        if ( veh.controlled || !veh.turret_enabled )
        {
            wait 0.5;
            continue;
        }
        
        if ( veh has_active_enemy() && isdefined( veh.enemy ) && isalive( veh.enemy ) )
        {
            if ( !isdefined( veh.turret_target ) || veh.turret_target != veh.enemy )
            {
                veh vehicle_ai::setturrettarget( veh.enemy, turret_index );
                veh.turret_target = veh.enemy;
                self playsound( "mpl_turret_alert" );
            }
            
            if ( veh.turretontarget )
            {
                if ( burst_fire_enabled )
                {
                    fire_time = min_burst_time < max_burst_time ? randomfloatrange( min_burst_time, max_burst_time ) : min_burst_time;
                    veh vehicle_ai::fire_for_time( fire_time, turret_index, veh.enemy );
                    
                    if ( min_pause_time > 0 )
                    {
                        pause_time = min_pause_time < max_pause_time ? randomfloatrange( min_pause_time, max_pause_time ) : min_pause_time;
                        wait pause_time;
                    }
                }
                else
                {
                    veh vehicle_ai::fire_for_rounds( 10, turret_index, veh.enemy );
                }
            }
            else
            {
                wait 0.25;
            }
            
            continue;
        }
        
        veh clearenemy();
        veh.turret_target = undefined;
        
        if ( veh.scanpos === "left" )
        {
            veh turretsettargetangles( turret_index, ( -15, 180, 0 ) );
            veh.scanpos = "left2";
        }
        else if ( veh.scanpos === "left2" )
        {
            veh turretsettargetangles( turret_index, ( -15, 360, 0 ) );
            veh.scanpos = "right";
        }
        else if ( veh.scanpos === "right" )
        {
            veh turretsettargetangles( turret_index, ( -15, 180 * -1, 0 ) );
            veh.scanpos = "right2";
        }
        else
        {
            veh turretsettargetangles( turret_index, ( -15, 360 * -1, 0 ) );
            veh.scanpos = "left";
        }
        
        veh waittilltimeout( 3.5, "enemy" );
    }
}

// Namespace mini_turret/mini_turret
// Params 2
// Checksum 0xff63b28d, Offset: 0x2e60
// Size: 0xe4
function watchturretshutdown( killstreakid, player )
{
    turret = self;
    turret waittilltimeout( level.killstreakbundle[ "mini_turret" ].ksduration, "mini_turret_shutdown" );
    killstreakrules::killstreakstop( "mini_turret", player.team, killstreakid );
    array::pop( player.mini_turrets, player.mini_turrets.size - 1, 0 );
    turret kill();
    turret influencers::remove_influencers();
}

// Namespace mini_turret/mini_turret
// Params 0
// Checksum 0xa6cc69b4, Offset: 0x2f50
// Size: 0x2a, Type: bool
function has_active_enemy()
{
    if ( !isdefined( self.enemylastseentime ) )
    {
        return false;
    }
    
    return gettime() < self.enemylastseentime + 1000;
}

