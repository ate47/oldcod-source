#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection_sound;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace sgen_test_chamber;

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x9509f345, Offset: 0x6a8
// Size: 0x3a
function main()
{
    /#
        iprintlnbold( "<dev string:x28>" );
    #/
    
    init_client_field_callback_funcs();
    setup_scenes();
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x19cc8ee0, Offset: 0x6f0
// Size: 0xca
function init_client_field_callback_funcs()
{
    clientfield::register( "world", "sgen_test_chamber_pod_graphics", 1, 1, "int" );
    clientfield::register( "world", "sgen_test_chamber_time_lapse", 1, 1, "int" );
    clientfield::register( "scriptmover", "sgen_test_guys_decay", 1, 1, "int" );
    clientfield::register( "world", "fxanim_hive_cluster_break", 1, 1, "int" );
    clientfield::register( "world", "fxanim_time_lapse_objects", 1, 1, "int" );
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x1db39b6c, Offset: 0x7c8
// Size: 0x152
function setup_scenes()
{
    scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh090", &scene_flash_light, "play" );
    scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh140", &scene_humanlabdeath_end, "done" );
    scene::add_scene_func( "cin_inf_05_taylorinfected_3rd_sh010", &scene_taylorinfected_3rd_fade_nt, "play" );
    scene::add_scene_func( "cin_inf_05_taylorinfected_3rd_sh080", &function_6089d98, "done" );
    scene::add_scene_func( "cin_inf_04_02_sarah_vign_01", &scene_sarah_vign_01_fade_nt, "play" );
    scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh140", &function_eabb935c, "play" );
    scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh150", &function_c43d862, "play" );
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x61dc954a, Offset: 0x928
// Size: 0x6b
function gas_release_watcher()
{
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0x54b2984d, Offset: 0x9a0
// Size: 0x13
function scene_humanlabdeath_end( a_ent )
{
    level notify( #"humanlabdeath_scene_end" );
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0x94bb160b, Offset: 0x9c0
// Size: 0x1a
function function_eabb935c( a_ent )
{
    level util::set_streamer_hint( 6 );
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0xd9d423f5, Offset: 0x9e8
// Size: 0x4a
function function_c43d862( a_ent )
{
    level waittill( #"hash_ee361e18" );
    
    if ( isdefined( a_ent[ "wire" ] ) )
    {
        e_wire = a_ent[ "wire" ];
        e_wire setmodel( "p7_sgen_dni_testing_pod_wires_01_off" );
    }
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0x941d703a, Offset: 0xa40
// Size: 0x103
function scene_flash_light( a_ent )
{
    fx_flash_lights = getentarray( "inf_test_chamber_flashlight", "script_noteworthy" );
    
    if ( isdefined( a_ent[ "flashlight" ] ) )
    {
        e_origin = a_ent[ "flashlight" ] gettagorigin( "tag_origin" );
        
        foreach ( fx_flash_light in fx_flash_lights )
        {
            fx_flash_light.origin = a_ent[ "flashlight" ] gettagorigin( "tag_light_position" );
            fx_flash_light linkto( a_ent[ "flashlight" ], "tag_origin" );
        }
    }
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x6375ba67, Offset: 0xb50
// Size: 0x1a
function function_a29f7cbd()
{
    level scene::init( "cin_inf_04_humanlabdeath_3rd_sh010" );
}

// Namespace sgen_test_chamber
// Params 2
// Checksum 0xb885904, Offset: 0xb78
// Size: 0x1ea
function sgen_test_chamber_init( str_objective, b_starting )
{
    /#
        iprintlnbold( "<dev string:x40>" );
    #/
    
    level clientfield::set( "sgen_test_chamber_pod_graphics", 1 );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        array::thread_all( level.players, &infection_util::player_enter_cinematic );
        level thread scene::init( "cin_inf_04_humanlabdeath_3rd_sh010" );
        load::function_a2995f22();
    }
    
    level thread namespace_eccdd5d1::function_6ef2bfc6();
    level thread util::delay( "start_fade", undefined, &util::screen_fade_in, 2, "white" );
    level thread util::delay( "fx_explosion", undefined, &gas_release_watcher );
    level thread util::delay( "fx_explosion", undefined, &clientfield::set, "fxanim_hive_cluster_break", 0 );
    level clientfield::set( "fxanim_hive_cluster_break", 1 );
    array::thread_all( level.players, &clientfield::increment_to_player, "stop_post_fx", 1 );
    level thread function_7711faaf();
    
    if ( isdefined( level.bzm_infectiondialogue4callback ) )
    {
        level thread [[ level.bzm_infectiondialogue4callback ]]();
    }
    
    level thread scene::play( "cin_inf_04_humanlabdeath_3rd_sh010" );
    level waittill( #"humanlabdeath_scene_end" );
    skipto::objective_completed( "sgen_test_chamber" );
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0xd6aebf6a, Offset: 0xd70
// Size: 0x52
function function_7711faaf()
{
    videostart( "cp_infection_env_dnimainmonitor", 1 );
    level waittill( #"fx_explosion" );
    videostop( "cp_infection_env_dnimainmonitor" );
    videostart( "cp_infection_env_timelapse_fail", 1 );
}

/#

    // Namespace sgen_test_chamber
    // Params 4
    // Checksum 0xadd0743f, Offset: 0xdd0
    // Size: 0x3a, Type: dev
    function sgen_test_chamber_done( str_objective, b_starting, b_direct, player )
    {
        iprintlnbold( "<dev string:x57>" );
    }

#/

// Namespace sgen_test_chamber
// Params 2
// Checksum 0xd6648e62, Offset: 0xe18
// Size: 0x10a
function time_lapse_init( str_objective, b_starting )
{
    /#
        iprintlnbold( "<dev string:x6e>" );
    #/
    
    if ( !b_starting )
    {
        videostop( "cp_infection_env_timelapse_fail" );
    }
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level util::set_streamer_hint( 9 );
        array::thread_all( level.players, &infection_util::player_enter_cinematic );
        load::function_a2995f22();
    }
    
    videostart( "cp_infection_env_raventimelapse_ravens", 1 );
    level thread time_lapse_anim_test();
    level thread fx_anim_time_lapse();
    level waittill( #"scene_time_lapse_end" );
    level thread util::clear_streamer_hint();
    skipto::objective_completed( "time_lapse" );
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x6cb820fb, Offset: 0xf30
// Size: 0xa2
function time_lapse_anim_test()
{
    scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh150", &scene_decayedman_skin_shader, "play" );
    scene::add_scene_func( "cin_inf_04_humanlabdeath_3rd_sh150", &scene_time_lapse_end, "done" );
    level thread scene::play( "cin_inf_04_humanlabdeath_3rd_sh150" );
    level waittill( #"hash_c6e56c65" );
    wait 1;
    clientfield::set( "sgen_test_chamber_time_lapse", 1 );
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0xb2790a59, Offset: 0xfe0
// Size: 0x7a
function scene_decayedman_skin_shader( a_ents )
{
    /#
        iprintlnbold( "<dev string:x7e>" );
    #/
    
    level thread function_a2b1036();
    cin_guy = a_ents[ "decayedman" ];
    cin_guy thread start_decayman_decay();
    level waittill( #"time_lapse_cut_to_white" );
    util::screen_fade_out( 0, "white" );
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0xa36de143, Offset: 0x1068
// Size: 0x112
function start_decayman_decay()
{
    level endon( #"scene_time_lapse_end" );
    self waittill( #"startdecay" );
    level notify( #"hash_c6e56c65" );
    wait 1;
    self setmodel( "c_spc_decayman_stage1_tout_fb" );
    self clientfield::set( "sgen_test_guys_decay", 1 );
    wait 1;
    self setmodel( "c_spc_decayman_stage2_tin_fb" );
    wait 1;
    self setmodel( "c_spc_decayman_stage2_fb" );
    wait 1;
    self setmodel( "c_spc_decayman_stage2_tout_fb" );
    wait 1;
    self setmodel( "c_spc_decayman_stage3_tin_fb" );
    wait 1;
    self setmodel( "c_spc_decayman_stage3_fb" );
    wait 1.5;
    self setmodel( "c_spc_decayman_stage4_fb" );
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0x7abd1aa2, Offset: 0x1188
// Size: 0x13
function scene_time_lapse_end( a_ents )
{
    level notify( #"scene_time_lapse_end" );
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x22f7a8ef, Offset: 0x11a8
// Size: 0x1a
function fx_anim_time_lapse()
{
    level thread clientfield::set( "fxanim_time_lapse_objects", 1 );
}

// Namespace sgen_test_chamber
// Params 4
// Checksum 0xb39ce91e, Offset: 0x11d0
// Size: 0x52
function time_lapse_done( str_objective, b_starting, b_direct, player )
{
    /#
        iprintlnbold( "<dev string:x8b>" );
    #/
    
    videostop( "cp_infection_env_raventimelapse_ravens" );
}

// Namespace sgen_test_chamber
// Params 0
// Checksum 0x90144e51, Offset: 0x1230
// Size: 0x1a
function function_a2b1036()
{
    level scene::init( "cin_inf_04_02_sarah_vign_01" );
}

// Namespace sgen_test_chamber
// Params 2
// Checksum 0x21861aee, Offset: 0x1258
// Size: 0x1a2
function cyber_soliders_invest_init( str_objective, b_starting )
{
    /#
        iprintlnbold( "<dev string:x9b>" );
    #/
    
    level util::set_streamer_hint( 3 );
    videostart( "cp_infection_env_timelapse_fail", 1 );
    
    if ( b_starting )
    {
        util::screen_fade_out( 0, "white" );
        array::thread_all( level.players, &infection_util::player_enter_cinematic );
    }
    
    level thread util::screen_fade_in( 1.5, "white" );
    
    if ( isdefined( level.bzm_infectiondialogue21callback ) )
    {
        level thread [[ level.bzm_infectiondialogue21callback ]]();
    }
    
    level scene::play( "cin_inf_04_02_sarah_vign_01" );
    
    if ( isdefined( level.bzm_infectiondialogue5callback ) )
    {
        level thread [[ level.bzm_infectiondialogue5callback ]]();
    }
    
    level thread namespace_eccdd5d1::function_e0a3aca4();
    level thread scene::play( "cin_inf_05_taylorinfected_3rd_sh010" );
    level waittill( #"taylorinfected_sh80_end" );
    
    if ( scene::is_skipping_in_progress() )
    {
        util::screen_fade_out( 0, "black", "end_level_fade" );
    }
    else
    {
        util::screen_fade_out( 1, "black", "end_level_fade" );
    }
    
    level thread util::clear_streamer_hint();
    skipto::objective_completed( "cyber_soliders_invest" );
}

// Namespace sgen_test_chamber
// Params 4
// Checksum 0x37b6e709, Offset: 0x1408
// Size: 0x52
function cyber_soliders_invest_done( str_objective, b_starting, b_direct, player )
{
    /#
        iprintlnbold( "<dev string:xb6>" );
    #/
    
    videostop( "cp_infection_env_timelapse_fail" );
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0x96ecd40, Offset: 0x1468
// Size: 0x52
function scene_sarah_vign_01_fade_nt( a_ent )
{
    level scene::init( "cin_inf_05_taylorinfected_3rd_sh010" );
    level waittill( #"sarah_vign_start_fade" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        util::screen_fade_out( 1, "white" );
    }
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0xadcf626c, Offset: 0x14c8
// Size: 0x5a
function scene_taylorinfected_3rd_fade_nt( a_ent )
{
    if ( !scene::is_skipping_in_progress() )
    {
        level clientfield::set( "set_exposure_bank", 3 );
        level waittill( #"taylorinfected_start_fade" );
        level thread util::screen_fade_in( 1.5, "white" );
    }
}

// Namespace sgen_test_chamber
// Params 1
// Checksum 0xea7dae9c, Offset: 0x1530
// Size: 0x32
function function_6089d98( a_ent )
{
    if ( !scene::is_skipping_in_progress() )
    {
        level clientfield::set( "set_exposure_bank", 1 );
    }
}

