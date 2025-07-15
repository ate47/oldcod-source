#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_village;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace blackstation_murders;

// Namespace blackstation_murders
// Params 4
// Checksum 0x6cd42284, Offset: 0x848
// Size: 0x22
function cleanup( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace blackstation_murders
// Params 0
// Checksum 0x29861b8d, Offset: 0x878
// Size: 0x22
function main()
{
    init_clientfields();
    setup_scenes();
}

// Namespace blackstation_murders
// Params 0
// Checksum 0xf7031fd5, Offset: 0x8a8
// Size: 0x32
function function_d7cb3668()
{
    level scene::init( "cin_inf_07_04_sarah_vign_03" );
    level scene::init( "cin_inf_08_blackstation_3rd_sh010" );
}

// Namespace blackstation_murders
// Params 2
// Checksum 0x6e6934c5, Offset: 0x8e8
// Size: 0x14a
function murders_main( str_objective, b_starting )
{
    objectives::complete( "cp_level_infection_cross_chasm" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level thread scene::init( "cin_inf_07_04_sarah_vign_03" );
        level thread scene::init( "cin_inf_08_blackstation_3rd_sh010" );
        load::function_a2995f22();
    }
    
    level clientfield::set( "black_station_ceiling_fxanim", 1 );
    players_enter_black_station();
    level thread namespace_bed101ee::function_973b77f9();
    array::thread_all( level.players, &infection_util::player_enter_cinematic );
    black_station_murders_scene();
    level thread ceiling_panels_fly_away();
    wait 4;
    array::thread_all( level.players, &infection_util::player_leave_cinematic );
    players_fly_through_ceiling();
    level thread skipto::objective_completed( str_objective );
}

// Namespace blackstation_murders
// Params 0
// Checksum 0x871feb40, Offset: 0xa40
// Size: 0xca
function init_clientfields()
{
    clientfield::register( "world", "black_station_ceiling_fxanim", 1, 2, "int" );
    clientfield::register( "world", "igc_blackscreen_fade_in", 1, 1, "counter" );
    clientfield::register( "world", "igc_blackscreen_fade_in_immediate", 1, 1, "counter" );
    clientfield::register( "world", "igc_blackscreen_fade_out_immediate", 1, 1, "counter" );
    clientfield::register( "toplayer", "japanese_graphic_content_hide", 1, 1, "int" );
}

// Namespace blackstation_murders
// Params 0
// Checksum 0xafb8ee21, Offset: 0xb18
// Size: 0x362
function setup_scenes()
{
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh010", &scene_3rd_sh010_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh020", &scene_3rd_sh020_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh030", &scene_3rd_sh030_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh040", &scene_3rd_sh040_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh050", &scene_3rd_sh050_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh060", &scene_3rd_sh060_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh070", &scene_3rd_sh070_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh080", &scene_3rd_sh080_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh090", &scene_3rd_sh090_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh090", &scene_3rd_sh090_done, "done" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh100", &scene_3rd_sh100_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh100", &scene_3rd_sh100_done, "done" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh110", &scene_3rd_sh110_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh110", &function_b1fccc96, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh110", &function_86c218d2, "done" );
    scene::add_scene_func( "cin_inf_08_03_blackstation_vign_aftermath", &function_46acf97b, "init" );
    scene::add_scene_func( "cin_inf_08_03_blackstation_vign_aftermath", &scene_aftermath_start, "play" );
    scene::add_scene_func( "cin_inf_08_03_blackstation_vign_aftermath", &scene_aftermath_done, "done" );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x7113c52b, Offset: 0xe88
// Size: 0xba
function players_enter_black_station( str_objective )
{
    level thread util::screen_fade_in( 1, "black" );
    
    if ( isdefined( level.bzm_infectiondialogue9callback ) )
    {
        level thread [[ level.bzm_infectiondialogue9callback ]]();
    }
    
    util::delay( 0.5, undefined, &function_cd24b21 );
    level thread namespace_bed101ee::function_973b77f9();
    level scene::play( "cin_inf_07_04_sarah_vign_03" );
    util::screen_fade_out( 0, "black" );
    level thread util::screen_fade_in( 1, "black" );
}

// Namespace blackstation_murders
// Params 0
// Checksum 0xc529278d, Offset: 0xf50
// Size: 0x52
function function_cd24b21()
{
    level thread util::clear_streamer_hint();
    var_7d116593 = struct::get( "tag_align_infection_blackstation", "targetname" );
    infection_util::function_7aca917c( var_7d116593.origin );
}

// Namespace blackstation_murders
// Params 0
// Checksum 0x7e7e65f0, Offset: 0xfb0
// Size: 0xf4
function black_station_murders_scene()
{
    if ( isdefined( level.bzm_infectiondialogue10callback ) )
    {
        level thread [[ level.bzm_infectiondialogue10callback ]]();
    }
    
    level thread namespace_bed101ee::function_c4d41b74();
    level thread japanese_graphic_content_hide();
    level thread scene::play( "cin_inf_08_blackstation_3rd_sh010" );
    level waittill( #"hash_90d6ffa3" );
    skipto::teleport_players( "black_station" );
    level thread scene::play( "cin_inf_08_03_blackstation_vign_aftermath" );
    array::thread_all( level.players, &clientfield::set_to_player, "japanese_graphic_content_hide", 0 );
    level thread scene::init( "cin_inf_10_01_foy_aie_reversemortar" );
    level thread scene::init( "cin_inf_10_02_foy_aie_reversewallexplosion_suppressor" );
    level waittill( #"hash_e6a81b1c" );
}

// Namespace blackstation_murders
// Params 0
// Checksum 0x17a4e76, Offset: 0x10b0
// Size: 0x85
function japanese_graphic_content_hide()
{
    level endon( #"hash_90d6ffa3" );
    
    while ( true )
    {
        level waittill( #"hash_b95052ad" );
        array::thread_all( level.players, &clientfield::set_to_player, "japanese_graphic_content_hide", 1 );
        level waittill( #"hash_aefb6286" );
        array::thread_all( level.players, &clientfield::set_to_player, "japanese_graphic_content_hide", 0 );
    }
}

// Namespace blackstation_murders
// Params 0
// Checksum 0x40ae0c0b, Offset: 0x1140
// Size: 0x3a
function ceiling_panels_fly_away()
{
    level clientfield::set( "black_station_ceiling_fxanim", 2 );
    wait 0.8;
    exploder::exploder( "lgt_bstation_probe_ceiling_change" );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x506aa52, Offset: 0x1188
// Size: 0x22
function function_8b29fc51( a_ents )
{
    level scene::add_player_linked_scene( "p7_fxanim_cp_infection_reverse_house_01_bundle" );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x85998e4e, Offset: 0x11b8
// Size: 0x6a
function function_bc8265b7( a_ents )
{
    level thread util::clear_streamer_hint();
    level thread village::function_1bf08d19();
    var_7d116593 = struct::get( "s_foy_lighting_hint", "targetname" );
    level thread infection_util::function_7aca917c( var_7d116593.origin );
}

// Namespace blackstation_murders
// Params 0
// Checksum 0x7503fc1e, Offset: 0x1230
// Size: 0x7a
function players_fly_through_ceiling()
{
    level scene::add_scene_func( "cin_inf_09_01_flippingworld_1st_risefal", &function_bc8265b7, "play" );
    level scene::add_scene_func( "cin_inf_09_01_flippingworld_1st_risefal", &function_8b29fc51, "done" );
    level scene::play( "cin_inf_09_01_flippingworld_1st_risefal" );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x9072b170, Offset: 0x12b8
// Size: 0xe3
function function_46acf97b( a_ents )
{
    level.var_9db198cc = a_ents;
    
    foreach ( ent in a_ents )
    {
        if ( isdefined( ent.targetname ) )
        {
            if ( ent.targetname != "sarah" && ent.targetname != "taylor" && ent.targetname != "diaz" && ent.targetname != "maretti" )
            {
                ent ghost();
            }
            
            continue;
        }
        
        ent ghost();
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x7293c72a, Offset: 0x13a8
// Size: 0x7b
function function_b1fccc96( a_ents )
{
    if ( isdefined( level.var_9db198cc ) )
    {
        foreach ( ent in level.var_9db198cc )
        {
            ent show();
        }
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x7f376ef5, Offset: 0x1430
// Size: 0xc3
function scene_aftermath_start( a_ents )
{
    a_ents[ "sarah" ] ai::set_ignoreall( 1 );
    a_ents[ "taylor" ] ai::set_ignoreall( 1 );
    a_ents[ "maretti" ] ai::set_ignoreall( 1 );
    
    foreach ( ent in a_ents )
    {
        ent show();
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xc1afb23f, Offset: 0x1500
// Size: 0x83
function scene_aftermath_done( a_ents )
{
    level flag::wait_till( "black_station_completed" );
    
    foreach ( ent in a_ents )
    {
        if ( isdefined( ent ) )
        {
            ent delete();
        }
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x9f399720, Offset: 0x1590
// Size: 0x10a
function vo_aftermath( a_ents )
{
    level dialog::remote( "hall_the_said_they_needed_0", 0 );
    level dialog::remote( "hall_we_were_marked_for_t_0", 0 );
    level dialog::remote( "hall_but_by_the_time_w_0", 0 );
    level dialog::remote( "hall_we_knew_they_d_send_0", 1 );
    level dialog::player_say( "plyr_that_wasn_t_what_hap_0", 0 );
    level dialog::player_say( "plyr_we_saw_the_footage_f_0", 0 );
    level dialog::player_say( "plyr_you_denied_them_thei_0", 1 );
    level dialog::remote( "hall_oh_my_god_0", 0 );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x8140ba0f, Offset: 0x16a8
// Size: 0x82
function scene_3rd_sh010_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot010" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot010" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xee5053b0, Offset: 0x1738
// Size: 0x82
function scene_3rd_sh020_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot020" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot020" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x3f82df38, Offset: 0x17c8
// Size: 0x82
function scene_3rd_sh030_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot030" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot030" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x14114c37, Offset: 0x1858
// Size: 0x82
function scene_3rd_sh040_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot040" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot040" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x7c8194a1, Offset: 0x18e8
// Size: 0x82
function scene_3rd_sh050_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot050" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot050" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xbfa87f10, Offset: 0x1978
// Size: 0x82
function scene_3rd_sh060_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot060" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot060" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x810eafd2, Offset: 0x1a08
// Size: 0x82
function scene_3rd_sh070_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot070" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot070" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x2a9f9865, Offset: 0x1a98
// Size: 0x82
function scene_3rd_sh080_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot080" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot080" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xb248684e, Offset: 0x1b28
// Size: 0x62
function scene_3rd_sh090_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot090" );
        level clientfield::increment( "igc_blackscreen_fade_in_immediate", 1 );
    }
    
    level scene::init( "cin_inf_08_03_blackstation_vign_aftermath" );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xdb543758, Offset: 0x1b98
// Size: 0x32
function scene_3rd_sh090_done( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder_stop( "inf_bs_shot090" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xeb919ead, Offset: 0x1bd8
// Size: 0x32
function scene_3rd_sh100_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot100" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xe45accfa, Offset: 0x1c18
// Size: 0x32
function scene_3rd_sh100_done( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder_stop( "inf_bs_shot100" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x8a09e417, Offset: 0x1c58
// Size: 0xaa
function scene_3rd_sh110_play( a_ents )
{
    level util::set_streamer_hint( 2 );
    
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot110" );
        level clientfield::increment( "igc_blackscreen_fade_in_immediate", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot110" );
    }
    
    exploder::exploder( "lgt_bstation_probe_igc_to_gameplay" );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xfd3594a6, Offset: 0x1d10
// Size: 0x22
function function_86c218d2( a_ents )
{
    level clientfield::increment( "igc_blackscreen_fade_in_immediate", 1 );
}

