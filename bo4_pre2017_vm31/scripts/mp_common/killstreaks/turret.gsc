#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/influencers_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/popups_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/turret_shared;
#using scripts/core_common/util_shared;
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

#namespace turret;

#using_animtree( "mp_autoturret" );

// Namespace turret/turret
// Params 0
// Checksum 0x215fcd4f, Offset: 0x980
// Size: 0x2b4
function init()
{
    killstreaks::register( "autoturret", "autoturret", "killstreak_auto_turret", "auto_turret_used", &activateturret );
    killstreaks::register_alt_weapon( "autoturret", "auto_gun_turret" );
    killstreaks::register_remote_override_weapon( "autoturret", "killstreak_remote_turret" );
    killstreaks::register_strings( "autoturret", &"KILLSTREAK_EARNED_AUTO_TURRET", &"KILLSTREAK_AUTO_TURRET_NOT_AVAILABLE", &"KILLSTREAK_AUTO_TURRET_INBOUND", undefined, &"KILLSTREAK_AUTO_TURRET_HACKED", 0 );
    killstreaks::register_dialog( "autoturret", "mpl_killstreak_auto_turret", "turretDialogBundle", undefined, "friendlyTurret", "enemyTurret", "enemyTurretMultiple", "friendlyTurretHacked", "enemyTurretHacked", "requestTurret", "threatTurret" );
    level.killstreaks[ "autoturret" ].threatonkill = 1;
    clientfield::register( "vehicle", "auto_turret_open", 1, 1, "int" );
    clientfield::register( "scriptmover", "auto_turret_init", 1, 1, "int" );
    clientfield::register( "scriptmover", "auto_turret_close", 1, 1, "int" );
    level.autoturretopenanim = %o_turret_sentry_deploy;
    level.autoturretcloseanim = %o_turret_sentry_close;
    remote_weapons::registerremoteweapon( "autoturret", &"MP_REMOTE_USE_TURRET", &startturretremotecontrol, &endturretremotecontrol, 1 );
    vehicle::add_main_callback( "sentry_turret", &initturret );
    visionset_mgr::register_info( "visionset", "turret_visionset", 1, 81, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0 );
}

// Namespace turret/turret
// Params 0
// Checksum 0xb8549f4c, Offset: 0xc40
// Size: 0x188
function initturret()
{
    turretvehicle = self;
    turretvehicle.dontfreeme = 1;
    turretvehicle.damage_on_death = 0;
    turretvehicle.delete_on_death = undefined;
    turretvehicle.watch_remote_weapon_death = 1;
    turretvehicle.watch_remote_weapon_death_duration = 1.2;
    turretvehicle.maxhealth = 2000;
    turretvehicle.damagetaken = 0;
    tablehealth = killstreak_bundles::get_max_health( "autoturret" );
    
    if ( isdefined( tablehealth ) )
    {
        turretvehicle.maxhealth = tablehealth;
    }
    
    turretvehicle.health = turretvehicle.maxhealth;
    turretvehicle.maxsightdistsqrd = 2500 * 2500;
    turretvehicle set_on_target_angle( 15, 0 );
    turretvehicle clientfield::set( "enemyvehicle", 1 );
    turretvehicle.soundmod = "drone_land";
    turretvehicle.overridevehicledamage = &onturretdamage;
    turretvehicle.overridevehiclekilled = &onturretdeath;
}

