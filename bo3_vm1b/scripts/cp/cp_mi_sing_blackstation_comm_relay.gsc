#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_blackstation_cross_debris;
#using scripts/cp/cp_mi_sing_blackstation_sound;
#using scripts/cp/cp_mi_sing_blackstation_utility;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_blackstation_comm_relay;

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 2
// Checksum 0xa27ece96, Offset: 0xd58
// Size: 0x19a
function objective_comm_relay_traverse_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        objectives::set( "cp_level_blackstation_comm_relay" );
        objectives::set( "cp_level_blackstation_goto_relay" );
        blackstation_utility::init_hendricks( "objective_comm_relay_traverse" );
        blackstation_utility::init_kane( "objective_relay_traverse_kane" );
        level.ai_kane ai::set_ignoreme( 1 );
        level.ai_kane ai::set_ignoreall( 1 );
        level.ai_hendricks setgoal( getnode( "hendricks_intro_end", "targetname" ), 1 );
        level.ai_kane setgoal( getnode( "kane_intro_end", "targetname" ), 1 );
        level thread blackstation_utility::police_station_corpses();
        level thread scene::play( "cin_bla_10_01_kaneintro_end_idle" );
        load::function_a2995f22();
        level thread namespace_4297372::function_6c35b4f3();
    }
    
    level thread blackstation_utility::player_rain_intensity( "light_ne" );
    comm_relay_traverse_main();
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 4
// Checksum 0x24eb4dac, Offset: 0xf00
// Size: 0x22
function objective_comm_relay_traverse_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xfd507ea4, Offset: 0xf30
// Size: 0xaa
function comm_relay_traverse_main()
{
    level thread function_3cd30cbd();
    level thread comm_relay_dialog();
    level thread breakable_atrium_windows_setup();
    level.ai_hendricks thread hendricks_behavior();
    
    if ( isdefined( level.bzm_blackstationdialogue4_1callback ) )
    {
        level thread [[ level.bzm_blackstationdialogue4_1callback ]]();
    }
    
    comm_relay_spawner_setup();
    trigger::wait_till( "trig_comm_relay_spawns", "targetname" );
    skipto::objective_completed( "objective_comm_relay_traverse" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 2
// Checksum 0xd7f9e56d, Offset: 0xfe8
// Size: 0x152
function objective_comm_relay_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        objectives::set( "cp_level_blackstation_comm_relay" );
        objectives::set( "cp_level_blackstation_goto_relay" );
        blackstation_utility::init_hendricks( "objective_comm_relay" );
        blackstation_utility::init_kane( "objective_blackstation_exterior" );
        level.ai_hendricks thread hendricks_behavior();
        level.ai_kane ai::set_ignoreme( 1 );
        level.ai_kane ai::set_ignoreall( 1 );
        level thread comm_relay_dialog_part2( b_starting );
        comm_relay_spawner_setup();
        trigger::use( "trig_comm_relay_spawns", "targetname" );
        level thread comm_relay_waypoints();
        level thread namespace_4297372::function_6c35b4f3();
        load::function_a2995f22();
    }
    
    comm_relay_main();
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x2dcad632, Offset: 0x1148
// Size: 0x15a
function comm_relay_spawner_setup()
{
    spawner::add_spawn_function_group( "comm_relay_group01", "targetname", &starter_behavior );
    spawner::add_spawn_function_group( "comm_relay_group02", "targetname", &reinforcement_behavior );
    spawner::add_spawn_function_group( "comm_relay_patroller", "script_noteworthy", &patrol_behavior );
    spawner::add_spawn_function_group( "comm_relay_retreater", "script_noteworthy", &retreater_behavior );
    spawner::simple_spawn( "comm_relay_awaken_robot1", &awaken_behavior );
    util::wait_network_frame();
    spawner::simple_spawn( "comm_relay_awaken_robot2", &awaken_behavior );
    util::wait_network_frame();
    spawner::simple_spawn( "comm_relay_awaken_robot3", &awaken_behavior );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 4
// Checksum 0x15850b3d, Offset: 0x12b0
// Size: 0x82
function objective_comm_relay_done( str_objective, b_starting, b_direct, player )
{
    objectives::complete( "cp_level_blackstation_goto_relay" );
    objectives::complete( "cp_level_blackstation_comm_relay" );
    objectives::set( "cp_level_blackstation_blackstation" );
    objectives::set( "cp_level_blackstation_rendezvous" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x19d5e1ef, Offset: 0x1340
// Size: 0x1b2
function comm_relay_main()
{
    level thread function_76732cae();
    level thread track_defenders();
    level thread table_flipper();
    level thread table_flip();
    level thread table_flipper_watcher();
    array::thread_all( level.activeplayers, &blackstation_utility::function_d870e0, "trig_comm_relay_approach" );
    array::thread_all( level.activeplayers, &blackstation_utility::function_d870e0, "comm_relay_interior_hendricks" );
    t_hack = getent( "clear_robot_use", "targetname" );
    t_hack triggerenable( 0 );
    spawner::simple_spawn_single( "comm_relay_igc_robot", &igc_robot );
    level flag::wait_till( "relay_reinforce" );
    spawner::simple_spawn( "comm_relay_back_room_humans" );
    spawner::simple_spawn( "comm_relay_group03", &function_aadd72bd );
    level flag::wait_till( "comm_relay_hacked" );
    skipto::objective_completed( "objective_comm_relay" );
    level.ai_hendricks notify( #"hash_d60979de" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x1aae142a, Offset: 0x1500
// Size: 0x62
function function_76732cae()
{
    trigger::wait_till( "trigger_comm_relay_window" );
    s_glass = struct::get( "comm_relay_glass" );
    glassradiusdamage( s_glass.origin, 10, 5000, 5000 );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x256c14da, Offset: 0x1570
// Size: 0x12
function delete_with_delay()
{
    wait 5;
    self delete();
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x4cb3ced5, Offset: 0x1590
// Size: 0x82
function function_3cd30cbd()
{
    level objectives::breadcrumb( "comm_relay_traverse_breadcrumb" );
    level objectives::breadcrumb( "breadcrumb_comm_relay_climb", "cp_level_blackstation_climb" );
    level objectives::breadcrumb( "breadcrumb_cross_bridge" );
    level objectives::breadcrumb( "comm_relay_breadcrumb" );
    level objectives::breadcrumb( "waypoint_comm_relay" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xdb2db22d, Offset: 0x1620
// Size: 0x32
function comm_relay_waypoints()
{
    level objectives::breadcrumb( "comm_relay_breadcrumb" );
    level objectives::breadcrumb( "waypoint_comm_relay" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xb788cf9e, Offset: 0x1660
// Size: 0xea
function comm_relay_dialog()
{
    level thread comm_relay_dialog_part2();
    level endon( #"comm_relay_engaged" );
    trigger::wait_till( "t_comms_vo" );
    level.ai_hendricks dialog::say( "hend_so_kane_now_that_t_0" );
    level dialog::remote( "kane_strike_and_strip_b_0", 0.5 );
    level dialog::player_say( "plyr_what_about_evac_for_0", 0.5 );
    level dialog::remote( "kane_facts_are_the_stat_0", 0.5 );
    level flag::wait_till( "comm_relay_dialog02" );
    level.ai_hendricks dialog::say( "hend_kane_we_re_approac_0" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 1
// Checksum 0xeae5dfa3, Offset: 0x1758
// Size: 0x92
function comm_relay_dialog_part2( b_starting )
{
    if ( !isdefined( b_starting ) )
    {
        b_starting = 0;
    }
    
    level flag::wait_till( "relay_room_clear" );
    level thread namespace_4297372::function_d4c52995();
    level thread scene::play( "cin_bla_11_01_comm_vign_scramble_hendricks_start" );
    level thread function_8f139027();
    level flag::set( "comm_relay_hendricks_ready" );
    level objectives::complete( "cp_waypoint_breadcrumb" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x1805b45a, Offset: 0x17f8
// Size: 0x4a
function function_8f139027()
{
    level endon( #"hash_60ad62af" );
    wait 25;
    level.ai_hendricks dialog::say( "hend_come_on_get_to_work_0" );
    wait 15;
    level.ai_hendricks dialog::say( "hend_we_don_t_got_all_day_0" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x733d932, Offset: 0x1850
// Size: 0x272
function igc_robot()
{
    self.goalradius = 4;
    self.nocybercom = 1;
    self ai::set_behavior_attribute( "can_gib", 0 );
    var_ebfa948 = self.health;
    self.health = self.health * 2;
    self.allowdeath = 0;
    self thread proximity_detection();
    self.fovcosine = 1;
    trigger::wait_till( "trig_comm_relay_igc_robot", "targetname", self );
    e_clip = getent( "comm_relay_console_clip", "targetname" );
    e_clip movez( 512, 0.05 );
    e_clip waittill( #"movedone" );
    self util::waittill_any( "enemy", "damage", "bulletwhizby", "comm_relay_proximity", "comm_relay_engaged" );
    level flag::set( "comm_relay_engaged" );
    self.fovcosine = 0;
    
    while ( self.health > var_ebfa948 )
    {
        wait 0.05;
    }
    
    level thread scene::play( "cin_bla_11_06_comm_vign_scramble_destroyrobot", self );
    e_clip delete();
    self notsolid();
    self oed::disable_thermal();
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self ai::set_behavior_attribute( "robot_lights", 2 );
    level waittill( #"hash_c11ac5b0" );
    level flag::set( "igc_robot_down" );
    level flag::wait_till( "comm_relay_hendricks_ready" );
    t_hack = getent( "clear_robot_use", "targetname" );
    t_hack triggerenable( 1 );
    util::init_interactive_gameobject( t_hack, &"cp_level_blackstation_hack_relay", &"CP_MI_SING_BLACKSTATION_MOVE_ROBOT", &function_af9d4545, self );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 1
// Checksum 0x9518401b, Offset: 0x1ad0
// Size: 0x19a
function function_af9d4545( e_player )
{
    e_player endon( #"death" );
    self gameobjects::disable_object();
    e_player thread function_4c16ca2b();
    e_player thread blackstation_utility::function_ed7faf05();
    level notify( #"hash_60ad62af" );
    level thread namespace_4297372::function_cde82250();
    level thread namespace_4297372::function_6c35b4f3();
    ai_robot = getent( "comm_relay_igc_robot_ai", "targetname" );
    
    if ( isdefined( level.bzm_blackstationdialogue4_2callback ) )
    {
        level thread [[ level.bzm_blackstationdialogue4_2callback ]]();
    }
    
    level scene::add_scene_func( "cin_bla_11_01_comm_vign_scramble_player_start", &function_104ecb4b );
    level scene::add_scene_func( "cin_bla_11_01_comm_vign_scramble_player_end", &function_77ccb9da, "play" );
    level scene::play( "cin_bla_11_01_comm_vign_scramble_player_start", array( e_player, ai_robot ) );
    level thread scene::play( "cin_bla_11_01_comm_vign_scramble_hendricks_end" );
    level scene::play( "cin_bla_11_01_comm_vign_scramble_player_end", array( e_player ) );
    e_player thread blackstation_utility::player_anchor();
    level flag::set( "comm_relay_hacked" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 1
// Checksum 0x87f2cd0f, Offset: 0x1c78
// Size: 0x75
function function_77ccb9da( a_ents )
{
    level thread function_53f20e51();
    level thread function_5be784f3();
    e_player = a_ents[ "player 1" ];
    
    while ( !level flag::get( "comm_relay_pulse" ) )
    {
        e_player cybercom::cybercom_armpulse( 1 );
        wait 3.05;
    }
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xef898301, Offset: 0x1cf8
// Size: 0x22
function function_53f20e51()
{
    level waittill( #"hash_311e66ea" );
    level flag::set( "comm_relay_pulse" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x98c99d9c, Offset: 0x1d28
// Size: 0x25a
function function_5be784f3()
{
    getent( "com_curve_on", "targetname" ) delete();
    getent( "com_rugged_on", "targetname" ) delete();
    getent( "com_curve_glitch_1", "targetname" ) show();
    getent( "com_rugged_glitch_1", "targetname" ) show();
    wait 7;
    getent( "com_curve_glitch_1", "targetname" ) delete();
    getent( "com_rugged_glitch_1", "targetname" ) delete();
    getent( "com_curve_glitch_2", "targetname" ) show();
    getent( "com_rugged_glitch_2", "targetname" ) show();
    level flag::wait_till( "comm_relay_pulse" );
    getent( "com_curve_glitch_2", "targetname" ) delete();
    getent( "com_rugged_glitch_2", "targetname" ) delete();
    getent( "com_curve_off", "targetname" ) show();
    getent( "com_rugged_off", "targetname" ) show();
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 1
// Checksum 0x8f37fa0d, Offset: 0x1f90
// Size: 0x6a
function function_104ecb4b( a_ents )
{
    level waittill( #"hash_7fd4ec9d" );
    e_robot = a_ents[ "comm_relay_igc_robot" ];
    
    if ( isdefined( e_robot ) )
    {
        e_robot detach( e_robot.head );
    }
    
    level waittill( #"hash_82ab74b7" );
    level thread scene::play( "cin_bla_11_01_comm_vign_scramble_hendricks_talk2kane" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xf0f45541, Offset: 0x2008
// Size: 0x42
function function_4c16ca2b()
{
    level endon( #"comm_relay_hacked" );
    self waittill( #"death" );
    level flag::set( "comm_relay_hacked" );
    level.ai_hendricks stopanimscripted();
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xab5bab18, Offset: 0x2058
// Size: 0x2a
function function_6c35b4f3()
{
    level flag::wait_till( "comm_relay_hacked" );
    level thread namespace_4297372::function_6c35b4f3();
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xc9120f03, Offset: 0x2090
// Size: 0x10a
function hendricks_behavior()
{
    self.ignoreall = 1;
    level flag::wait_till( "comm_relay_engaged" );
    self thread blackstation_utility::function_dccf6ccc();
    self.ignoreall = 0;
    level flag::wait_till( "relay_room_clear" );
    trigger::use( "trig_hendricks_comm_relay02", "targetname" );
    level flag::wait_till( "comm_relay_hacked" );
    level.ai_hendricks colors::disable();
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
    level scene::add_scene_func( "cin_bla_11_02_comm_vign_doorkick", &function_6eaf20ba );
    level thread scene::play( "cin_bla_11_02_comm_vign_doorkick", level.ai_hendricks );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 1
// Checksum 0x9787dda9, Offset: 0x21a8
// Size: 0xca
function function_6eaf20ba( a_ents )
{
    wait 0.5;
    level.ai_hendricks colors::enable();
    trigger::use( "triggercolor_walkway" );
    wait 0.5;
    getent( "comrelay_door_clip_right", "targetname" ) delete();
    getent( "comrelay_door_clip_left", "targetname" ) delete();
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 0 );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x7bb31b48, Offset: 0x2280
// Size: 0x3a
function function_aadd72bd()
{
    self endon( #"death" );
    wait randomint( 5 );
    self ai::set_behavior_attribute( "move_mode", "rusher" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xd443e6d7, Offset: 0x22c8
// Size: 0x11a
function starter_behavior()
{
    self endon( #"death" );
    self thread proximity_detection();
    self.fovcosine = 1;
    self util::waittill_any( "enemy", "damage", "bulletwhizby", "comm_relay_proximity", "comm_relay_engaged" );
    level flag::set( "comm_relay_engaged" );
    spawn_manager::enable( "comm_relay_group02_sm", 1 );
    self.fovcosine = 0;
    
    if ( self.archetype == "robot" )
    {
        self setgoal( getent( "comm_relay_goal_volume", "targetname" ) );
        level flag::wait_till( "comm_relay_back_room" );
        self setgoal( getent( "comm_relay_back_volume", "targetname" ), 1 );
    }
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x3c326588, Offset: 0x23f0
// Size: 0x33
function proximity_detection()
{
    self endon( #"death" );
    trigger::wait_till( "trig_comm_relay_proximity", "targetname" );
    self notify( #"comm_relay_proximity" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xfe459877, Offset: 0x2430
// Size: 0x2a
function reinforcement_behavior()
{
    self endon( #"death" );
    self ai::set_behavior_attribute( "move_mode", "rambo" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xfbfbab03, Offset: 0x2468
// Size: 0xeb
function patrol_behavior()
{
    self endon( #"death" );
    level endon( #"comm_relay_engaged" );
    next_node = getnearestnode( self.origin );
    
    do
    {
        self ai::force_goal( next_node, 4 );
        self waittill( #"goal" );
        
        if ( isdefined( next_node.script_wait_min ) && isdefined( next_node.script_wait_max ) )
        {
            self ai::force_goal( self.origin + anglestoforward( next_node.angles ) * 16, 4 );
            wait randomfloatrange( next_node.script_wait_min, next_node.script_wait_max );
        }
        
        next_node = getnode( next_node.target, "targetname" );
    }
    while ( isdefined( next_node ) );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x408a0a0c, Offset: 0x2560
// Size: 0x52
function retreater_behavior()
{
    self endon( #"death" );
    level flag::wait_till( "comm_relay_engaged" );
    self setgoal( getent( "comm_relay_back_volume", "targetname" ), 1 );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x983568f7, Offset: 0x25c0
// Size: 0x1e2
function awaken_behavior()
{
    self endon( #"death" );
    level endon( #"relay_room_clear" );
    self.script_noteworthy = "awakened_robot";
    s_scene = struct::get( self.target );
    s_scene scene::init( s_scene.scriptbundlename, self );
    mdl_origin = util::spawn_model( "tag_origin", s_scene.origin, s_scene.angles + ( 0, 90, 0 ) );
    mdl_origin scene::init( "p7_fxanim_cp_sgen_charging_station_open_01_bundle" );
    level flag::wait_till( "comm_relay_engaged" );
    level util::waittill_any_timeout( 45, "comm_relay_back_room", "defenders_low" );
    wait randomfloatrange( 2.5, 4 );
    level scene::add_scene_func( s_scene.scriptbundlename, &function_48aa6d93, "done" );
    s_scene thread scene::play( s_scene.scriptbundlename, self );
    level flag::set( "awakening_begun" );
    mdl_origin scene::play( "p7_fxanim_cp_sgen_charging_station_open_01_bundle" );
    mdl_origin delete();
    level flag::set( "awakening_end" );
    self setgoal( getent( "comm_relay_back_volume", "targetname" ) );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 1
// Checksum 0xf0e5e137, Offset: 0x27b0
// Size: 0x5f
function function_48aa6d93( a_ents )
{
    foreach ( ai_robot in a_ents )
    {
        ai_robot.b_activated = 1;
    }
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x2c40025d, Offset: 0x2818
// Size: 0xda
function track_defenders()
{
    level thread track_defenders_count();
    level thread track_awakened_robot_count();
    level flag::wait_till( "comm_relay_back_room" );
    spawn_manager::kill( "comm_relay_group02_sm", 1 );
    spawner::waittill_ai_group_cleared( "comm_relay_defenders" );
    level flag::wait_till( "igc_robot_down" );
    level flag::wait_till( "no_awakened_robots" );
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    savegame::checkpoint_save();
    level flag::set( "relay_room_clear" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xfbb1cf6e, Offset: 0x2900
// Size: 0x3b
function track_defenders_count()
{
    level flag::wait_till( "comm_relay_engaged" );
    spawner::waittill_ai_group_count( "comm_relay_defenders", 4 );
    level notify( #"defenders_low" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x5233c475, Offset: 0x2948
// Size: 0x85
function track_awakened_robot_count()
{
    level endon( #"relay_room_clear" );
    
    while ( true )
    {
        wait 0.25;
        level.a_awakened_robots = getaiarray( "awakened_robot", "script_noteworthy" );
        
        if ( level.a_awakened_robots.size > 0 )
        {
            level flag::set_val( "no_awakened_robots", 0 );
            continue;
        }
        
        level flag::set( "no_awakened_robots" );
    }
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x11f414de, Offset: 0x29d8
// Size: 0x52
function table_flipper_watcher()
{
    e_linker = getent( "e_table_linker", "targetname" );
    array::thread_all( level.activeplayers, &table_flipper_sighted, e_linker );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 1
// Checksum 0x5192d89a, Offset: 0x2a38
// Size: 0x95
function table_flipper_sighted( e_table )
{
    level endon( #"table_flip" );
    self endon( #"death" );
    n_distsq = 250000;
    
    while ( true )
    {
        self util::waittill_player_looking_at( e_table.origin, 25, 0, self );
        
        if ( distance2dsquared( self.origin, e_table.origin ) <= n_distsq )
        {
            level flag::set( "go_flippers" );
        }
        
        wait 0.1;
    }
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x68691860, Offset: 0x2ad8
// Size: 0x42
function table_flipper()
{
    level flag::wait_till( "go_flippers" );
    spawner::simple_spawn( "comm_relay_table_flippers", &function_34bb534a );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xe373cad7, Offset: 0x2b28
// Size: 0x72
function function_34bb534a()
{
    self endon( #"death" );
    self.goalradius = 8;
    self ai::set_behavior_attribute( "sprint", 1 );
    self waittill( #"goal" );
    level flag::set( "table_flip" );
    self.goalradius = 2048;
    self ai::set_behavior_attribute( "sprint", 0 );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0x5e5c7a14, Offset: 0x2ba8
// Size: 0x11a
function table_flip()
{
    level flag::wait_till( "table_flip" );
    a_table = getentarray( "com_relay_table", "targetname" );
    blackstation_utility::function_da77906f( a_table, "connect" );
    e_linker = getent( "e_table_linker", "targetname" );
    
    foreach ( ent in a_table )
    {
        ent linkto( e_linker );
    }
    
    e_linker rotateroll( 88, 0.4 );
    e_linker waittill( #"movedone" );
    blackstation_utility::function_da77906f( a_table, "disconnect" );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xb2f0a648, Offset: 0x2cd0
// Size: 0x42
function breakable_atrium_windows_setup()
{
    array::thread_all( getentarray( "trig_atrium_glass", "targetname" ), &atrium_windows_break );
}

// Namespace cp_mi_sing_blackstation_comm_relay
// Params 0
// Checksum 0xed3533ba, Offset: 0x2d20
// Size: 0x8a
function atrium_windows_break()
{
    v_origin = self.origin;
    self trigger::wait_till();
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "atrium_delete_path_clip" )
    {
        getent( "hendricks_window_clip", "targetname" ) delete();
    }
    
    glassradiusdamage( v_origin, 10, 500, 500 );
}

