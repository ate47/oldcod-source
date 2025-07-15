#using scripts/codescripts/struct;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_lotus2_sound;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/lotus_security_station;
#using scripts/cp/lotus_util;
#using scripts/shared/ai/archetype_robot;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace lotus_sky_bridge;

// Namespace lotus_sky_bridge
// Params 2
// Checksum 0xa28c2ccd, Offset: 0x2080
// Size: 0x43a
function industrial_zone_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_hendricks.allowbattlechatter[ "bc" ] = 0;
        trigger::use( "body_fall_trigger" );
        lotus_util::spawn_funcs_generic_rogue_control();
        skipto::teleport_ai( str_objective );
        load::function_a2995f22();
        level lotus_util::function_484bc3aa( 1 );
    }
    
    callback::remove_on_spawned( &lotus_util::function_6edd9874 );
    callback::remove_on_spawned( &lotus_util::function_5157e72f );
    exploder::kill_exploder( "fx_interior_snow_1" );
    level.ai_hendricks clientfield::set( "hendricks_frost_breath", 0 );
    getent( "trig_oob_industrial_zone", "targetname" ) triggerenable( 0 );
    level.ai_hendricks.goalradius = -128;
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
    level flag::init( "wallsmash_done" );
    level thread function_9d01fecc();
    spawner::add_spawn_function_group( "industrial_nrc", "script_noteworthy", &industrial_fight );
    exploder::exploder( "fx_vista_read2a" );
    lotus_util::function_176c92fd();
    set_skybridge_destruction_state( "skybridge_event_10-39_broken", "hide" );
    set_skybridge_destruction_state( "skybridge_event_10-41_broken", "hide" );
    set_skybridge_destruction_state( "skybridge_event_10-42_broken", "hide" );
    a_skybridge_chunks = getentarray( "skybridge_event_10-41", "targetname" );
    
    foreach ( e_chunk in a_skybridge_chunks )
    {
        e_chunk.origin += ( 9206, 0, 0 );
    }
    
    wait 0.1;
    custom_traversals_on_off( "skybridge00a_custom_traversal", 1 );
    custom_traversals_on_off( "skybridge01_custom_traversal", 1 );
    custom_traversals_on_off( "skybridge01a_custom_traversal", 1 );
    custom_traversals_on_off( "skybridge02_custom_traversal", 1 );
    level thread flyby_vtols();
    level thread function_fbd7205();
    level thread function_8175b0d4( 1 );
    level thread function_fbaeb3a1();
    level thread function_9f38eee8();
    wait 1;
    level thread function_4354b307();
    level flag::wait_till( "cin_hendricks_observes_go" );
    level thread function_b5b850b7();
    trigger::wait_till( "industrial_zone_complete" );
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    skipto::objective_completed( "industrial_zone" );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x9dcae598, Offset: 0x24c8
// Size: 0xf2
function function_9d01fecc()
{
    battlechatter::function_d9f49fba( 0 );
    flag::wait_till( "flag_wallsmash" );
    level.ai_hendricks dialog::say( "hend_kane_we_need_a_way_0" );
    level dialog::say( "kane_that_door_should_get_0", 1 );
    level thread lotus2_sound::function_208b0a38();
    level notify( #"hash_49e3585a" );
    level waittill( #"hash_bf54b99c" );
    level.ai_hendricks dialog::say( "hend_that_ll_work_too_l_0", 0.5 );
    wait 2;
    level flag::wait_till( "init_industrial_robot_attack_01" );
    level dialog::remote( "kane_you_better_hustle_0" );
    wait 3;
    battlechatter::function_d9f49fba( 1 );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x67fc4aa2, Offset: 0x25c8
// Size: 0x62
function function_b5b850b7()
{
    flag::wait_till( "flag_industrial_spawn_2" );
    level thread lotus_util::function_99514074( "industrial_robo_entrance_jumpdown01", "industrial_robo_entrant01" );
    level thread lotus_util::function_99514074( "industrial_robo_entrance_jumpdown02", "industrial_robo_entrant02", "flag_grand_entrance_02" );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x1642aa46, Offset: 0x2638
// Size: 0x4a
function function_4354b307()
{
    objectives::breadcrumb( "industrial_breadcrumb01" );
    flag::wait_till( "wallsmash_done" );
    objectives::breadcrumb( "industrial_breadcrumb03" );
}

// Namespace lotus_sky_bridge
// Params 4
// Checksum 0xd2809e6e, Offset: 0x2690
// Size: 0xa2
function industrial_zone_done( str_objective, b_starting, b_direct, player )
{
    level thread scene::init( "skybridge_2_falling_shop", "targetname" );
    level thread scene::init( "skybridge_2_falling_shop_2", "targetname" );
    level flag::init( "khalil_convo_done" );
    level flag::init( "skybridge_final_vo_can_play" );
    battlechatter::function_d9f49fba( 0 );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x48ab0521, Offset: 0x2740
// Size: 0x2da
function function_9f38eee8()
{
    var_a112a6b7 = getent( "industrial_wallbreak_decal", "targetname" );
    
    if ( isdefined( var_a112a6b7 ) )
    {
        var_a112a6b7 hide();
    }
    
    level scene::init( "cin_lot_09_02_pursuit_vign_wallsmash" );
    level waittill( #"hash_49e3585a" );
    level flag::wait_till( "flag_wallsmash" );
    
    if ( level flag::exists( "hendricks_stomps_cin_done" ) )
    {
        level flag::wait_till( "hendricks_stomps_cin_done" );
    }
    
    var_7e20817e = getent( "industrial_wallbreak", "targetname" );
    
    if ( isdefined( var_7e20817e ) )
    {
        var_7e20817e hide();
        var_7e20817e delete();
    }
    
    if ( isdefined( var_a112a6b7 ) )
    {
        var_a112a6b7 show();
    }
    
    var_8215eb73 = getent( "wallsmash_playerclip", "targetname" );
    var_8215eb73 delete();
    level thread scene::play( "cin_lot_09_02_pursuit_vign_wallsmash" );
    wait 0.5;
    level notify( #"hash_bf54b99c" );
    var_258dd90b = struct::get( "hendricks_stomps_cin", "targetname" );
    
    if ( var_258dd90b scene::is_playing( var_258dd90b.scriptbundlename ) )
    {
        level.ai_hendricks stopanimscripted( 0.3 );
    }
    
    ai_robot = getent( "cin_lot_09_02_pursuit_vign_wallsmash_robot_ai", "targetname" );
    
    if ( isalive( ai_robot ) )
    {
        level.ai_hendricks ai::shoot_at_target( "normal", ai_robot, undefined, 0.75 );
    }
    
    level flag::set( "wallsmash_done" );
    spawner::waittill_ai_group_cleared( "wallsmash_robot" );
    trigger::use( "trig_hendricks_through_hole", "targetname" );
    flag::wait_till( "flag_industrial_spawn_2" );
    mdl_clip = getent( "industrial_jump_robot_clip", "targetname" );
    
    if ( isdefined( mdl_clip ) )
    {
        mdl_clip delete();
    }
}

// Namespace lotus_sky_bridge
// Params 2
// Checksum 0x43ec6d4d, Offset: 0x2a28
// Size: 0x17a
function industrial_fight( n_level, str_volume )
{
    self endon( #"death" );
    
    if ( self.archetype == "robot" )
    {
        self ai::set_behavior_attribute( "rogue_control", "forced_level_" + n_level );
        
        if ( isdefined( str_volume ) )
        {
            e_goalvolume = getent( str_volume + "_1", "targetname" );
            self setgoal( e_goalvolume );
        }
    }
    else
    {
        self ai::set_behavior_attribute( "can_initiateaivsaimelee", 0 );
        self ai::set_behavior_attribute( "can_melee", 0 );
    }
    
    self.overrideactordamage = &industrial_nrc_damage_override;
    trigger::wait_till( "trig_industrial_end_fight" );
    self.b_end_fight = 1;
    
    if ( isdefined( str_volume ) )
    {
        trigger::wait_till( "trig_industrial_spawn_1" );
        e_goalvolume = getent( str_volume + "_2", "targetname" );
        self setgoal( e_goalvolume );
        flag::wait_till( "flag_industrial_spawn_2" );
        self cleargoalvolume();
    }
}

// Namespace lotus_sky_bridge
// Params 12
// Checksum 0x63fac582, Offset: 0x2bb0
// Size: 0xab
function industrial_nrc_damage_override( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name )
{
    if ( self.b_end_fight === 1 && self.archetype == "human" )
    {
        n_damage = self.health;
    }
    else if ( !isplayer( e_inflictor ) )
    {
        n_damage = 0;
    }
    
    return n_damage;
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x34a28ac0, Offset: 0x2c68
// Size: 0x2aa
function function_fbaeb3a1()
{
    spawner::add_spawn_function_group( "industrial_robot_attack_02_robot", "targetname", &ai::set_behavior_attribute, "rogue_control", "level_2" );
    flag::wait_till( "cin_hendricks_observes_go" );
    function_91311306();
    
    if ( !level flag::get( "flag_wallsmash" ) )
    {
        flag::init( "hendricks_stomps_cin_done" );
        level lotus_util::function_283fcbc5( "hendricks_stomps_cin", "hendricks_stomps_cin_robot", "at_industrial_outside", 0, 1 );
        flag::set( "hendricks_stomps_cin_done" );
    }
    
    scene::add_scene_func( "cin_gen_melee_robot_nogun_overhead_throw_init", &function_faa38388, "init" );
    level thread lotus_util::function_df89b05b( "industrial_robot_attack_01", "forced_level_2", "do_industrial_robot_attack_01", undefined, "industrial_zone_done" );
    flag::wait_till( "flag_industrial_rvh" );
    level thread lotus_util::function_df89b05b( "industrial_rvh_choke_throw", "forced_level_1", "industrial_rvh_choke_throw_go", 0.1, "industrial_zone_done" );
    level thread lotus_util::function_df89b05b( "industrial_robot_attack_02", "forced_level_1", "industrial_robot_attack_02_go", 0.1, "industrial_zone_done" );
    scene::remove_scene_func( "cin_gen_melee_robot_nogun_overhead_throw_init", &function_faa38388, "init" );
    level thread lotus_util::function_df89b05b( "industrial_robot_attack_03", "forced_level_1", "industrial_robot_attack_03_go", 0, "industrial_zone_done" );
    level thread lotus_util::function_df89b05b( "industrial_robot_attack_03a", "forced_level_1", "industrial_robot_attack_03_go", 0.5, "industrial_zone_done" );
    level thread lotus_util::function_df89b05b( "industrial_robot_attack_03b", "forced_level_1", "industrial_robot_attack_03_go", 1, "industrial_zone_done" );
    scene::init( "cin_lot_10_01_skybridge_1st_init_shop" );
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0xd6aaa488, Offset: 0x2f20
// Size: 0x5a
function function_faa38388( a_ents )
{
    a_ents[ "nrc_soldier_thrown" ] endon( #"death" );
    level waittill( #"hash_9aa959d8" );
    a_ents[ "nrc_soldier_thrown" ] stopanimscripted();
    a_ents[ "nrc_soldier_thrown" ] startragdoll();
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x9eefc634, Offset: 0x2f88
// Size: 0x112
function function_91311306()
{
    level flag::wait_till( "all_players_spawned" );
    
    if ( !level flag::get( "flag_wallsmash" ) )
    {
        s_scene = struct::get( "cin_hendricks_observes", "targetname" );
        s_scene scene::init( level.ai_hendricks );
        s_scene thread scene::play( level.ai_hendricks );
        util::waittill_any( "flag_wallsmash", "cin_lot_09_02_pursuit_vign_observation_done" );
        s_scene scene::stop();
        level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
    }
    
    var_b81735e0 = getent( "hendricks_dont_fall_clip", "targetname" );
    var_b81735e0 delete();
}

// Namespace lotus_sky_bridge
// Params 2
// Checksum 0x542b3a8, Offset: 0x30a8
// Size: 0x582
function sky_bridge1_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_hendricks.allowbattlechatter[ "bc" ] = 0;
        skipto::teleport_ai( str_objective );
        scene::init( "cin_lot_10_01_skybridge_1st_init_shop" );
        lotus_util::spawn_funcs_generic_rogue_control();
        level util::set_streamer_hint( 3, 1 );
        load::function_a2995f22();
        lotus_util::function_176c92fd();
        exploder::exploder( "fx_vista_read2a" );
    }
    else
    {
        level thread util::set_streamer_hint( 3, 1 );
        lotus_util::corpse_cleanup();
    }
    
    foreach ( player in level.players )
    {
        player lotus_util::function_f21ea22f();
    }
    
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 0 );
    level.ai_hendricks ai::set_behavior_attribute( "move_mode", "rambo" );
    spawner::add_spawn_function_group( "wwz_vtol_block_rushing_players", "targetname", &function_15bb85bc );
    level scene::init( "p7_fxanim_cp_lotus_mobile_shop_sky01_bundle" );
    level scene::init( "p7_fxanim_cp_lotus_mobile_shop_sky02_bundle" );
    level scene::init( "p7_fxanim_cp_lotus_mobile_shop_sky03_break_bundle" );
    level scene::init( "p7_fxanim_cp_lotus_skybridge_hunter_crash_01_bundle" );
    level scene::init( "p7_fxanim_cp_lotus_skybridge_hunter_crash_02_bundle" );
    level scene::init( "p7_fxanim_cp_lotus_skybridge_hunter_crash_03_bundle" );
    level scene::init( "p7_fxanim_cp_lotus_skybridge_hunter_crash_04_bundle" );
    level thread function_fbd7205();
    set_skybridge_destruction_state( "skybridge_event_10-39_broken", "hide" );
    set_skybridge_destruction_state( "skybridge_event_10-41_broken", "hide" );
    set_skybridge_destruction_state( "skybridge_event_10-42_broken", "hide" );
    custom_traversals_on_off( "sb_1_broken_start", 1 );
    level thread function_5fcdf0e7( 1 );
    level thread function_c23650f9();
    debris_push_animation( b_starting );
    level flag::wait_till( "skybridge_debris_cleared" );
    savegame::function_fb150717();
    level thread wwz_vtol();
    level lotus_util::function_484bc3aa( 0 );
    skybridge_sand_fx( 1 );
    lotus_util::function_f80cafbd( 1 );
    level.var_941f173a = 0;
    
    foreach ( player in level.players )
    {
        player thread function_fdb69d4a();
    }
    
    level thread function_8175b0d4( 7 );
    level thread function_5fcdf0e7( 2 );
    level thread function_5fcdf0e7( 3, 1, &function_236dcbd8 );
    level thread function_5fcdf0e7( 4 );
    trigger::use( "hendricks_color_sky_bridge1_start" );
    level thread function_8b154406( b_starting, "sky_bridge1_obj_breadcrumb" );
    level thread function_54838261();
    level thread function_a070d03f();
    level thread function_fd34fb22();
    trigger::wait_till( "trig_mobile_shop_sky01" );
    level thread sky_bridge_climbers();
    level thread sky_bridge_bottom_rvh_battle();
    level thread scene::play( "p7_fxanim_cp_lotus_mobile_shop_sky01_bundle" );
    level waittill( #"mobile_shop_kill" );
    trigger::use( "hendricks_color_sky_bridge1_post_shop_fall" );
    function_2ecaeb37();
    level thread function_70f27cf6();
    trigger::wait_till( "sky_bridge1_complete" );
    skipto::objective_completed( "sky_bridge1" );
}

// Namespace lotus_sky_bridge
// Params 4
// Checksum 0xec458968, Offset: 0x3638
// Size: 0xca
function sky_bridge1_done( str_objective, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        objectives::complete( "cp_level_lotus_go_to_skybridge" );
        objectives::complete( "cp_level_lotus_clear_debris" );
        objectives::set( "cp_level_lotus_go_to_tower_two" );
        level flag::set( "khalil_convo_done" );
        lotus_util::function_3b6587d6( 0, "lotus2_tower1_debris_push_umbra_gate" );
        level scene::skipto_end( "cin_lot_10_01_skybridge_1st_init_shop" );
    }
    
    lotus_util::function_3b6587d6( 0, "lotus2_tower2_umbra_gate" );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xe83db06b, Offset: 0x3710
// Size: 0x16a
function function_2ecaeb37()
{
    a_e_clip = getentarray( "mobile_shop_fall_1_clip", "targetname" );
    v_loc = struct::get( "skybridge_mobile_shop_crash_loc" ).origin;
    
    foreach ( e_clip in a_e_clip )
    {
        e_clip delete();
    }
    
    wait 0.05;
    a_corpses = getcorpsearray();
    
    foreach ( e_corpse in a_corpses )
    {
        if ( distance2d( v_loc, e_corpse.origin ) < -6 )
        {
            e_corpse delete();
        }
    }
    
    physicsjolt( v_loc, -6, 0, ( 0, 0, -1 ) );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xa0eed30c, Offset: 0x3888
// Size: 0x4a
function function_54838261()
{
    level flag::wait_till( "player_at_crash_point" );
    
    if ( !level flag::get( "wwz_vtol_crash_done" ) )
    {
        objectives::hide( "cp_waypoint_breadcrumb" );
    }
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x5dd7bd09, Offset: 0x38e0
// Size: 0x62
function function_231ed907()
{
    if ( isdefined( 15 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 15, "timeout" );
    }
    
    spawner::waittill_ai_group_count( "industrial_zone_robots", 2 );
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0x6f73caa8, Offset: 0x3950
// Size: 0x182
function debris_push_animation( b_starting )
{
    if ( !isdefined( b_starting ) )
    {
        b_starting = 0;
    }
    
    t_debris_push = getent( "trig_debris_push", "targetname" );
    t_debris_push triggerenable( 0 );
    e_carver = getent( "debris_push_carver", "targetname" );
    e_carver connectpaths();
    function_231ed907();
    scene::init( "cin_lot_10_01_skybridge_1st_push", level.ai_hendricks );
    
    if ( b_starting )
    {
        wait 1;
    }
    
    level flag::init( "debris_push_ready" );
    level flag::init( "debris_push_started" );
    level thread function_90b6f882();
    level.ai_hendricks waittill( #"hash_82588407" );
    level flag::set( "debris_push_ready" );
    objectives::complete( "cp_level_lotus_go_to_skybridge" );
    t_debris_push triggerenable( 1 );
    util::init_interactive_gameobject( t_debris_push, &"cp_level_lotus_clear_debris", &"CP_MI_CAIRO_LOTUS_CLEAR", &function_9d1fa3b5 );
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0x99ea5391, Offset: 0x3ae0
// Size: 0x1da
function function_9d1fa3b5( e_player )
{
    self gameobjects::disable_object();
    level flag::set( "debris_push_started" );
    lotus_util::function_3b6587d6( 0, "lotus2_tower1_debris_push_umbra_gate" );
    level thread lotus2_sound::function_1d1fd3af();
    objectives::complete( "cp_level_lotus_clear_debris" );
    objectives::set( "cp_level_lotus_go_to_tower_two" );
    level thread debris_push_sky_bridge_view();
    mdl_clip = getent( "debris_push_clip", "targetname" );
    mdl_clip connectpaths();
    mdl_clip delete();
    scene::add_scene_func( "cin_lot_10_01_skybridge_1st_push", &function_2fc33d6d, "play" );
    scene::play( "cin_lot_10_01_skybridge_1st_push", e_player );
    level flag::set( "skybridge_debris_cleared" );
    level util::teleport_players_igc( "after_debris_push_player_pos" );
    getent( "trig_oob_industrial_zone", "targetname" ) triggerenable( 1 );
    getent( "pursuit_oob", "targetname" ) delete();
    level thread function_e50bbb52();
    self gameobjects::destroy_object( 1 );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xe516674d, Offset: 0x3cc8
// Size: 0x92
function function_90b6f882()
{
    level dialog::remote( "kane_taylor_just_entered_0", 2 );
    level dialog::player_say( "plyr_he_s_headed_to_the_r_0", 0.5 );
    
    if ( !level flag::get( "debris_push_started" ) )
    {
        level flag::wait_till( "debris_push_ready" );
        level.ai_hendricks dialog::say( "hend_gimme_a_hand_0", 0.25 );
    }
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0x80892211, Offset: 0x3d68
// Size: 0xe3
function function_2fc33d6d( a_ents )
{
    level waittill( #"hash_3d336d3b" );
    var_d3b22312 = struct::get( "hunter_crash_intro", "script_noteworthy" );
    var_d3b22312 scene::play();
    wait 0.1;
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "artillery_rumble" );
        earthquake( 0.65, 0.7, player.origin, -128 );
    }
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xc9b7f746, Offset: 0x3e58
// Size: 0x5a
function function_c23650f9()
{
    trigger::wait_till( "hendricks_exited_industrial_zone", "targetname" );
    e_carver = getent( "debris_push_carver", "targetname" );
    e_carver disconnectpaths();
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x3aa263f0, Offset: 0x3ec0
// Size: 0x312
function debris_push_sky_bridge_view()
{
    wait 2;
    level thread function_d5c66ea2( "thrown_sb1_shot01_align" );
    level thread function_d5c66ea2( "thrown_sb1_double01_align", &function_87326039, &function_8a89718c );
    wait 0.05;
    level thread sky_bridge_rvh_battles( 14, "exited_industrial_zone", randomfloatrange( 1, 4 ) );
    level thread sky_bridge_rvh_battles( 12, "exited_industrial_zone", randomfloatrange( 2, 5 ) );
    level thread sky_bridge_rvh_battles( 13, "exited_industrial_zone", randomfloatrange( 2, 5 ) );
    level thread sky_bridge_rvh_battles( 20, "trig_mobile_shop_sky01", randomfloatrange( 1, 4 ), "mobile_shop_kill" );
    level thread sky_bridge_rvh_battles( 21, "trig_mobile_shop_sky01", randomfloatrange( 2, 5 ), "mobile_shop_kill" );
    level thread sky_bridge_rvh_battles( 22, "trig_mobile_shop_sky01", randomfloatrange( 2, 5 ), "mobile_shop_kill" );
    level thread sky_bridge_rvh_battles( 2, "trig_stop_pre_wwz_vtol_rvh", randomfloatrange( 10, 16 ) );
    level thread sky_bridge_rvh_battles( 3, "trig_stop_pre_wwz_vtol_rvh", randomfloatrange( 10, 16 ) );
    level thread sky_bridge_rvh_battles( 4, "trig_stop_pre_wwz_vtol_rvh", randomfloatrange( 10, 16 ) );
    level thread sky_bridge_rvh_battles( 5, "trig_stop_pre_wwz_vtol_rvh", randomfloatrange( 10, 16 ) );
    custom_traversals_on_off( "skybridge01_custom_traversal", 0 );
    set_skybridge_destruction_state( "skybridge_event_10-39_broken", "show" );
    set_skybridge_destruction_state( "skybridge_event_10-41_broken", "show" );
    set_skybridge_destruction_state( "skybridge_event_10-41", "delete" );
    wait 5;
    spawner::add_spawn_function_group( "robot_long_jump", "script_string", &function_d5a3009e );
    spawn_manager::enable( "sm_sky_bridge_0" );
    level thread scene::play( "cin_lot_10_01_skybridge_vign_jump_robot05" );
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0x3f2aebd, Offset: 0x41e0
// Size: 0xf3
function function_8a89718c( a_ents )
{
    s_goal = struct::get( "sky_bridge_1_del_goal", "targetname" );
    
    foreach ( ai_actor in a_ents )
    {
        if ( isalive( ai_actor ) )
        {
            ai_actor ai::set_ignoreall( 1 );
            ai_actor setgoal( s_goal.origin );
            ai_actor thread lotus_security_station::kill_at_goal();
            wait randomfloatrange( 0.5, 2 );
        }
    }
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xfbf02c6b, Offset: 0x42e0
// Size: 0xaa
function function_d5a3009e()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    wait randomfloatrange( 2, 3 );
    
    if ( !isdefined( level.var_4704ff29 ) )
    {
        level.var_4704ff29 = 1;
    }
    else
    {
        level.var_4704ff29++;
        level.var_4704ff29++;
        
        if ( level.var_4704ff29 > 4 )
        {
            return;
        }
    }
    
    self scene::play( "cin_lot_10_01_skybridge_vign_jump_robot0" + level.var_4704ff29, array( self ) );
    self ai::set_ignoreall( 0 );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xbe427651, Offset: 0x4398
// Size: 0x4a
function function_87326039()
{
    self ai::set_ignoreall( 1 );
    self scene::play( "cin_lot_10_01_skybridge_vign_jump_robot03", array( self ) );
    self ai::set_ignoreall( 0 );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x55da5630, Offset: 0x43f0
// Size: 0xba
function function_fd34fb22()
{
    trigger::wait_till( "exited_industrial_zone", "targetname" );
    
    do
    {
        var_264ebbeb = getaiteamarray( "team3" );
        var_264ebbeb = arraycombine( var_264ebbeb, getaiteamarray( "axis" ), 0, 0 );
        var_264ebbeb = array::filter( var_264ebbeb, 0, &filter_istouching, "sb1_initial_battle_area" );
        wait 0.2;
    }
    while ( var_264ebbeb.size );
    
    level flag::set( "sb1_initial_battle_done" );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x8af6fc94, Offset: 0x44b8
// Size: 0x42
function function_236dcbd8()
{
    self waittill( #"hunter_crash_impact" );
    var_32cf47f = struct::get( "fxanim_mobile_shop02_skybridge", "targetname" );
    var_32cf47f scene::play();
}

// Namespace lotus_sky_bridge
// Params 2
// Checksum 0xb66b0766, Offset: 0x4508
// Size: 0xf3
function set_skybridge_destruction_state( str_name, str_state )
{
    a_kaboom_chunks = getentarray( str_name, "targetname" );
    
    foreach ( e_chunk in a_kaboom_chunks )
    {
        if ( str_state == "hide" )
        {
            e_chunk ghost();
            e_chunk notsolid();
            continue;
        }
        
        if ( str_state == "show" )
        {
            e_chunk show();
            e_chunk solid();
            continue;
        }
        
        e_chunk delete();
    }
}

// Namespace lotus_sky_bridge
// Params 4
// Checksum 0x682e4514, Offset: 0x4608
// Size: 0x1aa
function sky_bridge_rvh_battles( n_index, str_trigger, n_wait, str_kill_notify )
{
    ai_robot = spawner::simple_spawn_single( "rvh_robot_" + n_index );
    ai_robot.b_end_fight = 0;
    
    if ( isdefined( str_trigger ) )
    {
        ai_human = spawner::simple_spawn_single( "rvh_human_" + n_index );
        ai_human ai::set_behavior_attribute( "can_initiateaivsaimelee", 0 );
        ai_human.b_end_fight = 0;
        ai_human.overrideactordamage = &function_383fe57e;
        ai_human setentitytarget( ai_robot );
        ai_robot.overrideactordamage = &function_383fe57e;
        ai_robot setentitytarget( ai_human );
        ai_robot rogue_control_ignore_players( 1 );
        
        if ( isdefined( str_kill_notify ) )
        {
            ai_human thread function_699800ba( str_kill_notify );
            ai_robot thread function_699800ba( str_kill_notify );
        }
        
        trigger::wait_till( str_trigger );
        
        if ( isdefined( n_wait ) )
        {
            wait n_wait;
        }
        
        if ( isalive( ai_human ) )
        {
            ai_human ai::set_ignoreall( 0 );
            ai_human ai::set_ignoreme( 0 );
            ai_human.b_end_fight = 1;
        }
    }
    
    if ( isalive( ai_robot ) )
    {
        ai_robot rogue_control_ignore_players( 0 );
    }
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0x728a641a, Offset: 0x47c0
// Size: 0x32
function function_699800ba( str_notify )
{
    self endon( #"death" );
    level waittill( str_notify );
    wait 0.05;
    self kill();
}

// Namespace lotus_sky_bridge
// Params 12
// Checksum 0xbe1964f2, Offset: 0x4800
// Size: 0xdf
function function_383fe57e( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name )
{
    if ( isdefined( e_inflictor ) )
    {
        if ( !isplayer( e_inflictor ) )
        {
            if ( self.b_end_fight === 1 || e_inflictor.targetname === "wwz_vtol_vh" )
            {
                n_damage = self.health;
            }
            else if ( e_inflictor.team === "axis" || e_inflictor.team === "team3" )
            {
                n_damage = 0;
            }
        }
    }
    
    return n_damage;
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0x881db378, Offset: 0x48e8
// Size: 0x6b
function rogue_control_ignore_players( b_ignore )
{
    foreach ( player in level.players )
    {
        self setignoreent( player, b_ignore );
    }
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xbfaf047, Offset: 0x4960
// Size: 0x8a
function sky_bridge_bottom_rvh_battle()
{
    trigger::wait_till( "start_sky_bridge_bottom_rvh_battle", "targetname" );
    level thread sky_bridge_rvh_battles( 6, "end_skybridge2_rvh", 0 );
    level thread sky_bridge_rvh_battles( 7, "end_skybridge2_rvh", randomfloatrange( 0, 2 ) );
    level thread sky_bridge_rvh_battles( 8, "end_skybridge2_rvh", randomfloatrange( 0, 2 ) );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x6ddfa19c, Offset: 0x49f8
// Size: 0x6a
function robot_fall_to_death()
{
    self ai::set_behavior_attribute( "rogue_control", "forced_level_2" );
    nd_traversal = getnode( "fall_to_death_traversal", "targetname" );
    self ai::set_behavior_attribute( "rogue_control_force_goal", nd_traversal.origin );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xe70cd3d8, Offset: 0x4a70
// Size: 0xa2
function function_f0763a16()
{
    vh_hunter = getent( "sky_bridge1_hurryup_hunter01", "targetname" ) spawner::spawn();
    vh_hunter setvehmaxspeed( 60 );
    vh_hunter vehicle_ai::start_scripted();
    vh_hunter attachpath( getvehiclenode( vh_hunter.target, "targetname" ) );
    vh_hunter startpath();
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x765ca138, Offset: 0x4b20
// Size: 0xca
function function_a070d03f()
{
    trigger::wait_till( "exited_industrial_zone" );
    var_e4630460 = function_c9c1e189( "sky_bridge_flyby_vtol" );
    var_566a739b = function_c9c1e189( "sky_bridge_flyby_vtol02" );
    var_e4630460 thread function_ec3fbb5c( "sb1_flyby_vtol", 1, 6, 1 );
    wait 2;
    var_566a739b thread function_ec3fbb5c( "sb1_flyby_vtol02", 1, 6, 1 );
    trigger::wait_till( "trig_wwz_vtol" );
    var_e4630460.var_d700fcda = 0;
    var_566a739b.var_d700fcda = 0;
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x25ecc512, Offset: 0x4bf8
// Size: 0x82
function function_2e696104()
{
    var_e4630460 = function_c9c1e189( "sky_bridge_flyby_vtol" );
    var_566a739b = function_c9c1e189( "sky_bridge_flyby_vtol02" );
    var_e4630460 thread function_ec3fbb5c( "sb1_flyby_vtol", 4, 6, 0 );
    wait 5;
    var_566a739b thread function_ec3fbb5c( "sb1_flyby_vtol02", 4, 6, 0 );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xf5a495d6, Offset: 0x4c88
// Size: 0x70a
function wwz_vtol()
{
    e_carver = getent( "wwz_vtol_crash_carver", "targetname" );
    e_carver connectpaths();
    level thread dialog::remote( "vtlp_air_support_coming_i_0", 1 );
    wait 3;
    level notify( #"robot_swarm" );
    vh_vtol = vehicle::simple_spawn_single_and_drive( "wwz_vtol" );
    vh_vtol util::magic_bullet_shield();
    vh_vtol flag::init( "set_0_done" );
    vh_vtol thread wwz_vtol_targets();
    vh_vtol thread function_c5005576();
    level thread lotus2_sound::function_12202095();
    level thread function_555c7428();
    scene::add_scene_func( "cin_lot_10_02_skybridge_vign_wwzfinale_approach", &function_2bf854b3, "play" );
    level thread scene::play( "cin_lot_10_02_skybridge_vign_wwzfinale_approach" );
    vh_vtol waittill( #"reached_end_node" );
    vh_vtol clearvehgoalpos();
    vh_vtol clearlookatent();
    vh_vtol.animname = "fxanim_skybridge_vtol";
    level thread scene::play( "p7_fxanim_cp_lotus_skybridge_vtol_idle_bundle", vh_vtol );
    objectives::hide( "cp_waypoint_breadcrumb" );
    level thread scene::play( "cin_lot_10_02_skybridge_vign_wwzfinale" );
    level waittill( #"hash_441e4f3" );
    vh_vtol util::stop_magic_bullet_shield();
    vh_vtol.delete_on_death = 1;
    vh_vtol notify( #"death" );
    
    if ( !isalive( vh_vtol ) )
    {
        vh_vtol delete();
    }
    
    level thread scene::play( "p7_fxanim_cp_lotus_skybridge_vtol_crash_bundle" );
    var_692f87a6 = getent( "fxanim_skybridge_vtol", "targetname" );
    var_692f87a6 thread function_c5005576();
    trigger::use( "kill_sm_wwz_vtol_block_rushing_players", "targetname" );
    level waittill( #"hash_2989fcfb" );
    var_b9acdfe5 = struct::get( "smoke_raven_location" );
    playfx( level._effect[ "raven_explosion" ], var_b9acdfe5.origin, ( 1, 1, 0 ), ( 0, 0, 1 ) );
    e_volume = getent( "vol_wwz_crash", "targetname" );
    a_robot_swarm = getaiteamarray( "team3" );
    a_robot_swarm = arraycombine( a_robot_swarm, getaiteamarray( "axis" ), 0, 0 );
    a_robot_swarm = arraysortclosest( a_robot_swarm, level.ai_hendricks.origin );
    var_6f23fc2e = 0;
    
    foreach ( ai_robot in a_robot_swarm )
    {
        if ( ai_robot istouching( e_volume ) )
        {
            ai_robot dodamage( ai_robot.health, ai_robot.origin, undefined, undefined, undefined, "MOD_GRENADE_SPLASH" );
        }
    }
    
    custom_traversals_on_off( "sb_1_broken_start", 0 );
    set_skybridge_destruction_state( "skybridge_event_10-42", "hide" );
    set_skybridge_destruction_state( "skybridge_event_10-42-clip", "hide" );
    set_skybridge_destruction_state( "skybridge_event_10-42_broken", "show" );
    e_carver disconnectpaths();
    getent( "lotus2_vtol_crash_roof_clip", "targetname" ) delete();
    getent( "skybridge_crash_oob", "targetname" ) delete();
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "artillery_rumble" );
        earthquake( 0.65, 0.7, player.origin, -128 );
    }
    
    trigger::use( "hunter_crashes_after_wwz_vtol" );
    wait 3;
    level flag::set( "wwz_vtol_crash_done" );
    level thread function_2e696104();
    objectives::show( "cp_waypoint_breadcrumb" );
    level.ai_hendricks colors::disable();
    level scene::init( "cin_lot_10_03_skybridge_vign_vtoljump_hendricks_start", level.ai_hendricks );
    level waittill( #"hash_baec8538" );
    flag::wait_till( "hendricks_jump_down_to_vtol" );
    level scene::stop( "cin_lot_10_03_skybridge_vign_vtoljump_hendricks_start" );
    level scene::play( "cin_lot_10_03_skybridge_vign_vtoljump_hendricks", level.ai_hendricks );
    level scene::init( "cin_lot_10_03_skybridge_vign_vtoljump_hendricks_end", level.ai_hendricks );
    flag::wait_till( "hendricks_jump_across_from_vtol" );
    
    if ( isdefined( level.bzm_lotusdialogue4_1callback ) )
    {
        level thread [[ level.bzm_lotusdialogue4_1callback ]]();
    }
    
    level scene::play( "cin_lot_10_03_skybridge_vign_vtoljump_hendricks_end", level.ai_hendricks );
    trigger::use( "end_skybridge2_rvh" );
    level.ai_hendricks colors::enable();
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x6938e06e, Offset: 0x53a0
// Size: 0x45
function function_c5005576()
{
    self endon( #"death" );
    self endon( #"hash_2989fcfb" );
    
    while ( true )
    {
        playrumbleonposition( "cp_lotus_rumble_wwz_vtol", self.origin );
        wait 0.1;
    }
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x65a9b8b5, Offset: 0x53f0
// Size: 0x175
function wwz_vtol_targets()
{
    self endon( #"death" );
    self endon( #"hash_2989fcfb" );
    wait 1;
    a_enemies = getaiarray( "rvh_ambient_first", "script_string" );
    
    foreach ( ai_enemy in a_enemies )
    {
        if ( isalive( ai_enemy ) )
        {
            self turret::shoot_at_target( ai_enemy, -1, undefined, 0 );
        }
    }
    
    self flag::set( "set_0_done" );
    
    while ( true )
    {
        a_robot_swarm = getaiarray( "sky_bridge_swarm", "script_string" );
        
        foreach ( ai_robot in a_robot_swarm )
        {
            if ( isalive( ai_robot ) )
            {
                self turret::shoot_at_target( ai_robot, -1, undefined, 0 );
            }
        }
        
        wait 0.05;
    }
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x80c9e19c, Offset: 0x5570
// Size: 0x132
function function_15bb85bc()
{
    var_f93e39e2 = struct::get_array( "wwz_vtol_block_rushing_players_align", "targetname" );
    
    do
    {
        var_fd20b602 = array::random( var_f93e39e2 );
        wait 0.2;
    }
    while ( var_fd20b602.occupied === 1 );
    
    var_fd20b602.occupied = 1;
    self animation_robot_climb( var_fd20b602, "ch_lot_10_03_skybridge_aie_climbinfast_robot01" );
    var_fd20b602.occupied = 0;
    self ai::set_ignoreall( 1 );
    v_goal = getent( "wwz_target", "targetname" ).origin;
    self setgoal( v_goal, 0, 1200 );
    self util::waittill_any( "goal", "near_goal" );
    self ai::set_ignoreall( 0 );
    self setgoal( self.origin, 0, 1200 );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xc3ad1e52, Offset: 0x56b0
// Size: 0xca
function function_555c7428()
{
    level dialog::remote( "khal_central_i_need_rein_0", 3 );
    level dialog::remote( "kane_khalil_gimme_a_sit_0", 2 );
    level dialog::remote( "kane_lost_central_comms_0", 2 );
    level dialog::remote( "ecmd_lieutenant_khalil_s_0", 1 );
    level dialog::player_say( "plyr_kane_what_about_kha_0", 1 );
    level dialog::remote( "kane_john_taylor_is_yo_0" );
    level dialog::remote( "kane_i_promise_0", 0.5 );
    level flag::set( "khalil_convo_done" );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xe6ac01b2, Offset: 0x5788
// Size: 0xaa
function function_70f27cf6()
{
    level flag::wait_till( "khalil_convo_done" );
    wait 1;
    level flag::wait_till( "hendricks_jump_down_to_vtol" );
    level dialog::player_say( "plyr_kane_how_long_until_0", 3 );
    level dialog::remote( "kane_few_minutes_tops_g_0", 2 );
    level flag::wait_till( "wont_be_long_now" );
    level dialog::remote( "plyr_it_won_t_be_long_now_0" );
    level flag::set( "skybridge_final_vo_can_play" );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x577ed886, Offset: 0x5840
// Size: 0x271
function sky_bridge_climbers()
{
    level thread sky_bridge_robot_swarm();
    trigger::wait_till( "trig_sb_climbers_0" );
    str_side = "right_";
    a_indexes = create_array_of_index( 3 );
    n_index_counter = 0;
    
    for ( i = 0; i < 3 ; i++ )
    {
        ai_climber = spawner::simple_spawn_single( "sb_1_normal_climber" );
        n_climber_index = a_indexes[ n_index_counter ];
        s_climb_bundle = struct::get( "sb_normal_climb_" + str_side + n_climber_index );
        ai_climber thread animation_robot_climb( s_climb_bundle, "ch_lot_10_03_skybridge_aie_climbinfast_robot01" );
        
        if ( str_side == "left_" )
        {
            str_side = "right_";
        }
        else
        {
            str_side = "left_";
        }
        
        n_index_counter++;
        
        if ( n_index_counter == a_indexes.size )
        {
            a_indexes = random_shuffle( a_indexes );
            n_index_counter = 0;
        }
        
        if ( math::cointoss() )
        {
            ai_climber ai::set_behavior_attribute( "rogue_control", "forced_level_3" );
        }
        
        wait randomfloatrange( 0.3, 1 );
    }
    
    if ( level.players.size > 2 )
    {
        for ( i = 0; i < 2 ; i++ )
        {
            ai_climber = spawner::simple_spawn_single( "sb_forced_level_1" );
            n_climber_index = randomint( 1 );
            s_climb_bundle = struct::get( "sb_fast_climb_" + str_side + n_climber_index );
            ai_climber thread animation_robot_climb( s_climb_bundle, "ch_lot_10_03_skybridge_aie_climbinfast_robot01" );
            
            if ( str_side == "left_" )
            {
                str_side = "right_";
            }
            else
            {
                str_side = "left_";
            }
            
            wait randomfloatrange( 0.3, 1 );
        }
    }
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0x850ca400, Offset: 0x5ac0
// Size: 0x86
function create_array_of_index( n_indexes )
{
    a_indexes = [];
    
    for ( i = 0; i < n_indexes ; i++ )
    {
        if ( !isdefined( a_indexes ) )
        {
            a_indexes = [];
        }
        else if ( !isarray( a_indexes ) )
        {
            a_indexes = array( a_indexes );
        }
        
        a_indexes[ a_indexes.size ] = i;
    }
    
    a_indexes = random_shuffle( a_indexes );
    return a_indexes;
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0xc985311, Offset: 0x5b50
// Size: 0x67
function random_shuffle( a_items )
{
    b_done_shuffling = undefined;
    item = a_items[ a_items.size - 1 ];
    
    while ( !( isdefined( b_done_shuffling ) && b_done_shuffling ) )
    {
        a_items = array::randomize( a_items );
        
        if ( a_items[ 0 ] != item )
        {
            b_done_shuffling = 1;
        }
        
        wait 0.05;
    }
    
    return a_items;
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x59fa1801, Offset: 0x5bc0
// Size: 0x12b
function sky_bridge_robot_swarm()
{
    level endon( #"hash_2989fcfb" );
    level waittill( #"robot_swarm" );
    level thread robot_swarm_continue();
    ai_robot = spawner::simple_spawn_single( "robot_swarm_t2" );
    ai_robot.script_string = "sky_bridge_swarm";
    a_indexes = create_array_of_index( 13 );
    
    for ( i = 0; i < a_indexes.size ; i++ )
    {
        ai_climber = spawner::simple_spawn_single( "sb_forced_level_2" );
        ai_climber.script_string = "sky_bridge_swarm";
        s_climb_bundle = struct::get( "sb_fast_climb_swarm_" + a_indexes[ i ] );
        ai_climber thread animation_robot_climb( s_climb_bundle, "ch_lot_10_03_skybridge_aie_climbinfast_robot01" );
        wait randomfloatrange( 1, 3 );
    }
    
    level notify( #"robot_swarm_continue" );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x8451d848, Offset: 0x5cf8
// Size: 0x11d
function robot_swarm_continue()
{
    level endon( #"hash_2989fcfb" );
    level waittill( #"robot_swarm_continue" );
    a_indexes = create_array_of_index( 13 );
    n_index_counter = 0;
    
    while ( true )
    {
        a_robots = getaiarray( "sky_bridge_swarm", "script_string" );
        
        if ( a_robots.size < 13 )
        {
            ai_climber = spawner::simple_spawn_single( "sb_forced_level_2" );
            ai_climber.script_string = "sky_bridge_swarm";
            s_climb_bundle = struct::get( "sb_fast_climb_swarm_continue_" + a_indexes[ n_index_counter ] );
            ai_climber thread animation_robot_climb( s_climb_bundle, "ch_lot_10_03_skybridge_aie_climbinfast_robot01" );
            n_index_counter++;
            
            if ( n_index_counter == a_indexes.size )
            {
                a_indexes = random_shuffle( a_indexes );
                n_index_counter = 0;
            }
        }
        
        util::wait_network_frame();
    }
}

// Namespace lotus_sky_bridge
// Params 2
// Checksum 0x63d635f0, Offset: 0x5e20
// Size: 0x52
function animation_robot_climb( s_climb_bundle, str_animation )
{
    self endon( #"death" );
    self rogue_control_ignore_players( 1 );
    self animation::play( str_animation, s_climb_bundle );
    self rogue_control_ignore_players( 0 );
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0x27d0cc20, Offset: 0x5e80
// Size: 0x32
function function_b7f9ae1f( nd_goto )
{
    self waittill( #"scriptedanim" );
    self ai::force_goal( nd_goto, 64, 1, undefined, undefined, 1 );
}

// Namespace lotus_sky_bridge
// Params 3
// Checksum 0xf69012e0, Offset: 0x5ec0
// Size: 0x2c4
function function_d5c66ea2( var_e270de9a, var_1c0be1aa, var_a6902cc5 )
{
    if ( !isdefined( var_1c0be1aa ) )
    {
        var_1c0be1aa = undefined;
    }
    
    if ( !isdefined( var_a6902cc5 ) )
    {
        var_a6902cc5 = undefined;
    }
    
    s_align = struct::get( var_e270de9a, "targetname" );
    
    if ( issubstr( var_e270de9a, "double" ) )
    {
        ai_robot = spawner::simple_spawn_single( "vign_thrown_robot_level_2", &util::magic_bullet_shield );
        ai_human = spawner::simple_spawn_single( "vign_thrown_human", &util::magic_bullet_shield );
        var_e71e42f3 = spawner::simple_spawn_single( "vign_thrown_human02" );
        a_ents = array( ai_human, var_e71e42f3, ai_robot );
        
        foreach ( ent in a_ents )
        {
            ent util::stop_magic_bullet_shield();
        }
        
        s_align scene::play( "cin_lot_09_02_pursuit_vign_thrown_double", a_ents );
    }
    else if ( issubstr( var_e270de9a, "shot" ) )
    {
        ai_human = spawner::simple_spawn_single( "vign_thrown_human", &util::magic_bullet_shield );
        ai_robot = spawner::simple_spawn_single( "vign_thrown_robot_level_1" );
        a_ents = array( ai_human, ai_robot );
        
        foreach ( ent in a_ents )
        {
            ent util::stop_magic_bullet_shield();
        }
        
        s_align scene::play( "cin_lot_09_02_pursuit_vign_thrown_shot", a_ents );
        
        if ( isalive( ai_robot ) )
        {
            ai_robot ai::set_behavior_attribute( "rogue_control", "level_2" );
        }
    }
    
    if ( isdefined( var_1c0be1aa ) )
    {
        if ( isdefined( ai_robot ) && isalive( ai_robot ) )
        {
            ai_robot thread [[ var_1c0be1aa ]]();
        }
    }
    
    if ( isdefined( var_a6902cc5 ) )
    {
        level thread [[ var_a6902cc5 ]]( a_ents );
    }
}

// Namespace lotus_sky_bridge
// Params 2
// Checksum 0x2d4fcde5, Offset: 0x6190
// Size: 0x702
function sky_bridge2_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_hendricks = util::get_hero( "hendricks" );
        skipto::teleport_ai( str_objective );
        level.ai_hendricks.allowbattlechatter[ "bc" ] = 0;
        lotus_util::spawn_funcs_generic_rogue_control();
        level scene::skipto_end( "p7_fxanim_cp_lotus_skybridge_vtol_crash_bundle" );
        level scene::skipto_end( "p7_fxanim_cp_lotus_mobile_shop_sky01_bundle" );
        level.ai_hendricks ai::set_behavior_attribute( "cqb", 0 );
        level.ai_hendricks ai::set_behavior_attribute( "move_mode", "normal" );
        level scene::init( "p7_fxanim_cp_lotus_mobile_shop_sky03_break_bundle" );
        level scene::init( "p7_fxanim_cp_lotus_skybridge_hunter_crash_01_bundle" );
        level scene::init( "p7_fxanim_cp_lotus_skybridge_hunter_crash_02_bundle" );
        level scene::init( "p7_fxanim_cp_lotus_skybridge_hunter_crash_03_bundle" );
        level scene::init( "p7_fxanim_cp_lotus_skybridge_hunter_crash_04_bundle" );
        lotus_util::function_f80cafbd( 1 );
        level thread function_fbd7205();
        level thread function_8175b0d4( 0 );
        level thread sky_bridge_rvh_battles( 6, "hendricks_color_sky_bridge2_start", 0 );
        level thread sky_bridge_rvh_battles( 7, "hendricks_color_sky_bridge2_start", randomfloatrange( 0, 2 ) );
        level thread sky_bridge_rvh_battles( 8, "hendricks_color_sky_bridge2_start", randomfloatrange( 0, 2 ) );
        level thread function_8b154406( b_starting, "sky_bridge2_obj_breadcrumb" );
        level thread function_e50bbb52();
        load::function_a2995f22();
        exploder::exploder( "fx_exterior_vtol_bridge_crash" );
        exploder::exploder( "fx_vista_read2a" );
        lotus_util::function_176c92fd();
        level flag::set( "khalil_convo_done" );
        level flag::set( "hendricks_jump_down_to_vtol" );
        skybridge_sand_fx( 1 );
        level thread function_70f27cf6();
    }
    
    spawner::add_spawn_function_group( "sb_wasp", "script_noteworthy", &sky_bridge_wasp );
    set_skybridge_destruction_state( "skybridge_event_10-42", "delete" );
    set_skybridge_destruction_state( "skybridge_event_10-42-clip", "delete" );
    set_skybridge_destruction_state( "skybridge_event_10-42_broken", "show" );
    level thread function_843bdbe4();
    level thread function_5fcdf0e7( 5 );
    
    if ( level.players.size > 2 )
    {
        ai_climber = spawner::simple_spawn_single( "sb_1_normal_climber" );
        s_climb_bundle = struct::get( "sb_normal_climb_2" );
        ai_climber thread animation_robot_climb( s_climb_bundle, "ch_lot_10_03_skybridge_aie_sideclimb_robot02" );
        spawn_manager::enable( "sm_sky_bridge_2" );
    }
    
    level thread function_1294d662();
    function_be1c6bc9( "trig_sky_bridge_bottom_0" );
    trigger::use( "trig_sky_bridge_bottom_0", "targetname", undefined, 0 );
    wait 1;
    trigger::use( "trig_sb2_top_0", "targetname", undefined, 0 );
    ai_climber = spawner::simple_spawn_single( "sb_1_normal_climber" );
    s_climb_bundle = struct::get( "sb_normal_climb_1" );
    ai_climber thread animation_robot_climb( s_climb_bundle, "ch_lot_10_03_skybridge_aie_sideclimb_robot02" );
    trigger::wait_till( "sky_bridge2_hendricks_vo" );
    level thread function_f6434b1f();
    trigger::wait_till( "trig_sb_2_retreat" );
    a_robots = getaiarray( "sb_2_shooters", "script_string" );
    e_volume = getent( "vol_sb_2_retreat", "targetname" );
    
    foreach ( ai_robot in a_robots )
    {
        ai_robot setgoal( e_volume, 1 );
    }
    
    level thread function_fa01f7b8();
    trigger::wait_till( "sky_bridge2_final_vo" );
    level thread function_80b5176f();
    var_7ab662a3 = trigger::wait_till( "sky_bridge2_complete" );
    level notify( #"hash_5de07fa5" );
    
    if ( isdefined( level.bzm_lotusdialogue4_2callback ) )
    {
        level thread [[ level.bzm_lotusdialogue4_2callback ]]();
    }
    
    level thread dialog::player_say( "plyr_kane_something_s_wr_0", 1.5 );
    level thread scene::add_scene_func( "cin_lot_09_01_pursuit_1st_switch_start", &end_fade_out, "skip_started" );
    level thread scene::play( "cin_lot_09_01_pursuit_1st_switch_start", var_7ab662a3.who );
    array::thread_all( level.activeplayers, &function_35cef19b );
    level waittill( #"hash_6a4e357d" );
    level clientfield::set( "sndIGCsnapshot", 4 );
    skipto::objective_completed( "sky_bridge2" );
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0x5cc35137, Offset: 0x68a0
// Size: 0x82
function end_fade_out( a_ents )
{
    foreach ( player in level.activeplayers )
    {
        player setlowready( 1 );
    }
    
    util::screen_fade_out( 0, "black" );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xee12ab06, Offset: 0x6930
// Size: 0x9a
function function_35cef19b()
{
    self endon( #"death" );
    var_de0db1fd = 0.5;
    var_66c3b4b9 = 0.6;
    
    while ( var_66c3b4b9 >= 0 )
    {
        self clientfield::set_to_player( "hijack_static_effect", 1 );
        wait var_de0db1fd;
        self clientfield::set_to_player( "hijack_static_effect", 0 );
        wait var_66c3b4b9;
        var_66c3b4b9 -= 0.05;
        var_de0db1fd += 0.1;
    }
    
    self clientfield::set_to_player( "hijack_static_effect", 1 );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xe69ce508, Offset: 0x69d8
// Size: 0x7a
function function_1294d662()
{
    trigger::wait_till( "hendricks_color_sky_bridge2_start" );
    ai_climber = spawner::simple_spawn_single( "sb_1_normal_climber" );
    s_climb_bundle = struct::get( "sb_normal_climb_0" );
    ai_climber thread animation_robot_climb( s_climb_bundle, "ch_lot_10_03_skybridge_aie_sideclimb_robot02" );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x3d6d5bc8, Offset: 0x6a60
// Size: 0x8a
function function_843bdbe4()
{
    level waittill( #"trig_sky_bridge_bottom_0" );
    var_e4630460 = function_c9c1e189( "sky_bridge_flyby_vtol" );
    var_566a739b = function_c9c1e189( "sky_bridge_flyby_vtol02" );
    var_e4630460 thread function_ec3fbb5c( "sb2_flyby_vtol", 1, 1, 0 );
    wait 2;
    var_566a739b thread function_ec3fbb5c( "sb2_flyby_vtol02", 1, 1, 0 );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xa0d92cb1, Offset: 0x6af8
// Size: 0x82
function function_f6434b1f()
{
    var_e4630460 = function_c9c1e189( "sky_bridge_flyby_vtol" );
    var_566a739b = function_c9c1e189( "sky_bridge_flyby_vtol02" );
    var_e4630460 thread function_ec3fbb5c( "sb2_flyby_vtol", 2, 2, 0 );
    wait 2;
    var_566a739b thread function_ec3fbb5c( "sb2_flyby_vtol02", 2, 2, 0 );
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0xe05fc088, Offset: 0x6b88
// Size: 0x95
function function_be1c6bc9( str_endon )
{
    level endon( str_endon );
    
    while ( true )
    {
        var_bdd1b88a = getaiteamarray( "team3" );
        var_bdd1b88a = arraycombine( var_bdd1b88a, getaiteamarray( "axis" ), 0, 0 );
        var_bdd1b88a = array::filter( var_bdd1b88a, 0, &filter_istouching, "sky_bridge2_start_area" );
        
        if ( !var_bdd1b88a.size )
        {
            return;
        }
        
        wait 0.2;
    }
}

// Namespace lotus_sky_bridge
// Params 2
// Checksum 0x63663e0, Offset: 0x6c28
// Size: 0x51, Type: bool
function filter_istouching( e_entity, str_name )
{
    e_volume = getent( str_name, "targetname" );
    
    if ( e_entity istouching( e_volume ) )
    {
        return true;
    }
    
    return false;
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x8b7ea2c5, Offset: 0x6c88
// Size: 0x113
function function_80b5176f()
{
    level flag::wait_till( "skybridge_final_vo_can_play" );
    level.ai_hendricks dialog::say( "hend_taylor_it_s_just_yo_0" );
    level.ai_hendricks dialog::say( "hend_this_isn_t_you_it_0", 0.5 );
    level.ai_hendricks thread dialog::say( "hend_what_is_it_john_wh_0", 1 );
    wait 5.5;
    
    foreach ( player in level.activeplayers )
    {
        player clientfield::set_to_player( "hijack_static_effect", 1 );
        wait 0.5;
        player clientfield::set_to_player( "hijack_static_effect", 0 );
    }
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xb02513e8, Offset: 0x6da8
// Size: 0x82
function sky_bridge_wasp()
{
    self.team = "team3";
    a_friendlies = getaiarray( "friendly_vtol_crew_ai", "targetname" );
    a_friendlies = array::remove_dead( a_friendlies, 0 );
    
    if ( a_friendlies.size > 0 )
    {
        self setentitytarget( array::random( a_friendlies ) );
    }
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x9098e67c, Offset: 0x6e38
// Size: 0x13b
function function_fa01f7b8()
{
    level waittill( #"hash_a31a8136" );
    level thread lotus2_sound::function_beaa78ac();
    exploder::exploder( "fx_sky_bridge_tower2_exp1" );
    var_cc034878 = getentarray( "tower2_ext_wall_explode_clean", "targetname" );
    
    foreach ( e_chunk in var_cc034878 )
    {
        e_chunk delete();
    }
    
    var_1adcc6bf = getentarray( "tower2_ext_wall_explode_destroy", "targetname" );
    
    foreach ( e_chunk in var_1adcc6bf )
    {
        e_chunk show();
    }
}

// Namespace lotus_sky_bridge
// Params 4
// Checksum 0x2104ed8b, Offset: 0x6f80
// Size: 0x22
function sky_bridge2_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x752ef085, Offset: 0x6fb0
// Size: 0x4df
function flyby_vtols()
{
    level endon( #"end_flyby_vtols" );
    level.veh_flyby_vtol_ea = getent( "skybridge_flyby_vtol_ea", "targetname" ) spawner::spawn();
    level.var_b68f1f5e = getent( "skybridge_flyby_hunter_nrc", "targetname" ) spawner::spawn();
    level.var_b68f1f5e setvehmaxspeed( 125 );
    level.var_b68f1f5e vehicle_ai::start_scripted();
    level.var_b68f1f5e ai::set_ignoreme( 1 );
    var_26778947 = getent( "trig_industrial_outside", "targetname" );
    v_quake_origin = var_26778947 getorigin();
    var_26778947 waittill( #"trigger" );
    level scene::play( "p7_fxanim_cp_lotus_skybridge_hunter_intro_bundle" );
    nd_chaser = getvehiclenode( "skybridge_flyby_vtol_opening_chaser_start", "targetname" );
    nd_chased = getvehiclenode( "skybridge_flyby_vtol_opening_chased_start", "targetname" );
    var_780ea365 = level.veh_flyby_vtol_ea;
    var_cbe20803 = level.var_b68f1f5e;
    var_780ea365 attachpath( nd_chaser );
    var_780ea365 startpath();
    wait 0.5;
    earthquake( 0.45, 0.75, v_quake_origin, 256 );
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "grenade_rumble" );
    }
    
    wait 1;
    var_cbe20803 attachpath( nd_chased );
    var_cbe20803 startpath();
    wait 0.5;
    earthquake( 0.45, 0.75, v_quake_origin, 256 );
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "grenade_rumble" );
    }
    
    var_780ea365 waittill( #"reached_end_node" );
    
    for ( var_1969d6b4 = randomfloatrange( 2, 3.5 ); true ; var_1969d6b4 = randomfloatrange( 2, 3.5 ) )
    {
        n_flyby_path = randomintrange( 1, 4 );
        nd_chaser = getvehiclenode( "skybridge_flyby_vtol_" + n_flyby_path + "_chaser_start", "targetname" );
        nd_chased = getvehiclenode( "skybridge_flyby_vtol_" + n_flyby_path + "_chased_start", "targetname" );
        n_flyby_type = randomint( 1 );
        
        switch ( n_flyby_type )
        {
            case 0:
                var_780ea365 = level.veh_flyby_vtol_ea;
                var_cbe20803 = level.var_b68f1f5e;
                break;
            case 1:
                var_780ea365 = level.var_b68f1f5e;
                var_cbe20803 = level.veh_flyby_vtol_ea;
                break;
            case 2:
                var_780ea365 = level.veh_flyby_vtol_ea;
                var_cbe20803 = undefined;
                break;
            case 3:
                var_780ea365 = level.var_b68f1f5e;
                var_cbe20803 = undefined;
                break;
        }
        
        var_780ea365 attachpath( nd_chaser );
        var_780ea365 startpath();
        wait randomfloatrange( 1, 1.5 );
        
        if ( isdefined( var_cbe20803 ) )
        {
            var_cbe20803 attachpath( nd_chased );
            var_cbe20803 startpath();
        }
        
        var_780ea365 waittill( #"reached_end_node" );
        wait var_1969d6b4;
    }
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x638fc295, Offset: 0x7498
// Size: 0x12a
function function_fdb69d4a()
{
    self endon( #"death" );
    level.var_36f2abde = ( -2636, -1390, 15832 );
    
    if ( !level flag::get( "play_wwz_vtol_crash" ) )
    {
        if ( !level flag::get( "sb1_initial_battle_done" ) )
        {
            self function_3ab6abff();
            wait 2;
        }
        
        self thread function_d6f89ec3();
        function_af70fd8a( 0, ( -2636, -1390, 15832 ) );
        level waittill( #"play_wwz_vtol_crash" );
    }
    
    if ( !level flag::get( "wwz_vtol_crash_done" ) )
    {
        function_af70fd8a( 1 );
        level waittill( #"wwz_vtol_crash_done" );
        wait 2;
    }
    
    if ( !level flag::get( "jumpdown_to_cross_vtol" ) )
    {
        function_af70fd8a( 0, ( 2327, -966, 15603.1 ) );
        level waittill( #"jumpdown_to_cross_vtol" );
    }
    
    function_af70fd8a( 0, ( -997, 1966, 15136 ) );
}

// Namespace lotus_sky_bridge
// Params 2
// Checksum 0x446cf5b7, Offset: 0x75d0
// Size: 0x4e
function function_af70fd8a( b_pause, var_81647593 )
{
    if ( !isdefined( var_81647593 ) )
    {
        var_81647593 = undefined;
    }
    
    if ( isdefined( var_81647593 ) )
    {
        level.var_36f2abde = var_81647593;
    }
    
    if ( !b_pause )
    {
        function_5e17f9d3();
    }
    
    level.var_941f173a = !b_pause;
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xfee38881, Offset: 0x7628
// Size: 0x32
function function_3ab6abff()
{
    self endon( #"death" );
    level endon( #"sb1_initial_battle_done" );
    trigger::wait_till( "start_dawdler_check", "targetname", self );
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x33ebe481, Offset: 0x7668
// Size: 0x305
function function_d6f89ec3()
{
    var_7be70491 = 20 * 0.2;
    var_b77bdab = int( 1 / 0.2 );
    var_acd23ae0 = 2 * var_b77bdab;
    var_e95d58b2 = 3 * var_b77bdab;
    var_e4609c20 = 12 * var_b77bdab;
    var_9a176c0c = 3 * var_b77bdab;
    var_a6b5a5f2 = 8 * var_b77bdab;
    self endon( #"death" );
    level endon( #"sky_bridge1_complete" );
    function_5e17f9d3();
    
    while ( true )
    {
        if ( level.var_941f173a )
        {
            if ( level.var_d87b4b0e > 0 )
            {
                level.var_d87b4b0e--;
            }
            
            if ( level.var_3d810458 > 0 )
            {
                level.var_3d810458--;
            }
            
            var_48529301 = distance2d( self.origin, level.var_36f2abde );
            var_50a0147f = level.var_272cec8f - var_48529301;
            array::push_front( level.var_757ec91f, var_50a0147f );
            level.var_272cec8f = var_48529301;
            
            if ( level.var_757ec91f.size > var_acd23ae0 )
            {
                arrayremoveindex( level.var_757ec91f, var_acd23ae0, 0 );
            }
            
            var_97147322 = math::array_average( level.var_757ec91f );
            
            if ( var_97147322 < 0 )
            {
                level.var_6f5f5ea0 += 2;
            }
            else if ( var_97147322 < var_7be70491 )
            {
                level.var_6f5f5ea0++;
            }
            else if ( level.var_6f5f5ea0 > 0 )
            {
                level.var_6f5f5ea0 -= 4;
            }
            
            level.var_6f5f5ea0 = math::clamp( level.var_6f5f5ea0, 0, var_e4609c20 );
            
            /#
                iprintln( "<dev string:x28>" + var_97147322 + "<dev string:x2e>" + level.var_6f5f5ea0 );
            #/
            
            if ( level.var_6f5f5ea0 >= var_e4609c20 )
            {
                if ( level.var_d87b4b0e <= 0 )
                {
                    /#
                        iprintln( "<dev string:x40>" );
                    #/
                    
                    self thread function_98cf27e0();
                    level.var_d87b4b0e = var_a6b5a5f2;
                }
            }
            else if ( level.var_6f5f5ea0 > var_e95d58b2 )
            {
                if ( level.var_3d810458 <= 0 )
                {
                    /#
                        iprintln( "<dev string:x50>" );
                    #/
                    
                    self thread function_2806a9b0( level.var_d1f071b6 );
                    level.var_3d810458 = var_9a176c0c;
                    level.var_d1f071b6++;
                }
            }
        }
        
        wait 0.2;
    }
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0xdbc8c8ed, Offset: 0x7978
// Size: 0x52
function function_5e17f9d3()
{
    level.var_6f5f5ea0 = 0;
    level.var_d87b4b0e = 0;
    level.var_3d810458 = 0;
    level.var_d1f071b6 = 0;
    level.var_757ec91f = [];
    level.var_272cec8f = distance2d( self.origin, level.var_36f2abde );
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0x10658e5a, Offset: 0x79d8
// Size: 0x229
function function_2806a9b0( var_d1f071b6 )
{
    self endon( #"death" );
    var_f49de915 = 2 + var_d1f071b6;
    
    if ( randomintrange( 0, 100 ) < 40 )
    {
        var_73aa72ef = getweapon( "launcher_standard" );
        var_6788cc47 = 1;
        var_eb493f55 = 2;
        n_max_wait = 1;
    }
    else
    {
        var_73aa72ef = getweapon( "lmg_light" );
        var_6788cc47 = 6;
        var_eb493f55 = 20;
        n_max_wait = 0.1;
    }
    
    a_s_source = struct::get_array( "warn_dawdler_magicbullet_source", "targetname" );
    var_f49de915 = math::clamp( var_f49de915, 2, a_s_source.size );
    
    for ( i = var_f49de915; i > 0 ; i-- )
    {
        s_source = array::random( a_s_source );
        var_4b9c2228 = randomintrange( var_6788cc47, var_eb493f55 );
        
        do
        {
            var_8bfbf121 = randomintrange( 50, -6 );
            var_b1a681f4 = randomintrange( 50, -6 );
            var_8bfbf121 = randomint( 100 ) < 50 ? var_8bfbf121 : var_8bfbf121 * -1;
            var_b1a681f4 = randomint( 100 ) < 50 ? var_b1a681f4 : var_b1a681f4 * -1;
            magicbullet( var_73aa72ef, s_source.origin, self.origin + ( var_8bfbf121, var_b1a681f4, 0 ) );
            wait randomfloatrange( 0, n_max_wait );
            var_4b9c2228--;
        }
        while ( var_4b9c2228 > 0 );
        
        array::exclude( a_s_source, s_source );
    }
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x6ead3c51, Offset: 0x7c10
// Size: 0x15a
function function_98cf27e0()
{
    var_db68bd31 = struct::get_array( "hunter_crash_kill_lagger_impact_point", "targetname" );
    var_4edc1532 = arraygetclosest( self.origin, var_db68bd31 );
    var_8d8f9222 = var_4edc1532.script_int < 10 ? "hunter_crash_kill_lagger0" : "hunter_crash_kill_lagger";
    var_f4e069ec = struct::get( var_8d8f9222 + var_4edc1532.script_int, "script_noteworthy" );
    var_1346ba83 = util::spawn_model( "veh_t7_drone_hunter_nrc" );
    var_f4e069ec thread function_d07395cc( var_1346ba83 );
    var_b58ae759 = var_1346ba83 util::waittill_any_timeout( 5, "hunter_crash_impact" );
    
    if ( var_b58ae759 === "hunter_crash_impact" )
    {
        if ( !sessionmodeiscampaignzombiesgame() )
        {
            radiusdamage( var_4edc1532.origin, 500, self.health * 2, self.health, undefined, "MOD_EXPLOSIVE" );
        }
    }
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x99397a3d, Offset: 0x7d78
// Size: 0x4a
function function_fbd7205()
{
    a_s_bundles = struct::get_array( "p7_fxanim_cp_lotus_dogfight_bundle", "scriptbundlename" );
    array::thread_all( a_s_bundles, &scene::play );
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0xbcdcf952, Offset: 0x7dd0
// Size: 0x3e
function function_c9c1e189( str_spawner_name )
{
    var_6d37f6c1 = vehicle::simple_spawn( str_spawner_name );
    var_6d37f6c1[ 0 ] util::magic_bullet_shield();
    return var_6d37f6c1[ 0 ];
}

// Namespace lotus_sky_bridge
// Params 4
// Checksum 0x963af996, Offset: 0x7e18
// Size: 0x172
function function_ec3fbb5c( str_name, var_b793b0f2, var_3882bd7, b_looping )
{
    var_e8cd1704 = var_b793b0f2;
    n_loop_count = 0;
    self.var_d700fcda = 1;
    
    while ( var_e8cd1704 <= var_3882bd7 && self.var_d700fcda )
    {
        var_4acb8b18 = getvehiclenode( str_name + "_path0" + var_e8cd1704, "targetname" );
        self attachpath( var_4acb8b18 );
        self startpath();
        self waittill( #"reached_end_node" );
        n_wait = randomfloatrange( 6, 12 );
        var_c1ced5dc = n_wait * 0.3 * n_loop_count;
        var_c1ced5dc = math::clamp( var_c1ced5dc, 0, 60 );
        wait n_wait + var_c1ced5dc;
        var_e8cd1704++;
        
        if ( b_looping )
        {
            if ( var_e8cd1704 > var_3882bd7 )
            {
                var_e8cd1704 = var_b793b0f2;
                n_loop_count++;
            }
        }
    }
    
    self util::stop_magic_bullet_shield();
    self.delete_on_death = 1;
    self notify( #"death" );
    
    if ( !isalive( self ) )
    {
        self delete();
    }
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0xc51d88b1, Offset: 0x7f98
// Size: 0xef
function function_8175b0d4( var_aa750b18 )
{
    level notify( #"hash_5de07fa5" );
    level endon( #"hash_5de07fa5" );
    var_824105f2 = struct::get_array( "hunter_crash_ambient", "script_noteworthy" );
    wait var_aa750b18;
    
    while ( true )
    {
        var_2e29ca4a = array::random( var_824105f2 );
        var_2e29ca4a scene::play( var_2e29ca4a.scriptbundlename );
        var_824105f2 = array::exclude( var_824105f2, var_2e29ca4a );
        n_randy = randomfloatrange( 2, 10 );
        wait n_randy;
        
        if ( var_824105f2.size == 0 )
        {
            var_824105f2 = struct::get_array( "hunter_crash_ambient", "script_noteworthy" );
        }
    }
}

// Namespace lotus_sky_bridge
// Params 4
// Checksum 0xc12554bd, Offset: 0x8090
// Size: 0x11b
function function_5fcdf0e7( n_index, var_e34a0fe5, func_spawn, param_1 )
{
    if ( !isdefined( var_e34a0fe5 ) )
    {
        var_e34a0fe5 = undefined;
    }
    
    var_63ef22cf = struct::get_array( "hunter_crash_group0" + n_index, "script_noteworthy" );
    trigger::wait_till( "hunter_crash_group0" + n_index, "script_noteworthy" );
    
    foreach ( var_7ca663de, var_f4e069ec in var_63ef22cf )
    {
        var_1346ba83 = util::spawn_model( "veh_t7_drone_hunter_nrc" );
        var_f4e069ec thread function_d07395cc( var_1346ba83 );
        
        if ( isdefined( var_e34a0fe5 ) && var_7ca663de == var_e34a0fe5 )
        {
            var_1346ba83 thread [[ func_spawn ]]( param_1 );
        }
    }
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0x70a32989, Offset: 0x81b8
// Size: 0x2a
function function_d07395cc( var_79ddcc8b )
{
    self util::script_delay();
    self scene::play( var_79ddcc8b );
}

// Namespace lotus_sky_bridge
// Params 2
// Checksum 0xd8ef6b6c, Offset: 0x81f0
// Size: 0xab
function custom_traversals_on_off( str_node_name, b_link )
{
    var_5ab883a0 = getnodearray( str_node_name, "targetname" );
    
    foreach ( nd_start in var_5ab883a0 )
    {
        if ( b_link )
        {
            linktraversal( nd_start );
            continue;
        }
        
        unlinktraversal( nd_start );
    }
}

// Namespace lotus_sky_bridge
// Params 2
// Checksum 0xbeca04af, Offset: 0x82a8
// Size: 0x22
function function_8b154406( b_starting, var_778cc6bb )
{
    objectives::breadcrumb( var_778cc6bb );
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0x86fccd36, Offset: 0x82d8
// Size: 0x8b
function skybridge_sand_fx( b_enable )
{
    var_9dff5377 = b_enable ? 1 : 0;
    
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "skybridge_sand_fx", var_9dff5377 );
    }
}

// Namespace lotus_sky_bridge
// Params 1
// Checksum 0x7d2cbffa, Offset: 0x8370
// Size: 0x1b2
function function_2bf854b3( a_ents )
{
    var_d27e665b = a_ents[ "lot_10_02_skybridge_vign_wwzfinale_robot01" ];
    var_6076f720 = a_ents[ "lot_10_02_skybridge_vign_wwzfinale_robot02" ];
    var_86797189 = a_ents[ "lot_10_02_skybridge_vign_wwzfinale_robot03" ];
    var_4485d596 = a_ents[ "lot_10_02_skybridge_vign_wwzfinale_robot04" ];
    var_6a884fff = a_ents[ "lot_10_02_skybridge_vign_wwzfinale_robot05" ];
    
    if ( isdefined( var_d27e665b ) )
    {
        var_d27e665b clientfield::set( "rogue_bot_fx", 1 );
    }
    
    if ( isdefined( var_6076f720 ) )
    {
        var_6076f720 clientfield::set( "rogue_bot_fx", 1 );
    }
    
    if ( isdefined( var_86797189 ) )
    {
        var_86797189 clientfield::set( "rogue_bot_fx", 1 );
    }
    
    if ( isdefined( var_4485d596 ) )
    {
        var_4485d596 clientfield::set( "rogue_bot_fx", 1 );
    }
    
    if ( isdefined( var_6a884fff ) )
    {
        var_6a884fff clientfield::set( "rogue_bot_fx", 1 );
    }
    
    level waittill( #"hash_2989fcfb" );
    
    if ( isdefined( var_d27e665b ) )
    {
        var_d27e665b clientfield::set( "rogue_bot_fx", 0 );
    }
    
    if ( isdefined( var_6076f720 ) )
    {
        var_6076f720 clientfield::set( "rogue_bot_fx", 0 );
    }
    
    if ( isdefined( var_86797189 ) )
    {
        var_86797189 clientfield::set( "rogue_bot_fx", 0 );
    }
    
    if ( isdefined( var_4485d596 ) )
    {
        var_4485d596 clientfield::set( "rogue_bot_fx", 0 );
    }
    
    if ( isdefined( var_6a884fff ) )
    {
        var_6a884fff clientfield::set( "rogue_bot_fx", 0 );
    }
}

// Namespace lotus_sky_bridge
// Params 0
// Checksum 0x36fe113c, Offset: 0x8530
// Size: 0x9d
function function_e50bbb52()
{
    var_a974bdb4 = getent( "trigger_skybridge_umbra_gate", "targetname" );
    
    while ( true )
    {
        while ( util::any_player_is_touching( var_a974bdb4, "allies" ) )
        {
            wait 0.25;
        }
        
        lotus_util::function_3b6587d6( 1, "lotus1_industrial_zone_umbra_gate" );
        var_a974bdb4 trigger::wait_till();
        lotus_util::function_3b6587d6( 0, "lotus1_industrial_zone_umbra_gate" );
    }
}

