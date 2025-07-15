#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_pallas;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_sgen_revenge_igc;

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 2
// Checksum 0xb51f990d, Offset: 0x3f8
// Size: 0x1c2
function skipto_revenge_init( str_objective, b_starting )
{
    showmiscmodels( "sgen_ocean_water" );
    
    if ( b_starting )
    {
        util::set_streamer_hint( 4 );
        level scene::init( "cin_sgen_20_twinrevenge_3rd_sh010" );
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
        objectives::complete( "cp_level_sgen_investigate_sgen" );
        objectives::complete( "cp_level_sgen_locate_emf" );
        objectives::complete( "cp_level_sgen_descend_into_core" );
        objectives::complete( "cp_level_sgen_goto_signal_source" );
        objectives::complete( "cp_level_sgen_goto_server_room" );
        objectives::complete( "cp_level_sgen_confront_pallas" );
        sgen::init_hendricks( str_objective );
        level thread cp_mi_sing_sgen_pallas::elevator_setup();
        load::function_a2995f22();
        level scene::play( "cin_sgen_20_twinrevenge_3rd_sh010" );
    }
    
    level waittill( #"hash_3f04e63f" );
    util::clear_streamer_hint();
    util::wait_network_frame();
    level util::player_lock_control();
    streamerrequest( "clear", "cin_sgen_19_ghost_3rd" );
    streamerrequest( "clear", "cin_sgen_20_twinrevenge_3rd" );
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 4
// Checksum 0xb9d5072, Offset: 0x5c8
// Size: 0x3a
function skipto_revenge_done( str_objective, b_starting, b_direct, player )
{
    hidemiscmodels( "sgen_ocean_water" );
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 0
// Checksum 0x821b5674, Offset: 0x610
// Size: 0x1c2
function function_a8e314e9()
{
    level scene::add_scene_func( "cin_sgen_20_twinrevenge_3rd_sh010", &set_exposure_bank, "play", 3 );
    level scene::add_scene_func( "cin_sgen_20_twinrevenge_3rd_sh010_nohint", &set_exposure_bank, "play", 3 );
    level scene::add_scene_func( "cin_sgen_20_twinrevenge_3rd_sh070", &set_exposure_bank, "play", 3 );
    level scene::add_scene_func( "cin_sgen_20_twinrevenge_3rd_sh070", &function_ac7d11ce, "play" );
    level scene::add_scene_func( "cin_sgen_20_twinrevenge_3rd_sh080", &function_867a9765, "play" );
    level scene::add_scene_func( "cin_sgen_20_twinrevenge_3rd_sh090", &function_a1234ba5, "play" );
    level scene::add_scene_func( "cin_sgen_20_twinrevenge_3rd_sh090", &twin_revenge_igc_complete, "done" );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        level scene::add_scene_func( "cin_sgen_20_twinrevenge_3rd_sh010", &function_c52866de, "play" );
        level scene::add_scene_func( "cin_sgen_20_twinrevenge_3rd_sh010_nohint", &function_c52866de, "play" );
    }
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 1
// Checksum 0xe029d88f, Offset: 0x7e0
// Size: 0x20
function function_c52866de( a_ents )
{
    if ( isdefined( level.bzm_sgendialogue8_1callback ) )
    {
        level thread [[ level.bzm_sgendialogue8_1callback ]]();
    }
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 1
// Checksum 0xc8637aa7, Offset: 0x808
// Size: 0x32
function function_a1234ba5( a_ents )
{
    level waittill( #"hash_a1234ba5" );
    util::screen_fade_out( 0, "black", "hide_trans_flood" );
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 1
// Checksum 0x87bf101c, Offset: 0x848
// Size: 0x5a
function twin_revenge_igc_complete( a_ents )
{
    util::clear_streamer_hint();
    set_exposure_bank( a_ents, 0 );
    skipto::teleport( "flood_combat" );
    skipto::objective_completed( "twin_revenge" );
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 1
// Checksum 0xc6bb7cec, Offset: 0x8b0
// Size: 0x3a
function function_ac7d11ce( a_ents )
{
    wait 1;
    level clientfield::set( "w_twin_igc_fxanim", 1 );
    wait 1;
    level clientfield::set( "w_twin_igc_fxanim", 2 );
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 1
// Checksum 0x5338ca28, Offset: 0x8f8
// Size: 0x22
function function_867a9765( a_ents )
{
    wait 1;
    level clientfield::set( "w_twin_igc_fxanim", 3 );
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 2
// Checksum 0xd41f0fd, Offset: 0x928
// Size: 0x2a
function set_exposure_bank( a_ents, b_set )
{
    level clientfield::set( "set_exposure_bank", b_set );
}

