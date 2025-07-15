#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_accolades;
#using scripts/cp/cp_mi_sing_sgen_pallas;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_sgen_flood;

// Namespace cp_mi_sing_sgen_flood
// Params 2
// Checksum 0x4903c611, Offset: 0x17b0
// Size: 0x45a
function skipto_flood_init( str_objective, b_starting )
{
    init_flags();
    spawn_manager::set_global_active_count( 30 );
    spawner::add_spawn_function_group( "flood_combat_runners", "script_noteworthy", &fallback_spawnfunc );
    array::run_all( getentarray( "floor_door_hint_trigger", "targetname" ), &triggerenable, 0 );
    
    if ( b_starting )
    {
        sgen::init_hendricks( str_objective );
        cp_mi_sing_sgen_pallas::elevator_setup();
        getent( "pallas_lift_front", "targetname" ) util::self_delete();
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::complete( "cp_level_sgen_descend_into_core" );
        objectives::complete( "cp_level_sgen_goto_signal_source" );
        objectives::complete( "cp_level_sgen_goto_server_room" );
        objectives::complete( "cp_level_sgen_confront_pallas" );
        array::run_all( getaiteamarray( "axis" ), &delete );
        load::function_a2995f22();
        
        if ( level.skipto_point === "dev_flood_combat" )
        {
            level.players[ 0 ] setorigin( ( 1152, -3864, -4876 ) );
            level.players[ 0 ] setplayerangles( ( 0, 0, 0 ) );
        }
    }
    else
    {
        util::streamer_wait( undefined, 1, 3 );
        level util::player_unlock_control();
        util::screen_fade_in( 0.5, "black", "hide_trans_flood" );
    }
    
    level thread sgen_util::set_door_state( "charging_station_entrance", "open" );
    level clientfield::set( "w_underwater_state", 1 );
    setdvar( "phys_buoyancy", 1 );
    spawner::add_spawn_function_group( "flood_reinforcement_robot", "script_noteworthy", &reinforcement_robot_setup );
    level.ai_hendricks ai::set_behavior_attribute( "can_melee", 0 );
    level.ai_hendricks ai::set_behavior_attribute( "can_be_meleed", 0 );
    level thread set_pipes_states_combat();
    set_doors_states_combat();
    a_s_spawn_point = struct::get_array( "charging_station_spawn_point" );
    array::thread_all( a_s_spawn_point, &util::delay_notify, 5, "post_pallas" );
    array::thread_all( getentarray( "water_spout_trigger", "targetname" ), &water_spout_push );
    array::thread_all( getentarray( "stumble_trigger", "targetname" ), &sgen_util::stumble_trigger_think );
    main();
    skipto::objective_completed( "flood_combat" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 4
// Checksum 0xc14d171, Offset: 0x1c18
// Size: 0x32
function skipto_flood_done( str_objective, b_starting, b_direct, player )
{
    sgen_accolades::function_bc2458f5();
}

// Namespace cp_mi_sing_sgen_flood
// Params 2
// Checksum 0x40b875c0, Offset: 0x1c58
// Size: 0x432
function skipto_flood_defend_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        level flag::init( "hendricks_defend_started" );
        level flag::init( "flood_defend_hendricks_at_door" );
        array::run_all( getentarray( "floor_door_hint_trigger", "targetname" ), &triggerenable, 0 );
        sgen::init_hendricks( str_objective );
        cp_mi_sing_sgen_pallas::elevator_setup();
        getent( "pallas_lift_front", "targetname" ) util::self_delete();
        level flag::set( "pallas_lift_front_open" );
        level flag::wait_till( "all_players_spawned" );
        array::run_all( getaiteamarray( "axis" ), &delete );
        
        if ( level.skipto_point === "dev_flood_combat" )
        {
            level.players[ 0 ] setorigin( ( 1152, -3864, -4876 ) );
            level.players[ 0 ] setplayerangles( ( 0, 0, 0 ) );
        }
        
        level clientfield::set( "w_underwater_state", 1 );
        setdvar( "phys_buoyancy", 1 );
        spawner::add_spawn_function_group( "flood_reinforcement_robot", "script_noteworthy", &reinforcement_robot_setup );
        level.ai_hendricks ai::set_behavior_attribute( "can_melee", 0 );
        level.ai_hendricks ai::set_behavior_attribute( "can_be_meleed", 0 );
        set_doors_states_defend();
        array::thread_all( getentarray( "water_spout_trigger", "targetname" ), &water_spout_push );
        level thread defend_room_set_state_flooded();
        level thread handle_earthquakes();
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::complete( "cp_level_sgen_descend_into_core" );
        objectives::complete( "cp_level_sgen_goto_signal_source" );
        objectives::complete( "cp_level_sgen_goto_server_room" );
        objectives::complete( "cp_level_sgen_confront_pallas" );
        objectives::set( "cp_level_sgen_get_to_surface" );
        level thread objectives::breadcrumb( "flood_combat_breadcrumb_end_trig" );
        level thread hendricks_defend_movement();
        t_boundary = getent( "flood_defend_out_of_boundary_trig", "targetname" );
        t_boundary setvisibletoall();
        load::function_a2995f22();
    }
    
    spawner::add_spawn_function_group( "flood_defend_catwalk_spawn_zone_robot", "targetname", &catwalk_spawn_zone_spawnfunc );
    defend_main( b_starting );
    spawn_manager::set_global_active_count( 32 );
    skipto::objective_completed( "flood_defend" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xf7391588, Offset: 0x2098
// Size: 0x82
function catwalk_spawn_zone_spawnfunc()
{
    n_level = 2;
    n_chance = sgen_util::get_num_scaled_by_player_count( 15, 11 );
    
    if ( n_chance > randomintrange( 0, 100 ) )
    {
        n_level = 3;
    }
    
    self.goalradius = 256;
    self ai::set_behavior_attribute( "rogue_control", "forced_level_" + n_level );
}

// Namespace cp_mi_sing_sgen_flood
// Params 4
// Checksum 0x2d01f62c, Offset: 0x2128
// Size: 0x132
function skipto_flood_defend_done( str_objective, b_starting, b_direct, player )
{
    a_ai = getaiteamarray( "axis", "team3" );
    
    foreach ( ai in a_ai )
    {
        if ( !( isdefined( ai.archetype ) && ai.archetype == "robot" ) )
        {
            ai.ignoreall = 1;
            ai sgen_util::teleport_to_underwater();
            continue;
        }
        
        ai util::self_delete();
    }
    
    if ( isdefined( level.ai_hendricks ) )
    {
        level.ai_hendricks ai::set_behavior_attribute( "can_melee", 1 );
        level.ai_hendricks ai::set_behavior_attribute( "can_be_meleed", 1 );
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xf8b4f769, Offset: 0x2268
// Size: 0x4a
function init_flags()
{
    level flag::init( "hendricks_defend_started" );
    level flag::init( "flood_combat_nag_playing" );
    level flag::init( "flood_defend_hendricks_at_door" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x35972091, Offset: 0x22c0
// Size: 0x232
function main()
{
    level flag::wait_till( "all_players_spawned" );
    objective_trigger = getent( "surgical_room_entrance_close", "targetname" );
    level thread alarm_sounds();
    level thread combat_vo();
    level thread handle_breadcrumbs();
    level thread handle_earthquakes();
    level thread handle_fallback();
    level thread handle_fallback_runners_cleanup();
    level thread hendricks_movement();
    level thread function_28b80c6f();
    level util::clientnotify( "escp" );
    level scene::play( "cin_sgen_20_02_twinrevenge_1st_elevator" );
    level flag::set( "pallas_lift_front_open" );
    objectives::set( "cp_level_sgen_get_to_surface" );
    trigger::wait_till( "surprised_54i_trigger" );
    level thread play_rejoin_scene();
    level thread play_robot_door_scene();
    level thread clean_up_charging_zone();
    level flag::wait_till( "flood_combat_surgical_room_door_close" );
    spawn_manager::enable( "flood_combat_defend_room_fallback_spawns" );
    level thread play_surgical_room_door_scene();
    level thread defend_room_set_state_risk_of_flooding();
    level thread defend_room_set_state_flooding();
    level flag::wait_till_timeout( 10, "flood_defend_zone_started" );
    level notify( #"cancel_hendricks_safe_zone" );
    spawn_manager::kill( "flood_combat_defend_room_fallback_spawns", 1 );
    level flag::wait_till_timeout( 30, "flood_defend_reached" );
    level flag::set( "flood_defend_reached" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xe4298e22, Offset: 0x2500
// Size: 0x192
function clean_up_charging_zone()
{
    level flag::wait_till( "flood_combat_charging_zone_cleared" );
    t_charging_zone = getent( "flood_combat_charging_zone_trig", "targetname" );
    t_boundary = getent( "flood_defend_out_of_boundary_trig", "targetname" );
    t_boundary setvisibletoall();
    sgen_util::set_door_state( "flood_robot_room_door_open", "close" );
    spawn_manager::kill( "flood_combat_charging_room_spawnmanager", 1 );
    spawn_manager::kill( "flood_combat_robot_room_spawnmanager", 1 );
    wait 0.05;
    a_ai_54i = getaiteamarray( "axis" );
    
    foreach ( ai_54i in a_ai_54i )
    {
        if ( isalive( ai_54i ) && ai_54i istouching( t_charging_zone ) )
        {
            ai_54i kill();
        }
    }
    
    charging_station_cleanup();
}

// Namespace cp_mi_sing_sgen_flood
// Params 1
// Checksum 0x5af5c34, Offset: 0x26a0
// Size: 0x82
function defend_main( b_starting )
{
    level flag::wait_till( "all_players_spawned" );
    level flag::set( "flood_combat_charging_zone_cleared" );
    spawn_manager::kill( "flood_combat_defend_room_fallback2_spawns", 1 );
    level thread defend_vo();
    level thread handle_defend_breadcrumbs();
    defend_logic( b_starting );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xd247803b, Offset: 0x2730
// Size: 0x22a
function hendricks_movement()
{
    level.ai_hendricks colors::disable();
    level.ai_hendricks.goalradius = 16;
    level flag::wait_till( "all_players_spawned" );
    level flag::wait_till( "pallas_lift_front_open" );
    level scene::play( "cin_sgen_21_01_releasetorrent_vign_pushdown_hendricks", level.ai_hendricks );
    level.ai_hendricks setgoal( getnode( "flood_combat_hendricks_intro_node", "targetname" ) );
    level.ai_hendricks colors::enable();
    trigger::wait_till( "flood_combat_windows_start", undefined );
    level.ai_hendricks colors::disable();
    level.ai_hendricks setgoal( getnode( "flood_combat_hendricks_catwalk_node", "targetname" ) );
    zone_wait_till_player( "flood_combat_catwalk_front_zone_trig", undefined, 0.75 );
    level.ai_hendricks zone_wait_till_safe( "flood_combat_catwalk_front_zone_trig", undefined, undefined, 0.74, "cancel_hendricks_safe_zone" );
    level thread weaken_catwalk_close_enemies();
    scene::add_scene_func( "cin_sgen_21_02_floodcombat_vign_traverse_hendricks", &kill_fallback_spawnmanager, "play" );
    level scene::play( "cin_sgen_21_02_floodcombat_vign_traverse_hendricks" );
    play_hendricks_defend_scene();
    nd_goal = getnode( "flood_defend_hendricks_ready_node", "targetname" );
    level.ai_hendricks setgoal( nd_goal );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x58592ae, Offset: 0x2968
// Size: 0xd3
function weaken_catwalk_close_enemies()
{
    a_ai_catwalk_close = getaiteamarray( "axis" );
    t_zone = getent( "flood_combat_catwalk_front_zone_trig", "targetname" );
    
    foreach ( ai_catwalk in a_ai_catwalk_close )
    {
        if ( isalive( ai_catwalk ) && ai_catwalk istouching( t_zone ) )
        {
            ai_catwalk.health = 1;
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 3
// Checksum 0x7785cf9b, Offset: 0x2a48
// Size: 0x9a
function zone_wait_till_player( str_key, str_val, n_delay )
{
    if ( !isdefined( str_val ) )
    {
        str_val = "targetname";
    }
    
    if ( !isdefined( n_delay ) )
    {
        n_delay = 0;
    }
    
    level endon( #"flood_defend" );
    t_zone = getent( str_key, str_val );
    t_zone endon( #"death" );
    
    do
    {
        t_zone waittill( #"trigger", e_triggerer );
        
        if ( isplayer( e_triggerer ) )
        {
            break;
        }
    }
    while ( true );
    
    wait n_delay;
}

// Namespace cp_mi_sing_sgen_flood
// Params 5
// Checksum 0x69c55848, Offset: 0x2af0
// Size: 0x164
function zone_wait_till_safe( str_key, str_val, str_species, n_delay, str_ender )
{
    if ( !isdefined( str_val ) )
    {
        str_val = "targetname";
    }
    
    if ( !isdefined( str_species ) )
    {
        str_species = "robot";
    }
    
    if ( !isdefined( n_delay ) )
    {
        n_delay = 0;
    }
    
    self endon( #"death" );
    level endon( #"flood_defend" );
    
    if ( isdefined( str_ender ) )
    {
        level endon( str_ender );
    }
    
    t_safe = getent( str_key, str_val );
    t_safe endon( #"death" );
    
    do
    {
        t_safe waittill( #"trigger" );
        n_touchers = 0;
        a_ai_enemies = getaispeciesarray( "axis", str_species );
        
        foreach ( ai_enemy in a_ai_enemies )
        {
            if ( isalive( ai_enemy ) && ai_enemy istouching( self ) )
            {
                n_touchers++;
            }
        }
        
        wait 1.5;
    }
    while ( n_touchers > 0 );
    
    wait n_delay;
}

// Namespace cp_mi_sing_sgen_flood
// Params 1
// Checksum 0x34504a44, Offset: 0x2c60
// Size: 0x32
function kill_fallback_spawnmanager( a_ents )
{
    level.ai_hendricks waittill( #"traversal_started" );
    spawn_manager::kill( "flood_combat_defend_room_fallback_spawns", 1 );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x5d2865db, Offset: 0x2ca0
// Size: 0xda
function set_doors_states_combat()
{
    level scene::init( "p7_fxanim_cp_sgen_door_bursting_01_bundle" );
    level thread sgen_util::set_door_state( "surgical_room_door", "open" );
    level thread sgen_util::set_door_state( "surgical_room_interior_entrance_doors_0", "open" );
    level thread sgen_util::set_door_state( "surgical_room_interior_entrance_doors_1", "open" );
    level thread sgen_util::set_door_state( "surgical_room_interior_entrance_doors_2", "open" );
    level thread sgen_util::set_door_state( "flood_robot_room_door_close", "close" );
    level thread sgen_util::set_door_state( "flood_robot_room_door_open", "open" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xe8df5ae8, Offset: 0x2d88
// Size: 0xc2
function set_doors_states_defend()
{
    level thread sgen_util::set_door_state( "surgical_room_interior_entrance_doors_0", "open" );
    level thread sgen_util::set_door_state( "surgical_room_interior_entrance_doors_1", "open" );
    level thread sgen_util::set_door_state( "surgical_room_interior_entrance_doors_2", "open" );
    level thread sgen_util::set_door_state( "flood_robot_room_door_close", "close" );
    level thread sgen_util::set_door_state( "flood_robot_crush_door", "close" );
    level thread sgen_util::set_door_state( "surgical_room_door", "close" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x8bbfaacc, Offset: 0x2e58
// Size: 0x12b
function handle_earthquakes()
{
    level endon( #"defend_time_expired" );
    level sgen_util::quake( 0.5, 1.5, sgen_util::get_players_center(), 5000, 4, 7 );
    
    while ( true )
    {
        if ( math::cointoss() )
        {
            v_origin = level.ai_hendricks.origin;
        }
        else
        {
            v_origin = sgen_util::get_players_center();
        }
        
        if ( isdefined( v_origin ) )
        {
            n_magnitude = randomfloatrange( 0.15, 0.25 );
            n_duration = randomfloatrange( 0.75, 1.78 );
            n_range = 5000;
            n_timeout = randomfloatrange( 8, 15 );
            level sgen_util::quake( n_magnitude, n_duration, v_origin, n_range );
            wait n_timeout + n_duration;
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xa124f4a8, Offset: 0x2f90
// Size: 0x7d
function handle_fallback_runners_cleanup()
{
    level endon( #"flood_combat_completed" );
    t_exit = getent( "flood_combat_flood_hall_cleanup_trig", "targetname" );
    
    while ( true )
    {
        t_exit waittill( #"trigger", ai_runner );
        level flag::set( "flood_runner_escaped" );
        ai_runner delete();
        wait 0.05;
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x997e1d6a, Offset: 0x3018
// Size: 0xe3
function issue_fallback()
{
    level.b_fallback_active = 1;
    a_ai_54i_humans = getaispeciesarray( "axis", "human" );
    
    foreach ( ai_human in a_ai_54i_humans )
    {
        n_wait = randomfloatrange( 0.15, 0.45 );
        wait n_wait;
        
        if ( isalive( ai_human ) )
        {
            ai_human thread fallback_think();
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x1dc7c6f, Offset: 0x3108
// Size: 0x11b
function cancel_fallback()
{
    level.b_fallback_active = 0;
    a_ai_54i_humans = getaispeciesarray( "axis", "human" );
    
    foreach ( ai_human in a_ai_54i_humans )
    {
        n_wait = randomfloatrange( 0.15, 0.45 );
        
        if ( isalive( ai_human ) )
        {
            ai_human ai::set_behavior_attribute( "sprint", 0 );
            ai_human notify( #"cancel_fallback" );
            ai_human.goalradius = 768;
            ai_human thread go_to_nearest_node( undefined, 768, 512 );
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 4
// Checksum 0x5eb355e8, Offset: 0x3230
// Size: 0x142
function go_to_nearest_node( v_origin, n_min, n_max, b_reverse )
{
    if ( !isdefined( v_origin ) )
    {
        v_origin = self.origin;
    }
    
    if ( !isdefined( n_min ) )
    {
        n_min = 256;
    }
    
    if ( !isdefined( n_max ) )
    {
        n_max = 512;
    }
    
    if ( !isdefined( b_reverse ) )
    {
        b_reverse = 0;
    }
    
    self endon( #"death" );
    a_nd_covers = getnodesinradiussorted( v_origin, n_min, n_max, -128 );
    
    if ( b_reverse && a_nd_covers.size > 1 )
    {
        a_nd_covers = array::reverse( a_nd_covers );
    }
    
    foreach ( nd_cover in a_nd_covers )
    {
        if ( !isnodeoccupied( nd_cover ) && isalive( self ) )
        {
            self setgoal( nd_cover );
            return;
        }
    }
    
    self setgoal( self.origin );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xee50707c, Offset: 0x3380
// Size: 0xdd
function issue_last_stand()
{
    level endon( #"flood_defend_complete" );
    t_combat_zone = getent( "flood_combat_prelab_zone_aitrig", "targetname" );
    t_last_stand_zone = getent( "flood_combat_defend_upper_goaltrig", "targetname" );
    t_combat_zone endon( #"death" );
    t_last_stand_zone endon( #"death" );
    t_combat_zone setinvisibletoall();
    
    while ( true )
    {
        t_combat_zone waittill( #"trigger", e_triggerer );
        
        if ( isalive( e_triggerer ) && e_triggerer.script_noteworthy !== "ignore_last_stand" )
        {
            e_triggerer notify( #"cancel_fallback" );
            e_triggerer setgoal( t_last_stand_zone );
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x65834fe1, Offset: 0x3468
// Size: 0x32
function stop_fallback_and_scatter()
{
    level endon( #"flood_defend_complete" );
    level waittill( #"flooded_lab_door_close" );
    cancel_fallback();
    issue_scatter();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xb70d2d37, Offset: 0x34a8
// Size: 0x19b
function issue_scatter()
{
    a_ai_54i = getaiteamarray( "axis" );
    t_last_stand_zone = getent( "flood_combat_defend_upper_goaltrig", "targetname" );
    t_combat_zone = getent( "flood_combat_prelab_zone_aitrig", "targetname" );
    s_center = struct::get( "flood_defend_flee_center" );
    
    foreach ( ai_54i in a_ai_54i )
    {
        n_wait = randomfloatrange( 0.15, 0.45 );
        
        if ( isalive( ai_54i ) && !ai_54i istouching( t_last_stand_zone ) && !ai_54i istouching( t_combat_zone ) )
        {
            ai_54i.accuracy = 0.1;
            ai_54i.health = 1;
            ai_54i thread go_to_nearest_node( s_center.origin, s_center.radius, s_center.radius, 1 );
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x5ef8466c, Offset: 0x3650
// Size: 0x10a
function handle_fallback()
{
    trigger::wait_till( "flood_combat_intro_fallback_trig" );
    level thread issue_fallback();
    trigger::wait_till( "flood_combat_charging_room_spawn_trig" );
    level thread cancel_fallback();
    level flag::wait_till( "flood_defend_start_flood_fallback" );
    trigger::use( "flood_combat_door_burst_trig" );
    level thread issue_fallback();
    trigger::wait_till( "flood_combat_robot_crushed_door_trig" );
    level thread cancel_fallback();
    trigger::wait_till( "flood_combat_prelab_spawn_trig" );
    level thread issue_fallback();
    level flag::wait_till( "flood_combat_surgical_room_door_close" );
    issue_last_stand();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xaeb18353, Offset: 0x3768
// Size: 0x2a
function fallback_spawnfunc()
{
    if ( isdefined( level.b_fallback_active ) && level.b_fallback_active )
    {
        self fallback_think();
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x416a6457, Offset: 0x37a0
// Size: 0x62
function fallback_think()
{
    nd_goal = getnode( "flood_combat_fallback_node", "targetname" );
    self ai::set_behavior_attribute( "sprint", 1 );
    self ai::force_goal( nd_goal, 256, 0, "cancel_fallback" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xba918704, Offset: 0x3810
// Size: 0x42
function alarm_sounds()
{
    array::thread_all( getentarray( "alarm_sound", "targetname" ), &play_looping_alarm );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xd4969b6b, Offset: 0x3860
// Size: 0x52
function play_looping_alarm()
{
    self playloopsound( "evt_flood_alarm_" + self.script_noteworthy );
    self waittill( #"stop_flood_sounds" );
    self stoploopsound( 0.5 );
    self util::self_delete();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xd3404823, Offset: 0x38c0
// Size: 0x42
function defend_room_set_state_risk_of_flooding()
{
    level thread scene::play( "water_lt_01", "targetname" );
    level scene::play( "water_rt_02", "targetname" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xf90116c1, Offset: 0x3910
// Size: 0x9a
function defend_room_set_state_flooding()
{
    level scene::init( "dividerl_lt_01", "targetname" );
    level scene::init( "divider_rt_02", "targetname" );
    level flag::wait_till( "flood_combat_start_flooding" );
    level thread flooding_sound_start();
    level thread flooding_water_sheeting();
    level thread handle_flooding_waterfall_lt();
    level thread handle_flooding_waterfall_rt();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x8cc0f6e2, Offset: 0x39b8
// Size: 0x82
function handle_flooding_waterfall_lt()
{
    level clientfield::set( "w_flood_combat_windows_b", 1 );
    wait 1.2;
    level thread scene::stop( "water_lt_01", "targetname", 1 );
    level thread scene::play( "water_lt_01_spill", "targetname" );
    level thread scene::play( "dividerl_lt_01", "targetname" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x2f92df6c, Offset: 0x3a48
// Size: 0x82
function handle_flooding_waterfall_rt()
{
    level clientfield::set( "w_flood_combat_windows_c", 1 );
    wait 0.93;
    level thread scene::stop( "water_rt_02", "targetname", 1 );
    level thread scene::play( "water_rt_02_spill", "targetname" );
    level thread scene::play( "divider_rt_02", "targetname" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x27f9c272, Offset: 0x3ad8
// Size: 0x92
function defend_room_set_state_flooded()
{
    level thread flooding_sound_start();
    level thread flooding_water_sheeting();
    level clientfield::set( "w_flood_combat_windows_b", 1 );
    level thread scene::skipto_end( "dividerl_lt_01", "targetname" );
    level clientfield::set( "w_flood_combat_windows_c", 1 );
    level thread scene::skipto_end( "divider_rt_02", "targetname" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x192c51aa, Offset: 0x3b78
// Size: 0x282
function flooding_sound_start()
{
    wait 1;
    flood_start_1 = getent( "flooding_start_1", "targetname" );
    flood_start_2 = getent( "flooding_start_2", "targetname" );
    torrent_gush_left = getent( "evt_torrent_gush_left", "targetname" );
    torrent_gush_right = getent( "evt_torrent_gush_right", "targetname" );
    torrent_surface_left = getent( "evt_torrent_gush_surface_l", "targetname" );
    torrent_surface_right = getent( "evt_torrent_gush_surface_r", "targetname" );
    
    if ( isdefined( flood_start_1 ) && isdefined( flood_start_2 ) )
    {
        playsoundatposition( "evt_flood_start_1", flood_start_1.origin );
        playsoundatposition( "evt_flood_start_2", flood_start_2.origin );
    }
    
    if ( isdefined( torrent_gush_left ) && isdefined( torrent_gush_right ) && isdefined( torrent_surface_left ) && isdefined( torrent_surface_right ) )
    {
        torrent_gush_left playloopsound( "evt_torrent_gush" );
        torrent_gush_right playloopsound( "evt_torrent_gush" );
        torrent_surface_left playloopsound( "evt_torrent_gush_surface" );
        torrent_surface_right playloopsound( "evt_torrent_gush_surface" );
        level waittill( #"stop_flood_sounds" );
        torrent_gush_left stoploopsound( 0.5 );
        torrent_gush_left delete();
        torrent_gush_right stoploopsound( 0.5 );
        torrent_gush_right delete();
        torrent_surface_left stoploopsound( 0.5 );
        torrent_surface_left delete();
        torrent_surface_right stoploopsound( 0.5 );
        torrent_surface_right delete();
        flood_start_1 delete();
        flood_start_2 delete();
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x66765acf, Offset: 0x3e08
// Size: 0x152
function flooding_water_sheeting()
{
    level endon( #"flood_defend_completed" );
    e_volume = getent( "flood_combat_water_sheeting", "targetname" );
    e_volume endon( #"death" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( e_volume ) )
            {
                if ( !( isdefined( player.tp_water_sheeting ) && player.tp_water_sheeting ) )
                {
                    player clientfield::set_to_player( "tp_water_sheeting", 1 );
                    player.tp_water_sheeting = 1;
                }
                
                continue;
            }
            
            if ( isdefined( player.tp_water_sheeting ) && player.tp_water_sheeting )
            {
                player clientfield::set_to_player( "tp_water_sheeting", 0 );
                player.tp_water_sheeting = 0;
            }
        }
        
        wait 1;
    }
    
    array::thread_all( level.players, &clientfield::set_to_player, "tp_water_sheeting", 0 );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x70ba5626, Offset: 0x3f68
// Size: 0x1d5
function water_spout_push()
{
    level endon( #"flood_combat_completed" );
    str_water_fx_origins = struct::get_array( self.target, "targetname" );
    v_dir = anglestoforward( ( 0, str_water_fx_origins[ 0 ].angles[ 1 ], 0 ) );
    v_org = str_water_fx_origins[ 0 ].origin;
    v_length = -128;
    array::thread_all( str_water_fx_origins, &loop_water_spout_fx, self );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !player isonground() && isdefined( player.last_air_push_time ) && gettime() - player.last_air_push_time < 1000 )
        {
            continue;
        }
        
        n_distance = distance2d( v_org, player.origin );
        
        if ( n_distance > v_length )
        {
            continue;
        }
        
        if ( player issprinting() && n_distance > v_length * 0.4 )
        {
            continue;
        }
        
        n_push_strength = mapfloat( 0, v_length, 80, 0, n_distance );
        v_player_velocity = player getvelocity();
        player setvelocity( v_player_velocity + v_dir * n_push_strength );
        
        if ( !player isonground() )
        {
            player.last_air_push_time = gettime();
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 1
// Checksum 0x53f48335, Offset: 0x4148
// Size: 0x112
function loop_water_spout_fx( trigger )
{
    level endon( #"flood_combat_completed" );
    e_fx_origin = util::spawn_model( "tag_origin", self.origin, self.angles );
    e_fx_origin.script_objective = "flood_defend";
    trigger::wait_till( self.target, undefined, undefined, 0 );
    
    if ( isdefined( trigger.script_string ) )
    {
        level thread scene::play( trigger.script_string );
        level thread sgen_util::quake( 0.35, randomfloatrange( 0.8, 1.4 ), sgen_util::get_players_center(), 5000, 1, 2 );
    }
    
    e_fx_origin playsound( "evt_pipe_break" );
    e_fx_origin playloopsound( "evt_water_pipe_flow" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x52d92ae6, Offset: 0x4268
// Size: 0x82
function play_surgical_room_door_scene()
{
    ai_door = spawner::simple_spawn_single( "surgical_room_door_close_guy_spawner" );
    level util::delay( 2, "death", &sgen_util::set_door_state, "surgical_room_door", "close" );
    
    if ( isalive( ai_door ) )
    {
        ai_door fallback_think();
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x7d80c0d1, Offset: 0x42f8
// Size: 0x4a
function surgical_room_entrance_close_resistance()
{
    level thread surgical_room_entrance_close_resistance_earthquake();
    level waittill( #"floor_door_open" );
    spawn_manager::disable( "flood_combat_reinforcements" );
    spawn_manager::kill( "flood_combat_reinforcements_human" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xdb60ba4f, Offset: 0x4350
// Size: 0x75
function surgical_room_entrance_close_resistance_earthquake()
{
    level endon( #"floor_door_open" );
    
    while ( true )
    {
        level sgen_util::quake( 0.35, randomfloatrange( 0.8, 1.4 ), sgen_util::get_players_center(), 5000, 1, 2 );
        wait randomintrange( 8, 15 );
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 1
// Checksum 0xbf88fb76, Offset: 0x43d0
// Size: 0x242
function defend_logic( b_starting )
{
    level thread play_flood_hallway_kill_scene();
    level thread handle_flood_hallway();
    level thread stop_fallback_and_scatter();
    spawner::add_spawn_function_group( "flood_defend_runner", "script_noteworthy", &function_3ed2d232 );
    
    if ( b_starting )
    {
        level thread play_hendricks_defend_scene();
    }
    
    level flag::wait_till( "defend_ready" );
    level flag::set( "flood_defend_enemies_spawning" );
    spawn_manager::enable( "flood_combat_reinforcements" );
    level thread catwalk_zone_anti_camper_measures();
    level flag::wait_till( "hendricks_defend_started" );
    spawn_manager::enable( "flood_combat_reinforcements_human" );
    level thread namespace_d40478f6::function_72ef07c3();
    level.ai_hendricks ai::set_ignoreall( 1 );
    level thread surgical_room_entrance_close_resistance();
    wait 18;
    level notify( #"hash_5097097b" );
    wait 12;
    level notify( #"defend_time_near" );
    wait 7;
    level flag::set( "defend_time_expired" );
    t_flood_hint_trigger = getent( "floor_door_hint_trigger", "targetname" );
    objectives::set( "cp_level_sgen_use_door", t_flood_hint_trigger.origin );
    var_8ad7c437 = util::init_interactive_gameobject( t_flood_hint_trigger, &"cp_prompt_enter_sgen_door", &"CP_MI_SING_SGEN_FLOOD_USE_DOOR", &function_d0378b1a );
    level waittill( #"hash_37c452a9" );
    objectives::complete( "cp_level_sgen_use_door" );
    objectives::set( "cp_level_sgen_get_to_surface" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x51a7a481, Offset: 0x4620
// Size: 0x5a
function function_3ed2d232()
{
    self ai::set_behavior_attribute( "sprint", 1 );
    self waittill( #"goal" );
    self ai::set_behavior_attribute( "sprint", 0 );
    self ai::set_behavior_attribute( "move_mode", "rambo" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 1
// Checksum 0x19ce185e, Offset: 0x4688
// Size: 0x162
function function_d0378b1a( e_player )
{
    level notify( #"floor_door_open" );
    level thread namespace_d40478f6::function_973b77f9();
    self gameobjects::disable_object();
    objectives::complete( "cp_level_sgen_use_door" );
    
    if ( isdefined( level.bzm_sgendialogue8_2callback ) )
    {
        level thread [[ level.bzm_sgendialogue8_2callback ]]();
    }
    
    scene::add_scene_func( "cin_sgen_22_01_release_torrent_1st_flood_hendricks", &handle_flood_door_animation, "play" );
    level thread scene::play( "cin_sgen_22_01_release_torrent_1st_flood_hendricks", level.ai_hendricks );
    scene::add_scene_func( "cin_sgen_22_01_release_torrent_1st_flood_player", &play_water_teleport_fx, "play" );
    level scene::play( "cin_sgen_22_01_release_torrent_1st_flood_player", e_player );
    level notify( #"stop_flood_sounds" );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_hendricks colors::enable();
    spawn_manager::kill( "flood_defend_catwalk_spawn_zone_spawnmanager", 1 );
    level notify( #"hash_37c452a9" );
    self gameobjects::destroy_object( 1 );
}

// Namespace cp_mi_sing_sgen_flood
// Params 1
// Checksum 0x9850bb95, Offset: 0x47f8
// Size: 0x83
function play_water_teleport_fx( a_ents )
{
    level endon( #"hash_6ede777e" );
    wait 1.5;
    
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "water_teleport", 1 );
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 1
// Checksum 0x5aea91e4, Offset: 0x4888
// Size: 0x7b
function stop_water_teleport_fx( a_ents )
{
    level notify( #"hash_6ede777e" );
    
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "water_teleport", 0 );
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x7efc7857, Offset: 0x4910
// Size: 0xc2
function function_28b80c6f()
{
    trigger::wait_till( "trig_hallway_ceiling_collapse_01" );
    level clientfield::set( "ceiling_collapse", 1 );
    trigger::wait_till( "trig_hallway_ceiling_collapse_02" );
    level clientfield::set( "ceiling_collapse", 2 );
    trigger::wait_till( "trig_hallway_ceiling_collapse_03" );
    level clientfield::set( "ceiling_collapse", 3 );
    trigger::wait_till( "trig_hallway_ceiling_collapse_04" );
    level clientfield::set( "ceiling_collapse", 4 );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x7a0e5522, Offset: 0x49e0
// Size: 0x192
function play_hendricks_defend_scene()
{
    nd_goto = getnode( "hendricks_flood_combat_wait", "targetname" );
    level.ai_hendricks setgoal( nd_goto.origin );
    level flag::wait_till( "defend_ready" );
    t_area = getent( "flood_defend_defend_room_zone_trig", "targetname" );
    var_a3eb613f = 1;
    
    while ( var_a3eb613f )
    {
        var_a3eb613f = 0;
        a_ai_enemies = getaiteamarray( "axis" );
        
        foreach ( ai_enemy in a_ai_enemies )
        {
            if ( ai_enemy istouching( t_area ) )
            {
                var_a3eb613f = 1;
                break;
            }
        }
        
        wait 0.2;
    }
    
    level scene::play( "cin_sgen_22_01_release_torrent_vign_flood_new_hendricks_hackdoor", level.ai_hendricks );
    level flag::set( "hendricks_defend_started" );
    level thread scene::play( "cin_sgen_22_01_release_torrent_vign_flood_new_hendricks_grabdoor", level.ai_hendricks );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x271df53b, Offset: 0x4b80
// Size: 0x6a
function hendricks_defend_movement()
{
    level.ai_hendricks colors::disable();
    level.ai_hendricks.goalradius = 16;
    nd_goal = getnode( "flood_defend_hendricks_ready_node", "targetname" );
    level.ai_hendricks setgoal( nd_goal );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xeb4dc13e, Offset: 0x4bf8
// Size: 0x62
function charging_station_cleanup()
{
    level thread sgen_util::set_door_state( "charging_station_entrance", "close" );
    array::thread_all( getentarray( "pod_track_model", "targetname" ), &util::self_delete );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x8f27ce05, Offset: 0x4c68
// Size: 0x52
function reinforcement_robot_setup()
{
    self ai::set_behavior_attribute( "force_cover", 1 );
    self ai::set_behavior_attribute( "sprint", 1 );
    self ai::set_behavior_attribute( "move_mode", "rambo" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x54f6f6a4, Offset: 0x4cc8
// Size: 0x165
function catwalk_zone_anti_camper_measures()
{
    t_zone = getent( "flood_defend_catwalk_spawn_zone_trig", "targetname" );
    e_spawnmanager = getent( t_zone.target, "targetname" );
    t_zone endon( #"death" );
    t_zone waittill( #"trigger" );
    level thread sgen_util::set_door_state( "flood_robot_room_door_close", "open" );
    level thread sgen_util::set_door_state( "flood_robot_room_door_open", "close" );
    
    while ( isdefined( t_zone ) )
    {
        t_zone waittill( #"trigger" );
        
        if ( !spawn_manager::is_enabled( e_spawnmanager.targetname ) )
        {
            spawn_manager::enable( e_spawnmanager.targetname );
        }
        
        set_ignoreall_array( "flood_defend_catwalk_spawn_zone_robot", undefined, 0 );
        level flag::wait_till( "flood_defend_catwalk_spawn_zone_unoccupied" );
        set_ignoreall_array( "flood_defend_catwalk_spawn_zone_robot" );
        spawn_manager::disable( e_spawnmanager.targetname );
        t_zone thread kill_anti_campers();
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x7c2856ee, Offset: 0x4e38
// Size: 0xa3
function kill_anti_campers()
{
    self endon( #"death" );
    self endon( #"trigger" );
    wait 4;
    a_ai_robots = getentarray( "flood_defend_catwalk_spawn_zone_robot" + "_ai", "targetname" );
    
    foreach ( ai_kill in a_ai_robots )
    {
        ai_kill kill();
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 3
// Checksum 0x3c81b667, Offset: 0x4ee8
// Size: 0x7a
function set_ignoreall_array( str_spawner_name, str_key, b_ignore )
{
    if ( !isdefined( str_key ) )
    {
        str_key = "targetname";
    }
    
    if ( !isdefined( b_ignore ) )
    {
        b_ignore = 1;
    }
    
    a_ai_ignorers = getentarray( str_spawner_name + "_ai", str_key );
    array::thread_all( a_ai_ignorers, &ai::set_ignoreall, b_ignore );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x934255af, Offset: 0x4f70
// Size: 0x1a
function play_rejoin_scene()
{
    level scene::play( "cin_sgen_21_03_floodcombat_vign_rejoin" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x9642a985, Offset: 0x4f98
// Size: 0x52
function play_robot_door_scene()
{
    level flag::wait_till( "flood_combat_door_crush_robot_start" );
    level thread scene::play( "cin_sgen_21_02_floodcombat_vign_escape_robot01" );
    level waittill( #"crushed_robot_door_water_spray_start" );
    trigger::use( "sgen_robot_crushed_water_trig" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x609c0b97, Offset: 0x4ff8
// Size: 0xa2
function play_flood_hallway_kill_scene()
{
    ai_doorman = spawner::simple_spawn_single( "flood_defend_flood_door_guy" );
    level scene::init( "cin_sgen_21_03_surgical_room_vign_closedoor_54i01", ai_doorman );
    trigger::wait_till( "flood_defend_defend_area_trig" );
    
    if ( isalive( ai_doorman ) )
    {
        ai_doorman ai::set_ignoreall( 1 );
        ai_doorman ai::set_ignoreme( 1 );
        level scene::play( "cin_sgen_21_03_surgical_room_vign_closedoor_54i01", ai_doorman );
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x4cb89b04, Offset: 0x50a8
// Size: 0x7a
function handle_flood_hallway()
{
    level thread scene::play( "p7_fxanim_cp_sgen_debris_hallway_flood_bundle" );
    level clientfield::set( "flood_defend_hallway_flood_siege", 1 );
    level thread handle_wave_kill_area();
    level waittill( #"debris_hallway_doors_shut_start" );
    level thread flood_wave_sound();
    level scene::init( "fxanim_flooded_lab_door", "targetname" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x64696b9f, Offset: 0x5130
// Size: 0x92
function flood_wave_sound()
{
    flood_emitter = spawn( "script_origin", ( 26360, 1575, -6604 ) );
    level waittill( #"play_flood_door_impact" );
    flood_emitter playsound( "evt_flood_door_impact" );
    flood_emitter playloopsound( "evt_flood_metal_stress", 2 );
    level waittill( #"floor_door_open" );
    flood_emitter stoploopsound( 2 );
    flood_emitter delete();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xbcd10c04, Offset: 0x51d0
// Size: 0x142
function handle_wave_kill_area()
{
    s_kill_center = struct::get( "flood_defend_wave_source_spot" );
    level waittill( #"debris_hallway_start_radial_kill_pulse" );
    a_ai_54i = getaispeciesarray( "axis", "human" );
    a_ai_54i = arraysortclosest( a_ai_54i, s_kill_center.origin );
    
    foreach ( ai_54i in a_ai_54i )
    {
        wait randomfloatrange( 0.2, 0.32 );
        
        if ( isalive( ai_54i ) && distance2d( ai_54i.origin, s_kill_center.origin ) <= s_kill_center.radius )
        {
            ai_54i kill();
        }
    }
    
    level flag::set( "flood_defend_flood_hallway_kill_zone_enabled" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x2ffcba21, Offset: 0x5320
// Size: 0x62
function set_pipes_states_combat()
{
    level scene::init( "p7_fxanim_cp_sgen_pipes_bursting_01_bundle" );
    level scene::init( "p7_fxanim_cp_sgen_pipes_bursting_02_bundle" );
    level scene::init( "p7_fxanim_cp_sgen_pipes_bursting_03_bundle" );
    level scene::init( "p7_fxanim_cp_sgen_pipes_bursting_04_bundle" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 1
// Checksum 0xb4f2969d, Offset: 0x5390
// Size: 0x32
function handle_flood_door_animation( a_ents )
{
    level waittill( #"hash_b1ecfdaa" );
    level scene::play( "fxanim_flooded_lab_door", "targetname" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xc4bafd29, Offset: 0x53d0
// Size: 0x1b2
function combat_vo()
{
    level.ai_hendricks dialog::say( "hend_what_the_hell_was_0", randomfloatrange( 0.2, 0.3 ) );
    level.ai_hendricks dialog::say( "plyr_sounds_like_taylor_s_0", randomfloatrange( 0.2, 0.3 ) );
    level flag::wait_till( "pallas_lift_front_open" );
    level dialog::remote( "kane_hendricks_we_have_m_0", randomfloatrange( 0.1, 0.25 ) );
    level.ai_hendricks dialog::say( "hend_you_heard_her_let_0", randomfloatrange( 0.2, 0.3 ) );
    level dialog::remote( "kane_overwatch_drone_show_0", randomfloatrange( 0.5, 0.76 ) );
    level thread do_security_room_nag();
    trigger::wait_till( "flood_combat_charging_station_zone_trig" );
    level.ai_hendricks dialog::say( "hend_get_through_them_we_0" );
    level thread do_charging_room_nag();
    level thread important_story_vo();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x1f16ea92, Offset: 0x5590
// Size: 0xfb
function do_security_room_nag()
{
    level endon( #"flood_combat_completed" );
    n_nag_min = 3;
    n_nag_max = 4;
    n_index = 0;
    a_str_nags = [];
    a_str_nags[ 0 ] = "hend_keep_moving_the_wh_0";
    a_str_nags[ 1 ] = "hend_go_go_go_0";
    
    while ( n_index < a_str_nags.size )
    {
        trigger::wait_till( "flood_combat_security_room_zone_trig" );
        
        if ( !level flag::get( "flood_combat_nag_playing" ) )
        {
            level flag::set( "flood_combat_nag_playing" );
            level.ai_hendricks dialog::say( a_str_nags[ n_index ] );
            n_index++;
            level flag::clear( "flood_combat_nag_playing" );
            n_nag_time = randomfloatrange( n_nag_min, n_nag_max );
            wait n_nag_time;
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0xa2a13ddc, Offset: 0x5698
// Size: 0x105
function do_charging_room_nag()
{
    level endon( #"flood_combat_completed" );
    n_nag_min = 3;
    n_nag_max = 6;
    n_index = 0;
    a_str_nags = [];
    a_str_nags[ 0 ] = "hend_get_through_them_we_0";
    a_str_nags[ 1 ] = "hend_don_t_stop_move_m_0";
    a_str_nags[ 2 ] = "hend_fucking_move_0";
    
    while ( n_index < a_str_nags.size )
    {
        n_nag_time = randomfloatrange( n_nag_min, n_nag_max );
        wait n_nag_time;
        trigger::wait_till( "flood_combat_charging_station_zone_trig" );
        
        if ( !level flag::get( "flood_combat_nag_playing" ) )
        {
            level flag::set( "flood_combat_nag_playing" );
            level.ai_hendricks dialog::say( a_str_nags[ n_index ] );
            n_index++;
            level flag::clear( "flood_combat_nag_playing" );
        }
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x74dae5b8, Offset: 0x57a8
// Size: 0x92
function important_story_vo()
{
    trigger::wait_till( "important_story_vo", "targetname" );
    level dialog::say( "plyr_start_scanning_for_t_0", randomfloatrange( 0.5, 0.76 ) );
    level dialog::remote( "kane_i_m_scanning_file_tr_0", randomfloatrange( 0.75, 1.25 ) );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x5c3b55df, Offset: 0x5848
// Size: 0x21a
function defend_vo()
{
    trigger::wait_or_timeout( 20, "flood_defend_defend_area_trig" );
    level thread util::clientnotify( "escps" );
    level dialog::player_say( "plyr_kane_i_hope_you_go_0" );
    level dialog::remote( "kane_alright_i_ll_talk_y_0", randomfloatrange( 0.1, 0.25 ) );
    level.ai_hendricks dialog::say( "hend_what_are_you_insan_0", randomfloatrange( 0.1, 0.25 ) );
    level dialog::remote( "kane_not_if_this_works_y_0", randomfloatrange( 0.1, 0.25 ) );
    level.ai_hendricks dialog::say( "hend_okay_okay_but_if_t_0", randomfloatrange( 0.1, 0.25 ) );
    level flag::set( "defend_ready" );
    level waittill( #"hash_5097097b" );
    level dialog::remote( "kane_i_ve_id_d_the_surviv_0" );
    level dialog::player_say( "plyr_all_in_good_time_ka_0", 0.3 );
    level waittill( #"defend_time_near" );
    level.ai_hendricks dialog::say( "hend_just_a_few_more_seco_0", randomfloatrange( 0.1, 0.25 ) );
    level waittill( #"defend_time_expired" );
    level.ai_hendricks dialog::say( "hend_give_me_a_hand_0" );
    level.ai_hendricks thread do_defend_nag();
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x91efc60d, Offset: 0x5a70
// Size: 0xdb
function do_defend_nag()
{
    level endon( #"floor_door_open" );
    a_str_nags = [];
    a_str_nags[ 0 ] = "hend_c_mon_we_gotta_get_o_0";
    a_str_nags[ 1 ] = "hend_the_whole_building_s_0";
    a_str_nags[ 2 ] = "hend_what_are_you_waiting_3";
    a_str_nags[ 3 ] = "hend_help_me_with_the_doo_0";
    
    foreach ( n_index, str_nag in a_str_nags )
    {
        wait randomfloatrange( 3, 6 );
        level.ai_hendricks dialog::say( a_str_nags[ n_index ], randomfloatrange( 0.1, 0.25 ) );
    }
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x43a0a707, Offset: 0x5b58
// Size: 0x1a
function handle_breadcrumbs()
{
    objectives::breadcrumb( "flood_combat_start_breadcrumb_trig" );
}

// Namespace cp_mi_sing_sgen_flood
// Params 0
// Checksum 0x1388e111, Offset: 0x5b80
// Size: 0x62
function handle_defend_breadcrumbs()
{
    level thread objectives::breadcrumb( "flood_combat_breadcrumb_end_trig" );
    level flag::wait_till( "hendricks_defend_started" );
    objectives::complete( "cp_waypoint_breadcrumb" );
    level flag::wait_till( "defend_time_expired" );
}