// Namespace turret/turret
// Params 0
// Checksum 0x66820ff, Offset: 0xdd0
// Size: 0x280, Type: bool
function activateturret()
{
    player = self;
    assert( isplayer( player ) );
    killstreakid = self killstreakrules::killstreakstart( "autoturret", player.team, 0, 0 );
    
    if ( killstreakid == -1 )
    {
        return false;
    }
    
    bundle = level.killstreakbundle[ "autoturret" ];
    turret = player placeables::spawnplaceable( "autoturret", killstreakid, &onplaceturret, &oncancelplacement, &onpickupturret, &onshutdown, undefined, undefined, "veh_t7_turret_sentry_gun_world_mp", "veh_t7_turret_sentry_gun_world_yellow", "veh_t7_turret_sentry_gun_world_red", 1, &"KILLSTREAK_SENTRY_TURRET_PICKUP", 90000, undefined, 0, bundle.ksplaceablehint, bundle.ksplaceableinvalidlocationhint );
    turret thread watchturretshutdown( killstreakid, player.team );
    turret thread util::ghost_wait_show_to_player( player );
    turret.othermodel thread util::ghost_wait_show_to_others( player );
    turret clientfield::set( "auto_turret_init", 1 );
    turret.othermodel clientfield::set( "auto_turret_init", 1 );
    event = turret waittill( "placed", "cancelled", "death" );
    
    if ( event._notify != "placed" )
    {
        return false;
    }
    
    turret playsound( "mpl_turret_startup" );
    return true;
}

// Namespace turret/turret
// Params 1
// Checksum 0xbdf3453c, Offset: 0x1058
// Size: 0x714
function onplaceturret( turret )
{
    player = self;
    assert( isplayer( player ) );
    
    if ( isdefined( turret.vehicle ) )
    {
        turret.vehicle.origin = turret.origin;
        turret.vehicle.angles = turret.angles;
        turret.vehicle thread util::ghost_wait_show( 0.05 );
        turret.vehicle playsound( "mpl_turret_startup" );
    }
    else
    {
        turret.vehicle = spawnvehicle( "sentry_turret", turret.origin, turret.angles, "dynamic_spawn_ai" );
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
        turret.vehicle set_team( player.team, 0 );
        turret.vehicle set_torso_targetting( 0 );
        turret.vehicle set_target_leading( 0 );
        turret.vehicle.use_non_teambased_enemy_selection = 1;
        turret.vehicle.waittill_turret_on_target_delay = 0.25;
        turret.vehicle.ignore_vehicle_underneath_splash_scalar = 1;
        turret.vehicle killstreaks::configure_team( "autoturret", turret.killstreakid, player, "small_vehicle" );
        turret.vehicle killstreak_hacking::enable_hacking( "autoturret", &hackedcallbackpre, &hackedcallbackpost );
        turret.vehicle thread turret_watch_owner_events();
        turret.vehicle thread turret_laser_watch();
        turret.vehicle thread setup_death_watch_for_new_targets();
        turret.vehicle createturretinfluencer( "turret" );
        turret.vehicle createturretinfluencer( "turret_close" );
        turret.vehicle thread util::ghost_wait_show( 0.05 );
        
        if ( issentient( turret.vehicle ) == 0 )
        {
            turret.vehicle makesentient();
        }
        
        player killstreaks::play_killstreak_start_dialog( "autoturret", player.pers[ "team" ], turret.killstreakid );
        level thread popups::displaykillstreakteammessagetoall( "autoturret", player );
        player addweaponstat( getweapon( "autoturret" ), "used", 1 );
        turret.vehicle.killstreak_end_time = gettime() + 90000 + 5000;
    }
    
    foreach ( player in level.players )
    {
        turret.vehicle respectnottargetedbysentryperk( player );
    }
    
    turret.vehicle enable( 0, 0 );
    target_set( turret.vehicle, ( 0, 0, 36 ) );
    turret.vehicle unlink();
    turret.vehicle vehicle::disconnect_paths( 0, 0 );
    turret.vehicle thread turretscanning();
    turret play_deploy_anim();
    player remote_weapons::useremoteweapon( turret.vehicle, "autoturret", 0 );
}

// Namespace turret/turret
// Params 1
// Checksum 0xdfdb02f4, Offset: 0x1778
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

// Namespace turret/turret
// Params 1
// Checksum 0xbffd051c, Offset: 0x17f0
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

