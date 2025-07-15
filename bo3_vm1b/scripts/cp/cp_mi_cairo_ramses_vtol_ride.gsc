#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses_fx;
#using scripts/cp/cp_mi_cairo_ramses_sound;
#using scripts/cp/cp_mi_cairo_ramses_station_fight;
#using scripts/cp/cp_mi_cairo_ramses_station_walk;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace vtol_ride;

// Namespace vtol_ride
// Params 2
// Checksum 0xb1e727c8, Offset: 0x1940
// Size: 0x152
function init( str_objective, b_starting )
{
    init_event_flags();
    array::thread_all( getentarray( "ammo_cache", "script_noteworthy" ), &oed::enable_keyline, 1 );
    level._effect[ "vtol_thruster" ] = "vehicle/fx_vtol_thruster_vista";
    battlechatter::function_d9f49fba( 0, "bc" );
    spawner::add_spawn_function_group( "staging_area_jumpdirect_guy01", "targetname", &function_163908b8 );
    spawner::add_spawn_function_group( "staging_area_allies", "script_string", &staging_area_allies_spawnfunc );
    vehicle::add_spawn_function_by_type( "veh_bo3_mil_vtol", &function_b946efd6 );
    event_setup( str_objective, b_starting );
    main();
    skipto::objective_completed( "vtol_ride" );
}

// Namespace vtol_ride
// Params 0
// Checksum 0x11ae0e03, Offset: 0x1aa0
// Size: 0xda
function init_event_flags()
{
    level flag::init( "jumpdirect_loops_started" );
    level flag::init( "jumpdirect_scene_done" );
    level flag::init( "staging_area_enter_started" );
    level flag::init( "trucks_ready" );
    level flag::init( "heroes_start_truck_anims" );
    level flag::init( "player_enter_hero_truck_started" );
    level flag::init( "players_ready" );
    level flag::init( "vtol_ride_players_in_position" );
    level flag::init( "vtol_ride_temp_probe_linked" );
}

// Namespace vtol_ride
// Params 2
// Checksum 0x8ae8d7c6, Offset: 0x1b88
// Size: 0xc2
function event_setup( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level thread cp_mi_cairo_ramses_station_walk::scene_cleanup( 0 );
        exploder::exploder( "fx_exploder_vtol_crash" );
        station_fight::cleanup_scene_turret();
        level thread scene::play( "p7_fxanim_cp_ramses_lotus_towers_hunters_swarm_bundle" );
    }
    
    level thread dead_system_fx_anim();
    exploder::exploder( "fx_exploder_staging_area_mortars" );
    init_heroes( str_objective, b_starting );
    init_scenes( b_starting );
}

// Namespace vtol_ride
// Params 4
// Checksum 0x8ec5f56d, Offset: 0x1c58
// Size: 0x3a
function done( str_objective, b_starting, b_direct, player )
{
    level flag::set( "vtol_ride_done" );
}

