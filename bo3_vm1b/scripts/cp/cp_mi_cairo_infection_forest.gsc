#using scripts/codescripts/struct;
#using scripts/cp/_collectibles;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_forest_surreal;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace forest;

// Namespace forest
// Params 0, eflags: 0x2
// Checksum 0x7afdac9e, Offset: 0x1300
// Size: 0x2a
function autoexec __init__sytem__()
{
    system::register( "infection_forest", &__init__, undefined, undefined );
}

// Namespace forest
// Params 0
// Checksum 0xeeaaae90, Offset: 0x1338
// Size: 0x42
function __init__()
{
    level.str_friendly_intro = "cin_inf_06_02_bastogne_vign_intro";
    level.str_sarah_intro = "cin_inf_06_02_bastogne_vign_sarahintro";
    level.str_player_intro = "cin_inf_06_02_bastogne_vign_playerintro";
    scene_setup();
}

// Namespace forest
// Params 0
// Checksum 0xfa68e535, Offset: 0x1388
// Size: 0x11a
function init_client_field_callback_funcs()
{
    clientfield::register( "world", "forest_mortar_index", 1, 3, "int" );
    clientfield::register( "world", "forest_surreal_exposure", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_frost_up", 1, 1, "counter" );
    clientfield::register( "toplayer", "pstfx_frost_down", 1, 1, "counter" );
    clientfield::register( "scriptmover", "wfa_steam_sound", 1, 1, "counter" );
    clientfield::register( "scriptmover", "cp_infection_world_falls_break_rumble", 1, 1, "counter" );
    clientfield::register( "scriptmover", "cp_infection_world_falls_away_rumble", 1, 1, "counter" );
}

// Namespace forest
// Params 0
// Checksum 0x22567ce2, Offset: 0x14b0
// Size: 0x5a
function function_e8608118()
{
    spawner_setup();
    level thread scene::init( level.str_friendly_intro );
    level thread scene::init( level.str_sarah_intro );
    level thread scene::init( level.str_player_intro );
}

// Namespace forest
// Params 2
// Checksum 0x2ab4c67e, Offset: 0x1518
// Size: 0x15a
function intro_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        spawner_setup();
        level thread scene::init( level.str_friendly_intro );
        level thread scene::init( level.str_sarah_intro );
        level thread scene::init( level.str_player_intro );
        level util::set_streamer_hint( 12 );
        load::function_a2995f22();
        exploder::exploder( "sgen_server_room_fall" );
    }
    
    level thread exploding_trees_init();
    infection_util::turn_on_snow_fx_for_all_players();
    
    if ( true )
    {
        level thread intro_only_falling_debris_from_sgen();
    }
    
    level thread intro_only_random_mortar_explosions();
    battlechatter::function_d9f49fba( 0 );
    level thread bastogne_frozen_soldiers();
    sarah_intro();
    
    if ( b_starting )
    {
        level thread util::clear_streamer_hint();
    }
    
    level thread skipto::objective_completed( str_objective );
}

// Namespace forest
// Params 4
// Checksum 0x99e47093, Offset: 0x1680
// Size: 0x22
function intro_cleanup( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace forest
// Params 2
// Checksum 0x13e6cb0, Offset: 0x16b0
// Size: 0x3e2
function forest_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        spawner_setup();
        level.str_friendly_intro = "cin_inf_06_02_bastogne_vign_intro";
        level scene::init( level.str_friendly_intro );
        level scene::init( "p7_fxanim_cp_infection_sgen_floor_debris_bundle" );
        load::function_a2995f22();
        
        if ( true )
        {
            level thread falling_debris_from_sgen();
        }
        
        level thread random_mortar_explosions();
        infection_util::turn_on_snow_fx_for_all_players();
        level thread scene::skipto_end( level.str_friendly_intro );
        level thread scene::skipto_end( "p7_fxanim_cp_infection_sgen_floor_debris_bundle" );
        level thread namespace_bed101ee::function_245384ac();
    }
    
    collectibles::function_93523442( "p7_nc_cai_inf_02", -6, ( -20, -15, 0 ) );
    collectibles::function_37aecd21();
    objectives::set( "cp_level_infection_follow_sarah" );
    infection_accolades::function_15b29a5a();
    infection_accolades::function_c081e535();
    battlechatter::function_d9f49fba( 1 );
    
    if ( isdefined( 0 ) && 0 )
    {
        num_players = getplayers().size;
        
        if ( num_players == 1 )
        {
            level.reduce_german_accuracy = 1;
        }
    }
    
    level thread infection_util::function_3fe1f72( "t_sarah_bastogne_objective_", 0, &forest_surreal::sarah_waits_at_ravine );
    level thread force_sarah_move();
    level thread bastogne_battle_startup();
    level thread wakamole_guys();
    level thread bastogne_hill_running_group();
    level thread sniper_guys_on_rocks();
    level thread high_ground_rpg();
    level thread bastogne_left_side_rocks_fallback();
    level thread bastogne_right_side_runners();
    level thread bastogne_right_side_wave2();
    level thread function_2c145384( "t_2nd_hill_rienforcements", "sp_2nd_hill_reinforcements", "sm_2nd_hill_reinforcements" );
    level thread function_2c145384( "t_2nd_hill_rienforcements", "sp_2nd_hill_reinforcements_mg_side", "sm_2nd_hill_reinforcements_mg_side" );
    level thread bastogne_final_guys();
    level thread forest_fallback_triggers();
    level thread bastogne_frozen_soldiers();
    level thread friendly_ai_manager();
    level thread exploding_trees_update();
    level thread reverse_rock_bundles();
    level thread bastogne_turret( "t_mg_turret_1", "bastogne_turret_1", 0, "s_turret_kill", "fx_expl_mg_bullet_impacts01" );
    level thread bastogne_turret( "t_mg_turret_1", "bastogne_turret_2", 0, "s_turret_kill_2", undefined );
    level thread misc_vo_thread();
    level thread function_afb42159();
    trigger::wait_till( "bastogne_complete" );
    level notify( #"bastogne_complete" );
    level.reduce_german_accuracy = undefined;
    level_complete_cleanup();
    infection_util::enable_exploding_deaths( 0 );
    level thread skipto::objective_completed( str_objective );
}

