#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_load;
#using scripts/cp/_mapping_drone;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_exterior;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai/warlord;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_mi_sing_sgen_enter_silo;

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2
// Checksum 0xcfa6c6c0, Offset: 0x2170
// Size: 0x35a
function skipto_discover_data_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        videostart( "cp_sgen_env_LobbyMovie", 1 );
        sgen::init_hendricks( str_objective );
        level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
        level.ai_hendricks ai::set_behavior_attribute( "sprint", 0 );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        level flag::set( "hendricks_at_silo_doors" );
        level scene::init( "p7_fxanim_cp_sgen_overhang_building_glass_bundle" );
        level scene::init( "cin_sgen_05_01_discoverdata_vign_lookaround_hendricks" );
        level scene::init( "pb_sgen_data_discovery_hack" );
        trig_post_discover_data = getent( "trig_post_discover_data", "targetname" );
        trig_post_discover_data triggerenable( 0 );
        exploder::exploder( "sgen_flying_IGC" );
        load::function_a2995f22();
        
        foreach ( player in level.activeplayers )
        {
            player clientfield::set_to_player( "sndSiloBG", 1 );
        }
        
        cp_mi_sing_sgen_exterior::open_silo_doors();
    }
    
    level thread function_ab1ca63f();
    level flag::wait_till( "silo_door_opened" );
    
    if ( isdefined( level.bzm_sgendialogue2callback ) )
    {
        level thread [[ level.bzm_sgendialogue2callback ]]();
    }
    
    level thread building_glass_debris();
    level thread function_370bcbcc();
    level thread namespace_d40478f6::function_26fc5a92();
    level thread scene::play( "cin_sgen_05_01_discoverdata_vign_lookaround_hendricks" );
    level waittill( #"hash_dd334053" );
    level thread util::set_streamer_hint( 6 );
    level util::delay( 2, undefined, &discover_data_vo );
    level flag::wait_till( "data_recovered" );
    mapping_drone::spawn_drone();
    level scene::add_scene_func( "cin_sgen_06_01_followleader_vign_activate_eac_hendricks", &function_8e9806c5 );
    level scene::add_scene_func( "cin_sgen_06_01_followleader_vign_activate_eac_drone", &function_8cf3dc94 );
    level thread scene::play( "cin_sgen_06_01_followleader_vign_activate_eac_drone" );
    level thread scene::play( "cin_sgen_06_01_followleader_vign_activate_eac_hendricks" );
    skipto::objective_completed( str_objective );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xac3ba64e, Offset: 0x24d8
// Size: 0x1ca
function function_370bcbcc()
{
    var_f3ad9584 = getent( "emf_device", "targetname" );
    level waittill( #"hash_dd334053" );
    snd_emf = spawn( "script_origin", var_f3ad9584.origin );
    snd_emf playloopsound( "evt_emf_signal" );
    level flag::wait_till( "kane_data_callout" );
    t_use = spawn( "trigger_radius_use", var_f3ad9584.origin, 0, 32, 32 );
    t_use triggerignoreteam();
    t_use setvisibletoall();
    t_use setteamfortrigger( "none" );
    t_use usetriggerrequirelookat();
    var_d67faff5 = util::init_interactive_gameobject( t_use, &"cp_prompt_dni_sgen_hack_emf_source", &"CP_MI_SING_SGEN_HACK", &function_41ebcee5, array( var_f3ad9584 ) );
    level flag::wait_till( "data_discovered" );
    snd_emf stoploopsound();
    objectives::complete( "cp_level_sgen_locate_emf" );
    var_d67faff5 gameobjects::disable_object();
    level flag::wait_till( "data_recovered" );
    var_d67faff5 gameobjects::destroy_object( 1, 0 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1
// Checksum 0xfdf55762, Offset: 0x26b0
// Size: 0x7a
function function_41ebcee5( e_player )
{
    level flag::set( "data_discovered" );
    level scene::add_scene_func( "pb_sgen_data_discovery_hack", &player_data_aquired );
    level scene::play( "pb_sgen_data_discovery_hack", e_player );
    level flag::set( "data_recovered" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1
// Checksum 0x24824b74, Offset: 0x2738
// Size: 0x5a
function function_8cf3dc94( a_ents )
{
    level.vh_mapper vehicle::lights_off();
    level.vh_mapper.script_objective = "fallen_soldiers";
    level waittill( #"hash_3ac74ca" );
    level.vh_mapper vehicle::lights_on();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1
// Checksum 0xdd5c3f55, Offset: 0x27a0
// Size: 0xfb
function player_data_aquired( a_ents )
{
    wait 2.5;
    
    foreach ( e_in_scene in a_ents )
    {
        if ( isplayer( e_in_scene ) )
        {
            e_in_scene cybercom::cybercom_armpulse( 1 );
            e_in_scene clientfield::set_to_player( "sndCCHacking", 2 );
            e_in_scene util::delay( 1, "death", &clientfield::increment_to_player, "hack_dni_fx" );
            e_in_scene util::delay( 2, "death", &clientfield::set_to_player, "sndCCHacking", 0 );
        }
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xa00553e6, Offset: 0x28a8
// Size: 0x52
function building_glass_debris()
{
    level thread glass_debris_timeout();
    level thread player_lookat_building();
    level flag::wait_till( "play_building_glass_debris" );
    level thread scene::play( "p7_fxanim_cp_sgen_overhang_building_glass_bundle" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xb4e8718a, Offset: 0x2908
// Size: 0x72
function player_lookat_building()
{
    level endon( #"play_building_glass_debris" );
    trig_lookat_glass_debris = getent( "trig_lookat_glass_debris", "targetname" );
    level.players[ 0 ] util::waittill_player_looking_at( trig_lookat_glass_debris.origin, 0.8, 0 );
    level flag::set( "play_building_glass_debris" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x2772d3ab, Offset: 0x2988
// Size: 0x22
function glass_debris_timeout()
{
    level endon( #"play_building_glass_debris" );
    wait 10;
    level flag::set( "play_building_glass_debris" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xe79367c4, Offset: 0x29b8
// Size: 0xea
function discover_data_vo()
{
    level flag::set( "kane_data_callout" );
    level dialog::remote( "kane_i_m_picking_up_an_em_0" );
    level flag::wait_till( "data_discovered" );
    level dialog::player_say( "plyr_got_it_uploading_0" );
    level dialog::remote( "kane_the_looters_didn_t_j_0" );
    level.ai_hendricks waittill( #"activate_drone_vo_done" );
    level dialog::remote( "kane_message_received_and_0" );
    level flag::wait_till( "post_discover_data" );
    level thread namespace_d40478f6::function_fb17452c();
    level.ai_hendricks dialog::say( "hend_stick_to_the_ledge_0" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4
// Checksum 0x67bbaa0e, Offset: 0x2ab0
// Size: 0x42
function skipto_discover_data_done( str_objective, b_starting, b_direct, player )
{
    struct::delete_script_bundle( "scene", "cin_sgen_05_01_discoverdata_1st_handgesture_player_dataacquired" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x3d88d587, Offset: 0x2b00
// Size: 0x32
function function_ab1ca63f()
{
    level flag::wait_till( "discover_data_tele" );
    videostop( "cp_sgen_env_LobbyMovie" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2
// Checksum 0x79625605, Offset: 0x2b40
// Size: 0x2e2
function skipto_aquarium_shimmy_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        sgen::init_hendricks( str_objective );
        mapping_drone::spawn_drone( "nd_post_discover_data" );
        level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
        level.ai_hendricks ai::set_behavior_attribute( "sprint", 0 );
        bm_discover_data_player_clip = getent( "bm_discover_data_player_clip", "targetname" );
        bm_discover_data_player_clip delete();
        trig_discover_data_kill = getent( "trig_discover_data_kill", "targetname" );
        trig_discover_data_kill delete();
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::set( "cp_level_sgen_descend_into_core" );
        level scene::skipto_end( "p7_fxanim_cp_sgen_hendricks_railing_kick_bundle" );
        level flag::set( "hendricks_data_anim_done" );
        level flag::set( "glass_railing_kicked" );
        load::function_a2995f22();
        
        foreach ( player in level.activeplayers )
        {
            player clientfield::set_to_player( "sndSiloBG", 1 );
        }
    }
    
    level thread follow_1_vo( b_starting );
    level thread dust_fx_follow();
    level thread post_discover_data_breadcrumb();
    level thread gen_lab_hendricks_safety();
    level.ai_hendricks colors::disable();
    level.ai_hendricks thread post_discover_data_hendricks();
    level.vh_mapper thread drone_lead_player_post_data();
    level thread fish_swim_by();
    level thread catwalk_shimmy_rock_falls();
    level flag::wait_till( "player_past_shimmy_wall" );
    skipto::objective_completed( str_objective );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4
// Checksum 0xe331719e, Offset: 0x2e30
// Size: 0x102
function skipto_aquarium_shimmy_done( str_objective, b_starting, b_direct, player )
{
    struct::delete_script_bundle( "scene", "p7_fxanim_cp_sgen_overhang_building_glass_bundle" );
    struct::delete_script_bundle( "scene", "cin_sgen_01_intro_3rd_pre200_overlook_sh010" );
    struct::delete_script_bundle( "scene", "cin_sgen_03_03_undeadqt_vign_limitedpower_corpses" );
    struct::delete_script_bundle( "scene", "cin_sgen_05_01_discoverdata_vign_lookaround_hendricks" );
    struct::delete_script_bundle( "scene", "cin_sgen_05_01_discoverdata_1st_handgestrure_player_dataacquired" );
    struct::delete_script_bundle( "scene", "cin_sgen_06_01_followleader_vign_activate_eac_drone" );
    struct::delete_script_bundle( "scene", "cin_sgen_06_01_followleader_vign_activate_eac_hendricks" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x604517fd, Offset: 0x2f40
// Size: 0x62
function catwalk_shimmy_rock_falls()
{
    level flag::wait_till( "hendricks_follow1_wait2" );
    level clientfield::increment( "debris_catwalk", 1 );
    level flag::wait_till( "play_shimmy_wall_debris" );
    level clientfield::increment( "debris_wall", 1 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x6d07dae5, Offset: 0x2fb0
// Size: 0xca
function post_discover_data_breadcrumb()
{
    level flag::wait_till( "glass_railing_kicked" );
    objectives::breadcrumb( "post_data_breadcrumb" );
    level flag::wait_till( "post_discover_data" );
    trig_discover_data_kill = getent( "trig_discover_data_kill", "targetname" );
    
    if ( isdefined( trig_discover_data_kill ) )
    {
        trig_discover_data_kill delete();
    }
    
    objectives::set( "cp_level_sgen_descend_into_core" );
    objectives::breadcrumb( "obj_first_jump_down" );
    gen_lab_objective_breadcrumbs();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1
// Checksum 0x66f5f271, Offset: 0x3088
// Size: 0x16a
function function_8e9806c5( a_ents )
{
    level waittill( #"hash_922f2f3" );
    level.ai_hendricks setmodel( "spawner_ally_hero_hendricks_sgen" );
    level.ai_hendricks.animname = "hendricks";
    util::clear_streamer_hint();
    level flag::wait_till( "highlight_railing_glass" );
    mdl_glass = getent( "railing_kick", "animname" );
    mdl_glass thread oed::enable_keyline( 0, "glass_railing_kicked" );
    level flag::wait_till( "glass_railing_kicked" );
    level thread scene::play( "p7_fxanim_cp_sgen_hendricks_railing_kick_bundle" );
    level waittill( #"hash_359ae459" );
    bm_discover_data_player_clip = getent( "bm_discover_data_player_clip", "targetname" );
    bm_discover_data_player_clip delete();
    trig_post_discover_data = getent( "trig_post_discover_data", "targetname" );
    trig_post_discover_data triggerenable( 1 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x80c5d67a, Offset: 0x3200
// Size: 0x11a
function post_discover_data_hendricks()
{
    level flag::wait_till( "hendricks_data_anim_done" );
    level flag::wait_till( "post_discover_data" );
    level scene::play( "cin_sgen_06_02_followtheleader_vign_hendricks_traversal_start" );
    level flag::wait_till( "hendricks_follow1_jump1" );
    level scene::play( "cin_sgen_06_02_followtheleader_vign_hendricks_traversal_finish" );
    self colors::enable();
    trigger::use( "trig_color_post_first_jump", undefined, undefined, 0 );
    level flag::wait_till( "hendricks_follow1_wait3" );
    trigger::use( "pre_gen_lab_after_slide" );
    level scene::play( "cin_sgen_06_02_followleader_vign_slide_hendricks" );
    level flag::wait_till( "player_near_shimmy" );
    level.ai_hendricks thread gen_lab_hendricks();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1
// Checksum 0xe3b5633b, Offset: 0x3328
// Size: 0x19a
function follow_1_vo( b_starting )
{
    level flag::wait_till( "post_discover_data" );
    
    if ( b_starting )
    {
        level.ai_hendricks dialog::say( "hend_hey_let_s_go_0" );
        level.ai_hendricks dialog::say( "hend_stick_to_the_ledge_0", 1 );
    }
    
    wait 3;
    level flag::wait_till( "enter_silo_killings_vo" );
    wait 2;
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
    level.ai_hendricks ai::set_behavior_attribute( "sprint", 0 );
    level dialog::player_say( "plyr_the_footage_we_saw_o_0" );
    level.ai_hendricks dialog::say( "hend_i_ve_known_taylor_a_0", 1.5 );
    level dialog::player_say( "plyr_maybe_he_wasn_t_the_0", 0.75 );
    level.ai_hendricks dialog::say( "hend_even_so_doesn_t_ex_0", 1.33 );
    level dialog::player_say( "plyr_we_ll_get_to_the_bot_0", 1 );
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 0 );
    level.ai_hendricks ai::set_behavior_attribute( "sprint", 1 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x20c6a1a1, Offset: 0x34d0
// Size: 0x95
function dust_fx_follow()
{
    t_dust = getent( "dust_fx", "targetname" );
    t_dust endon( #"death" );
    
    while ( true )
    {
        t_dust waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            t_dust setinvisibletoplayer( who );
            who clientfield::set_to_player( "dust_motes", 1 );
        }
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x828a02e1, Offset: 0x3570
// Size: 0xf9
function fish_swim_by()
{
    mdl_fish = getent( "oarfish", "targetname" );
    level flag::wait_till( "hendricks_follow1_wait2" );
    mdl_fish.angles += ( -15, 0, 0 );
    n_time = 10;
    s_target = mdl_fish;
    
    while ( isdefined( s_target.target ) )
    {
        s_target = struct::get( s_target.target, "targetname" );
        mdl_fish moveto( s_target.origin, n_time );
        mdl_fish rotateto( s_target.angles, n_time, n_time / 2, n_time / 2 );
        wait n_time;
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2
// Checksum 0x5af90bf, Offset: 0x3678
// Size: 0x26a
function skipto_gen_lab_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        sgen::init_hendricks( str_objective );
        mapping_drone::spawn_drone( "nd_start_gen_lab" );
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::set( "cp_level_sgen_descend_into_core" );
        level.ai_hendricks thread gen_lab_hendricks();
        level thread gen_lab_objective_breadcrumbs();
        level thread namespace_d40478f6::function_fb17452c();
        load::function_a2995f22();
        
        foreach ( player in level.activeplayers )
        {
            player clientfield::set_to_player( "sndSiloBG", 1 );
            player clientfield::set_to_player( "dust_motes", 1 );
        }
    }
    
    level thread function_bed09c90();
    level clientfield::set( "sndLabWalla", 1 );
    level.vh_mapper thread drone_lead_player_gen_lab();
    trig_gen_lab_door_player_check = getent( "trig_gen_lab_door_player_check", "targetname" );
    trig_gen_lab_door_player_check triggerenable( 0 );
    level thread gen_lab_spawning();
    level thread scene::init( "p7_fxanim_cp_sgen_lab_ceiling_light_01_bundle" );
    level thread scene::init( "p7_fxanim_cp_sgen_lab_ceiling_light_02_bundle" );
    level flag::wait_till_all( array( "hendricks_at_gen_lab_door", "player_at_gen_lab_door" ) );
    skipto::objective_completed( str_objective );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x22ea85b0, Offset: 0x38f0
// Size: 0x4a
function gen_lab_objective_breadcrumbs()
{
    objectives::breadcrumb( "sgen_lab_breadcrumb_1" );
    level flag::wait_till( "gen_lab_cleared" );
    objectives::breadcrumb( "sgen_labs_exit_breadcrumb" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x6214a420, Offset: 0x3948
// Size: 0x142
function function_bed09c90()
{
    level flag::wait_till( "trig_spawn_gen_lab" );
    a_m_doors = getentarray( "lobby_entrance_doors", "script_noteworthy" );
    var_280d5f68 = getent( "silo_door_left", "targetname" );
    var_3c301126 = getent( "silo_door_right", "targetname" );
    var_280d5f68 rotateyaw( 91, 1, 0.25, 0.4 );
    playsoundatposition( "evt_silo_door_open", var_280d5f68.origin );
    var_3c301126 rotateyaw( -91, 1, 0.25, 0.4 );
    playsoundatposition( "evt_silo_door_open", var_3c301126.origin );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x61049bb4, Offset: 0x3a98
// Size: 0x112
function gen_lab_spawning()
{
    level flag::wait_till( "trig_spawn_gen_lab" );
    level thread hendricks_color_wave_1_count();
    level thread wave_1_enemy_color_chain();
    level.ai_hendricks thread monitor_hendricks_gunfire();
    
    foreach ( e_player in level.activeplayers )
    {
        e_player thread monitor_player_gunfire();
    }
    
    level thread force_gen_lab_hot();
    level flag::wait_till( "player_mid_gen_lab" );
    spawner::simple_spawn( "gen_lab_enemy_wave_2", &setup_wave_2_gen_lab_guy );
    level thread wait_till_lab_cleared();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x1237e1b2, Offset: 0x3bb8
// Size: 0x6a
function setup_wave_2_gen_lab_guy()
{
    self.goalradius = 1024;
    self ai::set_behavior_attribute( "cqb", 1 );
    e_vol_gen_lab_fallback = getent( "vol_gen_lab_fallback", "targetname" );
    self setgoal( e_vol_gen_lab_fallback );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x798205db, Offset: 0x3c30
// Size: 0x42
function wave_1_enemy_color_chain()
{
    level flag::wait_till( "gen_lab_gone_hot" );
    level battlechatter::function_d9f49fba( 1 );
    spawner::simple_spawn( "gen_lab_reinforcements" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x7456b3b2, Offset: 0x3c80
// Size: 0x42
function force_gen_lab_hot()
{
    level flag::wait_till( "player_front_gen_lab" );
    level flag::set( "gen_lab_gone_hot" );
    level thread namespace_d40478f6::play_genlab_music();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x40147d0f, Offset: 0x3cd0
// Size: 0x5a
function monitor_hendricks_gunfire()
{
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    level flag::wait_till( "gen_lab_gone_hot" );
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x31102eb1, Offset: 0x3d38
// Size: 0x5a
function monitor_player_gunfire()
{
    self endon( #"death" );
    self ai::set_ignoreme( 1 );
    level flag::wait_till( "gen_lab_gone_hot" );
    
    if ( self.active_camo === 1 )
    {
        self waittill( #"active_camo_off" );
    }
    
    self ai::set_ignoreme( 0 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xd6ad2efd, Offset: 0x3da0
// Size: 0x7a
function hendricks_color_wave_1_count()
{
    spawner::waittill_ai_group_amount_killed( "gen_lab_enemies", 3 );
    trigger::use( "gen_lab_color_chain_front", undefined, undefined, 0 );
    spawner::waittill_ai_group_amount_killed( "gen_lab_enemies", 6 );
    spawner::waittill_ai_group_cleared( "gen_lab_warlords" );
    trigger::use( "gen_lab_color_chain_mid", undefined, undefined, 0 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1
// Checksum 0x3d75e44d, Offset: 0x3e28
// Size: 0x7b
function setup_patrol_scene( a_ents )
{
    foreach ( ent in a_ents )
    {
        if ( isai( ent ) )
        {
            ent thread monitor_patrol_damage();
        }
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x4a6c0e84, Offset: 0x3eb0
// Size: 0x52
function monitor_patrol_damage()
{
    level endon( #"gen_lab_gone_hot" );
    self waittill( #"damage" );
    sgen_util::scene_stop_if_active( self.current_scene );
    level flag::set( "gen_lab_gone_hot" );
    level thread namespace_d40478f6::play_genlab_music();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xb22a9ea6, Offset: 0x3f10
// Size: 0x1ea
function setup_gen_lab_guy()
{
    self endon( #"death" );
    self.old_maxsightdistsqrd = self.maxsightdistsqrd;
    self.maxsightdistsqrd = 360000;
    self.fovcosine = 0.95;
    self thread gen_lab_sight_check();
    self thread monitor_gen_lab_gunfire();
    self oed::set_force_tmode();
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    
    if ( self.script_string === "gen_lab_force_hot_guy" )
    {
        self thread gen_lab_force_hot_patrol();
    }
    
    level flag::wait_till( "gen_lab_gone_hot" );
    self.maxsightdistsqrd = self.old_maxsightdistsqrd;
    self.fovcosine = 0;
    self ai::set_behavior_attribute( "cqb", 1 );
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
    self.goalradius = 1024;
    
    if ( self.script_string === "cover_office" )
    {
        var_36b24c48 = getent( "gen_lab_office_goalvolume", "targetname" );
    }
    else
    {
        var_36b24c48 = getent( "gen_lab_soldier_goal", "targetname" );
    }
    
    self setgoal( var_36b24c48 );
    level flag::wait_till( "player_mid_gen_lab" );
    e_vol_gen_lab_fallback = getent( "vol_gen_lab_fallback", "targetname" );
    self setgoal( e_vol_gen_lab_fallback );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xb45fc3f7, Offset: 0x4108
// Size: 0xad
function gen_lab_sight_check()
{
    level endon( #"gen_lab_gone_hot" );
    self endon( #"death" );
    
    while ( true )
    {
        foreach ( player in level.activeplayers )
        {
            if ( self cansee( player ) )
            {
                level flag::set( "gen_lab_gone_hot" );
                level thread namespace_d40478f6::play_genlab_music();
            }
        }
        
        wait 0.5;
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xae370a6e, Offset: 0x41c0
// Size: 0x3a
function monitor_gen_lab_gunfire()
{
    self util::waittill_any( "bulletwhizby", "grenade_fire" );
    level flag::set( "gen_lab_gone_hot" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x2d7359fe, Offset: 0x4208
// Size: 0x6a
function gen_lab_force_hot_patrol()
{
    level endon( #"gen_lab_gone_hot" );
    self endon( #"death" );
    level flag::wait_till( "hendricks_in_gen_lab" );
    nd_gen_lab_patrol_force_hot = getnode( "nd_gen_lab_patrol_force_hot", "targetname" );
    self thread ai::patrol( nd_gen_lab_patrol_force_hot );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xb4a6b92c, Offset: 0x4280
// Size: 0xc2
function setup_gen_lab_warlord()
{
    self endon( #"death" );
    self oed::set_force_tmode();
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    level flag::wait_till( "gen_lab_gone_hot" );
    self setgoal( self.origin );
    self.goalradius = 1024;
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
    self warlordinterface::setwarlordaggressivemode( 1 );
    self function_f61c0df8( "node_gen_lab_warlord_preferred", 3, 5 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4
// Checksum 0xdb75ddf0, Offset: 0x4350
// Size: 0xda
function skipto_gen_lab_done( str_objective, b_starting, b_direct, player )
{
    level flag::set( "gen_lab_door_opened" );
    struct::delete_script_bundle( "scene", "cin_sgen_06_02_followtheleader_vign_hendricks_traversal_start" );
    struct::delete_script_bundle( "scene", "cin_sgen_06_02_followtheleader_vign_hendricks_traversal_finish" );
    struct::delete_script_bundle( "scene", "cin_sgen_06_02_followleader_vign_slide_hendricks" );
    struct::delete_script_bundle( "scene", "cin_sgen_06_02_follow_leader_vign_wallrun" );
    struct::delete_script_bundle( "scene", "cin_sgen_07_01_genlab_vign_patrol" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xa1b7e3f, Offset: 0x4438
// Size: 0x92
function wait_till_lab_cleared()
{
    spawner::waittill_ai_group_cleared( "gen_lab_enemies" );
    spawner::waittill_ai_group_cleared( "gen_lab_warlords" );
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    level flag::set( "gen_lab_cleared" );
    level thread namespace_d40478f6::function_973b77f9();
    level thread namespace_d40478f6::play_robot_knock_music();
    level battlechatter::function_d9f49fba( 0 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 3
// Checksum 0xa1aca422, Offset: 0x44d8
// Size: 0xab
function function_f61c0df8( var_e39815ad, n_time_min, n_time_max )
{
    var_91efa0da = getnodearray( var_e39815ad, "targetname" );
    
    foreach ( node in var_91efa0da )
    {
        self warlordinterface::addpreferedpoint( node.origin, n_time_min * 1000, n_time_max * 1000 );
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x70f08af, Offset: 0x4590
// Size: 0x27a
function gen_lab_hendricks()
{
    self colors::disable();
    nd_hendricks_post_shimmy_wall = getnode( "nd_hendricks_post_shimmy_wall", "targetname" );
    self thread ai::force_goal( nd_hendricks_post_shimmy_wall, 32 );
    level flag::wait_till( "player_past_shimmy_wall" );
    level scene::play( "cin_sgen_06_02_follow_leader_vign_wallrun" );
    self ai::set_behavior_attribute( "cqb", 1 );
    self ai::set_behavior_attribute( "sprint", 0 );
    nd_hendricks_outside_gen_lab = getnode( "nd_hendricks_outside_gen_lab", "targetname" );
    self thread ai::force_goal( nd_hendricks_outside_gen_lab, 32 );
    level flag::wait_till( "hendricks_gen_lab_intro_color" );
    nd_hendricks_front_gen_lab = getnode( "nd_hendricks_front_gen_lab", "targetname" );
    self ai::force_goal( nd_hendricks_front_gen_lab, 32 );
    level flag::set( "hendricks_in_gen_lab" );
    self colors::enable();
    level thread hendricks_gen_lab_vo();
    level flag::wait_till( "gen_lab_gone_hot" );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level thread namespace_d40478f6::play_genlab_music();
    self.goalradius = 1024;
    level flag::wait_till( "gen_lab_cleared" );
    self colors::disable();
    nd_gen_lab_door = getnode( "nd_gen_lab_door", "targetname" );
    self setgoal( nd_gen_lab_door, 1 );
    self waittill( #"goal" );
    level flag::set( "hendricks_at_gen_lab_door" );
    level flag::wait_till( "gen_lab_door_opened" );
    self colors::enable();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xf6ff83b0, Offset: 0x4818
// Size: 0x7a
function hendricks_gen_lab_vo()
{
    level endon( #"gen_lab_gone_hot" );
    var_c085d91c = [];
    var_c085d91c[ 0 ] = "hendricks_in_gen_lab";
    var_c085d91c[ 1 ] = "pre_gen_lab_vo_done";
    level flag::wait_till_any( var_c085d91c );
    
    if ( !level flag::get( "gen_lab_gone_hot" ) )
    {
        level.ai_hendricks dialog::say( "hend_take_the_first_shot_0" );
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2
// Checksum 0x5f9a78a9, Offset: 0x48a0
// Size: 0x26a
function skipto_post_gen_lab_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        sgen::init_hendricks( str_objective );
        mapping_drone::spawn_drone( "nd_post_gen_lab_start" );
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::set( "cp_level_sgen_descend_into_core" );
        level thread objectives::breadcrumb( "sgen_labs_exit_breadcrumb" );
        e_gen_lab_end_door = getent( "gen_lab_end_door", "targetname" );
        e_gen_lab_end_door delete();
        level flag::set( "gen_lab_door_opened" );
        load::function_a2995f22();
        
        foreach ( player in level.activeplayers )
        {
            player clientfield::set_to_player( "sndSiloBG", 1 );
            player clientfield::set_to_player( "dust_motes", 1 );
        }
        
        level thread namespace_d40478f6::play_robot_knock_music();
    }
    
    level notify( #"skr" );
    level thread function_8a4d2dee();
    level thread function_a6226aba();
    level.ai_hendricks thread post_gen_lab_hendricks();
    level.vh_mapper thread drone_lead_player_post_gen_lab();
    var_58d37bcd = getent( "trig_bridge_kill_trigger", "targetname" );
    var_58d37bcd triggerenable( 0 );
    level flag::wait_till( "follow_chem_lab" );
    skipto::objective_completed( str_objective );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4
// Checksum 0xc0c7ed94, Offset: 0x4b18
// Size: 0x22
function skipto_post_gen_lab_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x78fb1c30, Offset: 0x4b48
// Size: 0x82
function gen_lab_hendricks_safety()
{
    level endon( #"hash_8210273d" );
    level flag::wait_till( "gen_lab_hendricks_safety" );
    level flag::set( "hendricks_follow1_jump1" );
    level flag::set( "hendricks_follow1_wait2" );
    level flag::set( "hendricks_follow1_wait3" );
    level flag::set( "hendricks_follow1_wait4" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x374fbf9a, Offset: 0x4bd8
// Size: 0xc2
function function_8a4d2dee()
{
    hidemiscmodels( "silo_bridge_edge_break_static" );
    level clientfield::increment( "debris_fall", 1 );
    level flag::wait_till( "main_bridge_collapse" );
    level thread scene::play( "p7_fxanim_cp_sgen_bridge_silo_debris_bundle" );
    level scene::play( "p7_fxanim_cp_sgen_bridge_silo_edge_break_bundle" );
    showmiscmodels( "silo_bridge_edge_break_static" );
    level flag::wait_till( "post_bridge_collapse_rocks" );
    level clientfield::increment( "debris_bridge", 1 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xc24f8bc, Offset: 0x4ca8
// Size: 0x1b2
function post_gen_lab_hendricks()
{
    level scene::play( "cin_sgen_08_01_followleader_2_vign_pathfinding_aie_jumpdown_hendricks" );
    level flag::wait_till( "hendricks_follow2_wallrun_trick" );
    scene::add_scene_func( "cin_sgen_09_01_chemlab_vign_windowknock_robots_start", &function_67a6b650 );
    level thread scene::play( "cin_sgen_09_01_chemlab_vign_windowknock_robots_start" );
    level scene::play( "cin_sgen_08_01_followleader2_vign_wallrun" );
    level flag::wait_till( "hendricks_wallrun_done" );
    self setgoal( getnode( "nd_before_bridge_collapse", "targetname" ), 1 );
    self ai::set_behavior_attribute( "cqb", 1 );
    self ai::set_behavior_attribute( "sprint", 0 );
    level flag::wait_till( "post_bridge_collapse_rocks" );
    self thread dialog::say( "hend_watch_your_step_t_1", 1 );
    level scene::stop( "cin_sgen_08_01_followleader2_vign_wallrun" );
    self setgoal( getnode( "nd_after_bridge_collapse", "targetname" ), 1 );
    self waittill( #"goal" );
    self ai::set_behavior_attribute( "cqb", 0 );
    self ai::set_behavior_attribute( "sprint", 1 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x6b61e704, Offset: 0x4e68
// Size: 0x5a
function function_a6226aba()
{
    level flag::wait_till( "hendricks_follow2_jumpdown" );
    level.ai_hendricks dialog::say( "hend_you_trying_to_send_u_0" );
    level dialog::remote( "kane_i_just_want_the_same_0", 0.75 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2
// Checksum 0x42d34bbf, Offset: 0x4ed0
// Size: 0x2c2
function skipto_chem_lab_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        sgen::init_hendricks( str_objective );
        mapping_drone::spawn_drone( "nd_follow_chem_lab" );
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::set( "cp_level_sgen_descend_into_core" );
        level scene::skipto_end( "p7_fxanim_cp_sgen_bridge_silo_edge_break_bundle" );
        level flag::set( "hendricks_wallrun_done" );
        scene::add_scene_func( "cin_sgen_09_01_chemlab_vign_windowknock_robots_start", &function_67a6b650 );
        level thread scene::play( "cin_sgen_09_01_chemlab_vign_windowknock_robots_start" );
        level thread namespace_d40478f6::play_robot_knock_music();
        load::function_a2995f22();
        
        foreach ( player in level.activeplayers )
        {
            player clientfield::set_to_player( "sndSiloBG", 1 );
            player clientfield::set_to_player( "dust_motes", 1 );
        }
    }
    
    if ( isdefined( level.bzm_sgendialogue3callback ) )
    {
        level thread [[ level.bzm_sgendialogue3callback ]]();
    }
    
    level.ai_hendricks thread chem_lab_hendricks();
    level.vh_mapper thread drone_lead_player_chem_lab();
    level scene::init( "cin_sgen_09_02_chem_lab_vign_opendoor_hendricks" );
    level scene::init( "cin_sgen_11_02_silofloor_vign_notice_hendricks" );
    level thread chem_lab_breadcrumbs();
    level thread setup_silo_robot_risers();
    level thread chem_lab_robots();
    trig_player_at_silo_floor = getent( "trig_player_at_silo_floor", "targetname" );
    trig_player_at_silo_floor triggerenable( 0 );
    level flag::wait_till( "follow3_1" );
    skipto::objective_completed( str_objective );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4
// Checksum 0xcafa07ce, Offset: 0x51a0
// Size: 0x82
function skipto_chem_lab_done( str_objective, b_starting, b_direct, player )
{
    level flag::set( "chem_door_open" );
    struct::delete_script_bundle( "cin_sgen_09_01_chemlab_vign_windowknock_robots_stop" );
    struct::delete_script_bundle( "cin_sgen_09_01_chemlab_vign_windowknock_hendricks_start_idle" );
    struct::delete_script_bundle( "cin_sgen_09_01_chemlab_vign_windowknock_hendricks_moveinroom" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xc9fac9ee, Offset: 0x5230
// Size: 0x52
function chem_lab_breadcrumbs()
{
    level thread objectives::breadcrumb( "obj_chem_lab_mid_breadcrumb" );
    level flag::wait_till( "player_in_chem_lab" );
    level waittill( #"hendricks_chem_door_loop" );
    objectives::breadcrumb( "obj_chem_lab_door_breadcrumb" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x1d885971, Offset: 0x5290
// Size: 0x27a
function chem_lab_hendricks()
{
    level flag::wait_till( "hendricks_wallrun_done" );
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self ai::set_behavior_attribute( "cqb", 1 );
    self ai::set_behavior_attribute( "sprint", 0 );
    level thread scene::play( "cin_sgen_09_01_chemlab_vign_windowknock_hendricks_start_idle" );
    level waittill( #"hendricks_chem_start_idle" );
    level flag::wait_till( "chem_lab_start" );
    level scene::play( "cin_sgen_09_01_chemlab_vign_windowknock_hendricks_moveinroom" );
    level flag::wait_till( "player_in_chem_lab" );
    level thread scene::play( "cin_sgen_09_01_chemlab_vign_windowknock_robots_stop" );
    level thread scene::play( "cin_sgen_09_02_chem_lab_vign_workerbot_robot01_breakfree" );
    level flag::wait_till( "chem_lab_hendricks_movein_done" );
    level thread scene::play( "cin_sgen_09_02_chem_lab_vign_opendoor_hendricks" );
    level waittill( #"hash_99a916d7" );
    e_chem_lab_door_player_clip = getent( "chem_lab_door_player_clip", "targetname" );
    e_chem_lab_door_player_clip notsolid();
    level waittill( #"hendricks_chem_door_loop" );
    level thread chem_door_nag_lines();
    level flag::set( "chem_door_open" );
    trigger::wait_till( "trig_silo_floor_player_check" );
    level flag::set( "all_players_outside_chem_lab" );
    e_chem_lab_door_player_clip solid();
    level scene::play( "cin_sgen_09_02_chem_lab_vign_exitdoor_hendricks" );
    level.ai_hendricks ai::set_ignoreme( 0 );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 0 );
    level.ai_hendricks ai::set_behavior_attribute( "sprint", 1 );
    self thread post_chem_lab_hendricks();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x914cae32, Offset: 0x5518
// Size: 0x52
function chem_door_nag_lines()
{
    level endon( #"all_players_outside_chem_lab" );
    level endon( #"start_chem_lab_robot_scare" );
    wait 8;
    level.ai_hendricks dialog::say( "hend_i_m_not_gonna_hold_i_0" );
    wait 10;
    level.ai_hendricks dialog::say( "hend_wanna_pick_up_the_pa_0" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xc810487d, Offset: 0x5578
// Size: 0x82
function chem_lab_robots()
{
    scene::add_scene_func( "cin_sgen_09_02_chem_lab_vign_workerbot_robot01_breakfree", &function_67a6b650 );
    scene::init( "cin_sgen_09_02_chem_lab_vign_workerbot_robot01_breakfree" );
    level thread robot_breaks_glass_notetrack();
    level flag::wait_till( "start_chem_lab_robot_scare" );
    level thread scene::play( "cin_sgen_09_02_chem_lab_vign_workerbot_robot01_breakfree_stop" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x54cbf208, Offset: 0x5608
// Size: 0x7a
function robot_breaks_glass_notetrack()
{
    level clientfield::set( "w_robot_window_break", 2 );
    level waittill( #"chem_lab_break_glass" );
    level thread namespace_d40478f6::function_98762d53();
    level notify( #"skrd" );
    level.players[ 0 ] thread dialog::player_say( "plyr_shit_1", 1 );
    level clientfield::set( "w_robot_window_break", 1 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1
// Checksum 0x8353752, Offset: 0x5690
// Size: 0x2a
function function_67a6b650( a_ents )
{
    array::thread_all_ents( a_ents, &function_7bff1955 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1
// Checksum 0x587a48fb, Offset: 0x56c8
// Size: 0x5a
function function_7bff1955( e_robot )
{
    e_robot attach( "c_cia_robot_dam_1_lights_1" );
    e_robot clientfield::set( "play_cia_robot_rogue_control", 1 );
    e_robot waittill( #"lights_out" );
    e_robot clientfield::set( "play_cia_robot_rogue_control", 0 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2
// Checksum 0xa80543c6, Offset: 0x5730
// Size: 0x312
function skipto_post_chem_lab_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        sgen::init_hendricks( str_objective );
        level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
        level.ai_hendricks ai::set_behavior_attribute( "sprint", 0 );
        level flag::set( "player_in_chem_lab" );
        mapping_drone::spawn_drone( "nd_pre_ambush" );
        level.vh_mapper thread drone_lead_player_post_chem_lab();
        level.ai_hendricks thread post_chem_lab_hendricks();
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::set( "cp_level_sgen_descend_into_core" );
        level scene::skipto_end( "p7_fxanim_cp_sgen_bridge_silo_edge_break_bundle" );
        level scene::skipto_end( "cin_sgen_09_02_chem_lab_vign_exitdoor_hendricks" );
        scene::add_scene_func( "cin_sgen_11_02_silofloor_vign_notice_hendricks", &drone_highlights_grate, "init" );
        level scene::init( "cin_sgen_11_02_silofloor_vign_notice_hendricks" );
        level thread setup_silo_robot_risers();
        level thread namespace_d40478f6::function_98762d53();
        level flag::set( "follow3_1" );
        trig_player_at_silo_floor = getent( "trig_player_at_silo_floor", "targetname" );
        trig_player_at_silo_floor triggerenable( 0 );
        level flag::set( "chem_door_open" );
        load::function_a2995f22();
        
        foreach ( player in level.activeplayers )
        {
            player clientfield::set_to_player( "sndSiloBG", 1 );
            player clientfield::set_to_player( "dust_motes", 1 );
        }
    }
    
    level thread post_chem_lab_breadcrumbs();
    level flag::wait_till( "player_at_silo_floor" );
    
    if ( isdefined( level.bzm_sgendialogue4callback ) )
    {
        level thread [[ level.bzm_sgendialogue4callback ]]();
    }
    
    skipto::objective_completed( str_objective );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4
// Checksum 0x1ea5c0bf, Offset: 0x5a50
// Size: 0x82
function skipto_post_chem_lab_done( str_objective, b_starting, b_direct, player )
{
    struct::delete_script_bundle( "cin_sgen_09_02_chem_lab_vign_workerbot_robot01_breakfree" );
    struct::delete_script_bundle( "cin_sgen_09_02_chem_lab_vign_workerbot_robot01_breakfree_stop" );
    struct::delete_script_bundle( "cin_sgen_09_02_chem_lab_vign_opendoor_hendricks" );
    struct::delete_script_bundle( "cin_sgen_09_02_chem_lab_vign_exitdoor_hendricks" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x730843e2, Offset: 0x5ae0
// Size: 0x1a
function post_chem_lab_breadcrumbs()
{
    objectives::breadcrumb( "obj_chem_lab_slide_breadcrumb" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x67264a28, Offset: 0x5b08
// Size: 0xe2
function post_chem_lab_hendricks()
{
    level thread post_chem_lab_vo();
    self.goalradius = 32;
    nd_hendricks_post_chem_lab = getnode( "nd_hendricks_post_chem_lab", "targetname" );
    self setgoal( nd_hendricks_post_chem_lab.origin, 1 );
    level flag::wait_till( "hendricks_follow3_wait1" );
    level scene::play( "cin_sgen_10_01_followleader3_vign_slide" );
    nd_hendricks_silo_floor = getnode( "hendricks_silo_floor", "targetname" );
    self ai::force_goal( nd_hendricks_silo_floor, 32 );
    self thread silo_floor_hendricks();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xbee92017, Offset: 0x5bf8
// Size: 0x32
function post_chem_lab_vo()
{
    level dialog::remote( "plyr_kane_could_someone_0" );
    level dialog::remote( "kane_it_s_unlikely_that_a_0" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xdfb66bc, Offset: 0x5c38
// Size: 0xa3
function ev_player_tutorial()
{
    level flag::wait_till( "player_ev_tutorial" );
    
    foreach ( player in level.activeplayers )
    {
        if ( isdefined( player.ev_state ) && player.ev_state )
        {
            return;
        }
        
        player thread util::show_hint_text( &"CP_MI_SING_SGEN_EV_TUTORIAL", 0, "enhanced_vision_activated", 5 );
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2
// Checksum 0xb88bf0dd, Offset: 0x5ce8
// Size: 0x272
function skipto_silo_floor_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        sgen::init_hendricks( str_objective );
        level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
        level.ai_hendricks ai::set_behavior_attribute( "sprint", 0 );
        level.ai_hendricks thread silo_floor_hendricks();
        mapping_drone::spawn_drone( "nd_highlight_grate" );
        level.vh_mapper thread drone_lead_player_silo_battle();
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::set( "cp_level_sgen_descend_into_core" );
        level scene::skipto_end( "p7_fxanim_cp_sgen_bridge_silo_edge_break_bundle" );
        scene::add_scene_func( "cin_sgen_11_02_silofloor_vign_notice_hendricks", &drone_highlights_grate, "init" );
        level scene::init( "cin_sgen_11_02_silofloor_vign_notice_hendricks" );
        level flag::set( "follow3_1" );
        level thread setup_silo_robot_risers();
        load::function_a2995f22();
        
        foreach ( player in level.activeplayers )
        {
            player clientfield::set_to_player( "sndSiloBG", 1 );
            player clientfield::set_to_player( "dust_motes", 1 );
        }
        
        level flag::set( "start_silo_floor_battle" );
    }
    
    level thread silo_floor_battle_vo();
    silo_floor_battle();
    skipto::objective_completed( str_objective );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xa2201670, Offset: 0x5f68
// Size: 0x192
function silo_floor_battle_vo()
{
    level flag::wait_till( "hendricks_at_silo_floor" );
    level flag::wait_till( "player_at_silo_floor" );
    level flag::set( "send_drone_over_grate" );
    level.ai_hendricks dialog::say( "hend_recon_drone_says_the_0" );
    level.ai_hendricks dialog::say( "hend_anyone_wanna_bet_a_h_0", 0.5 );
    playsoundatposition( " evt_metal_bang", ( -624, 995, -2569 ) );
    wait 1;
    playsoundatposition( "mus_coalescence_theme_silo", ( -624, 995, -2569 ) );
    wait 1;
    level notify( #"ambush" );
    level thread namespace_d40478f6::play_robot_ambush_music();
    level flag::set( "start_floor_risers" );
    level.ai_hendricks dialog::say( "hend_whoa_what_the_hel_0" );
    level.ai_hendricks dialog::say( "hend_whoa_whoa_0", 1 );
    level dialog::remote( "kane_hendricks_they_re_t_0" );
    level flag::wait_till( "start_silo_ambush" );
    level battlechatter::function_d9f49fba( 1 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x8096881, Offset: 0x6108
// Size: 0x142
function silo_floor_hendricks()
{
    level flag::set( "hendricks_at_silo_floor" );
    trig_player_at_silo_floor = getent( "trig_player_at_silo_floor", "targetname" );
    trig_player_at_silo_floor triggerenable( 1 );
    level flag::wait_till( "player_at_silo_floor" );
    nd_hendricks_silo_front = getnode( "nd_hendricks_silo_front", "targetname" );
    self ai::force_goal( nd_hendricks_silo_front, 32 );
    level flag::wait_till( "start_silo_ambush" );
    self ai::set_ignoreme( 0 );
    self ai::set_ignoreall( 0 );
    objectives::set( "cp_level_sgen_silo_kill" );
    nd_hendricks_silo_fallback = getnode( "nd_hendricks_silo_fallback", "targetname" );
    self ai::force_goal( nd_hendricks_silo_fallback, 32 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x3fa6249b, Offset: 0x6258
// Size: 0x2d2
function silo_floor_battle()
{
    array::thread_all( getspawnerarray( "silo_robot_rusher", "script_noteworthy" ), &spawner::add_spawn_function, &init_silo_robot_rusher );
    array::thread_all( getspawnerarray( "middle_room_robots", "targetname" ), &spawner::add_spawn_function, &init_silo_robots );
    array::thread_all( getspawnerarray( "silo_ambush_robots", "targetname" ), &spawner::add_spawn_function, &init_silo_robots );
    savegame::checkpoint_save();
    level flag::wait_till( "start_silo_ambush" );
    level.vh_mapper mapping_drone::function_74191a2( 1 );
    level thread monitor_middle_room_robots();
    
    if ( level.players.size > 1 )
    {
        n_delay = 20;
    }
    else
    {
        n_delay = 30;
    }
    
    level thread flag::delay_set( n_delay, "spawn_silo_robots" );
    level flag::wait_till( "spawn_silo_robots" );
    level util::delay( 2, undefined, &function_847fb8ed, "break_higher_balcony_right" );
    level util::delay( 4.5, undefined, &function_847fb8ed, "break_higher_balcony_left" );
    spawner::simple_spawn( "silo_ambush_robots" );
    spawner::waittill_ai_group_cleared( "silo_floor_robots" );
    level thread namespace_d40478f6::function_973b77f9();
    level battlechatter::function_d9f49fba( 0 );
    level.vh_mapper mapping_drone::function_74191a2( 0 );
    level flag::set( "silo_floor_cleared" );
    level.ai_hendricks dialog::say( "hend_all_clear_who_the_h_0", 1 );
    level dialog::remote( "kane_i_don_t_know_i_m_0", 0.5 );
    objectives::complete( "cp_level_sgen_silo_kill" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x87a551b3, Offset: 0x6538
// Size: 0x72
function monitor_middle_room_robots()
{
    wait 5;
    spawner::simple_spawn( "middle_room_robots" );
    
    if ( level.players.size > 1 )
    {
        n_killed = 4;
    }
    else
    {
        n_killed = 6;
    }
    
    spawner::waittill_ai_group_amount_killed( "silo_floor_robots", n_killed );
    level flag::set( "spawn_silo_robots" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x7eeb8ef5, Offset: 0x65b8
// Size: 0x10a
function setup_silo_robot_risers()
{
    level thread function_cc37bee6( "front_robot_riser_01", 1 );
    level thread function_cc37bee6( "front_robot_riser_02", 3.5 );
    level thread function_cc37bee6( "front_robot_riser_03", 2.5 );
    level thread function_cc37bee6( "middle_room_riser_01", 1 );
    level thread function_cc37bee6( "middle_room_riser_02", 3 );
    level thread function_cc37bee6( "middle_room_riser_03", 1.5 );
    level thread function_cc37bee6( "middle_room_riser_04", 4 );
    level flag::wait_till( "start_floor_risers" );
    wait 2;
    level thread function_847fb8ed( "break_lower_balcony" );
    level flag::set( "start_silo_ambush" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1
// Checksum 0xe27a336e, Offset: 0x66d0
// Size: 0x119
function function_847fb8ed( var_5b3b7ceb )
{
    s_bullet_start = struct::get( var_5b3b7ceb );
    a_s_windows = struct::get_array( s_bullet_start.target );
    
    for ( i = 0; i < 5 ; i++ )
    {
        a_s_windows = array::randomize( a_s_windows );
        
        foreach ( s_window in a_s_windows )
        {
            magicbullet( level.ai_hendricks.weapon, s_bullet_start.origin, s_window.origin );
            wait randomfloatrange( 0.05, 0.2 );
        }
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2
// Checksum 0xff6fa318, Offset: 0x67f8
// Size: 0x20a
function function_cc37bee6( str_align, n_delay )
{
    var_a269823c = spawner::simple_spawn_single( "robot_riser_spawner" );
    var_a269823c endon( #"death" );
    var_a269823c oed::disable_thermal();
    var_a269823c clientfield::set( "disable_tmode", 1 );
    var_a269823c disableaimassist();
    var_a269823c function_73a47766( 0 );
    var_a269823c ai::set_behavior_attribute( "robot_lights", 2 );
    s_align = struct::get( str_align );
    s_align thread scene::init( var_a269823c );
    level flag::wait_till( "start_floor_risers" );
    
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    var_a269823c ai::set_behavior_attribute( "rogue_control", "forced_level_1" );
    var_a269823c ai::set_behavior_attribute( "robot_lights", 0 );
    s_align thread scene::play( var_a269823c );
    var_a269823c oed::enable_thermal();
    var_a269823c clientfield::set( "disable_tmode", 0 );
    var_a269823c enableaimassist();
    var_a269823c function_73a47766( 1 );
    
    if ( isdefined( s_align.target ) )
    {
        nd_goal = getnode( s_align.target, "targetname" );
        var_a269823c setgoal( nd_goal, 1 );
        return;
    }
    
    e_silo_floor_volume = getent( "silo_floor_volume", "targetname" );
    var_a269823c setgoal( e_silo_floor_volume );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x92cee198, Offset: 0x6a10
// Size: 0xb2
function init_silo_robots()
{
    self endon( #"death" );
    self ai::set_behavior_attribute( "rogue_control", "forced_level_1" );
    
    if ( isdefined( self.target ) )
    {
        nd_goal = getnode( self.target, "targetname" );
        self ai::force_goal( nd_goal, 32 );
        return;
    }
    
    e_silo_floor_volume = getent( "silo_floor_volume", "targetname" );
    self setgoal( e_silo_floor_volume, 1 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xa37268dd, Offset: 0x6ad0
// Size: 0x92
function init_silo_robot_rusher()
{
    self endon( #"death" );
    self ai::set_behavior_attribute( "rogue_control", "forced_level_1" );
    
    if ( level.players.size == 1 )
    {
        wait randomfloatrange( 0.5, 2.5 );
    }
    
    self ai::set_behavior_attribute( "move_mode", "rusher" );
    self ai::set_behavior_attribute( "sprint", 1 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4
// Checksum 0x939600c2, Offset: 0x6b70
// Size: 0xc2
function skipto_silo_floor_done( str_objective, b_starting, b_direct, player )
{
    struct::delete_script_bundle( "scene", "cin_sgen_08_01_followleader_2_vign_pathfinding_aie_jumpdown_hendricks" );
    struct::delete_script_bundle( "scene", "cin_sgen_08_01_followleader2_vign_wallrun" );
    struct::delete_script_bundle( "scene", "cin_sgen_09_01_chemlab_vign_windowknock_robots_start" );
    struct::delete_script_bundle( "scene", "cin_sgen_10_01_followleader3_vign_slide" );
    struct::delete_script_bundle( "scene", "p7_fxanim_cp_sgen_hendricks_railing_kick_bundle" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1
// Checksum 0x8d108bf3, Offset: 0x6c40
// Size: 0x12a
function function_73a47766( b_state )
{
    if ( b_state )
    {
        self cybercom::cybercom_aiclearoptout( "cybercom_servoshortout" );
        self cybercom::cybercom_aiclearoptout( "cybercom_systemoverload" );
        self cybercom::cybercom_aiclearoptout( "cybercom_immolation" );
        self cybercom::cybercom_aiclearoptout( "cybercom_fireflyswarm" );
        self cybercom::cybercom_aiclearoptout( "cybercom_iffoverride" );
        self cybercom::cybercom_aiclearoptout( "cybercom_surge" );
        return;
    }
    
    self cybercom::cybercom_aioptout( "cybercom_servoshortout" );
    self cybercom::cybercom_aioptout( "cybercom_systemoverload" );
    self cybercom::cybercom_aioptout( "cybercom_immolation" );
    self cybercom::cybercom_aioptout( "cybercom_fireflyswarm" );
    self cybercom::cybercom_aioptout( "cybercom_iffoverride" );
    self cybercom::cybercom_aioptout( "cybercom_surge" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 2
// Checksum 0x988446f8, Offset: 0x6d78
// Size: 0x312
function skipto_under_silo_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        sgen::init_hendricks( str_objective );
        mapping_drone::spawn_drone( "nd_silo_grate" );
        level.vh_mapper thread drone_lead_player_silo_floor();
        level scene::skipto_end( "p7_fxanim_cp_sgen_bridge_silo_edge_break_bundle" );
        scene::add_scene_func( "cin_sgen_11_02_silofloor_vign_notice_hendricks", &drone_highlights_grate, "init" );
        level scene::init( "cin_sgen_11_02_silofloor_vign_notice_hendricks" );
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::set( "cp_level_sgen_descend_into_core" );
        level flag::set( "silo_floor_cleared" );
        level flag::set( "drone_over_grate" );
        level flag::set( "start_silo_ambush" );
        level flag::wait_till( "all_players_spawned" );
        level thread namespace_d40478f6::function_71f06599();
        
        foreach ( player in level.activeplayers )
        {
            player clientfield::set_to_player( "sndSiloBG", 1 );
        }
        
        load::function_a2995f22();
    }
    
    level clientfield::set( "w_underwater_state", 1 );
    level clientfield::set( "fallen_soldiers_client_fxanims", 1 );
    level.ai_hendricks under_silo_hendricks();
    level flag::wait_till( "enter_corvus" );
    
    foreach ( player in level.activeplayers )
    {
        player clientfield::set_to_player( "sndSiloBG", 0 );
        player clientfield::set_to_player( "dust_motes", 0 );
    }
    
    objectives::complete( "cp_level_sgen_descend_into_core" );
    skipto::objective_completed( str_objective );
    level thread corpse_cleanup();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x36dffe7b, Offset: 0x7098
// Size: 0x1a
function under_silo_objective_breadcrumbs()
{
    objectives::breadcrumb( "under_silo_breadcrumb" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 4
// Checksum 0x58f39636, Offset: 0x70c0
// Size: 0x142
function skipto_under_silo_done( str_objective, b_starting, b_direct, player )
{
    level flag::set( "silo_grate_open" );
    struct::delete_script_bundle( "p7_fxanim_cp_sgen_lab_ceiling_light_01_bundle" );
    struct::delete_script_bundle( "p7_fxanim_cp_sgen_lab_ceiling_light_02_bundle" );
    struct::delete_script_bundle( "p7_fxanim_cp_sgen_monkey_jar_bundle" );
    struct::delete_script_bundle( "p7_fxanim_cp_sgen_bridge_silo_edge_break_bundle" );
    struct::delete_script_bundle( "cin_sgen_11_02_silofloor_vign_notice_hendricks" );
    struct::delete_script_bundle( "cin_sgen_11_02_silofloor_vign_notice_drone" );
    struct::delete_script_bundle( "cin_sgen_11_02_silofloor_traverse_vign_hendricks_firstjump" );
    struct::delete_script_bundle( "cin_sgen_11_02_silofloor_traverse_vign_hendricks_secondjump" );
    struct::delete_script_bundle( "cin_sgen_11_02_silofloor_traverse_vign_hendricks_thirdjump" );
    struct::delete_script_bundle( "cin_sgen_11_02_silofloor_traverse_vign_hendricks_fourthjump" );
    struct::delete_script_bundle( "cin_sgen_11_02_silofloor_traverse_vign_hendricks_fifthjump" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x28238979, Offset: 0x7210
// Size: 0x83
function corpse_cleanup()
{
    a_bodies = getcorpsearray();
    
    foreach ( corpse in a_bodies )
    {
        if ( isdefined( corpse ) )
        {
            corpse delete();
            wait 0.05;
        }
    }
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 1
// Checksum 0x1d1cfdd8, Offset: 0x72a0
// Size: 0xfa
function drone_highlights_grate( a_scene_ents )
{
    level flag::wait_till( "drone_over_grate" );
    a_scene_ents[ "silo_floor_grate" ] clientfield::set( "structural_weakness", 1 );
    level flag::wait_till( "start_silo_ambush" );
    a_scene_ents[ "silo_floor_grate" ] clientfield::set( "structural_weakness", 0 );
    level flag::wait_till( "drone_over_grate_real" );
    a_scene_ents[ "silo_floor_grate" ] clientfield::set( "structural_weakness", 1 );
    level flag::wait_till( "silo_grate_open" );
    a_scene_ents[ "silo_floor_grate" ] clientfield::set( "structural_weakness", 0 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x5e0a4cc8, Offset: 0x73a8
// Size: 0x232
function under_silo_hendricks()
{
    self ai::set_behavior_attribute( "cqb", 1 );
    self ai::set_behavior_attribute( "sprint", 0 );
    level flag::wait_till( "silo_floor_regroup" );
    level thread ev_player_tutorial();
    level flag::wait_till( "drone_over_grate_real" );
    
    if ( isdefined( level.bzm_sgendialogue4_1callback ) )
    {
        level thread [[ level.bzm_sgendialogue4_1callback ]]();
    }
    
    scene::play( "cin_sgen_11_02_silofloor_vign_notice_hendricks" );
    level thread under_silo_vo();
    level thread under_silo_objective_breadcrumbs();
    level thread util::clientnotify( "sound_kill_thunder" );
    level scene::play( "cin_sgen_11_02_silofloor_traverse_vign_hendricks_firstjump" );
    level.ai_hendricks waittill( #"idle_started" );
    wait 1;
    level flag::wait_till( "hendricks_under_silo_second_jump" );
    level thread scene::play( "cin_sgen_11_02_silofloor_traverse_vign_hendricks_secondjump" );
    level.ai_hendricks waittill( #"idle_started" );
    level flag::wait_till( "hendricks_under_silo_third_jump" );
    level thread scene::play( "cin_sgen_11_02_silofloor_traverse_vign_hendricks_thirdjump" );
    level.ai_hendricks waittill( #"idle_started" );
    level flag::wait_till( "hendricks_under_silo_fourth_jump" );
    level thread scene::play( "cin_sgen_11_02_silofloor_traverse_vign_hendricks_fourthjump" );
    level.ai_hendricks waittill( #"idle_started" );
    level flag::wait_till( "hendricks_under_silo_fifth_jump" );
    level scene::play( "cin_sgen_11_02_silofloor_traverse_vign_hendricks_fifthjump" );
    nd_post_jump_downs = getnode( "nd_post_jump_downs", "targetname" );
    self setgoal( nd_post_jump_downs, 1 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xf7b120cd, Offset: 0x75e8
// Size: 0x142
function under_silo_vo()
{
    level dialog::remote( "kane_limited_light_ahead_0", 1 );
    level.ai_hendricks dialog::say( "hend_copy_that_kane_0", 0.8 );
    level flag::wait_till( "hendricks_under_silo_second_jump" );
    level.ai_hendricks dialog::say( "hend_hustle_recon_drone_0" );
    level flag::wait_till( "drone_died" );
    level.ai_hendricks dialog::say( "hend_kane_we_lost_the_f_0" );
    level dialog::remote( "kane_negative_beat_blu_0", 1 );
    level.ai_hendricks dialog::say( "hend_fucking_tech_0", 0.5 );
    level dialog::remote( "kane_keep_moving_gps_co_0", 1 );
    objectives::complete( "cp_level_sgen_descend_into_core" );
    objectives::set( "cp_level_sgen_find_recon_drone", level.vh_mapper );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xb73a4c02, Offset: 0x7738
// Size: 0x92
function drone_lead_player_post_data()
{
    self thread speed_up_at_shimmy();
    level flag::wait_till( "post_discover_data" );
    
    if ( level scene::is_active( "cin_sgen_06_01_followleader_vign_activate_eac_drone" ) )
    {
        level scene::stop( "cin_sgen_06_01_followleader_vign_activate_eac_drone" );
    }
    
    self mapping_drone::follow_path( "nd_post_discover_data", "post_discover_data" );
    level flag::wait_till( "player_past_shimmy_wall" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x587f4cdb, Offset: 0x77d8
// Size: 0x62
function speed_up_at_shimmy()
{
    level flag::wait_till( "player_past_shimmy_wall" );
    self notify( #"stop_speed_regulator" );
    
    if ( level flag::get( "drone_scanning" ) )
    {
        level flag::clear( "drone_scanning" );
    }
    
    self mapping_drone::function_6a8adcf6( 35 );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x607a2e3f, Offset: 0x7848
// Size: 0x5a
function pre_gen_lab_vo()
{
    wait 3.4;
    level.ai_hendricks dialog::say( "hend_shit_damn_54i_are_0" );
    level dialog::player_say( "plyr_i_think_it_s_time_we_0" );
    level flag::set( "pre_gen_lab_vo_done" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x7eb93ca2, Offset: 0x78b0
// Size: 0x382
function drone_lead_player_gen_lab()
{
    level scene::init( "cin_sgen_07_01_genlab_vign_patrol" );
    self mapping_drone::function_6a8adcf6( 25 );
    self mapping_drone::follow_path( "nd_start_gen_lab" );
    self mapping_drone::function_74191a2( 1 );
    scene::add_scene_func( "cin_sgen_07_01_genlab_vign_patrol", &setup_patrol_scene, "play" );
    spawner::simple_spawn_single( "gen_lab_warlord", &setup_gen_lab_warlord );
    spawner::simple_spawn_single( "gen_lab_warlord2", &setup_gen_lab_warlord );
    spawner::simple_spawn_single( "gen_lab_enemy_1", &setup_gen_lab_guy );
    spawner::simple_spawn_single( "gen_lab_enemy_2", &setup_gen_lab_guy );
    spawner::simple_spawn_single( "gen_lab_enemy_3", &setup_gen_lab_guy );
    spawner::simple_spawn_single( "gen_lab_enemy_4", &setup_gen_lab_guy );
    spawner::simple_spawn_single( "gen_lab_enemy_5", &setup_gen_lab_guy );
    
    if ( isdefined( level.bzm_sgendialogue2_1callback ) )
    {
        level thread [[ level.bzm_sgendialogue2_1callback ]]();
    }
    
    level thread scene::play( "cin_sgen_07_01_genlab_vign_patrol" );
    level thread pre_gen_lab_vo();
    level lui::play_movie( "cp_sgen_pip_mappingdrone01", "pip" );
    level notify( #"hash_12cb211a" );
    self mapping_drone::function_6a8adcf6( 5 );
    self mapping_drone::follow_path( "gen_lab_wait_goal" );
    level flag::wait_till( "gen_lab_cleared" );
    self mapping_drone::function_74191a2( 0 );
    self mapping_drone::function_6a8adcf6( 10 );
    self thread mapping_drone::follow_path( "nd_follow_gen_lab_mid" );
    self waittill( #"hash_f6e9e60f" );
    self mapping_drone::function_6a8adcf6( 5 );
    level flag::wait_till( "hendricks_at_gen_lab_door" );
    trig_gen_lab_door_player_check = getent( "trig_gen_lab_door_player_check", "targetname" );
    trig_gen_lab_door_player_check triggerenable( 1 );
    level flag::wait_till( "player_at_gen_lab_door" );
    e_gen_lab_end_door = getent( "gen_lab_end_door", "targetname" );
    e_gen_lab_end_door movez( 100, 2, 1 );
    e_gen_lab_end_door playsound( "evt_genlab_door_open" );
    e_gen_lab_end_door waittill( #"movedone" );
    level flag::set( "gen_lab_door_opened" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x92dc11a1, Offset: 0x7c40
// Size: 0x82
function drone_lead_player_post_gen_lab()
{
    self mapping_drone::function_6a8adcf6( 15 );
    self mapping_drone::follow_path( "nd_post_gen_lab_start" );
    self thread mapping_drone::follow_path( "nd_drone_bridge_path", "hendricks_follow2_wallrun_trick" );
    self waittill( #"hash_f6e9e60f" );
    self mapping_drone::function_6a8adcf6( 5 );
    level flag::wait_till( "follow_chem_lab" );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xda3ad9f9, Offset: 0x7cd0
// Size: 0x72
function drone_lead_player_chem_lab()
{
    self mapping_drone::function_2dde6e87();
    self mapping_drone::function_6a8adcf6( 5 );
    self mapping_drone::follow_path( "nd_follow_chem_lab", "chem_lab_start" );
    self mapping_drone::follow_path( "nd_post_chem_lab", "chem_door_open" );
    self thread drone_lead_player_post_chem_lab();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x4940568b, Offset: 0x7d50
// Size: 0x42
function drone_lead_player_post_chem_lab()
{
    self mapping_drone::function_6a8adcf6( 10 );
    self mapping_drone::follow_path( "nd_pre_ambush", "follow3_1" );
    self thread drone_lead_player_silo_battle();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xe4273ab9, Offset: 0x7da0
// Size: 0x8a
function drone_lead_player_silo_battle()
{
    self mapping_drone::function_6a8adcf6( 15 );
    self mapping_drone::follow_path( "nd_highlight_grate", "send_drone_over_grate" );
    level flag::set( "drone_over_grate" );
    self mapping_drone::function_6a8adcf6( 15 );
    self mapping_drone::follow_path( "nd_ambush_react", "start_floor_risers" );
    self thread drone_lead_player_silo_floor();
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0x6baccb97, Offset: 0x7e38
// Size: 0xea
function drone_lead_player_silo_floor()
{
    self mapping_drone::function_6a8adcf6( 15 );
    self mapping_drone::follow_path( "nd_silo_grate", "silo_floor_cleared" );
    level thread scene::init( "cin_sgen_11_02_silofloor_vign_notice_drone" );
    level flag::set( "drone_over_grate_real" );
    level flag::wait_till( "silo_grate_open" );
    level thread namespace_d40478f6::function_71f06599();
    level scene::play( "cin_sgen_11_02_silofloor_vign_notice_drone" );
    self.drivepath = 0;
    self mapping_drone::function_6a8adcf6( 25 );
    self mapping_drone::follow_path( "nd_silo_floor_platform_1", "hendricks_under_silo_second_jump", &drone_discover_corvus );
}

// Namespace cp_mi_sing_sgen_enter_silo
// Params 0
// Checksum 0xf80e0c0b, Offset: 0x7f30
// Size: 0xa2
function drone_discover_corvus()
{
    level lui::prime_movie( "cp_sgen_pip_mappingdrone02" );
    self waittill( #"show_corvus_entrance" );
    level lui::play_movie( "cp_sgen_pip_mappingdrone02", "pip" );
    level flag::set( "drone_died" );
    playfxontag( level._effect[ "drone_sparks" ], self, "tag_origin" );
    self vehicle::lights_off();
    self vehicle::toggle_sounds( 0 );
}