// Namespace turret/turret
// Params 1
// Checksum 0x2d868fd7, Offset: 0x1928
// Size: 0x70
function hackedcallbackpost( hacker )
{
    turretvehicle = self;
    hacker remote_weapons::useremoteweapon( turretvehicle, "autoturret", 0 );
    turretvehicle notify( #"watchremotecontroldeactivate_remoteweapons" );
    turretvehicle.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now( turretvehicle );
}

// Namespace turret/turret
// Params 1
// Checksum 0x60a01f39, Offset: 0x19a0
// Size: 0x44
function play_deploy_anim_after_wait( wait_time )
{
    turret = self;
    turret endon( #"death" );
    wait wait_time;
    turret play_deploy_anim();
}

// Namespace turret/turret
// Params 0
// Checksum 0x1d4f9013, Offset: 0x19f0
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

// Namespace turret/turret
// Params 1
// Checksum 0xd433e1be, Offset: 0x1a98
// Size: 0x1c
function oncancelplacement( turret )
{
    turret notify( #"sentry_turret_shutdown" );
}

// Namespace turret/turret
// Params 1
// Checksum 0x4ee40f9d, Offset: 0x1ac0
// Size: 0x1e4
function onpickupturret( turret )
{
    player = self;
    turret.vehicle ghost();
    turret.vehicle disable( 0 );
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

// Namespace turret/turret
// Params 15
// Checksum 0x88599958, Offset: 0x1cb0
// Size: 0x1e8
function onturretdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    empdamage = int( idamage + self.healthdefault * 1 + 0.5 );
    idamage = self killstreaks::ondamageperweapon( "autoturret", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1 );
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

// Namespace turret/turret
// Params 8
// Checksum 0xe933252f, Offset: 0x1ea0
// Size: 0x7c
function onturretdeath( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    self ondeath( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime );
}

// Namespace turret/turret
// Params 8
// Checksum 0x564f0d85, Offset: 0x1f28
// Size: 0x84
function ondeathafterframeend( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    waittillframeend();
    
    if ( isdefined( self ) )
    {
        self ondeath( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime );
    }
}

// Namespace turret/turret
// Params 8
// Checksum 0x8cf6643, Offset: 0x1fb8
// Size: 0x44c
function ondeath( einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    turretvehicle = self;
    
    if ( turretvehicle.dead === 1 )
    {
        return;
    }
    
    turretvehicle.dead = 1;
    turretvehicle disabledriverfiring( 1 );
    turretvehicle disable( 0 );
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
        scoreevents::processscoreevent( "destroyed_sentry_gun", eattacker, self, weapon );
        eattacker challenges::destroyscorestreak( weapon, turretvehicle.controlled, 1, 0 );
        eattacker challenges::destroynonairscorestreak_poststatslock( weapon );
        eattacker addplayerstat( "destroy_turret", 1 );
        eattacker addweaponstat( weapon, "destroy_turret", 1 );
        luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_AUTO_TURRET", eattacker.entnum );
    }
    
    turretvehicle vehicle_death::death_fx();
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

// Namespace turret/turret
// Params 1
// Checksum 0x706b0f30, Offset: 0x2410
// Size: 0x1c
function onshutdown( turret )
{
    turret notify( #"sentry_turret_shutdown" );
}

// Namespace turret/turret
// Params 1
// Checksum 0x2bf9ff9c, Offset: 0x2438
// Size: 0x1a4
function startturretremotecontrol( turretvehicle )
{
    player = self;
    assert( isplayer( player ) );
    turretvehicle disable( 0 );
    turretvehicle usevehicle( player, 0 );
    turretvehicle clientfield::set( "vehicletransition", 1 );
    turretvehicle.controlled = 1;
    turretvehicle.treat_owner_damage_as_friendly_fire = 0;
    turretvehicle.ignore_team_kills = 0;
    player vehicle::set_vehicle_drivable_time( 90000 + 5000, turretvehicle.killstreak_end_time );
    player vehicle::update_damage_as_occupant( isdefined( turretvehicle.damagetaken ) ? turretvehicle.damagetaken : 0, isdefined( turretvehicle.maxhealth ) ? turretvehicle.maxhealth : 100 );
    visionset_mgr::activate( "visionset", "turret_visionset", self, 1, 90000, 1 );
}

// Namespace turret/turret
// Params 2
// Checksum 0xfe9af491, Offset: 0x25e8
// Size: 0xec
function endturretremotecontrol( turretvehicle, exitrequestedbyowner )
{
    if ( exitrequestedbyowner )
    {
        turretvehicle thread enableturretafterwait( 0.1 );
    }
    
    turretvehicle clientfield::set( "vehicletransition", 0 );
    
    if ( isdefined( turretvehicle.owner ) && turretvehicle.controlled === 1 )
    {
        visionset_mgr::deactivate( "visionset", "turret_visionset", turretvehicle.owner );
    }
    
    turretvehicle.controlled = 0;
    turretvehicle.treat_owner_damage_as_friendly_fire = 1;
    turretvehicle.ignore_team_kills = 1;
}

// Namespace turret/turret
// Params 1
// Checksum 0xa2510190, Offset: 0x26e0
// Size: 0x84
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
    self enable( 0, 0 );
}

// Namespace turret/turret
// Params 1
// Checksum 0x521c3495, Offset: 0x2770
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

// Namespace turret/turret
// Params 0
// Checksum 0xc6dec361, Offset: 0x2848
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
    onshutdown( self );
}

// Namespace turret/turret
// Params 0
// Checksum 0x3b438c5e, Offset: 0x2978
// Size: 0xe0
function turret_laser_watch()
{
    turretvehicle = self;
    turretvehicle endon( #"death" );
    
    while ( true )
    {
        laser_should_be_on = !turretvehicle.controlled && turretvehicle does_have_target( 0 );
        
        if ( laser_should_be_on )
        {
            if ( islaseron( turretvehicle ) == 0 )
            {
                turretvehicle enable_laser( 1, 0 );
            }
        }
        else if ( islaseron( turretvehicle ) )
        {
            turretvehicle enable_laser( 0, 0 );
        }
        
        wait 0.25;
    }
}

// Namespace turret/turret
// Params 0
// Checksum 0x6f5febb4, Offset: 0x2a60
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

// Namespace turret/turret
// Params 1
// Checksum 0xd9cec472, Offset: 0x2b18
// Size: 0x84
function target_death_watch( turretvehicle )
{
    target = self;
    target endon( #"abort_death_watch" );
    turretvehicle endon( #"death" );
    target waittill( "death", "disconnect", "joined_team", "joined_spectators" );
    turretvehicle stop( 0, 1 );
}

// Namespace turret/turret
// Params 0
// Checksum 0xa958d864, Offset: 0x2ba8
// Size: 0x1c4
function turretscanning()
{
    turretvehicle = self;
    turretvehicle endon( #"death" );
    turretvehicle endon( #"end_turret_scanning" );
    turret_data = turretvehicle _get_turret_data( 0 );
    turretvehicle.do_not_clear_targets_during_think = 1;
    wait 0.8;
    
    while ( true )
    {
        if ( turretvehicle.controlled )
        {
            wait 0.5;
            continue;
        }
        
        if ( turretvehicle does_have_target( 0 ) )
        {
            wait 0.25;
            continue;
        }
        
        /#
            turret_data = turretvehicle _get_turret_data( 0 );
        #/
        
        turretvehicle clear_target( 0 );
        
        if ( turretvehicle.scanpos === "left" )
        {
            turretvehicle turretsettargetangles( 0, ( 0, turret_data.leftarc - 10, 0 ) );
            turretvehicle.scanpos = "right";
        }
        else
        {
            turretvehicle turretsettargetangles( 0, ( 0, ( turret_data.rightarc - 10 ) * -1, 0 ) );
            turretvehicle.scanpos = "left";
        }
        
        wait 2.5;
    }
}

// Namespace turret/turret
// Params 2
// Checksum 0x8ee12f3e, Offset: 0x2d78
// Size: 0x84
function watchturretshutdown( killstreakid, team )
{
    turret = self;
    turret waittill( "sentry_turret_shutdown" );
    killstreakrules::killstreakstop( "autoturret", team, killstreakid );
    
    if ( isdefined( turret.vehicle ) )
    {
        turret.vehicle influencers::remove_influencers();
    }
}

