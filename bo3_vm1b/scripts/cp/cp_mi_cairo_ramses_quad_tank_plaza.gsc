#using scripts/codescripts/struct;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses2_fx;
#using scripts/cp/cp_mi_cairo_ramses2_sound;
#using scripts/cp/cp_mi_cairo_ramses_accolades;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/vehicles/_raps;

#namespace quad_tank_plaza;

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x4f6b038d, Offset: 0x27e8
// Size: 0x22
function quad_tank_plaza_main()
{
    precache();
    plaza_main();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x2818
// Size: 0x2
function precache()
{
    
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x18d5bba3, Offset: 0x2828
// Size: 0x323
function pre_skipto()
{
    level.w_quadtank_weapon = getweapon( "quadtank_main_turret" );
    level.w_quadtank_player_weapon = getweapon( "quadtank_main_turret_player" );
    level.w_quadtank_mlrs_weapon = getweapon( "quadtank_main_turret_rocketpods_straight" );
    level.w_quadtank_mlrs_weapon2 = getweapon( "quadtank_main_turret_rocketpods_javelin" );
    level flag::init( "quad_tank_1_destroyed" );
    level flag::init( "quad_tank_2_spawned" );
    level flag::init( "quad_tank_2_destroyed" );
    level flag::init( "spawn_quad_tank_3" );
    level flag::init( "quad_tank_3_spawned" );
    level flag::init( "demo_player_controlled_quadtank" );
    level flag::init( "qt1_left_side" );
    level flag::init( "qt1_right_side" );
    level flag::init( "qt1_died_in_a_bad_place" );
    level flag::init( "qt_targets_statue" );
    level flag::init( "qt_plaza_statue_destroyed" );
    level flag::init( "qt_plaza_rocket_building_destroyed" );
    level flag::init( "qt_plaza_theater_destroyed" );
    level flag::init( "qt_plaza_theater_enemies_cleared" );
    level flag::init( "qt_plaza_mobile_wall_destroyed" );
    level flag::init( "obj_plaza_cleared" );
    level flag::init( "obj_player_at_plaza_igc" );
    level flag::init( "obj_follow_khalil" );
    level flag::init( "spawn_second_quadtank" );
    level flag::init( "third_quadtank_killed" );
    level flag::init( "qt_plaza_outro_igc_started" );
    level thread start_qt_plaza_ambient_combat();
    level thread qt1_friendly_vignettes();
    a_nd_nodes = getnodearray( "mobile_wall_exposed_nodes", "targetname" );
    
    foreach ( node in a_nd_nodes )
    {
        setenablenode( node, 0 );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x2c2b45cd, Offset: 0x2b58
// Size: 0x3a
function function_315508b4()
{
    var_cc018542 = getweapon( "launcher_standard" );
    self giveweapon( var_cc018542 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x473a9a5a, Offset: 0x2ba0
// Size: 0x45a
function start_qt_plaza_ambient_combat()
{
    ramses_accolades::function_f77ccfb1();
    ramses_accolades::function_359e6bb1();
    init_plaza_spawn_functions();
    init_statue_fxanim_clips();
    init_theater_fxanim_clips();
    init_palace_corner_fxanim_clips();
    init_outro_igc_shadow_cards();
    level thread setup_players_qt_plaza_threat_bias_group();
    level thread demo_mlrs_quadtank();
    a_e_goalvolume = getentarray( "qt_plaza_start_amws_goalvolume", "targetname" );
    a_sp_amws = getentarray( "qt_plaza_start_amws", "targetname" );
    level.a_qt_plaza_amws = [];
    
    foreach ( sp_awms in a_sp_amws )
    {
        ai_amws = spawner::simple_spawn_single( sp_awms );
        
        if ( isdefined( ai_amws ) )
        {
            ai_amws setgoal( a_e_goalvolume[ 0 ], 1 );
            a_e_goalvolume = array::remove_index( a_e_goalvolume, 0 );
            level.a_qt_plaza_amws[ level.a_qt_plaza_amws.size ] = ai_amws;
        }
        
        util::wait_network_frame();
    }
    
    util::wait_network_frame();
    vehicle::simple_spawn( "qt_plaza_turret" );
    util::wait_network_frame();
    spawn_manager::enable( "sm_egypt_plaza_wall" );
    util::wait_network_frame();
    spawn_manager::enable( "sm_egypt_palace_window" );
    util::wait_network_frame();
    spawn_manager::enable( "sm_egypt_quadtank" );
    util::wait_network_frame();
    spawn_manager::enable( "sm_egypt_siegebot" );
    util::wait_network_frame();
    e_spawnmanager = getent( "sm_nrc_siegebot", "targetname" );
    level thread spawn_manager::run_func_when_enabled( "sm_nrc_siegebot", &wave_spawner, e_spawnmanager, 20, 25, 2 );
    spawn_manager::enable( "sm_nrc_siegebot" );
    util::wait_network_frame();
    e_spawnmanager = getent( "sm_nrc_quadtank", "targetname" );
    level thread spawn_manager::run_func_when_enabled( "sm_nrc_quadtank", &wave_spawner, e_spawnmanager, 20, 25, 4 );
    spawn_manager::enable( "sm_nrc_quadtank" );
    util::wait_network_frame();
    spawn_manager::enable( "qt1_nrc_wasp_sm" );
    util::wait_network_frame();
    spawn_manager::enable( "sm_nrc_govt_building_rpg" );
    util::wait_network_frame();
    trigger::use( "trig_color_vtol_igc_allies", "targetname" );
    trigger::use( "trig_color_post_vtol_igc_axis", "targetname" );
    setthreatbias( "NRC_Quadtank", "Egyptian_RPG_guys", 100000 );
    
    while ( !isdefined( level.first_quadtank ) )
    {
        wait 0.05;
    }
    
    level thread ai_movement_on_vtol_igc_end();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x2dcbf8a3, Offset: 0x3008
// Size: 0x52
function ai_movement_on_vtol_igc_end()
{
    level flag::wait_till( "vtol_igc_done" );
    ai_retreat_left = getent( "egyptian_retreat_guy_left_ai", "targetname" );
    ai_retreat_left thread friendly_retreat_left();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xa394a3a4, Offset: 0x3068
// Size: 0x1d2
function friendly_retreat_left()
{
    self endon( #"death" );
    self ai::set_behavior_attribute( "disablearrivals", 1 );
    
    for ( nd_pos = getnode( "retreat_guy_left_path", "targetname" ); isdefined( nd_pos ) ; nd_pos = undefined )
    {
        self ai::force_goal( nd_pos, -128, 0, "near_goal", 1, 1 );
        self util::waittill_any( "near_goal", "goal" );
        
        if ( isdefined( nd_pos.target ) )
        {
            nd_pos = getnode( nd_pos.target, "targetname" );
            continue;
        }
    }
    
    s_scene = struct::get( "s_qt_plaza_egypt_debriscover", "targetname" );
    s_scene scene::play( self );
    
    for ( nd_pos = getnode( "retreat_guy_left_path_02", "targetname" ); isdefined( nd_pos ) ; nd_pos = undefined )
    {
        self ai::force_goal( nd_pos, -128, 0, "near_goal", 1, 1 );
        self util::waittill_any( "near_goal", "goal" );
        
        if ( isdefined( nd_pos.target ) )
        {
            nd_pos = getnode( nd_pos.target, "targetname" );
            continue;
        }
    }
    
    self ai::set_ignoreall( 0 );
    self util::stop_magic_bullet_shield();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x3b2347e8, Offset: 0x3248
// Size: 0xf2
function friendly_retreat_right()
{
    self endon( #"death" );
    nd_pos = getnode( "retreat_guy_right_path", "targetname" );
    self ai::set_ignoreall( 1 );
    
    while ( isdefined( nd_pos ) )
    {
        self ai::force_goal( nd_pos, -128, 0, "near_goal", 1, 1 );
        self util::waittill_any( "near_goal", "goal" );
        
        if ( isdefined( nd_pos.target ) )
        {
            nd_pos = getnode( nd_pos.target, "targetname" );
            continue;
        }
        
        nd_pos = undefined;
    }
    
    self ai::set_ignoreall( 0 );
    self util::stop_magic_bullet_shield();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x81495def, Offset: 0x3348
// Size: 0x942
function init_plaza_spawn_functions()
{
    createthreatbiasgroup( "Egyptian_RPG_guys" );
    createthreatbiasgroup( "NRC_Quadtank" );
    createthreatbiasgroup( "NRC_center_guys" );
    createthreatbiasgroup( "NRC_QT1_Shotgunners" );
    createthreatbiasgroup( "Players" );
    createthreatbiasgroup( "PlayerVehicles" );
    createthreatbiasgroup( "Egyptian_AI_near_players" );
    createthreatbiasgroup( "NRC_RPG_guys" );
    createthreatbiasgroup( "NRC_QT2_Robot_Rushers" );
    createthreatbiasgroup( "Egyptian_Theater_guys" );
    createthreatbiasgroup( "QT2_NRC_Raps" );
    createthreatbiasgroup( "QT2_Egyptian_Guys_on_Blocks" );
    createthreatbiasgroup( "NRC_Wasps" );
    createthreatbiasgroup( "NRC_AMWS" );
    createthreatbiasgroup( "NRC_theater_guys" );
    setthreatbias( "Players", "QT2_NRC_Raps", 1000 );
    setthreatbias( "PlayerVehicles", "QT2_NRC_Raps", 10000 );
    setthreatbias( "PlayerVehicles", "NRC_AMWS", 10000 );
    setthreatbias( "Players", "NRC_Quadtank", 0 );
    setthreatbias( "Players", "NRC_QT1_Shotgunners", -1000 );
    setthreatbias( "Players", "NRC_center_guys", -1000 );
    setthreatbias( "Players", "NRC_theater_guys", -1000 );
    setthreatbias( "Players", "NRC_Wasps", -1000 );
    setthreatbias( "Players", "NRC_AMWS", -1000 );
    vehicle::add_spawn_function( "demo_intro_mlrs_quadtank", &init_intro_quadtank );
    vehicle::add_hijack_function( "demo_intro_mlrs_quadtank", &quadtank_hijacked );
    vehicle::add_spawn_function( "artillery_quadtank", &init_artillery_quadtank );
    vehicle::add_hijack_function( "artillery_quadtank", &quadtank_hijacked );
    vehicle::add_spawn_function( "third_quadtank", &init_third_quadtank );
    vehicle::add_hijack_function( "third_quadtank", &quadtank_hijacked );
    vehicle::add_spawn_function( "qt_plaza_controllable_qt_raps", &qt_plaza_controllable_qt_raps_spawnfunc );
    vehicle::add_spawn_function( "qt_plaza_start_amws", &qt_plaza_start_amws_spawnfunc );
    vehicle::add_spawn_function( "qt1_nrc_amws", &qt1_nrc_amws_spawnfunc );
    vehicle::add_spawn_function( "qt1_raps", &qt1_nrc_raps_spawnfunc );
    vehicle::add_spawn_function( "qt_plaza_turret", &qt_plaza_turret_spawnfunc );
    vehicle::add_spawn_function( "qt2_nrc_wasps", &qt2_nrc_wasps_spawnfunc );
    vehicle::add_spawn_function( "qt2_nrc_wasps_berm", &qt2_nrc_wasps_berm_spawnfunc );
    vehicle::add_spawn_function( "qt2_nrc_wasps_palace", &qt2_nrc_wasps_palace_spawnfunc );
    vehicle::add_spawn_function( "qt2_raps", &qt2_nrc_raps_spawnfunc );
    spawner::add_spawn_function_group( "egypt_palace_window_guys", "targetname", &egypt_palace_window_guys_spawn_func );
    spawner::add_spawn_function_group( "egyptian_retreat_guy_left", "targetname", &egypt_retreat_guys_spawn_func );
    spawner::add_spawn_function_group( "egyptian_retreat_guy_right", "targetname", &egypt_retreat_guys_spawn_func );
    spawner::add_spawn_function_group( "statue_fall_guys", "targetname", &egypt_statue_fall_guys_spawn_func );
    spawner::add_spawn_function_group( "nrc_govt_building_rpg_guys", "targetname", &nrc_govt_building_rpg_guys_spawn_func );
    spawner::add_spawn_function_group( "nrc_rpg_berm_guys", "targetname", &nrc_berm_guys_spawn_func );
    spawner::add_spawn_function_group( "nrc_quadtank_guys", "targetname", &nrc_quadtank_guys_spawn_func );
    spawner::add_spawn_function_group( "qt2_robot_rushers", "targetname", &nrc_quadtank2_robot_rushers_spawn_func );
    spawner::add_spawn_function_group( "qt2_ally_theater", "targetname", &egypt_qt2_theater_spawn_func );
    spawner::add_spawn_function_group( "nrc_mobile_wall", "targetname", &nrc_mobile_wall_spawn_func );
    spawner::add_spawn_function_group( "nrc_theater", "targetname", &function_26fe7ac7 );
    a_plaza_wasps = getentarray( "plaza_wasps", "script_noteworthy" );
    
    foreach ( sp_wasp in a_plaza_wasps )
    {
        sp_wasp spawner::add_spawn_function( &plaza_wasps_think );
    }
    
    a_egypt_palace_window_guys = getentarray( "egypt_palace_window_guys", "targetname" );
    a_egypt_plaza_wall_guys = getentarray( "egypt_plaza_wall_guy", "targetname" );
    a_egyptian_rpg_guys = arraycombine( a_egypt_palace_window_guys, a_egypt_plaza_wall_guys, 1, 0 );
    
    foreach ( sp_rpg in a_egyptian_rpg_guys )
    {
        sp_rpg spawner::add_spawn_function( &egyptian_rpg_spawn_func );
    }
    
    a_nrc_govt_building_rpg_guys = getentarray( "nrc_govt_building_rpg_guys", "targetname" );
    a_nrc_rpg_berm_guys = getentarray( "nrc_rpg_berm_guys", "targetname" );
    a_nrc_rpg_guys = arraycombine( a_nrc_govt_building_rpg_guys, a_nrc_rpg_berm_guys, 1, 0 );
    
    foreach ( sp_rpg in a_nrc_rpg_guys )
    {
        sp_rpg spawner::add_spawn_function( &nrc_rpg_spawn_func );
    }
    
    spawner::simple_spawn( "egyptian_retreat_guy_left" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x94d1a30, Offset: 0x3c98
// Size: 0x5a
function egyptian_rpg_spawn_func()
{
    self setthreatbiasgroup( "Egyptian_RPG_guys" );
    e_goalvolume = getent( self.target, "targetname" );
    self setgoal( e_goalvolume, 1 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xaf396ba4, Offset: 0x3d00
// Size: 0x1a
function nrc_rpg_spawn_func()
{
    self setthreatbiasgroup( "NRC_RPG_guys" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x13540eb1, Offset: 0x3d28
// Size: 0xa2
function init_intro_quadtank()
{
    self endon( #"death" );
    self thread vtol_igc_quadtank_movement();
    self util::magic_bullet_shield();
    self quadtank::quadtank_weakpoint_display( 0 );
    level flag::wait_till( "vtol_igc_done" );
    self util::stop_magic_bullet_shield();
    self quadtank::quadtank_weakpoint_display( 1 );
    self thread intro_quadtank_movement();
    self thread intro_quadtank_deathfunc();
    self thread quadtank1_flavor_vo();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xc26a1a08, Offset: 0x3dd8
// Size: 0x87
function vtol_igc_quadtank_movement()
{
    self endon( #"death" );
    level endon( #"vtol_igc_done" );
    a_s_spots = struct::get_array( "demo_qt1_vtol_igc_movement", "targetname" );
    
    while ( true )
    {
        s_spot = array::random( a_s_spots );
        self setgoal( s_spot.origin, 1 );
        self waittill( #"at_anchor" );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x565620f5, Offset: 0x3e68
// Size: 0x1d7
function intro_quadtank_movement()
{
    self endon( #"death" );
    self flag::init( "intro_qt_damage_threshold_reached" );
    self thread intro_quadtank_health_watcher();
    
    if ( math::cointoss() )
    {
        a_s_spots = struct::get_array( "demo_qt1_movement_left_side", "targetname" );
        str_side = "left";
    }
    else
    {
        a_s_spots = struct::get_array( "demo_qt1_movement_right_side", "targetname" );
        str_side = "right";
    }
    
    while ( true )
    {
        self intro_quadtank_shuffle_movement( a_s_spots, str_side );
        s_spot = struct::get( "demo_qt1_movement_travel", "targetname" );
        self setgoal( s_spot.origin, 1 );
        self waittill( #"at_anchor" );
        
        if ( str_side == "left" || self flag::get( "intro_qt_damage_threshold_reached" ) )
        {
            str_side = "right";
        }
        else if ( str_side == "right" && !self flag::get( "intro_qt_damage_threshold_reached" ) )
        {
            str_side = "left";
        }
        
        level flag::set( "qt1_" + str_side + "_side" );
        level thread update_qt1_amws_goalvolume( str_side );
        a_s_spots = struct::get_array( "demo_qt1_movement_" + str_side + "_side", "targetname" );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x4a2fab4a, Offset: 0x4048
// Size: 0x61
function intro_quadtank_health_watcher()
{
    self endon( #"death" );
    n_health_threshold = self.health / 2;
    
    while ( true )
    {
        self waittill( #"damage" );
        
        if ( self.health <= n_health_threshold )
        {
            self notify( #"intro_quadtank_damage_threshold_reached" );
            self flag::set( "intro_qt_damage_threshold_reached" );
            break;
        }
    }
}

// Namespace quad_tank_plaza
// Params 2
// Checksum 0x46992977, Offset: 0x40b8
// Size: 0xfd
function intro_quadtank_shuffle_movement( a_s_spots, str_side )
{
    self endon( #"trophy_system_enabled" );
    
    if ( isdefined( 60 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 60, "timeout" );
    }
    
    if ( str_side == "left" )
    {
        self endon( #"intro_quadtank_damage_threshold_reached" );
    }
    
    for ( s_last_spot = undefined; true ; s_last_spot = s_spot )
    {
        while ( true )
        {
            s_spot = array::random( a_s_spots );
            
            if ( isdefined( s_last_spot ) && s_last_spot == s_spot )
            {
                continue;
            }
            
            break;
        }
        
        self setgoal( s_spot.origin, 1 );
        self waittill( #"at_anchor" );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x97c59581, Offset: 0x41c0
// Size: 0x82
function intro_quadtank_deathfunc()
{
    self waittill( #"death" );
    e_trigger = getent( "qt1_death_trigger", "targetname" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self istouching( e_trigger ) )
    {
        wait 5;
        self disconnectpaths();
        level flag::set( "qt1_died_in_a_bad_place" );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x2ed01484, Offset: 0x4250
// Size: 0x4a
function qt_plaza_start_amws_spawnfunc()
{
    self endon( #"death" );
    self endon( #"hash_f0738128" );
    self util::magic_bullet_shield();
    level flag::wait_till( "vtol_igc_done" );
    self util::stop_magic_bullet_shield();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x4177339b, Offset: 0x42a8
// Size: 0xda
function qt1_nrc_amws_spawnfunc()
{
    self endon( #"death" );
    self setthreatbiasgroup( "NRC_AMWS" );
    
    if ( level flag::get( "qt1_left_side" ) )
    {
        e_goalvolume = getent( "qt1_amws_right_goalvolume", "targetname" );
        self setgoal( e_goalvolume, 1 );
    }
    else if ( level flag::get( "qt1_right_side" ) )
    {
        e_goalvolume = getent( "qt1_amws_left_goalvolume", "targetname" );
        self setgoal( e_goalvolume, 1 );
    }
    
    self thread amws_vo_watcher();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x1897691d, Offset: 0x4390
// Size: 0x33
function amws_vo_watcher()
{
    self endon( #"death" );
    trigger::wait_till( "qt_plaza_alley_spawn_trigger", "targetname", self );
    level notify( #"amws_callout_vo" );
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xb08bac9f, Offset: 0x43d0
// Size: 0x17b
function update_qt1_amws_goalvolume( str_side )
{
    level notify( #"update_qt1_amws_goalvolume" );
    level endon( #"update_qt1_amws_goalvolume" );
    level flag::wait_till( "vtol_igc_done" );
    
    if ( str_side == "left" )
    {
        e_goalvolume = getent( "qt1_amws_right_goalvolume", "targetname" );
    }
    else if ( str_side == "right" )
    {
        e_goalvolume = getent( "qt1_amws_left_goalvolume", "targetname" );
    }
    
    a_start_amws = getentarray( "qt_plaza_start_amws_ai", "targetname", 1 );
    a_qt1_amws = getentarray( "qt1_nrc_amws_ai", "targetname", 1 );
    a_amws = arraycombine( a_start_amws, a_qt1_amws, 1, 0 );
    
    foreach ( amws in a_amws )
    {
        if ( isalive( amws ) )
        {
            amws setgoal( e_goalvolume, 1 );
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xe50e7b4c, Offset: 0x4558
// Size: 0x9a
function init_third_quadtank()
{
    self endon( #"death" );
    s_pos_1 = struct::get( "qt3_goalpos", "targetname" );
    self setgoal( s_pos_1.origin );
    self waittill( #"at_anchor" );
    level notify( #"start_quad_music" );
    e_goalvolume = getent( "third_quadtank_goalvolume", "targetname" );
    self setgoal( e_goalvolume, 1 );
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xad9cc9a6, Offset: 0x4600
// Size: 0xcf
function function_ca22c738( e_target )
{
    self endon( #"death" );
    self endon( #"hash_28b25b09" );
    var_26080a40 = getweapon( "quadtank_main_turret_rocketpods_straight" );
    self.perfectaim = 1;
    
    while ( true )
    {
        self vehicle_ai::setturrettarget( e_target, 0 );
        self util::waittill_any_timeout( 10, "turret_on_target" );
        
        for ( i = 0; i < 4 && isdefined( e_target ) ; i++ )
        {
            self setvehweapon( var_26080a40 );
            self fireweapon( 0, e_target );
            wait 0.8;
        }
        
        wait 10;
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x2b5830bf, Offset: 0x46d8
// Size: 0x3e2
function function_f536966()
{
    s_target = struct::get( "qt3_cannon_shot_pos", "targetname" );
    e_target = spawn( "script_model", s_target.origin );
    e_target setmodel( "tag_origin" );
    e_target.health = 100;
    self thread function_ca22c738( e_target );
    n_count = 0;
    t_damage = getent( "trigger_palace_collapse", "targetname" );
    
    while ( true )
    {
        t_damage waittill( #"damage", n_damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags );
        
        if ( attacker === self || attacker === level.quadtank_owner )
        {
            if ( type === "MOD_PROJECTILE" || type === "MOD_PROJECTILE_SPLASH" )
            {
                n_count++;
                
                if ( n_count > 1 )
                {
                    e_target notify( #"death" );
                    self notify( #"hash_28b25b09" );
                    self.perfectaim = 0;
                    self clearturrettarget( 0 );
                    self setvehweapon( getweapon( "quadtank_main_turret_rocketpods_javelin" ) );
                    break;
                }
            }
        }
    }
    
    level thread scene::play( "p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle" );
    level flag::set( "qt_plaza_rocket_building_destroyed" );
    t_damage delete();
    e_target delete();
    level thread kill_egyptians_inside_palace();
    rumble_and_camshake( "qt2_intro_org" );
    e_palace_corner_breach_carver = getent( "palace_corner_breach_carver", "targetname" );
    e_palace_corner_breach_carver delete();
    a_bm_palace_breach_corner = getentarray( "palace_corner_breach", "targetname" );
    
    foreach ( bm_piece in a_bm_palace_breach_corner )
    {
        if ( isdefined( bm_piece ) )
        {
            bm_piece delete();
        }
    }
    
    a_e_debris = getentarray( "palace_corner_blocker", "targetname" );
    
    foreach ( e_debris in a_e_debris )
    {
        e_debris solid();
        e_debris disconnectpaths();
        e_debris show();
    }
    
    e_palace_collision = getent( "palace_corner_breach_collision", "targetname" );
    e_palace_collision solid();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x196edbf2, Offset: 0x4ac8
// Size: 0x12a
function kill_egyptians_inside_palace()
{
    level endon( #"qt_plaza_outro_igc_started" );
    spawn_manager::disable( "sm_egypt_palace_window" );
    a_ai = spawn_manager::get_ai( "sm_egypt_palace_window" );
    
    foreach ( ai in a_ai )
    {
        if ( isalive( ai ) )
        {
            ai kill();
        }
    }
    
    s_pos = struct::get( "qt3_cannon_shot_pos", "targetname" );
    physicsexplosionsphere( s_pos.origin, 768, 768, 1 );
    wait 20;
    spawn_manager::enable( "sm_egypt_palace_window" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xf4e531f2, Offset: 0x4c00
// Size: 0x1a7
function ignore_players()
{
    foreach ( player in level.players )
    {
        player.ignoreme = 1;
        player enableinvulnerability();
    }
    
    foreach ( hero in level.heroes )
    {
        hero.ignoreme = 1;
    }
    
    level flag::wait_till( "vtol_igc_done" );
    wait 5;
    
    foreach ( player in level.players )
    {
        player.ignoreme = 0;
        player disableinvulnerability();
    }
    
    foreach ( hero in level.heroes )
    {
        hero.ignoreme = 0;
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xd5e3966f, Offset: 0x4db0
// Size: 0x52
function egypt_palace_window_guys_spawn_func()
{
    self endon( #"death" );
    self.ignoresuppression = 1;
    e_goalvolume = getent( self.target, "targetname" );
    self setgoal( e_goalvolume, 1 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x7c38cc5a, Offset: 0x4e10
// Size: 0x5a
function egypt_retreat_guys_spawn_func()
{
    self endon( #"death" );
    self util::magic_bullet_shield();
    nd_goal = getnode( self.target, "targetname" );
    self setgoal( nd_goal, 1 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xcff0af56, Offset: 0x4e78
// Size: 0x72
function qt_plaza_turret_spawnfunc()
{
    if ( !isdefined( level.qt_plaza_egyptian_turrets ) )
    {
        level.qt_plaza_egyptian_turrets = [];
    }
    
    level.qt_plaza_egyptian_turrets[ level.qt_plaza_egyptian_turrets.size ] = self;
    self util::magic_bullet_shield();
    self vehicle::toggle_sounds( 0 );
    level flag::wait_till( "vtol_igc_done" );
    self vehicle::toggle_sounds( 1 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xfacab1e5, Offset: 0x4ef8
// Size: 0x72
function qt2_nrc_wasps_spawnfunc()
{
    self endon( #"death" );
    self setthreatbiasgroup( "NRC_Wasps" );
    e_goalvolume = getent( "pre_qt2_nrc_wasp_goalvolume", "targetname" );
    self setgoal( e_goalvolume, 1 );
    self thread wasp_vo_trigger_watcher();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x6ab6a6cc, Offset: 0x4f78
// Size: 0x82
function qt2_nrc_wasps_berm_spawnfunc()
{
    self endon( #"death" );
    self setthreatbiasgroup( "NRC_Wasps" );
    e_goalvolume = getent( "qt2_nrc_wasp_berm_goalvolume", "targetname" );
    self setgoal( e_goalvolume, 1 );
    self.attackeraccuracy = 0.25;
    self thread wasp_vo_trigger_watcher();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x85c5dd71, Offset: 0x5008
// Size: 0x82
function qt2_nrc_wasps_palace_spawnfunc()
{
    self endon( #"death" );
    self setthreatbiasgroup( "NRC_Wasps" );
    e_goalvolume = getent( "qt2_nrc_wasp_palace_goalvolume", "targetname" );
    self setgoal( e_goalvolume, 1 );
    self.attackeraccuracy = 0.25;
    self thread wasp_vo_trigger_watcher();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xe7666e98, Offset: 0x5098
// Size: 0x4b
function qt2_nrc_raps_spawnfunc()
{
    self endon( #"death" );
    self setthreatbiasgroup( "QT2_NRC_Raps" );
    trigger::wait_till( "qt_plaza_alley_spawn_trigger", "targetname", self );
    level notify( #"raps_callout_vo" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xed03fce, Offset: 0x50f0
// Size: 0x14d
function magic_bullet_rpg()
{
    level endon( #"qt_plaza_outro_igc_started" );
    a_s_start_points = struct::get_array( "qt_plaza_magic_bullet_rpg", "targetname" );
    weapon = getweapon( "launcher_standard" );
    
    while ( true )
    {
        n_rpg_count = randomintrange( 1, 4 );
        
        for ( i = 0; i < n_rpg_count ; i++ )
        {
            s_start_point = array::random( a_s_start_points );
            a_s_end_points = struct::get_array( s_start_point.target, "targetname" );
            s_end_point = array::random( a_s_end_points );
            magicbullet( weapon, s_start_point.origin, s_end_point.origin );
            wait randomfloatrange( 2, 4 );
        }
        
        wait randomfloatrange( 20, 30 );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x85215a90, Offset: 0x5248
// Size: 0x1da
function plaza_main()
{
    level flag::wait_till( "vtol_igc_done" );
    level clientfield::set( "alley_fxanim_curtains", 0 );
    level.ai_hendricks util::delay( 10, undefined, &colors::set_force_color, "o" );
    trigger::use( "trig_color_post_vtol_igc_allies", "targetname" );
    level thread establish_egyptian_ignore_groups();
    level thread establish_nrc_ignore_groups();
    
    foreach ( player in level.players )
    {
        player thread player_hijack_watcher();
    }
    
    callback::on_spawned( &player_hijack_watcher );
    level thread post_vtol_igc_vo();
    level thread rpg_palace_callout_vo();
    level thread rpg_berm_callout_vo();
    level thread function_ffaf7dc4();
    
    if ( isdefined( level.bzm_ramsesdialogue7_1callback ) )
    {
        level thread [[ level.bzm_ramsesdialogue7_1callback ]]();
    }
    
    level thread quad_tank_plaza_hijacked_quadtank_watcher();
    level flag::wait_till( "quad_tank_1_destroyed" );
    level thread artillery_quadtank();
    level flag::wait_till( "spawn_quad_tank_3" );
    level thread third_quadtank();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x5b8c7020, Offset: 0x5430
// Size: 0x7a
function function_ffaf7dc4()
{
    level endon( #"qt_plaza_outro_igc_started" );
    var_8c4a6a64 = getentarray( "qtp_palace_rubble", "targetname" );
    array::run_all( var_8c4a6a64, &notsolid );
    level waittill( #"hash_7352ee5f" );
    array::run_all( var_8c4a6a64, &solid );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x9062edf, Offset: 0x54b8
// Size: 0x5f
function establish_egyptian_ignore_groups()
{
    while ( true )
    {
        if ( level.players.size > 1 )
        {
            setignoremegroup( "NRC_center_guys", "Egyptian_RPG_guys" );
        }
        
        if ( flag::get( "quad_tank_1_destroyed" ) )
        {
            break;
        }
        
        level waittill( #"player_spawned" );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x105a88dc, Offset: 0x5520
// Size: 0x52
function establish_nrc_ignore_groups()
{
    setignoremegroup( "Players", "NRC_RPG_guys" );
    setignoremegroup( "Egyptian_AI_near_players", "NRC_RPG_guys" );
    level thread setup_threat_bias_for_ai_near_players();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x8c7c2fca, Offset: 0x5580
// Size: 0xe7
function setup_players_qt_plaza_threat_bias_group()
{
    level endon( #"third_quadtank_killed" );
    
    foreach ( player in level.players )
    {
        player setthreatbiasgroup( "Players" );
    }
    
    while ( true )
    {
        level waittill( #"player_spawned" );
        
        foreach ( player in level.players )
        {
            player setthreatbiasgroup( "Players" );
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x6154a26d, Offset: 0x5670
// Size: 0x1d1
function setup_threat_bias_for_ai_near_players()
{
    level endon( #"third_quadtank_killed" );
    
    while ( true )
    {
        foreach ( player in level.activeplayers )
        {
            a_ai = getaiteamarray( "allies" );
            
            foreach ( ai in a_ai )
            {
                if ( isdefined( ai.script_noteworthy ) && ai.script_noteworthy == "qt_plaza_egyptian_rpg" )
                {
                    continue;
                }
                
                str_threat_bias = ai getthreatbiasgroup();
                
                if ( isdefined( str_threat_bias ) && str_threat_bias != "Egyptian_AI_near_players" )
                {
                    continue;
                }
                
                n_distance = distance2dsquared( ai.origin, player.origin );
                
                if ( n_distance <= 65536 )
                {
                    ai setthreatbiasgroup( "Egyptian_AI_near_players" );
                    ai.egyptian_ai_near_players = 1;
                    continue;
                }
                
                if ( isdefined( ai.egyptian_ai_near_players ) && ai.egyptian_ai_near_players )
                {
                    ai setthreatbiasgroup();
                    ai.egyptian_ai_near_players = 0;
                }
            }
            
            wait 0.1;
        }
        
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xb23f0e1d, Offset: 0x5850
// Size: 0x3a
function qt1_friendly_vignettes()
{
    level thread qt1_last_stand_scenes();
    level waittill( #"vtol_igc_start_qt_plaza_vignettes2" );
    level thread qt1_egyptian_wounded_scene();
    level thread qt1_rescueinjured_r_scene();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xc89fa37a, Offset: 0x5898
// Size: 0x1ca
function qt1_egyptian_wounded_scene()
{
    a_ai = spawner::simple_spawn( "qt_plaza_egyptian_wounded" );
    e_carver = getent( "egyptian_wounded_carver", "targetname" );
    e_carver disconnectpaths();
    a_amws = getentarray( "qt_plaza_start_amws_ai", "targetname", 1 );
    ai_amws = array::random( a_amws );
    ai_amws notify( #"hash_f0738128" );
    ai_amws util::magic_bullet_shield();
    s_target = struct::get( "egyptian_wounded_target", "targetname" );
    e_target = spawn( "script_model", s_target.origin );
    e_target setmodel( "tag_origin" );
    e_target.health = 100;
    ai_amws thread ai::shoot_at_target( "shoot_until_target_dead", e_target );
    s_scene = struct::get( "scene_qt_plaza_egyptian_wounded", "targetname" );
    s_scene scene::skipto_end( a_ai, undefined, undefined, 0.375 );
    ai_amws util::stop_magic_bullet_shield();
    e_carver delete();
    e_target notify( #"death" );
    e_target delete();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x8c65b3e6, Offset: 0x5a70
// Size: 0x2a
function function_3a7f574e()
{
    self endon( #"death" );
    self ai::set_ignoreme( 1 );
    self util::magic_bullet_shield();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x5395ecd2, Offset: 0x5aa8
// Size: 0x20a
function qt1_rescueinjured_r_scene()
{
    a_ai = spawner::simple_spawn( "qt_plaza_egyptian_rescueinjured_guy", &function_3a7f574e );
    e_clip1 = getent( "qt_plaza_left_vignette_carver1", "targetname" );
    e_clip1 disconnectpaths();
    e_clip2 = getent( "qt_plaza_left_vignette_carver2", "targetname" );
    e_clip2 disconnectpaths();
    s_scene = struct::get( "scene_qt_plaza_rescueinjured_r", "targetname" );
    s_scene thread scene::skipto_end( a_ai, undefined, undefined, 0.25 );
    level waittill( #"rescueinjured_loop_started" );
    e_clip1 delete();
    
    foreach ( ai in a_ai )
    {
        if ( isalive( ai ) )
        {
            ai ai::set_ignoreme( 0 );
            ai util::stop_magic_bullet_shield();
            ai colors::set_force_color( "p" );
            
            if ( ai.animname === "arena_defend_intro_r_injured" )
            {
                ai_injured = ai;
                ai_injured util::delay( 60, "death", &kill );
            }
        }
    }
    
    if ( isdefined( ai_injured ) )
    {
        ai_injured waittill( #"death" );
    }
    
    e_clip2 delete();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x8f8c1b15, Offset: 0x5cc0
// Size: 0xbb
function qt1_last_stand_scenes()
{
    level waittill( #"vtol_igc_start_qt_plaza_vignettes" );
    a_s_scenes = struct::get_array( "qt_plaza_last_stand_guys", "targetname" );
    
    foreach ( s_scene in a_s_scenes )
    {
        n_time = randomfloatrange( 0.05, 0.15 );
        s_scene thread scene::skipto_end( undefined, undefined, undefined, n_time );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xfbedfce7, Offset: 0x5d88
// Size: 0xda
function plaza_dialog()
{
    level.ai_hendricks dialog::say( "hend_we_need_to_clear_the_0" );
    wait 1.5;
    level.ai_hendricks dialog::say( "hend_quad_tank_on_the_de_0" );
    wait 1;
    level.ai_hendricks dialog::say( "hend_grab_that_launcher_a_0" );
    level flag::wait_till( "quad_tank_1_destroyed" );
    level.ai_hendricks dialog::say( "hend_yeah_tank_down_kee_0" );
    level flag::wait_till( "obj_plaza_cleared" );
    level.ai_khalil dialog::say( "khal_regroup_on_me_0" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xee4a65d9, Offset: 0x5e70
// Size: 0x202
function demo_mlrs_quadtank()
{
    vh_intro_mlrs_quadtank = spawner::simple_spawn_single( "demo_intro_mlrs_quadtank" );
    level.first_quadtank = vh_intro_mlrs_quadtank;
    vh_intro_mlrs_quadtank setthreatbiasgroup( "NRC_Quadtank" );
    setthreatbias( "Players", "NRC_Quadtank", -9999 );
    vh_intro_mlrs_quadtank quadtank::remove_repulsor();
    vh_intro_mlrs_quadtank util::magic_bullet_shield();
    level flag::wait_till( "vtol_igc_done" );
    vh_intro_mlrs_quadtank quadtank::quadtank_projectile_watcher();
    vh_intro_mlrs_quadtank thread function_27b2ebf2();
    callback::on_vehicle_damage( &function_15abacf7 );
    objectives::set( "cp_level_ramses_destroy_quadtank", vh_intro_mlrs_quadtank );
    vh_intro_mlrs_quadtank util::stop_magic_bullet_shield();
    level thread spawn_qt1_nrc_technical();
    level thread qt1_amws_spawn_manager();
    spawn_manager::disable( "qt1_nrc_wasp_sm" );
    setthreatbias( "Players", "NRC_Quadtank", 0 );
    vh_intro_mlrs_quadtank util::delay( 3, undefined, &function_f536966 );
    vh_intro_mlrs_quadtank util::waittill_any( "enter_vehicle", "death", "CloneAndRemoveEntity" );
    level flag::set( "quad_tank_1_destroyed" );
    callback::remove_on_vehicle_damage( &function_15abacf7 );
    savegame::checkpoint_save();
    objectives::complete( "cp_level_ramses_destroy_quadtank" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xc96052dc, Offset: 0x6080
// Size: 0xf9
function function_27b2ebf2()
{
    self endon( #"death" );
    var_fae93870 = 0;
    var_c1df3693 = 2;
    var_9a15ea97 = getweapon( "launcher_standard" );
    
    while ( true )
    {
        self waittill( #"projectile_applyattractor", missile );
        
        if ( missile.weapon === var_9a15ea97 )
        {
            var_fae93870++;
            
            if ( var_fae93870 >= var_c1df3693 )
            {
                foreach ( player in level.activeplayers )
                {
                    player util::show_hint_text( &"CP_MI_CAIRO_RAMSES_QUADTANK_REPULSOR_HINT" );
                }
                
                var_fae93870 = 0;
                var_c1df3693 *= 2;
            }
            
            wait 0.25;
        }
    }
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xb3ba3734, Offset: 0x6188
// Size: 0xf6
function function_15abacf7( params )
{
    if ( level.first_quadtank === self && self quadtank::trophy_disabled() )
    {
        if ( isplayer( params.eattacker ) && issubstr( params.smeansofdeath, "BULLET" ) )
        {
            player = params.eattacker;
            
            if ( isdefined( player.n_total_damage ) )
            {
                player.n_total_damage += params.idamage;
            }
            else
            {
                player.n_total_damage = params.idamage;
            }
            
            if ( player.n_total_damage > 999 )
            {
                player util::show_hint_text( &"CP_MI_CAIRO_RAMSES_QUADTANK_ROCKETS_HINT" );
                player.n_total_damage = 0;
            }
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xa624b97e, Offset: 0x6288
// Size: 0x27b
function spawn_qt1_nrc_technical()
{
    array::wait_till( level.a_qt_plaza_amws, "death" );
    a_nd_nodes = getnodearray( "qt1_nrc_truck_nodes", "script_noteworthy" );
    
    foreach ( node in a_nd_nodes )
    {
        setenablenode( node, 0 );
    }
    
    wait 5;
    vh_nrc_plaza_truck = spawner::simple_spawn_single( "nrc_qt1_truck" );
    
    if ( !isdefined( vh_nrc_plaza_truck ) )
    {
        return;
    }
    
    vh_nrc_plaza_truck thread nrc_technical_damagefunc();
    vh_nrc_plaza_truck thread function_c2a9c2e3();
    ai_gunner = spawner::simple_spawn_single( "nrc_technical_gunner" );
    ai_gunner vehicle::get_in( vh_nrc_plaza_truck, "gunner1", 1 );
    ai_driver = spawner::simple_spawn_single( "nrc_technical_gunner" );
    ai_driver vehicle::get_in( vh_nrc_plaza_truck, "driver", 1 );
    nd_truck_start = getvehiclenode( vh_nrc_plaza_truck.target, "targetname" );
    vh_nrc_plaza_truck thread vehicle::get_on_and_go_path( nd_truck_start );
    vh_nrc_plaza_truck thread function_e4aa3ab2( ai_driver );
    vh_nrc_plaza_truck turret::enable( 1, 1 );
    vh_nrc_plaza_truck makevehicleusable();
    vh_nrc_plaza_truck setseatoccupied( 0 );
    vh_nrc_plaza_truck util::waittill_any( "death", "reached_end_node" );
    
    foreach ( node in a_nd_nodes )
    {
        setenablenode( node, 1 );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x1d9c1781, Offset: 0x6510
// Size: 0x2a
function function_c2a9c2e3()
{
    self endon( #"death" );
    self waittill( #"hash_89126c82" );
    wait 1;
    self playsound( "evt_tech_driveup_qt" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xcb5ed414, Offset: 0x6548
// Size: 0xaa
function qt1_amws_spawn_manager()
{
    level endon( #"quad_tank_1_destroyed" );
    array::wait_till( level.a_qt_plaza_amws, "death" );
    level thread amws_callout_vo();
    e_spawnmanager = getent( "qt1_nrc_amws_sm", "targetname" );
    level thread spawn_manager::run_func_when_enabled( "qt1_nrc_amws_sm", &wave_spawner, e_spawnmanager, 10, 15, 2 );
    spawn_manager::enable( "qt1_nrc_amws_sm" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x125e2041, Offset: 0x6600
// Size: 0x5b2
function artillery_quadtank()
{
    a_ai_retreat = getentarray( "egyptian_retreat_guy_left_ai", "targetname" );
    
    foreach ( ai_guy in a_ai_retreat )
    {
        if ( isalive( ai_guy ) )
        {
            ai_guy dodamage( ai_guy.health, ai_guy.origin );
        }
    }
    
    trigger::use( "trig_color_quadtank2_allies" );
    trigger::use( "trig_color_quadtank2_axis" );
    level thread mlrs_defeated_move_up_vo();
    level notify( #"qt1_nrc_amws_sm_wave_spawner_stop" );
    spawn_manager::disable( "qt1_nrc_amws_sm" );
    e_goalvolume = getent( "post_qt1_amws_goalvolume", "targetname" );
    a_amws = spawn_manager::get_ai( "qt1_nrc_amws_sm" );
    
    foreach ( amws in a_amws )
    {
        amws setgoal( e_goalvolume, 1 );
    }
    
    spawn_manager::enable( "qt2_nrc_wasp_sm" );
    spawn_manager::enable( "sm_egypt_statue_fall" );
    
    if ( !level flag::get( "qt_plaza_theater_destroyed" ) )
    {
        spawn_manager::enable( "sm_egypt_theater" );
    }
    
    level.ai_khalil = util::get_hero( "khalil" );
    level.ai_khalil colors::set_force_color( "o" );
    s_khalil_start = struct::get( "khalil_start", "targetname" );
    level.ai_khalil skipto::teleport_single_ai( s_khalil_start );
    wait 5;
    level notify( #"qt2_nrc_wasp_sm_wave_spawner_stop" );
    spawn_manager::disable( "qt2_nrc_wasp_sm" );
    level thread artillery_quadtank_intro_vo();
    scene::add_scene_func( "p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle", &palace_wall_fxanim_notetracks, "play" );
    level scene::play( "p7_fxanim_cp_ramses_qt_plaza_palace_wall_collapse_bundle" );
    level.second_quadtank thread artillery_qt_destroys_statue();
    level flag::set( "quad_tank_2_spawned" );
    objectives::set( "cp_level_ramses_destroy_quadtank", level.second_quadtank );
    e_spawnmanager = getent( "qt2_nrc_wasp2_palace_sm", "targetname" );
    level thread spawn_manager::run_func_when_enabled( "qt2_nrc_wasp2_palace_sm", &wave_spawner, e_spawnmanager, 15, 20, 3 );
    spawn_manager::enable( "qt2_nrc_wasp2_palace_sm" );
    e_spawnmanager = getent( "qt2_nrc_robot_rushers_sm", "targetname" );
    level thread spawn_manager::run_func_when_enabled( "qt2_nrc_robot_rushers_sm", &wave_spawner, e_spawnmanager, 10, 15, 3 );
    spawn_manager::enable( "qt2_nrc_robot_rushers_sm" );
    setignoremegroup( "Egyptian_RPG_guys", "NRC_QT2_Robot_Rushers" );
    level thread robot_callout_vo();
    level thread egyptian_ai_ignore_qt2_nrc_raps();
    spawn_manager::enable( "qt2_nrc_raps_sm" );
    level thread raps_callout_vo();
    setignoremegroup( "Egyptian_Theater_guys", "NRC_QT2_Robot_Rushers" );
    setignoremegroup( "NRC_QT2_Robot_Rushers", "Egyptian_Theater_guys" );
    level flag::wait_till_any( array( "qt_plaza_statue_destroyed", "quad_tank_2_destroyed", "demo_player_controlled_quadtank" ) );
    
    if ( isalive( level.second_quadtank ) )
    {
        level.second_quadtank thread artillery_quadtank_movement_routine();
        level.second_quadtank thread quadtank_flavor_vo();
    }
    
    level flag::wait_till_any( array( "quad_tank_2_destroyed", "demo_player_controlled_quadtank" ) );
    objectives::complete( "cp_level_ramses_destroy_quadtank" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x990d438d, Offset: 0x6bc0
// Size: 0x72
function handle_qt2_depth_spawn_managers()
{
    level notify( #"sm_nrc_depth_wave_spawner_stop" );
    spawn_manager::disable( "sm_nrc_depth" );
    
    while ( true )
    {
        a_active_ai = spawn_manager::get_ai( "sm_nrc_depth" );
        
        if ( a_active_ai.size <= 2 )
        {
            break;
        }
        
        wait 1;
    }
    
    spawn_manager::enable( "sm_nrc_qt2_depth" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xa16f4ab1, Offset: 0x6c40
// Size: 0xc5
function egyptian_ai_ignore_qt2_nrc_raps()
{
    level endon( #"qt_plaza_outro_igc_started" );
    setignoremegroup( "QT2_NRC_Raps", "QT2_Egyptian_Guys_on_Blocks" );
    e_trigger = getent( "qt2_egyptian_guys_on_blocks", "targetname" );
    
    while ( true )
    {
        e_trigger waittill( #"trigger", ent );
        str_threat = ent getthreatbiasgroup();
        
        if ( str_threat == "QT2_Egyptian_Guys_on_Blocks" )
        {
            wait 0.1;
            continue;
        }
        
        ent setthreatbiasgroup( "QT2_Egyptian_Guys_on_Blocks" );
    }
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0x5168c79c, Offset: 0x6d10
// Size: 0x52
function palace_wall_fxanim_notetracks( a_ents )
{
    e_wall = getent( "qt_plaza_palace_wall_collapse", "targetname" );
    e_wall thread qt_first_hit();
    e_wall thread qt_ground_hit();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xc50999c7, Offset: 0x6d70
// Size: 0x42
function qt_first_hit()
{
    self waittill( #"qt_first_hit" );
    level notify( #"sm_nrc_siegebot_wave_spawner_stop" );
    spawn_manager::disable( "sm_nrc_siegebot" );
    rumble_and_camshake( "qt2_intro_org" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x2696674e, Offset: 0x6dc0
// Size: 0x39a
function qt_ground_hit()
{
    self waittill( #"qt_ground_hit" );
    level.second_quadtank.trophy_system_health = 0;
    level.second_quadtank.trophy_disables = 999;
    level.second_quadtank.displayweakpoint = 0;
    level.second_quadtank quadtank::quadtank_on();
    level.second_quadtank quadtank::remove_repulsor();
    level.second_quadtank quadtank::quadtank_weakpoint_display( 0 );
    level.second_quadtank vehicle_ai::set_state( "scripted" );
    n_damage = level.second_quadtank.healthdefault * 0.25;
    var_7e1ceefd = int( n_damage );
    level.second_quadtank.health -= var_7e1ceefd;
    level.second_quadtank vehicle::set_damage_fx_level( 1 );
    level.second_quadtank hidepart( "tag_lidar_null", "", 1 );
    level.second_quadtank hidepart( "tag_defense_active" );
    level.second_quadtank notify( #"trophy_system_destroyed" );
    level notify( #"trophy_system_destroyed", level.second_quadtank );
    level.second_quadtank util::delay( 3, undefined, &vehicle::toggle_lights_group, 1, 0 );
    a_bm_qt_fall_event = getentarray( "qt_fall_event", "targetname" );
    
    foreach ( bm_piece in a_bm_qt_fall_event )
    {
        if ( isdefined( bm_piece ) )
        {
            bm_piece delete();
        }
    }
    
    t_kill = getent( "qt2_intro_kill_trigger", "targetname" );
    a_ai = getaiarray();
    a_all_actors = arraycombine( a_ai, level.players, 1, 0 );
    
    foreach ( e_actor in a_all_actors )
    {
        if ( e_actor util::is_hero() )
        {
            continue;
        }
        
        if ( e_actor.targetname === "artillery_quadtank_ai" )
        {
            continue;
        }
        
        if ( e_actor istouching( t_kill ) )
        {
            if ( isplayer( e_actor ) )
            {
                e_actor dodamage( e_actor.health, e_actor.origin );
                break;
            }
            
            e_actor kill();
            break;
        }
    }
    
    rumble_and_camshake( "qt2_intro_org" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xc9d78e86, Offset: 0x7168
// Size: 0x3a
function init_artillery_quadtank()
{
    level.second_quadtank = self;
    self quadtank::quadtank_off();
    self thread qt2_resolve_death();
    self thread qt2_resolve_hijack();
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xcc42fea7, Offset: 0x71b0
// Size: 0x8c
function spawn_artillery_quadtank( b_dev_skipto )
{
    if ( !isdefined( b_dev_skipto ) )
    {
        b_dev_skipto = 0;
    }
    
    ai_artillery_quadtank = spawner::simple_spawn_single( "artillery_quadtank" );
    ai_artillery_quadtank ai::set_ignoreme( 1 );
    ai_artillery_quadtank ai::set_ignoreall( 1 );
    ai_artillery_quadtank quadtank::quadtank_weakpoint_display( 0 );
    
    if ( !b_dev_skipto )
    {
        ai_artillery_quadtank setthreatbiasgroup( "NRC_Quadtank" );
    }
    
    level.second_quadtank = ai_artillery_quadtank;
    return ai_artillery_quadtank;
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x6d9c503d, Offset: 0x7248
// Size: 0xd7
function artillery_quadtank_movement_routine()
{
    self endon( #"death" );
    
    if ( !level flag::get( "qt1_died_in_a_bad_place" ) )
    {
        s_pos = struct::get( "qt2_movement_path_A", "targetname" );
    }
    else
    {
    }
    
    for ( s_pos = struct::get( "qt2_movement_path_B", "targetname" ); isdefined( s_pos ) ; s_pos = undefined )
    {
        self setgoal( s_pos.origin, 1 );
        self waittill( #"at_anchor" );
        
        if ( isdefined( s_pos.target ) )
        {
            s_pos = struct::get( s_pos.target, "targetname" );
            continue;
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x4ffbeedc, Offset: 0x7328
// Size: 0xa2
function qt2_resolve_death()
{
    level endon( #"demo_player_controlled_quadtank" );
    self waittill( #"death" );
    wait 2;
    level flag::set( "quad_tank_2_destroyed" );
    savegame::checkpoint_save();
    trigger::use( "trig_color_quadtank3_allies" );
    trigger::use( "trig_color_quadtank3_axis" );
    wait 10;
    level flag::set( "spawn_quad_tank_3" );
    level thread stop_qt2_nrc_wasps();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xaaf104ea, Offset: 0x73d8
// Size: 0x62
function qt2_resolve_hijack()
{
    level endon( #"quad_tank_2_destroyed" );
    self waittill( #"cloneandremoveentity" );
    level flag::set( "demo_player_controlled_quadtank" );
    level thread handle_player_controllable_quadtank( self );
    level thread stop_qt2_nrc_wasps();
    wait 10;
    level flag::set( "spawn_quad_tank_3" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xcebf2574, Offset: 0x7448
// Size: 0x9a
function function_6fde5d65()
{
    battlechatter::function_d9f49fba( 0 );
    level dialog::remote( "tayr_we_need_to_expose_0" );
    level dialog::remote( "tayr_you_know_me_hendric_0", 2 );
    level dialog::remote( "tayr_you_were_supposed_to_0", 2 );
    level dialog::remote( "tayr_all_you_had_to_do_wa_0", 2 );
    level dialog::remote( "tayr_we_need_to_speak_to_0", 2 );
    battlechatter::function_d9f49fba( 1 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x972fd90, Offset: 0x74f0
// Size: 0x12b
function stop_qt2_nrc_wasps()
{
    level notify( #"qt2_nrc_wasp2_palace_sm_wave_spawner_stop" );
    spawn_manager::disable( "qt2_nrc_wasp2_palace_sm" );
    level notify( #"qt2_nrc_wasp2_berm_sm_wave_spawner_stop" );
    spawn_manager::disable( "qt2_nrc_wasp2_berm_sm" );
    e_goalvolume = getent( "post_qt2_wasp_goalvolume", "targetname" );
    a_wasp_palace = spawn_manager::get_ai( "qt2_nrc_wasp2_palace_sm" );
    a_wasp_berm = spawn_manager::get_ai( "qt2_nrc_wasp2_berm_sm" );
    a_wasps = arraycombine( a_wasp_palace, a_wasp_berm, 1, 0 );
    
    foreach ( ai_wasp in a_wasps )
    {
        ai_wasp setgoal( e_goalvolume, 1 );
    }
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xf5561a53, Offset: 0x7628
// Size: 0x132
function handle_player_controllable_quadtank( ai_artillery_quadtank )
{
    level notify( #"qt2_nrc_robot_rushers_sm_wave_spawner_stop" );
    spawn_manager::disable( "qt2_nrc_robot_rushers_sm" );
    trigger::use( "trig_color_player_controlled_QT_allies", "targetname" );
    trigger::use( "trig_color_player_controlled_QT_axis", "targetname" );
    level thread nrc_breach_theater();
    
    while ( !isdefined( level.player_controlled_quadtank ) )
    {
        wait 0.1;
    }
    
    level thread enable_spawn_managers_for_player_controllable_quadtank();
    level thread qt2_nrc_technical_trucks();
    level thread theater_spawn_manager_watcher();
    level flag::wait_till_any( array( "qt_plaza_theater_destroyed", "qt_plaza_theater_enemies_cleared", "spawn_quad_tank_3" ) );
    wait 3;
    spawn_manager::enable( "qt_plaza_controllable_qt_raps_sm" );
    level flag::set( "spawn_quad_tank_3" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xaa36127d, Offset: 0x7768
// Size: 0xc2
function enable_spawn_managers_for_player_controllable_quadtank()
{
    wait 3;
    a_nd_nodes = getnodearray( "mobile_wall_exposed_nodes", "targetname" );
    
    foreach ( node in a_nd_nodes )
    {
        setenablenode( node, 1 );
    }
    
    spawn_manager::enable( "nrc_mobile_wall_sm" );
    spawn_manager::enable( "demo_qt2_wasp_sm" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x1d559b13, Offset: 0x7838
// Size: 0x5d
function quad_tank_plaza_hijacked_quadtank_watcher()
{
    level endon( #"qt_plaza_outro_igc_started" );
    
    while ( true )
    {
        level waittill( #"clonedentity", clone );
        
        if ( clone.scriptvehicletype === "quadtank" )
        {
            level.player_controlled_quadtank = clone;
            level.player_controlled_quadtank thread function_1491a9ea();
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x38c18f18, Offset: 0x78a0
// Size: 0x22
function function_1491a9ea()
{
    self endon( #"death" );
    wait 5;
    self vehicle::lights_off();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xf8883ae9, Offset: 0x78d0
// Size: 0x3a
function theater_spawn_manager_watcher()
{
    level endon( #"third_quadtank_killed" );
    spawn_manager::wait_till_spawned_count( "nrc_theater_sm", 6 );
    level flag::set( "qt_plaza_theater_enemies_cleared" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x4f23dfef, Offset: 0x7918
// Size: 0x14a
function nrc_breach_theater()
{
    spawn_manager::disable( "sm_egypt_theater" );
    a_ai_egyptians = spawn_manager::get_ai( "sm_egypt_theater" );
    
    foreach ( ai_egyptian in a_ai_egyptians )
    {
        ai_egyptian.health = 1;
    }
    
    wait 5;
    spawn_manager::enable( "nrc_theater_sm" );
    a_e_breach_doors = getentarray( "breach_doors", "targetname" );
    
    foreach ( e_breach_door in a_e_breach_doors )
    {
        e_breach_door delete();
    }
    
    level thread theater_breach_vo();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xb35f72ee, Offset: 0x7a70
// Size: 0x383
function qt2_nrc_technical_trucks()
{
    a_nd_nodes = getnodearray( "qt3_nrc_truck_nodes", "script_noteworthy" );
    
    foreach ( node in a_nd_nodes )
    {
        setenablenode( node, 0 );
    }
    
    a_nd_nodes = getnodearray( "qt1_nrc_truck_nodes", "script_noteworthy" );
    
    foreach ( node in a_nd_nodes )
    {
        setenablenode( node, 0 );
    }
    
    a_sp_trucks = getentarray( "nrc_qt3_truck", "targetname" );
    truck_sound_counter = 1;
    
    foreach ( sp_truck in a_sp_trucks )
    {
        vh_nrc_plaza_truck = spawner::simple_spawn_single( sp_truck );
        
        if ( isdefined( vh_nrc_plaza_truck ) )
        {
            vh_nrc_plaza_truck thread nrc_technical_damagefunc();
            ai_gunner = spawner::simple_spawn_single( "nrc_technical_gunner" );
            ai_gunner vehicle::get_in( vh_nrc_plaza_truck, "gunner1", 1 );
            ai_driver = spawner::simple_spawn_single( "nrc_technical_gunner" );
            ai_driver vehicle::get_in( vh_nrc_plaza_truck, "driver", 1 );
            nd_truck_start = getvehiclenode( vh_nrc_plaza_truck.target, "targetname" );
            vh_nrc_plaza_truck thread vehicle::get_on_and_go_path( nd_truck_start );
            vh_nrc_plaza_truck thread function_e4aa3ab2( ai_driver );
            vh_nrc_plaza_truck thread nrc_driveup_sound( truck_sound_counter );
            truck_sound_counter += 1;
            vh_nrc_plaza_truck makevehicleusable();
            vh_nrc_plaza_truck setseatoccupied( 0 );
            vh_nrc_plaza_truck turret::enable( 1, 1 );
        }
        
        wait randomfloatrange( 2, 5 );
    }
    
    level thread technical_truck_callout_vo();
    wait 5;
    a_nd_nodes = getnodearray( "qt1_nrc_truck_nodes", "script_noteworthy" );
    
    foreach ( node in a_nd_nodes )
    {
        setenablenode( node, 1 );
    }
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0x1bd3d042, Offset: 0x7e00
// Size: 0x3a
function nrc_driveup_sound( counter )
{
    self endon( #"death" );
    self waittill( #"hash_89126c82" );
    self playsound( "evt_tech_driveup_qt_pair_" + counter );
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0x48358fae, Offset: 0x7e48
// Size: 0x42
function function_e4aa3ab2( ai_driver )
{
    self endon( #"death" );
    self waittill( #"reached_end_node" );
    
    if ( isalive( ai_driver ) )
    {
        ai_driver vehicle::get_out();
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x13a47d64, Offset: 0x7e98
// Size: 0x1cb
function nrc_technical_damagefunc()
{
    level endon( #"qt_plaza_outro_igc_started" );
    
    while ( true )
    {
        self waittill( #"damage", n_damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags );
        
        if ( weapon == level.w_quadtank_player_weapon || weapon == level.w_quadtank_mlrs_weapon || weapon == level.w_quadtank_mlrs_weapon2 )
        {
            self dodamage( self.health, self.origin );
            break;
        }
    }
    
    v_launch = anglestoforward( self.angles ) * -350 + ( 0, 0, 200 );
    v_org = self.origin + anglestoforward( self.angles ) * 10;
    self launchvehicle( v_launch, v_org, 0 );
    self thread nrc_technical_landed_watcher();
    a_ai_riders = self.riders;
    
    foreach ( ai in a_ai_riders )
    {
        ai dodamage( ai.health, ai.origin );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x5715b3b4, Offset: 0x8070
// Size: 0x7a
function nrc_technical_landed_watcher()
{
    self endon( #"death" );
    
    if ( isdefined( 60 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 60, "timeout" );
    }
    
    self waittill( #"veh_landed" );
    
    if ( isdefined( self ) )
    {
        self playsound( "evt_truck_impact" );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xe03e5613, Offset: 0x80f8
// Size: 0x22
function qt_plaza_controllable_qt_raps_spawnfunc()
{
    self endon( #"death" );
    self setthreatbiasgroup( "QT2_NRC_Raps" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x27b0c132, Offset: 0x8128
// Size: 0x52
function qt1_nrc_raps_spawnfunc()
{
    self endon( #"death" );
    self setthreatbiasgroup( "QT2_NRC_Raps" );
    self ai::set_ignoreme( 1 );
    self thread qt1_raps_hijack_watcher();
    self thread qt1_raps_death_watcher();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xda60e3c7, Offset: 0x8188
// Size: 0x37
function qt1_raps_hijack_watcher()
{
    level endon( #"stop_qt1_raps" );
    level endon( #"quad_tank_1_destroyed" );
    self endon( #"qt1_raps_death" );
    self waittill( #"cloneandremoveentity" );
    self notify( #"qt1_raps_hijack" );
    level notify( #"stop_qt1_raps" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x222cf395, Offset: 0x81c8
// Size: 0x37
function qt1_raps_death_watcher()
{
    level endon( #"stop_qt1_raps" );
    level endon( #"quad_tank_1_destroyed" );
    self endon( #"qt1_raps_hijack" );
    self waittill( #"death" );
    wait 2;
    
    if ( isdefined( self ) )
    {
        self notify( #"qt1_raps_death" );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x83f8d39, Offset: 0x8208
// Size: 0x252
function artillery_qt_destroys_statue()
{
    self endon( #"death" );
    var_6587b577 = ( 10731, -15846, -56 );
    self vehicle_ai::setturrettarget( var_6587b577, 0 );
    self util::waittill_any_timeout( 3, "turret_on_target" );
    s_target = struct::get( "qt_target_statue", "targetname" );
    e_target = spawn( "script_model", s_target.origin );
    e_target setmodel( "tag_origin" );
    e_target.health = 100;
    e_trigger = getent( "statue_fall_damage_trigger", "targetname" );
    self.perfectaim = 1;
    self.aim_set_by_shoot_at_target = 1;
    self vehicle_ai::set_state( "combat" );
    self thread ai::shoot_at_target( "shoot_until_target_dead", e_target );
    self thread egyptians_by_statue_vignettes();
    level flag::set( "qt_targets_statue" );
    
    while ( true )
    {
        e_trigger waittill( #"damage", n_damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags );
        
        if ( attacker == self && isdefined( weapon ) && weapon == level.w_quadtank_weapon )
        {
            e_target notify( #"death" );
            level flag::set( "qt_plaza_statue_destroyed" );
            self.perfectaim = 0;
            self.aim_set_by_shoot_at_target = 0;
            break;
        }
    }
    
    level thread plaza_statue_fall();
    e_target delete();
    level thread statue_fall_vo();
    wait 2;
    self thread function_24cd2cab();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xff6faacd, Offset: 0x8468
// Size: 0x202
function function_24cd2cab()
{
    self endon( #"death" );
    s_target = struct::get( "mobile_wall_fxanim", "targetname" );
    self vehicle_ai::setturrettarget( s_target.origin, 0 );
    self util::waittill_any_timeout( 3, "turret_on_target" );
    e_target = spawn( "script_model", s_target.origin );
    e_target setmodel( "tag_origin" );
    e_target.health = 100;
    e_trigger = getent( "mobile_wall_damage_trigger", "targetname" );
    self.perfectaim = 1;
    self.aim_set_by_shoot_at_target = 1;
    self vehicle_ai::set_state( "combat" );
    self thread ai::shoot_at_target( "shoot_until_target_dead", e_target );
    
    while ( true )
    {
        e_trigger waittill( #"damage", n_damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags );
        
        if ( attacker == self && isdefined( weapon ) && weapon == level.w_quadtank_weapon )
        {
            e_target notify( #"death" );
            level flag::set( "qt_plaza_mobile_wall_destroyed" );
            self.perfectaim = 0;
            self.aim_set_by_shoot_at_target = 0;
            break;
        }
    }
    
    level thread mobile_wall_fxanim();
    e_target delete();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x4f4dbadc, Offset: 0x8678
// Size: 0x52
function egypt_statue_fall_guys_spawn_func()
{
    self endon( #"death" );
    self util::magic_bullet_shield();
    self ai::set_ignoreme( 1 );
    self waittill( #"qt_plaza_statue_retreat" );
    self util::stop_magic_bullet_shield();
    self ai::set_ignoreme( 0 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xbe9d3028, Offset: 0x86d8
// Size: 0x2bf
function egyptians_by_statue_vignettes()
{
    a_ai = getentarray( "statue_fall_guys_ai", "targetname", 1 );
    spawn_manager::kill( "sm_egypt_statue_fall" );
    a_s_scenes = struct::get_array( "qt_plaza_statue_retreat", "targetname" );
    a_s_scenes_copy = arraycopy( a_s_scenes );
    
    while ( isalive( self ) && self.getreadytofire === 0 )
    {
        wait 0.05;
    }
    
    foreach ( ai in a_ai )
    {
        s_scene = arraygetclosest( ai.origin, a_s_scenes_copy );
        arrayremovevalue( a_s_scenes_copy, s_scene, 0 );
        s_scene thread scene::init( ai );
        wait randomfloatrange( 0.1, 0.25 );
    }
    
    level flag::wait_till_any( array( "qt_plaza_statue_destroyed", "quad_tank_2_destroyed", "demo_player_controlled_quadtank" ) );
    
    if ( level flag::get( "qt_plaza_statue_destroyed" ) )
    {
        level thread egyptian_statue_fall_vo( a_ai );
        
        foreach ( s_scene in a_s_scenes )
        {
            s_scene thread scene::play();
            wait randomfloatrange( 0.1, 0.25 );
        }
    }
    else
    {
        level scene::stop( "cin_gen_react_retreat" );
    }
    
    foreach ( ai in a_ai )
    {
        if ( isalive( ai ) )
        {
            ai notify( #"qt_plaza_statue_retreat" );
            ai.goalradius = 512;
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x70b77f0d, Offset: 0x89a0
// Size: 0x7b
function nrc_govt_building_rpg_guys_spawn_func()
{
    self endon( #"death" );
    e_goalvolume = getent( self.target, "targetname" );
    self setgoal( e_goalvolume, 1 );
    self.ignoresuppression = 1;
    trigger::wait_till( self.target, "targetname", self );
    level notify( #"rpg_palace_callout_vo" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x4514da18, Offset: 0x8a28
// Size: 0x1a
function function_26fe7ac7()
{
    self setthreatbiasgroup( "NRC_theater_guys" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x7149651f, Offset: 0x8a50
// Size: 0x73
function nrc_berm_guys_spawn_func()
{
    self endon( #"death" );
    e_goalvolume = getent( self.target, "targetname" );
    self setgoal( e_goalvolume, 1 );
    trigger::wait_till( self.target, "targetname", self );
    level notify( #"rpg_berm_callout_vo" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xafbf74b3, Offset: 0x8ad0
// Size: 0x162
function nrc_quadtank_guys_spawn_func()
{
    self endon( #"death" );
    self setthreatbiasgroup( "NRC_center_guys" );
    
    if ( level.players.size > 1 )
    {
        a_ai = spawn_manager::get_ai( "sm_nrc_quadtank" );
        
        if ( a_ai.size > 0 && isdefined( level.qt_plaza_egyptian_turrets ) && level.qt_plaza_egyptian_turrets.size > 0 )
        {
            foreach ( e_turret in level.qt_plaza_egyptian_turrets )
            {
                e_turret turret::set_ignore_ent_array( a_ai, 0 );
            }
        }
    }
    
    if ( !level flag::get( "quad_tank_1_destroyed" ) )
    {
        if ( issubstr( self.classname, "shotgun" ) )
        {
            n_count = spawner::get_ai_group_ai( "qt1_nrc_shotgunner" ).size;
            
            if ( n_count < 4 )
            {
                self thread qt1_nrc_cqb_shotgun_rusher();
            }
            
            return;
        }
        
        self thread function_6639b8f8();
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x5f28cfa0, Offset: 0x8c40
// Size: 0x132
function qt1_nrc_cqb_shotgun_rusher()
{
    self endon( #"death" );
    self flag::init( "nrc_qt1_shotgunner_rush" );
    self setthreatbiasgroup( "NRC_QT1_Shotgunners" );
    setignoremegroup( "NRC_QT1_Shotgunners", "Egyptian_RPG_guys" );
    setignoremegroup( "Egyptian_RPG_guys", "NRC_QT1_Shotgunners" );
    self thread function_10c25a20();
    self waittill( #"goal" );
    wait randomfloatrange( 5, 20 );
    self flag::set( "nrc_qt1_shotgunner_rush" );
    a_nd_nodes = getnodearray( "nrc_shotgun_rusher_node", "targetname" );
    nd_goal = array::random( a_nd_nodes );
    self setgoal( nd_goal, 1 );
    self thread qt1_nrc_shotgun_goalvolume();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xe61dc3e7, Offset: 0x8d80
// Size: 0x52
function function_10c25a20()
{
    self endon( #"death" );
    self endon( #"hash_cb188399" );
    self ramses_util::function_f08afb37();
    util::waittill_any_ents( level, "quad_tank_1_destroyed", self, "nrc_qt1_shotgunner_rush" );
    self ramses_util::function_f08afb37( 0 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x86553b0a, Offset: 0x8de0
// Size: 0x72
function qt1_nrc_shotgun_goalvolume()
{
    self endon( #"death" );
    e_goalvolume = getent( "qt1_nrc_rusher_goalvolume", "targetname" );
    
    while ( true )
    {
        e_goalvolume waittill( #"trigger", ent );
        
        if ( ent == self )
        {
            break;
        }
    }
    
    self setgoal( e_goalvolume, 1 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x8ec72a7b, Offset: 0x8e60
// Size: 0x4a
function function_6639b8f8()
{
    self endon( #"death" );
    self endon( #"hash_cb188399" );
    self ramses_util::function_f08afb37();
    level flag::wait_till( "quad_tank_1_destroyed" );
    self ramses_util::function_f08afb37( 0 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x9fe306b5, Offset: 0x8eb8
// Size: 0xa3
function nrc_quadtank2_robot_rushers_spawn_func()
{
    self endon( #"death" );
    self setthreatbiasgroup( "NRC_QT2_Robot_Rushers" );
    setignoremegroup( "Egyptian_RPG_guys", "NRC_QT2_Robot_Rushers" );
    self ai::set_behavior_attribute( "move_mode", "rusher" );
    self ai::set_behavior_attribute( "sprint", 1 );
    trigger::wait_till( "robot_callout_vo_trigger", "targetname", self );
    level notify( #"robot_callout_vo" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x89b16a3c, Offset: 0x8f68
// Size: 0x22
function egypt_qt2_theater_spawn_func()
{
    self endon( #"death" );
    self setthreatbiasgroup( "Egyptian_Theater_guys" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x54161819, Offset: 0x8f98
// Size: 0xc5
function nrc_mobile_wall_spawn_func()
{
    self endon( #"death" );
    a_s_scenes = struct::get_array( "qt_plaza_traverse_mobile_wall", "targetname" );
    a_s_scenes = array::randomize( a_s_scenes );
    
    while ( true )
    {
        foreach ( s_scene in a_s_scenes )
        {
            if ( !s_scene scene::is_playing() )
            {
                s_scene scene::play( self );
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x8b5e6bd2, Offset: 0x9068
// Size: 0x243
function init_statue_fxanim_clips()
{
    a_e_carver = getentarray( "wing_carver_slanty", "targetname" );
    
    foreach ( e_carver in a_e_carver )
    {
        e_carver notsolid();
        e_carver connectpaths();
    }
    
    a_e_carver = getentarray( "wing_carver_upright", "targetname" );
    
    foreach ( e_carver in a_e_carver )
    {
        e_carver notsolid();
        e_carver connectpaths();
    }
    
    a_e_collision = getentarray( "wing_slanty_collision", "targetname" );
    
    foreach ( e_clip in a_e_collision )
    {
        e_clip notsolid();
        e_clip connectpaths();
    }
    
    a_e_collision = getentarray( "wing_collision_upright", "targetname" );
    
    foreach ( e_clip in a_e_collision )
    {
        e_clip notsolid();
        e_clip connectpaths();
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xc168e2bb, Offset: 0x92b8
// Size: 0xaa
function init_theater_fxanim_clips()
{
    a_e_post_collapse = getentarray( "post_collapse_collision", "targetname" );
    
    foreach ( e_clip in a_e_post_collapse )
    {
        e_clip notsolid();
        e_clip connectpaths();
    }
    
    hide_destroyed_theater_fx_anim();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x5266e432, Offset: 0x9370
// Size: 0x193
function init_palace_corner_fxanim_clips()
{
    a_e_debris = getentarray( "palace_corner_blocker", "targetname" );
    
    foreach ( e_debris in a_e_debris )
    {
        e_debris notsolid();
        e_debris connectpaths();
        e_debris hide();
    }
    
    a_nd_nodes = getnodearray( "qt_plaza_palace_corner_cover", "script_noteworthy" );
    
    foreach ( node in a_nd_nodes )
    {
        setenablenode( node, 0 );
    }
    
    wait 0.1;
    
    foreach ( node in a_nd_nodes )
    {
        setenablenode( node, 1 );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xb521baf9, Offset: 0x9510
// Size: 0x9a
function init_outro_igc_shadow_cards()
{
    e_card = getent( "outro_shot_010_shadow", "targetname" );
    e_card hide();
    e_card = getent( "outro_shot_020_shadow", "targetname" );
    e_card hide();
    e_card = getent( "outro_shot_040_shadow", "targetname" );
    e_card hide();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x7234d56, Offset: 0x95b8
// Size: 0x4a
function plaza_statue_fall()
{
    scene::add_scene_func( "p7_fxanim_cp_ramses_quadtank_statue_bundle", &function_5fea384c, "play" );
    level scene::play( "p7_fxanim_cp_ramses_quadtank_statue_bundle" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x1ce28a59, Offset: 0x9610
// Size: 0x62
function function_5fea384c()
{
    rumble_and_camshake( "s_statue_pos" );
    e_qt_statue = getent( "quadtank_statue", "targetname" );
    e_qt_statue thread bird_wing_impact();
    e_qt_statue thread bird_body_impact();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x4463c09c, Offset: 0x9680
// Size: 0x305
function bird_wing_impact()
{
    self waittill( #"bird_wing_impact" );
    rumble_and_camshake( "bird_wing_impact" );
    a_e_carver = getentarray( "wing_carver_upright", "targetname" );
    
    foreach ( e_carver in a_e_carver )
    {
        e_carver solid();
        e_carver disconnectpaths();
    }
    
    a_e_collision = getentarray( "wing_collision_upright", "targetname" );
    
    foreach ( e_clip in a_e_collision )
    {
        e_clip solid();
        e_clip disconnectpaths();
    }
    
    a_t_kill_statue_fall = getentarray( "trig_kill_bird_wing", "targetname" );
    a_ai = getaiarray();
    a_all_actors = arraycombine( a_ai, level.players, 1, 0 );
    
    foreach ( e_actor in a_all_actors )
    {
        if ( e_actor util::is_hero() )
        {
            continue;
        }
        
        if ( e_actor === level.player_controlled_quadtank )
        {
            e_actor dodamage( e_actor.health, e_actor.origin );
        }
        
        foreach ( t_kill in a_t_kill_statue_fall )
        {
            if ( e_actor istouching( t_kill ) )
            {
                if ( isplayer( e_actor ) )
                {
                    e_actor dodamage( e_actor.health, e_actor.origin );
                    break;
                }
                
                e_actor kill();
                break;
            }
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x3b15b9b7, Offset: 0x9990
// Size: 0x38d
function bird_body_impact()
{
    self waittill( #"bird_body_impact" );
    rumble_and_camshake( "bird_body_impact" );
    a_e_carver = getentarray( "wing_carver_slanty", "targetname" );
    
    foreach ( e_carver in a_e_carver )
    {
        e_carver solid();
        e_carver disconnectpaths();
    }
    
    a_e_collision = getentarray( "wing_slanty_collision", "targetname" );
    
    foreach ( e_clip in a_e_collision )
    {
        e_clip solid();
        e_clip disconnectpaths();
    }
    
    a_nd_statue = getnodearray( "statue_fall_cover_nodes", "targetname" );
    
    foreach ( nd_statue in a_nd_statue )
    {
        setenablenode( nd_statue, 0 );
    }
    
    a_t_kill_statue_fall = getentarray( "trig_kill_bird_body", "targetname" );
    a_ai = getaiarray();
    a_all_actors = arraycombine( a_ai, level.players, 1, 0 );
    
    foreach ( e_actor in a_all_actors )
    {
        if ( e_actor util::is_hero() )
        {
            continue;
        }
        
        if ( e_actor === level.player_controlled_quadtank )
        {
            e_actor dodamage( e_actor.health, e_actor.origin );
        }
        
        foreach ( t_kill in a_t_kill_statue_fall )
        {
            if ( e_actor istouching( t_kill ) )
            {
                if ( isplayer( e_actor ) )
                {
                    e_actor dodamage( e_actor.health, e_actor.origin );
                    break;
                }
                
                e_actor kill();
                break;
            }
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x1dcee811, Offset: 0x9d28
// Size: 0x22a
function third_quadtank()
{
    level thread function_6fde5d65();
    ai_third_quadtank = spawner::simple_spawn_single( "third_quadtank" );
    level.third_quadtank = ai_third_quadtank;
    ai_third_quadtank setthreatbiasgroup( "NRC_Quadtank" );
    ai_third_quadtank thread third_quadtank_deathfunc();
    level flag::set( "quad_tank_3_spawned" );
    objectives::set( "cp_level_ramses_destroy_quadtank", ai_third_quadtank );
    level thread namespace_a6a248fc::function_63054139();
    level thread qt3_phalanx();
    a_bm_second_quadtank_wall = getentarray( "oh_yeah_explosion", "targetname" );
    
    foreach ( e_piece in a_bm_second_quadtank_wall )
    {
        e_piece delete();
    }
    
    scene::add_scene_func( "p7_fxanim_cp_ramses_quadtank_plaza_glass_building_bundle", &third_quadtank_spawn_vo, "done" );
    level thread scene::play( "p7_fxanim_cp_ramses_quadtank_plaza_glass_building_bundle" );
    rumble_and_camshake( "glass_building_pos" );
    ai_third_quadtank thread quadtank_flavor_vo();
    level flag::wait_till( "third_quadtank_killed" );
    objectives::complete( "cp_level_ramses_destroy_quadtank" );
    level notify( #"qt2_nrc_robot_rushers_sm_wave_spawner_stop" );
    spawn_manager::disable( "qt2_nrc_robot_rushers_sm" );
    level notify( #"sm_nrc_quadtank_wave_spawner_stop" );
    spawn_manager::disable( "sm_nrc_quadtank" );
    qt_plaza_outro();
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0x62582a31, Offset: 0x9f60
// Size: 0x5ea
function qt_plaza_outro( b_dev_skipto )
{
    if ( !isdefined( b_dev_skipto ) )
    {
        b_dev_skipto = 0;
    }
    
    ramses_accolades::function_84fd481b();
    ramses_accolades::function_c31ee41b();
    level thread util::set_streamer_hint( 4, 1 );
    
    if ( isdefined( level.player_controlled_quadtank ) && level.player_controlled_quadtank.targetname === "third_quadtank_ai" )
    {
        wait 15;
    }
    
    wait 3;
    level clientfield::set( "sndIGCsnapshot", 4 );
    util::screen_fade_out( 3 );
    array::run_all( level.activeplayers, &enableinvulnerability );
    function_e2d7342();
    quad_tank_plaza_spawn_manager_cleanup();
    level thread stop_dead_system_fx_anim();
    battlechatter::function_d9f49fba( 0 );
    level.ai_hendricks dialog::say( "hend_that_s_the_last_of_1", 0.5 );
    wait 1;
    level util::clientnotify( "pre_outro_fade_in" );
    level flag::set( "qt_plaza_outro_igc_started" );
    level thread namespace_a6a248fc::function_ff483e3c();
    level thread audio::unlockfrontendmusic( "mus_ramses_battle_intro" );
    level thread scene::init( "p7_fxanim_cp_ramses_flyover_plaza_cinematic_bundle" );
    vehicle::add_spawn_function( "qt_plaza_outro_vtol_flyovers", &vtol_qt_flyover_spawnfunc );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh010", &trigger_play_corpse_scenes_initial, "play" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh020", &trigger_play_corpse_scenes_sh030, "play" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh010", &sh010_shadow_card_show, "play" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh010", &sh010_shadow_card_hide, "done" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh020", &function_b54fb58e, "play" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh030", &function_a5697ed9, "play" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh020", &start_sh020_vtol_flyovers, "play" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh030", &start_sh030_vtol_flyovers, "play" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh020", &sh020_shadow_card_show, "play" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh020", &sh020_shadow_card_hide, "done" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh040", &sh040_shadow_card_show, "play" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh040", &function_40ffea00, "play" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh050", &function_892c9e40, "play" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh030", &adjust_sunshadowsplitdistance, "play" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh030", &reset_sunshadowsplitdistance, "done" );
    scene::add_scene_func( "cin_ram_08_gettofreeway_3rd_sh320", &fade_out_and_end, "play" );
    level clientfield::set( "qt_plaza_outro_exposure", 1 );
    
    if ( isdefined( level.bzm_ramsesdialogue8callback ) )
    {
        level thread [[ level.bzm_ramsesdialogue8callback ]]();
    }
    
    util::delay( 1, undefined, &util::screen_fade_in, 1 );
    array::run_all( level.activeplayers, &disableinvulnerability );
    level thread scene::play( "cin_ram_08_gettofreeway_3rd_sh010" );
    
    if ( !level flag::get( "qt_plaza_statue_destroyed" ) )
    {
        level scene::skipto_end( "p7_fxanim_cp_ramses_quadtank_statue_bundle" );
    }
    
    if ( !level flag::get( "qt_plaza_rocket_building_destroyed" ) )
    {
        level scene::skipto_end( "p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle" );
    }
    
    if ( !level flag::get( "qt_plaza_mobile_wall_destroyed" ) )
    {
        level scene::skipto_end( "p7_fxanim_cp_ramses_mobile_wall_explode_bundle" );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xf04c874c, Offset: 0xa558
// Size: 0x9a
function function_e2d7342()
{
    var_aafd7555 = 0;
    
    foreach ( player in level.activeplayers )
    {
        if ( isdefined( player.hijacked_vehicle_entity ) )
        {
            var_aafd7555 = 1;
            player.hijacked_vehicle_entity usevehicle( player, 0 );
        }
    }
    
    if ( var_aafd7555 )
    {
        wait 5;
        return;
    }
    
    wait 2;
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xca1784e7, Offset: 0xa600
// Size: 0x22
function trigger_play_corpse_scenes_initial( a_ents )
{
    trigger::use( "trigger_play_corpse_scenes_initial" );
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xe468a062, Offset: 0xa630
// Size: 0x22
function trigger_play_corpse_scenes_sh030( a_ents )
{
    trigger::use( "trigger_play_corpse_scenes_sh030" );
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0x9c73ee32, Offset: 0xa660
// Size: 0x3a
function function_b54fb58e( a_ents )
{
    hidemiscmodels( "quadtank_statue_static2" );
    level clientfield::set( "hide_statue_rubble", 1 );
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xecc4940e, Offset: 0xa6a8
// Size: 0x42
function function_a5697ed9( a_ents )
{
    wait 0.05;
    showmiscmodels( "quadtank_statue_static2" );
    level clientfield::set( "hide_statue_rubble", 0 );
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0x2cf5d071, Offset: 0xa6f8
// Size: 0xaa
function fade_out_and_end( a_ents )
{
    level waittill( #"level_fade_out" );
    level clientfield::set( "sndIGCsnapshot", 4 );
    level.var_6e1075a2 = 0;
    
    if ( !scene::is_skipping_in_progress() )
    {
        util::screen_fade_out( 0.9, "black", "end_level_fade" );
    }
    
    if ( level.skipto_point !== "dev_qt_plaza_outro" )
    {
        skipto::objective_completed( "quad_tank_plaza" );
        return;
    }
    
    skipto::objective_completed( "dev_qt_plaza_outro" );
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xb56a92f2, Offset: 0xa7b0
// Size: 0x7a
function start_sh020_vtol_flyovers( a_ents )
{
    trigger::use( "vtol_flyover_spawn_sh020" );
    level thread scene::play( "p7_fxanim_cp_ramses_flyover_plaza_cinematic_bundle" );
    level waittill( #"sh020_send_vtol_2" );
    trigger::use( "vtol_flyover_spawn_sh020_part_2" );
    level waittill( #"sh020_send_vtol_3" );
    trigger::use( "vtol_flyover_spawn_sh020_part_3" );
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xcd88546f, Offset: 0xa838
// Size: 0x42
function start_sh030_vtol_flyovers( a_ents )
{
    trigger::use( "vtol_flyover_spawn_sh030" );
    level waittill( #"sh030_send_vtol_2" );
    trigger::use( "vtol_flyover_spawn_sh030_part_2" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xcc0e2945, Offset: 0xa888
// Size: 0x132
function vtol_qt_flyover_spawnfunc()
{
    self endon( #"death" );
    a_e_models = [];
    a_s_structs = struct::get_array( self.target, "targetname" );
    
    foreach ( struct in a_s_structs )
    {
        e_model = spawn( "script_model", struct.origin );
        e_model.angles = struct.angles;
        e_model setmodel( struct.model );
        e_model linkto( self );
        a_e_models[ a_e_models.size ] = e_model;
    }
    
    self waittill( #"reached_end_node" );
    array::run_all( a_e_models, &delete );
    self delete();
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0x85e54a2b, Offset: 0xa9c8
// Size: 0x3a
function adjust_sunshadowsplitdistance( a_ents )
{
    level.sun_shadow_split_distance = 0;
    level.old_sunshadowsplitdistance = level.sun_shadow_split_distance;
    level util::set_sun_shadow_split_distance( 5000 );
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0x4b9ab3f8, Offset: 0xaa10
// Size: 0x2a
function reset_sunshadowsplitdistance( a_ents )
{
    if ( isdefined( level.old_sunshadowsplitdistance ) )
    {
        level util::set_sun_shadow_split_distance( level.old_sunshadowsplitdistance );
    }
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xb3bc550f, Offset: 0xaa48
// Size: 0x42
function sh010_shadow_card_show( a_ents )
{
    e_card = getent( "outro_shot_010_shadow", "targetname" );
    e_card show();
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xccbbc0fc, Offset: 0xaa98
// Size: 0x42
function sh010_shadow_card_hide( a_ents )
{
    e_card = getent( "outro_shot_010_shadow", "targetname" );
    e_card hide();
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xb23f8f01, Offset: 0xaae8
// Size: 0x42
function sh020_shadow_card_show( a_ents )
{
    e_card = getent( "outro_shot_020_shadow", "targetname" );
    e_card show();
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0x3eecfc5e, Offset: 0xab38
// Size: 0x42
function sh020_shadow_card_hide( a_ents )
{
    e_card = getent( "outro_shot_020_shadow", "targetname" );
    e_card hide();
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xd74d0099, Offset: 0xab88
// Size: 0x42
function sh040_shadow_card_show( a_ents )
{
    e_card = getent( "outro_shot_040_shadow", "targetname" );
    e_card show();
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0x9a20627, Offset: 0xabd8
// Size: 0xab
function function_40ffea00( a_ents )
{
    hidemiscmodels( "quadtank_statue_static2" );
    a_e_debris = getentarray( "palace_corner_blocker", "targetname" );
    
    foreach ( e_debris in a_e_debris )
    {
        e_debris delete();
    }
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0x6444759c, Offset: 0xac90
// Size: 0x22
function function_892c9e40( a_ents )
{
    showmiscmodels( "quadtank_statue_static2" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xc97a24f3, Offset: 0xacc0
// Size: 0x22
function third_quadtank_deathfunc()
{
    self waittill( #"death" );
    level flag::set( "third_quadtank_killed" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xca357596, Offset: 0xacf0
// Size: 0x181
function qt3_phalanx()
{
    startposition = struct::get( "qt_plaza_new_bldg_phalanx_start", "targetname" );
    endposition = struct::get( "qt_plaza_new_bldg_phalanx_end", "targetname" );
    var_88fc10b2 = getent( "nrc_phalanx_spawner_cqb", "targetname", 0 );
    var_62f99649 = getent( "nrc_phalanx_spawner_assault", "targetname", 0 );
    phalanx = new robotphalanx();
    [[ phalanx ]]->initialize( "phalanx_column", startposition.origin, endposition.origin, 2, 4, var_88fc10b2, var_62f99649 );
    level.phalanx = phalanx;
    level thread qt3_scatter_phalanx();
    robots = arraycombine( arraycombine( phalanx.tier1robots_, phalanx.tier2robots_, 0, 0 ), phalanx.tier3robots_, 0, 0 );
    ai::waittill_dead( robots, 6 );
    spawn_manager::enable( "sm_nrc_quadtank3_robots" );
    level.phalanx = undefined;
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xbd89a695, Offset: 0xae80
// Size: 0x2a
function qt3_scatter_phalanx()
{
    wait 15;
    
    if ( isdefined( level.phalanx ) )
    {
        level.phalanx robotphalanx::scatterphalanx();
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xf5d51dba, Offset: 0xaeb8
// Size: 0x5a
function plaza_wasps_think()
{
    self endon( #"death" );
    e_wasps_vol = getent( self.target, "targetname" );
    self setgoal( e_wasps_vol, 1 );
    self thread wasp_vo_trigger_watcher();
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x33f3a9bb, Offset: 0xaf20
// Size: 0x33
function wasp_vo_trigger_watcher()
{
    self endon( #"death" );
    trigger::wait_till( "qt_plaza_wasp_vo_trigger", "targetname", self );
    level notify( #"wasp_callout_vo" );
}

// Namespace quad_tank_plaza
// Params 3
// Checksum 0xcb5b1eb5, Offset: 0xaf60
// Size: 0x171
function wave_spawner( n_min_wait, n_max_wait, n_respawn_threshold )
{
    level endon( self.targetname + "_wave_spawner_stop" );
    assert( n_min_wait <= n_max_wait, "<dev string:x28>" );
    assert( n_respawn_threshold <= self.sm_active_count_max, "<dev string:x5a>" );
    level flag::wait_till( "all_players_spawned" );
    
    while ( isdefined( self ) && level.players.size == 1 )
    {
        while ( isdefined( self ) )
        {
            a_active_ai = spawn_manager::get_ai( self.targetname );
            
            if ( isdefined( a_active_ai.size ) && a_active_ai.size < self.sm_active_count_max )
            {
                wait 0.1;
                continue;
            }
            
            spawn_manager::disable( self.targetname );
            break;
        }
        
        while ( isdefined( self ) )
        {
            a_active_ai = spawn_manager::get_ai( self.targetname );
            
            if ( isdefined( a_active_ai.size ) && a_active_ai.size <= n_respawn_threshold )
            {
                wait randomfloatrange( n_min_wait, n_max_wait );
                spawn_manager::enable( self.targetname );
                break;
            }
            
            wait 0.1;
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xe81ece53, Offset: 0xb0e0
// Size: 0x7a
function quadtank_hijacked()
{
    level.player_controlled_quadtank = self;
    spawn_manager::enable( "sm_nrc_berm_rpg", 1 );
    self thread player_controlled_quadtank_deathfunc();
    self.threatbias = 3000;
    level thread theater_fxanim();
    
    if ( self.targetname !== "third_quadtank_ai" )
    {
        objectives::complete( "cp_level_ramses_destroy_quadtank" );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xf62d739, Offset: 0xb168
// Size: 0x1d
function player_controlled_quadtank_deathfunc()
{
    self waittill( #"death" );
    level.player_controlled_quadtank = undefined;
    level.quadtank_owner = undefined;
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x26904589, Offset: 0xb190
// Size: 0x69
function player_hijack_watcher()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"clonedentity", e_clone );
        e_clone setthreatbiasgroup( "PlayerVehicles" );
        
        if ( isdefined( e_clone.archetype ) && e_clone.archetype == "quadtank" )
        {
            level.quadtank_owner = self;
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xe90ac8ec, Offset: 0xb208
// Size: 0x34a
function theater_fxanim()
{
    level endon( #"qt_plaza_outro_igc_started" );
    level.player_controlled_quadtank endon( #"death" );
    
    if ( flag::get( "qt_plaza_theater_destroyed" ) )
    {
        return;
    }
    
    level thread theater_damage_trigger();
    level thread quadtank_fired_watcher();
    level flag::wait_till( "qt_plaza_theater_destroyed" );
    scene::add_scene_func( "p7_fxanim_cp_ramses_cinema_collapse_bundle", &function_c56ab13c, "play" );
    level thread scene::play( "p7_fxanim_cp_ramses_cinema_collapse_bundle" );
    show_destroyed_theater_fx_anim();
    exploder::exploder_stop( "LGT_theater" );
    spawn_manager::disable( "nrc_theater_sm" );
    spawn_manager::disable( "sm_egypt_theater" );
    e_trigger = getent( "trigger_cinema_collapse", "targetname" );
    level thread kill_stuff_theater_fxanim( e_trigger );
    a_nd_cover = getnodearray( "qt_plaza_theater_cover_node", "script_noteworthy" );
    
    foreach ( node in a_nd_cover )
    {
        setenablenode( node, 0 );
    }
    
    a_e_post_collapse = getentarray( "post_collapse_collision", "targetname" );
    
    foreach ( e_clip in a_e_post_collapse )
    {
        e_clip solid();
        e_clip disconnectpaths();
    }
    
    a_e_pre_collapse = getentarray( "pre_collapse_collision", "targetname" );
    
    foreach ( e_clip in a_e_pre_collapse )
    {
        e_clip notsolid();
    }
    
    rumble_and_camshake( "theater_fxanim_org" );
    array::run_all( getentarray( "qt_plaza_theater_ammo", "targetname" ), &delete );
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xc1b7864c, Offset: 0xb560
// Size: 0x52
function function_c56ab13c( a_ents )
{
    e_fx_anim = a_ents[ "cinema_collapse" ];
    e_fx_anim thread left_debris_hit_notetrack();
    e_fx_anim thread right_debris_hit_notetrack();
    e_fx_anim thread center_debris_hit_notetrack();
}

// Namespace quad_tank_plaza
// Params 2
// Checksum 0xcee562b9, Offset: 0xb5c0
// Size: 0x2cb
function kill_stuff_theater_fxanim( e_trigger, b_kill_quadtank )
{
    if ( !isdefined( b_kill_quadtank ) )
    {
        b_kill_quadtank = 0;
    }
    
    a_ai = getaiarray();
    
    foreach ( ai in a_ai )
    {
        if ( isdefined( level.player_controlled_quadtank ) && ai == level.player_controlled_quadtank )
        {
            if ( b_kill_quadtank && ai istouching( e_trigger ) )
            {
                ai dodamage( ai.health, ai.origin );
                continue;
            }
            else
            {
                continue;
            }
        }
        
        if ( isdefined( ai.archetype ) && ai.archetype == "quadtank" )
        {
            if ( b_kill_quadtank && ai istouching( e_trigger ) )
            {
                ai dodamage( ai.health, ai.origin );
                continue;
            }
            else
            {
                continue;
            }
        }
        
        if ( ai istouching( e_trigger ) && !ai util::is_hero() )
        {
            ai kill();
        }
    }
    
    a_spots = skipto::get_spots( "cinema_teleport_outside" );
    
    foreach ( player in level.players )
    {
        if ( player istouching( e_trigger ) )
        {
            if ( isdefined( player.hijacked_vehicle_entity ) && a_spots.size > 0 )
            {
                player thread function_2ea9c430( a_spots[ 0 ] );
                arrayremoveindex( a_spots, 0 );
            }
            else
            {
                player dodamage( player.health, player.origin );
            }
        }
        
        if ( isdefined( player.hijacked_vehicle_entity ) && player.hijacked_vehicle_entity istouching( e_trigger ) )
        {
            player.hijacked_vehicle_entity usevehicle( player, 0 );
        }
    }
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0x7d8985db, Offset: 0xb898
// Size: 0x5a
function function_2ea9c430( s_teleport_spot )
{
    self endon( #"death" );
    self waittill( #"return_to_body" );
    wait 0.05;
    wait 0.05;
    self setorigin( s_teleport_spot.origin );
    self setplayerangles( s_teleport_spot.angles );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xb772b077, Offset: 0xb900
// Size: 0x109
function theater_damage_trigger()
{
    level endon( #"qt_plaza_theater_destroyed" );
    level.player_controlled_quadtank endon( #"death" );
    e_trigger = getent( "trigger_cinema_collapse", "targetname" );
    
    while ( true )
    {
        e_trigger waittill( #"damage", n_damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags );
        
        if ( attacker === level.quadtank_owner )
        {
            if ( type === "MOD_PROJECTILE" || type === "MOD_PROJECTILE_SPLASH" )
            {
                level flag::set( "qt_plaza_theater_destroyed" );
                e_trigger delete();
                break;
            }
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x3282de4d, Offset: 0xba18
// Size: 0x4d
function quadtank_fired_watcher()
{
    level endon( #"qt_plaza_theater_destroyed" );
    level.player_controlled_quadtank endon( #"death" );
    
    while ( true )
    {
        level.player_controlled_quadtank waittill( #"weapon_fired", projectile );
        projectile thread player_controlled_quadtank_fired_projectile();
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xc687f5e2, Offset: 0xba70
// Size: 0x61
function player_controlled_quadtank_fired_projectile()
{
    self endon( #"death" );
    e_trigger = getent( "trigger_cinema_collapse", "targetname" );
    
    while ( true )
    {
        if ( self istouching( e_trigger ) )
        {
            self notify( #"death" );
        }
        
        wait 0.05;
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x8cc29180, Offset: 0xbae0
// Size: 0x62
function left_debris_hit_notetrack()
{
    self waittill( #"left_debris_hits_ground" );
    e_trigger = getent( "theater_fxanim_kill_trigger_left", "targetname" );
    level thread kill_stuff_theater_fxanim( e_trigger, 1 );
    rumble_and_camshake( "theater_fxanim_left_debris" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x3f5ae2f6, Offset: 0xbb50
// Size: 0x62
function right_debris_hit_notetrack()
{
    self waittill( #"right_debris_hits_ground" );
    e_trigger = getent( "theater_fxanim_kill_trigger_right", "targetname" );
    level thread kill_stuff_theater_fxanim( e_trigger, 1 );
    rumble_and_camshake( "theater_fxanim_right_debris" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x43545c17, Offset: 0xbbc0
// Size: 0x62
function center_debris_hit_notetrack()
{
    self waittill( #"center_debris_hits_ground" );
    e_trigger = getent( "theater_fxanim_kill_trigger_center", "targetname" );
    level thread kill_stuff_theater_fxanim( e_trigger, 1 );
    rumble_and_camshake( "theater_fxanim_center_debris" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x60ec888c, Offset: 0xbc30
// Size: 0xff
function test_quadtank_damage_trigger()
{
    level endon( #"qt_plaza_outro_igc_started" );
    
    while ( true )
    {
        e_trigger = getent( "test_quadtank_damage", "targetname" );
        e_trigger waittill( #"trigger", ent );
        
        if ( isdefined( level.quadtank_owner ) && ent == level.quadtank_owner )
        {
            a_e_objs = getentarray( "physics_test_objects", "targetname" );
            
            foreach ( e_obj in a_e_objs )
            {
                e_obj physicslaunch( e_obj.origin, ( 0, 0, 20 ) );
            }
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xdce1457e, Offset: 0xbd38
// Size: 0xbb
function mobile_wall_fxanim()
{
    level thread scene::play( "p7_fxanim_cp_ramses_mobile_wall_explode_bundle" );
    rumble_and_camshake( "mobile_wall_fxanim" );
    a_e_props = getentarray( "mobile_wall_explosion_hidden", "targetname" );
    
    foreach ( e_prop in a_e_props )
    {
        e_prop hide();
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x97233cef, Offset: 0xbe00
// Size: 0x1a
function vtol_igc_hunter_fx_anim()
{
    level clientfield::set( "vtol_igc_fxanim_hunter", 1 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xdd18fb39, Offset: 0xbe28
// Size: 0x1a
function dead_system_fx_anim()
{
    level clientfield::set( "qt_plaza_fxanim_hunters", 1 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xd5cc0d8, Offset: 0xbe50
// Size: 0x1a
function stop_dead_system_fx_anim()
{
    level clientfield::set( "qt_plaza_fxanim_hunters", 0 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x871176c5, Offset: 0xbe78
// Size: 0x5a
function hide_destroyed_theater_fx_anim()
{
    level clientfield::set( "theater_fxanim_swap", 1 );
    array::run_all( getentarray( "destroyed_interior", "targetname" ), &hide );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x597fd08b, Offset: 0xbee0
// Size: 0xe2
function show_destroyed_theater_fx_anim()
{
    level clientfield::set( "theater_fxanim_swap", 0 );
    a_e_models = getentarray( "pristine_interior", "targetname" );
    
    foreach ( e_model in a_e_models )
    {
        e_model hide();
    }
    
    array::run_all( getentarray( "destroyed_interior", "targetname" ), &show );
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0x101440da, Offset: 0xbfd0
// Size: 0x123
function rumble_and_camshake( str_targetname )
{
    s_pos = struct::get( str_targetname, "targetname" );
    
    foreach ( e_player in level.players )
    {
        n_distance_squared = distance2dsquared( s_pos.origin, e_player.origin );
        
        if ( n_distance_squared < 1000000 )
        {
            e_player playrumbleonentity( "tank_damage_heavy_mp" );
            earthquake( 0.65, 0.7, e_player.origin, 128 );
            
            if ( n_distance_squared < 62500 )
            {
                e_player shellshock( "default", 1.5 );
            }
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xae264402, Offset: 0xc100
// Size: 0x5a
function post_vtol_igc_vo()
{
    a_str_lines = [];
    a_str_lines[ 0 ] = "hend_grab_some_cover_go_0";
    a_str_lines[ 1 ] = "hend_get_outta_there_fin_0";
    str_line = array::random( a_str_lines );
    level.ai_hendricks thread dialog::say( str_line );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x86935fcf, Offset: 0xc168
// Size: 0x125
function quadtank1_flavor_vo()
{
    level endon( #"quad_tank_1_destroyed" );
    a_str_hendricks_lines = [];
    a_str_hendricks_lines[ 0 ] = "hend_bring_down_that_son_0";
    a_str_hendricks_lines[ 1 ] = "hend_that_quad_s_armed_wi_0";
    a_str_hendricks_lines[ 2 ] = "hend_quad_s_rockets_are_g_0";
    a_str_kane_lines = [];
    a_str_kane_lines[ 0 ] = "kane_take_out_that_quad_b_0";
    a_str_kane_lines[ 1 ] = "kane_that_quad_s_rockets_0";
    str_last_hendricks_line = undefined;
    str_last_kane_line = undefined;
    
    while ( true )
    {
        self waittill( #"trophy_system_disabled" );
        
        if ( math::cointoss() )
        {
            str_line = pick_new_line( a_str_hendricks_lines, str_last_hendricks_line );
            level.ai_hendricks dialog::say( str_line );
            str_last_hendricks_line = str_line;
        }
        else
        {
            str_line = pick_new_line( a_str_kane_lines, str_last_kane_line );
            level dialog::remote( str_line );
            str_last_kane_line = str_line;
        }
        
        wait randomfloatrange( 45, 60 );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xcb71459c, Offset: 0xc298
// Size: 0x1f9
function amws_callout_vo()
{
    level endon( #"quad_tank_1_destroyed" );
    level waittill( #"amws_callout_vo" );
    a_str_lines = [];
    a_str_lines[ 0 ] = "esl3_amws_incoming_0";
    a_str_lines[ 1 ] = "esl4_amws_inbound_grab_s_0";
    a_str_lines[ 2 ] = "esl1_evasives_amws_inbou_0";
    a_str_lines[ 3 ] = "egy2_spotted_enemy_amw_mo_0";
    a_str_lines[ 4 ] = "esl3_eyes_on_hostile_amw_0";
    str_last_line = undefined;
    
    while ( true )
    {
        do
        {
            wait 0.15;
            var_df8a7392 = spawn_manager::get_ai( "qt1_nrc_amws_sm" );
        }
        while ( var_df8a7392.size < 1 );
        
        a_ai_1 = spawn_manager::get_ai( "sm_egypt_siegebot" );
        a_ai_2 = spawn_manager::get_ai( "sm_egypt_quadtank" );
        a_ai = arraycombine( a_ai_1, a_ai_2, 1, 0 );
        
        if ( a_ai.size > 0 )
        {
            ai_speaker = undefined;
            a_ai = array::randomize( a_ai );
            
            foreach ( ai in a_ai )
            {
                if ( isalive( ai ) && ai.is_talking !== 1 )
                {
                    ai_speaker = ai;
                    break;
                }
            }
            
            if ( isdefined( ai_speaker ) )
            {
                str_line = pick_new_line( a_str_lines, str_last_line );
                ai_speaker dialog::say( str_line );
                str_last_line = str_line;
                wait randomfloatrange( 30, 45 );
            }
            else
            {
                wait 1;
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x8c40f3ef, Offset: 0xc4a0
// Size: 0x321
function raps_callout_vo()
{
    level endon( #"third_quadtank_killed" );
    a_str_lines = [];
    a_str_lines[ 0 ] = "esl1_hostile_raps_moving_0";
    a_str_lines[ 1 ] = "egy2_look_out_raps_inco_0";
    a_str_lines[ 2 ] = "esl3_take_cover_raps_inb_0";
    a_str_lines[ 3 ] = "esl4_hostile_raps_inbound_0";
    a_str_lines[ 4 ] = "esl1_enemy_raps_coming_in_0";
    a_str_lines[ 5 ] = "egy2_hostile_raps_inbound_0";
    a_str_lines[ 6 ] = "esl3_enemy_raps_moving_on_0";
    a_str_lines[ 7 ] = "esl4_hostile_raps_inbound_1";
    a_str_lines[ 8 ] = "esl1_raps_coming_in_find_0";
    a_str_lines[ 9 ] = "egy2_hostile_raps_look_o_0";
    a_str_khalil_lines = [];
    a_str_khalil_lines[ 0 ] = "khal_raps_incoming_0";
    a_str_khalil_lines[ 1 ] = "khal_raps_move_0";
    a_str_khalil_lines[ 2 ] = "khal_find_cover_raps_in_0";
    a_str_khalil_lines[ 3 ] = "khal_look_out_raps_0";
    a_str_khalil_lines[ 4 ] = "khal_enemy_raps_inbound_0";
    a_str_khalil_lines[ 5 ] = "khal_heads_up_enemy_rap_0";
    a_str_khalil_lines[ 6 ] = "khal_hostile_raps_inbound_0";
    a_str_khalil_lines[ 7 ] = "khal_enemy_raps_0";
    a_str_khalil_lines[ 8 ] = "khal_raps_moving_in_0";
    a_str_khalil_lines[ 9 ] = "khal_incoming_raps_0";
    str_last_line = undefined;
    str_last_khalil_line = undefined;
    level waittill( #"raps_callout_vo" );
    
    while ( true )
    {
        if ( math::cointoss() )
        {
            str_line = pick_new_line( a_str_khalil_lines, str_last_khalil_line );
            level.ai_khalil dialog::say( str_line );
            str_last_khalil_line = str_line;
            wait randomfloatrange( 30, 45 );
            continue;
        }
        
        do
        {
            wait 0.15;
            var_6ee22718 = spawner::get_ai_group_sentient_count( "nrc_raps" );
        }
        while ( var_6ee22718 < 1 );
        
        a_ai_1 = spawn_manager::get_ai( "sm_egypt_siegebot" );
        a_ai_2 = spawn_manager::get_ai( "sm_egypt_quadtank" );
        a_ai = arraycombine( a_ai_1, a_ai_2, 1, 0 );
        
        if ( a_ai.size > 0 )
        {
            ai_speaker = undefined;
            a_ai = array::randomize( a_ai );
            
            foreach ( ai in a_ai )
            {
                if ( isalive( ai ) && ai.is_talking !== 1 )
                {
                    ai_speaker = ai;
                    break;
                }
            }
            
            if ( isdefined( ai_speaker ) )
            {
                str_line = pick_new_line( a_str_lines, str_last_line );
                ai_speaker dialog::say( str_line );
                str_last_line = str_line;
                wait randomfloatrange( 30, 45 );
            }
            else
            {
                wait 1;
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x8ab1b8a0, Offset: 0xc7d0
// Size: 0x17b
function quadtank_flavor_vo()
{
    level endon( #"quad_tank_2_destroyed" );
    level endon( #"demo_player_controlled_quadtank" );
    level endon( #"third_quadtank_killed" );
    a_str_hendricks_lines = [];
    a_str_hendricks_lines[ 0 ] = "hend_focus_fire_on_that_a_0";
    a_str_hendricks_lines[ 1 ] = "hend_finally_a_fair_fight_0";
    a_str_hendricks_lines[ 2 ] = "hend_we_gotta_bring_down_0";
    a_str_hendricks_lines[ 3 ] = "hend_bring_down_that_son_0";
    a_str_hendricks_lines[ 4 ] = "hend_that_quad_s_armed_wi_0";
    a_str_hendricks_lines[ 5 ] = "hend_quad_s_rockets_are_g_0";
    a_str_kane_lines = [];
    a_str_kane_lines[ 0 ] = "kane_focus_fire_on_that_a_0";
    a_str_kane_lines[ 1 ] = "kane_take_down_that_artil_0";
    a_str_kane_lines[ 2 ] = "kane_you_gotta_bring_down_0";
    a_str_kane_lines[ 3 ] = "kane_focus_weapon_fire_on_0";
    a_str_kane_lines[ 4 ] = "kane_take_out_that_quad_b_0";
    a_str_kane_lines[ 5 ] = "kane_that_quad_s_rockets_0";
    str_last_hendricks_line = undefined;
    
    for ( str_last_kane_line = undefined; true ; str_last_kane_line = str_line )
    {
        wait randomfloatrange( 60, 90 );
        
        if ( math::cointoss() )
        {
            str_line = pick_new_line( a_str_hendricks_lines, str_last_hendricks_line );
            level.ai_hendricks dialog::say( str_line );
            str_last_hendricks_line = str_line;
            continue;
        }
        
        str_line = pick_new_line( a_str_kane_lines, str_last_kane_line );
        level dialog::remote( str_line );
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xe150cbb2, Offset: 0xc958
// Size: 0x1e1
function mlrs_defeated_move_up_vo()
{
    a_str_lines = [];
    a_str_lines[ 0 ] = "esl1_go_push_them_back_0";
    a_str_lines[ 1 ] = "egy2_move_up_move_up_0";
    a_str_lines[ 2 ] = "esl3_move_up_take_new_po_0";
    a_str_lines[ 3 ] = "esl4_come_on_push_forwar_0";
    a_str_lines[ 4 ] = "esl1_let_s_move_let_s_mo_0";
    str_last_line = undefined;
    var_522ce6c6 = 0;
    wait 6;
    
    while ( var_522ce6c6 < 2 )
    {
        a_ai_1 = spawn_manager::get_ai( "sm_egypt_siegebot" );
        a_ai_2 = spawn_manager::get_ai( "sm_egypt_quadtank" );
        a_ai = arraycombine( a_ai_1, a_ai_2, 1, 0 );
        
        if ( a_ai.size > 0 )
        {
            ai_speaker = undefined;
            a_ai = array::randomize( a_ai );
            
            foreach ( ai in a_ai )
            {
                if ( isalive( ai ) && ai.is_talking !== 1 )
                {
                    ai_speaker = ai;
                    break;
                }
            }
            
            if ( isdefined( ai_speaker ) )
            {
                str_line = pick_new_line( a_str_lines, str_last_line );
                ai_speaker dialog::say( str_line );
                var_522ce6c6++;
                str_last_line = str_line;
                wait randomfloatrange( 1.5, 2.5 );
            }
            else
            {
                wait 1;
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xc38ab4c2, Offset: 0xcb48
// Size: 0x1b9
function rpg_palace_callout_vo()
{
    level endon( #"third_quadtank_killed" );
    a_str_lines = [];
    a_str_lines[ 0 ] = "esl3_rpg_top_of_the_pala_0";
    a_str_lines[ 1 ] = "esl4_rpg_spotted_top_flo_0";
    str_last_line = undefined;
    var_522ce6c6 = 0;
    level waittill( #"rpg_palace_callout_vo" );
    
    while ( var_522ce6c6 < 2 )
    {
        a_ai_1 = spawn_manager::get_ai( "sm_egypt_siegebot" );
        a_ai_2 = spawn_manager::get_ai( "sm_egypt_quadtank" );
        a_ai = arraycombine( a_ai_1, a_ai_2, 1, 0 );
        
        if ( a_ai.size > 0 )
        {
            ai_speaker = undefined;
            a_ai = array::randomize( a_ai );
            
            foreach ( ai in a_ai )
            {
                if ( isalive( ai ) && ai.is_talking !== 1 )
                {
                    ai_speaker = ai;
                    break;
                }
            }
            
            if ( isdefined( ai_speaker ) )
            {
                str_line = pick_new_line( a_str_lines, str_last_line );
                ai_speaker dialog::say( str_line );
                var_522ce6c6++;
                str_last_line = str_line;
                wait randomfloatrange( 60, 120 );
            }
            else
            {
                wait 1;
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xd7838e61, Offset: 0xcd10
// Size: 0x1b9
function rpg_berm_callout_vo()
{
    level endon( #"third_quadtank_killed" );
    a_str_lines = [];
    a_str_lines[ 0 ] = "esl1_rpg_top_of_the_berm_0";
    a_str_lines[ 1 ] = "egy2_look_out_rpg_on_the_0";
    str_last_line = undefined;
    var_522ce6c6 = 0;
    
    while ( var_522ce6c6 < 2 )
    {
        level waittill( #"rpg_berm_callout_vo" );
        a_ai_1 = spawn_manager::get_ai( "sm_egypt_siegebot" );
        a_ai_2 = spawn_manager::get_ai( "sm_egypt_quadtank" );
        a_ai = arraycombine( a_ai_1, a_ai_2, 1, 0 );
        
        if ( a_ai.size > 0 )
        {
            ai_speaker = undefined;
            a_ai = array::randomize( a_ai );
            
            foreach ( ai in a_ai )
            {
                if ( isalive( ai ) && ai.is_talking !== 1 )
                {
                    ai_speaker = ai;
                    break;
                }
            }
            
            if ( isdefined( ai_speaker ) )
            {
                str_line = pick_new_line( a_str_lines, str_last_line );
                ai_speaker dialog::say( str_line );
                var_522ce6c6++;
                str_last_line = str_line;
                wait randomfloatrange( 60, 120 );
            }
            else
            {
                wait 1;
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x90092753, Offset: 0xced8
// Size: 0x9a
function artillery_quadtank_intro_vo()
{
    level waittill( #"artillery_qt_intro_hendricks_vo_0" );
    level thread namespace_a6a248fc::function_19e0cb0e();
    level thread namespace_a6a248fc::function_98c9ec2a();
    level.ai_hendricks thread dialog::say( "hend_look_out_we_got_inc_0" );
    level waittill( #"artillery_qt_intro_hendricks_vo_1" );
    level.ai_hendricks thread dialog::say( "hend_vtol_down_don_t_ha_0" );
    level waittill( #"artillery_qt_intro_hendricks_vo_2" );
    level.ai_hendricks dialog::say( "hend_shit_quad_is_functi_0" );
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xfda7a802, Offset: 0xcf80
// Size: 0x181
function egyptian_statue_fall_vo( a_ai )
{
    a_str_lines = [];
    a_str_lines[ 0 ] = "esl1_get_outta_there_0";
    a_str_lines[ 1 ] = "egy2_move_move_move_1";
    a_str_lines[ 2 ] = "esl3_scatter_get_outta_t_0";
    a_str_lines[ 3 ] = "esl4_incoming_move_0";
    a_str_lines[ 4 ] = "esl3_scatter_scatter_in_0";
    var_522ce6c6 = 0;
    str_last_line = undefined;
    
    while ( var_522ce6c6 < 2 )
    {
        if ( a_ai.size > 0 )
        {
            ai_speaker = undefined;
            a_ai = array::randomize( a_ai );
            
            foreach ( ai in a_ai )
            {
                if ( isalive( ai ) && ai.is_talking !== 1 )
                {
                    ai_speaker = ai;
                    break;
                }
            }
            
            if ( isdefined( ai_speaker ) )
            {
                str_line = pick_new_line( a_str_lines, str_last_line );
                ai_speaker dialog::say( str_line );
                var_522ce6c6++;
                str_last_line = str_line;
                wait randomfloatrange( 0.5, 1.5 );
            }
            else
            {
                wait 1;
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xf16c0a20, Offset: 0xd110
// Size: 0x2a
function statue_fall_vo()
{
    level.ai_hendricks thread dialog::say( "hend_statue_s_coming_down_0", 1 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xa0ab52b8, Offset: 0xd148
// Size: 0x1c9
function robot_callout_vo()
{
    level endon( #"third_quadtank_killed" );
    a_str_lines = [];
    a_str_lines[ 0 ] = "esl4_eyes_on_hostile_gis_0";
    a_str_lines[ 1 ] = "esl3_enemy_grunts_spotted_0";
    a_str_lines[ 2 ] = "egy2_hostile_grunts_movin_0";
    a_str_lines[ 3 ] = "esl1_grunts_spotted_0";
    a_str_lines[ 4 ] = "esl4_i_got_sights_on_host_0";
    str_last_line = undefined;
    level waittill( #"robot_callout_vo" );
    
    while ( true )
    {
        a_ai_1 = spawn_manager::get_ai( "sm_egypt_siegebot" );
        a_ai_2 = spawn_manager::get_ai( "sm_egypt_quadtank" );
        a_ai = arraycombine( a_ai_1, a_ai_2, 1, 0 );
        
        if ( a_ai.size > 0 )
        {
            ai_speaker = undefined;
            a_ai = array::randomize( a_ai );
            
            foreach ( ai in a_ai )
            {
                if ( isalive( ai ) && ai.is_talking !== 1 )
                {
                    ai_speaker = ai;
                    break;
                }
            }
            
            if ( isdefined( ai_speaker ) )
            {
                str_line = pick_new_line( a_str_lines, str_last_line );
                ai_speaker dialog::say( str_line );
                str_last_line = str_line;
                wait randomfloatrange( 60, 120 );
            }
            else
            {
                wait 1;
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x974fa168, Offset: 0xd320
// Size: 0x2a
function technical_truck_callout_vo()
{
    level.ai_hendricks thread dialog::say( "esl1_technical_spotted_t_0", 1 );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0x9f1630f4, Offset: 0xd358
// Size: 0x18b
function theater_breach_vo()
{
    wait 2;
    a_str_lines = [];
    a_str_lines[ 0 ] = "esl3_spotted_hostiles_in_0";
    a_str_lines[ 1 ] = "esl4_hostile_forces_insid_0";
    a_str_lines[ 2 ] = "esl1_they_re_coming_throu_0";
    
    while ( true )
    {
        a_ai_1 = spawn_manager::get_ai( "sm_egypt_siegebot" );
        a_ai_2 = spawn_manager::get_ai( "sm_egypt_quadtank" );
        a_ai = arraycombine( a_ai_1, a_ai_2, 1, 0 );
        
        if ( a_ai.size > 0 )
        {
            ai_speaker = undefined;
            a_ai = array::randomize( a_ai );
            
            foreach ( ai in a_ai )
            {
                if ( isalive( ai ) && ai.is_talking !== 1 )
                {
                    ai_speaker = ai;
                    break;
                }
            }
            
            if ( isdefined( ai_speaker ) )
            {
                str_line = array::random( a_str_lines );
                ai_speaker dialog::say( str_line );
                return;
            }
            else
            {
                wait 1;
            }
            
            continue;
        }
        
        wait 1;
    }
}

// Namespace quad_tank_plaza
// Params 1
// Checksum 0xe41bd8f, Offset: 0xd4f0
// Size: 0x241
function third_quadtank_spawn_vo( a_ents )
{
    level endon( #"third_quadtank_killed" );
    var_ce5b55e5 = level.third_quadtank.origin;
    a_ai = getaiteamarray( "allies" );
    a_ai = arraysortclosest( a_ai, var_ce5b55e5 );
    ai_speaker = undefined;
    
    foreach ( ai in a_ai )
    {
        if ( !ai util::is_hero() && isalive( ai ) && ai.is_talking !== 1 )
        {
            ai_speaker = ai;
            break;
        }
    }
    
    wait 5;
    a_str_lines = [];
    a_str_lines[ 0 ] = "esl1_grunt_company_comin_0";
    a_str_lines[ 1 ] = "egy2_eyes_on_hostile_grun_0";
    a_str_lines[ 2 ] = "esl3_spotted_hostile_grun_0";
    a_str_lines[ 3 ] = "esl4_grab_some_cover_hos_0";
    a_str_lines[ 4 ] = "esl3_gi_company_spotted_a_0";
    
    while ( true )
    {
        a_ai = getaiteamarray( "allies" );
        a_ai = arraysortclosest( a_ai, var_ce5b55e5 );
        ai = undefined;
        
        for ( i = 0; i < a_ai.size ; i++ )
        {
            ai = a_ai[ i ];
            
            if ( !ai util::is_hero() && isalive( ai ) && !( isdefined( ai.is_talking ) && ai.is_talking ) )
            {
                break;
            }
        }
        
        if ( isdefined( ai ) )
        {
            str_line = array::random( a_str_lines );
            ai dialog::say( str_line );
            return;
        }
        
        wait 0.25;
    }
}

// Namespace quad_tank_plaza
// Params 2
// Checksum 0x1dda9a98, Offset: 0xd740
// Size: 0x5d
function pick_new_line( a_str_lines, str_last_line )
{
    a_str_lines = array::randomize( a_str_lines );
    
    for ( i = 0; i < a_str_lines.size ; i++ )
    {
        str_new_line = a_str_lines[ i ];
        
        if ( str_new_line !== str_last_line )
        {
            return str_new_line;
        }
    }
    
    return str_last_line;
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xeb5548ef, Offset: 0xd7a8
// Size: 0x37b
function quad_tank_plaza_spawn_manager_cleanup()
{
    spawn_manager::kill( "sm_egypt_plaza_wall" );
    spawn_manager::kill( "sm_egypt_palace_window" );
    spawn_manager::kill( "sm_egypt_quadtank" );
    spawn_manager::kill( "sm_egypt_siegebot" );
    spawn_manager::kill( "sm_nrc_siegebot" );
    spawn_manager::kill( "sm_nrc_quadtank" );
    spawn_manager::kill( "sm_nrc_depth" );
    spawn_manager::kill( "sm_nrc_berm_rpg" );
    spawn_manager::kill( "qt1_nrc_wasp_sm" );
    spawn_manager::kill( "sm_nrc_govt_building_rpg" );
    spawn_manager::kill( "qt1_nrc_amws_sm" );
    spawn_manager::kill( "qt1_nrc_raps_sm" );
    spawn_manager::kill( "qt2_nrc_wasp_sm" );
    spawn_manager::kill( "sm_egypt_theater" );
    spawn_manager::kill( "qt2_nrc_wasp2_berm_sm" );
    spawn_manager::kill( "qt2_nrc_wasp2_palace_sm" );
    spawn_manager::kill( "qt2_nrc_robot_rushers_sm" );
    spawn_manager::kill( "qt2_nrc_raps_sm" );
    spawn_manager::kill( "sm_nrc_qt2_depth" );
    spawn_manager::kill( "nrc_mobile_wall_sm" );
    spawn_manager::kill( "demo_qt2_wasp_sm" );
    spawn_manager::kill( "qt_plaza_controllable_qt_raps_sm" );
    spawn_manager::kill( "nrc_theater_sm" );
    spawn_manager::kill( "sm_nrc_quadtank3_robots" );
    a_ai = getaiarray();
    
    foreach ( ai in a_ai )
    {
        if ( !ai util::is_hero() )
        {
            if ( ai !== level.player_controlled_quadtank && ai.vehicletype !== "veh_bo3_civ_truck_pickup_tech_nrc_nolights" )
            {
                ai delete();
            }
        }
    }
    
    a_corpses = getcorpsearray();
    
    foreach ( corpse in a_corpses )
    {
        if ( corpse.vehicletype !== "veh_bo3_civ_truck_pickup_tech_nrc_nolights" )
        {
            corpse delete();
        }
    }
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xf785e9e7, Offset: 0xdb30
// Size: 0xea
function statue_fall_test()
{
    level thread scene::init( "p7_fxanim_cp_ramses_quadtank_statue_bundle" );
    level thread scene::init( "p7_fxanim_cp_ramses_mobile_wall_explode_bundle" );
    level flag::wait_till( "first_player_spawned" );
    wait 3;
    iprintlnbold( "Statue about to fall" );
    vh_intro_mlrs_quadtank = spawner::simple_spawn_single( "demo_intro_mlrs_quadtank" );
    vh_intro_mlrs_quadtank util::magic_bullet_shield();
    vh_intro_mlrs_quadtank vehicle_ai::start_scripted( 1 );
    wait 1;
    level thread scene::play( "cin_ram_07_04_plaza_vign_quaddefeated" );
    level thread scene::play( "p7_fxanim_cp_ramses_quadtank_statue_bundle" );
    wait 8;
    level thread scene::play( "p7_fxanim_cp_ramses_mobile_wall_explode_bundle" );
}

// Namespace quad_tank_plaza
// Params 0
// Checksum 0xc8da323e, Offset: 0xdc28
// Size: 0x2a
function dev_hacked_quadtank_skipto()
{
    ai_artillery_quadtank = spawn_artillery_quadtank( 1 );
    handle_player_controllable_quadtank( ai_artillery_quadtank );
}

