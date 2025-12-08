#using scripts/core_common/array_shared;
#using scripts/core_common/audio_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/math_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/statemachine_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/turret_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_ai_shared;
#using scripts/core_common/vehicle_death_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/vehicles/wasp;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/heatseekingmissile;
#using scripts/mp_common/gametypes/shellshock;
#using scripts/mp_common/killstreaks/airsupport;
#using scripts/mp_common/killstreaks/helicopter;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_detect;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/qrdrone;
#using scripts/mp_common/killstreaks/rcbomb;
#using scripts/mp_common/killstreaks/remote_weapons;
#using scripts/mp_common/teams/teams;
#using scripts/mp_common/util;

#namespace sentinel;

// Namespace sentinel/sentinel
// Params 0
// Checksum 0x19902ec2, Offset: 0x9c0
// Size: 0x20c
function init()
{
    killstreaks::register( "sentinel", "sentinel", "killstreak_" + "sentinel", "sentinel" + "_used", &activatesentinel, 1 );
    killstreaks::register_strings( "sentinel", &"KILLSTREAK_SENTINEL_EARNED", &"KILLSTREAK_SENTINEL_NOT_AVAILABLE", &"KILLSTREAK_SENTINEL_INBOUND", undefined, &"KILLSTREAK_SENTINEL_HACKED" );
    killstreaks::register_dialog( "sentinel", "mpl_killstreak_sentinel_strt", "sentinelDialogBundle", "sentinelPilotDialogBundle", "friendlySentinel", "enemySentinel", "enemySentinelMultiple", "friendlySentinelHacked", "enemySentinelHacked", "requestSentinel", "threatSentinel" );
    killstreaks::register_alt_weapon( "sentinel", "killstreak_remote" );
    killstreaks::register_alt_weapon( "sentinel", "sentinel_turret" );
    remote_weapons::registerremoteweapon( "sentinel", &"KILLSTREAK_SENTINEL_USE_REMOTE", &startsentinelremotecontrol, &endsentinelremotecontrol, 0 );
    level.killstreaks[ "sentinel" ].threatonkill = 1;
    vehicle::add_main_callback( "veh_sentinel_mp", &initsentinel );
    visionset_mgr::register_info( "visionset", "sentinel_visionset", 1, 100, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0 );
}

// Namespace sentinel/sentinel
// Params 0
// Checksum 0xc62ea50f, Offset: 0xbd8
// Size: 0x41c
function initsentinel()
{
    self.settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    target_set( self, ( 0, 0, 0 ) );
    self.health = self.healthdefault;
    self.numflares = 1;
    self.damagetaken = 0;
    self vehicle::friendly_fire_shield();
    self enableaimassist();
    self setneargoalnotifydist( 40 );
    self sethoverparams( 50, 100, 100 );
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.vehaircraftcollisionenabled = 1;
    self thread vehicle_ai::nudge_collision();
    self thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile( "explode", "death" );
    self thread helicopter::create_flare_ent( ( 0, 0, -20 ) );
    self thread audio::vehiclespawncontext();
    self.do_scripted_crash = 0;
    self.overridevehicledamage = &sentineldamageoverride;
    self.selfdestruct = 0;
    self.enable_target_laser = 1;
    self.aggresive_navvolume_recover = 1;
    self vehicle_ai::init_state_machine_for_role( "default" );
    self vehicle_ai::get_state_callbacks( "combat" ).enter_func = &wasp::state_combat_enter;
    self vehicle_ai::get_state_callbacks( "combat" ).update_func = &wasp::state_combat_update;
    self vehicle_ai::get_state_callbacks( "death" ).update_func = &wasp::state_death_update;
    self vehicle_ai::get_state_callbacks( "driving" ).enter_func = &driving_enter;
    wasp::init_guard_points();
    self vehicle_ai::add_state( "guard", &wasp::state_guard_enter, &wasp::state_guard_update, &wasp::state_guard_exit );
    vehicle_ai::add_utility_connection( "combat", "guard", &wasp::state_guard_can_enter );
    vehicle_ai::add_utility_connection( "guard", "combat" );
    vehicle_ai::add_interrupt_connection( "guard", "emped", "emped" );
    vehicle_ai::add_interrupt_connection( "guard", "off", "shut_off" );
    vehicle_ai::add_interrupt_connection( "guard", "pain", "pain" );
    vehicle_ai::add_interrupt_connection( "guard", "driving", "enter_vehicle" );
    self vehicle_ai::startinitialstate( "combat" );
}

