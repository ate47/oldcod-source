#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_eth_prologue;
#using scripts/cp/cp_mi_eth_prologue_accolades;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_prologue_enter_base;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace air_traffic_controller;

// Namespace air_traffic_controller
// Params 0
// Checksum 0xb867d714, Offset: 0x708
// Size: 0x22
function air_traffic_controller_start()
{
    air_traffic_controller_precache();
    air_traffic_controller_main();
}

// Namespace air_traffic_controller
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x738
// Size: 0x2
function air_traffic_controller_precache()
{
    
}

// Namespace air_traffic_controller
// Params 0
// Checksum 0xc4e42a04, Offset: 0x748
// Size: 0x312
function air_traffic_controller_main()
{
    load::function_73adcefc();
    battlechatter::function_d9f49fba( 0 );
    level.ai_hendricks = util::get_hero( "hendricks" );
    level thread function_13d078e2();
    level thread scene::init( "cin_pro_01_02_airtraffic_1st_hack" );
    load::function_a2995f22();
    level util::clientnotify( "sndOnOverride" );
    level thread util::do_chyron_text( "CP_MI_ETH_PROLOGUE_INTRO_LINE_1_FULL", "CP_MI_ETH_PROLOGUE_INTRO_LINE_1_SHORT", "CP_MI_ETH_PROLOGUE_INTRO_LINE_2_FULL", "CP_MI_ETH_PROLOGUE_INTRO_LINE_2_SHORT", "CP_MI_ETH_PROLOGUE_INTRO_LINE_3_FULL", "CP_MI_ETH_PROLOGUE_INTRO_LINE_3_SHORT", "CP_MI_ETH_PROLOGUE_INTRO_LINE_4_FULL", "CP_MI_ETH_PROLOGUE_INTRO_LINE_4_SHORT", "CP_MI_ETH_PROLOGUE_INTRO_LINE_5_FULL", "CP_MI_ETH_PROLOGUE_INTRO_LINE_5_SHORT" );
    lui::prime_movie( "cp_prologue_env_controltower" );
    exploder::exploder( "fx_exploder_high_res_fire" );
    level cp_prologue_util::spawn_coop_player_replacement( "skipto_nrc_knocking" );
    wait 5;
    level.ai_hendricks thread dialog::say( "hend_the_nrc_are_gonna_be_0" );
    wait 1.5;
    level clientfield::set( "sndIGCsnapshot", 2 );
    level thread namespace_21b2c1f2::play_intro_igc();
    
    if ( isdefined( level.bzm_prologuedialogue1callback ) )
    {
        level thread [[ level.bzm_prologuedialogue1callback ]]();
    }
    
    videostart( "cp_prologue_env_controltower" );
    util::delay( 6.5, undefined, &exploder::stop_exploder, "fx_exploder_high_res_fire" );
    level thread scene::play( "cin_pro_01_02_airtraffic_1st_hack_ai" );
    level scene::play( "cin_pro_01_02_airtraffic_1st_hack" );
    videostop( "cp_prologue_env_controltower" );
    videostart( "cp_prologue_env_post_crash", 1 );
    level clientfield::set( "sndIGCsnapshot", 0 );
    level thread cp_prologue_util::function_2a0bc326( level.ai_hendricks.origin, 1.4, 2, 5000, 12, "damage_heavy", "default" );
    playfxoncamera( level._effect[ "prologue_transition_debris" ], ( 0, 0, 0 ), ( 1, 0, 0 ), ( 0, 0, 1 ) );
    level thread scene::play( "cin_pro_01_02_airtraffic_1st_hack_aftermath_ai" );
    level scene::play( "cin_pro_01_02_airtraffic_1st_hack_aftermath" );
    skipto::objective_completed( "skipto_air_traffic_controller" );
}

// Namespace air_traffic_controller
// Params 0
// Checksum 0xe82b36d1, Offset: 0xa68
// Size: 0x6a
function function_13d078e2()
{
    level scene::init( "p7_fxanim_cp_prologue_control_tower_plane_hit_bundle" );
    level waittill( #"hash_9ba3dcb6" );
    exploder::exploder( "fx_exploder_disable_fx_start" );
    level scene::play( "p7_fxanim_cp_prologue_control_tower_plane_hit_bundle" );
    level scene::play( "p7_fxanim_cp_prologue_control_tower_plane_fall_bundle" );
}