// Namespace vtol_ride
// Params 0
// Checksum 0x48733b6d, Offset: 0x1ca0
// Size: 0x81
function main()
{
    level flag::set( "vtol_ride_event_started" );
    level.n_players_in_trucks = 0;
    level.n_current_background_vehicles = 0;
    level thread objectives();
    level thread scenes();
    level thread vo();
    staging_area();
    level notify( #"vtol_ride_event_done" );
    level.n_players_in_trucks = undefined;
    level.n_current_background_vehicles = undefined;
}

// Namespace vtol_ride
// Params 2
// Checksum 0xd799249a, Offset: 0x1d30
// Size: 0x14a
function init_heroes( str_objective, b_starting )
{
    if ( b_starting )
    {
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_khalil = util::get_hero( "khalil" );
        skipto::teleport_ai( str_objective, level.heroes );
    }
    
    level.ai_hendricks colors::disable();
    level.ai_khalil colors::disable();
    level.ai_hendricks.goalradius = 64;
    level.ai_khalil.goalradius = 64;
    level.ai_hendricks ai::set_behavior_attribute( "disablesprint", 1 );
    level.ai_hendricks ai::set_behavior_attribute( "vignette_mode", "fast" );
    level.ai_khalil ai::set_behavior_attribute( "disablesprint", 1 );
    level.ai_khalil ai::set_behavior_attribute( "vignette_mode", "fast" );
}

// Namespace vtol_ride
// Params 1
// Checksum 0x3c272e3c, Offset: 0x1e88
// Size: 0x302
function init_scenes( b_starting )
{
    if ( b_starting )
    {
        level scene::skipto_end( "p7_fxanim_cp_ramses_station_ceiling_vtol_bundle" );
        level scene::skipto_end( "p7_fxanim_cp_ramses_station_ceiling_vtol_crashed_bundle" );
        level scene::init( "p_ramses_lift_wing_blockage" );
        level thread scene::play( "cin_ram_04_02_easterncheck_vign_jumpdirect_hendricks" );
        level thread scene::play( "cin_ram_04_02_easterncheck_vign_jumpdirect_khalil" );
        level notify( #"reached_ceiling_collapse" );
        level notify( #"swap_station_interior" );
        exploder::exploder( "vtol_crash" );
        exploder::exploder( "fx_exploder_station_ambient_post_collapse" );
        exploder::exploder( "fx_exploder_dropship_hits_floor" );
        exploder::exploder( "fx_exploder_dropship_through_ceiling" );
        exploder::exploder( "fx_exploder_dropship_hits_column" );
        exploder::exploder( "fx_exploder_dropship_through_ceiling_02" );
        exploder::exploder( "fx_exploder_dropship_through_ceiling_03" );
        level thread station_fight::ceiling_lighting_swap();
        a_ceiling_piece_geo = getentarray( "station_ceiling_pristine", "targetname" );
        
        foreach ( piece in a_ceiling_piece_geo )
        {
            piece delete();
        }
        
        var_2f5160f4 = getentarray( "roof_hole_blocker", "targetname" );
        
        foreach ( e_blocker in var_2f5160f4 )
        {
            e_blocker hide();
        }
        
        level util::set_streamer_hint( 3, 1 );
        load::function_a2995f22( 1 );
        station_fight::delete_props();
        station_fight::show_props( "_combat" );
        station_fight::phys_pulse_on_structs();
        ramses_util::ambient_walk_fx_exploder();
        level flag::set( "ceiling_collapse_complete" );
        level notify( #"vtol_crash_complete" );
        level notify( #"killed_by_ceiling" );
        level thread station_fight::end_fight_ambient_dialog();
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0xf5c67930, Offset: 0x2198
// Size: 0x72
function function_b946efd6()
{
    util::wait_network_frame();
    playfxontag( level._effect[ "vtol_thruster" ], self, "tag_fx_engine_left" );
    playfxontag( level._effect[ "vtol_thruster" ], self, "tag_fx_engine_right" );
    self vehicle::toggle_sounds( 0 );
}

// Namespace vtol_ride
// Params 0
// Checksum 0xa643b965, Offset: 0x2218
// Size: 0xa2
function staging_area_allies_spawnfunc()
{
    self.goalradius = 64;
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self ai::set_behavior_attribute( "disablearrivals", 1 );
    self ai::set_behavior_attribute( "disablesprint", 1 );
    self ai::set_behavior_attribute( "vignette_mode", "slow" );
    
    if ( self.script_noteworthy === "does_walk" )
    {
        self ai::set_behavior_attribute( "patrol", 1 );
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0xc708459e, Offset: 0x22c8
// Size: 0x1da
function staging_area()
{
    level thread start_ambient_background_vtols( "staging_area_background_vtol", 3 );
    spawn_staging_area_props();
    function_719a5145();
    objectives::complete( "cp_level_ramses_protect_salim" );
    objectives::set( "cp_level_ramses_eastern_checkpoint" );
    remove_exit_blocker();
    callback::on_spawned( &tether_players_to_khalil );
    callback::on_spawned( &ramses_util::set_low_ready_movement );
    level.players tether_players_to_khalil();
    level thread ai_cleanup_boundary();
    level thread function_4e3398e0();
    spawner::simple_spawn( "staging_area_background_technical_01", &function_226410e6 );
    level flag::wait_till( "trucks_ready" );
    objectives::set( "cp_level_ramses_board" );
    trigger::wait_till( "staging_area_enter_trig" );
    level thread start_ambient_background_vtols( "staging_area_overhead_vtol", 3 );
    level flag::wait_till( "players_ready" );
    objectives::complete( "cp_level_ramses_board" );
    level notify( #"staging_area_ambient_stop" );
    level util::clientnotify( "sndLevelEnd" );
    util::screen_fade_out( 2 );
}

// Namespace vtol_ride
// Params 0
// Checksum 0x9dc925bd, Offset: 0x24b0
// Size: 0x82
function function_719a5145()
{
    level endon( #"hash_ddf95d21" );
    level thread function_d3b86c9f( 10 );
    level thread function_637a00da();
    level thread function_5813f4ec();
    level flag::wait_till( "jumpdirect_loops_started" );
    level flag::wait_till( "hendricks_jumpdirect_looping" );
    level flag::wait_till( "khalil_jumpdirect_looping" );
}

// Namespace vtol_ride
// Params 1
// Checksum 0xb1605169, Offset: 0x2540
// Size: 0x17
function function_d3b86c9f( n_timer )
{
    wait n_timer;
    level notify( #"hash_ddf95d21" );
}

// Namespace vtol_ride
// Params 0
// Checksum 0x494e949, Offset: 0x2560
// Size: 0x22
function function_637a00da()
{
    level waittill( #"hendricks_jumpdirect_looping" );
    level flag::set( "hendricks_jumpdirect_looping" );
}

// Namespace vtol_ride
// Params 0
// Checksum 0x6ccf3f1e, Offset: 0x2590
// Size: 0x22
function function_5813f4ec()
{
    level waittill( #"khalil_jumpdirect_looping" );
    level flag::set( "khalil_jumpdirect_looping" );
}

// Namespace vtol_ride
// Params 0
// Checksum 0xdd8dfa03, Offset: 0x25c0
// Size: 0xd3
function function_4e3398e0()
{
    level waittill( #"hash_585a73e3" );
    callback::remove_on_spawned( &tether_players_to_khalil );
    callback::on_spawned( &function_a10d0d8a );
    level.players stop_tether_players();
    
    foreach ( player in level.players )
    {
        player allowjump( 1 );
        player allowdoublejump( 0 );
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0x7f675d2a, Offset: 0x26a0
// Size: 0x22
function function_a10d0d8a()
{
    self allowjump( 1 );
    self allowdoublejump( 0 );
}

// Namespace vtol_ride
// Params 1
// Checksum 0xbac01413, Offset: 0x26d0
// Size: 0xab
function tether_players_to_khalil( n_min_speed )
{
    if ( !isdefined( n_min_speed ) )
    {
        n_min_speed = 0.4;
    }
    
    if ( isarray( self ) )
    {
        a_e_players = self;
    }
    else
    {
        a_e_players = array( self );
    }
    
    foreach ( e_player in a_e_players )
    {
        e_player thread function_bfaa9238( n_min_speed );
    }
}

// Namespace vtol_ride
// Params 1
// Checksum 0x95f97c22, Offset: 0x2788
// Size: 0x82
function function_bfaa9238( n_min_speed )
{
    if ( !isdefined( n_min_speed ) )
    {
        n_min_speed = 0.4;
    }
    
    self endon( #"stop_tether" );
    self endon( #"death" );
    trigger::wait_till( "trig_start_station_exit_tether", "targetname", self );
    self thread ramses_util::player_walk_speed_adjustment( level.ai_khalil, "stop_tether", 72, -112, n_min_speed, 1, 66 );
    self thread ramses_util::set_low_ready_movement();
}

// Namespace vtol_ride
// Params 0
// Checksum 0x46443344, Offset: 0x2818
// Size: 0xeb
function stop_tether_players()
{
    if ( isarray( self ) )
    {
        a_e_players = self;
    }
    else
    {
        a_e_players = array( self );
    }
    
    foreach ( e_player in a_e_players )
    {
        e_player notify( #"stop_tether" );
    }
    
    wait 0.05;
    
    foreach ( e_player in a_e_players )
    {
        e_player setmovespeedscale( 1 );
    }
}

// Namespace vtol_ride
// Params 4
// Checksum 0x21eb056a, Offset: 0x2910
// Size: 0x1f5
function ambient_wave_think( numaisperwave, spawners, minwait, maxwait )
{
    if ( !isdefined( minwait ) )
    {
        minwait = 2;
    }
    
    if ( !isdefined( maxwait ) )
    {
        maxwait = 3;
    }
    
    numaisspawned = 0;
    mingoalradius = 64;
    maxgoalradius = 96;
    
    while ( numaisspawned < numaisperwave )
    {
        ais = spawner::simple_spawn( array::random( spawners ) );
        numaisspawned++;
        
        foreach ( ai in ais )
        {
            ai.goalradius = randomintrange( mingoalradius, maxgoalradius );
            
            if ( randomint( 100 ) < 30 )
            {
                ai ai::set_behavior_attribute( "sprint", 1 );
            }
            
            if ( randomint( 100 ) < 25 )
            {
                sndent = spawn( "script_origin", ai.origin );
                sndent linkto( ai );
                sndent playloopsound( "amb_walla_battlechatter", 1 );
                ai thread snddeletesndent( sndent );
            }
        }
        
        if ( numaisspawned == 1 )
        {
            ai_talk = array::random( ais );
            
            if ( isdefined( ai_talk ) )
            {
                ai_talk thread say_runners_vo();
            }
        }
        
        wait randomintrange( minwait, maxwait );
    }
}

// Namespace vtol_ride
// Params 1
// Checksum 0xce1612c1, Offset: 0x2b10
// Size: 0x22
function snddeletesndent( sndent )
{
    self waittill( #"death" );
    sndent delete();
}

// Namespace vtol_ride
// Params 0
// Checksum 0xbaebf8d1, Offset: 0x2b40
// Size: 0x10a
function handle_staging_area_front_runners()
{
    a_sidewalk_runners_left = getentarray( "staging_area_sidewalk_guys_left", "targetname" );
    a_sidewalk_runners_right = getentarray( "staging_area_sidewalk_guys_right", "targetname" );
    numaisperwave = 4;
    waitbetweenwaves = 6;
    level thread ambient_wave_think( numaisperwave, a_sidewalk_runners_left, 3, 6 );
    level thread ambient_wave_think( numaisperwave, a_sidewalk_runners_right, 3, 6 );
    wait waitbetweenwaves;
    level flag::wait_till( "trucks_ready" );
    trigger::wait_or_timeout( waitbetweenwaves, "staging_area_enter_trig", "targetname" );
    level thread ambient_wave_think( numaisperwave, a_sidewalk_runners_left );
    level thread ambient_wave_think( numaisperwave, a_sidewalk_runners_right );
}

// Namespace vtol_ride
// Params 0
// Checksum 0x382d6480, Offset: 0x2c58
// Size: 0xd2
function handle_staging_area_left_2_right_runners()
{
    a_sidewalk_runners_left = getentarray( "staging_area_background_runners_left", "targetname" );
    a_sidewalk_runners_right = getentarray( "staging_area_background_runners_right", "targetname" );
    numaisperwave = 3;
    waitbetweenwaves = 10;
    level thread ambient_wave_think( numaisperwave, a_sidewalk_runners_left, 3, 6 );
    level thread ambient_wave_think( numaisperwave, a_sidewalk_runners_right, 3, 6 );
    wait waitbetweenwaves;
    level thread ambient_wave_think( numaisperwave, a_sidewalk_runners_left, 3, 6 );
    level thread ambient_wave_think( numaisperwave, a_sidewalk_runners_right, 3, 6 );
}

// Namespace vtol_ride
// Params 0
// Checksum 0x4953a89d, Offset: 0x2d38
// Size: 0x7a
function handle_staging_area_right_2_left_runners()
{
    a_sidewalk_runners_right = getentarray( "staging_area_background_runners2", "targetname" );
    numaisperwave = 3;
    waitbetweenwaves = 10;
    level thread ambient_wave_think( numaisperwave, a_sidewalk_runners_right, 3, 6 );
    wait waitbetweenwaves;
    level thread ambient_wave_think( numaisperwave, a_sidewalk_runners_right, 3, 6 );
}

// Namespace vtol_ride
// Params 0
// Checksum 0x892f9586, Offset: 0x2dc0
// Size: 0x115
function ambient_runners_logic()
{
    n_front_wave_limit = 36;
    
    while ( true )
    {
        if ( getaiarray().size < n_front_wave_limit )
        {
            level thread handle_staging_area_front_runners();
        }
        
        level flag::wait_till( "trucks_ready" );
        minwaittime = 7;
        maxwaittime = 11;
        wait randomintrange( minwaittime, maxwaittime );
        
        if ( getaiarray().size < n_front_wave_limit )
        {
            level thread handle_staging_area_left_2_right_runners();
        }
        
        minwaittime = 11;
        maxwaittime = 13;
        wait randomintrange( minwaittime, maxwaittime );
        
        if ( getaiarray().size < n_front_wave_limit )
        {
            level thread handle_staging_area_right_2_left_runners();
        }
        
        minwaittime = 10;
        maxwaittime = 14;
        wait randomintrange( minwaittime, maxwaittime );
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0x1c8a449, Offset: 0x2ee0
// Size: 0x172
function remove_exit_blocker()
{
    s_exit = struct::get( "ramses_station_exit_obj", "targetname" );
    t_exit = spawn( "trigger_radius_use", s_exit.origin, 0, 50, 64 );
    t_exit triggerignoreteam();
    t_exit setvisibletoall();
    t_exit setteamfortrigger( "none" );
    mdl_gameobject = util::init_interactive_gameobject( t_exit, &"cp_level_ramses_exit_station", &"CP_MI_CAIRO_RAMSES_MOVE_ASIDE", &play_station_exit_scene );
    mdl_gameobject waittill( #"hash_c2b847e5" );
    
    if ( isdefined( level.bzm_ramsesdialogue3_2callback ) )
    {
        level thread [[ level.bzm_ramsesdialogue3_2callback ]]();
    }
    
    level flag::set( "station_exit_removed" );
    e_blocker = getent( s_exit.target, "targetname" );
    e_blocker delete();
    mdl_gameobject gameobjects::disable_object();
    objectives::complete( "cp_level_ramses_exit_station" );
}

// Namespace vtol_ride
// Params 0
// Checksum 0x28bcda9e, Offset: 0x3060
// Size: 0x7d
function ai_cleanup_boundary()
{
    level endon( #"staging_area_ambient_stop" );
    t_cleanup = getent( "staging_area_ai_cleanup_aitrig", "targetname" );
    
    while ( true )
    {
        t_cleanup waittill( #"trigger", ai_cleanup );
        
        if ( isai( ai_cleanup ) )
        {
            ai_cleanup delete();
        }
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0x280bd29b, Offset: 0x30e8
// Size: 0x8b
function get_runner_group_count()
{
    n_runner_groups = 0;
    str_name = "";
    
    foreach ( sp_runner in self )
    {
        if ( str_name != sp_runner.targetname )
        {
            n_runner_groups++;
        }
        
        str_name = sp_runner.targetname;
    }
    
    return n_runner_groups;
}

// Namespace vtol_ride
// Params 1
// Checksum 0x752d37bd, Offset: 0x3180
// Size: 0xa5
function get_runner_groups( n_groups )
{
    a_runner_groups = [];
    
    for ( i = 1; i < n_groups + 1 ; i++ )
    {
        a_sp_runners = getspawnerarray( "staging_area_background_runners" + i, "targetname" );
        
        if ( !isdefined( a_runner_groups ) )
        {
            a_runner_groups = [];
        }
        else if ( !isarray( a_runner_groups ) )
        {
            a_runner_groups = array( a_runner_groups );
        }
        
        a_runner_groups[ a_runner_groups.size ] = a_sp_runners;
    }
    
    return a_runner_groups;
}

// Namespace vtol_ride
// Params 1
// Checksum 0x542714fa, Offset: 0x3230
// Size: 0x5a
function ai_move_to_node( str_node )
{
    nd_goal = getnode( str_node, "targetname" );
    self setgoal( nd_goal, 1 );
    self waittill( #"goal" );
    self clearforcedgoal();
}

// Namespace vtol_ride
// Params 0
// Checksum 0x66336ed8, Offset: 0x3298
// Size: 0xdb
function spawn_staging_area_props()
{
    a_s_prop_spots = struct::get_array( "vtol_ride_staging_area_prop_spots", "script_noteworthy" );
    
    foreach ( s in a_s_prop_spots )
    {
        m_prop = util::spawn_model( s.model, s.origin, s.angles );
        m_prop.targetname = s.targetname;
        m_prop.script_objective = "vtol_ride";
        util::wait_network_frame();
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0xbb0e6378, Offset: 0x3380
// Size: 0xba
function vtol_ride()
{
    a_t_ride = getentarray( "vtol_ride_trig", "script_noteworthy" );
    level waittill( #"trucks_start_drive_in" );
    a_t_ride init_flags( "_ready" );
    a_t_ride wait_till_flags( "_ready" );
    level flag::set( "vtol_ride_started" );
    level thread enemy_vtol_ambience();
    level flag::wait_till( "mobile_wall_fxanim_start" );
    level flag::set( "dead_turret_stop_station_ambients" );
}

// Namespace vtol_ride
// Params 0
// Checksum 0x44d09fe5, Offset: 0x3448
// Size: 0x32
function enemy_vtol_ambience()
{
    level thread left_side_vtols_shot_down();
    level thread right_side_vtols_shot_down();
    level thread ambient_egyptian_reinforcements();
}

// Namespace vtol_ride
// Params 0
// Checksum 0xe1b85520, Offset: 0x3488
// Size: 0x322
function left_side_vtols_shot_down()
{
    a_e_dead_turrets = [];
    
    foreach ( e_turret in level.a_e_all_dead_turrets )
    {
        if ( isdefined( e_turret.script_int ) && e_turret.script_int == 1 )
        {
            a_e_dead_turrets[ a_e_dead_turrets.size ] = e_turret;
        }
    }
    
    nd_spawn_amb_vtol_1 = getvehiclenode( "spawn_amb_vtol_1", "script_noteworthy" );
    nd_spawn_amb_vtol_1 waittill( #"trigger" );
    a_vtol_ride_quads = getentarray( "amb_vtol_quads", "targetname" );
    nd_crash_vtol_quad_1 = getvehiclenode( "vtol_1_crash_node", "script_noteworthy" );
    e_dead_target = util::spawn_model( "script_origin", nd_crash_vtol_quad_1.origin, nd_crash_vtol_quad_1.angles );
    e_dead_target setinvisibletoall();
    
    foreach ( e_turret in a_e_dead_turrets )
    {
        e_turret turret::set_target( e_dead_target, undefined, 0 );
    }
    
    nd_crash_vtol_quad_1 waittill( #"trigger" );
    
    foreach ( e_turret in a_e_dead_turrets )
    {
        e_turret thread turret::fire_for_time( 4, 0 );
    }
    
    nd_crash_vtol_quad_2 = getvehiclenode( "vtol_2_crash_node", "script_noteworthy" );
    e_dead_target = util::spawn_model( "script_origin", nd_crash_vtol_quad_2.origin, nd_crash_vtol_quad_2.angles );
    e_dead_target setinvisibletoall();
    
    foreach ( e_turret in a_e_dead_turrets )
    {
        e_turret turret::set_target( e_dead_target, undefined, 0 );
    }
    
    nd_crash_vtol_quad_2 waittill( #"trigger" );
    
    foreach ( e_turret in a_e_dead_turrets )
    {
        e_turret thread turret::fire_for_time( 4, 0 );
    }
    
    e_dead_target delete();
}

// Namespace vtol_ride
// Params 0
// Checksum 0xea7583e5, Offset: 0x37b8
// Size: 0x2ca
function right_side_vtols_shot_down()
{
    a_e_dead_turrets = [];
    
    foreach ( e_turret in level.a_e_all_dead_turrets )
    {
        if ( isdefined( e_turret.script_int ) && e_turret.script_int == 0 )
        {
            a_e_dead_turrets[ a_e_dead_turrets.size ] = e_turret;
        }
    }
    
    nd_amb_vtol_quad_3 = getvehiclenode( "vtol_3_crash_node", "script_noteworthy" );
    e_dead_target = util::spawn_model( "script_origin", nd_amb_vtol_quad_3.origin, nd_amb_vtol_quad_3.angles );
    e_dead_target setinvisibletoall();
    
    foreach ( e_turret in a_e_dead_turrets )
    {
        e_turret turret::set_target( e_dead_target, undefined, 0 );
    }
    
    nd_amb_vtol_quad_3 waittill( #"trigger" );
    
    foreach ( e_turret in a_e_dead_turrets )
    {
        e_turret thread turret::fire_for_time( 4, 0 );
    }
    
    nd_amb_vtol_quad_4 = getvehiclenode( "vtol_4_crash_node", "script_noteworthy" );
    e_dead_target = util::spawn_model( "script_origin", nd_amb_vtol_quad_4.origin, nd_amb_vtol_quad_4.angles );
    e_dead_target setinvisibletoall();
    
    foreach ( e_turret in a_e_dead_turrets )
    {
        e_turret turret::set_target( e_dead_target, undefined, 0 );
    }
    
    nd_amb_vtol_quad_4 waittill( #"trigger" );
    
    foreach ( e_turret in a_e_dead_turrets )
    {
        e_turret thread turret::fire_for_time( 4, 0 );
    }
    
    e_dead_target delete();
}

// Namespace vtol_ride
// Params 0
// Checksum 0x285128ff, Offset: 0x3a90
// Size: 0x213
function ambient_egyptian_reinforcements()
{
    nd_start_egypt_runners_1 = getvehiclenode( "start_egypt_runners_1", "script_noteworthy" );
    nd_start_egypt_runners_1 waittill( #"trigger" );
    nd_vtol_egyptian_runners = getentarray( "vtol_egyptian_runners_1", "targetname" );
    
    foreach ( sp_runner in nd_vtol_egyptian_runners )
    {
        ai_runner = sp_runner spawner::spawn();
        ai_runner thread run_and_delete();
    }
    
    nd_start_egypt_runners_2 = getvehiclenode( "start_egypt_runners_2", "script_noteworthy" );
    nd_start_egypt_runners_2 waittill( #"trigger" );
    nd_vtol_egyptian_runners = getentarray( "vtol_egyptian_runners_2", "targetname" );
    
    foreach ( sp_runner in nd_vtol_egyptian_runners )
    {
        ai_runner = sp_runner spawner::spawn();
        ai_runner thread run_and_delete();
    }
    
    nd_vtol_egyptian_runners = getentarray( "vtol_egyptian_runners_3", "targetname" );
    
    foreach ( sp_runner in nd_vtol_egyptian_runners )
    {
        ai_runner = sp_runner spawner::spawn();
        ai_runner thread run_and_delete();
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0x33de0737, Offset: 0x3cb0
// Size: 0x6a
function run_and_delete()
{
    self endon( #"death" );
    nd_goal = getnode( self.target, "targetname" );
    self thread ai::force_goal( nd_goal, 32, 0 );
    self waittill( #"goal" );
    wait 5;
    self delete();
}

// Namespace vtol_ride
// Params 0
// Checksum 0x8983bdd8, Offset: 0x3d28
// Size: 0x32
function objectives()
{
    level flag::wait_till( "players_ready" );
    objectives::complete( "cp_level_ramses_eastern_checkpoint" );
}

// Namespace vtol_ride
// Params 0
// Checksum 0xadc357ea, Offset: 0x3d68
// Size: 0x3b2
function scenes()
{
    level.ai_khalil flag::init( "khalil_ready" );
    level.ai_khalil flag::init( "khalil_init" );
    level clientfield::set( "staging_area_intro", 1 );
    scene::add_scene_func( "p7_fxanim_cp_ramses_wall_carry_bundle", &wall_carry_fxanim_scene_init, "init" );
    scene::add_scene_func( "cin_ram_04_01_staging_vign_finisher", &function_29d8f4e5, "done" );
    level scene::init( "p7_fxanim_cp_ramses_wall_carry_bundle" );
    util::wait_network_frame();
    level scene::init( "p7_fxanim_cp_ramses_wall_carry_02_bundle" );
    util::wait_network_frame();
    level scene::init( "p7_fxanim_cp_ramses_wall_carry_03_bundle" );
    level scene::init( "cin_ram_04_01_staging_vign_help" );
    util::wait_network_frame();
    level scene::init( "cin_ram_04_01_staging_vign_help_alt" );
    util::wait_network_frame();
    level scene::init( "cin_ram_04_01_staging_vign_logistics" );
    util::wait_network_frame();
    level scene::init( "cin_ram_04_01_staging_vign_trafficcop" );
    level scene::init( "cin_ram_04_02_easterncheck_vign_jumpdirect" );
    level thread scene::play( "staging_area_ambient_egyptians", "targetname" );
    level flag::set( "jumpdirect_loops_started" );
    play_dead_robots_looping_thread();
    level thread helipad_ambient_vtol_scenes();
    level waittill( #"staging_area_enter_ready" );
    level thread play_jumpdirect_scene();
    level flag::wait_till( "staging_area_enter_started" );
    level thread robot_execution_scene( 20 );
    level flag::wait_till_timeout( 20, "staging_area_ambient_start" );
    level thread scene::play( "p7_fxanim_cp_ramses_wall_carry_bundle" );
    level clientfield::set( "staging_area_intro", 0 );
    level thread function_d8e0d27e();
    level waittill( #"trucks_start_drive_in" );
    level thread scene::play( "cin_ram_04_01_staging_vign_help_alt" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_vtol_ride_bundle", &vtol_ride_fxanim_scene_init, "init" );
    level scene::init( "p7_fxanim_cp_ramses_vtol_ride_bundle" );
    level waittill( #"wall_lift_off" );
    level thread scene::play( "cin_ram_04_01_staging_vign_help" );
    level thread scene::play( "cin_ram_04_01_staging_vign_logistics" );
    level thread scene::play( "cin_ram_04_01_staging_vign_trafficcop" );
    wait randomfloatrange( 2, 4 );
    level thread scene::play( "p7_fxanim_cp_ramses_wall_carry_03_bundle" );
    wait 3;
    level thread ambient_runners_logic();
}

// Namespace vtol_ride
// Params 0
// Checksum 0xdfeaff11, Offset: 0x4128
// Size: 0xdb
function wall_carry_fxanim_scene_init()
{
    level.a_wall_parts = array( getent( "wall_carry_wall", "targetname" ), getent( "wall_carry_doors", "targetname" ), getent( "wall_carry_harness", "targetname" ) );
    
    foreach ( part in level.a_wall_parts )
    {
        part setdedicatedshadow( 1 );
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0xf5301495, Offset: 0x4210
// Size: 0xcb
function play_dead_robots_looping_thread()
{
    a_str_scenes = array( "cin_sgen_12_02_corvus_vign_deadpose_robot01_ontummy", "cin_sgen_12_02_corvus_vign_deadpose_robot02_onback01", "cin_sgen_12_02_corvus_vign_deadpose_robot03_onback02", "cin_sgen_12_02_corvus_vign_deadpose_robot04_onside", "cin_sgen_12_02_corvus_vign_deadpose_robot05_onwallsitting" );
    
    foreach ( str_scene in a_str_scenes )
    {
        mdl_robot = get_dead_robot_model();
        level thread scene::play( str_scene, mdl_robot );
        util::wait_network_frame();
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0xb1668db0, Offset: 0x42e8
// Size: 0x15c
function get_dead_robot_model()
{
    n_head_exists_chance = 80;
    str_robot_head = "c_nrc_robot_grunt_head";
    a_str_robot_torsoes = array( "c_nrc_robot_grunt_g_upclean", "c_nrc_robot_grunt_g_rarmoff", "c_nrc_robot_grunt_g_larmoff" );
    a_str_robot_legs = array( "c_nrc_robot_grunt_g_lowclean", "c_nrc_robot_grunt_g_blegsoff", "c_nrc_robot_grunt_g_rlegoff" );
    mdl_robot = util::spawn_model( array::random( a_str_robot_torsoes ), ( 0, 0, 0 ), ( 0, 0, 0 ) );
    str_legs = array::random( a_str_robot_legs );
    mdl_robot attach( str_legs );
    
    if ( str_legs == "c_nrc_robot_grunt_g_blegsoff" )
    {
        mdl_robot hidepart( "j_knee_ri_dam" );
    }
    else
    {
        mdl_robot attach( "c_nrc_robot_dam_1_g_llegspawn" );
    }
    
    mdl_robot attach( "c_nrc_robot_dam_1_g_rlegspawn" );
    
    if ( randomint( 100 ) < n_head_exists_chance )
    {
        mdl_robot attach( str_robot_head );
    }
    
    return mdl_robot;
}

// Namespace vtol_ride
// Params 0
// Checksum 0xbe8f02e, Offset: 0x4450
// Size: 0x122
function play_jumpdirect_scene()
{
    if ( scene::is_active( "cin_ram_04_02_easterncheck_vign_jumpdirect_hendricks" ) )
    {
        scene::stop( "cin_ram_04_02_easterncheck_vign_jumpdirect_hendricks" );
    }
    
    if ( scene::is_active( "cin_ram_04_02_easterncheck_vign_jumpdirect_khalil" ) )
    {
        scene::stop( "cin_ram_04_02_easterncheck_vign_jumpdirect_khalil" );
    }
    
    if ( !isdefined( level.ai_hendricks ) )
    {
        level.ai_hendricks = util::get_hero( "hendricks" );
    }
    
    scene::add_scene_func( "cin_ram_04_02_easterncheck_vign_jumpdirect", &function_b1758ff5, "done" );
    level thread scene::play( "cin_ram_04_02_easterncheck_vign_jumpdirect" );
    array::wait_till( array( level.ai_hendricks, level.ai_khalil ), "ready_to_move" );
    level flag::set( "jumpdirect_scene_done" );
}

// Namespace vtol_ride
// Params 1
// Checksum 0xb54529a7, Offset: 0x4580
// Size: 0x72
function function_b1758ff5( a_ents )
{
    var_edc5d3d5 = a_ents[ "staging_area_jumpdirect_guy02" ];
    wait randomintrange( 11, 12 );
    nd_path = getnode( "node_jumpdirect_guy02_path", "targetname" );
    var_edc5d3d5 ai::patrol( nd_path );
}

// Namespace vtol_ride
// Params 0
// Checksum 0xa33d8232, Offset: 0x4600
// Size: 0xaa
function function_163908b8()
{
    nd_wait = getnode( "node_jumpdirect_guy01_wait", "targetname" );
    self setgoal( nd_wait, 1 );
    level flag::wait_till( "heroes_start_truck_anims" );
    wait randomintrange( 2, 3 );
    nd_path = getnode( "node_jumpdirect_guy01_path", "targetname" );
    self ai::patrol( nd_path );
}

// Namespace vtol_ride
// Params 1
// Checksum 0x33724958, Offset: 0x46b8
// Size: 0x18a
function robot_execution_scene( n_timeout )
{
    str_scene_name = "cin_ram_04_01_staging_vign_finisher";
    a_str_robot_crawler_parts = array( "c_nrc_robot_grunt_g_blegsoff", "c_nrc_robot_grunt_head" );
    a_str_robot_crawler_parts_hide = array( "j_hip_le_dam", "j_knee_ri_dam" );
    a_str_robot_parts = array( "c_nrc_robot_grunt_g_rlegoff", "c_nrc_robot_grunt_head" );
    mdl_robot_crawler_base = util::spawn_model( "c_nrc_robot_grunt_g_upclean", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    mdl_robot_base = util::spawn_model( "c_nrc_robot_grunt_g_rarmoff", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    mdl_robot_base construct_model_from_parts( a_str_robot_parts );
    mdl_robot_crawler_base construct_model_from_parts( a_str_robot_crawler_parts, a_str_robot_crawler_parts_hide );
    a_mdl_robots[ "robot_crawler_01" ] = mdl_robot_base;
    a_mdl_robots[ "robot_crawler_02" ] = mdl_robot_crawler_base;
    level scene::init( str_scene_name, a_mdl_robots );
    level flag::wait_till_any_timeout( n_timeout, array( "staging_area_kills_start", "staging_area_ambient_start" ) );
    level scene::play( str_scene_name, a_mdl_robots );
}

// Namespace vtol_ride
// Params 1
// Checksum 0x3e90889f, Offset: 0x4850
// Size: 0x82
function function_29d8f4e5( a_ents )
{
    ai_guy = a_ents[ "staging_area_vign_finisher_guy" ];
    ai_guy setgoal( self.origin );
    wait randomintrange( 8, 10 );
    nd_path = getnode( "node_vign_finisher_path", "targetname" );
    ai_guy ai::patrol( nd_path );
}

// Namespace vtol_ride
// Params 2
// Checksum 0x8d18da56, Offset: 0x48e0
// Size: 0xdb
function construct_model_from_parts( a_str_parts, a_str_hide_tags )
{
    if ( !isdefined( a_str_hide_tags ) )
    {
        a_str_hide_tags = [];
    }
    
    foreach ( str_part in a_str_parts )
    {
        self attach( str_part );
    }
    
    foreach ( str_tag in a_str_hide_tags )
    {
        self hidepart( str_tag );
    }
}

// Namespace vtol_ride
// Params 1
// Checksum 0xe19d4c5b, Offset: 0x49c8
// Size: 0x8b
function play_station_exit_scene( e_player )
{
    str_name = "p_ramses_lift_wing_blockage";
    scene::add_scene_func( str_name, &station_exit_scene_start, "play" );
    scene::add_scene_func( str_name, &function_75f74956, "done" );
    level thread scene::play( str_name, e_player );
    self notify( #"hash_c2b847e5" );
}

// Namespace vtol_ride
// Params 1
// Checksum 0x2066abbf, Offset: 0x4a60
// Size: 0x32
function station_exit_scene_start( a_ents )
{
    level notify( #"staging_area_enter_ready" );
    level waittill( #"staging_area_exit_started" );
    level flag::set( "staging_area_enter_started" );
}

// Namespace vtol_ride
// Params 1
// Checksum 0x16f64df3, Offset: 0x4aa0
// Size: 0x1a
function function_75f74956( a_ents )
{
    util::clear_streamer_hint();
}

// Namespace vtol_ride
// Params 0
// Checksum 0x6beaa15c, Offset: 0x4ac8
// Size: 0x2a
function init_heroes_board_scene()
{
    level notify( #"hash_585a73e3" );
    level thread khalil_move_to_truck();
    hendricks_move_to_truck();
}

// Namespace vtol_ride
// Params 0
// Checksum 0xa6adae55, Offset: 0x4b00
// Size: 0x102
function hendricks_move_to_truck()
{
    level scene::play( "cin_ram_04_02_easterncheck_vign_jumpdirect_hendricks_end" );
    level.ai_hendricks ai::set_behavior_attribute( "vignette_mode", "fast" );
    level.ai_hendricks.goalradius = 64;
    level.ai_hendricks setgoal( getnode( "vtol_ride_temp_hendricks_goal", "targetname" ) );
    level.ai_hendricks ai::set_behavior_attribute( "disablearrivals", 1 );
    level.ai_hendricks waittill( #"goal" );
    level flag::set( "heroes_start_truck_anims" );
    level.ai_hendricks sethighdetail( 1 );
    level scene::play( "cin_ram_04_02_easterncheck_1st_entertruck_demo_hendricks" );
}

// Namespace vtol_ride
// Params 0
// Checksum 0x142bdb68, Offset: 0x4c10
// Size: 0x15a
function khalil_move_to_truck()
{
    level scene::play( "cin_ram_04_02_easterncheck_vign_jumpdirect_khalil_end" );
    level.ai_khalil ai::set_behavior_attribute( "vignette_mode", "fast" );
    level.ai_khalil.goalradius = 64;
    level.ai_khalil setgoal( getnode( "vtol_ride_temp_khalil_goal", "targetname" ) );
    level.ai_khalil ai::set_behavior_attribute( "disablearrivals", 1 );
    level.ai_khalil waittill( #"goal" );
    level.ai_khalil sethighdetail( 1 );
    level thread scene::init( "cin_ram_04_02_easterncheck_1st_entertruck_demo_khalil" );
    level.ai_khalil waittill( #"khalil_init" );
    level.ai_khalil flag::set( "khalil_init" );
    level.ai_khalil waittill( #"khalil_ready" );
    level.ai_khalil flag::set( "khalil_ready" );
    level thread ramses_sound::function_973b77f9();
}

// Namespace vtol_ride
// Params 3
// Checksum 0x505a73eb, Offset: 0x4d78
// Size: 0x85
function play_player_board_scene( e_player, str_tag, vh_technical )
{
    if ( str_tag == "tag_antenna1" )
    {
        vh_technical thread scene::play( "cin_ram_04_02_easterncheck_1st_entertruck_demo2", e_player );
    }
    else
    {
        vh_technical thread scene::play( "cin_ram_04_02_easterncheck_1st_entertruck_demo", e_player );
    }
    
    level flag::set( "player_enter_hero_truck_started" );
    e_player thread truck_camera_tween();
    e_player waittill( #"hash_15add06c" );
}

// Namespace vtol_ride
// Params 0
// Checksum 0xd03184fd, Offset: 0x4e08
// Size: 0x3a
function truck_camera_tween()
{
    self endon( #"disconnect" );
    n_tween = 0.85;
    self waittill( #"tween_camera" );
    self startcameratween( n_tween );
}

// Namespace vtol_ride
// Params 1
// Checksum 0x53d30e7a, Offset: 0x4e50
// Size: 0x11a
function vtol_ride_fxanim_scene_init( a_ents )
{
    a_vh_technicals = array( a_ents[ "technical_left" ], a_ents[ "technical_right" ] );
    a_str_enter_tags = array( "tag_antenna1", "tag_antenna2" );
    
    foreach ( vh_technical in a_vh_technicals )
    {
        vh_technical thread set_up_player_technical( a_str_enter_tags );
    }
    
    array::wait_till( a_vh_technicals, "ready_to_board" );
    level flag::set( "trucks_ready" );
    array::wait_till( a_vh_technicals, "seats_full" );
    level flag::set( "players_ready" );
}

// Namespace vtol_ride
// Params 1
// Checksum 0x817ae1b4, Offset: 0x4f78
// Size: 0x2fb
function set_up_player_technical( a_str_enter_tags )
{
    self give_riders();
    
    if ( self.targetname == "technical_left" )
    {
        level waittill( #"init_heroes_board_scene" );
        level thread init_heroes_board_scene();
    }
    
    self waittill( #"stopped" );
    v_origin = self gettagorigin( "tag_bumper_rear_d0" );
    v_angles = self gettagangles( "tag_bumper_rear_d0" );
    e_collision = getent( self.targetname + "_boarding_collision", "targetname" );
    e_collision moveto( v_origin, 0.05 );
    e_collision rotateto( v_angles + ( 0, 90, 0 ), 0.5 );
    wait 1;
    self notify( #"ready_to_board" );
    
    if ( self.targetname == "technical_left" )
    {
        t_ready_khalil = spawn( "trigger_radius", self.origin, 0, 666, 256 );
        t_ready_khalil waittill( #"trigger" );
        t_ready_khalil delete();
        level.ai_khalil flag::wait_till( "khalil_init" );
        level thread scene::play( "p7_fxanim_cp_ramses_wall_carry_02_bundle" );
        level thread scene::play( "cin_ram_04_02_easterncheck_1st_entertruck_demo_khalil" );
    }
    
    level.ai_khalil flag::wait_till( "khalil_ready" );
    self.n_linked = 0;
    self thread function_85aceb92( a_str_enter_tags );
    
    foreach ( str_tag in a_str_enter_tags )
    {
        v_offset = v_origin + anglestoforward( v_angles ) * 20;
        t_enter = spawn( "trigger_box_use", v_offset, 0, 36, 32, 48 );
        t_enter.angles = v_angles;
        t_enter.targetname = str_tag;
        t_enter enter_truck_think( self, a_str_enter_tags );
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0x41f9fbf0, Offset: 0x5280
// Size: 0xc1
function give_riders()
{
    a_ai_riders = [];
    a_str_rider_positions = array( "driver", "passenger1" );
    a_str_rider_spawners = array( "staging_area_rider_1", "staging_area_rider_2", "staging_area_rider_3" );
    a_str_rider_spawners = array::randomize( a_str_rider_spawners );
    
    for ( i = 0; i < a_str_rider_positions.size ; i++ )
    {
        a_ai_riders[ i ] = spawner::simple_spawn_single( a_str_rider_spawners[ i ] );
        a_ai_riders[ i ] vehicle::get_in( self, a_str_rider_positions[ i ], 1 );
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0xde1e68d7, Offset: 0x5350
// Size: 0x52
function link_light_probe()
{
    e_probe = getent( "lgt_test_probe", "targetname" );
    level flag::set( "vtol_ride_temp_probe_linked" );
    e_probe linkto( self );
}

// Namespace vtol_ride
// Params 2
// Checksum 0x2578ffae, Offset: 0x53b0
// Size: 0x5a
function enter_truck_think( vh_technical, a_str_tags )
{
    level notify( #"vtol_ride_board_objective_start" );
    self setcursorhint( "HINT_INTERACTIVE_PROMPT" );
    self triggerignoreteam();
    self fill_truck_seats( vh_technical, a_str_tags );
}

// Namespace vtol_ride
// Params 2
// Checksum 0x275ae50a, Offset: 0x5418
// Size: 0x9a
function fill_truck_seats( vh_technical, a_str_tags )
{
    e_player = self function_c61be98c( vh_technical );
    
    if ( isdefined( e_player ) && !e_player flag::get( "linked_to_truck" ) )
    {
        self link_player_to_truck( vh_technical, e_player );
        level.n_players_in_trucks++;
        vh_technical.n_linked++;
        vh_technical notify( #"player_enters_a_truck" );
        return;
    }
    
    self fill_truck_seats( vh_technical, a_str_tags );
}

// Namespace vtol_ride
// Params 1
// Checksum 0x94aad45e, Offset: 0x54c0
// Size: 0x94
function function_c61be98c( vh_technical )
{
    mdl_gameobject = util::init_interactive_gameobject( self, &"cp_prompt_entervehicle_ramses_technical", &"CP_MI_CAIRO_RAMSES_BOARD_TRUCK", &function_8ebbac0d );
    
    if ( vh_technical.targetname === "technical_right" )
    {
        mdl_gameobject thread function_543c8d72( vh_technical );
    }
    
    e_player = mdl_gameobject function_3bc165a2( vh_technical );
    mdl_gameobject gameobjects::disable_object();
    return e_player;
}

// Namespace vtol_ride
// Params 1
// Checksum 0xa1dd3995, Offset: 0x5560
// Size: 0xb5
function function_543c8d72( vh_technical )
{
    level endon( #"players_ready" );
    vh_technical endon( #"seats_full" );
    self.is_enabled = 0;
    self gameobjects::disable_object();
    
    while ( true )
    {
        if ( level.players.size <= 2 && self.is_enabled )
        {
            self.is_enabled = 0;
            self gameobjects::disable_object();
        }
        else if ( level.players.size > 2 && !self.is_enabled )
        {
            self.is_enabled = 1;
            self gameobjects::enable_object();
        }
        
        wait 0.5;
    }
}

// Namespace vtol_ride
// Params 1
// Checksum 0x897d11f3, Offset: 0x5620
// Size: 0x32
function function_8ebbac0d( e_player )
{
    self notify( #"player_boarded", e_player );
    objectives::complete( "cp_level_ramses_eastern_checkpoint", e_player );
}

// Namespace vtol_ride
// Params 1
// Checksum 0x134470de, Offset: 0x5660
// Size: 0x28
function function_3bc165a2( vh_technical )
{
    vh_technical endon( #"player_enters_a_truck" );
    self waittill( #"player_boarded", e_player );
    return e_player;
}

// Namespace vtol_ride
// Params 1
// Checksum 0xc2268ab0, Offset: 0x5690
// Size: 0x8f
function function_85aceb92( a_str_tags )
{
    while ( self.n_linked < a_str_tags.size )
    {
        if ( level.players.size == 1 && level.n_players_in_trucks >= level.players.size )
        {
            break;
        }
        else if ( level.players.size > 1 && level.n_players_in_trucks >= 1 && level.n_players_in_trucks >= level.activeplayers.size )
        {
            break;
        }
        
        wait 0.25;
    }
    
    self notify( #"seats_full" );
}

// Namespace vtol_ride
// Params 2
// Checksum 0xc86ddf29, Offset: 0x5728
// Size: 0x9e
function link_player_to_truck( vh_technical, e_player )
{
    str_tag = self.targetname;
    e_player flag::set( "linked_to_truck" );
    
    if ( vh_technical.var_a8da2af9 === 1 && level scene::is_playing( "cin_ram_04_02_easterncheck_1st_entertruck_demo" ) )
    {
        level waittill( #"hash_faa941cd" );
    }
    
    vh_technical.var_a8da2af9 = 1;
    vh_technical play_player_board_scene( e_player, str_tag, vh_technical );
    vh_technical.var_a8da2af9 = 0;
}

// Namespace vtol_ride
// Params 0
// Checksum 0xc5514443, Offset: 0x57d0
// Size: 0x5a
function function_d8e0d27e()
{
    wait 15;
    trigger::use( "trig_technical_01_go" );
    wait 5;
    spawner::simple_spawn( "staging_area_background_technical_02", &function_226410e6 );
    wait 15;
    trigger::use( "trig_technical_02_go" );
}

// Namespace vtol_ride
// Params 0
// Checksum 0xab0096d5, Offset: 0x5838
// Size: 0xfa
function function_226410e6()
{
    nd_start = getvehiclenode( self.target, "targetname" );
    
    if ( self.script_noteworthy === "staging_area_background_technical_01" )
    {
        level waittill( #"trucks_start_drive_in" );
    }
    
    self thread vehicle::get_on_and_go_path( nd_start );
    self waittill( #"reached_path_end" );
    
    foreach ( e_rider in self.riders )
    {
        e_rider delete();
    }
    
    self.delete_on_death = 1;
    self notify( #"death" );
    
    if ( !isalive( self ) )
    {
        self delete();
    }
}

// Namespace vtol_ride
// Params 2
// Checksum 0xe4c3adc2, Offset: 0x5940
// Size: 0x1b5
function start_ambient_background_vtols( str_targetname, n_max )
{
    level endon( #"staging_area_ambient_stop" );
    a_sp_vtols = getvehiclespawnerarray( str_targetname, "targetname" );
    
    while ( true )
    {
        a_sp_vtols = array::randomize( a_sp_vtols );
        
        foreach ( sp_vtol in a_sp_vtols )
        {
            if ( level.n_current_background_vehicles < n_max )
            {
                if ( isdefined( sp_vtol ) )
                {
                    if ( !( isdefined( sp_vtol.b_active ) && sp_vtol.b_active ) )
                    {
                        sp_vtol.b_active = 1;
                        vh_vtol = spawner::simple_spawn_single( sp_vtol );
                        vnd_start = getvehiclenode( sp_vtol.target, "targetname" );
                        vh_vtol vehicle::toggle_sounds( 0 );
                        sp_vtol.count++;
                        level.n_current_background_vehicles++;
                        vh_vtol playloopsound( "evt_vtol_ambient" );
                        vh_vtol thread count_background_vehicle_death( sp_vtol );
                        vh_vtol thread vehicle::get_on_and_go_path( vnd_start );
                        wait randomfloatrange( 0.4, 0.75 );
                    }
                }
                
                continue;
            }
            
            level waittill( #"background_vtol_death" );
        }
        
        wait 0.05;
    }
}

// Namespace vtol_ride
// Params 1
// Checksum 0xb09abc7d, Offset: 0x5b00
// Size: 0x3f
function count_background_vehicle_death( sp )
{
    level endon( #"staging_area_ambient_stop" );
    self waittill( #"death" );
    
    if ( isdefined( sp ) )
    {
        sp.b_active = 0;
    }
    
    level.n_current_background_vehicles--;
    level notify( #"background_vtol_death" );
}

// Namespace vtol_ride
// Params 1
// Checksum 0x85c3c476, Offset: 0x5b48
// Size: 0x2a
function delete_intro_wall( mdl_wall_01 )
{
    self waittill( #"death" );
    
    if ( isdefined( mdl_wall_01 ) )
    {
        mdl_wall_01 delete();
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0xf8f9ef8d, Offset: 0x5b80
// Size: 0x122
function helipad_ambient_vtol_scenes()
{
    level endon( #"staging_area_ambient_stop" );
    a_str_vtols = array( "helipad_liftoff_vtol_1", "helipad_liftoff_vtol_2", "helipad_liftoff_vtol_3", "helipad_liftoff_vtol_4", "helipad_liftoff_vtol_5", "helipad_liftoff_vtol_6", "helipad_liftoff_vtol_7", "helipad_liftoff_vtol_8", "helipad_liftoff_vtol_9", "helipad_liftoff_vtol_10" );
    a_vh_vtols = get_helipads_vtols( a_str_vtols );
    
    foreach ( vtol in a_vh_vtols )
    {
        vtol vehicle::toggle_sounds( 0 );
    }
    
    a_vh_vtols init_helipad_vtols();
    level flag::wait_till( "staging_area_ambient_start" );
    a_vh_vtols start_helipad_vtols();
}

// Namespace vtol_ride
// Params 1
// Checksum 0xef1f8424, Offset: 0x5cb0
// Size: 0x32
function vtol_load_scene_init( a_ents )
{
    vh_vtol = a_ents[ "crowd_vtol" ];
    vh_vtol flag::init( "loaded" );
}

// Namespace vtol_ride
// Params 1
// Checksum 0x1ef5cac3, Offset: 0x5cf0
// Size: 0x32
function vtol_load_scene_done( a_ents )
{
    vh_vtol = a_ents[ "crowd_vtol" ];
    vh_vtol flag::set( "loaded" );
}

// Namespace vtol_ride
// Params 1
// Checksum 0xbc248219, Offset: 0x5d30
// Size: 0x11d
function get_helipads_vtols( a_str_names )
{
    a_vh_vtols = [];
    
    foreach ( str_name in a_str_names )
    {
        vh_vtol = spawner::simple_spawn_single( str_name );
        
        if ( !isdefined( a_vh_vtols ) )
        {
            a_vh_vtols = [];
        }
        else if ( !isarray( a_vh_vtols ) )
        {
            a_vh_vtols = array( a_vh_vtols );
        }
        
        a_vh_vtols[ a_vh_vtols.size ] = vh_vtol;
        
        if ( isdefined( vh_vtol.script_noteworthy ) )
        {
            vh_vtol flag::init( "loaded" );
            vh_vtol util::delay( randomintrange( 10, 20 ), undefined, &flag::set, "loaded" );
        }
    }
    
    return a_vh_vtols;
}

// Namespace vtol_ride
// Params 0
// Checksum 0x644bf389, Offset: 0x5e58
// Size: 0xa7
function get_crowd_scene_vtols()
{
    a_vh_vtols = [];
    
    foreach ( vh_vtol in self )
    {
        if ( isdefined( vh_vtol.script_noteworthy ) )
        {
            if ( !isdefined( a_vh_vtols ) )
            {
                a_vh_vtols = [];
            }
            else if ( !isarray( a_vh_vtols ) )
            {
                a_vh_vtols = array( a_vh_vtols );
            }
            
            a_vh_vtols[ a_vh_vtols.size ] = vh_vtol;
        }
    }
    
    return a_vh_vtols;
}

// Namespace vtol_ride
// Params 0
// Checksum 0x88ea4e25, Offset: 0x5f08
// Size: 0x7b
function init_helipad_vtols()
{
    foreach ( vh_vtol in self )
    {
        level scene::init( vh_vtol.script_string, vh_vtol );
        util::wait_network_frame();
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0xe3b4a3b7, Offset: 0x5f90
// Size: 0x7b
function init_helipad_crowd_vtols()
{
    foreach ( vh_vtol in self )
    {
        level scene::init( vh_vtol.script_noteworthy, "targetname", vh_vtol );
        util::wait_network_frame();
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0xb624dd31, Offset: 0x6018
// Size: 0xd3
function start_helipad_vtols()
{
    level endon( #"staging_area_ambient_stop" );
    s_goal = struct::get( "helipads_vtol_goal", "targetname" );
    wait 5;
    
    foreach ( vh_vtol in self )
    {
        vh_vtol thread play_vtol_liftoff( s_goal.origin );
        vh_vtol playloopsound( "evt_vtol_ambient" );
        wait randomfloatrange( 4, 8 );
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0x2a2a679e, Offset: 0x60f8
// Size: 0xcb
function start_vtol_crowd_load_scenes()
{
    level endon( #"staging_area_ambient_stop" );
    n_timeout = 60;
    trigger::wait_or_timeout( n_timeout, "staging_area_helipads_liftoff_trig" );
    
    foreach ( vh_vtol in self )
    {
        level thread scene::play( vh_vtol.script_noteworthy, "targetname", vh_vtol );
        wait randomfloatrange( 0.56, 1.25 );
    }
}

// Namespace vtol_ride
// Params 1
// Checksum 0x662a6154, Offset: 0x61d0
// Size: 0x9a
function play_vtol_liftoff( v_goal )
{
    self endon( #"death" );
    
    if ( isdefined( self.script_noteworthy ) )
    {
        self flag::wait_till( "loaded" );
    }
    
    level scene::play( self.script_string, self );
    self setvehgoalpos( v_goal );
    self waittill( #"goal" );
    self.delete_on_death = 1;
    self notify( #"death" );
    
    if ( !isalive( self ) )
    {
        self delete();
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0x3854c8ab, Offset: 0x6278
// Size: 0x291
function dead_system_fx_anim()
{
    level flag::wait_till( "dead_turrets_initialized" );
    level.a_batteries = [];
    level.a_vh_active_battery = [];
    a_s_fxanim_hunters = struct::get_array( "ramses_station_hunters", "targetname" );
    a_s_fxanim_dropships = struct::get_array( "ramses_station_vtols", "targetname" );
    a_s_fxanim_hunters_turnaround = struct::get_array( "ramses_station_hunters_turnaround", "targetname" );
    a_s_fxanim = arraycombine( a_s_fxanim_hunters, a_s_fxanim_dropships, 0, 0 );
    
    for ( i = 1; i < 5 ; i++ )
    {
        a_vh_battery = getvehiclearray( "station_battery_" + i, "script_noteworthy" );
        assert( a_vh_battery.size == 3, "<dev string:x28>" + "<dev string:x48>" + i + "<dev string:x59>" + a_vh_battery.size + "<dev string:x5f>" + 3 + "<dev string:x73>" );
        level.a_batteries[ i ] = a_vh_battery;
    }
    
    level thread debug_increase_bullet_range();
    scene::add_scene_func( "p7_fxanim_cp_ramses_lotus_towers_hunters_09_bundle_server", &hunter_fxanim_scene_start, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_lotus_towers_hunters_10_bundle_server", &hunter_fxanim_scene_start, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_lotus_towers_vtols_01_bundle_server", &hunter_fxanim_scene_start, "play" );
    a_s_fxanim_hunters_turnaround thread play_hunter_turn_back_fxanim_scenes();
    a_s_fxanim play_hunter_fxanim_scenes();
    
    foreach ( s_fxanim in a_s_fxanim )
    {
        s_fxanim scene::stop( 1 );
    }
    
    level.a_batteries = undefined;
    level.a_vh_active_battery = undefined;
}

// Namespace vtol_ride
// Params 0
// Checksum 0xe4725fc6, Offset: 0x6518
// Size: 0x12b
function turret_futz_think()
{
    level endon( #"staging_area_ambient_stop" );
    
    while ( self.b_firing )
    {
        foreach ( e_player in level.activeplayers )
        {
            if ( distance2d( e_player getorigin(), self.origin ) <= 894 )
            {
                e_player turret_futz_enable();
                continue;
            }
            
            e_player turret_futz_enable( 0 );
        }
        
        wait 0.05;
    }
    
    foreach ( e_player in level.activeplayers )
    {
        e_player turret_futz_enable( 0 );
    }
}

// Namespace vtol_ride
// Params 1
// Checksum 0x5579018f, Offset: 0x6650
// Size: 0x32
function turret_futz_enable( b_on )
{
    if ( !isdefined( b_on ) )
    {
        b_on = 1;
    }
    
    self clientfield::set_to_player( "filter_ev_interference_toggle", b_on );
}

/#

    // Namespace vtol_ride
    // Params 1
    // Checksum 0x3853e9be, Offset: 0x6690
    // Size: 0x4d, Type: dev
    function debug_draw_futz_sphere( n_distance )
    {
        self endon( #"_stop_turret" );
        
        while ( true )
        {
            debug::debug_sphere( self.origin, n_distance, ( 1, 0, 0 ), 0.5, 1 );
            wait 0.05;
        }
    }

#/

// Namespace vtol_ride
// Params 0
// Checksum 0xc9b7d759, Offset: 0x66e8
// Size: 0xa3
function reset_dead_turrets_target_pos()
{
    level endon( #"staging_area_ambient_stop" );
    a_e_turret_fake_targets = getentarray( "battery_fake_target", "targetname" );
    
    foreach ( vh_turret in self )
    {
        vh_turret setturrettargetent( array::random( a_e_turret_fake_targets ) );
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0xef9d6e5f, Offset: 0x6798
// Size: 0x75
function play_hunter_fxanim_scenes()
{
    level endon( #"staging_area_ambient_stop" );
    level.a_vh_active_battery = array::random( level.a_batteries );
    
    while ( true )
    {
        spawn_dead_system_targets();
        array::wait_till( level.a_vh_active_battery, "_stop_turret" );
        activate_new_battery();
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0x51092d59, Offset: 0x6818
// Size: 0x65
function play_hunter_turn_back_fxanim_scenes()
{
    level endon( #"staging_area_ambient_stop" );
    
    while ( true )
    {
        s_fxanim = array::random( self );
        
        if ( !s_fxanim scene::is_playing() )
        {
            s_fxanim thread scene::play();
        }
        
        wait randomfloatrange( 2, 4 );
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0xad03e914, Offset: 0x6888
// Size: 0x71
function spawn_dead_system_targets()
{
    level endon( #"staging_area_ambient_stop" );
    
    for ( i = 0; i < 3 ; i++ )
    {
        s_fxanim = get_dead_system_target_fxanim();
        s_fxanim thread scene::play();
        wait randomfloatrange( 0.59, 1.2 );
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0x997224fd, Offset: 0x6908
// Size: 0x4f
function get_dead_system_target_fxanim()
{
    level endon( #"staging_area_ambient_stop" );
    s_fxanim = undefined;
    
    while ( true )
    {
        s_fxanim = array::random( self );
        
        if ( !s_fxanim scene::is_playing() )
        {
            break;
        }
        
        wait 0.05;
    }
    
    return s_fxanim;
}

// Namespace vtol_ride
// Params 0
// Checksum 0xa991f0a1, Offset: 0x6960
// Size: 0x69
function activate_new_battery()
{
    level endon( #"staging_area_ambient_stop" );
    vh_last_active = level.a_vh_active_battery[ 0 ];
    level.a_vh_active_battery reset_dead_turrets_target_pos();
    
    do
    {
        level.a_vh_active_battery = array::random( level.a_batteries );
        wait 0.05;
    }
    while ( level.a_vh_active_battery[ 0 ] == vh_last_active );
}

// Namespace vtol_ride
// Params 1
// Checksum 0x68678485, Offset: 0x69d8
// Size: 0x73
function hunter_fxanim_scene_start( a_ents )
{
    level endon( #"staging_area_ambient_stop" );
    
    foreach ( mdl_target in a_ents )
    {
        mdl_target thread dead_system_assign_target();
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0xde1f6eb8, Offset: 0x6a58
// Size: 0x85
function dead_system_assign_target()
{
    level endon( #"staging_area_ambient_stop" );
    
    foreach ( vh_turret in level.a_vh_active_battery )
    {
        if ( !( isdefined( vh_turret.b_firing ) && vh_turret.b_firing ) )
        {
            vh_turret dead_turret_fire_at_target( self );
            break;
        }
    }
}

// Namespace vtol_ride
// Params 1
// Checksum 0x161b5a12, Offset: 0x6ae8
// Size: 0xb2
function dead_turret_fire_at_target( mdl_target )
{
    level endon( #"staging_area_ambient_stop" );
    self.b_firing = 1;
    self setturrettargetent( mdl_target );
    self thread fire_dead_turret( mdl_target );
    mdl_target util::waittill_either( "hunter_explodes", "vtol_01_explodes" );
    wait randomfloatrange( 0.15, 0.45 );
    self notify( #"_stop_turret" );
    self clearturrettarget();
    self laseroff();
    self.b_firing = 0;
}

// Namespace vtol_ride
// Params 1
// Checksum 0x44143ca7, Offset: 0x6ba8
// Size: 0x39
function can_dead_turret_see( mdl_target )
{
    return sighttracepassed( self gettagorigin( "tag_flash" ), mdl_target.origin, 0, self );
}

// Namespace vtol_ride
// Params 1
// Checksum 0x50e5fe33, Offset: 0x6bf0
// Size: 0xf2
function fire_dead_turret( mdl_target )
{
    self endon( #"death" );
    self endon( #"_stop_turret" );
    mdl_target endon( #"death" );
    self waittill( #"turret_on_target" );
    wait randomfloatrange( 2, 4 );
    
    if ( mdl_target.targetname == "lotus_dropships" )
    {
        wait randomfloatrange( 0.05, 0.25 );
    }
    else
    {
        wait randomfloatrange( 1, 2 );
    }
    
    while ( !self can_dead_turret_see( mdl_target ) )
    {
        wait 0.05;
    }
    
    self laseron();
    
    if ( self.script_string === "do_futz" )
    {
        self thread turret_futz_think();
    }
    
    self turret::fire_for_time( 100 );
}

// Namespace vtol_ride
// Params 0
// Checksum 0x419a4fd4, Offset: 0x6cf0
// Size: 0x72
function debug_increase_bullet_range()
{
    n_bullet_range = getdvarint( "bulletrange" );
    setdvar( "bulletrange", 65000 );
    level flag::wait_till( "dead_turret_stop_station_ambients" );
    setdvar( "bulletrange", n_bullet_range );
}

// Namespace vtol_ride
// Params 0
// Checksum 0xf7eda1de, Offset: 0x6d70
// Size: 0xb2
function vo()
{
    level flag::wait_till( "jumpdirect_scene_done" );
    level.ai_khalil dialog::say( "khal_we_have_to_hurry_0", randomfloatrange( 0.1, 0.25 ) );
    level.ai_khalil flag::wait_till( "khalil_ready" );
    wait 1;
    level.ai_khalil thread do_nag( "khal_get_in_0", 6, 9, "players_ready", "cin_ram_04_02_easterncheck_1st_entertruck_demo", 1 );
}

// Namespace vtol_ride
// Params 6
// Checksum 0x56b9a8e4, Offset: 0x6e30
// Size: 0xa5
function do_nag( str_nag, n_time_min, n_time_max, str_ender, str_scene, n_count_max )
{
    if ( !isdefined( n_count_max ) )
    {
        n_count_max = 1;
    }
    
    level endon( str_ender );
    n_count = 0;
    
    while ( n_count_max > n_count )
    {
        if ( !isdefined( str_scene ) || !level scene::is_playing( str_scene ) )
        {
            self dialog::say( str_nag );
            n_count++;
        }
        
        wait randomfloatrange( n_time_min, n_time_max );
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0x79719b74, Offset: 0x6ee0
// Size: 0x32
function say_runners_vo()
{
    self dialog::say( "esl1_let_s_move_let_s_mo_0", randomfloatrange( 4, 6 ) );
}

// Namespace vtol_ride
// Params 1
// Checksum 0xed6a77a7, Offset: 0x6f20
// Size: 0x49
function init_flags( str )
{
    for ( i = 0; i < self.size ; i++ )
    {
        level flag::init( self[ i ].targetname + str );
    }
}

// Namespace vtol_ride
// Params 1
// Checksum 0x1a93b456, Offset: 0x6f78
// Size: 0x49
function wait_till_flags( str )
{
    for ( i = 0; i < self.size ; i++ )
    {
        level flag::wait_till( self[ i ].targetname + str );
    }
}

// Namespace vtol_ride
// Params 0
// Checksum 0x7ebe1b29, Offset: 0x6fd0
// Size: 0x72
function egg()
{
    a_t_pylons = getentarray( "temp_egg_trig", "targetname" );
    t_cancel = getentarray( "temp_egg_cancel_trig", "targetname" );
    array::thread_all( a_t_pylons, &track_pylon_jumps, t_cancel );
}

// Namespace vtol_ride
// Params 2
// Checksum 0xc82b1f38, Offset: 0x7050
// Size: 0x31
function track_pylon_jumps( a_t_pylons, t_cancel )
{
    while ( !level flag::get( "players_ready" ) )
    {
    }
}