// Namespace sentinel/sentinel
// Params 1
// Checksum 0x2ace4da4, Offset: 0x1000
// Size: 0x24
function driving_enter( params )
{
    vehicle_ai::defaultstate_driving_enter( params );
}

// Namespace sentinel/sentinel
// Params 4
// Checksum 0x6f1ad0d2, Offset: 0x1030
// Size: 0x240
function drone_pain_for_time( time, stablizeparam, restorelookpoint, weapon )
{
    self endon( #"death" );
    self.painstarttime = gettime();
    
    if ( !( isdefined( self.inpain ) && self.inpain ) && isdefined( self.health ) && self.health > 0 )
    {
        self.inpain = 1;
        
        while ( gettime() < self.painstarttime + time * 1000 )
        {
            self setvehvelocity( self.velocity * stablizeparam );
            self setangularvelocity( self getangularvelocity() * stablizeparam );
            wait 0.1;
        }
        
        if ( isdefined( restorelookpoint ) && isdefined( self.health ) && self.health > 0 )
        {
            restorelookent = spawn( "script_model", restorelookpoint );
            restorelookent setmodel( "tag_origin" );
            self vehclearlookat();
            self vehlookat( restorelookent );
            self turretsettarget( 0, restorelookent );
            wait 1.5;
            self vehclearlookat();
            self turretcleartarget( 0 );
            restorelookent delete();
        }
        
        if ( weapon.isemp )
        {
            remote_weapons::set_static( 0 );
        }
        
        self.inpain = 0;
    }
}

// Namespace sentinel/sentinel
// Params 7
// Checksum 0x66a5762c, Offset: 0x1278
// Size: 0x134
function drone_pain( eattacker, damagetype, hitpoint, hitdirection, hitlocationinfo, partname, weapon )
{
    if ( !( isdefined( self.inpain ) && self.inpain ) )
    {
        yaw_vel = math::randomsign() * randomfloatrange( 280, 320 );
        ang_vel = self getangularvelocity();
        ang_vel += ( randomfloatrange( -120, -100 ), yaw_vel, randomfloatrange( -200, 200 ) );
        self setangularvelocity( ang_vel );
        self thread drone_pain_for_time( 0.8, 0.7, undefined, weapon );
    }
}

// Namespace sentinel/sentinel
// Params 15
// Checksum 0xa1f5d700, Offset: 0x13b8
// Size: 0x1b4
function sentineldamageoverride( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    if ( smeansofdeath == "MOD_TRIGGER_HURT" )
    {
        return 0;
    }
    
    emp_damage = self.healthdefault * 0.5 + 0.5;
    idamage = killstreaks::ondamageperweapon( "sentinel", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, &destroyed_cb, self.maxhealth * 0.4, &low_health_cb, emp_damage, undefined, 1, 1 );
    
    if ( isdefined( eattacker ) && isdefined( eattacker.team ) && eattacker.team != self.team )
    {
        drone_pain( eattacker, smeansofdeath, vpoint, vdir, shitloc, partname, weapon );
    }
    
    self.damagetaken += idamage;
    return idamage;
}

// Namespace sentinel/sentinel
// Params 2
// Checksum 0xad6849b4, Offset: 0x1578
// Size: 0x64
function destroyed_cb( attacker, weapon )
{
    if ( isdefined( attacker ) && isdefined( attacker.team ) && attacker.team != self.team )
    {
        self.owner.dofutz = 1;
    }
}

// Namespace sentinel/sentinel
// Params 2
// Checksum 0x795ea261, Offset: 0x15e8
// Size: 0x64
function low_health_cb( attacker, weapon )
{
    if ( self.playeddamaged == 0 )
    {
        self killstreaks::play_pilot_dialog_on_owner( "damaged", "sentinel", self.killstreak_id );
        self.playeddamaged = 1;
    }
}

// Namespace sentinel/sentinel
// Params 2
// Checksum 0x3268acef, Offset: 0x1658
// Size: 0x3a6
function calcspawnorigin( origin, angles )
{
    heightoffset = rcbomb::getplacementstartheight();
    mins = ( -5, -5, 0 );
    maxs = ( 5, 5, 10 );
    startpoints = [];
    testangles = [];
    testangles[ 0 ] = ( 0, 0, 0 );
    testangles[ 1 ] = ( 0, 30, 0 );
    testangles[ 2 ] = ( 0, -30, 0 );
    testangles[ 3 ] = ( 0, 60, 0 );
    testangles[ 4 ] = ( 0, -60, 0 );
    testangles[ 3 ] = ( 0, 90, 0 );
    testangles[ 4 ] = ( 0, -90, 0 );
    bestorigin = origin;
    bestangles = angles;
    bestfrac = 0;
    
    for ( i = 0; i < testangles.size ; i++ )
    {
        startpoint = origin + ( 0, 0, heightoffset );
        endpoint = startpoint + vectorscale( anglestoforward( ( 0, angles[ 1 ], 0 ) + testangles[ i ] ), 70 );
        mask = 1 | 2;
        trace = physicstrace( startpoint, endpoint, mins, maxs, self, mask );
        
        if ( isdefined( trace[ "entity" ] ) && isplayer( trace[ "entity" ] ) )
        {
            continue;
        }
        
        if ( trace[ "fraction" ] > bestfrac )
        {
            bestfrac = trace[ "fraction" ];
            bestorigin = trace[ "position" ];
            bestangles = ( 0, angles[ 1 ], 0 ) + testangles[ i ];
            
            if ( bestfrac == 1 )
            {
                break;
            }
        }
    }
    
    if ( bestfrac > 0 )
    {
        if ( distance2dsquared( origin, bestorigin ) < 400 )
        {
            return undefined;
        }
        
        trace = physicstrace( bestorigin, bestorigin + ( 0, 0, 25 ), mins, maxs, self, mask );
        placement = spawnstruct();
        placement.origin = trace[ "position" ];
        placement.angles = bestangles;
        return placement;
    }
    
    return undefined;
}

// Namespace sentinel/sentinel
// Params 1
// Checksum 0xd4f6fcc0, Offset: 0x1a08
// Size: 0x5f8, Type: bool
function activatesentinel( killstreaktype )
{
    assert( isplayer( self ) );
    player = self;
    
    if ( !isnavvolumeloaded() )
    {
        /#
            iprintlnbold( "Error: NavVolume Not Loaded" );
        #/
        
        self iprintlnbold( &"KILLSTREAK_SENTINEL_NOT_AVAILABLE" );
        return false;
    }
    
    if ( player isplayerswimming() )
    {
        self iprintlnbold( &"KILLSTREAK_SENTINEL_NOT_PLACEABLE" );
        return false;
    }
    
    spawnpos = calcspawnorigin( player.origin, player.angles );
    
    if ( !isdefined( spawnpos ) )
    {
        self iprintlnbold( &"KILLSTREAK_SENTINEL_NOT_PLACEABLE" );
        return false;
    }
    
    killstreak_id = player killstreakrules::killstreakstart( "sentinel", player.team, 0, 1 );
    
    if ( killstreak_id == -1 )
    {
        return false;
    }
    
    player addweaponstat( getweapon( "sentinel" ), "used", 1 );
    sentinel = spawnvehicle( "veh_sentinel_mp", spawnpos.origin, spawnpos.angles, "dynamic_spawn_ai" );
    sentinel killstreaks::configure_team( "sentinel", killstreak_id, player, "small_vehicle", undefined, &configureteampost );
    sentinel killstreak_hacking::enable_hacking( "sentinel", &hackedcallbackpre, &hackedcallbackpost );
    sentinel.killstreak_id = killstreak_id;
    sentinel.killstreak_end_time = gettime() + 45000;
    sentinel.original_vehicle_type = sentinel.vehicletype;
    sentinel.ignore_vehicle_underneath_splash_scalar = 1;
    sentinel clientfield::set( "enemyvehicle", 1 );
    sentinel.hardpointtype = "sentinel";
    sentinel.soundmod = "player";
    sentinel.maxhealth = killstreak_bundles::get_max_health( "sentinel" );
    sentinel.lowhealth = killstreak_bundles::get_low_health( "sentinel" );
    sentinel.health = sentinel.maxhealth;
    sentinel.hackedhealth = killstreak_bundles::get_hacked_health( "sentinel" );
    sentinel.rocketdamage = sentinel.maxhealth / 1 + 1;
    sentinel.playeddamaged = 0;
    sentinel.treat_owner_damage_as_friendly_fire = 1;
    sentinel.ignore_team_kills = 1;
    sentinel thread healthmonitor();
    sentinel.goalradius = 1200;
    sentinel.goalheight = 500;
    sentinel.enable_guard = 1;
    sentinel.always_face_enemy = 1;
    sentinel thread killstreaks::waitfortimeout( "sentinel", 45000, &ontimeout, "sentinel_shutdown" );
    sentinel thread watchwater();
    sentinel thread watchdeath();
    sentinel thread watchshutdown();
    sentinel vehicle::init_target_group();
    sentinel vehicle::add_to_target_group( sentinel );
    params = level.killstreakbundle[ "sentinel" ];
    immediate_use = isdefined( params.ksuseimmediately ) ? params.ksuseimmediately : 0;
    player remote_weapons::useremoteweapon( sentinel, "sentinel", immediate_use );
    sentinel killstreaks::play_pilot_dialog_on_owner( "arrive", "sentinel", killstreak_id );
    self killstreaks::play_killstreak_start_dialog( "sentinel", self.team, killstreak_id );
    sentinel thread watchgameended();
    return true;
}

// Namespace sentinel/sentinel
// Params 1
// Checksum 0x63ebe352, Offset: 0x2008
// Size: 0xfc
function hackedcallbackpre( hacker )
{
    sentinel = self;
    sentinel.owner unlink();
    sentinel clientfield::set( "vehicletransition", 0 );
    
    if ( sentinel.controlled === 1 )
    {
        visionset_mgr::deactivate( "visionset", "sentinel_visionset", sentinel.owner );
    }
    
    sentinel.owner remote_weapons::removeandassignnewremotecontroltrigger( sentinel.usetrigger );
    sentinel remote_weapons::endremotecontrolweaponuse( 1 );
    endsentinelremotecontrol( sentinel, 1 );
}

// Namespace sentinel/sentinel
// Params 1
// Checksum 0x4c26a8c9, Offset: 0x2110
// Size: 0x70
function hackedcallbackpost( hacker )
{
    sentinel = self;
    hacker remote_weapons::useremoteweapon( sentinel, "sentinel", 0 );
    sentinel notify( #"watchremotecontroldeactivate_remoteweapons" );
    sentinel.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now( sentinel );
}

// Namespace sentinel/sentinel
// Params 2
// Checksum 0xb44afedd, Offset: 0x2188
// Size: 0x3c
function configureteampost( owner, ishacked )
{
    sentinel = self;
    sentinel thread watchteamchange();
}

// Namespace sentinel/sentinel
// Params 0
// Checksum 0x72b8508, Offset: 0x21d0
// Size: 0x6c
function watchgameended()
{
    sentinel = self;
    sentinel endon( #"death" );
    level waittill( "game_ended" );
    sentinel.abandoned = 1;
    sentinel.selfdestruct = 1;
    sentinel notify( #"sentinel_shutdown" );
}

// Namespace sentinel/sentinel
// Params 1
// Checksum 0xbeaaa7a1, Offset: 0x2248
// Size: 0x21c
function startsentinelremotecontrol( sentinel )
{
    player = self;
    assert( isplayer( player ) );
    sentinel usevehicle( player, 0 );
    sentinel clientfield::set( "vehicletransition", 1 );
    sentinel thread audio::sndupdatevehiclecontext( 1 );
    sentinel thread vehicle::monitor_missiles_locked_on_to_me( player );
    sentinel.inheliproximity = 0;
    sentinel.treat_owner_damage_as_friendly_fire = 0;
    sentinel.ignore_team_kills = 0;
    minheightoverride = undefined;
    minz_struct = struct::get( "vehicle_oob_minz", "targetname" );
    
    if ( isdefined( minz_struct ) )
    {
        minheightoverride = minz_struct.origin[ 2 ];
    }
    
    sentinel thread qrdrone::qrdrone_watch_distance( 0, minheightoverride );
    sentinel.distance_shutdown_override = &sentineldistancefailure;
    player vehicle::set_vehicle_drivable_time( 45000, sentinel.killstreak_end_time );
    visionset_mgr::activate( "visionset", "sentinel_visionset", player, 1, 90000, 1 );
    
    if ( isdefined( sentinel.playerdrivenversion ) )
    {
        sentinel setvehicletype( sentinel.playerdrivenversion );
    }
}

// Namespace sentinel/sentinel
// Params 2
// Checksum 0xe6f727b5, Offset: 0x2470
// Size: 0x1fc
function endsentinelremotecontrol( sentinel, exitrequestedbyowner )
{
    sentinel.treat_owner_damage_as_friendly_fire = 1;
    sentinel.ignore_team_kills = 1;
    
    if ( isdefined( sentinel.owner ) )
    {
        sentinel.owner vehicle::stop_monitor_missiles_locked_on_to_me();
        
        if ( sentinel.controlled === 1 )
        {
            visionset_mgr::deactivate( "visionset", "sentinel_visionset", sentinel.owner );
        }
    }
    
    params = level.killstreakbundle[ "sentinel" ];
    shutdown_on_exit = isdefined( params.ksshutdownonexit ) ? params.ksshutdownonexit : 0;
    
    if ( exitrequestedbyowner || shutdown_on_exit )
    {
        if ( isdefined( sentinel.owner ) )
        {
            sentinel.owner qrdrone::destroyhud();
            sentinel.owner unlink();
            sentinel clientfield::set( "vehicletransition", 0 );
        }
        
        sentinel thread audio::sndupdatevehiclecontext( 0 );
    }
    
    if ( isdefined( sentinel.original_vehicle_type ) )
    {
        sentinel setvehicletype( sentinel.original_vehicle_type );
    }
    
    if ( shutdown_on_exit )
    {
        sentinel ontimeout();
    }
}

// Namespace sentinel/sentinel
// Params 0
// Checksum 0xbdabd844, Offset: 0x2678
// Size: 0x12c
function ontimeout()
{
    sentinel = self;
    sentinel killstreaks::play_pilot_dialog_on_owner( "timeout", "sentinel" );
    params = level.killstreakbundle[ "sentinel" ];
    
    if ( isdefined( sentinel.owner ) )
    {
        radiusdamage( sentinel.origin, params.ksexplosionouterradius, params.ksexplosioninnerdamage, params.ksexplosionouterdamage, sentinel.owner, "MOD_EXPLOSIVE", getweapon( "sentinel" ) );
        
        if ( isdefined( params.ksexplosionrumble ) )
        {
            sentinel.owner playrumbleonentity( params.ksexplosionrumble );
        }
    }
    
    sentinel notify( #"sentinel_shutdown" );
}

// Namespace sentinel/sentinel
// Params 0
// Checksum 0x7e89dddd, Offset: 0x27b0
// Size: 0x9a
function healthmonitor()
{
    self endon( #"death" );
    params = level.killstreakbundle[ "sentinel" ];
    
    if ( isdefined( params.fxlowhealth ) )
    {
        while ( true )
        {
            if ( self.lowhealth > self.health )
            {
                playfxontag( params.fxlowhealth, self, "tag_origin" );
                break;
            }
            
            waitframe( 1 );
        }
    }
}

// Namespace sentinel/sentinel
// Params 0
// Checksum 0x4dc1704c, Offset: 0x2858
// Size: 0x24
function sentineldistancefailure()
{
    sentinel = self;
    sentinel notify( #"sentinel_shutdown" );
}

// Namespace sentinel/sentinel
// Params 0
// Checksum 0x7da4349f, Offset: 0x2888
// Size: 0x264
function watchdeath()
{
    sentinel = self;
    waitresult = sentinel waittill( "death" );
    attacker = waitresult.attacker;
    weapon = waitresult.weapon;
    modtype = waitresult.mod;
    sentinel notify( #"sentinel_shutdown" );
    attacker = self [[ level.figure_out_attacker ]]( attacker );
    
    if ( !isdefined( self.owner ) || isdefined( attacker ) && self.owner util::isenemyplayer( attacker ) )
    {
        if ( isplayer( attacker ) )
        {
            challenges::destroyedaircraft( attacker, weapon, sentinel.controlled === 1 );
            attacker challenges::addflyswatterstat( weapon, self );
            attacker addweaponstat( weapon, "destroy_aitank_or_setinel", 1 );
            scoreevents::processscoreevent( "destroyed_sentinel", attacker, sentinel.owner, weapon );
            
            if ( modtype == "MOD_RIFLE_BULLET" || modtype == "MOD_PISTOL_BULLET" )
            {
                attacker addplayerstat( "shoot_down_sentinel", 1 );
            }
            
            luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_SENTINEL", attacker.entnum );
        }
        
        if ( isdefined( sentinel ) && isdefined( sentinel.owner ) )
        {
            sentinel killstreaks::play_destroyed_dialog_on_owner( "sentinel", sentinel.killstreak_id );
        }
    }
}

// Namespace sentinel/sentinel
// Params 0
// Checksum 0x630c86d3, Offset: 0x2af8
// Size: 0x78
function watchteamchange()
{
    self notify( #"sentinel_watchteamchange_singleton" );
    self endon( #"sentinel_watchteamchange_singleton" );
    sentinel = self;
    sentinel endon( #"sentinel_shutdown" );
    sentinel.owner waittill( "joined_team", "disconnect", "joined_spectators" );
    sentinel notify( #"sentinel_shutdown" );
}

// Namespace sentinel/sentinel
// Params 0
// Checksum 0xc104c068, Offset: 0x2b78
// Size: 0xd0
function watchwater()
{
    sentinel = self;
    sentinel endon( #"sentinel_shutdown" );
    
    while ( true )
    {
        wait 0.1;
        trace = physicstrace( self.origin + ( 0, 0, 10 ), self.origin + ( 0, 0, 6 ), ( -2, -2, -2 ), ( 2, 2, 2 ), self, 4 );
        
        if ( trace[ "fraction" ] < 1 )
        {
            break;
        }
    }
    
    sentinel notify( #"sentinel_shutdown" );
}

// Namespace sentinel/sentinel
// Params 0
// Checksum 0x35c568a1, Offset: 0x2c50
// Size: 0x16c
function watchshutdown()
{
    sentinel = self;
    sentinel waittill( "sentinel_shutdown" );
    
    if ( isdefined( sentinel.controlled ) && ( isdefined( sentinel.control_initiated ) && sentinel.control_initiated || sentinel.controlled ) )
    {
        sentinel remote_weapons::endremotecontrolweaponuse( 0 );
        
        while ( isdefined( sentinel.controlled ) && ( isdefined( sentinel.control_initiated ) && sentinel.control_initiated || sentinel.controlled ) )
        {
            waitframe( 1 );
        }
    }
    
    if ( isdefined( sentinel.owner ) )
    {
        sentinel.owner qrdrone::destroyhud();
    }
    
    killstreakrules::killstreakstop( "sentinel", sentinel.originalteam, sentinel.killstreak_id );
    
    if ( isalive( sentinel ) )
    {
        sentinel kill();
    }
}

