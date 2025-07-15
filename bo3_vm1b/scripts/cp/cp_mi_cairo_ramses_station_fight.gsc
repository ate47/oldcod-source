#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses_accolades;
#using scripts/cp/cp_mi_cairo_ramses_fx;
#using scripts/cp/cp_mi_cairo_ramses_level_start;
#using scripts/cp/cp_mi_cairo_ramses_nasser_interview;
#using scripts/cp/cp_mi_cairo_ramses_sound;
#using scripts/cp/cp_mi_cairo_ramses_station_walk;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/cp_mi_cairo_ramses_vtol_ride;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_raps;

#namespace station_fight;

// Namespace station_fight
// Params 2
// Checksum 0x79acf226, Offset: 0x1760
// Size: 0x4ca
function init( str_objective, b_starting )
{
    callback::remove_on_spawned( &level_start::setup_players_for_station_walk );
    spawner::add_spawn_function_group( "station_fight_scene_robot", "script_noteworthy", &entry_anim_spawnfunc );
    spawner::add_spawn_function_group( "station_fight_balcony_turret_steal_robot", "targetname", &robot_turret_spawnfunc );
    spawner::add_spawn_function_group( "balcony_station_fight_ai", "script_noteworthy", &ramses_util::magic_bullet_shield_till_notify, "end_balcony_shields", 1 );
    spawner::add_spawn_function_group( "balcony_robot_ai", "script_string", &function_23c641de );
    spawner::add_spawn_function_group( "right_side_station_fight_ai", "script_noteworthy", &ramses_util::magic_bullet_shield_till_notify, "player_is_close", 1 );
    spawner::add_spawn_function_group( "right_side_station_fight_ai", "script_noteworthy", &function_157bd88d );
    spawner::add_spawn_function_group( "rap_drive_to_point_explode", "script_noteworthy", &drive_to_point_then_explode );
    spawner::add_spawn_function_group( "station_fight_raps_jump_raps", "targetname", &raps_jump_spawnfunc );
    spawner::add_spawn_function_group( "actor_spawner_enemy_dps_robot_assault_ar", "classname", &resolve_melee_with_mbs );
    spawner::add_spawn_function_group( "actor_spawner_enemy_dps_robot_cqb_shotgun", "classname", &resolve_melee_with_mbs );
    spawner::add_spawn_function_group( "actor_spawner_enemy_dps_robot_suppressor_ar", "classname", &resolve_melee_with_mbs );
    spawner::add_spawn_function_group( "actor_spawner_enemy_dps_robot_suppressor_mg", "classname", &resolve_melee_with_mbs );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level cp_mi_cairo_ramses_station_walk::scene_cleanup( 0 );
        level thread intermediate_prop_state_show();
        level thread ramses_util::ambient_walk_fx_exploder();
        level scene::init( "cin_ram_03_01_defend_1st_rapsintro" );
        level thread function_91e74b85();
        level util::set_streamer_hint( 2, 1 );
    }
    else
    {
        level thread util::set_streamer_hint( 2, 1 );
    }
    
    level.nd_khalil = getnode( "khalil_station_fight_start_node", "targetname" );
    setenablenode( level.nd_khalil, 0 );
    function_dfedb0b8( str_objective, b_starting );
    
    if ( scene::is_playing( "cin_ram_02_04_interview_part04" ) )
    {
        scene::stop( "cin_ram_02_04_interview_part04" );
    }
    
    if ( isdefined( level.bzm_ramsesdialogue3callback ) )
    {
        level thread [[ level.bzm_ramsesdialogue3callback ]]();
    }
    
    level thread scene::play( "cin_ram_02_04_interview_part04_end_loops" );
    
    foreach ( e_player in level.players )
    {
        e_player thread level_start::setup_players_for_station_fight();
    }
    
    level thread scene::play( "p7_fxanim_cp_ramses_lotus_towers_hunters_swarm_bundle" );
    ramses_accolades::function_6f52c808();
    ramses_accolades::function_7f657f7a();
    ramses_accolades::function_fec73937();
    ramses_accolades::function_a17fa88e();
    battlechatter::function_d9f49fba( 1, "bc" );
    main( b_starting );
    skipto::objective_completed( "defend_ramses_station" );
}

// Namespace station_fight
// Params 4
// Checksum 0x2531ca69, Offset: 0x1c38
// Size: 0x52
function done( str_objective, b_starting, b_direct, player )
{
    ramses_accolades::function_b13b2dae();
    ramses_accolades::tank_handleairburst();
    ramses_accolades::function_6d6e6d0d();
}

// Namespace station_fight
// Params 1
// Checksum 0x6e32e77b, Offset: 0x1c98
// Size: 0xe2
function main( b_starting )
{
    if ( b_starting )
    {
        load::function_a2995f22( 1 );
        array::thread_all( getentarray( "ammo_cache", "script_noteworthy" ), &oed::disable_keyline );
    }
    
    util::wait_network_frame();
    level thread snd_notifies();
    level thread allies_think();
    level thread progression_scenes();
    clientfield::set( "hide_station_miscmodels", 0 );
    clientfield::set( "delete_fxanim_fans", 1 );
    station_fight();
}

// Namespace station_fight
// Params 0
// Checksum 0xaa09aa40, Offset: 0x1d88
// Size: 0x3a
function snd_notifies()
{
    wait 0.05;
    level util::clientnotify( "hosp_amb" );
    level util::clientnotify( "inv" );
}

// Namespace station_fight
// Params 0
// Checksum 0xe1c2f960, Offset: 0x1dd0
// Size: 0x4a
function entry_anim_spawnfunc()
{
    assert( isdefined( self.script_string ), "<dev string:x28>" + self.origin + "<dev string:x2f>" );
    self scene::play( self.script_string, self );
}