// Namespace forest
// Params 0
// Checksum 0x24b5aba7, Offset: 0x1aa0
// Size: 0x52
function force_sarah_move()
{
    t_objective_start = getent( "t_sarah_bastogne_objective_0", "targetname" );
    wait 2;
    
    if ( isdefined( t_objective_start ) )
    {
        trigger::use( "t_sarah_bastogne_objective_0", "targetname" );
    }
}

// Namespace forest
// Params 4
// Checksum 0x3dc7b935, Offset: 0x1b00
// Size: 0x92
function cleanup( str_objective, b_starting, b_direct, player )
{
    infection_accolades::function_a0f567cb();
    hidemiscmodels( "hide_me_from_wolves" );
    var_3edb0ecc = getentarray( "bastogne_world_falls_away", "script_noteworthy" );
    level thread array::run_all( var_3edb0ecc, &show );
}

// Namespace forest
// Params 0
// Checksum 0x51b41424, Offset: 0x1ba0
// Size: 0x14b
function level_complete_cleanup()
{
    a_enemy_to_keep = [];
    a_ai = getaiteamarray( "axis" );
    
    if ( isdefined( a_ai ) )
    {
        a_sorted_ai = infection_util::ent_array_distance_from_players( a_ai );
        
        for ( i = 0; i < a_sorted_ai.size ; i++ )
        {
            e_ent = a_sorted_ai[ i ];
            
            if ( i + 7 >= a_sorted_ai.size )
            {
                a_enemy_to_keep[ a_enemy_to_keep.size ] = e_ent;
                continue;
            }
            
            e_ent infection_util::function_e66c8377();
        }
    }
    
    for ( i = 0; i < a_enemy_to_keep.size ; i++ )
    {
        e_ent = a_enemy_to_keep[ i ];
        e_ent thread one_minute_kill();
    }
    
    colors::kill_color_replacements();
    a_ai = getaiteamarray( "allies" );
    
    if ( isdefined( a_ai ) )
    {
        for ( i = 0; i < a_ai.size ; i++ )
        {
            if ( !a_ai[ i ] util::is_hero() )
            {
                a_ai[ i ] infection_util::function_5e78ab8c();
            }
        }
    }
    
    level notify( #"tree_cleanup" );
}

// Namespace forest
// Params 0
// Checksum 0x3e19b719, Offset: 0x1cf8
// Size: 0x22
function one_minute_kill()
{
    self endon( #"death" );
    wait 60;
    self infection_util::function_e66c8377();
}

// Namespace forest
// Params 2
// Checksum 0x2e27ea8a, Offset: 0x1d28
// Size: 0x2a
function init_anims_on_trigger( str_trigger, str_anim_group )
{
    self thread _init_anims_on_trigger( str_trigger, str_anim_group );
}

// Namespace forest
// Params 2
// Checksum 0x29a43458, Offset: 0x1d60
// Size: 0x32
function _init_anims_on_trigger( str_trigger, str_anim_group )
{
    trigger::wait_till( str_trigger );
    infection_util::setup_reverse_time_arrivals( str_anim_group );
}

// Namespace forest
// Params 0
// Checksum 0x11c2fc69, Offset: 0x1da0
// Size: 0x272
function scene_setup()
{
    scene::add_scene_func( level.str_friendly_intro, &infection_util::function_9f64d290, "play", 0 );
    scene::add_scene_func( level.str_friendly_intro, &function_ae9a24ef, "play" );
    scene::add_scene_func( level.str_friendly_intro, &infection_util::function_9f64d290, "done", 1 );
    scene::add_scene_func( level.str_sarah_intro, &infection_util::function_9f64d290, "play", 0 );
    scene::add_scene_func( level.str_sarah_intro, &infection_util::function_9f64d290, "done", 1 );
    scene::add_scene_func( level.str_sarah_intro, &vo_forest_messages, "play" );
    scene::add_scene_func( level.str_sarah_intro, &vo_forest_follow, "done" );
    scene::add_scene_func( level.str_sarah_intro, &infection_util::function_23e59afd, "play" );
    scene::add_scene_func( level.str_sarah_intro, &infection_util::function_e2eba6da, "done" );
    scene::add_scene_func( level.str_sarah_intro, &scene_callback_sarah_intro_play, "play" );
    scene::add_scene_func( level.str_sarah_intro, &function_54e62fbb, "done" );
    scene::add_scene_func( level.str_player_intro, &scene_callback_player_intro_play, "play" );
    scene::add_scene_func( level.str_player_intro, &scene_callback_player_intro_done, "done" );
}

// Namespace forest
// Params 0
// Checksum 0x60c9f520, Offset: 0x2020
// Size: 0x34a
function spawner_setup()
{
    infection_util::enable_exploding_deaths( 1 );
    spawner::add_spawn_function_group( "bastogne_friendly_guys", "script_noteworthy", &friendly_ai_spawn_function );
    spawner::add_spawn_function_group( "bastogne_tiger_tank_1_guys", "script_noteworthy", &infection_util::set_goal_on_spawn );
    spawner::add_spawn_function_group( "sm_bastogne_reinforcements", "script_noteworthy", &infection_util::set_goal_on_spawn );
    spawner::add_spawn_function_group( "sp_bastogne_battle_start", "targetname", &check_for_german_reduced_accuracy );
    spawner::add_spawn_function_group( "sp_bastogne_reinforcements_left_guys", "targetname", &check_for_german_reduced_accuracy );
    spawner::add_spawn_function_group( "sp_bastogne_reinforcements_right_guys", "targetname", &check_for_german_reduced_accuracy );
    spawner::add_spawn_function_group( "sp_bastogne_reinforcements", "targetname", &check_for_german_reduced_accuracy );
    spawner::add_spawn_function_group( "sp_bastogne_reinforcements_2", "targetname", &check_for_german_reduced_accuracy );
    spawner::add_spawn_function_group( "sp_bastogne_final_guys", "targetname", &check_for_german_reduced_accuracy );
    spawner::add_spawn_function_group( "sp_wakamole_start", "targetname", &ai_wakamole, 64, 0 );
    spawner::add_spawn_function_group( "sp_bastogne_ww2_mg_wakamole", "targetname", &ai_wakamole, 64, 0 );
    spawner::add_spawn_function_group( "sp_bastogne_hill_running_group", "targetname", &ai_wakamole, 512, 0 );
    spawner::add_spawn_function_group( "sp_bastogne_right_side_runners", "targetname", &ai_wakamole, 512, 0 );
    spawner::add_spawn_function_group( "sp_bastogne_right_side_wave2", "targetname", &ai_wakamole, 512, 0 );
    spawner::add_spawn_function_group( "sp_bastogne_high_ground_rpg", "targetname", &ai_wakamole, 64, 1 );
    spawner::add_spawn_function_group( "sp_left_side_rocks_fallback", "targetname", &ai_wakamole, 512, 0 );
    infection_util::setup_reverse_time_arrivals( "bastogne_reverse_anim" );
    init_anims_on_trigger( "init_bastogne_reverse_anims_2", "bastogne_reverse_anim_2" );
}

// Namespace forest
// Params 0
// Checksum 0x57b80cdd, Offset: 0x2378
// Size: 0x8a
function bastogne_battle_startup()
{
    str_sp_manager = "sm_bastogne_battle_start";
    spawn_manager::enable( str_sp_manager );
    e_trigger = getent( "t_bastogne_battle_startup", "targetname" );
    
    if ( isdefined( e_trigger ) )
    {
        e_trigger waittill( #"trigger" );
    }
    
    if ( spawn_manager::is_enabled( str_sp_manager ) )
    {
        spawn_manager::disable( str_sp_manager );
    }
}

// Namespace forest
// Params 0
// Checksum 0x328579b6, Offset: 0x2410
// Size: 0x13b
function sarah_intro()
{
    level notify( #"sarah_intro_started" );
    level thread spawn_falling_intro_enemy();
    array::thread_all( level.players, &infection_util::player_enter_cinematic );
    
    if ( isdefined( level.bzm_infectiondialogue7callback ) )
    {
        level thread [[ level.bzm_infectiondialogue7callback ]]();
    }
    
    level thread scene::play( level.str_friendly_intro );
    level thread scene::play( level.str_player_intro );
    level waittill( #"hash_d885008c" );
    level scene::play( level.str_sarah_intro );
    level thread sarah_intro_start_battle();
    trigger::use( "bastogne_intro_reverse_anims_start", "targetname", undefined, 0 );
    infection_util::turn_off_snow_fx_for_all_players();
    util::wait_network_frame();
    infection_util::turn_on_snow_fx_for_all_players();
    array::thread_all( level.players, &infection_util::player_leave_cinematic );
    level notify( #"sarah_intro_complete" );
}

// Namespace forest
// Params 0
// Checksum 0xfe0298c7, Offset: 0x2558
// Size: 0x119
function sarah_intro_start_battle()
{
    start_time = gettime();
    intro_troops = 0;
    intro_guys = 0;
    
    while ( true )
    {
        time = gettime();
        dt = ( time - start_time ) / 1000;
        
        if ( dt > 0.5 )
        {
            if ( !intro_troops )
            {
                /#
                    iprintlnbold( "<dev string:x28>" );
                #/
                
                intro_troops = 1;
                a_spawners = getentarray( "sp_sarah_intro_attacker", "targetname" );
                
                for ( i = 0; i < a_spawners.size ; i++ )
                {
                    spawner::simple_spawn_single( a_spawners[ i ] );
                    util::wait_network_frame();
                }
            }
        }
        
        if ( dt > 1 )
        {
            if ( !intro_guys )
            {
                level thread scene::play( "bastogne_reverse_anim_intro_1" );
                intro_guys = 1;
            }
        }
        
        if ( dt >= 4 )
        {
            return;
        }
        
        wait 0.05;
    }
}

// Namespace forest
// Params 1
// Checksum 0x19a84099, Offset: 0x2680
// Size: 0xc7
function scene_callback_sarah_intro_play( a_ents )
{
    a_ents[ "sarah" ] thread infection_util::actor_camo( 1 );
    level thread util::screen_fade_in( 1, "white" );
    a_ents[ "sarah" ] waittill( #"hash_74fab6ea" );
    a_ents[ "sarah" ] thread infection_util::actor_camo( 0 );
    a_ents[ "sarah" ] waittill( #"time_stop" );
    a_ents[ "sarah" ] setignorepauseworld( 1 );
    level notify( #"sarah_time_stop" );
    a_ents[ "sarah" ] waittill( #"time_start" );
    level notify( #"sarah_time_start" );
}

// Namespace forest
// Params 1
// Checksum 0xea5ba95e, Offset: 0x2750
// Size: 0xa
function function_54e62fbb( a_ents )
{
    
}

// Namespace forest
// Params 1
// Checksum 0x6cad6eea, Offset: 0x2768
// Size: 0x10a
function scene_callback_player_intro_play( a_ents )
{
    foreach ( player in level.players )
    {
    }
    
    level waittill( #"landed_bastogne" );
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "cp_infection_floor_break" );
        player shellshock( "default", 2.5 );
    }
    
    exploder::stop_exploder( "sgen_server_room_fall" );
    level thread function_1e925d59();
}

// Namespace forest
// Params 1
// Checksum 0xa6667dad, Offset: 0x2880
// Size: 0x1a
function scene_callback_player_intro_done( a_ents )
{
    level thread infection_util::teleport_coop_players_after_shared_cinematic();
}

// Namespace forest
// Params 1
// Checksum 0xef9e2585, Offset: 0x28a8
// Size: 0x2a
function function_1e925d59( a_ents )
{
    wait 6.35;
    level thread scene::play( "p7_fxanim_cp_infection_sgen_floor_debris_bundle" );
}

// Namespace forest
// Params 0
// Checksum 0x3a79ea05, Offset: 0x28e0
// Size: 0x1b2
function forest_fallback_triggers()
{
    level thread wakamole_fallbacks();
    wait_for_all_players_to_enter_trigger( "info_bastogne_fallback_1" );
    level notify( #"fallback1" );
    e_volume = getent( "t_bastogne_fallback_1_volume", "targetname" );
    a_ai = getaiteamarray( "axis" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        a_ai[ i ] thread ai_fallback_to_volume( e_volume );
    }
    
    a_players = getplayers();
    
    if ( a_players.size > 1 )
    {
        return;
    }
    
    wait_for_all_players_to_enter_trigger( "info_bastogne_fallback_2" );
    e_volume = getent( "t_bastogne_fallback_2_volume", "targetname" );
    a_ai = getaiteamarray( "axis" );
    
    for ( i = 0; i < a_ai.size ; i++ )
    {
        a_ai[ i ] thread ai_fallback_to_volume( e_volume );
    }
    
    if ( spawn_manager::is_enabled( "sm_bastogne_reinforcements_left" ) )
    {
        spawn_manager::disable( "sm_bastogne_reinforcements_left" );
    }
    
    if ( spawn_manager::is_enabled( "sm_bastogne_reinforcements_right" ) )
    {
        spawn_manager::disable( "sm_bastogne_reinforcements_right" );
    }
}

// Namespace forest
// Params 1
// Checksum 0x5709f82b, Offset: 0x2aa0
// Size: 0x142
function wait_for_all_players_to_enter_trigger( str_info_volume )
{
    if ( isdefined( level.players_enter_trigger ) )
    {
        assertmsg( "<dev string:x3e>" );
    }
    
    level.players_enter_trigger = 1;
    e_info_volume = getent( str_info_volume, "targetname" );
    
    while ( true )
    {
        num_touching = 0;
        a_players = getplayers();
        
        for ( i = 0; i < a_players.size ; i++ )
        {
            e_player = a_players[ i ];
            
            if ( e_player istouching( e_info_volume ) )
            {
                e_player.player_has_entered_trigger = 1;
            }
            
            if ( isdefined( e_player.player_has_entered_trigger ) )
            {
                num_touching++;
            }
        }
        
        if ( num_touching >= a_players.size )
        {
            break;
        }
        
        wait 0.05;
    }
    
    a_players = getplayers();
    
    for ( i = 0; i < a_players.size ; i++ )
    {
        a_players[ i ].player_has_entered_trigger = undefined;
    }
    
    level.players_enter_trigger = undefined;
    e_info_volume delete();
}

// Namespace forest
// Params 1
// Checksum 0xbe640e72, Offset: 0x2bf0
// Size: 0x96
function ai_fallback_to_volume( e_volume )
{
    self endon( #"death" );
    
    if ( isdefined( self.script_string ) && self.script_string == "no_fallback" )
    {
        return;
    }
    
    if ( isdefined( self.disable_fallback ) && self.disable_fallback )
    {
        return;
    }
    
    wait randomfloatrange( 0.1, 0.5 );
    self.goalradius = -128;
    self setgoal( e_volume );
    self waittill( #"goal" );
    self.goalradius = 1024;
}

// Namespace forest
// Params 0
// Checksum 0xc6ee70e1, Offset: 0x2c90
// Size: 0xa2
function wakamole_fallbacks()
{
    level thread wakamole_trigger_fallback( "s_fallback_wakamole_start", "vol_wakamole_start", "volume_wakamole_fallback" );
    level thread wakamole_trigger_fallback( "s_fallback_wakamole_middle", "volume_wakamole_middle", "volume_wakamole_fallback" );
    level thread wakamole_trigger_fallback( "s_fallback_wakamole_right_middle", "volume_wakamole_right_middle", "volume_wakamole_fallback" );
    level thread wakamole_trigger_fallback( "s_fallback_wakamole_end", "volume_wakamole_end", "volume_wakamole_fallback" );
}

// Namespace forest
// Params 3
// Checksum 0x2e8f305c, Offset: 0x2d40
// Size: 0xe9
function wakamole_trigger_fallback( str_fallback_struct, str_wakamole_volume, str_fallback_volume )
{
    infection_util::wait_for_any_player_to_pass_struct( str_fallback_struct );
    e_ent_volume = getent( str_wakamole_volume, "targetname" );
    e_fallback_volume = getent( str_fallback_volume, "targetname" );
    a_ai = getaiteamarray( "axis" );
    
    if ( isdefined( a_ai ) )
    {
        for ( i = 0; i < a_ai.size ; i++ )
        {
            e_ent = a_ai[ i ];
            
            if ( e_ent istouching( e_ent_volume ) )
            {
                e_ent thread ai_fallback_to_volume( e_fallback_volume );
            }
        }
    }
}

// Namespace forest
// Params 0
// Checksum 0x227c66cc, Offset: 0x2e38
// Size: 0x72
function friendly_ai_manager()
{
    spawn_manager::enable( "sm_friendly_guys_bastogne" );
    
    if ( false )
    {
        return;
    }
    
    trigger::use( "forest_color_start" );
    level waittill( #"bastogne_complete" );
    spawn_manager::kill( "sm_friendly_guys_bastogne" );
    spawn_manager::kill( "sm_friendly_guys_bastogne_2" );
}

// Namespace forest
// Params 0
// Checksum 0x7503d731, Offset: 0x2eb8
// Size: 0x82
function friendly_ai_spawn_function()
{
    self.goalradius = 256;
    
    if ( isdefined( 1 ) && 1 )
    {
        num_players = getplayers().size;
        
        if ( num_players > 1 )
        {
            self.script_accuracy = 0.8;
        }
    }
    
    if ( false )
    {
        self.ignoreall = 1;
        return;
    }
    
    self.overrideactordamage = &callback_squad_damage;
    self thread increase_goalradius_on_color_trigger_3();
}

// Namespace forest
// Params 0
// Checksum 0x320b3fd6, Offset: 0x2f48
// Size: 0x4a
function increase_goalradius_on_color_trigger_3()
{
    self endon( #"death" );
    e_trigger = getent( "color_trigger_3", "targetname" );
    e_trigger waittill( #"trigger" );
    self.goalradius = 2048;
}

// Namespace forest
// Params 12
// Checksum 0x56a2ac26, Offset: 0x2fa0
// Size: 0xdc
function callback_squad_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename )
{
    if ( !isdefined( level.num_friendlies_killed_in_forest ) )
    {
        level.num_friendlies_killed_in_forest = 0;
    }
    
    if ( isdefined( eattacker ) && isplayer( eattacker ) )
    {
        idamage = 0;
    }
    
    if ( self.health > 0 && idamage >= self.health )
    {
        if ( level.num_friendlies_killed_in_forest > 3 )
        {
            idamage = self.health - 1;
        }
        else
        {
            level.num_friendlies_killed_in_forest++;
        }
    }
    
    return idamage;
}

// Namespace forest
// Params 1
// Checksum 0xaaec58a3, Offset: 0x3088
// Size: 0x4a
function function_ae9a24ef( a_ents )
{
    level waittill( #"sarah_time_start" );
    a_ents[ "friendly_guys_bastogne_01" ] dialog::say( "hall_congratulations_priv_0", 5 );
    level thread function_79ce4af7();
}

// Namespace forest
// Params 0
// Checksum 0x631a8a74, Offset: 0x30e0
// Size: 0x32
function function_79ce4af7()
{
    level dialog::player_say( "plyr_how_is_this_possible_0", 1 );
    level dialog::player_say( "plyr_this_has_to_be_an_il_0", 6 );
}

// Namespace forest
// Params 1
// Checksum 0x5b42bf30, Offset: 0x3120
// Size: 0x3a
function vo_forest_messages( a_ents )
{
    cin_sarah = a_ents[ "sarah" ];
    
    if ( isdefined( cin_sarah ) )
    {
        cin_sarah setteam( "allies" );
    }
}

// Namespace forest
// Params 1
// Checksum 0xc64ebe12, Offset: 0x3168
// Size: 0x7a
function vo_forest_follow( a_ents )
{
    level thread namespace_bed101ee::function_245384ac();
    wait 1;
    ai_objective_sarah = getent( "sarah_ai", "targetname" );
    
    if ( isdefined( ai_objective_sarah ) )
    {
        infection_util::function_637cd603();
        ai_objective_sarah thread dialog::say( "hall_follow_me_i_ll_sh_0", 0 );
    }
}

// Namespace forest
// Params 0
// Checksum 0x90b69918, Offset: 0x31f0
// Size: 0x102
function intro_only_random_mortar_explosions()
{
    clientfield::set( "forest_mortar_index", 1 );
    level waittill( #"sarah_time_stop" );
    
    foreach ( player in level.players )
    {
        player setignorepauseworld( 1 );
    }
    
    ai_objective_sarah = getent( "sarah_ai", "targetname" );
    level thread infection_util::slow_nearby_players( ai_objective_sarah, 2000, 18 );
    setpauseworld( 1 );
    level waittill( #"sarah_time_start" );
    setpauseworld( 0 );
    level waittill( #"sarah_intro_complete" );
    level thread random_mortar_explosions();
}

// Namespace forest
// Params 0
// Checksum 0xef20ca24, Offset: 0x3300
// Size: 0x122
function random_mortar_explosions()
{
    clientfield::set( "forest_mortar_index", 2 );
    e_trigger = getent( "t_background_mortar_3", "targetname" );
    e_trigger waittill( #"trigger" );
    clientfield::set( "forest_mortar_index", 3 );
    e_trigger = getent( "t_background_mortar_4", "targetname" );
    e_trigger waittill( #"trigger" );
    clientfield::set( "forest_mortar_index", 4 );
    e_trigger = getent( "t_background_mortar_5", "targetname" );
    e_trigger waittill( #"trigger" );
    clientfield::set( "forest_mortar_index", 5 );
    e_trigger = getent( "t_background_mortar_6", "targetname" );
    e_trigger waittill( #"trigger" );
    clientfield::set( "forest_mortar_index", 6 );
}

// Namespace forest
// Params 0
// Checksum 0x52549a3, Offset: 0x3430
// Size: 0x81
function spawn_falling_intro_enemy()
{
    a_ents = getentarray( "sp_falling_intro_enemy", "targetname" );
    
    for ( i = 0; i < a_ents.size ; i++ )
    {
        e_ent = spawner::simple_spawn_single( a_ents[ i ], &falling_intro_enemy_update );
        util::wait_network_frame();
    }
}

// Namespace forest
// Params 0
// Checksum 0x561f1338, Offset: 0x34c0
// Size: 0x59
function kill_falling_intro_enemy()
{
    a_ents = getentarray( "sp_falling_intro_enemy_ai", "targetname" );
    
    for ( i = 0; i < a_ents.size ; i++ )
    {
        a_ents[ i ] delete();
    }
}

// Namespace forest
// Params 0
// Checksum 0xe735918c, Offset: 0x3528
// Size: 0x5a
function falling_intro_enemy_update()
{
    self endon( #"death" );
    self.goalradius = 64;
    self ai::set_ignoreall( 1 );
    level waittill( #"sarah_time_stop" );
    self dodamage( self.health + 100, self.origin );
}

// Namespace forest
// Params 0
// Checksum 0xd1629f8c, Offset: 0x3590
// Size: 0x52
function intro_only_falling_debris_from_sgen()
{
    level waittill( #"sarah_intro_started" );
    level thread falling_big_piece( "bastogne_large_falling_piece_6", 4 );
    level thread falling_big_piece( "bastogne_large_falling_piece_2", 10 );
    level waittill( #"sarah_time_start" );
    level thread falling_debris_from_sgen();
}

// Namespace forest
// Params 0
// Checksum 0x7dbd521, Offset: 0x35f0
// Size: 0xa2
function falling_debris_from_sgen()
{
    initial_delay = 2;
    level thread falling_big_piece( "bastogne_large_falling_piece_2", initial_delay + 2 );
    level thread falling_big_piece( "bastogne_large_falling_piece_4", initial_delay + 5 );
    level thread falling_big_piece( "bastogne_large_falling_piece_3", initial_delay + 6 );
    level thread falling_big_piece( "bastogne_large_falling_piece_6", initial_delay + 10 );
    level thread falling_big_piece( "bastogne_large_falling_piece_1", initial_delay + 13 );
    level thread falling_big_piece( "bastogne_large_falling_piece_5", initial_delay + 16 );
}

// Namespace forest
// Params 2
// Checksum 0x7d4d4dde, Offset: 0x36a0
// Size: 0x1fa
function falling_big_piece( struct_name, fall_delay )
{
    s_struct = struct::get( struct_name, "targetname" );
    a_debris = getentarray( "bastogne_large_debris", "targetname" );
    closest_dist = 1e+06;
    e_closest = a_debris[ 0 ];
    
    for ( i = 0; i < a_debris.size ; i++ )
    {
        dist = distance( s_struct.origin, a_debris[ i ].origin );
        
        if ( dist < closest_dist )
        {
            closest_dist = dist;
            e_closest = a_debris[ i ];
        }
    }
    
    v_offset = ( 0, 0, 2000 );
    e_closest moveto( e_closest.origin + v_offset, 0.05 );
    e_closest hide();
    wait fall_delay;
    e_closest show();
    e_closest playsound( "evt_metal_incoming" );
    e_closest moveto( e_closest.origin - v_offset, 1 );
    wait 1;
    quake_size = 0.5;
    quake_time = randomfloatrange( 1, 1.2 );
    quake_radius = 3000;
    earthquake( quake_size, quake_time, e_closest.origin, quake_radius );
    e_closest playsound( "evt_metal_impact" );
}

/#

    // Namespace forest
    // Params 0
    // Checksum 0xed232981, Offset: 0x38a8
    // Size: 0x2e9, Type: dev
    function debug_ai_counts()
    {
        while ( true )
        {
            data = spawnstruct();
            
            while ( true )
            {
                x_text = -56;
                y_text = 80;
                data.ai_types = [];
                data.ai_counts = [];
                data.hud = [];
                e_player = getplayers()[ 0 ];
                a_ai = getaiteamarray( "<dev string:x8f>" );
                
                for ( i = 0; i < a_ai.size ; i++ )
                {
                    found = 0;
                    e_ent = a_ai[ i ];
                    
                    if ( isdefined( e_ent.targetname ) )
                    {
                        for ( j = 0; j < data.ai_types.size ; j++ )
                        {
                            if ( data.ai_types[ j ] == e_ent.targetname )
                            {
                                data.ai_counts[ j ]++;
                                found = 1;
                                break;
                            }
                        }
                    }
                    
                    if ( !found && isdefined( e_ent.targetname ) )
                    {
                        data.ai_types[ data.ai_types.size ] = e_ent.targetname;
                        data.ai_counts[ data.ai_counts.size ] = 1;
                        hud_elem = infection_util::createclienthudtext( e_player, "<dev string:x94>", x_text, y_text, 1 );
                        
                        if ( issubstr( e_ent.targetname, "<dev string:x95>" ) )
                        {
                            hud_elem.color = ( 0, 1, 0 );
                        }
                        else if ( issubstr( e_ent.targetname, "<dev string:x9b>" ) )
                        {
                            hud_elem.color = ( 1, 0, 0 );
                        }
                        
                        data.hud[ data.hud.size ] = hud_elem;
                        y_text += 12;
                    }
                }
                
                for ( i = 0; i < data.ai_types.size ; i++ )
                {
                    hud_elem = data.hud[ i ];
                    str_text = data.ai_types[ i ] + "<dev string:x9f>" + data.ai_counts[ i ];
                    hud_elem settext( str_text );
                }
                
                wait 0.1;
                
                for ( i = 0; i < data.hud.size ; i++ )
                {
                    data.hud[ i ] destroy();
                }
            }
            
            wait 0.05;
        }
    }

#/

// Namespace forest
// Params 0
// Checksum 0xeef1ce98, Offset: 0x3ba0
// Size: 0x10a
function exploding_trees_init()
{
    level.a_reverse_trees = [];
    level.a_reverse_trees[ level.a_reverse_trees.size ] = "fxanim_tree_break01";
    level.a_reverse_trees[ level.a_reverse_trees.size ] = "fxanim_tree_break02";
    level.a_reverse_trees[ level.a_reverse_trees.size ] = "fxanim_tree_break03";
    level.a_reverse_trees[ level.a_reverse_trees.size ] = "fxanim_tree_break04";
    level.a_reverse_trees[ level.a_reverse_trees.size ] = "fxanim_tree_break05";
    level.a_reverse_trees[ level.a_reverse_trees.size ] = "fxanim_tree_break06";
    level.a_reverse_trees[ level.a_reverse_trees.size ] = "fxanim_tree_break07";
    
    for ( i = 0; i < level.a_reverse_trees.size ; i++ )
    {
        level thread scene::init( level.a_reverse_trees[ i ], "targetname" );
        util::wait_network_frame();
    }
    
    level.exploding_trees_initialized = 1;
}

// Namespace forest
// Params 0
// Checksum 0x6c78749a, Offset: 0x3cb8
// Size: 0x64
function exploding_trees_update()
{
    if ( !isdefined( level.exploding_trees_initialized ) )
    {
        exploding_trees_init();
    }
    
    for ( i = 0; i < level.a_reverse_trees.size ; i++ )
    {
        level thread reverse_tree( level.a_reverse_trees[ i ], 1000 );
    }
    
    level waittill( #"tree_cleanup" );
}

// Namespace forest
// Params 2
// Checksum 0x6851ebc8, Offset: 0x3d28
// Size: 0x9a
function reverse_tree( str_targetname, trigger_radius )
{
    level endon( #"tree_cleanup" );
    s_tree = struct::get( str_targetname, "targetname" );
    
    while ( true )
    {
        dist = infection_util::player_distance( s_tree.origin );
        
        if ( dist < trigger_radius )
        {
            break;
        }
        
        wait 0.1;
    }
    
    level thread scene::play( str_targetname, "targetname" );
}

// Namespace forest
// Params 0
// Checksum 0x5939aa41, Offset: 0x3dd0
// Size: 0x6a
function wakamole_guys()
{
    spawn_manager::enable( "sm_wakamole_start" );
    e_trigger = getent( "bastogne_intro_mortar_group_2", "targetname" );
    
    if ( isdefined( e_trigger ) )
    {
        e_trigger waittill( #"trigger" );
    }
    
    spawn_manager::enable( "sm_bastogne_ww2_mg_wakamole" );
}

// Namespace forest
// Params 2
// Checksum 0x239ef6e4, Offset: 0x3e48
// Size: 0x56
function ai_wakamole( end_goal_radius, disable_fallback )
{
    self endon( #"death" );
    self check_for_german_reduced_accuracy();
    
    if ( disable_fallback )
    {
        self.disable_fallback = 1;
    }
    
    self.goalradius = 64;
    self waittill( #"goal" );
    self.goalradius = end_goal_radius;
}

// Namespace forest
// Params 0
// Checksum 0x2b43265, Offset: 0x3ea8
// Size: 0x8a
function bastogne_hill_running_group()
{
    level endon( #"bastogne_complete" );
    e_trigger = getent( "t_bastogne_hill_running_group", "targetname" );
    e_trigger waittill( #"trigger" );
    
    /#
        iprintlnbold( "<dev string:xa3>" );
    #/
    
    spawn_manager::enable( "sm_bastogne_hill_running_group" );
    util::delay_notify( 3, "forest_sniper_spawn" );
}

// Namespace forest
// Params 0
// Checksum 0x124248c1, Offset: 0x3f40
// Size: 0x72
function bastogne_right_side_runners()
{
    level endon( #"bastogne_complete" );
    e_trigger = getent( "t_bastogne_right_side_runners", "targetname" );
    e_trigger waittill( #"trigger" );
    
    /#
        iprintlnbold( "<dev string:xbf>" );
    #/
    
    spawn_manager::enable( "sm_bastogne_right_side_runners" );
}

// Namespace forest
// Params 0
// Checksum 0xfb8dfb6d, Offset: 0x3fc0
// Size: 0x72
function bastogne_right_side_wave2()
{
    level endon( #"bastogne_complete" );
    e_trigger = getent( "t_bastogne_right_side_wave2", "targetname" );
    e_trigger waittill( #"trigger" );
    
    /#
        iprintlnbold( "<dev string:xdb>" );
    #/
    
    spawn_manager::enable( "sm_bastogne_right_side_wave2" );
}

// Namespace forest
// Params 3
// Checksum 0xfa27ab35, Offset: 0x4040
// Size: 0xa2
function function_2c145384( str_trigger, str_spawners, str_spawn_manager )
{
    level endon( #"bastogne_complete" );
    e_trigger = getent( str_trigger, "targetname" );
    e_trigger waittill( #"trigger" );
    
    /#
        iprintlnbold( "<dev string:xf5>" );
    #/
    
    spawner::add_spawn_function_group( str_spawners, "targetname", &ai_wakamole, 512, 0 );
    spawn_manager::enable( str_spawn_manager );
}

// Namespace forest
// Params 0
// Checksum 0xaedb8208, Offset: 0x40f0
// Size: 0xa2
function bastogne_final_guys()
{
    e_trigger = getent( "t_2nd_hill_rienforcements", "targetname" );
    e_trigger waittill( #"trigger" );
    spawn_manager::enable( "sm_bastogne_final_guys" );
    infection_util::wait_for_any_player_to_pass_struct( "s_turret_kill_2" );
    
    if ( spawn_manager::is_enabled( "sm_bastogne_final_guys" ) )
    {
        spawn_manager::disable( "sm_bastogne_final_guys" );
    }
    
    level thread namespace_bed101ee::function_bf117816();
}

// Namespace forest
// Params 0
// Checksum 0xb3f6c047, Offset: 0x41a0
// Size: 0x3a
function sniper_guys_on_rocks()
{
    level waittill( #"forest_sniper_spawn" );
    spawn_manager::enable( "sm_bastogne_rocks_sniper" );
    infection_util::infection_battle_chatter( "sniper_infection" );
}

// Namespace forest
// Params 0
// Checksum 0x588e976d, Offset: 0x41e8
// Size: 0x3a
function high_ground_rpg()
{
    level waittill( #"fallback1" );
    spawn_manager::enable( "sm_bastogne_high_ground_rpg" );
    infection_util::infection_battle_chatter( "rpg_ridge" );
}

// Namespace forest
// Params 0
// Checksum 0x1da7a062, Offset: 0x4230
// Size: 0x52
function bastogne_left_side_rocks_fallback()
{
    e_trigger = getent( "t_left_side_rocks_fallback", "targetname" );
    
    if ( isdefined( e_trigger ) )
    {
        e_trigger waittill( #"trigger" );
        spawn_manager::enable( "sm_left_side_rocks_fallback" );
    }
}

// Namespace forest
// Params 0
// Checksum 0x340fd081, Offset: 0x4290
// Size: 0x2a
function check_for_german_reduced_accuracy()
{
    if ( isdefined( level.reduce_german_accuracy ) && level.reduce_german_accuracy )
    {
        self.script_accuracy = 0.8;
    }
}

// Namespace forest
// Params 0
// Checksum 0x7dcdef94, Offset: 0x42c8
// Size: 0xa2
function reverse_rock_bundles()
{
    scene::init( "p7_fxanim_cp_infection_reverse_rocks_01_bundle" );
    util::wait_network_frame();
    scene::init( "p7_fxanim_cp_infection_reverse_rocks_02_bundle" );
    e_trigger = getent( "t_reverse_rocks_01_bundle", "targetname" );
    e_trigger waittill( #"trigger" );
    level thread scene::play( "p7_fxanim_cp_infection_reverse_rocks_02_bundle" );
    level thread scene::play( "p7_fxanim_cp_infection_reverse_rocks_01_bundle" );
}

// Namespace forest
// Params 5
// Checksum 0xd6b6c990, Offset: 0x4378
// Size: 0x15a
function bastogne_turret( str_trigger, str_turret_name, use_scripted_gunners, str_kill_struct, str_exploder_introduction )
{
    e_trigger = getent( str_trigger, "targetname" );
    e_trigger waittill( #"trigger" );
    e_turret = vehicle::simple_spawn_single( str_turret_name );
    e_turret.turret_index = 0;
    e_turret turret::set_burst_parameters( 0.75, 1.5, 0.25, 0.75, e_turret.turret_index );
    e_turret turret::enable( 0, 1 );
    
    if ( use_scripted_gunners )
    {
        e_turret thread bastogne_update_turret();
    }
    else
    {
        e_turret turret::enable_auto_use( 1 );
    }
    
    e_turret thread turret_exploder_effect();
    
    if ( isdefined( str_kill_struct ) )
    {
        infection_util::wait_for_any_player_to_pass_struct( str_kill_struct );
        e_turret turret::enable_auto_use( 0 );
    }
}

// Namespace forest
// Params 0
// Checksum 0x5ee6ef6b, Offset: 0x44e0
// Size: 0x14d
function turret_exploder_effect()
{
    e_volume = getent( "volume_turret_introduction", "targetname" );
    
    while ( true )
    {
        b_has_user = turret::does_have_user( self.turret_index );
        
        if ( b_has_user )
        {
            a_players = getplayers();
            
            for ( i = 0; i < a_players.size ; i++ )
            {
                e_player = a_players[ i ];
                
                if ( e_player istouching( e_volume ) )
                {
                    v_dir = vectornormalize( self.origin - e_player.origin );
                    v_forward = anglestoforward( e_player.angles );
                    dp = vectordot( v_dir, v_forward );
                    
                    if ( dp > 0.95 )
                    {
                        exploder::exploder( "fx_expl_mg_bullet_impacts01" );
                        return;
                    }
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace forest
// Params 0
// Checksum 0x59d444ec, Offset: 0x4638
// Size: 0xd1
function bastogne_update_turret()
{
    level endon( #"bastogne_complete" );
    e_gunner = undefined;
    turret_mode = "looking_for_gunner";
    
    while ( true )
    {
        switch ( turret_mode )
        {
            default:
                e_gunner = bastogne_turret_get_gunner();
                turret_mode = "gunner_running_to_turret";
                break;
            case "gunner_running_to_turret":
                alive = self bastogne_turret_gunner_running_to_turret( e_gunner );
                
                if ( alive )
                {
                    turret_mode = "gunner_manning_turret";
                }
                else
                {
                    turret_mode = "looking_for_gunner";
                }
                
                break;
            case "gunner_manning_turret":
                self bastogne_turret_gunner_firing( e_gunner );
                turret_mode = "looking_for_gunner";
                break;
        }
        
        wait 0.05;
    }
}

// Namespace forest
// Params 0
// Checksum 0xf1ddb8d0, Offset: 0x4718
// Size: 0xc7
function bastogne_turret_get_gunner()
{
    e_closest = undefined;
    
    while ( true )
    {
        a_ai = getaiteamarray( "axis" );
        closest_dist = 99999.9;
        
        if ( isdefined( a_ai ) )
        {
            for ( i = 0; i < a_ai.size ; i++ )
            {
                dist = distance( a_ai[ i ].origin, self.origin );
                
                if ( dist < 2500 && dist < closest_dist )
                {
                    closest_dist = dist;
                    e_closest = a_ai[ i ];
                }
            }
        }
        
        if ( isdefined( e_closest ) )
        {
            break;
        }
        
        wait 0.5;
    }
    
    return e_closest;
}

// Namespace forest
// Params 1
// Checksum 0x20b1c9a2, Offset: 0x47e8
// Size: 0x8c, Type: bool
function bastogne_turret_gunner_running_to_turret( e_gunner )
{
    self.gunner_ready = undefined;
    e_gunner thread gunner_run_to_goal( self );
    
    while ( true )
    {
        if ( !isalive( e_gunner ) )
        {
            return false;
        }
        
        if ( isdefined( self.gunner_ready ) )
        {
            break;
        }
        
        wait 0.05;
    }
    
    self turret::enable( 0, 1 );
    e_gunner vehicle::get_in( self, "driver", 1 );
    return true;
}

// Namespace forest
// Params 1
// Checksum 0x5d3e2666, Offset: 0x4880
// Size: 0x52
function gunner_run_to_goal( e_turret )
{
    self endon( #"death" );
    self.goalradius = 64;
    self setgoal( e_turret.origin );
    self waittill( #"goal" );
    e_turret.gunner_ready = 1;
}

// Namespace forest
// Params 1
// Checksum 0x2863d7e6, Offset: 0x48e0
// Size: 0x41
function bastogne_turret_gunner_firing( e_gunner )
{
    while ( isalive( e_gunner ) )
    {
        wait 0.01;
    }
    
    self turret::disable( 0 );
    self.gunner_ready = undefined;
}

// Namespace forest
// Params 0
// Checksum 0x166961e8, Offset: 0x4930
// Size: 0xa2
function misc_vo_thread()
{
    wait 1;
    infection_util::infection_battle_chatter( "bastogne_intro" );
    e_trigger = getent( "t_vo_multiple_routes", "targetname" );
    e_trigger waittill( #"trigger" );
    infection_util::infection_battle_chatter( "multiple_routes" );
    e_trigger = getent( "t_vo_regroup_halftracks", "targetname" );
    e_trigger waittill( #"trigger" );
    infection_util::infection_battle_chatter( "regroup_halftracks" );
}

// Namespace forest
// Params 0
// Checksum 0x1d584322, Offset: 0x49e0
// Size: 0x103
function bastogne_frozen_soldiers()
{
    if ( isdefined( level.frozen_soldiers ) )
    {
        return;
    }
    
    level.frozen_soldiers = 1;
    var_1105cabf = struct::get_array( "bastogne_frozen_soldier", "targetname" );
    
    foreach ( scriptbundle in var_1105cabf )
    {
        if ( math::cointoss() )
        {
            var_76c674e0 = util::spawn_model( "c_ger_winter_soldier_1" );
        }
        else
        {
            var_76c674e0 = util::spawn_model( "c_ger_winter_soldier_2" );
        }
        
        var_76c674e0.script_objective = "forest";
        level thread scene::play( scriptbundle.scriptbundlename, var_76c674e0 );
        util::wait_network_frame();
    }
}

// Namespace forest
// Params 0
// Checksum 0x48327bb6, Offset: 0x4af0
// Size: 0x72
function function_afb42159()
{
    trigger::wait_till( "t_checkpoint_bastogne_mid", "targetname" );
    savegame::checkpoint_save();
    var_7d116593 = struct::get( "s_forest_surreal_lighting_hint", "targetname" );
    infection_util::function_7aca917c( var_7d116593.origin );
}

