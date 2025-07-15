#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_city;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace zurich_street;

// Namespace zurich_street
// Params 0
// Checksum 0x7ab9a53a, Offset: 0x18e8
// Size: 0x3a
function main()
{
    scene::add_scene_func( "p7_fxanim_cp_zurich_parking_wall_explode_bundle", &zurich_util::function_9f90bc0f, "done", "garage_ambient_cleanup" );
}

// Namespace zurich_street
// Params 2
// Checksum 0xfa550f78, Offset: 0x1930
// Size: 0x4ea
function skipto_main( str_objective, b_starting )
{
    level flag::init( "garage_entrance_attack" );
    level flag::init( "garage_entrance_cleared" );
    level flag::init( "garage_entrance_open" );
    level flag::init( "garage_ramp_cleared" );
    level flag::init( "street_clear" );
    level flag::init( "street_phalanx_scatter" );
    level flag::init( "street_truck_cover_available" );
    level flag::init( "street_intro_intersection_cleared" );
    callback::on_spawned( &on_player_spawned );
    spawner::add_spawn_function_group( "street_robot_custom_entry", "script_string", &function_9ae7d78 );
    spawner::add_spawn_function_group( "street_vehicle_ai_splined_entry", "script_noteworthy", &function_c89b08c9 );
    spawner::add_spawn_function_group( "garage_intro_guys", "script_noteworthy", &function_748fa5c2 );
    spawner::add_spawn_function_group( "garage_2nd_floor_intro_guys", "script_noteworthy", &function_9ff08320 );
    spawner::add_spawn_function_group( "street_intro_guys", "script_noteworthy", &function_721c929f );
    spawner::add_spawn_function_group( "robot_phalanx", "script_noteworthy", &function_721c929f );
    spawner::add_spawn_function_group( "street_turret_spawn_manager_robot", "targetname", &function_dcb29c2c );
    spawner::add_spawn_function_group( "garage_breach_street_enemy", "targetname", &function_2ad4a40f );
    spawner::add_spawn_function_group( "garage_breach_rushers", "script_aigroup", &function_42881589 );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        zurich_util::init_kane( str_objective, 1 );
        level.ai_kane.goalradius = 32;
        var_35a3121c = zurich_util::function_b0dd51f4( "zurich_street_redshirts" );
        trigger::use( "zurich_street_start_colortrig" );
        zurich_city::function_e3750802();
        level thread zurich_city::function_ab4451a1();
        level.var_ebb30c1a = [];
        function_48166ad7();
        level clientfield::set( "intro_ambience", 1 );
        exploder::exploder( "streets_tower_wasp_swarm" );
        level clientfield::set( "zurich_city_ambience", 1 );
        level thread function_1be1a835();
        level thread namespace_67110270::function_db37681();
        level thread zurich_city::function_da30164f();
        load::function_a2995f22();
    }
    
    vh_turret = spawner::simple_spawn_single( "street_turret", &function_5268b119 );
    level thread function_ce297ff6( b_starting );
    level thread function_1b074d61();
    level thread zurich_city::function_9b9c35d7();
    street_main();
    level clientfield::set( "intro_ambience", 0 );
    var_62e3398b = getspawnerarray( "robot_phalanx", "script_noteworthy" );
    array::thread_all( var_62e3398b, &spawner::remove_spawn_function, &function_721c929f );
    callback::remove_on_spawned( &on_player_spawned );
    skipto::objective_completed( str_objective );
}

// Namespace zurich_street
// Params 4
// Checksum 0x1301b9a4, Offset: 0x1e28
// Size: 0x4a
function skipto_done( str_objective, b_starting, b_direct, player )
{
    zurich_util::enable_surreal_ai_fx( 0 );
    level thread zurich_util::function_4a00a473( "street" );
}