// Namespace station_fight
// Params 0
// Checksum 0x91f5dba7, Offset: 0x1e28
// Size: 0x8a
function _fake_launch()
{
    self endon( #"death" );
    s_start = struct::get( self.target, "targetname" );
    m_raps = spawn( "script_model", s_start.origin );
    m_raps setmodel( "veh_t7_drone_raps" );
    self _drop( s_start, m_raps );
}

// Namespace station_fight
// Params 2
// Checksum 0xaf88b9b4, Offset: 0x1ec0
// Size: 0xf2
function _drop( s_start, m_raps )
{
    self endon( #"death" );
    a_s_ends = struct::get_array( s_start.target, "targetname" );
    s_end = a_s_ends[ randomint( a_s_ends.size ) ];
    m_raps.origin = s_start.origin;
    m_raps.angles = s_start.angles;
    m_raps moveto( s_end.origin, 1.1 );
    m_raps waittill( #"movedone" );
    self.origin = m_raps.origin;
    self.angles = m_raps.angles;
    m_raps delete();
}

// Namespace station_fight
// Params 0
// Checksum 0x6455c973, Offset: 0x1fc0
// Size: 0x132
function drive_to_point_then_explode()
{
    self endon( #"death" );
    
    if ( isdefined( self.target ) )
    {
        v_goal = struct::get( self.target, "targetname" ).origin;
    }
    else
    {
        self setgoal( level.activeplayers[ 0 ] );
        return;
    }
    
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self vehicle_ai::start_scripted();
    self setneargoalnotifydist( -128 );
    self setvehgoalpos( v_goal, 0, 1 );
    self util::waittill_any_timeout( 5, "goal", "near_goal", "force_goal", "change_state" );
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    self clearvehgoalpos();
    self vehicle_ai::stop_scripted( "combat" );
}

// Namespace station_fight
// Params 0
// Checksum 0x9daf4d9d, Offset: 0x2100
// Size: 0xda
function raps_jump_spawnfunc()
{
    self endon( #"death" );
    self ai::set_ignoreme( 1 );
    self.settings.detonation_distance = 32;
    self.settings.jump_chance = 1;
    
    if ( isdefined( self.target ) )
    {
        vnd_start = getvehiclenode( self.target, "targetname" );
        self vehicle::get_on_and_go_path( vnd_start );
    }
    else if ( isdefined( self.script_int ) )
    {
        self _launch( 80 );
    }
    
    self vehicle_ai::stop_scripted( "combat" );
    self ai::set_ignoreme( 0 );
}

// Namespace station_fight
// Params 1
// Checksum 0x9d696fde, Offset: 0x21e8
// Size: 0xb2
function _launch( n_scale )
{
    self endon( #"death" );
    v_direction = anglestoforward( self.angles );
    v_force = v_direction * n_scale;
    self.is_jumping = 1;
    self launchvehicle( v_force, self.origin + ( 0, 0, -4 ) );
    assert( isdefined( self.script_int ), "<dev string:x76>" + self.origin + "<dev string:x87>" );
    wait self.script_int;
    self.is_jumping = 0;
}

// Namespace station_fight
// Params 0
// Checksum 0x9368a703, Offset: 0x22a8
// Size: 0x92
function robot_turret_spawnfunc()
{
    self.goalradius = 96;
    vh_turret = getvehiclearray( "station_capture_turret", "script_noteworthy" );
    vh_turret = vh_turret[ 0 ];
    self endon( #"death" );
    self setgoal( vh_turret.origin, 1 );
    self waittill( #"goal" );
    vh_turret thread captured_turret_think( self );
    self robot_turret_gunner_think( vh_turret );
}

// Namespace station_fight
// Params 1
// Checksum 0x4626d84b, Offset: 0x2348
// Size: 0x52
function captured_turret_think( ai_gunner )
{
    self endon( #"death" );
    self.team = "axis";
    ai_gunner waittill( #"death" );
    ai_gunner unlink();
    self.team = "allies";
}

// Namespace station_fight
// Params 1
// Checksum 0x77066e2e, Offset: 0x23a8
// Size: 0xfa
function robot_turret_gunner_think( vh_turret )
{
    self endon( #"death" );
    t_enemy_balcony_goal = getent( "station_fight_enemy_balcony_goaltrig", "targetname" );
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self forceteleport( vh_turret.origin, vh_turret.angles, 1 );
    self linkto( vh_turret );
    vh_turret waittill( #"death" );
    self clearforcedgoal();
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
    self unlink();
    self.goalradius = 1024;
    self setgoal( t_enemy_balcony_goal );
}

// Namespace station_fight
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x24b0
// Size: 0x2
function robot_turret_gunner_death()
{
    
}

// Namespace station_fight
// Params 2
// Checksum 0x7b44a075, Offset: 0x24c0
// Size: 0x12a
function function_dfedb0b8( str_objective, b_starting )
{
    level.ai_hendricks = util::get_hero( "hendricks" );
    level.ai_khalil = util::get_hero( "khalil" );
    level.ai_rachel = util::get_hero( "rachel" );
    level.ai_hendricks ai::set_ignoreall( 1 );
    level.ai_rachel ai::set_ignoreall( 1 );
    level.ai_rachel ai::set_ignoreme( 1 );
    level.ai_hendricks.goalradius = 32;
    level.ai_khalil.goalradius = 32;
    level.ai_rachel.goalradius = 32;
    level.ai_hendricks setgoal( level.ai_hendricks.origin );
    
    if ( b_starting )
    {
        setup_heros_start_positions();
    }
}

// Namespace station_fight
// Params 0
// Checksum 0xccbb4a6a, Offset: 0x25f8
// Size: 0xaa
function setup_heros_start_positions()
{
    s_hendricks = struct::get( "defend_ramses_station_hendricks_start_spot", "targetname" );
    s_khalil = struct::get( "defend_ramses_station_khalil_start_spot", "targetname" );
    level.ai_hendricks forceteleport( s_hendricks.origin, s_hendricks.angles, 1 );
    level.ai_khalil forceteleport( s_khalil.origin, s_khalil.angles, 1 );
}

// Namespace station_fight
// Params 0
// Checksum 0xb919b189, Offset: 0x26b0
// Size: 0x4a
function init_turrets()
{
    a_vh_turrets = getentarray( "station_fight_turret", "targetname" );
    array::thread_all( a_vh_turrets, &_turret_enable_think );
}

// Namespace station_fight
// Params 0
// Checksum 0x42034881, Offset: 0x2708
// Size: 0xb2
function _turret_enable_think()
{
    s_obj = struct::get( self.script_string, "targetname" );
    t_obj = spawn( "trigger_radius", self.origin, 0, s_obj.radius, -128 );
    t_obj.script_objective = "vtol_ride";
    e_turret = self;
    self thread ramses_util::turret_pickup_think( s_obj );
    level waittill( #"vtol_crash_complete" );
    e_turret turret_objective( s_obj, t_obj );
}

// Namespace station_fight
// Params 2
// Checksum 0x324e3dad, Offset: 0x27c8
// Size: 0xcc
function _enable_scene_turret( s_obj, t_obj )
{
    vh_turret = getent( "station_fight_turret_respawn", "targetname" );
    vh_turret.team = "allies";
    m_turret = util::spawn_model( self.model, self.origin, self.angles );
    self.delete_on_death = 1;
    self notify( #"death" );
    
    if ( !isalive( self ) )
    {
        self delete();
    }
    
    vh_turret thread _respawn_scene_turret( m_turret, s_obj, t_obj );
    return m_turret;
}

// Namespace station_fight
// Params 3
// Checksum 0xdbdce7ce, Offset: 0x28a0
// Size: 0xb2
function _respawn_scene_turret( m_turret, s_obj, t_obj )
{
    level endon( #"mobile_wall_fxanim_start" );
    level flag::wait_till( "station_fight_body_pull_scene_completed" );
    self.origin = m_turret.origin;
    self.angles = m_turret.angles;
    m_turret delete();
    self thread ramses_util::turret_pickup_think( s_obj );
    
    if ( !level flag::get( "station_fight_completed" ) )
    {
        self thread turret_objective( s_obj, t_obj );
    }
}

// Namespace station_fight
// Params 0
// Checksum 0xc51f592a, Offset: 0x2960
// Size: 0x4a2
function station_fight()
{
    e_sm_center_raps = getent( "station_fight_raps_jump", "targetname" );
    e_sm_center_raps ramses_util::scale_spawn_manager_by_player_count( 2, 1 );
    spawn_manager::enable( "sm_initial_balcony_spawn" );
    spawn_manager::enable( "sm_balcony_robots" );
    level thread ramses_util::staged_battle_outcomes( "sm_balcony_robots", "sm_initial_balcony_spawn" );
    level waittill( #"hash_3e9d30d3" );
    spawn_manager::enable( "sm_initial_recovery_right_spawn" );
    level thread spawner::simple_spawn( "custom_raps" );
    level waittill( #"raps_intro_done" );
    util::clear_streamer_hint();
    trigger::wait_or_timeout( 20, "trigger_ceiling_collapse" );
    level notify( #"reached_ceiling_collapse" );
    level thread spawn_in_drop_pod_robots();
    spawn_manager::enable( "station_fight_raps_jump" );
    wait 3;
    spawn_manager::enable( "sm_ceiling_fight_server_robots" );
    spawn_manager::enable( "sm_server_fights_ceiling_ally" );
    level thread ramses_util::staged_battle_outcomes( "sm_ceiling_fight_server_robots", "sm_server_fights_ceiling_ally" );
    wait 3;
    level thread spawn_station_phalanx();
    util::wait_network_frame();
    level thread spawn_station_right_phalanx();
    util::wait_network_frame();
    level thread function_e59f097a();
    util::wait_network_frame();
    spawn_manager::enable( "sm_right_across_gap_human" );
    level thread track_gap_soldiers_dead( "sm_right_across_gap_human" );
    level thread track_right_robot_phalanx_dead( "sm_right_across_gap_human" );
    wait 10;
    spawn_manager::enable( "sm_rap_trickle" );
    function_917e4a1b();
    spawn_manager::wait_till_cleared( "station_fight_wave1_robots_left" );
    spawn_manager::wait_till_cleared( "station_fight_wave1_robots_right" );
    spawn_manager::wait_till_cleared( "sm_ceiling_fight_server_robots" );
    spawn_manager::wait_till_cleared( "station_fight_raps_jump" );
    spawn_manager::wait_till_cleared( "sm_balcony_robots" );
    level flag::wait_till( "station_phalanx_dead" );
    level flag::wait_till( "station_right_phalanx_dead" );
    level flag::wait_till( "station_center_phalanx_dead" );
    
    if ( !level flag::get( "drop_pod_opened_and_spawned" ) )
    {
        trigger::use( "trig_open_pod", "targetname" );
        wait 1;
    }
    
    level spawner::waittill_ai_group_cleared( "droppod_ai" );
    var_262d783a = spawn_manager::get_ai( "sm_rap_trickle" );
    spawn_manager::kill( "sm_rap_trickle" );
    
    foreach ( ai_rap in var_262d783a )
    {
        ai_rap raps::detonate();
    }
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    level flag::set( "station_fight_completed" );
    
    if ( isdefined( level.bzm_ramsesdialogue3_1callback ) )
    {
        level thread [[ level.bzm_ramsesdialogue3_1callback ]]();
    }
    
    battlechatter::function_d9f49fba( 0, "bc" );
    objectives::complete( "cp_level_ramses_defend_station" );
    level thread util::set_streamer_hint( 3 );
    level thread function_52111922();
    end_fight_dialog();
    level thread end_fight_ambient_dialog();
}

// Namespace station_fight
// Params 0
// Checksum 0xebe836f0, Offset: 0x2e10
// Size: 0x1a2
function function_91e74b85()
{
    level flag::wait_till( "all_players_connected" );
    level flag::init( "station_fight_started" );
    spawner::add_spawn_function_group( "initial_station_fight_ai", "script_noteworthy", &function_d0f8bc28, "station_fight_started" );
    spawner::add_spawn_function_group( "initial_station_fight_ai", "script_noteworthy", &ramses_util::magic_bullet_shield_till_notify, "ceiling_collapse_complete", 1 );
    spawn_manager::enable( "station_fight_wave1_robots_left" );
    spawn_manager::enable( "sm_initial_arch_spawn_left" );
    spawn_manager::enable( "station_fight_wave1_robots_right" );
    spawn_manager::enable( "sm_initial_arch_spawn_right" );
    spawn_manager::enable( "sm_initial_recovery_left_spawn" );
    level thread function_97cdc17e();
    level flag::wait_till( "station_fight_started" );
    level thread ramses_util::staged_battle_outcomes( "station_fight_wave1_robots_left", "sm_initial_arch_spawn_left" );
    level thread ramses_util::staged_battle_outcomes( "station_fight_wave1_robots_right", "sm_initial_arch_spawn_right" );
    level thread ai_at_arch_magic_bullet_shield_removal( "sm_initial_arch_spawn_right", "sm_initial_arch_spawn_left" );
}

// Namespace station_fight
// Params 1
// Checksum 0xca51b2a, Offset: 0x2fc0
// Size: 0x122
function function_d0f8bc28( str_flag )
{
    self endon( #"death" );
    
    if ( isdefined( self.target ) )
    {
        e_goal = getent( self.target, "targetname" );
        
        if ( !isdefined( e_goal ) )
        {
            nd_goal = getnode( self.target, "targetname" );
        }
    }
    
    self setgoal( self.origin, 0, 32 );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    level flag::wait_till( str_flag );
    
    if ( isdefined( e_goal ) )
    {
        self setgoal( e_goal );
    }
    else if ( isdefined( nd_goal ) )
    {
        self setgoal( nd_goal );
    }
    else
    {
        self.goalradius = 512;
    }
    
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
}

// Namespace station_fight
// Params 0
// Checksum 0xfd798f6c, Offset: 0x30f0
// Size: 0x139
function function_52111922()
{
    a_allies = getaiteamarray( "allies" );
    var_3f8fb967 = array::exclude( a_allies, level.heroes );
    var_3f8fb967 = array::remove_dead( var_3f8fb967 );
    var_1d1c81b8 = getnodearray( "station_fight_end_patrol", "targetname" );
    
    if ( var_1d1c81b8.size > var_3f8fb967.size )
    {
        for ( i = 0; i < var_3f8fb967.size ; i++ )
        {
            var_3f8fb967[ i ].goalradius = 32;
            var_3f8fb967[ i ] ai::set_ignoreall( 1 );
            var_3f8fb967[ i ] ai::set_behavior_attribute( "patrol", 1 );
            var_3f8fb967[ i ] ai::set_behavior_attribute( "disablearrivals", 1 );
            var_3f8fb967[ i ] setgoal( var_1d1c81b8[ i ], 1 );
            wait randomfloatrange( 0.25, 1 );
        }
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x84bf8ac5, Offset: 0x3238
// Size: 0x93
function function_917e4a1b()
{
    do
    {
        wait 0.5;
        a_enemies = getaiteamarray( "axis" );
    }
    while ( a_enemies.size > 3 );
    
    foreach ( ai in a_enemies )
    {
        ai thread function_d02622d1();
    }
}

// Namespace station_fight
// Params 0
// Checksum 0xad9f245d, Offset: 0x32d8
// Size: 0xf2
function function_d02622d1()
{
    self endon( #"death" );
    
    do
    {
        foreach ( player in level.activeplayers )
        {
            if ( !player util::is_player_looking_at( self.origin ) && distance( self.origin, util::get_closest_player( self.origin, "allies" ).origin ) > -56 )
            {
                var_d8c90b1a = 1;
            }
            
            wait 0.05;
        }
    }
    while ( !isdefined( var_d8c90b1a ) );
    
    self util::stop_magic_bullet_shield();
    self kill();
}

// Namespace station_fight
// Params 0
// Checksum 0x1a282926, Offset: 0x33d8
// Size: 0x53
function function_157bd88d()
{
    self endon( #"death" );
    
    if ( self.targetname == "right_across_gap_human" )
    {
        level flag::wait_till( "player_right_side_gap" );
    }
    else
    {
        level flag::wait_till( "player_right_side" );
    }
    
    self notify( #"player_is_close" );
}

// Namespace station_fight
// Params 0
// Checksum 0xe5a35920, Offset: 0x3438
// Size: 0x53
function function_23c641de()
{
    self endon( #"death" );
    
    while ( isdefined( level.ai_khalil ) && distance( self.origin, level.ai_khalil.origin ) > -128 )
    {
        wait 0.25;
    }
    
    self notify( #"end_balcony_shields" );
}

// Namespace station_fight
// Params 0
// Checksum 0x3bc7cc57, Offset: 0x3498
// Size: 0x9b
function resolve_melee_with_mbs()
{
    self endon( #"death" );
    level flag::wait_till( "ceiling_collapse_complete" );
    
    while ( true )
    {
        self waittill( #"failed_melee_mbs", e_target );
        
        if ( e_target == level.ai_khalil || e_target == level.ai_hendricks )
        {
            self notify( #"ram_kill_mb" );
            continue;
        }
        
        if ( e_target != level.ai_khalil && e_target != level.ai_hendricks && !isplayer( e_target ) )
        {
            e_target notify( #"ram_kill_mb" );
        }
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x567d2bcb, Offset: 0x3540
// Size: 0x172
function robotintro_handler()
{
    spawner::add_spawn_function_group( "robot_intro_robot", "targetname", &ai::set_ignoreme, 1 );
    spawner::add_spawn_function_group( "robot_intro_robot", "targetname", &util::magic_bullet_shield );
    level scene::init( "cin_ram_03_02_defend_vign_robotintro" );
    trigger::wait_till( "trig_robot_intro_vignette" );
    e_robot = getent( "robot_intro_robot_ai", "targetname" );
    e_soldier = getent( "robot_intro_guy_ai", "targetname" );
    e_robot util::stop_magic_bullet_shield();
    level thread scene::play( "cin_ram_03_02_defend_vign_robotintro" );
    e_robot thread function_ad9d7c7a( e_soldier );
    level util::waittill_notify_or_timeout( "cin_ram_03_02_defend_vign_robotintro_done", 7 );
    
    if ( isalive( e_robot ) )
    {
        e_robot ai::set_behavior_attribute( "move_mode", "rusher" );
        e_robot ai::set_ignoreme( 0 );
    }
}

// Namespace station_fight
// Params 1
// Checksum 0xf6b12fc7, Offset: 0x36c0
// Size: 0x7a
function function_ad9d7c7a( e_soldier )
{
    level endon( #"cin_ram_03_02_defend_vign_robotintro_done" );
    self waittill( #"death" );
    scene::stop( "cin_ram_03_02_defend_vign_robotintro" );
    
    if ( isalive( e_soldier ) )
    {
        e_soldier startragdoll();
        e_soldier util::stop_magic_bullet_shield();
        e_soldier kill();
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x5f999d3f, Offset: 0x3748
// Size: 0xf2
function spawn_in_drop_pod_robots()
{
    trigger::wait_till( "trig_open_pod", "targetname" );
    savegame::checkpoint_save();
    level thread scene::play( "p7_fxanim_cp_ramses_station_ceiling_vtol_bundle" );
    level flag::set( "drop_pod_opened_and_spawned" );
    level thread spawn_robots_in_pod();
    e_vtol = getent( "station_ceiling_troopcarrier", "targetname" );
    e_vtol connectpaths();
    wait 0.2;
    e_vtol_cutter = getent( "vtol_navmesh_cutter", "targetname" );
    e_vtol_cutter disconnectpaths();
    wait 0.5;
}

// Namespace station_fight
// Params 0
// Checksum 0xb0a90e6e, Offset: 0x3848
// Size: 0x152
function spawn_station_phalanx()
{
    level flag::init( "station_phalanx_dead" );
    v_start_position = struct::get( "station_phalanx_start", "targetname" ).origin;
    var_e2ea1b3f = struct::get( "station_phalanx_end", "targetname" ).origin;
    
    if ( level.players.size == 1 )
    {
        n_ai_count = 3;
    }
    else
    {
        n_ai_count = level.players.size + 2;
    }
    
    o_phalanx = new robotphalanx();
    [[ o_phalanx ]]->initialize( "phalanx_column_right", v_start_position, var_e2ea1b3f, 1, n_ai_count );
    robots = arraycombine( arraycombine( o_phalanx.tier1robots_, o_phalanx.tier2robots_, 0, 0 ), o_phalanx.tier3robots_, 0, 0 );
    array::wait_till( robots, "death" );
    level flag::set( "station_phalanx_dead" );
}

// Namespace station_fight
// Params 0
// Checksum 0xbd628792, Offset: 0x39a8
// Size: 0x1d2
function spawn_station_right_phalanx()
{
    level flag::init( "station_right_phalanx_dead" );
    v_start_position = struct::get( "station_right_phalanx_start", "targetname" ).origin;
    var_e2ea1b3f = struct::get( "station_right_phalanx_end", "targetname" ).origin;
    o_phalanx = new robotphalanx();
    [[ o_phalanx ]]->initialize( "phanalx_wedge", v_start_position, var_e2ea1b3f, 2, 3 );
    a_robots = arraycombine( arraycombine( o_phalanx.tier1robots_, o_phalanx.tier2robots_, 0, 0 ), o_phalanx.tier3robots_, 0, 0 );
    
    foreach ( e_robot in a_robots )
    {
        e_robot thread ramses_util::magic_bullet_shield_till_notify( "gap_soldiers_dead", 1, "station_right_phalanx_scatter" );
        e_robot thread ramses_util::magic_bullet_shield_till_notify( "player_is_close", 1, "station_right_phalanx_scatter" );
    }
    
    level thread function_3da9f438( var_e2ea1b3f );
    o_phalanx thread scatter_on_notify( "station_right_phalanx_scatter" );
    array::wait_till( a_robots, "death" );
    level flag::set( "station_right_phalanx_dead" );
}

// Namespace station_fight
// Params 0
// Checksum 0x419408af, Offset: 0x3b88
// Size: 0x162
function function_e59f097a()
{
    level flag::init( "station_center_phalanx_dead" );
    v_start_position = struct::get( "station_center_phalanx_start", "targetname" ).origin;
    var_e2ea1b3f = struct::get( "station_center_phalanx_end", "targetname" ).origin;
    
    if ( level.players.size < 3 )
    {
        n_ai_count = 4;
    }
    else
    {
        n_ai_count = level.players.size + 2;
    }
    
    o_phalanx = new robotphalanx();
    [[ o_phalanx ]]->initialize( "phalanx_column_right", v_start_position, var_e2ea1b3f, 1, n_ai_count );
    o_phalanx thread function_a6f57c70( 20 );
    a_robots = arraycombine( arraycombine( o_phalanx.tier1robots_, o_phalanx.tier2robots_, 0, 0 ), o_phalanx.tier3robots_, 0, 0 );
    array::wait_till( a_robots, "death" );
    level flag::set( "station_center_phalanx_dead" );
}

// Namespace station_fight
// Params 1
// Checksum 0x1e5c591b, Offset: 0x3cf8
// Size: 0x22
function scatter_on_notify( str_phalanx_scatter_notify )
{
    level waittill( str_phalanx_scatter_notify );
    self robotphalanx::scatterphalanx();
}

// Namespace station_fight
// Params 1
// Checksum 0xed9ecc80, Offset: 0x3d28
// Size: 0x2a
function function_a6f57c70( n_delay )
{
    level endon( #"station_center_phalanx_dead" );
    wait n_delay;
    
    if ( isdefined( self ) )
    {
        self robotphalanx::scatterphalanx();
    }
}

// Namespace station_fight
// Params 1
// Checksum 0xad99523b, Offset: 0x3d60
// Size: 0xc7
function function_3da9f438( var_3c23ee9a )
{
    level endon( #"station_right_phalanx_dead" );
    
    do
    {
        foreach ( player in level.activeplayers )
        {
            if ( isdefined( player ) && player util::is_player_looking_at( var_3c23ee9a ) )
            {
                if ( distance( player.origin, var_3c23ee9a ) < 800 )
                {
                    level notify( #"player_is_close" );
                    level notify( #"station_right_phalanx_scatter" );
                    return;
                }
            }
            
            wait 0.05;
        }
        
        wait 0.1;
    }
    while ( true );
}

// Namespace station_fight
// Params 1
// Checksum 0xf1a85221, Offset: 0x3e30
// Size: 0x5f
function track_gap_soldiers_dead( str_gap_spawn_manager )
{
    level endon( #"station_right_phalanx_dead" );
    
    do
    {
        wait 0.5;
        a_human_ais = spawn_manager::get_ai( str_gap_spawn_manager );
    }
    while ( a_human_ais.size > 0 || spawn_manager::is_enabled( str_gap_spawn_manager ) );
    
    level notify( #"gap_soldiers_dead" );
}

// Namespace station_fight
// Params 1
// Checksum 0x367d091e, Offset: 0x3e98
// Size: 0xa3
function track_right_robot_phalanx_dead( str_gap_spawn_manager )
{
    level endon( #"gap_soldiers_dead" );
    level util::waittill_any( "station_right_phalanx_dead", "station_right_phalanx_scatter" );
    a_human_ais = spawn_manager::get_ai( str_gap_spawn_manager );
    
    foreach ( e_human in a_human_ais )
    {
        e_human.goalradius = 1024;
    }
}

// Namespace station_fight
// Params 1
// Checksum 0x7c9dd04d, Offset: 0x3f48
// Size: 0x4a
function kill_on_ceiling_drop( str_spawn_manager )
{
    a_alive_ai = spawn_manager::get_ai( "station_fight_wave1_robots_left" );
    array::thread_all( a_alive_ai, &random_wait_then_kill );
}

// Namespace station_fight
// Params 0
// Checksum 0x13316687, Offset: 0x3fa0
// Size: 0x4a
function random_wait_then_kill()
{
    self endon( #"death" );
    wait randomfloatrange( 0.15, 0.5 );
    util::stop_magic_bullet_shield( self );
    self kill();
}

// Namespace station_fight
// Params 0
// Checksum 0x6b0a5aec, Offset: 0x3ff8
// Size: 0x172
function spawn_robots_in_pod()
{
    a_droppod_robots = spawner::simple_spawn( "droppod_robot", &pod_robot_spawn_function );
    wait 0.5;
    arraysortclosest( a_droppod_robots, struct::get( "drop_pod_fire_loc" ).origin );
    
    foreach ( e_robot in a_droppod_robots )
    {
        if ( isalive( e_robot ) )
        {
            e_robot ai::set_ignoreall( 0 );
            e_robot ai::set_ignoreme( 0 );
            e_robot ai::set_behavior_attribute( "move_mode", "rusher" );
            e_robot notify( #"out_of_pod" );
            e_robot.cybercomtargetstatusoverride = undefined;
            wait 1;
        }
    }
    
    array::wait_till( a_droppod_robots, "death" );
    getent( "drop_pod_fire_clip", "targetname" ) movez( 100, 0.05 );
}

// Namespace station_fight
// Params 0
// Checksum 0x548e3c49, Offset: 0x4178
// Size: 0x42
function pod_robot_spawn_function()
{
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self.cybercomtargetstatusoverride = 1;
    self ramses_util::magic_bullet_shield_till_notify( "out_of_pod", 1 );
}

// Namespace station_fight
// Params 0
// Checksum 0xb1a0cefc, Offset: 0x41c8
// Size: 0x2ea
function allies_think()
{
    level waittill( #"raps_intro_done" );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level thread khalil_station_fight();
    spawner::waittill_ai_group_ai_count( "custom_raps", 0 );
    var_2eae89db = struct::get( "cin_gen_melee_hendricks_stomp_gibbedrobot", "scriptbundlename" );
    level.ai_hendricks setgoal( var_2eae89db.origin, 0, -128 );
    level flag::wait_till( "pod_hits_floor" );
    level.ai_hendricks sethighdetail( 0 );
    
    while ( distance( level.ai_hendricks.origin, var_2eae89db.origin ) > 600 && !level flag::get( "drop_pod_opened_and_spawned" ) )
    {
        wait 0.25;
    }
    
    if ( !level flag::get( "drop_pod_opened_and_spawned" ) )
    {
        scene::play( "cin_gen_melee_hendricks_stomp_gibbedrobot" );
    }
    else if ( scene::is_active( "cin_gen_melee_hendricks_stomp_gibbedrobot" ) )
    {
        scene::stop( "cin_gen_melee_hendricks_stomp_gibbedrobot" );
    }
    
    var_b200e7a3 = getent( "station_fight_allies_near_goal", "targetname" );
    level.ai_hendricks setgoal( var_b200e7a3 );
    a_allies = getactorarray( "recovery_room_allies", "script_aigroup" );
    
    foreach ( ai in a_allies )
    {
        ai setgoal( var_b200e7a3, 1 );
    }
    
    level flag::wait_till( "drop_pod_opened_and_spawned" );
    level.ai_hendricks setgoal( getent( "station_fight_drop_pod_goal", "targetname" ) );
    level flag::wait_till( "station_fight_completed" );
    level.ai_hendricks ai::set_behavior_attribute( "disablesprint", 1 );
    level scene::play( "cin_ram_04_02_easterncheck_vign_jumpdirect_hendricks" );
}

// Namespace station_fight
// Params 2
// Checksum 0x139c792f, Offset: 0x44c0
// Size: 0xef
function ai_at_arch_magic_bullet_shield_removal( str_sm1, str_sm2 )
{
    level endon( #"reached_ceiling_collapse" );
    trigger::wait_till( "trig_start_rap_intro", "targetname" );
    wait 15;
    a_soldiers = spawn_manager::get_ai( str_sm1 );
    a_soldiers = arraycombine( a_soldiers, spawn_manager::get_ai( str_sm2 ), 0, 0 );
    a_soldiers = array::randomize( a_soldiers );
    
    foreach ( e_guy in a_soldiers )
    {
        if ( isdefined( e_guy ) )
        {
            e_guy notify( #"ram_kill_mb" );
        }
        
        wait 2;
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x57febcfe, Offset: 0x45b8
// Size: 0x1f2
function khalil_station_fight()
{
    setenablenode( level.nd_khalil, 1 );
    level.ai_khalil setgoal( level.nd_khalil, 0, 64 );
    level.nd_khalil = undefined;
    level flag::wait_till( "ceiling_collapse_complete" );
    level thread scene::play( "cin_ram_03_03_defend_vign_balconybash_khalil_init" );
    level waittill( #"hash_40171b94" );
    
    if ( scene::is_playing( "cin_ram_03_03_defend_vign_balconybash_khalil_init" ) )
    {
        level scene::stop( "cin_ram_03_03_defend_vign_balconybash_khalil_init" );
    }
    
    level scene::play( "cin_ram_03_03_defend_vign_balconybash" );
    e_goalvolume = getent( "initial_balcony_friendly_volume", "targetname" );
    level.ai_khalil setgoal( e_goalvolume );
    spawn_manager::wait_till_cleared( "sm_balcony_robots" );
    e_goalvolume = getent( "second_balcony_friendly_volume", "targetname" );
    level.ai_khalil setgoal( e_goalvolume );
    level flag::wait_till( "drop_pod_opened_and_spawned" );
    level.ai_khalil setgoal( getnode( "khalil_balcony_platform_node", "targetname" ), 1 );
    level flag::wait_till( "station_fight_completed" );
    level.ai_khalil ai::set_behavior_attribute( "disablesprint", 1 );
    scene::play( "cin_ram_04_02_easterncheck_vign_jumpdirect_khalil" );
}

// Namespace station_fight
// Params 1
// Checksum 0x1878dda4, Offset: 0x47b8
// Size: 0x15a
function function_1a2278be( a_ents )
{
    e_robot = a_ents[ "balcony_bash_robot" ];
    e_soldier = a_ents[ "balcony_bash_soldier" ];
    e_soldier ai::set_ignoreme( 1 );
    e_soldier thread function_3ee9fc92();
    e_robot.goalradius = 32;
    e_robot ai::set_ignoreall( 1 );
    e_robot ai::set_ignoreme( 1 );
    util::magic_bullet_shield( e_robot );
    e_robot setgoal( e_robot.origin, 1 );
    level waittill( #"hash_6daeefef" );
    e_soldier ai::set_ignoreme( 0 );
    util::stop_magic_bullet_shield( e_robot );
    e_robot waittill( #"death" );
    scene::stop( "cin_ram_03_03_defend_vign_balconybash" );
    
    if ( isdefined( e_soldier ) && isalive( e_soldier ) && e_soldier flag::get( "past_ragdoll_frame" ) )
    {
        e_soldier startragdoll();
        e_soldier kill();
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x30fba91e, Offset: 0x4920
// Size: 0x42
function function_3ee9fc92()
{
    self flag::init( "past_ragdoll_frame" );
    self endon( #"death" );
    self waittill( #"hash_8368b9dc" );
    self flag::set( "past_ragdoll_frame" );
}

// Namespace station_fight
// Params 1
// Checksum 0x33b7c295, Offset: 0x4970
// Size: 0x5a
function function_c0443db4( a_ents )
{
    e_robot = a_ents[ "stomped_robot" ];
    
    if ( isalive( e_robot ) )
    {
        e_robot ai::set_ignoreme( 1 );
        e_robot disableaimassist();
    }
}

// Namespace station_fight
// Params 0
// Checksum 0xaf4d45f6, Offset: 0x49d8
// Size: 0xba
function progression_scenes()
{
    scene::add_scene_func( "cin_gen_melee_hendricks_stomp_gibbedrobot", &function_c0443db4, "init" );
    scene::init( "cin_gen_melee_hendricks_stomp_gibbedrobot" );
    level thread raps_intro();
    level thread ambient_scenes();
    play_ceiling_collapse();
    level notify( #"start_defend_music" );
    level thread ramses_sound::station_defend_music();
    level flag::wait_till( "station_fight_completed" );
    level thread ramses_sound::function_9bda9447();
}

// Namespace station_fight
// Params 0
// Checksum 0x607e7afc, Offset: 0x4aa0
// Size: 0x24a
function raps_intro()
{
    level thread sndwaittillanimnotify();
    level thread raps_intro_fxanim();
    level thread wait_for_blood_notifies();
    scene::add_scene_func( "cin_ram_03_01_defend_1st_rapsintro", &swap_soldier_body, "play" );
    scene::add_scene_func( "cin_ram_03_01_defend_1st_rapsintro", &function_3b3f857a, "done" );
    ramses_util::co_op_teleport_on_igc_end( "cin_ram_03_01_defend_1st_rapsintro", "defend_ramses_station" );
    
    foreach ( player in level.players )
    {
        player.ignoreme = 1;
    }
    
    getent( "raps_intro_door_clip", "targetname" ) delete();
    level.ai_rachel sethighdetail( 0 );
    level.ai_khalil sethighdetail( 0 );
    level flag::set( "station_fight_started" );
    level scene::play( "cin_ram_03_01_defend_1st_rapsintro", level.var_be0fc6c8 );
    level flag::set( "raps_intro_done" );
    objectives::set( "cp_level_ramses_defend_station" );
    wait 1.5;
    
    foreach ( player in level.players )
    {
        player.ignoreme = 0;
    }
    
    savegame::checkpoint_save();
}

// Namespace station_fight
// Params 0
// Checksum 0xf8dcf60d, Offset: 0x4cf8
// Size: 0x102
function function_97cdc17e()
{
    var_5d7a0794 = spawner::simple_spawn_single( "station_fight_wounded_guy" );
    scene::init( "cin_gen_wounded_last_stand_guy01", var_5d7a0794 );
    var_5d7a0794 = spawner::simple_spawn_single( "station_fight_wounded_guy" );
    scene::init( "cin_gen_wounded_last_stand_guy02", var_5d7a0794 );
    var_5d7a0794 = spawner::simple_spawn_single( "station_fight_wounded_guy" );
    scene::init( "cin_gen_wounded_last_stand_guy03", var_5d7a0794 );
    level flag::wait_till( "station_fight_started" );
    level thread scene::play( "cin_gen_wounded_last_stand_guy02" );
    level waittill( #"raps_intro_done" );
    level thread scene::play( "cin_gen_wounded_last_stand_guy01" );
    level thread scene::play( "cin_gen_wounded_last_stand_guy03" );
}

// Namespace station_fight
// Params 1
// Checksum 0x5375148e, Offset: 0x4e08
// Size: 0x3a
function swap_soldier_body( a_ents )
{
    level waittill( #"swap_rap_guy_model" );
    e_soldier = a_ents[ "rap_intro_guy" ];
    e_soldier setmodel( "c_ega_soldier_3_pincushion_armoff_fb" );
}

// Namespace station_fight
// Params 1
// Checksum 0x663272ab, Offset: 0x4e50
// Size: 0x122
function function_3b3f857a( a_ents )
{
    a_ents[ "rap_intro_guy" ] clientfield::increment( "hide_graphic_content", 1 );
    a_ents[ "arm" ] clientfield::increment( "hide_graphic_content", 1 );
    a_ents[ "shrapnel02" ] clientfield::increment( "hide_graphic_content", 1 );
    a_ents[ "shrapnel03" ] clientfield::increment( "hide_graphic_content", 1 );
    a_ents[ "shrapnel04" ] clientfield::increment( "hide_graphic_content", 1 );
    a_ents[ "shrapnel06" ] clientfield::increment( "hide_graphic_content", 1 );
    a_ents[ "shrapnel07" ] clientfield::increment( "hide_graphic_content", 1 );
}

// Namespace station_fight
// Params 1
// Checksum 0xd2de0d54, Offset: 0x4f80
// Size: 0x7b
function function_896cfa4c( a_ents )
{
    util::wait_network_frame();
    
    foreach ( ent in a_ents )
    {
        ent clientfield::increment( "hide_graphic_content", 1 );
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x28feb3f2, Offset: 0x5008
// Size: 0x32
function wait_for_blood_notifies()
{
    level waittill( #"rap_blood_postfx" );
    level thread play_blood_postfx();
    level waittill( #"rap_blood_postfx" );
    level thread play_blood_postfx();
}

// Namespace station_fight
// Params 0
// Checksum 0xbe12136f, Offset: 0x5048
// Size: 0x7b
function play_blood_postfx()
{
    foreach ( e_player in level.players )
    {
        if ( e_player.current_scene === "cin_ram_03_01_defend_1st_rapsintro" )
        {
            e_player clientfield::increment_to_player( "rap_blood_on_player" );
        }
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x6dd62a7c, Offset: 0x50d0
// Size: 0x22
function sndwaittillanimnotify()
{
    level waittill( #"sndrapsintrodone" );
    level util::clientnotify( "dro" );
}

// Namespace station_fight
// Params 0
// Checksum 0xb4963a8c, Offset: 0x5100
// Size: 0x22
function raps_intro_fxanim()
{
    level waittill( #"play_raps_explosion_bundle" );
    level scene::play( "p7_fxanim_cp_ramses_raps_explosion_bundle" );
}

// Namespace station_fight
// Params 0
// Checksum 0xd64154f4, Offset: 0x5130
// Size: 0x163
function play_ceiling_collapse()
{
    scene::add_scene_func( "p7_fxanim_cp_ramses_station_ceiling_vtol_bundle", &ceiling_lighting_swap, "init" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_station_ceiling_bundle", &ceiling_collapse_break_glass, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_station_ceiling_bundle", &ceiling_anim_swap_station_interior, "play" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_station_ceiling_bundle", &kill_on_ceiling_drop, "done" );
    level scene::init( "p7_fxanim_cp_ramses_station_ceiling_bundle" );
    level waittill( #"reached_ceiling_collapse" );
    level thread kill_ambient_exploder_on_notetrack();
    level thread ceiling_anim_pod_impact();
    level thread function_16c6b95d();
    level play_ceiling_anims_blocking();
    level flag::set( "ceiling_collapse_complete" );
    level scene::init( "p_ramses_lift_wing_blockage" );
    level notify( #"vtol_crash_complete" );
    level notify( #"killed_by_ceiling" );
}

// Namespace station_fight
// Params 0
// Checksum 0xafaf2385, Offset: 0x52a0
// Size: 0x22
function function_16c6b95d()
{
    level waittill( #"hash_16c6b95d" );
    exploder::exploder( "ceiling_colapse" );
}

// Namespace station_fight
// Params 1
// Checksum 0x588f6e3d, Offset: 0x52d0
// Size: 0xb3
function phys_pulse_on_structs( a_ents )
{
    a_structs = struct::get_array( "station_phys_pulse", "targetname" );
    
    foreach ( struct in a_structs )
    {
        physicsjolt( struct.origin, -1, 1, math::random_vector( 20 ) );
        wait 0.05;
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x64069ab0, Offset: 0x5390
// Size: 0x32
function play_ceiling_anims_blocking()
{
    level thread scene::play( "p7_fxanim_cp_ramses_station_ceiling_bundle" );
    level scene::init( "p7_fxanim_cp_ramses_station_ceiling_vtol_bundle" );
}

// Namespace station_fight
// Params 0
// Checksum 0x9db978ee, Offset: 0x53d0
// Size: 0x92
function ceiling_anim_pod_impact()
{
    level waittill( #"pod_hits_floor" );
    level flag::set( "pod_hits_floor" );
    
    if ( spawn_manager::get_ai( "station_fight_wave1_robots_left" ).size > 0 )
    {
        var_8f75db49 = struct::get( "pod_radius_damage", "targetname" );
        radiusdamage( var_8f75db49.origin, 300, 1000, 500, undefined, "MOD_EXPLOSIVE" );
    }
}

// Namespace station_fight
// Params 0
// Checksum 0xcebf18d1, Offset: 0x5470
// Size: 0x133
function ceiling_lighting_swap()
{
    level waittill( #"switch_fog_banks" );
    level clientfield::set( "defend_fog_banks", 1 );
    a_ceiling_geo = getentarray( "station_roof_hole", "targetname" );
    
    foreach ( piece in a_ceiling_geo )
    {
        piece delete();
    }
    
    var_2f5160f4 = getentarray( "roof_hole_blocker", "targetname" );
    
    foreach ( e_blocker in var_2f5160f4 )
    {
        e_blocker hide();
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x6ddb4f61, Offset: 0x55b0
// Size: 0xd2
function ceiling_anim_swap_station_interior()
{
    wait 1;
    a_ceiling_piece_geo = getentarray( "station_ceiling_pristine", "targetname" );
    
    foreach ( piece in a_ceiling_piece_geo )
    {
        piece delete();
    }
    
    level waittill( #"swap_station_interior" );
    level thread show_props( "_combat" );
    delete_props();
    phys_pulse_on_structs();
}

// Namespace station_fight
// Params 0
// Checksum 0x7e3b74ac, Offset: 0x5690
// Size: 0x1a
function kill_ambient_exploder_on_notetrack()
{
    level waittill( #"dropship_through_ceiling" );
    level ramses_util::ambient_walk_fx_exploder( 0 );
}

// Namespace station_fight
// Params 1
// Checksum 0x2906ad47, Offset: 0x56b8
// Size: 0xcb
function ceiling_collapse_break_glass( a_ents )
{
    a_s_pulse = struct::get_array( "station_fight_glass_pulse", "targetname" );
    wait 1.4;
    
    foreach ( s in a_s_pulse )
    {
        glassradiusdamage( s.origin, s.radius, 500, 400 );
        wait randomfloatrange( 0.5, 0.75 );
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x9781ac5a, Offset: 0x5790
// Size: 0x1ea
function ambient_scenes()
{
    spawner::add_spawn_function_group( "balcony_bash_robot", "targetname", &ai::set_ignoreme, 1 );
    scene::add_scene_func( "cin_ram_03_03_defend_vign_balconybash", &function_1a2278be, "init" );
    scene::add_scene_func( "cin_ram_03_01_defend_vign_shrapnelpinned_01", &function_896cfa4c, "init" );
    scene::add_scene_func( "cin_ram_03_01_defend_vign_shrapnelpinned_03", &function_896cfa4c, "init" );
    level scene::init( "cin_ram_03_03_defend_vign_balconybash" );
    util::wait_network_frame();
    level scene::init( "cin_ram_03_03_defend_vign_debriscover_aligned" );
    level thread robotintro_handler();
    level scene::init( "cin_ram_03_01_defend_vign_shrapnelpinned_01" );
    util::wait_network_frame();
    level scene::init( "cin_ram_03_01_defend_vign_shrapnelpinned_03" );
    level thread scene::play( "cin_gen_deathpose_m_floor_shrapnel01" );
    util::wait_network_frame();
    level thread scene::play( "cin_gen_deathpose_m_floor_shrapnel02" );
    util::wait_network_frame();
    level thread scene::play( "cin_gen_deathpose_m_floor_shrapnel03" );
    level thread function_8eaad758();
    level waittill( #"killed_by_ceiling" );
    level thread scene::play( "cin_ram_03_03_defend_vign_debriscover_aligned" );
}

// Namespace station_fight
// Params 0
// Checksum 0x3f3cb466, Offset: 0x5988
// Size: 0xb2
function function_8eaad758()
{
    level endon( #"station_fight_completed" );
    var_bfdab3ed = spawner::simple_spawn_single( "shrapnel_guy" );
    util::magic_bullet_shield( var_bfdab3ed );
    var_bfdab3ed ai::set_ignoreme( 1 );
    trigger::wait_till( "trig_shrapnel_death_scene" );
    spawner::simple_spawn_single( "shrapnel_raps", &function_77c1726a );
    util::stop_magic_bullet_shield( var_bfdab3ed );
    scene::play( "cin_ram_03_01_defend_vign_shrapnelpinned_04", var_bfdab3ed );
}

// Namespace station_fight
// Params 0
// Checksum 0xec7779e3, Offset: 0x5a48
// Size: 0xaa
function function_77c1726a()
{
    assert( isdefined( self.target ), "<dev string:xb5>" );
    v_goal = struct::get( self.target, "targetname" ).origin;
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self setvehgoalpos( v_goal, 1, 1 );
    level waittill( #"hash_56447163" );
    self raps::detonate();
}

// Namespace station_fight
// Params 2
// Checksum 0xc93b0c11, Offset: 0x5b00
// Size: 0x42
function turret_objective( s_obj, t_obj )
{
    self turret_objective_show_think( s_obj, t_obj );
    
    if ( isdefined( self ) )
    {
        self oed::disable_keyline();
    }
}

// Namespace station_fight
// Params 2
// Checksum 0x552656fa, Offset: 0x5b50
// Size: 0x85
function turret_objective_show_think( s_obj, t_obj )
{
    level endon( #"station_fight_completed" );
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        t_obj waittill( #"trigger", e_player );
        
        while ( isdefined( t_obj ) && isalive( e_player ) && e_player istouching( t_obj ) )
        {
            wait 0.1;
        }
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x4d114c89, Offset: 0x5be0
// Size: 0x283
function cleanup_scenes()
{
    a_str_scenes = [];
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_03_02_defend_1st_pullbody";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_02_05_interview_vign_nassersitting";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_03_03_defend_vign_balconybash";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_03_03_defend_vign_debriscover_aligned";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_03_02_defend_vign_last_stand_death_guy01";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_03_02_defend_vign_last_stand_death_guy02";
    
    if ( !isdefined( a_str_scenes ) )
    {
        a_str_scenes = [];
    }
    else if ( !isarray( a_str_scenes ) )
    {
        a_str_scenes = array( a_str_scenes );
    }
    
    a_str_scenes[ a_str_scenes.size ] = "cin_ram_03_02_defend_vign_last_stand_death_guy03";
    
    foreach ( str_scene in a_str_scenes )
    {
        if ( level scene::is_active( str_scene ) )
        {
            level thread scene::stop( str_scene, 1 );
            wait 0.1;
        }
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x836189b2, Offset: 0x5e70
// Size: 0x72
function cleanup_scene_turret()
{
    vh_turret = getent( "station_fight_turret_respawn", "targetname" );
    
    if ( isdefined( vh_turret ) )
    {
        vh_turret.delete_on_death = 1;
        vh_turret notify( #"death" );
        
        if ( !isalive( vh_turret ) )
        {
            vh_turret delete();
        }
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x407d61cc, Offset: 0x5ef0
// Size: 0xa3
function enemies_track_players()
{
    a_ai_robots = getaiteamarray( "axis" );
    
    foreach ( ai in a_ai_robots )
    {
        if ( !isvehicle( ai ) )
        {
            ai ai::set_behavior_attribute( "move_mode", "rusher" );
        }
    }
}

// Namespace station_fight
// Params 1
// Checksum 0xd807071f, Offset: 0x5fa0
// Size: 0x14a
function hide_props( str_state )
{
    if ( !isdefined( str_state ) )
    {
        str_state = "";
    }
    
    hidemiscmodels( "station_clutter" + str_state );
    a_m_props = getentarray( "station_clutter" + str_state, "targetname" );
    a_m_props_noteworthy = getentarray( "station_clutter" + str_state, "script_noteworthy" );
    a_m_clips = getentarray( "station_clutter_collision" + str_state, "targetname" );
    a_m_stairs = getentarray( "station_stairs" + str_state, "targetname" );
    a_m_props ramses_util::hide_ents( 1 );
    a_m_props ramses_util::make_not_solid();
    a_m_props_noteworthy ramses_util::hide_ents( 1 );
    a_m_clips ramses_util::make_not_solid();
    a_m_stairs ramses_util::hide_ents();
}

// Namespace station_fight
// Params 1
// Checksum 0x9576f83c, Offset: 0x60f8
// Size: 0x17a
function show_props( str_state )
{
    if ( !isdefined( str_state ) )
    {
        str_state = "";
    }
    
    showmiscmodels( "station_clutter" + str_state );
    a_m_props = getentarray( "station_clutter" + str_state, "targetname" );
    a_m_props_noteworthy = getentarray( "station_clutter" + str_state, "script_noteworthy" );
    a_m_clips = getentarray( "station_clutter_collision" + str_state, "targetname" );
    a_m_stairs = getentarray( "station_stairs" + str_state, "targetname" );
    a_m_props ramses_util::make_solid();
    a_m_clips ramses_util::make_solid();
    a_m_props ramses_util::show_ents( 1 );
    a_m_props_noteworthy ramses_util::show_ents( 1 );
    a_m_stairs ramses_util::show_ents();
    a_struct_props = struct::get_array( "station_clutter" + str_state, "targetname" );
    a_struct_props ramses_util::spawn_from_structs();
}

// Namespace station_fight
// Params 2
// Checksum 0x7a857658, Offset: 0x6280
// Size: 0x1d2
function delete_props( str_state, b_connectpaths )
{
    if ( !isdefined( str_state ) )
    {
        str_state = "";
    }
    
    if ( !isdefined( b_connectpaths ) )
    {
        b_connectpaths = 0;
    }
    
    a_m_props = getentarray( "station_clutter" + str_state, "targetname" );
    a_m_clips = getentarray( "station_clutter_collision" + str_state, "targetname" );
    a_m_props_no_col = getentarray( "station_clutter_nocol" + str_state, "targetname" );
    a_m_stairs = getentarray( "station_stairs" + str_state, "targetname" );
    hidemiscmodels( "station_clutter" + str_state );
    
    if ( b_connectpaths )
    {
        n_count = 0;
        
        foreach ( e_prop in a_m_props )
        {
            e_prop connectpaths();
            n_count++;
            
            if ( n_count > 1 )
            {
                wait 0.05;
                n_count = 0;
            }
        }
    }
    
    array::delete_all( a_m_props );
    array::delete_all( a_m_clips );
    array::delete_all( a_m_props_no_col );
    array::delete_all( a_m_stairs );
}

// Namespace station_fight
// Params 0
// Checksum 0xaafc35a5, Offset: 0x6460
// Size: 0x3a
function intermediate_prop_state_hide()
{
    a_m_props_to_hide = getentarray( "station_defend_after", "script_noteworthy" );
    a_m_props_to_hide ramses_util::hide_ents();
}

// Namespace station_fight
// Params 0
// Checksum 0x762789b9, Offset: 0x64a8
// Size: 0x123
function intermediate_prop_state_show()
{
    a_m_props_to_show = getentarray( "station_defend_after", "script_noteworthy" );
    a_m_props_to_show ramses_util::show_ents( 1 );
    util::wait_network_frame();
    a_m_props_to_delete = getentarray( "station_defend_before", "script_noteworthy" );
    array::delete_all( a_m_props_to_delete );
    util::wait_network_frame();
    a_rooftop_pieces = getentarray( "droppod_hole", "targetname" );
    
    foreach ( rooftop_piece in a_rooftop_pieces )
    {
        rooftop_piece delete();
    }
}

// Namespace station_fight
// Params 0
// Checksum 0x4bb05efd, Offset: 0x65d8
// Size: 0xa2
function end_fight_dialog()
{
    wait 2;
    level.ai_hendricks dialog::say( "hend_all_clear_that_s_t_0" );
    level dialog::player_say( "plyr_kane_patch_us_into_0", 1 );
    level dialog::remote( "ecmd_ramses_1_1_priority_0" );
    level dialog::remote( "ecmd_request_all_emergenc_0" );
    level.ai_khalil dialog::say( "khal_copy_that_but_we_l_0" );
    level dialog::remote( "ecmd_confirmed_vtol_sup_0" );
}

// Namespace station_fight
// Params 0
// Checksum 0xda72a3c8, Offset: 0x6688
// Size: 0xd2
function end_fight_ambient_dialog()
{
    wait 5;
    a_ai = getaiteamarray( "allies" );
    arrayremovevalue( a_ai, level.ai_hendricks, 0 );
    arrayremovevalue( a_ai, level.ai_khalil, 0 );
    a_ai = arraysortclosest( a_ai, level.players[ 0 ].origin );
    
    if ( isdefined( a_ai[ 0 ] ) )
    {
        if ( math::cointoss() )
        {
            a_ai[ 0 ] thread dialog::say( "esl3_how_did_they_beat_ou_0" );
            return;
        }
        
        a_ai[ 0 ] thread dialog::say( "esl4_impossible_how_did_0" );
    }
}

// Namespace station_fight
// Params 2
// Checksum 0xe2d4efc9, Offset: 0x6768
// Size: 0x52
function defend_station_test( str_objective, b_starting )
{
    delete_props();
    show_props( "_combat" );
    init( "defend_ramses_station", b_starting );
}

// Namespace station_fight
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x67c8
// Size: 0x2
function defend_station_done()
{
    
}

