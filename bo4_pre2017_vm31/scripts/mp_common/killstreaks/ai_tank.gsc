#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/hud_shared;
#using scripts/core_common/killstreaks_shared;
#using scripts/core_common/oob;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/spawning_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/values_shared;
#using scripts/core_common/vehicle_ai_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/core_common/vehicles/amws;
#using scripts/core_common/visionset_mgr_shared;
#using scripts/core_common/weapons/weapons;
#using scripts/mp_common/challenges;
#using scripts/mp_common/gametypes/dev;
#using scripts/mp_common/killstreaks/dogs;
#using scripts/mp_common/killstreaks/emp;
#using scripts/mp_common/killstreaks/killstreak_bundles;
#using scripts/mp_common/killstreaks/killstreak_detect;
#using scripts/mp_common/killstreaks/killstreak_hacking;
#using scripts/mp_common/killstreaks/killstreakrules;
#using scripts/mp_common/killstreaks/killstreaks;
#using scripts/mp_common/killstreaks/remote_weapons;
#using scripts/mp_common/killstreaks/satellite;
#using scripts/mp_common/killstreaks/supplydrop;
#using scripts/mp_common/killstreaks/uav;
#using scripts/mp_common/util;

#namespace ai_tank;

#using_animtree( "mp_vehicles" );

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0xa1a01640, Offset: 0xe28
// Size: 0x47c
function init()
{
    bundle = struct::get_script_bundle( "killstreak", "killstreak_" + "ai_tank_drop" );
    level.ai_tank_minigun_flash_3p = "killstreaks/fx_agr_rocket_flash_3p";
    killstreaks::register( "ai_tank_drop", "ai_tank_marker", "killstreak_ai_tank_drop", "ai_tank_drop_used", &activateaitank );
    killstreaks::register_alt_weapon( "ai_tank_drop", "amws_gun_turret" );
    killstreaks::register_alt_weapon( "ai_tank_drop", "amws_launcher_turret" );
    killstreaks::register_alt_weapon( "ai_tank_drop", "amws_gun_turret_mp_player" );
    killstreaks::register_alt_weapon( "ai_tank_drop", "amws_launcher_turret_mp_player" );
    killstreaks::register_remote_override_weapon( "ai_tank_drop", "killstreak_ai_tank" );
    killstreaks::register_strings( "ai_tank_drop", &"KILLSTREAK_EARNED_AI_TANK_DROP", &"KILLSTREAK_AI_TANK_NOT_AVAILABLE", &"KILLSTREAK_AI_TANK_INBOUND", undefined, &"KILLSTREAK_AI_TANK_HACKED" );
    killstreaks::register_dialog( "ai_tank_drop", "mpl_killstreak_ai_tank", "aiTankDialogBundle", "aiTankPilotDialogBundle", "friendlyAiTank", "enemyAiTank", "enemyAiTankMultiple", "friendlyAiTankHacked", "enemyAiTankHacked", "requestAiTank", "threatAiTank" );
    killstreaks::devgui_scorestreak_command( "ai_tank_drop", "Debug Routes", "set devgui_tank routes" );
    level.killstreaks[ "ai_tank_drop" ].threatonkill = 1;
    remote_weapons::registerremoteweapon( "killstreak_ai_tank", &"MP_REMOTE_USE_TANK", &starttankremotecontrol, &endtankremotecontrol, 0 );
    level.ai_tank_fov = cos( 160 );
    level.ai_tank_turret_weapon = getweapon( "ai_tank_drone_gun" );
    level.ai_tank_turret_fire_rate = level.ai_tank_turret_weapon.firetime;
    level.ai_tank_remote_weapon = getweapon( "killstreak_ai_tank" );
    spawns = spawning::get_spawnpoint_array( "mp_tdm_spawn" );
    level.ai_tank_damage_fx = "killstreaks/fx_agr_damage_state";
    level.ai_tank_explode_fx = "killstreaks/fx_agr_explosion";
    level.ai_tank_crate_explode_fx = "killstreaks/fx_agr_drop_box";
    anims = [];
    anims[ anims.size ] = %o_drone_tank_missile1_fire;
    anims[ anims.size ] = %o_drone_tank_missile2_fire;
    anims[ anims.size ] = %o_drone_tank_missile3_fire;
    anims[ anims.size ] = %o_drone_tank_missile_full_reload;
    
    if ( !isdefined( bundle.ksmainturretrecoilforcezoffset ) )
    {
        bundle.ksmainturretrecoilforcezoffset = 0;
    }
    
    if ( !isdefined( bundle.ksweaponreloadtime ) )
    {
        bundle.ksweaponreloadtime = 0.5;
    }
    
    visionset_mgr::register_info( "visionset", "agr_visionset", 1, 80, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0 );
    
    /#
        level thread tank_devgui_think();
    #/
    
    thread register();
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0x5db490a7, Offset: 0x12b0
// Size: 0xc4
function register()
{
    clientfield::register( "vehicle", "ai_tank_death", 1, 1, "int" );
    clientfield::register( "vehicle", "ai_tank_missile_fire", 1, 2, "int" );
    clientfield::register( "vehicle", "ai_tank_stun", 1, 1, "int" );
    clientfield::register( "toplayer", "ai_tank_update_hud", 1, 1, "counter" );
}

// Namespace ai_tank/ai_tank
// Params 2
// Checksum 0x255f509c, Offset: 0x1380
// Size: 0x4ca
function calculatespawnorigin( origin, angles )
{
    startheight = getplacementstartheight();
    mins = ( -5, -5, 0 );
    maxs = ( 5, 5, 10 );
    startpoints = [];
    startangles = [];
    wheelcounts = [];
    testcheck = [];
    largestcount = 0;
    largestcountindex = 0;
    testangles = [];
    testangles[ 0 ] = ( 0, 0, 0 );
    testangles[ 1 ] = ( 0, 20, 0 );
    testangles[ 2 ] = ( 0, -20, 0 );
    testangles[ 3 ] = ( 0, 45, 0 );
    testangles[ 4 ] = ( 0, -45, 0 );
    heightoffset = 5;
    
    for ( i = 0; i < testangles.size ; i++ )
    {
        testcheck[ i ] = 0;
        startangles[ i ] = ( 0, angles[ 1 ], 0 );
        startpoint = origin + vectorscale( anglestoforward( startangles[ i ] + testangles[ i ] ), 70 );
        endpoint = startpoint - ( 0, 0, 100 );
        startpoint += ( 0, 0, startheight );
        mask = 1 | 2;
        trace = physicstrace( startpoint, endpoint, mins, maxs, self, mask );
        
        if ( isdefined( trace[ "entity" ] ) && isplayer( trace[ "entity" ] ) )
        {
            wheelcounts[ i ] = 0;
            continue;
        }
        
        startpoints[ i ] = trace[ "position" ] + ( 0, 0, heightoffset );
        wheelcounts[ i ] = testwheellocations( startpoints[ i ], startangles[ i ], heightoffset );
        
        if ( positionwouldtelefrag( startpoints[ i ] ) )
        {
            continue;
        }
        
        if ( largestcount < wheelcounts[ i ] )
        {
            largestcount = wheelcounts[ i ];
            largestcountindex = i;
        }
        
        if ( wheelcounts[ i ] >= 3 )
        {
            testcheck[ i ] = 1;
            
            if ( testspawnorigin( startpoints[ i ], startangles[ i ] ) )
            {
                placement = spawnstruct();
                placement.origin = startpoints[ i ];
                placement.angles = startangles[ i ];
                return placement;
            }
        }
    }
    
    for ( i = 0; i < testangles.size ; i++ )
    {
        if ( !testcheck[ i ] )
        {
            if ( wheelcounts[ i ] >= 2 )
            {
                if ( testspawnorigin( startpoints[ i ], startangles[ i ] ) )
                {
                    placement = spawnstruct();
                    placement.origin = startpoints[ i ];
                    placement.angles = startangles[ i ];
                    return placement;
                }
            }
        }
    }
    
    return undefined;
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0xbb7585f2, Offset: 0x1858
// Size: 0x1d0, Type: bool
function activateaitank( hardpointtype )
{
    player = self;
    placement = calculatespawnorigin( self.origin, self.angles );
    
    if ( !isdefined( placement ) || !self isonground() || self util::isusingremote() || killstreaks::is_interacting_with_object() || self oob::istouchinganyoobtrigger() )
    {
        self iprintlnbold( &"KILLSTREAK_RCBOMB_NOT_PLACEABLE" );
        return false;
    }
    
    killstreak_id = player killstreakrules::killstreakstart( hardpointtype, player.team, 0, 1 );
    
    if ( killstreak_id == -1 )
    {
        return false;
    }
    
    level thread ai_tank_killstreak_start( self, placement.origin, killstreak_id, hardpointtype );
    
    if ( self.pers[ "lpSystem" ].tokens > 0 )
    {
        self.pers[ "lpSystem" ].tokens--;
        self clientfield::set_player_uimodel( "hudItems.lplevel.unlockTokens", self.pers[ "lpSystem" ].tokens );
    }
    
    return true;
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0x74ce5c, Offset: 0x1a30
// Size: 0x338
function usekillstreakaitankdrop( hardpointtype )
{
    team = self.team;
    
    if ( !self supplydrop::issupplydropgrenadeallowed( hardpointtype ) )
    {
        return 0;
    }
    
    killstreak_id = self killstreakrules::killstreakstart( hardpointtype, team, 0, 0 );
    
    if ( killstreak_id == -1 )
    {
        return 0;
    }
    
    context = spawnstruct();
    
    if ( !isdefined( context ) )
    {
        killstreak_stop_and_assert( hardpointtype, team, killstreak_id, "Failed to spawn struct for ai tank." );
        return 0;
    }
    
    context.radius = level.killstreakcorebundle.ksairdropaitankradius;
    context.dist_from_boundary = 16;
    context.max_dist_from_location = 4;
    context.perform_physics_trace = 1;
    context.check_same_floor = 1;
    context.islocationgood = &is_location_good;
    context.objective = &"airdrop_aitank";
    context.killstreakref = hardpointtype;
    context.validlocationsound = level.killstreakcorebundle.ksvalidaitanklocationsound;
    context.tracemask = 1 | 4;
    context.droptag = "tag_attach";
    context.droptagoffset = ( -35, 0, 10 );
    result = self supplydrop::usesupplydropmarker( killstreak_id, context );
    self notify( #"supply_drop_marker_done" );
    
    if ( !isdefined( result ) || !result )
    {
        killstreakrules::killstreakstop( hardpointtype, team, killstreak_id );
        return 0;
    }
    
    self killstreaks::play_killstreak_start_dialog( "ai_tank_drop", self.team, killstreak_id );
    self killstreakrules::displaykillstreakstartteammessagetoall( "ai_tank_drop" );
    self addweaponstat( getweapon( "ai_tank_marker" ), "used", 1 );
    self.pers[ "lpSystem" ].tokens--;
    self clientfield::set_player_uimodel( "hudItems.lplevel.unlockTokens", self.pers[ "lpSystem" ].tokens );
    return result;
}

// Namespace ai_tank/ai_tank
// Params 5
// Checksum 0x8001b3f3, Offset: 0x1d70
// Size: 0x24c
function crateland( crate, category, owner, team, context )
{
    context.perform_physics_trace = 0;
    context.dist_from_boundary = 24;
    context.max_dist_from_location = 96;
    
    if ( owner emp::enemyempactive() && ( !crate is_location_good( crate.origin, context ) || !isdefined( owner ) || team != owner.team || !owner hasperk( "specialty_immuneemp" ) ) )
    {
        killstreakrules::killstreakstop( category, team, crate.package_contents_id );
        wait 10;
        
        if ( isdefined( crate ) )
        {
            crate delete();
        }
        
        return;
    }
    
    origin = crate.origin;
    cratebottom = bullettrace( origin, origin + ( 0, 0, -50 ), 0, crate );
    
    if ( isdefined( cratebottom ) )
    {
        origin = cratebottom[ "position" ] + ( 0, 0, 1 );
    }
    
    playfx( level.ai_tank_crate_explode_fx, origin, ( 1, 0, 0 ), ( 0, 0, 1 ) );
    playsoundatposition( "veh_talon_crate_exp", crate.origin );
    level thread ai_tank_killstreak_start( owner, origin, crate.package_contents_id, category );
    crate delete();
}

// Namespace ai_tank/ai_tank
// Params 2
// Checksum 0x81aaa457, Offset: 0x1fc8
// Size: 0x42, Type: bool
function is_location_good( location, context )
{
    return supplydrop::islocationgood( location, context ) && valid_location( location );
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0xebfcb952, Offset: 0x2018
// Size: 0xee, Type: bool
function valid_location( location )
{
    if ( !isdefined( location ) )
    {
        location = self.origin;
    }
    
    if ( !isplayer( self ) )
    {
        start = self getcentroid();
        end = location + ( 0, 0, 16 );
        trace = physicstrace( start, end, ( 0, 0, 0 ), ( 0, 0, 0 ), self, 16 );
        
        if ( trace[ "fraction" ] < 1 )
        {
            return false;
        }
    }
    
    if ( self oob::istouchinganyoobtrigger() )
    {
        return false;
    }
    
    return true;
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0x3efaabdc, Offset: 0x2110
// Size: 0x14c
function hackedcallbackpre( hacker )
{
    drone = self;
    drone clientfield::set( "enemyvehicle", 2 );
    drone.owner stop_remote();
    drone.owner clientfield::set_to_player( "static_postfx", 0 );
    
    if ( drone.controlled === 1 )
    {
        visionset_mgr::deactivate( "visionset", "agr_visionset", drone.owner );
    }
    
    drone.owner remote_weapons::removeandassignnewremotecontroltrigger( drone.usetrigger );
    drone remote_weapons::endremotecontrolweaponuse( 1 );
    drone.owner unlink();
    drone clientfield::set( "vehicletransition", 0 );
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0xfc302b95, Offset: 0x2268
// Size: 0x70
function hackedcallbackpost( hacker )
{
    drone = self;
    hacker remote_weapons::useremoteweapon( drone, "killstreak_ai_tank", 0 );
    drone notify( #"watchremotecontroldeactivate_remoteweapons" );
    drone.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now( drone );
}

// Namespace ai_tank/ai_tank
// Params 2
// Checksum 0x329f6fd2, Offset: 0x22e0
// Size: 0x3c
function configureteampost( owner, ishacked )
{
    drone = self;
    drone thread tank_watch_owner_events();
}

// Namespace ai_tank/ai_tank
// Params 4
// Checksum 0xf7699114, Offset: 0x2328
// Size: 0x5c8
function ai_tank_killstreak_start( owner, origin, killstreak_id, category )
{
    team = owner.team;
    waittillframeend();
    
    if ( level.gameended )
    {
        return;
    }
    
    drone = spawnvehicle( "spawner_bo3_ai_tank_mp", origin, ( 0, 0, 0 ), "talon" );
    
    if ( !isdefined( drone ) )
    {
        killstreak_stop_and_assert( category, team, killstreak_id, "Failed to spawn ai tank vehicle." );
        return;
    }
    
    drone.settings = struct::get_script_bundle( "vehiclecustomsettings", drone.scriptbundlesettings );
    drone.customdamagemonitor = 1;
    drone.avoid_shooting_owner = 1;
    drone.avoid_shooting_owner_ref_tag = "tag_flash_gunner1";
    drone killstreaks::configure_team( "ai_tank_drop", killstreak_id, owner, "small_vehicle", undefined, &configureteampost );
    drone killstreak_hacking::enable_hacking( "ai_tank_drop", &hackedcallbackpre, &hackedcallbackpost );
    drone killstreaks::setup_health( "ai_tank_drop", 1500, 0 );
    drone.original_vehicle_type = drone.vehicletype;
    drone clientfield::set( "enemyvehicle", 1 );
    drone setvehicleavoidance( 1 );
    drone clientfield::set( "ai_tank_missile_fire", 3 );
    drone.killstreak_id = killstreak_id;
    drone.type = "tank_drone";
    drone.dontdisconnectpaths = 1;
    drone.isstunned = 0;
    drone.soundmod = "drone_land";
    drone.ignore_vehicle_underneath_splash_scalar = 1;
    drone.treat_owner_damage_as_friendly_fire = 1;
    drone.ignore_team_kills = 1;
    drone.controlled = 0;
    drone makevehicleunusable();
    drone.numberrockets = 3;
    drone.warningshots = 3;
    drone setdrawinfrared( 1 );
    
    if ( !isdefined( drone.owner.numtankdrones ) )
    {
        drone.owner.numtankdrones = 1;
    }
    else
    {
        drone.owner.numtankdrones++;
    }
    
    drone.ownernumber = drone.owner.numtankdrones;
    target_set( drone, ( 0, 0, 20 ) );
    drone vehicle::init_target_group();
    drone vehicle::add_to_target_group( drone );
    drone setup_gameplay_think( category );
    drone.killstreak_end_time = gettime() + 45000;
    params = level.killstreakbundle[ "ai_tank_drop" ];
    immediate_use = isdefined( params.ksuseimmediately ) ? params.ksuseimmediately : 0;
    waitframe( 1 );
    owner remote_weapons::useremoteweapon( drone, "killstreak_ai_tank", immediate_use );
    drone thread kill_monitor();
    drone thread deleteonkillbrush( drone.owner );
    drone thread tank_rocket_watch_ai();
    level thread tank_game_end_think( drone );
    
    foreach ( player in level.players )
    {
        drone respectnottargetedbyaitankperk( player );
    }
    
    /#
        drone thread tank_think_debug();
    #/
    
    /#
    #/
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0x2d4b1c32, Offset: 0x28f8
// Size: 0x4e
function get_vehicle_name( vehicle_version )
{
    switch ( vehicle_version )
    {
        case 2:
        default:
            return "spawner_bo3_ai_tank_mp";
        case 1:
            return "ai_tank_drone_mp";
    }
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0x78002f95, Offset: 0x2950
// Size: 0xac
function setup_gameplay_think( category )
{
    drone = self;
    drone thread tank_abort_think();
    drone thread tank_team_kill();
    drone thread tank_too_far_from_nav_mesh_abort_think();
    drone thread tank_death_think( category );
    drone thread tank_damage_think();
    drone thread watchwater();
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0xc522b2f, Offset: 0x2a08
// Size: 0x65c
function tank_think_debug()
{
    self endon( #"death" );
    server_frames_to_persist = 1;
    text_scale = 0.5;
    text_alpha = 1;
    text_color = ( 1, 1, 1 );
    
    while ( true )
    {
        if ( getdvarint( "scr_ai_tank_think_debug" ) == 0 )
        {
            wait 5;
            continue;
        }
        
        target_name = "unknown";
        target_entity = undefined;
        tank_is_idle = !isdefined( self.enemy );
        target_entity = self.enemy;
        
        if ( isdefined( target_entity ) && !tank_is_idle )
        {
            if ( isdefined( target_entity.name ) )
            {
                target_name = target_entity.name;
            }
            else if ( isdefined( target_entity.remotename ) )
            {
                target_name = target_entity.remotename;
            }
        }
        
        target_text = tank_is_idle ? "Target: none" : "Target: " + target_name;
        
        /#
            print3d( self.origin, target_text, text_color, text_alpha, text_scale, server_frames_to_persist );
        #/
        
        duration_text = "Duration: " + ( self.killstreak_end_time - gettime() ) * 0.001;
        
        /#
            print3d( self.origin + ( 0, 0, 12 ), duration_text, text_color, text_alpha, text_scale, server_frames_to_persist );
        #/
        
        can_see_text = "Can see: ";
        
        if ( tank_is_idle )
        {
            can_see_text += "---";
        }
        else
        {
            can_see_text += self cansee( target_entity ) ? "yes" : "no";
        }
        
        /#
            print3d( self.origin + ( 0, 0, -12 ), can_see_text, text_color, text_alpha, text_scale, server_frames_to_persist );
        #/
        
        movement_type_text = "Movement: ";
        
        if ( isdefined( self.debug_ai_movement_type ) )
        {
            movement_type_text += self.debug_ai_movement_type;
        }
        else
        {
            movement_type_text += "---";
        }
        
        /#
            print3d( self.origin + ( 0, 0, -24 ), movement_type_text, text_color, text_alpha, text_scale, server_frames_to_persist );
        #/
        
        if ( isdefined( self.debug_ai_move_to_point ) )
        {
            /#
                util::debug_sphere( self.debug_ai_move_to_point + ( 0, 0, 16 ), 10, ( 0.1, 0.95, 0.1 ), 0.9, server_frames_to_persist );
            #/
            
            if ( isdefined( self.debug_ai_move_to_points_considered ) )
            {
                foreach ( point in self.debug_ai_move_to_points_considered )
                {
                    point_color = ( 0.65, 0.65, 0.65 );
                    
                    if ( isdefined( point.score ) )
                    {
                        if ( point.score != 0 )
                        {
                            if ( point.score < 0 )
                            {
                                point_color = ( 0.65, 0.1, 0.1 );
                            }
                            else if ( point.score > 50 )
                            {
                                point_color = ( 0.1, 0.65, 0.1 );
                            }
                            else
                            {
                                point_color = ( 0.95, 0.95, 0.1 );
                            }
                            
                            score_text_scale = text_scale;
                            score_text_color = text_color;
                            
                            if ( point.origin != self.debug_ai_move_to_point )
                            {
                                score_text_scale *= 0.67;
                            }
                            else
                            {
                                score_text_scale *= 1.5;
                                score_text_color = ( 0.05, 0.98, 0.05 );
                            }
                            
                            /#
                                print3d( point.origin + ( 0, 0, 16 ), point.score, score_text_color, text_alpha, score_text_scale, server_frames_to_persist );
                            #/
                        }
                    }
                    
                    if ( point.origin != self.debug_ai_move_to_point )
                    {
                        /#
                            util::debug_sphere( point.origin + ( 0, 0, 16 ), 3, point_color, 0.5, server_frames_to_persist );
                        #/
                    }
                }
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0x9a90226c, Offset: 0x3070
// Size: 0x32
function tank_team_kill()
{
    self endon( #"death" );
    self.owner waittill( "teamKillKicked" );
    self notify( #"death" );
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0xb425610a, Offset: 0x30b0
// Size: 0x138
function kill_monitor()
{
    self endon( #"death" );
    last_kill_vo = 0;
    kill_vo_spacing = 4000;
    
    while ( true )
    {
        waitresult = self waittill( "killed" );
        victim = waitresult.victim;
        
        if ( !isdefined( self.owner ) || !isdefined( victim ) )
        {
            continue;
        }
        
        if ( self.owner == victim )
        {
            continue;
        }
        
        if ( level.teambased && self.owner.team == victim.team )
        {
            continue;
        }
        
        if ( !self.controlled && last_kill_vo + kill_vo_spacing < gettime() )
        {
            self killstreaks::play_pilot_dialog_on_owner( "kill", "ai_tank_drop", self.killstreak_id );
            last_kill_vo = gettime();
        }
    }
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0x275ef39, Offset: 0x31f0
// Size: 0x54
function tank_abort_think()
{
    tank = self;
    tank thread killstreaks::waitfortimeout( "ai_tank_drop", 45000, &tank_timeout_callback, "death", "emp_jammed" );
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0x1be4e21e, Offset: 0x3250
// Size: 0x4a
function tank_timeout_callback()
{
    self killstreaks::play_pilot_dialog_on_owner( "timeout", "ai_tank_drop" );
    self.timed_out = 1;
    self notify( #"death" );
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0xe1294b15, Offset: 0x32a8
// Size: 0x15a
function tank_watch_owner_events()
{
    self notify( #"tank_watch_owner_events_singleton" );
    self endon( #"tank_watch_owner_events_singleton" );
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
    
    if ( isdefined( self.owner ) && self.controlled === 1 )
    {
        visionset_mgr::deactivate( "visionset", "agr_visionset", self.owner );
        self.owner stop_remote();
    }
    
    self.abandoned = 1;
    self notify( #"death" );
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0xe632ee40, Offset: 0x3410
// Size: 0x3c
function tank_game_end_think( drone )
{
    drone endon( #"death" );
    level waittill( "game_ended" );
    drone notify( #"death" );
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0x7d86b563, Offset: 0x3458
// Size: 0x5c
function stop_remote()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self killstreaks::clear_using_remote();
    self remote_weapons::destroyremotehud();
    self util::clientnotify( "nofutz" );
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0x8a04bd69, Offset: 0x34c0
// Size: 0x90
function tank_hacked_health_update( hacker )
{
    tank = self;
    hackeddamagetaken = tank.defaultmaxhealth - tank.hackedhealth;
    assert( hackeddamagetaken > 0 );
    
    if ( hackeddamagetaken > tank.damagetaken )
    {
        tank.damagetaken = hackeddamagetaken;
    }
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0x3ed8b934, Offset: 0x3558
// Size: 0x6ba
function tank_damage_think()
{
    self endon( #"death" );
    assert( isdefined( self.maxhealth ) );
    self.defaultmaxhealth = self.maxhealth;
    maxhealth = self.maxhealth;
    self.maxhealth = 999999;
    self.health = self.maxhealth;
    self.isstunned = 0;
    self.hackedhealthupdatecallback = &tank_hacked_health_update;
    self.hackedhealth = killstreak_bundles::get_hacked_health( "ai_tank_drop" );
    low_health = 0;
    self.damagetaken = 0;
    
    for ( ;; )
    {
        waitresult = self waittill( "damage" );
        damage = waitresult.amount;
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        mod = waitresult.mod;
        chargelevel = waitresult.charge_level;
        position = waitresult.position;
        flags = waitresult.flags;
        self.maxhealth = 999999;
        self.health = self.maxhealth;
        
        /#
            self.damage_debug = damage + " (" + weapon.name + ")";
        #/
        
        if ( weapon.isemp && mod == "MOD_GRENADE_SPLASH" )
        {
            emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage( "ai_tank_drop", maxhealth );
            
            if ( !isdefined( emp_damage_to_apply ) )
            {
                emp_damage_to_apply = maxhealth / 2;
            }
            
            self.damagetaken += emp_damage_to_apply;
            damage = 0;
            
            if ( !self.isstunned && emp_damage_to_apply > 0 )
            {
                self.isstunned = 1;
                challenges::stunnedtankwithempgrenade( attacker );
                self thread tank_stun( 4 );
            }
        }
        
        if ( !self.isstunned )
        {
            if ( mod == "MOD_GRENADE_SPLASH" || weapon.dostun && mod == "MOD_GAS" )
            {
                self.isstunned = 1;
                self thread tank_stun( 1.5 );
            }
        }
        
        weapon_damage = killstreak_bundles::get_weapon_damage( "ai_tank_drop", maxhealth, attacker, weapon, mod, damage, flags, chargelevel );
        
        if ( !isdefined( weapon_damage ) )
        {
            if ( mod == "MOD_PROJECTILE_SPLASH" && ( mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET" || weapon.name == "hatchet" || weapon.bulletimpactexplode ) )
            {
                if ( isplayer( attacker ) )
                {
                    if ( attacker hasperk( "specialty_armorpiercing" ) )
                    {
                        damage += int( damage * level.cac_armorpiercing_data );
                    }
                }
                
                if ( weapon.weapclass == "spread" )
                {
                    damage *= 1.5;
                }
                
                weapon_damage = damage * 0.8;
            }
            
            if ( ( mod == "MOD_PROJECTILE" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE_SPLASH" ) && damage != 0 && !weapon.isemp && !weapon.bulletimpactexplode )
            {
                weapon_damage = damage * 1;
            }
            
            if ( !isdefined( weapon_damage ) )
            {
                weapon_damage = damage;
            }
        }
        
        self.damagetaken += weapon_damage;
        
        if ( self.controlled )
        {
            self.owner sendkillstreakdamageevent( int( weapon_damage ) );
            self.owner vehicle::update_damage_as_occupant( self.damagetaken, maxhealth );
        }
        
        if ( self.damagetaken >= maxhealth )
        {
            if ( isdefined( self.owner ) )
            {
                self.owner.dofutz = 1;
            }
            
            self.health = 0;
            self notify( #"death", { #attacker:attacker, #mod:mod, #weapon:weapon } );
            return;
        }
        
        if ( !low_health && self.damagetaken > maxhealth / 1.8 )
        {
            self killstreaks::play_pilot_dialog_on_owner( "damaged", "ai_tank_drop", self.killstreak_id );
            self thread tank_low_health_fx();
            low_health = 1;
        }
    }
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0x4fb8d2ad, Offset: 0x3c20
// Size: 0xfc
function tank_low_health_fx()
{
    self endon( #"death" );
    self.damage_fx = spawn( "script_model", self gettagorigin( "tag_origin" ) + ( 0, 0, -14 ) );
    
    if ( !isdefined( self.damage_fx ) )
    {
        return;
    }
    
    self.damage_fx setmodel( "tag_origin" );
    self.damage_fx linkto( self, "tag_turret", ( 0, 0, -14 ), ( 0, 0, 0 ) );
    wait 0.1;
    playfxontag( level.ai_tank_damage_fx, self.damage_fx, "tag_origin" );
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0x961def15, Offset: 0x3d28
// Size: 0xe0
function deleteonkillbrush( player )
{
    player endon( #"disconnect" );
    self endon( #"death" );
    killbrushes = getentarray( "trigger_hurt", "classname" );
    
    while ( true )
    {
        for ( i = 0; i < killbrushes.size ; i++ )
        {
            if ( self istouching( killbrushes[ i ] ) )
            {
                if ( isdefined( self ) )
                {
                    self notify( #"death", { #attacker:self.owner } );
                }
                
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0x1da7499, Offset: 0x3e10
// Size: 0x270
function tank_stun( duration )
{
    self endon( #"death" );
    self notify( #"stunned" );
    self clearvehgoalpos();
    forward = anglestoforward( self.angles );
    forward = self.origin + forward * 128;
    forward -= ( 0, 0, 64 );
    self turretsettarget( 0, forward );
    self disablegunnerfiring( 0, 1 );
    self laseroff();
    
    if ( self.controlled )
    {
        self.owner val::set( "tank_stun", "freezecontrols", 1 );
        self.owner sendkillstreakdamageevent( 400 );
    }
    
    if ( isdefined( self.owner.fullscreen_static ) )
    {
        self.owner thread remote_weapons::stunstaticfx( duration );
    }
    
    self clientfield::set( "ai_tank_stun", 1 );
    
    if ( self.controlled )
    {
        self.owner clientfield::set_to_player( "static_postfx", 1 );
    }
    
    wait duration;
    self clientfield::set( "ai_tank_stun", 0 );
    
    if ( self.controlled )
    {
        self.owner clientfield::set_to_player( "static_postfx", 0 );
    }
    
    if ( self.controlled )
    {
        self.owner val::reset( "tank_stun", "freezecontrols" );
    }
    
    self disablegunnerfiring( 0, 0 );
    self.isstunned = 0;
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0xb7993463, Offset: 0x4088
// Size: 0x214
function emp_crazy_death()
{
    self clientfield::set( "ai_tank_stun", 1 );
    self notify( #"death" );
    time = 0;
    randomangle = randomint( 360 );
    
    while ( time < 1.45 )
    {
        self turretsettarget( 0, self.origin + anglestoforward( ( randomintrange( 305, 315 ), int( randomangle + time * 180 ), 0 ) ) * 100 );
        
        if ( time > 0.2 )
        {
            self fireweapon( 1 );
            
            if ( randomint( 100 ) > 85 )
            {
                rocket = self fireweapon( 0 );
                
                if ( isdefined( rocket ) )
                {
                    rocket.from_ai = 1;
                }
            }
        }
        
        time += 0.05;
        waitframe( 1 );
    }
    
    self clientfield::set( "ai_tank_death", 1 );
    playfx( level.ai_tank_explode_fx, self.origin, ( 0, 0, 1 ) );
    playsoundatposition( "wpn_agr_explode", self.origin );
    waitframe( 1 );
    self hide();
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0xcef337c2, Offset: 0x42a8
// Size: 0x67c
function tank_death_think( hardpointname )
{
    team = self.team;
    killstreak_id = self.killstreak_id;
    waitresult = self waittill( "death" );
    attacker = waitresult.attacker;
    weapon = waitresult.weapon;
    
    if ( !isdefined( self ) )
    {
        killstreak_stop_and_assert( hardpointname, team, killstreak_id, "Failed to handle death. A." );
        return;
    }
    
    self.dead = 1;
    self laseroff();
    self clearvehgoalpos();
    not_abandoned = !isdefined( self.abandoned ) || !self.abandoned;
    
    if ( self.controlled == 1 )
    {
        self.owner sendkillstreakdamageevent( 600 );
        self.owner remote_weapons::destroyremotehud();
    }
    
    self clientfield::set( "ai_tank_death", 1 );
    stunned = 0;
    settings = self.settings;
    
    if ( self.timed_out === 1 || isdefined( settings ) && self.abandoned === 1 )
    {
        fx_origin = self gettagorigin( isdefined( settings.timed_out_death_tag_1 ) ? settings.timed_out_death_tag_1 : "tag_origin" );
        playfx( isdefined( settings.timed_out_death_fx_1 ) ? settings.timed_out_death_fx_1 : level.ai_tank_explode_fx, isdefined( fx_origin ) ? fx_origin : self.origin, ( 0, 0, 1 ), ( 1, 0, 0 ) );
        playsoundatposition( isdefined( settings.timed_out_death_sound_1 ) ? settings.timed_out_death_sound_1 : "wpn_agr_explode", self.origin );
    }
    else
    {
        playfx( level.ai_tank_explode_fx, self.origin, ( 0, 0, 1 ), ( 1, 0, 0 ) );
        playsoundatposition( "wpn_agr_explode", self.origin );
    }
    
    if ( not_abandoned )
    {
        util::wait_network_frame();
        
        if ( !isdefined( self ) )
        {
            killstreak_stop_and_assert( hardpointname, team, killstreak_id, "Failed to handle death. B." );
            return;
        }
    }
    
    if ( self.controlled )
    {
        self ghost();
    }
    else
    {
        self hide();
    }
    
    if ( isdefined( self.damage_fx ) )
    {
        self.damage_fx delete();
    }
    
    attacker = self [[ level.figure_out_attacker ]]( attacker );
    
    if ( isdefined( attacker ) && isplayer( attacker ) && isdefined( self.owner ) && attacker != self.owner )
    {
        if ( self.owner util::isenemyplayer( attacker ) )
        {
            scoreevents::processscoreevent( "destroyed_aitank", attacker, self.owner, weapon );
            luinotifyevent( &"player_callout", 2, &"KILLSTREAK_DESTROYED_AI_TANK", attacker.entnum );
            attacker addweaponstat( weapon, "destroyed_aitank", 1 );
            controlled = 0;
            
            if ( isdefined( self.wascontrollednowdead ) && self.wascontrollednowdead )
            {
                attacker addweaponstat( weapon, "destroyed_controlled_killstreak", 1 );
                controlled = 1;
            }
            
            attacker challenges::destroyscorestreak( weapon, controlled, 1 );
            attacker challenges::destroynonairscorestreak_poststatslock( weapon );
            attacker addweaponstat( weapon, "destroy_aitank_or_setinel", 1 );
            self killstreaks::play_destroyed_dialog_on_owner( "ai_tank_drop", self.killstreak_id );
        }
    }
    
    if ( not_abandoned )
    {
        self waittilltimeout( 2, "remote_weapon_end" );
        
        if ( !isdefined( self ) )
        {
            killstreak_stop_and_assert( hardpointname, team, killstreak_id, "Failed to handle death. C." );
            return;
        }
    }
    
    killstreakrules::killstreakstop( hardpointname, team, self.killstreak_id );
    
    if ( isdefined( self.aim_entity ) )
    {
        self.aim_entity delete();
    }
    
    self delete();
}

// Namespace ai_tank/ai_tank
// Params 4
// Checksum 0xa84a07, Offset: 0x4930
// Size: 0x5c
function killstreak_stop_and_assert( hardpoint_name, team, killstreak_id, assert_msg )
{
    killstreakrules::killstreakstop( hardpoint_name, team, killstreak_id );
    assertmsg( assert_msg );
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0x9d30b317, Offset: 0x4998
// Size: 0x7e
function tank_too_far_from_nav_mesh_abort_think()
{
    self endon( #"death" );
    not_on_nav_mesh_count = 0;
    
    for ( ;; )
    {
        wait 1;
        not_on_nav_mesh_count = isdefined( getclosestpointonnavmesh( self.origin, 480 ) ) ? 0 : not_on_nav_mesh_count + 1;
        
        if ( not_on_nav_mesh_count >= 4 )
        {
            self notify( #"death" );
        }
    }
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0x6bb48ecc, Offset: 0x4a20
// Size: 0x82, Type: bool
function tank_has_radar()
{
    if ( level.teambased )
    {
        return ( uav::hasuav( self.team ) || satellite::hassatellite( self.team ) );
    }
    
    return uav::hasuav( self.entnum ) || satellite::hassatellite( self.entnum );
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0xad1eb331, Offset: 0x4ab0
// Size: 0x1d6
function tank_get_player_enemies( on_radar )
{
    enemies = [];
    
    if ( !isdefined( on_radar ) )
    {
        on_radar = 0;
    }
    
    if ( on_radar )
    {
        time = gettime();
    }
    
    foreach ( teamkey, team in level.aliveplayers )
    {
        if ( level.teambased && teamkey == self.team )
        {
            continue;
        }
        
        foreach ( player in team )
        {
            if ( !valid_target( player, self.team, self.owner ) )
            {
                continue;
            }
            
            if ( on_radar )
            {
                if ( time - player.lastfiretime > 3000 && !tank_has_radar() )
                {
                    continue;
                }
            }
            
            enemies[ enemies.size ] = player;
        }
    }
    
    return enemies;
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0x80daae6d, Offset: 0x4c90
// Size: 0x18c
function tank_compute_enemy_position()
{
    enemies = tank_get_player_enemies( 0 );
    position = undefined;
    
    if ( enemies.size )
    {
        x = 0;
        y = 0;
        z = 0;
        
        foreach ( enemy in enemies )
        {
            x += enemy.origin[ 0 ];
            y += enemy.origin[ 1 ];
            z += enemy.origin[ 2 ];
        }
        
        x /= enemies.size;
        y /= enemies.size;
        z /= enemies.size;
        position = ( x, y, z );
    }
    
    return position;
}

// Namespace ai_tank/ai_tank
// Params 3
// Checksum 0xa32d2871, Offset: 0x4e28
// Size: 0x258, Type: bool
function valid_target( target, team, owner )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( target == owner )
    {
        return false;
    }
    
    if ( isplayer( target ) )
    {
        if ( target.sessionstate != "playing" )
        {
            return false;
        }
        
        if ( isdefined( target.lastspawntime ) && gettime() - target.lastspawntime < 3000 )
        {
            return false;
        }
        
        if ( target hasperk( "specialty_nottargetedbyaitank" ) )
        {
            return false;
        }
        
        /#
            if ( target isinmovemode( "ufo", "noclip" ) )
            {
                return false;
            }
        #/
    }
    
    if ( level.teambased )
    {
        if ( isdefined( target.team ) && team == target.team )
        {
            return false;
        }
    }
    
    if ( isdefined( target.owner ) && target.owner == owner )
    {
        return false;
    }
    
    if ( isdefined( target.script_owner ) && target.script_owner == owner )
    {
        return false;
    }
    
    if ( isdefined( target.dead ) && target.dead )
    {
        return false;
    }
    
    if ( isdefined( target.targetname ) && target.targetname == "riotshield_mp" )
    {
        if ( isdefined( target.damagetaken ) && target.damagetaken >= getdvarint( "riotshield_deployed_health" ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0x9f038114, Offset: 0x5088
// Size: 0x6c
function respectnottargetedbyaitankperk( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    aitank = self;
    aitank setignoreent( player, player hasperk( "specialty_nottargetedbyaitank" ) );
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0x5b48e0b5, Offset: 0x5100
// Size: 0x23c
function starttankremotecontrol( drone )
{
    drone makevehicleusable();
    drone clearvehgoalpos();
    drone turretcleartarget( 0 );
    drone laseroff();
    drone.treat_owner_damage_as_friendly_fire = 0;
    drone.ignore_team_kills = 0;
    
    if ( isdefined( drone.playerdrivenversion ) )
    {
        drone setvehicletype( drone.playerdrivenversion );
    }
    
    drone usevehicle( self, 0 );
    drone clientfield::set( "vehicletransition", 1 );
    drone makevehicleunusable();
    drone setbrake( 0 );
    drone thread tank_rocket_watch( self );
    drone thread vehicle::monitor_missiles_locked_on_to_me( self );
    self vehicle::set_vehicle_drivable_time( 45000, drone.killstreak_end_time );
    self vehicle::update_damage_as_occupant( isdefined( drone.damagetaken ) ? drone.damagetaken : 0, isdefined( drone.defaultmaxhealth ) ? drone.defaultmaxhealth : 100 );
    drone update_client_ammo( drone.numberrockets, 1 );
    visionset_mgr::activate( "visionset", "agr_visionset", self, 1, 90000, 1 );
}

// Namespace ai_tank/ai_tank
// Params 2
// Checksum 0x2c0dc500, Offset: 0x5348
// Size: 0x294
function endtankremotecontrol( drone, exitrequestedbyowner )
{
    not_dead = !( isdefined( drone.dead ) && drone.dead );
    
    if ( isdefined( drone.owner ) )
    {
        drone.owner remote_weapons::destroyremotehud();
    }
    
    drone.treat_owner_damage_as_friendly_fire = 1;
    drone.ignore_team_kills = 1;
    
    if ( drone.classname == "script_vehicle" )
    {
        drone makevehicleunusable();
    }
    
    if ( isdefined( drone.original_vehicle_type ) && not_dead )
    {
        drone setvehicletype( drone.original_vehicle_type );
    }
    
    if ( isdefined( drone.owner ) )
    {
        drone.owner vehicle::stop_monitor_missiles_locked_on_to_me();
    }
    
    if ( exitrequestedbyowner && not_dead )
    {
        drone vehicle_ai::set_state( "combat" );
    }
    
    if ( drone.cobra === 1 && not_dead )
    {
        drone thread amws::cobra_retract();
    }
    
    if ( isdefined( drone.owner ) && drone.controlled === 1 )
    {
        visionset_mgr::deactivate( "visionset", "agr_visionset", drone.owner );
    }
    
    drone clientfield::set( "vehicletransition", 0 );
    params = level.killstreakbundle[ "ai_tank_drop" ];
    shutdown_on_exit = isdefined( params.ksshutdownonexit ) ? params.ksshutdownonexit : 0;
    
    if ( shutdown_on_exit )
    {
        drone tank_timeout_callback();
    }
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0x2ad8cf8c, Offset: 0x55e8
// Size: 0xf4
function perform_recoil_missile_turret( player )
{
    bundle = level.killstreakbundle[ "ai_tank_drop" ];
    earthquake( 0.4, 0.5, self.origin, 200 );
    self perform_recoil( "tag_barrel", isdefined( self.controlled ) && self.controlled ? bundle.ksmainturretrecoilforcecontrolled : bundle.ksmainturretrecoilforce, bundle.ksmainturretrecoilforcezoffset );
    
    if ( self.controlled && isdefined( player ) )
    {
        player playrumbleonentity( "sniper_fire" );
    }
}

// Namespace ai_tank/ai_tank
// Params 3
// Checksum 0x6b75ebb1, Offset: 0x56e8
// Size: 0x94
function perform_recoil( recoil_tag, force_scale_factor, force_z_offset )
{
    angles = self gettagangles( recoil_tag );
    dir = anglestoforward( angles );
    self launchvehicle( dir * force_scale_factor, self.origin + ( 0, 0, force_z_offset ), 0 );
}

// Namespace ai_tank/ai_tank
// Params 2
// Checksum 0x1424068d, Offset: 0x5788
// Size: 0x7c
function update_client_ammo( ammo_count, driver_only_update )
{
    if ( !isdefined( driver_only_update ) )
    {
        driver_only_update = 0;
    }
    
    if ( !driver_only_update )
    {
        self clientfield::set( "ai_tank_missile_fire", ammo_count );
    }
    
    if ( self.controlled )
    {
        self.owner clientfield::increment_to_player( "ai_tank_update_hud", 1 );
    }
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0xe1c67ce3, Offset: 0x5810
// Size: 0x128
function tank_rocket_watch( player )
{
    self endon( #"death" );
    player endon( #"stopped_using_remote" );
    
    if ( self.numberrockets <= 0 )
    {
        self reload_rockets( player );
    }
    
    if ( !self.isstunned )
    {
        self disabledriverfiring( 0 );
    }
    
    while ( true )
    {
        waitresult = player waittill( "missile_fire" );
        waitresult.projectile.ignore_team_kills = self.ignore_team_kills;
        self.numberrockets--;
        self update_client_ammo( self.numberrockets );
        self perform_recoil_missile_turret( player );
        
        if ( self.numberrockets <= 0 )
        {
            self reload_rockets( player );
        }
    }
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0x87ccee53, Offset: 0x5940
// Size: 0x6c
function tank_rocket_watch_ai()
{
    self endon( #"death" );
    
    while ( true )
    {
        waitresult = self waittill( "missile_fire" );
        waitresult.projectile.ignore_team_kills = self.ignore_team_kills;
        waitresult.projectile.killcament = self;
    }
}

// Namespace ai_tank/ai_tank
// Params 1
// Checksum 0xd13a2120, Offset: 0x59b8
// Size: 0x124
function reload_rockets( player )
{
    bundle = level.killstreakbundle[ "ai_tank_drop" ];
    self disabledriverfiring( 1 );
    weapon_wait_duration_ms = int( bundle.ksweaponreloadtime * 1000 );
    player setvehicleweaponwaitduration( weapon_wait_duration_ms );
    player setvehicleweaponwaitendtime( gettime() + weapon_wait_duration_ms );
    wait bundle.ksweaponreloadtime;
    self.numberrockets = 3;
    self update_client_ammo( self.numberrockets );
    wait 0.4;
    
    if ( !self.isstunned )
    {
        self disabledriverfiring( 0 );
    }
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0x9f71dcb8, Offset: 0x5ae8
// Size: 0x1d6
function watchwater()
{
    self endon( #"death" );
    inwater = 0;
    
    while ( !inwater )
    {
        wait 0.3;
        trace = physicstrace( self.origin + ( 0, 0, 42 ), self.origin + ( 0, 0, 12 ), ( -2, -2, -2 ), ( 2, 2, 2 ), self, 4 );
        inwater = trace[ "fraction" ] < ( 42 - 36 ) / ( 42 - 12 ) && trace[ "fraction" ] != 1;
        watertracedistancefromend = 42 - 12 - trace[ "fraction" ] * ( 42 - 12 );
        static_alpha = min( 1, watertracedistancefromend / ( 36 - 12 ) );
        
        if ( isdefined( self.owner ) && self.controlled )
        {
            self.owner clientfield::set_to_player( "static_postfx", static_alpha > 0 ? 1 : 0 );
        }
    }
    
    if ( isdefined( self.owner ) )
    {
        self.owner.dofutz = 1;
    }
    
    self notify( #"death" );
}

// Namespace ai_tank/ai_tank
// Params 0
// Checksum 0xe86e3c45, Offset: 0x5cc8
// Size: 0x6a
function getplacementstartheight()
{
    startheight = 50;
    
    switch ( self getstance() )
    {
        case #"crouch":
            startheight = 30;
            break;
        case #"prone":
            startheight = 15;
            break;
    }
    
    return startheight;
}

// Namespace ai_tank/ai_tank
// Params 3
// Checksum 0x8aa98cc5, Offset: 0x5d40
// Size: 0x202
function testwheellocations( origin, angles, heightoffset )
{
    forward = 13;
    side = 10;
    wheels = [];
    wheels[ 0 ] = ( forward, side, 0 );
    wheels[ 1 ] = ( forward, -1 * side, 0 );
    wheels[ 2 ] = ( -1 * forward, -1 * side, 0 );
    wheels[ 3 ] = ( -1 * forward, side, 0 );
    height = 5;
    touchcount = 0;
    yawangles = ( 0, angles[ 1 ], 0 );
    
    for ( i = 0; i < 4 ; i++ )
    {
        wheel = rotatepoint( wheels[ i ], yawangles );
        startpoint = origin + wheel;
        endpoint = startpoint + ( 0, 0, -1 * height - heightoffset );
        startpoint += ( 0, 0, height - heightoffset );
        trace = bullettrace( startpoint, endpoint, 0, self );
        
        if ( trace[ "fraction" ] < 1 )
        {
            touchcount++;
        }
    }
    
    return touchcount;
}

// Namespace ai_tank/ai_tank
// Params 2
// Checksum 0x69f4d987, Offset: 0x5f50
// Size: 0x22e, Type: bool
function testspawnorigin( origin, angles )
{
    liftedorigin = origin + ( 0, 0, 5 );
    size = 12;
    height = 15;
    mins = ( -1 * size, -1 * size, 0 );
    maxs = ( size, size, height );
    absmins = liftedorigin + mins;
    absmaxs = liftedorigin + maxs;
    
    if ( boundswouldtelefrag( absmins, absmaxs ) )
    {
        return false;
    }
    
    startheight = getplacementstartheight();
    mask = 1 | 2 | 4;
    trace = physicstrace( liftedorigin, origin + ( 0, 0, 1 ), mins, maxs, self, mask );
    
    if ( trace[ "fraction" ] < 1 )
    {
        return false;
    }
    
    size = 2.5;
    height = size * 2;
    mins = ( -1 * size, -1 * size, 0 );
    maxs = ( size, size, height );
    sweeptrace = physicstrace( self.origin + ( 0, 0, startheight ), liftedorigin, mins, maxs, self, mask );
    
    if ( sweeptrace[ "fraction" ] < 1 )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace ai_tank/ai_tank
    // Params 0
    // Checksum 0x247174c, Offset: 0x6188
    // Size: 0xb0, Type: dev
    function tank_devgui_think()
    {
        setdvar( "devgui_tank", "" );
        
        for ( ;; )
        {
            wait 0.25;
            level.ai_tank_turret_fire_rate = level.ai_tank_turret_weapon.firetime;
            
            if ( getdvarstring( "devgui_tank" ) == "routes" )
            {
                devgui_debug_route();
                setdvar( "devgui_tank", "" );
            }
        }
    }

    // Namespace ai_tank/ai_tank
    // Params 2
    // Checksum 0xce0f065b, Offset: 0x6240
    // Size: 0xa4, Type: dev
    function tank_debug_patrol( node1, node2 )
    {
        self endon( #"death" );
        self endon( #"debug_patrol" );
        
        for ( ;; )
        {
            self setvehgoalpos( node1.origin, 1 );
            self waittill( "reached_end_node" );
            wait 1;
            self setvehgoalpos( node2.origin, 1 );
            self waittill( "reached_end_node" );
            wait 1;
        }
    }

    // Namespace ai_tank/ai_tank
    // Params 0
    // Checksum 0xf6138ddd, Offset: 0x62f0
    // Size: 0x152, Type: dev
    function devgui_debug_route()
    {
        iprintln( "Choose nodes with 'A' or press 'B' to cancel" );
        nodes = dev::dev_get_node_pair();
        
        if ( !isdefined( nodes ) )
        {
            iprintln( "Route Debug Cancelled" );
            return;
        }
        
        iprintln( "Sending talons to chosen nodes" );
        tanks = getentarray( "talon", "targetname" );
        
        foreach ( tank in tanks )
        {
            tank notify( #"debug_patrol" );
            tank thread tank_debug_patrol( nodes[ 0 ], nodes[ 1 ] );
        }
    }

    // Namespace ai_tank/ai_tank
    // Params 0
    // Checksum 0xf05a898c, Offset: 0x6450
    // Size: 0x2b8, Type: dev
    function tank_debug_hud_init()
    {
        for ( host = util::gethostplayer(); !isdefined( host ) ; host = util::gethostplayer() )
        {
            wait 0.25;
        }
        
        x = 80;
        y = 40;
        level.ai_tank_bar = newclienthudelem( host );
        level.ai_tank_bar.x = x + 80;
        level.ai_tank_bar.y = y + 2;
        level.ai_tank_bar.alignx = "left";
        level.ai_tank_bar.aligny = "top";
        level.ai_tank_bar.horzalign = "fullscreen";
        level.ai_tank_bar.vertalign = "fullscreen";
        level.ai_tank_bar.alpha = 0;
        level.ai_tank_bar.foreground = 0;
        level.ai_tank_bar setshader( "black", 1, 8 );
        level.ai_tank_text = newclienthudelem( host );
        level.ai_tank_text.x = x + 80;
        level.ai_tank_text.y = y;
        level.ai_tank_text.alignx = "left";
        level.ai_tank_text.aligny = "top";
        level.ai_tank_text.horzalign = "fullscreen";
        level.ai_tank_text.vertalign = "fullscreen";
        level.ai_tank_text.alpha = 0;
        level.ai_tank_text.fontscale = 1;
        level.ai_tank_text.foreground = 1;
    }

    // Namespace ai_tank/ai_tank
    // Params 0
    // Checksum 0x18e04418, Offset: 0x6710
    // Size: 0x178, Type: dev
    function tank_debug_health()
    {
        self.damage_debug = "";
        level.ai_tank_bar.alpha = 1;
        level.ai_tank_text.alpha = 1;
        
        for ( ;; )
        {
            waitframe( 1 );
            
            if ( !isdefined( self ) || !isalive( self ) )
            {
                level.ai_tank_bar.alpha = 0;
                level.ai_tank_text.alpha = 0;
                return;
            }
            
            width = self.health / self.maxhealth * 300;
            width = int( max( width, 1 ) );
            level.ai_tank_bar setshader( "black", width, 8 );
            str = self.health + "  Last Damage: " + self.damage_debug;
            level.ai_tank_text settext( str );
        }
    }

#/