// Namespace zurich_street
// Params 0
// Checksum 0x50ba55, Offset: 0x1e80
// Size: 0x42a
function street_main()
{
    zurich_util::enable_nodes( "garage_entrance_nodes", "script_noteworthy", 0 );
    zurich_util::enable_nodes( "garage_intro_enemies", undefined, 0 );
    level scene::init( "p7_fxanim_cp_zurich_parking_wall_explode_bundle" );
    level thread function_1b8ff897();
    level thread function_9a1931bc();
    vh_vtol = getvehiclenode( "street_garage_vtol", "targetname" ) zurich_util::function_a569867c( undefined, &vtol_spawnfunc );
    level thread function_c8cc9a0d();
    level thread function_6a364612();
    level thread function_ba4b9ec5();
    level flag::wait_till( "street_battle_intersection_reached" );
    wait 0.05;
    zurich_util::function_33ec653f( "street_intersection_raven_soldier_spawn_manager", undefined, undefined, &zurich_util::function_d065a580 );
    level.ai_kane thread function_4e8285e0();
    level flag::wait_till( "street_civs_start" );
    level thread zurich_util::spawn_phalanx( "street_phalanx", "phalanx_forward", 6, 1, undefined, "street_phalanx_scatter", 2 );
    wait 0.05;
    spawn_manager::enable( "street_spawn_manager" );
    level flag::wait_till( "street_balcony_spawn_closet_available" );
    vh_vtol = getvehiclenode( "street_garage_vtol2", "targetname" ) zurich_util::function_a569867c( undefined, &vtol_spawnfunc );
    wait 0.05;
    spawn_manager::enable( "street_balcony_reinforcement_spawn_manager" );
    zurich_util::function_33ec653f( "street_garage_roof_raven_soldier_spawn_manager", undefined, undefined, &zurich_util::function_d065a580 );
    spawn_manager::wait_till_ai_remaining( "street_balcony_reinforcement_spawn_manager", 2 );
    a_ai_robots = spawn_manager::get_ai( "street_balcony_reinforcement_spawn_manager" );
    
    foreach ( ai in a_ai_robots )
    {
        if ( ai.script_noteworthy === "street_balcony_robot_sniper" )
        {
            continue;
        }
        
        ai ai::set_behavior_attribute( "move_mode", "rusher" );
    }
    
    a_ai_wasps = spawn_manager::get_ai( "street_wasp_spawn_manager" );
    array::thread_all( a_ai_wasps, &function_90c5d999 );
    spawn_manager::kill( "street_spawn_manager", 1 );
    level flag::set( "street_clear" );
    savegame::checkpoint_save();
    wait 3;
    var_66b24a60 = zurich_util::function_3789d4db( "street_garage_entrance_open_trig", undefined, 700, 768 );
    var_66b24a60 thread function_3a6344d1( 5 );
    var_66b24a60 waittill( #"trigger" );
    var_66b24a60 delete();
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    function_4d92b2c7();
    level flag::set( "garage_entrance_open" );
}

// Namespace zurich_street
// Params 0
// Checksum 0x327097bf, Offset: 0x22b8
// Size: 0x72
function function_ba4b9ec5()
{
    level.ai_kane dialog::say( "kane_what_does_it_want_0", 1 );
    level dialog::player_say( "plyr_right_now_i_think_i_0", 1 );
    level.ai_kane dialog::say( "kane_it_knows_we_re_comin_0", 1 );
}

// Namespace zurich_street
// Params 0
// Checksum 0x5716d2b0, Offset: 0x2338
// Size: 0xea
function function_242cb817()
{
    level flag::wait_till( "garage_entrance_cleared" );
    level.ai_kane dialog::say( "kane_we_have_to_move_thro_0", 1 );
    level flag::wait_till( "flag_start_plyr_controlling_vo" );
    level dialog::player_say( "plyr_controlling_these_ro_0", 1 );
    trigger::wait_for_either( "garage_kane_rooftop_colortrig", "garage_kane_exit_colortrig" );
    level.ai_kane dialog::say( "kane_stay_with_me_3", 1 );
    level.ai_kane dialog::say( "kane_we_ll_get_through_th_0", 2 );
    level flag::set( "flag_start_kane_it_won_t_vo_done" );
}

// Namespace zurich_street
// Params 2
// Checksum 0x2024427b, Offset: 0x2430
// Size: 0x472
function function_568e2e07( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level flag::init( "garage_entrance_attack" );
        level flag::init( "garage_entrance_cleared" );
        level flag::init( "garage_entrance_open" );
        level flag::init( "garage_ramp_cleared" );
        level flag::init( "street_truck_cover_available", 1 );
        level flag::set( "street_balcony_spawn_closet_available" );
        spawner::add_spawn_function_group( "street_robot_custom_entry", "script_string", &function_9ae7d78 );
        spawner::add_spawn_function_group( "street_vehicle_ai_splined_entry", "script_noteworthy", &function_c89b08c9 );
        spawner::add_spawn_function_group( "garage_breach_rushers", "script_aigroup", &function_42881589 );
        spawner::add_spawn_function_group( "garage_intro_guys", "script_noteworthy", &function_748fa5c2 );
        spawner::add_spawn_function_group( "garage_2nd_floor_intro_guys", "script_noteworthy", &function_9ff08320 );
        spawner::add_spawn_function_group( "garage_breach_street_enemy", "targetname", &function_2ad4a40f );
        zurich_util::init_kane( str_objective, 1 );
        level scene::init( "p7_fxanim_cp_zurich_parking_wall_explode_bundle" );
        level.var_ebb30c1a = [];
        level thread function_1b074d61();
        function_48166ad7( str_objective );
        load::function_a2995f22();
        wait 0.05;
        zurich_city::function_e3750802();
        wait 0.05;
        vh_turret = spawner::simple_spawn_single( "street_turret", &function_5268b119 );
        wait 0.05;
        a_ai_allies = zurich_util::function_33ec653f( "garage_skipto_allies_spawn_manager" );
        
        for ( i = 0; i < 2 ; i++ )
        {
            if ( !isalive( a_ai_allies[ i ] ) )
            {
                continue;
            }
            
            a_ai_allies[ i ] util::magic_bullet_shield();
        }
        
        level thread function_8535a819();
        exploder::exploder( "streets_tower_wasp_swarm" );
        level clientfield::set( "zurich_city_ambience", 1 );
        level thread zurich_city::function_ab4451a1();
        zurich_util::enable_nodes( "garage_entrance_nodes", "script_noteworthy", 0 );
        zurich_util::enable_nodes( "garage_intro_enemies", undefined, 0 );
        level thread namespace_67110270::function_db37681();
        level thread zurich_city::function_da30164f();
        level thread function_a0abe6b6();
    }
    
    level thread function_410cfaac( b_starting );
    level thread function_242cb817();
    level thread zurich_util::function_c83720c9();
    init_elevators();
    function_ec9dd4a5();
    function_b7d40ae();
    function_7a0e84a8();
    level notify( #"hash_c7263fa8" );
    level thread zurich_util::function_2361541e( "garage" );
    garage_main();
    level thread function_d987ae9();
    skipto::objective_completed( str_objective );
}

// Namespace zurich_street
// Params 4
// Checksum 0x9f2145ac, Offset: 0x28b0
// Size: 0x4a
function skipto_garage_done( str_objective, b_starting, b_direct, player )
{
    zurich_util::enable_surreal_ai_fx( 0 );
    level thread zurich_util::function_4a00a473( "garage" );
}

// Namespace zurich_street
// Params 0
// Checksum 0xfcc29894, Offset: 0x2908
// Size: 0x683
function garage_main()
{
    level thread function_1c9e622e();
    level thread function_dc91abc9();
    level thread function_b3a34ca5();
    level thread function_34ad4dc8();
    level flag::wait_till( "garage_entrance_open" );
    
    if ( isdefined( level.bzm_zurichdialogue1_1callback ) )
    {
        level thread [[ level.bzm_zurichdialogue1_1callback ]]();
    }
    
    zurich_util::enable_nodes( "garage_entrance_nodes", "script_noteworthy" );
    zurich_util::enable_nodes( "garage_intro_enemies" );
    spawn_manager::enable( "street_garage_breach_spawn_manger" );
    wait 0.05;
    spawn_manager::enable( "garage_allies_spawn_manager" );
    wait 0.05;
    level thread zurich_util::function_33ec653f( "garage_intro_enemy_fake_spawn_manager", undefined, undefined, &function_748fa5c2 );
    wait 0.05;
    spawn_manager::kill( "street_allies_spawn_manager", 1 );
    level thread function_b863f1b1();
    trigger::wait_till( "street_exit_zone_trig" );
    a_ai_robots = spawn_manager::get_ai( "street_turret_spawn_manager" );
    array::thread_all( a_ai_robots, &function_bb52655d );
    spawn_manager::kill( "street_turret_spawn_manager", 1 );
    
    if ( level.players.size < 3 )
    {
        a_ai_snipers = getentarray( "street_balcony_robot_sniper", "script_noteworthy" );
        
        foreach ( ai in a_ai_snipers )
        {
            if ( isalive( ai ) )
            {
                ai kill();
            }
        }
    }
    
    level thread function_1418d19();
    var_9f88d117 = getent( "garage_intro_glass_weapon_clip", "targetname" );
    var_9f88d117 delete();
    trigger::wait_till( "garage_ramp_spawn_manager_trig" );
    level thread spawn_manager::run_func_when_complete( "garage_ramp_spawn_manager", &function_bdb3b32d );
    spawn_manager::enable( "garage_ramp_spawn_manager" );
    trigger::wait_till( "garage_robots_spawn_manager_trig" );
    spawn_manager::enable( "garage_robots_spawn_manager" );
    spawn_manager::enable( "garage_2nd_floor_allies_spawn_manager" );
    trigger::wait_till( "garage_third_floor_trig" );
    savegame::checkpoint_save();
    level thread function_e804203a();
    level flag::wait_till( "garage_end_phalanx_scatter" );
    var_b2d1f880 = getent( "garage_upper_floor_left_goaltrig", "targetname" );
    var_d587bca1 = getent( "garage_upper_floor_right_goaltrig", "targetname" );
    var_bb5c7c43 = getent( "garage_exit_gate_left_trig", "targetname" );
    var_678e7878 = getent( "garage_exit_gate_right_trig", "targetname" );
    a_ai_enemies = getaispeciesarray( "axis", "robot" );
    array::run_all( a_ai_enemies, &function_932e49ba, var_b2d1f880, var_d587bca1, var_bb5c7c43, var_678e7878 );
    level flag::wait_till( "garage_gate_open" );
    var_26d693b1 = spawner::get_ai_group_ai( "intro_hero_redshirts" );
    array::run_all( var_26d693b1, &util::stop_magic_bullet_shield );
    savegame::checkpoint_save();
    spawn_manager::kill( "garage_ramp_spawn_manager", 1 );
    spawn_manager::kill( "garage_robots_spawn_manager", 1 );
    spawn_manager::kill( "garage_2nd_floor_allies_spawn_manager", 1 );
    a_ai_enemies = getaispeciesarray( "axis", "robot" );
    
    foreach ( ai in a_ai_enemies )
    {
        if ( !ai istouching( var_bb5c7c43 ) && !ai istouching( var_678e7878 ) )
        {
            ai kill();
        }
    }
    
    trigger::wait_till( "garage_exit_zone_trig" );
    
    if ( level.players.size == 1 )
    {
        a_ai_enemies = getaispeciesarray( "axis", "robot" );
        
        foreach ( ai in a_ai_enemies )
        {
            ai.overrideactordamage = &zurich_util::function_8ac3f026;
        }
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0x67025f69, Offset: 0x2f98
// Size: 0x5a
function function_bb52655d()
{
    var_9bfba9d9 = getent( "street_center_goaltrig", "targetname" );
    
    if ( self istouching( var_9bfba9d9 ) )
    {
        return;
    }
    
    self kill();
}

// Namespace zurich_street
// Params 0
// Checksum 0xf046e9a8, Offset: 0x3000
// Size: 0xe3
function function_bdb3b32d()
{
    spawn_manager::wait_till_complete( "garage_ramp_spawn_manager" );
    spawner::waittill_ai_group_ai_count( "garage_entrance_robots", 0 );
    level flag::set( "garage_ramp_cleared" );
    a_ai_robots = spawner::get_ai_group_ai( "garage_saffold_robots" );
    
    foreach ( ai in a_ai_robots )
    {
        ai ai::set_ignoreme( 0 );
        ai.overrideactordamage = &zurich_util::function_8ac3f026;
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0x333c53dd, Offset: 0x30f0
// Size: 0x52
function function_e804203a()
{
    trigger::wait_till( "garage_phalanx_spawn_trig" );
    zurich_util::spawn_phalanx( "garage_left_path_phalanx", "phanalx_wedge", 3, 1, 0.1, "garage_end_phalanx_scatter", 3 );
}

// Namespace zurich_street
// Params 4
// Checksum 0x9195009a, Offset: 0x3150
// Size: 0x8a
function function_932e49ba( var_b2d1f880, var_d587bca1, var_bb5c7c43, var_678e7878 )
{
    if ( self istouching( var_b2d1f880 ) )
    {
        self setgoal( var_bb5c7c43 );
        return;
    }
    else if ( self istouching( var_d587bca1 ) )
    {
        self setgoal( var_678e7878 );
        return;
    }
    
    self setgoal( var_bb5c7c43 );
}

// Namespace zurich_street
// Params 0
// Checksum 0x200b616a, Offset: 0x31e8
// Size: 0x167
function function_b863f1b1()
{
    spawn_manager::wait_till_complete( "street_garage_breach_spawn_manger" );
    spawner::waittill_ai_group_ai_count( "garage_breach_rushers", 1 );
    level flag::set( "garage_entrance_attack" );
    spawn_manager::wait_till_cleared( "street_garage_breach_spawn_manger" );
    exploder::stop_exploder( "street_parking_wall_exp" );
    level flag::set( "garage_entrance_cleared" );
    savegame::checkpoint_save();
    spawn_manager::wait_till_cleared( "garage_allies_spawn_manager" );
    
    if ( level.players.size < 3 )
    {
        var_b04fa3dc = struct::get( "garage_intro_enemy_fake_spawn_manager" );
        var_fb75ccb0 = array::remove_dead( var_b04fa3dc.a_ai );
        
        foreach ( ai in var_fb75ccb0 )
        {
            ai.script_accuracy = 0.2;
        }
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0x6ff61bf, Offset: 0x3358
// Size: 0xa2
function function_a0abe6b6()
{
    var_66b24a60 = zurich_util::function_3789d4db( "street_garage_entrance_open_trig", undefined, 720, 768 );
    var_66b24a60 thread function_3a6344d1( 4 );
    var_66b24a60 waittill( #"trigger" );
    var_66b24a60 delete();
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    function_4d92b2c7();
    level flag::set( "garage_entrance_open" );
}

// Namespace zurich_street
// Params 1
// Checksum 0x9c0af237, Offset: 0x3408
// Size: 0xf2
function function_ce297ff6( b_starting )
{
    if ( b_starting )
    {
        objectives::set( "cp_level_zurich_assault_hq_obj" );
        objectives::breadcrumb( "intro_breadcrumb_trig2", "cp_waypoint_breadcrumb" );
    }
    
    trigger::wait_till( "truck_burst_breadcrumb_trig", undefined, undefined, 0 );
    objectives::hide( "cp_level_zurich_assault_hq_obj" );
    objectives::set( "cp_level_zurich_assault_hq_awaiting_obj" );
    level flag::wait_till( "garage_entrance_cleared" );
    objectives::hide( "cp_level_zurich_assault_hq_awaiting_obj" );
    objectives::show( "cp_level_zurich_assault_hq_obj" );
    objectives::breadcrumb( "street_garage_entrance_breadcrumb_trig", "cp_waypoint_breadcrumb" );
}

// Namespace zurich_street
// Params 1
// Checksum 0x6cabb033, Offset: 0x3508
// Size: 0x1aa
function function_410cfaac( b_starting )
{
    if ( b_starting )
    {
        objectives::set( "cp_level_zurich_assault_hq_awaiting_obj" );
        level flag::wait_till( "garage_entrance_cleared" );
        objectives::hide( "cp_level_zurich_assault_hq_awaiting_obj" );
        objectives::set( "cp_level_zurich_assault_hq_obj" );
        objectives::breadcrumb( "street_garage_entrance_breadcrumb_trig", "cp_waypoint_breadcrumb" );
    }
    
    trigger::wait_till( "street_garage_entrance_breadcrumb_trig", undefined, undefined, 0 );
    objectives::hide( "cp_level_zurich_assault_hq_obj" );
    objectives::show( "cp_level_zurich_assault_hq_awaiting_obj" );
    level flag::wait_till( "garage_ramp_cleared" );
    trigger::wait_till( "street_garage_2nd_floor_breadcrumb_spot", undefined, undefined, 0 );
    var_c226e38e = getent( "garage_cleanup_trig", "targetname" );
    
    while ( isdefined( var_c226e38e ) && level.ai_kane istouching( var_c226e38e ) )
    {
        wait 0.2;
    }
    
    objectives::hide( "cp_level_zurich_assault_hq_awaiting_obj" );
    objectives::show( "cp_level_zurich_assault_hq_obj" );
    objectives::breadcrumb( "garage_kane_rooftop_colortrig", "cp_waypoint_breadcrumb" );
}

// Namespace zurich_street
// Params 0
// Checksum 0xb5dc6b87, Offset: 0x36c0
// Size: 0x12
function on_player_spawned()
{
    self function_2e5e657b();
}

// Namespace zurich_street
// Params 0
// Checksum 0x9e76d93a, Offset: 0x36e0
// Size: 0x12f
function function_2e5e657b()
{
    level endon( #"street_balcony_spawn_closet_available" );
    self endon( #"death" );
    
    if ( level flag::get( "street_balcony_spawn_closet_available" ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        
        foreach ( var_cbc51d9b in level.var_ebb30c1a )
        {
            if ( !isalive( var_cbc51d9b ) )
            {
                continue;
            }
            
            var_b8f6e26f = self util::is_player_looking_at( var_cbc51d9b geteye(), 0.98, 1, self );
            
            if ( isdefined( var_cbc51d9b.var_6e5e16ee ) && var_b8f6e26f && var_cbc51d9b.var_6e5e16ee && self util::is_ads() )
            {
                trigger::use( "street_vehicle_burst_scene_trig", undefined, undefined, 0 );
                return;
            }
        }
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0x44c4854a, Offset: 0x3818
// Size: 0x4a
function function_dcb29c2c()
{
    self endon( #"death" );
    s_goal = struct::get( "street_turret_enemy_goal_spot" );
    self setgoal( s_goal.origin, 0, 256 );
}

// Namespace zurich_street
// Params 0
// Checksum 0x644f5bd1, Offset: 0x3870
// Size: 0x6d
function function_5268b119()
{
    self endon( #"death" );
    level endon( #"garage" );
    self vehicle::god_on();
    
    while ( true )
    {
        self waittill( #"enter_vehicle" );
        spawn_manager::enable( "street_turret_spawn_manager", 1 );
        self waittill( #"exit_vehicle" );
        spawn_manager::disable( "street_turret_spawn_manager", 1 );
    }
}

// Namespace zurich_street
// Params 1
// Checksum 0x4946edeb, Offset: 0x38e8
// Size: 0x182
function function_c89b08c9( nd_start )
{
    self endon( #"death" );
    
    if ( !isdefined( nd_start ) )
    {
        nd_start = getvehiclenode( self.target, "targetname" );
    }
    
    self disableaimassist();
    self vehicle_ai::start_scripted();
    self.team = "team3";
    self thread vehicle::get_on_and_go_path( nd_start );
    
    if ( nd_start.script_string === "run_defend_logic" )
    {
        self function_fd9eb46();
        return;
    }
    
    if ( nd_start.script_string === "run_guard_logic" )
    {
        self function_dbaa39f6();
        return;
    }
    else if ( self.scriptvehicletype === "hunter" )
    {
        self vehicle::god_on();
        self thread function_ba1c7fdb();
    }
    
    self waittill( #"reached_end_node" );
    
    if ( self.script_string === "stop_scripted" )
    {
        self vehicle_ai::stop_scripted();
        self enableaimassist();
        self.team = "axis";
        return;
    }
    else if ( self.script_string === "run_wasp_attack_logic" )
    {
        self function_3feabcbe();
        return;
    }
    
    self delete();
}

// Namespace zurich_street
// Params 0
// Checksum 0x9e8fe9d9, Offset: 0x3a78
// Size: 0xc2
function function_9ae7d78()
{
    self endon( #"death" );
    s_scene = struct::get( self.target );
    level scene::play( s_scene.targetname, "targetname", self );
    
    if ( isdefined( s_scene.target ) )
    {
        goal = getent( s_scene.target, "targetname" );
        
        if ( !isdefined( goal ) )
        {
            goal = getnode( s_scene.target, "targetname" );
        }
        
        if ( isdefined( goal ) )
        {
            self setgoal( goal );
        }
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0x97c0f2bd, Offset: 0x3b48
// Size: 0x62
function function_892106c9()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self function_ade7ef6b();
    level waittill( #"hash_90cef371" );
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
}

// Namespace zurich_street
// Params 0
// Checksum 0xd8556cd0, Offset: 0x3bb8
// Size: 0x82
function function_ade7ef6b()
{
    var_8a3b64d6 = zurich_util::get_num_scaled_by_player_count( 0, 35 );
    
    if ( randomint( 100 ) <= var_8a3b64d6 )
    {
        wait 0.05;
        self ai::set_behavior_attribute( "rogue_control", "forced_level_3" );
        self ai::set_behavior_attribute( "rogue_control_speed", "sprint" );
        self.team = "axis";
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0xc6911bc, Offset: 0x3c48
// Size: 0x3f
function function_ba1c7fdb()
{
    self endon( #"death" );
    self waittill( #"hash_3113e74d" );
    self thread vehicle_ai::fire_for_time( 100 );
    self waittill( #"hash_5d07b3ec" );
    self notify( #"fire_stop" );
}

// Namespace zurich_street
// Params 0
// Checksum 0xd90243fb, Offset: 0x3c90
// Size: 0xfa
function function_721c929f()
{
    self endon( #"death" );
    
    if ( self.team == "allies" )
    {
        self.script_accuracy = 0.1;
    }
    else
    {
        self.var_6e5e16ee = 1;
    }
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        self util::magic_bullet_shield();
    }
    
    if ( self.script_string === "intro_redshirt" )
    {
        return;
    }
    
    level flag::wait_till( "street_phalanx_scatter" );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        self.health = self.maxhealth;
        self util::stop_magic_bullet_shield();
    }
    
    if ( self.team == "axis" )
    {
        return;
    }
    
    level flag::wait_till( "garage_entrance_attack" );
    self colors::set_force_color( "y" );
}

// Namespace zurich_street
// Params 0
// Checksum 0x9f6d836f, Offset: 0x3d98
// Size: 0x132
function function_748fa5c2()
{
    self endon( #"death" );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        self ai::set_ignoreall( 1 );
        self util::magic_bullet_shield();
    }
    
    if ( self.team == "allies" )
    {
        self.script_accuracy = 0.1;
        self ai::set_ignoreme( 1 );
    }
    
    trigger::wait_till( "street_wall_approach_trig", undefined, undefined, 0 );
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
    level flag::wait_till( "street_exit_zone_reached" );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        self.health = self.maxhealth;
        self util::stop_magic_bullet_shield();
    }
    
    if ( self.team == "axis" )
    {
        self ai::set_behavior_attribute( "move_mode", "rusher" );
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0xb31138ec, Offset: 0x3ed8
// Size: 0x12
function function_42881589()
{
    self function_ade7ef6b();
}

// Namespace zurich_street
// Params 0
// Checksum 0xd7a804f8, Offset: 0x3ef8
// Size: 0x9a
function function_9ff08320()
{
    self endon( #"death" );
    
    if ( self.team == "allies" )
    {
        self.script_accuracy = 0.1;
    }
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        self util::magic_bullet_shield();
    }
    
    level flag::wait_till( "garage_ramp_reached" );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        self util::stop_magic_bullet_shield();
    }
    
    self colors::set_force_color( "y" );
}

// Namespace zurich_street
// Params 0
// Checksum 0xcfe03713, Offset: 0x3fa0
// Size: 0xf2
function vtol_spawnfunc()
{
    self endon( #"death" );
    self.health = 100000;
    self.team = "axis";
    self.var_7a04481c = zurich_util::get_num_scaled_by_player_count( 4000, 1000 );
    self.var_90937e6 = struct::get_array( "street_vtol_crash_point" );
    self vehicle::god_on();
    
    if ( self.script_string !== "no_death" )
    {
        self thread zurich_util::function_6d571441();
    }
    
    self waittill( #"hash_5f96e13c" );
    var_b0a9b597 = spawner::get_ai_group_ai( "street_vtol_riders" );
    array::run_all( var_b0a9b597, &kill );
}

// Namespace zurich_street
// Params 0
// Checksum 0x51383132, Offset: 0x40a0
// Size: 0x42
function function_2ad4a40f()
{
    self endon( #"death" );
    level flag::wait_till( "garage_entrance_open" );
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
}

// Namespace zurich_street
// Params 0
// Checksum 0x25371b35, Offset: 0x40f0
// Size: 0x1da
function function_9a1931bc()
{
    level thread zurich_util::function_33ec653f( "street_intro_redshirts_fake_spawn_manager", undefined, undefined, &function_721c929f );
    level flag::wait_till( "street_civs_start" );
    trigger::use( "street_allies_intro_battle_colortrig" );
    level flag::wait_till( "street_intro_intersection_cleared" );
    trigger::use( "street_kane_intersection_colortrig" );
    trigger::use( "street_allies_intro_colortrig" );
    level flag::wait_till( "street_truck_cover_available" );
    trigger::use( "street_allies_battle_colortrig" );
    level flag::wait_till( "street_balcony_spawn_closet_available" );
    level.ai_kane ai::set_ignoreme( 1 );
    level.ai_kane thread zurich_util::function_d0103e8d();
    level flag::wait_till( "garage_entrance_attack" );
    trigger::use( "street_allies_attack_colortrig" );
    level flag::wait_till( "garage_entrance_cleared" );
    trigger::use( "street_allies_garage_enter_colortrig" );
    trigger::wait_till( "street_wall_approach_trig" );
    trigger::use( "street_kane_garage_colortrig" );
    level flag::wait_till( "street_exit_zone_reached" );
    trigger::use( "street_allies_garage_colortrig" );
}

// Namespace zurich_street
// Params 0
// Checksum 0x6b32b6ec, Offset: 0x42d8
// Size: 0xda
function function_8535a819()
{
    trigger::use( "street_allies_battle_colortrig" );
    level.ai_kane ai::set_ignoreme( 1 );
    level.ai_kane thread zurich_util::function_d0103e8d();
    level flag::wait_till( "garage_entrance_attack" );
    trigger::use( "street_allies_attack_colortrig" );
    level flag::wait_till( "garage_entrance_cleared" );
    trigger::use( "street_allies_garage_enter_colortrig" );
    trigger::wait_till( "street_wall_approach_trig" );
    trigger::use( "street_kane_garage_colortrig" );
}

// Namespace zurich_street
// Params 0
// Checksum 0xfa4f73f6, Offset: 0x43c0
// Size: 0x26a
function function_1c9e622e()
{
    level.ai_kane ai::set_ignoreme( 0 );
    level flag::wait_till( "garage_entrance_cleared" );
    level.ai_kane zurich_util::function_121ba443();
    level.ai_kane thread function_c9dccfc4();
    zurich_util::function_c049667c( 1 );
    a_ai_allies = getaiteamarray( "allies" );
    
    foreach ( ai in a_ai_allies )
    {
        if ( ai util::is_hero() || ai.script_noteworthy === "garage_intro_guys" )
        {
            continue;
        }
        
        ai colors::set_force_color( "y" );
    }
    
    spawn_manager::wait_till_complete( "garage_ramp_spawn_manager" );
    trigger::use( "garage_kane_intro_clear_colortrig" );
    trigger::use( "garage_redshirts_2nd_floor_colortrig" );
    spawn_manager::wait_till_ai_remaining( "garage_ramp_spawn_manager", 1 );
    trigger::use( "garage_kane_2nd_floor_colortrig" );
    level flag::wait_till( "garage_ramp_reached" );
    trigger::use( "garage_kane_ramp_colortrig" );
    trigger::wait_till( "street_garage_2nd_floor_wasp_spawn_trig", undefined, undefined, 0 );
    level flag::wait_till( "garage_gate_open" );
    a_ai_enemies = getaispeciesarray( "axis", "robot" );
    array::wait_till( a_ai_enemies, "death" );
    trigger::use( "garage_kane_exit_colortrig" );
    level flag::wait_till( "garage_completed" );
}

// Namespace zurich_street
// Params 0
// Checksum 0x35c2ec61, Offset: 0x4638
// Size: 0x82
function function_c9dccfc4()
{
    level endon( #"hash_9903fa62" );
    level flag::wait_till( "garage_car_2nd_floor_standard_01_done" );
    trigger::wait_till( "garage_kane_left_change_color_colortrig" );
    self colors::set_force_color( "o" );
    level flag::wait_till( "garage_completed" );
    self colors::set_force_color( "b" );
}

// Namespace zurich_street
// Params 3
// Checksum 0x26b7e4a0, Offset: 0x46c8
// Size: 0xf3
function function_82ecade4( goal, n_min_wait, n_max_wait )
{
    if ( !isdefined( n_min_wait ) )
    {
        n_min_wait = 0.3;
    }
    
    if ( !isdefined( n_max_wait ) )
    {
        n_max_wait = 1.1;
    }
    
    a_ai = self;
    
    if ( !isarray( self ) )
    {
        a_ai = array( self );
    }
    
    foreach ( ai in a_ai )
    {
        wait randomfloatrange( n_min_wait, n_max_wait );
        
        if ( isalive( ai ) )
        {
            ai setgoal( goal );
        }
    }
}

// Namespace zurich_street
// Params 1
// Checksum 0xa3b6b083, Offset: 0x47c8
// Size: 0x32
function kill_ai( n_delay )
{
    if ( !isdefined( n_delay ) )
    {
        n_delay = 0;
    }
    
    self endon( #"death" );
    wait n_delay;
    self kill();
}

// Namespace zurich_street
// Params 0
// Checksum 0x729efa15, Offset: 0x4808
// Size: 0x62
function function_6a364612()
{
    level flag::wait_till( "street_civs_start" );
    spawn_manager::enable( "street_wasp_spawn_manager" );
    level flag::wait_till( "street_clear" );
    spawn_manager::kill( "street_wasp_spawn_manager", 1 );
}

// Namespace zurich_street
// Params 0
// Checksum 0xf61afc30, Offset: 0x4878
// Size: 0xd2
function function_34ad4dc8()
{
    level flag::wait_till( "garage_entrance_open" );
    spawn_manager::enable( "garage_entrance_wasp_spawn_manager" );
    trigger::wait_till( "street_garage_2nd_floor_wasp_spawn_trig", undefined, undefined, 0 );
    spawn_manager::enable( "street_garage_2nd_floor_wasp_end_spawnmanager" );
    level flag::wait_till( "garage_gate_open" );
    a_ai_wasps = spawn_manager::get_ai( "street_garage_2nd_floor_wasp_end_spawnmanager" );
    spawn_manager::kill( "street_garage_2nd_floor_wasp_end_spawnmanager", 1 );
    array::run_all( a_ai_wasps, &kill );
}

// Namespace zurich_street
// Params 0
// Checksum 0x9f000569, Offset: 0x4958
// Size: 0x7a
function function_3feabcbe()
{
    self endon( #"death" );
    self vehicle_ai::stop_scripted();
    self enableaimassist();
    self.team = "axis";
    t_goal = getent( "garage_wasp_goaltrig", "targetname" );
    self setgoal( t_goal );
}

// Namespace zurich_street
// Params 0
// Checksum 0x7a768448, Offset: 0x49e0
// Size: 0x82
function function_fd9eb46()
{
    self endon( #"death" );
    self waittill( #"reached_end_node" );
    self vehicle_ai::stop_scripted();
    self enableaimassist();
    self.team = "axis";
    t_goal = getent( "garage_wasp_defend_goaltrig", "targetname" );
    self setgoal( t_goal );
}

// Namespace zurich_street
// Params 0
// Checksum 0xc73d9932, Offset: 0x4a70
// Size: 0x52
function function_dbaa39f6()
{
    self endon( #"death" );
    self waittill( #"reached_end_node" );
    self vehicle_ai::stop_scripted();
    self enableaimassist();
    self.team = "axis";
    self function_90c5d999();
}

// Namespace zurich_street
// Params 0
// Checksum 0x2857e0e7, Offset: 0x4ad0
// Size: 0x42
function function_90c5d999()
{
    t_goal = getent( "street_center_goaltrig", "targetname" );
    self setgoal( t_goal );
}

// Namespace zurich_street
// Params 7
// Checksum 0xf69f4cd, Offset: 0x4b20
// Size: 0xeb
function function_11cc2d60( nd_start, n_time, n_group_size, n_time_min, n_time_max, var_4339be5c, var_6dcbc9a2 )
{
    if ( !isdefined( n_time ) )
    {
        n_time = 0.2;
    }
    
    if ( !isdefined( n_group_size ) )
    {
        n_group_size = 8;
    }
    
    if ( isdefined( n_time_min ) && isdefined( n_time_max ) )
    {
        n_time = randomfloatrange( n_time_min, n_time_max );
    }
    
    if ( isdefined( n_time_max ) && isdefined( var_6dcbc9a2 ) )
    {
        n_group_size = randomintrange( n_time_max, var_6dcbc9a2 );
    }
    
    var_c779405 = [];
    
    for ( i = 0; i < n_group_size ; i++ )
    {
        var_c779405[ i ] = spawner::simple_spawn_single( self, &function_c89b08c9, nd_start );
        wait n_time;
    }
    
    return var_c779405;
}

// Namespace zurich_street
// Params 0
// Checksum 0x6c945f5b, Offset: 0x4c18
// Size: 0x5a
function function_1b8ff897()
{
    level endon( #"hash_5539c1de" );
    zurich_util::function_1b3dfa61( "p7_fxanim_cp_zurich_car_crash_06_bundle_trig", undefined, 1300, 768 );
    level flag::set( "street_intro_intersection_cleared" );
    level scene::play( "p7_fxanim_cp_zurich_car_crash_06_bundle" );
}

// Namespace zurich_street
// Params 0
// Checksum 0x9db3deae, Offset: 0x4c80
// Size: 0xea
function function_1be1a835()
{
    scene::add_scene_func( "p7_fxanim_cp_zurich_truck_crash_01_bundle", &function_93e3e895, "play" );
    scene::add_scene_func( "p7_fxanim_cp_zurich_truck_crash_01_bundle", &function_8c1a1bb7, "done" );
    wait 0.05;
    level scene::init( "p7_fxanim_cp_zurich_truck_crash_01_bundle" );
    wait 0.05;
    zurich_util::function_1b3dfa61( "street_vehicle_burst_scene_trig", undefined, 1300, 512 );
    level flag::set( "street_phalanx_scatter" );
    level scene::play( "p7_fxanim_cp_zurich_truck_crash_01_bundle" );
    savegame::checkpoint_save();
}

// Namespace zurich_street
// Params 1
// Checksum 0x214a294, Offset: 0x4d78
// Size: 0x32a
function function_93e3e895( a_ents )
{
    var_a146f241 = getnodearray( "street_intro_redshirts", "targetname" );
    var_9b1ed538 = getnodearray( "street_intro_truck_cover_nodes", "targetname" );
    var_b04fa3dc = struct::get( "street_intro_redshirts_fake_spawn_manager" );
    var_a3f74aa3 = var_b04fa3dc.a_ai;
    var_a3f74aa3 = array::remove_dead( var_a3f74aa3 );
    
    foreach ( nd in var_9b1ed538 )
    {
        setenablenode( nd, 0 );
    }
    
    a_ents[ "truck_crash_01_veh" ] thread function_d700903e();
    a_ents[ "truck_crash_01_veh" ] waittill( #"hash_84bfd73b" );
    a_ents[ "truck_crash_01_veh" ] notify( #"stop_damage" );
    var_a3f74aa3 = array::remove_dead( var_a3f74aa3 );
    
    foreach ( ai in var_a3f74aa3 )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        ai util::stop_magic_bullet_shield();
        
        if ( ai.script_string === "intro_redshirt" )
        {
            ai kill();
        }
    }
    
    var_a146f241 = getnodearray( "street_intro_redshirts", "targetname" );
    var_9b1ed538 = getnodearray( "street_intro_truck_cover_nodes", "targetname" );
    
    foreach ( nd in var_a146f241 )
    {
        setenablenode( nd, 0 );
    }
    
    foreach ( nd in var_9b1ed538 )
    {
        setenablenode( nd, 1 );
    }
    
    level flag::set( "street_truck_cover_available" );
    physicsexplosionsphere( a_ents[ "truck_crash_01_veh" ].origin, 512, 0, 1.2 );
}

// Namespace zurich_street
// Params 0
// Checksum 0x43f4461f, Offset: 0x50b0
// Size: 0xaa
function function_c8cc9a0d()
{
    s_rpg = struct::get( "street_intro_robot_magic_bullet_start" );
    s_rpg_target = struct::get( s_rpg.target );
    var_9faa0c88 = getweapon( "launcher_standard" );
    magicbullet( var_9faa0c88, s_rpg.origin, s_rpg_target.origin );
    wait 1;
    radiusdamage( s_rpg.origin, 64, 700, 500 );
}

// Namespace zurich_street
// Params 1
// Checksum 0x47654b07, Offset: 0x5168
// Size: 0x3a
function function_8c1a1bb7( a_ents )
{
    level flag::set( "street_balcony_spawn_closet_available" );
    self thread zurich_util::function_9f90bc0f( a_ents, "garage_ambient_cleanup" );
}

// Namespace zurich_street
// Params 0
// Checksum 0xfef53401, Offset: 0x51b0
// Size: 0xca
function function_4e8285e0()
{
    level flag::wait_till( "street_civs_start" );
    var_295a1e1f = getentarray( "zurich_intro_camera_ai", "targetname" );
    var_9cb1bda3 = arraygetclosest( self.origin, var_295a1e1f );
    
    if ( !isdefined( var_9cb1bda3 ) )
    {
        return;
    }
    
    self lookatpos( var_9cb1bda3.origin );
    self thread ai::shoot_at_target( "normal", var_9cb1bda3 );
    wait 2;
    
    if ( !isalive( var_9cb1bda3 ) )
    {
        return;
    }
    
    var_9cb1bda3 kill();
}

// Namespace zurich_street
// Params 0
// Checksum 0x6b2ba7d, Offset: 0x5288
// Size: 0x202
function function_dc91abc9()
{
    level scene::init( "p7_fxanim_cp_zurich_car_crash_03_bundle" );
    trigger::wait_till( "street_exit_zone_trig" );
    scene::add_scene_func( "p7_fxanim_cp_zurich_car_crash_01_bundle", &function_d8cdc243, "play" );
    level thread scene::play( "p7_fxanim_cp_zurich_car_crash_01_bundle" );
    function_723d47ab();
    level scene::play( "p7_fxanim_cp_zurich_car_crash_02_bundle" );
    level flag::set( "garage_car_2nd_floor_standard_01_done" );
    trigger::wait_till( "garage_third_floor_trig" );
    var_9582077f = getentarray( "garage_car_scene_trig", "targetname" );
    array::thread_all( var_9582077f, &function_95c63963 );
    wait 21;
    level flag::wait_till_timeout( 15, "garage_entrance_cleared" );
    zurich_util::function_1b3dfa61( "garage_exit_gate_trig", undefined, 400.5, 512 );
    umbragate_set( "garage_umbra_gate", 1 );
    scene::add_scene_func( "p7_fxanim_cp_zurich_car_crash_03_bundle", &function_646cd830, "play" );
    scene::add_scene_func( "p7_fxanim_cp_zurich_car_crash_03_bundle", &function_5d018732, "done" );
    level scene::play( "p7_fxanim_cp_zurich_car_crash_03_bundle" );
    level flag::set( "garage_gate_open" );
}

// Namespace zurich_street
// Params 0
// Checksum 0x2a8c5c88, Offset: 0x5498
// Size: 0x32
function function_723d47ab()
{
    if ( level.activeplayers.size < 2 )
    {
        level endon( #"hash_c88a6904" );
    }
    
    zurich_util::function_3adbd846( "garage_car_2nd_floor_standard_01_trig", undefined, 1 );
}

// Namespace zurich_street
// Params 0
// Checksum 0x1a5480cd, Offset: 0x54d8
// Size: 0x18b
function function_1418d19()
{
    var_f6338e1d = struct::get_array( "train_crash_glass_break_spot" );
    var_c7b1d4be = struct::get( "train_crash_sound_spot" );
    playsoundatposition( "evt_train_crash_front", var_c7b1d4be.origin );
    wait 6;
    
    foreach ( e_player in level.activeplayers )
    {
        e_player playrumbleonentity( "damage_heavy" );
    }
    
    earthquake( 0.25, 2, var_c7b1d4be.origin, 10000 );
    
    foreach ( s_glass in var_f6338e1d )
    {
        glassradiusdamage( s_glass.origin, s_glass.radius, 700, 500, "MOD_GRENADE_SPLASH" );
        wait randomfloatrange( 0.2, 0.3 );
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0x204c05b9, Offset: 0x5670
// Size: 0x52
function function_4d92b2c7()
{
    level thread scene::play( "p7_fxanim_cp_zurich_parking_wall_explode_bundle" );
    mdl_wall = getent( "garage_entrance_wall", "targetname" );
    mdl_wall delete();
}

// Namespace zurich_street
// Params 1
// Checksum 0x249959d1, Offset: 0x56d0
// Size: 0x72
function function_3a6344d1( n_delay )
{
    if ( !isdefined( n_delay ) )
    {
        n_delay = 1;
    }
    
    self endon( #"death" );
    s_look_spot = struct::get( "train_crash_sound_spot" );
    wait n_delay;
    
    do
    {
        wait 0.1;
    }
    while ( !zurich_util::function_f8645b6( -1, s_look_spot.origin, 0.92 ) );
    
    self trigger::use();
}

// Namespace zurich_street
// Params 1
// Checksum 0x83a0ddfe, Offset: 0x5750
// Size: 0x1f2
function function_48166ad7( str_objective )
{
    var_80658d78 = array( "p7_fxanim_cp_zurich_car_crash_01_bundle", "p7_fxanim_cp_zurich_car_crash_02_bundle", "p7_fxanim_cp_zurich_car_crash_06_bundle" );
    scene::add_scene_func( "p7_fxanim_cp_zurich_car_crash_stuck_bundle", &function_96b02c44, "play" );
    scene::add_scene_func( "p7_fxanim_cp_zurich_car_crash_stuck_bundle", &function_e0bb6e8b, "done" );
    level thread scene::play( "p7_fxanim_cp_zurich_car_crash_stuck_bundle" );
    wait 0.05;
    
    foreach ( str_bundle in var_80658d78 )
    {
        scene::add_scene_func( str_bundle, &function_c9765981, "play" );
        scene::add_scene_func( str_bundle, &function_e0bb6e8b, "done" );
        level scene::init( str_bundle );
        wait 0.05;
    }
    
    if ( str_objective === "garage" )
    {
        level thread scene::skipto_end( "p7_fxanim_cp_zurich_car_crash_06_bundle" );
        level thread scene::skipto_end( "p7_fxanim_cp_zurich_truck_crash_01_bundle" );
        exploder::exploder( "street_truck_crash_fires" );
        exploder::exploder( "street_truck_crash_garage_linger" );
        level flag::set( "street_balcony_spawn_closet_available" );
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0x97b41a7c, Offset: 0x5950
// Size: 0x65
function function_1b074d61()
{
    level endon( #"hash_9903fa62" );
    
    while ( true )
    {
        var_21c17e53 = getaiteamarray( "axis", "allies" );
        level.var_ebb30c1a = arraycombine( var_21c17e53, level.activeplayers, 0, 0 );
        wait 0.05;
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0x8d296281, Offset: 0x59c0
// Size: 0x185
function function_d700903e()
{
    self endon( #"death" );
    self endon( #"stop_damage" );
    
    while ( true )
    {
        foreach ( var_cbc51d9b in level.var_ebb30c1a )
        {
            if ( isdefined( var_cbc51d9b ) && var_cbc51d9b istouching( self ) )
            {
                var_cabb1f64 = isalive( var_cbc51d9b ) && !var_cbc51d9b util::is_hero() && !isplayer( var_cbc51d9b );
                is_player = isdefined( var_cbc51d9b.owner ) && ( isplayer( var_cbc51d9b ) || isplayer( var_cbc51d9b.owner ) );
                
                if ( var_cabb1f64 )
                {
                    var_cbc51d9b util::stop_magic_bullet_shield();
                    var_cbc51d9b kill();
                    continue;
                }
                
                if ( is_player )
                {
                    var_cbc51d9b dodamage( var_cbc51d9b.health + 1000, var_cbc51d9b.origin, self, undefined, undefined, "MOD_HIT_BY_OBJECT" );
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace zurich_street
// Params 2
// Checksum 0x8b142fbe, Offset: 0x5b50
// Size: 0xe2
function function_42ac5715( str_ent_name, str_trig_name )
{
    e_toucher = getent( str_ent_name, "targetname" );
    t_trig = getent( str_trig_name, "targetname" );
    var_a56fa84f = struct::get( t_trig.target );
    e_toucher endon( #"death" );
    t_trig endon( #"death" );
    
    while ( !e_toucher istouching( t_trig ) )
    {
        wait 0.05;
    }
    
    radiusdamage( var_a56fa84f.origin, var_a56fa84f.radius, 700, 500, e_toucher );
    t_trig delete();
}

// Namespace zurich_street
// Params 1
// Checksum 0xff01056, Offset: 0x5c40
// Size: 0x7b
function function_96b02c44( a_ents )
{
    foreach ( e_car in a_ents )
    {
        /#
            recordent( e_car );
        #/
        
        e_car thread util::auto_delete();
    }
}

// Namespace zurich_street
// Params 1
// Checksum 0xfd081ff0, Offset: 0x5cc8
// Size: 0x7b
function function_c9765981( a_ents )
{
    foreach ( e_car in a_ents )
    {
        /#
            recordent( e_car );
        #/
        
        e_car thread function_d700903e();
    }
}

// Namespace zurich_street
// Params 1
// Checksum 0xe2301ef7, Offset: 0x5d50
// Size: 0x7a
function function_e0bb6e8b( a_ents )
{
    foreach ( e_car in a_ents )
    {
        e_car notify( #"stop_damage" );
    }
    
    self thread zurich_util::function_9f90bc0f( a_ents, "rails_ambient_cleanup" );
}

// Namespace zurich_street
// Params 1
// Checksum 0x5149784, Offset: 0x5dd8
// Size: 0xaa
function function_646cd830( a_ents )
{
    /#
        recordent( a_ents[ "<dev string:x28>" ] );
    #/
    
    /#
        recordent( a_ents[ "<dev string:x35>" ] );
    #/
    
    a_ents[ "car_crash_03" ] thread function_d700903e();
    a_ents[ "car_crash_03_wall" ] waittill( #"hash_c0199b64" );
    mdl_wall = getent( "garage_exit_wall", "targetname" );
    mdl_wall delete();
}

// Namespace zurich_street
// Params 1
// Checksum 0xdfc4ca42, Offset: 0x5e90
// Size: 0x7a
function function_5d018732( a_ents )
{
    foreach ( e_car in a_ents )
    {
        e_car notify( #"stop_damage" );
    }
    
    self thread zurich_util::function_9f90bc0f( a_ents, "rails_ambient_cleanup" );
}

// Namespace zurich_street
// Params 0
// Checksum 0x24bc5c7a, Offset: 0x5f18
// Size: 0x8a
function function_95c63963()
{
    self endon( #"death" );
    assert( isdefined( self.script_string ), "<dev string:x47>" );
    self waittill( #"trigger" );
    scene::add_scene_func( self.script_string, &function_91c120ae, "play" );
    level scene::play( self.script_string );
    self delete();
}

// Namespace zurich_street
// Params 1
// Checksum 0x44df7e2d, Offset: 0x5fb0
// Size: 0x5a
function function_91c120ae( a_ents )
{
    var_19f54c8f = getentarray( self.scriptbundlename + "_gates", "targetname" );
    array::thread_all( var_19f54c8f, &function_9b734821, a_ents );
}

// Namespace zurich_street
// Params 1
// Checksum 0x946e9564, Offset: 0x6018
// Size: 0x5a
function function_3f5b8a5e( a_ents )
{
    var_19f54c8f = getentarray( self.scriptbundlename + "_gates", "targetname" );
    array::thread_all( var_19f54c8f, &function_74bdec69, a_ents );
}

// Namespace zurich_street
// Params 1
// Checksum 0xeec530a, Offset: 0x6080
// Size: 0x82
function function_74bdec69( a_ents )
{
    self endon( #"death" );
    n_time = 0.5;
    n_dist = 44;
    
    if ( self.script_noteworthy === "bottom" )
    {
        n_dist *= -1;
    }
    
    self.v_start = self.origin;
    self moveto( self.origin + ( 0, 0, n_dist ), n_time );
}

// Namespace zurich_street
// Params 1
// Checksum 0x7bba201d, Offset: 0x6110
// Size: 0x72
function function_9b734821( a_ents )
{
    self endon( #"death" );
    t_close = getent( self.targetname + "_trig", "targetname" );
    
    if ( isdefined( t_close ) )
    {
        t_close waittill( #"trigger" );
    }
    
    self moveto( self.v_start, 0.62 );
}

// Namespace zurich_street
// Params 1
// Checksum 0x21d5d04, Offset: 0x6190
// Size: 0xf3
function function_d8cdc243( a_ents )
{
    var_aea40fc = struct::get_array( "garge_ramp_car_glass_break_spot" );
    level waittill( #"hash_cc6fa4a6" );
    
    foreach ( mdl_car in a_ents )
    {
        foreach ( s_break in var_aea40fc )
        {
            glassradiusdamage( s_break.origin, s_break.radius, 700, 500, "MOD_GRENADE_SPLASH" );
        }
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0xe58d1e63, Offset: 0x6290
// Size: 0xe3
function init_elevators()
{
    a_s_doors = struct::get_array( "garage_elevator_doors", "script_noteworthy" );
    a_mdl_doors = [];
    
    foreach ( n_index, s in a_s_doors )
    {
        a_mdl_doors[ n_index ] = util::spawn_model( s.model, s.origin, s.angles );
        a_mdl_doors[ n_index ].targetname = s.targetname;
        a_mdl_doors[ n_index ].script_objective = "rails";
        wait 0.05;
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0x44a40707, Offset: 0x6380
// Size: 0x82
function function_b3a34ca5()
{
    level endon( #"garage_completed" );
    level thread function_19764f0e();
    level thread function_60227c5();
    wait 2.1;
    level thread function_7248d34();
    wait 1.3;
    level thread function_adb65bc4();
    trigger::wait_till( "garage_end_elevators_trig" );
    function_9c0b8c73();
}

// Namespace zurich_street
// Params 0
// Checksum 0x3881e8f4, Offset: 0x6410
// Size: 0x1d1
function function_19764f0e()
{
    level endon( #"garage_completed" );
    var_836db305 = getent( "garage_elevator_door_left_entrance2", "targetname" );
    var_73d5b598 = getent( "garage_elevator_door_right_entrance2", "targetname" );
    
    /#
        recordent( var_836db305 );
    #/
    
    /#
        recordent( var_73d5b598 );
    #/
    
    var_73d5b598 rotatepitch( -1, 0.1 );
    var_836db305 moveto( var_836db305.origin + ( 0, 4 * -1, 0 ), 0.1 );
    var_73d5b598 moveto( var_73d5b598.origin + ( 0, 4, 0 ), 0.1 );
    var_73d5b598 waittill( #"movedone" );
    
    while ( true )
    {
        var_836db305 moveto( var_836db305.origin + ( 0, 36 * -1, 0 ), 0.45 );
        var_73d5b598 moveto( var_73d5b598.origin + ( 0, 36, 0 ), 0.45 );
        var_73d5b598 waittill( #"movedone" );
        var_836db305 moveto( var_836db305.origin + ( 0, 36, 0 ), 0.45 );
        var_73d5b598 moveto( var_73d5b598.origin + ( 0, 36 * -1, 0 ), 0.45 );
        var_73d5b598 waittill( #"movedone" );
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0x67876598, Offset: 0x65f0
// Size: 0x1d1
function function_60227c5()
{
    level endon( #"garage_completed" );
    var_836db305 = getent( "garage_elevator_door_left_entrance", "targetname" );
    var_73d5b598 = getent( "garage_elevator_door_right_entrance", "targetname" );
    
    /#
        recordent( var_836db305 );
    #/
    
    /#
        recordent( var_73d5b598 );
    #/
    
    var_836db305 rotatepitch( 4, 0.1 );
    var_836db305 moveto( var_836db305.origin + ( 0, 2 * -1, 0 ), 0.1 );
    var_73d5b598 moveto( var_73d5b598.origin + ( 0, 2, 0 ), 0.1 );
    var_73d5b598 waittill( #"movedone" );
    
    while ( true )
    {
        var_836db305 moveto( var_836db305.origin + ( 0, 8 * -1, 0 ), 0.15 );
        var_73d5b598 moveto( var_73d5b598.origin + ( 0, 8, 0 ), 0.15 );
        var_73d5b598 waittill( #"movedone" );
        var_836db305 moveto( var_836db305.origin + ( 0, 8, 0 ), 0.15 );
        var_73d5b598 moveto( var_73d5b598.origin + ( 0, 8 * -1, 0 ), 0.15 );
        var_73d5b598 waittill( #"movedone" );
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0x3f987249, Offset: 0x67d0
// Size: 0x189
function function_7248d34()
{
    level endon( #"garage_completed" );
    var_836db305 = getent( "garage_elevator_door_left_2nd_floor_entrance", "targetname" );
    var_73d5b598 = getent( "garage_elevator_door_right_2nd_floor_entrance", "targetname" );
    
    /#
        recordent( var_836db305 );
    #/
    
    /#
        recordent( var_73d5b598 );
    #/
    
    while ( true )
    {
        var_836db305 moveto( var_836db305.origin + ( 0, 60 * -1, 0 ), 0.75 );
        var_73d5b598 moveto( var_73d5b598.origin + ( 0, 60, 0 ), 0.75 );
        var_73d5b598 playsound( "evt_elevator_glitch" );
        var_73d5b598 waittill( #"movedone" );
        var_836db305 moveto( var_836db305.origin + ( 0, 60, 0 ), 0.75 );
        var_73d5b598 moveto( var_73d5b598.origin + ( 0, 60 * -1, 0 ), 0.75 );
        var_73d5b598 playsound( "evt_elevator_glitch" );
        var_73d5b598 waittill( #"movedone" );
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0x5a684322, Offset: 0x6968
// Size: 0x159
function function_adb65bc4()
{
    level endon( #"garage_completed" );
    var_836db305 = getent( "garage_elevator_door_left_2nd_floor_entrance2", "targetname" );
    var_73d5b598 = getent( "garage_elevator_door_right_2nd_floor_entrance2", "targetname" );
    
    /#
        recordent( var_836db305 );
    #/
    
    /#
        recordent( var_73d5b598 );
    #/
    
    while ( true )
    {
        var_836db305 moveto( var_836db305.origin + ( 0, 35 * -1, 0 ), 0.6 );
        var_73d5b598 moveto( var_73d5b598.origin + ( 0, 35, 0 ), 0.6 );
        var_73d5b598 waittill( #"movedone" );
        var_836db305 moveto( var_836db305.origin + ( 0, 35, 0 ), 0.6 );
        var_73d5b598 moveto( var_73d5b598.origin + ( 0, 35 * -1, 0 ), 0.6 );
        var_73d5b598 waittill( #"movedone" );
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0xcd9b7203, Offset: 0x6ad0
// Size: 0x30a
function function_9c0b8c73()
{
    var_836db305 = getent( "garage_elevator_door_left_exit", "targetname" );
    var_73d5b598 = getent( "garage_elevator_door_right_exit", "targetname" );
    var_bf22cfbd = getent( "garage_elevator_door_left_exit2", "targetname" );
    var_5de8c6ca = getent( "garage_elevator_door_right_exit2", "targetname" );
    var_b76dcc17 = zurich_util::function_33ec653f( "garage_exit_elevator_robots_spawn_manager", undefined, 0.15, &function_892106c9 );
    t_zone = getent( "garage_exit_elevator_zone_aitrig", "targetname" );
    
    /#
        recordent( var_836db305 );
    #/
    
    /#
        recordent( var_73d5b598 );
    #/
    
    /#
        recordent( var_bf22cfbd );
    #/
    
    /#
        recordent( var_5de8c6ca );
    #/
    
    playsoundatposition( "evt_elevator_ding", struct::get( "garage_elevator_sound_spot" ).origin );
    var_836db305 moveto( var_836db305.origin + ( 0, 64, 0 ), 2 );
    var_73d5b598 moveto( var_73d5b598.origin + ( 0, 64 * -1, 0 ), 2 );
    wait 0.4;
    var_bf22cfbd moveto( var_bf22cfbd.origin + ( 0, 64, 0 ), 2 );
    var_5de8c6ca moveto( var_5de8c6ca.origin + ( 0, 64 * -1, 0 ), 2 );
    var_5de8c6ca waittill( #"movedone" );
    level notify( #"hash_90cef371" );
    level flag::wait_till( "garage_exit_elevator_zone_clear" );
    var_836db305 moveto( var_836db305.origin + ( 0, 64 * -1, 0 ), 2 );
    var_73d5b598 moveto( var_73d5b598.origin + ( 0, 64, 0 ), 2 );
    wait 0.4;
    var_bf22cfbd moveto( var_bf22cfbd.origin + ( 0, 64 * -1, 0 ), 2 );
    var_5de8c6ca moveto( var_5de8c6ca.origin + ( 0, 64, 0 ), 2 );
}

// Namespace zurich_street
// Params 0
// Checksum 0x38ee5e9d, Offset: 0x6de8
// Size: 0x32a
function function_7a0e84a8()
{
    var_3b159664 = getnodearray( "garage_lift_gate_nodes", "script_noteworthy" );
    
    foreach ( nd in var_3b159664 )
    {
        setenablenode( nd, 0 );
    }
    
    var_19f54c8f = [];
    var_71955f5e = struct::get_array( "p7_fxanim_cp_zurich_car_crash_04_bundle_gates" );
    var_9797d9c7 = struct::get_array( "p7_fxanim_cp_zurich_car_crash_05_bundle_gates" );
    var_91ad292d = arraycombine( var_71955f5e, var_9797d9c7, 0, 0 );
    wait 0.05;
    
    foreach ( i, s_gate in var_91ad292d )
    {
        var_19f54c8f[ i ] = util::spawn_model( s_gate.model, s_gate.origin, s_gate.angles );
        var_19f54c8f[ i ].targetname = s_gate.targetname;
        var_19f54c8f[ i ].script_noteworthy = s_gate.script_noteworthy;
        var_19f54c8f[ i ].script_string = s_gate.script_string;
        var_19f54c8f[ i ].script_objective = "rails";
        wait 0.05;
    }
    
    scene::add_scene_func( "p7_fxanim_cp_zurich_car_crash_04_bundle", &function_3f5b8a5e, "init" );
    scene::add_scene_func( "p7_fxanim_cp_zurich_car_crash_05_bundle", &function_3f5b8a5e, "init" );
    scene::add_scene_func( "p7_fxanim_cp_zurich_car_crash_04_bundle", &function_c9765981, "play" );
    scene::add_scene_func( "p7_fxanim_cp_zurich_car_crash_05_bundle", &function_c9765981, "play" );
    scene::add_scene_func( "p7_fxanim_cp_zurich_car_crash_04_bundle", &function_e0bb6e8b, "done" );
    scene::add_scene_func( "p7_fxanim_cp_zurich_car_crash_05_bundle", &function_e0bb6e8b, "done" );
    level scene::init( "p7_fxanim_cp_zurich_car_crash_04_bundle" );
    wait 0.05;
    level scene::init( "p7_fxanim_cp_zurich_car_crash_05_bundle" );
}

// Namespace zurich_street
// Params 0
// Checksum 0xae1a0633, Offset: 0x7120
// Size: 0x149
function function_d987ae9()
{
    t_cleanup = getent( "garage_cleanup_trig", "targetname" );
    t_cleanup endon( #"death" );
    
    while ( true )
    {
        var_52adae1e = getaiteamarray( "axis", "allies" );
        
        foreach ( ai in var_52adae1e )
        {
            var_cabb1f64 = isalive( ai ) && !ai util::is_hero();
            
            if ( var_cabb1f64 && !ai zurich_util::player_can_see_me( 1024 ) && ai istouching( t_cleanup ) )
            {
                ai util::stop_magic_bullet_shield();
                ai kill();
            }
        }
        
        wait 1;
    }
}

// Namespace zurich_street
// Params 0
// Checksum 0x4d54f695, Offset: 0x7278
// Size: 0x4a
function function_b7d40ae()
{
    var_11cbfab3 = getentarray( "break_glass", "script_noteworthy" );
    array::thread_all( var_11cbfab3, &function_b09dbdde );
}

// Namespace zurich_street
// Params 0
// Checksum 0x6323e24c, Offset: 0x72d0
// Size: 0x5a
function function_b09dbdde()
{
    self endon( #"death" );
    self waittill( #"trigger", var_26c7381f );
    glassradiusdamage( var_26c7381f.origin, 64, 700, 500, "MOD_HIT_BY_OBJECT" );
    self delete();
}

// Namespace zurich_street
// Params 0
// Checksum 0xfa06ccdd, Offset: 0x7338
// Size: 0x4a
function function_ec9dd4a5()
{
    var_3e9d5326 = getentarray( "garage_car_kill_trig", "targetname" );
    array::thread_all( var_3e9d5326, &function_f3cdc2c1 );
}

// Namespace zurich_street
// Params 0
// Checksum 0x1d003bb8, Offset: 0x7390
// Size: 0x92
function function_f3cdc2c1()
{
    self endon( #"death" );
    s_damage = struct::get( self.target );
    n_radius = s_damage.radius;
    
    if ( !isdefined( n_radius ) )
    {
        n_radius = 64;
    }
    
    self waittill( #"trigger" );
    radiusdamage( s_damage.origin, n_radius, 1200, 1100 );
}

/#

    // Namespace zurich_street
    // Params 0
    // Checksum 0x2a558d1f, Offset: 0x7430
    // Size: 0x55, Type: dev
    function function_9075d8d6()
    {
        self endon( #"death" );
        
        for ( n_stage = 0; true ; n_stage++ )
        {
            self thread zurich_util::function_ff016910( "<dev string:x7e>" + n_stage, undefined );
            self waittill( #"movedone" );
            self notify( #"hash_8fba9" );
        }
    }

#/
