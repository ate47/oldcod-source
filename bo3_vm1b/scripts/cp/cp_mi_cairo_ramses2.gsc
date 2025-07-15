#using scripts/codescripts/struct;
#using scripts/cp/_collectibles;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses2_fx;
#using scripts/cp/cp_mi_cairo_ramses2_sound;
#using scripts/cp/cp_mi_cairo_ramses_accolades;
#using scripts/cp/cp_mi_cairo_ramses_alley;
#using scripts/cp/cp_mi_cairo_ramses_arena_defend;
#using scripts/cp/cp_mi_cairo_ramses_quad_tank_plaza;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/cp_mi_cairo_ramses_vtol_igc;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_cairo_ramses2;

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0x5e388198, Offset: 0xcf8
// Size: 0x32
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0x60b79fc9, Offset: 0xd38
// Size: 0x30a
function main()
{
    if ( sessionmodeiscampaignzombiesgame() && 0 )
    {
        setclearanceceiling( 34 );
    }
    else
    {
        setclearanceceiling( 116 );
    }
    
    setailimit( 40 );
    savegame::set_mission_name( "ramses" );
    ramses_accolades::function_4d39a2af();
    ramses_accolades::function_43898266();
    ramses_accolades::function_e1862c87();
    ramses_accolades::function_6f52c808();
    ramses_accolades::function_7f657f7a();
    ramses_accolades::function_fec73937();
    ramses_accolades::function_a17fa88e();
    ramses_accolades::function_8e872dc8();
    util::init_streamer_hints( 5 );
    init_clientfields();
    init_flags();
    setup_skiptos();
    objectives::complete( "cp_level_ramses_determine_what_salim_knows" );
    objectives::complete( "cp_level_ramses_interrogate_salim" );
    objectives::complete( "cp_level_ramses_protect_salim" );
    objectives::complete( "cp_level_ramses_eastern_checkpoint" );
    objectives::set( "cp_level_ramses_demolish_arena_defend" );
    getent( "lgt_shadow_block_trans", "targetname" ) hide();
    ramses_util::function_1903e7dc();
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    callback::on_loadout( &on_player_loadout );
    callback::on_laststand( &on_player_last_stand );
    cp_mi_cairo_ramses2_fx::main();
    cp_mi_cairo_ramses2_sound::main();
    load::main();
    setdvar( "compassmaxrange", "12000" );
    setdvar( "scr_security_breach_lose_contact_distance", 36000 );
    setdvar( "scr_security_breach_lost_contact_distance", 72000 );
    
    /#
        execdevgui( "<dev string:x28>" );
    #/
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0x4f9ddbcc, Offset: 0x1050
// Size: 0x1ba
function init_clientfields()
{
    clientfield::register( "toplayer", "player_spike_plant_postfx", 1, 1, "counter" );
    clientfield::register( "world", "arena_defend_fxanim_hunters", 1, 1, "int" );
    clientfield::register( "world", "arena_defend_mobile_wall_damage", 1, 1, "int" );
    clientfield::register( "world", "alley_fxanim_hunters", 1, 1, "int" );
    clientfield::register( "world", "alley_fog_banks", 1, 1, "int" );
    clientfield::register( "world", "alley_fxanim_curtains", 1, 1, "int" );
    clientfield::register( "world", "vtol_igc_fxanim_hunter", 1, 1, "int" );
    clientfield::register( "world", "qt_plaza_fxanim_hunters", 1, 1, "int" );
    clientfield::register( "world", "theater_fxanim_swap", 1, 1, "int" );
    clientfield::register( "world", "qt_plaza_outro_exposure", 1, 1, "int" );
    clientfield::register( "world", "hide_statue_rubble", 1, 1, "int" );
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0xc8f5c626, Offset: 0x1218
// Size: 0x16a
function init_flags()
{
    level flag::init( "vtol_igc_trigger_used" );
    level flag::init( "intro_igc_done" );
    level flag::init( "dead_turret_stop_station_ambients" );
    level flag::init( "station_walk_cleanup" );
    level flag::init( "weak_points_objective_active" );
    level flag::init( "sinkhole_charges_detonated" );
    level flag::init( "arena_defend_sinkhole_outro" );
    level flag::init( "player_has_dead_control" );
    level flag::init( "start_vtol_robot_drop_1" );
    level flag::init( "start_vtol_robot_drop_2" );
    level flag::init( "vtol_igc_done" );
    level flag::init( "freeway_battle_cleared" );
    level flag::init( "flak_vtol_ride_stop" );
    level flag::init( "flak_arena_defend_stop" );
    level flag::init( "flak_alley_stop" );
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0xc833c6f8, Offset: 0x1390
// Size: 0x2e2
function setup_skiptos()
{
    skipto::function_d68e678e( "arena_defend_intro", &arena_defend::intro, "Arena Defend", &arena_defend::intro_done );
    skipto::add( "arena_defend", &arena_defend::main, "Arena Defend", &arena_defend::done );
    skipto::function_d68e678e( "sinkhole_collapse", &arena_defend::function_4451e1bd, "Sinkhole Collapse", &arena_defend::function_82a50f67 );
    skipto::add_dev( "dev_weak_point_test", &arena_defend::dev_weak_point_test, "Weak Point Test", &arena_defend::dev_weak_point_test, "", "" );
    skipto::add_dev( "dev_sinkhole_test", &arena_defend::dev_sinkhole_test, "Sinkhole Test", &arena_defend::dev_sinkhole_test_done, "", "alley" );
    skipto::function_d68e678e( "alley", &skipto_alley_init, "Alley", &skipto_alley_done );
    skipto::function_d68e678e( "vtol_igc", &skipto_vtol_igc_init, "VTOL IGC", &skipto_vtol_igc_done );
    skipto::function_d68e678e( "quad_tank_plaza", &skipto_quadtank_plaza_init, "Quad Tank Plaza", &skipto_quadtank_plaza_done );
    skipto::add_dev( "dev_statue_fall", &skipto_statue_fall_init, "Statue Fall Test", &skipto_statue_fall_done );
    skipto::add_dev( "dev_hacked_quadtank", &dev_hacked_quadtank_init, "Test Hacked Quadtank", &dev_hacked_quadtank_done );
    skipto::add_dev( "dev_qt_plaza_outro", &dev_qt_plaza_outro_init, "QT PLAZA OUTRO", &dev_qt_plaza_outro_done );
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0x28de1b6d, Offset: 0x1680
// Size: 0x32
function on_player_connect()
{
    self flag::init( "linked_to_truck" );
    self flag::init( "spike_launcher_tutorial_complete" );
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0x16e4b582, Offset: 0x16c0
// Size: 0x12
function on_player_spawned()
{
    self ramses_util::set_lighting_state_on_spawn();
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0x783a2f76, Offset: 0x16e0
// Size: 0x7a
function on_player_loadout()
{
    if ( level.skipto_point === "arena_defend_intro" || level.skipto_point === "arena_defend" || level.skipto_point == "sinkhole_collapse" || level.skipto_point === "dev_weak_point_test" || level.skipto_point === "dev_sinkhole_test" )
    {
        self ramses_util::give_spike_launcher( 1 );
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0x143df268, Offset: 0x1768
// Size: 0x13
function on_player_last_stand()
{
    self notify( #"last_stand_detonate" );
    self notify( #"stop_hero_weapon_hint" );
}

// Namespace cp_mi_cairo_ramses2
// Params 2
// Checksum 0xa9fb5a6d, Offset: 0x1788
// Size: 0x16a
function skipto_alley_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        hidemiscmodels( "alley_doors_open" );
        ramses_util::function_22e1a261();
        ramses_util::function_f2f98cfc();
        ramses_util::function_1aeb2873();
        level.ai_hendricks = util::get_hero( "hendricks" );
        skipto::teleport_ai( str_objective );
        load::function_a2995f22();
        level thread util::set_streamer_hint( 5 );
    }
    
    objectives::set( "cp_level_ramses_go_to_safiya" );
    
    if ( isdefined( level.var_1b3f87f7 ) )
    {
        level.var_1b3f87f7 delete();
    }
    
    ramses_util::function_7255e66( 1, "alley_mobile_armory" );
    level.ai_hendricks colors::enable();
    level.ai_hendricks colors::set_force_color( "o" );
    vtol_igc::hide_skipto_items();
    alley::alley_main();
}

// Namespace cp_mi_cairo_ramses2
// Params 4
// Checksum 0x2c39ecf0, Offset: 0x1900
// Size: 0x8a
function skipto_alley_done( str_objective, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        arena_defend::weak_points_fxanim_scenes_cleanup();
        level ramses_util::function_22e1a261();
    }
    
    ramses_util::function_7255e66( 0, "alley_mobile_armory" );
    setailimit( 35 );
    hidemiscmodels( "qtp_vtol_nose" );
}

// Namespace cp_mi_cairo_ramses2
// Params 2
// Checksum 0xa0b294bb, Offset: 0x1998
// Size: 0x192
function skipto_vtol_igc_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_hendricks colors::set_force_color( "o" );
        skipto::teleport_ai( str_objective );
        ramses_util::function_f2f98cfc();
        level scene::init( "cin_ram_06_05_safiya_1st_friendlydown_init" );
        level thread namespace_a6a248fc::function_6b994041();
        load::function_a2995f22();
    }
    
    if ( isdefined( level.streamer_vtol_igc ) )
    {
        level.streamer_vtol_igc delete();
    }
    
    callback::remove_on_loadout( &on_player_loadout );
    level.players ramses_util::take_spike_launcher();
    init_qt_plaza_fx_anims();
    init_qt_plaza_fx();
    level flag::set( "flak_alley_stop" );
    level thread alley::stop_hunter_crash_fx_anims();
    level thread quad_tank_plaza::dead_system_fx_anim();
    vtol_igc::hide_skipto_items();
    vtol_igc::vtol_igc_main( b_starting );
}

// Namespace cp_mi_cairo_ramses2
// Params 4
// Checksum 0xabe69724, Offset: 0x1b38
// Size: 0x7a
function skipto_vtol_igc_done( str_objective, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        objectives::complete( "cp_level_ramses_go_to_safiya" );
    }
    
    objectives::complete( "cp_level_ramses_vtol_use" );
    exploder::kill_exploder( "transition" );
    ramses_util::function_fb967724();
}

// Namespace cp_mi_cairo_ramses2
// Params 2
// Checksum 0xf42b2b13, Offset: 0x1bc0
// Size: 0x182
function skipto_quadtank_plaza_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        scene::add_scene_func( "cin_ram_06_05_safiya_1st_friendlydown", &function_7cfa94ff, "init" );
        scene::init( "cin_ram_06_05_safiya_1st_friendlydown" );
        level.ai_hendricks = util::get_hero( "hendricks" );
        skipto::teleport_ai( str_objective );
        battlechatter::function_d9f49fba( 0 );
        callback::remove_on_loadout( &on_player_loadout );
        level thread vtol_igc_skipto();
        load::function_a2995f22();
        level thread quad_tank_plaza::dead_system_fx_anim();
        quad_tank_plaza::pre_skipto();
        util::clientnotify( "pst" );
        init_qt_plaza_fx_anims();
        init_qt_plaza_fx();
    }
    else
    {
        battlechatter::function_d9f49fba( 1 );
    }
    
    vtol_igc::hide_skipto_items();
    quad_tank_plaza::quad_tank_plaza_main();
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0x31ddfc83, Offset: 0x1d50
// Size: 0x1ea
function vtol_igc_skipto()
{
    level thread quad_tank_plaza::ignore_players();
    level thread vtol_igc::hide_vtol_wings();
    scene::add_scene_func( "cin_ram_06_05_safiya_1st_friendlydown", &vtol_igc::function_e78f7ba0, "play" );
    scene::add_scene_func( "cin_ram_06_05_safiya_1st_friendlydown", &vtol_igc::vtol_igc_done, "done" );
    level thread vtol_igc::vtol_igc_notetracks( 1 );
    s_scene = struct::get( "truck_flip_vtol", "targetname" );
    s_scene thread scene::skipto_end();
    level waittill( #"level_is_go" );
    level thread vtol_igc::function_6ee65e7a();
    level util::screen_fade_out( 0, "black", "skipto_fade" );
    util::delay( 1.5, undefined, &util::screen_fade_in, 1, "black", "skipto_fade" );
    level scene::skipto_end( "cin_ram_06_05_safiya_1st_friendlydown", undefined, undefined, 0.88, 1 );
    battlechatter::function_d9f49fba( 1 );
    level flag::set( "vtol_igc_done" );
    exploder::exploder_stop( "fx_expl_qtplaza_hotel" );
    array::run_all( getentarray( "lgt_vtol_block", "targetname" ), &hide );
    util::clear_streamer_hint();
}

// Namespace cp_mi_cairo_ramses2
// Params 1
// Checksum 0x12f94d73, Offset: 0x1f48
// Size: 0xa2
function function_7cfa94ff( a_ents )
{
    var_2aa82b86 = a_ents[ "cin_ram_06_05_safiya_1st_friendlydown_vtol01" ];
    var_2aa82b86 vtol_igc::function_1e5c6903( 1, "" );
    var_2aa82b86 vtol_igc::function_1e5c6903( 1, "_d1" );
    var_2aa82b86 vtol_igc::function_1e5c6903( 0, "_d2" );
    level waittill( #"hash_6f5e60c5" );
    var_2aa82b86 hidepart( "tag_glass4_d2_animate" );
    var_2aa82b86 showpart( "tag_glass4_d3_animate" );
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0x6830e99, Offset: 0x1ff8
// Size: 0x1a
function init_qt_plaza_fx_anims()
{
    level scene::init( "p7_fxanim_cp_ramses_mobile_wall_explode_bundle" );
}

// Namespace cp_mi_cairo_ramses2
// Params 0
// Checksum 0x80082f1, Offset: 0x2020
// Size: 0x92
function init_qt_plaza_fx()
{
    exploder::exploder( "fx_expl_qtplaza_hotel" );
    exploder::exploder( "fx_expl_qtplaza_main" );
    exploder::exploder( "fx_expl_qtplaza_tracers" );
    exploder::exploder( "fx_expl_qtplaza_vista" );
    exploder::exploder( "ramses_vtol_down" );
    exploder::exploder( "LGT_theater" );
}

// Namespace cp_mi_cairo_ramses2
// Params 4
// Checksum 0xd8e1baa6, Offset: 0x20c0
// Size: 0x3a
function skipto_quadtank_plaza_done( str_objective, b_starting, b_direct, player )
{
    objectives::complete( "cp_level_ramses_destroy_quadtank" );
}

// Namespace cp_mi_cairo_ramses2
// Params 2
// Checksum 0x404be37, Offset: 0x2108
// Size: 0x3a
function skipto_statue_fall_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        vtol_igc::hide_skipto_items();
        quad_tank_plaza::statue_fall_test();
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 4
// Checksum 0x5ded0c40, Offset: 0x2150
// Size: 0x22
function skipto_statue_fall_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace cp_mi_cairo_ramses2
// Params 2
// Checksum 0x334693, Offset: 0x2180
// Size: 0x2a
function dev_hacked_quadtank_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        quad_tank_plaza::dev_hacked_quadtank_skipto();
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 4
// Checksum 0x958f5ae5, Offset: 0x21b8
// Size: 0x22
function dev_hacked_quadtank_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace cp_mi_cairo_ramses2
// Params 2
// Checksum 0x978f864e, Offset: 0x21e8
// Size: 0x15a
function dev_qt_plaza_outro_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        level ramses_util::set_lighting_state_time_shift_2();
        level.ai_hendricks = util::get_hero( "hendricks" );
        level.ai_khalil = util::get_hero( "khalil" );
        level flag::init( "qt_plaza_outro_igc_started" );
        level flag::init( "qt_plaza_statue_destroyed" );
        level flag::init( "qt_plaza_rocket_building_destroyed" );
        level flag::init( "qt_plaza_mobile_wall_destroyed" );
        quad_tank_plaza::init_outro_igc_shadow_cards();
        init_qt_plaza_fx();
        level scene::skipto_end( "p7_fxanim_cp_ramses_quadtank_plaza_building_rocket_bundle" );
        level scene::skipto_end( "p7_fxanim_cp_ramses_cinema_collapse_bundle" );
        exploder::exploder( "fx_expl_bldg_rocket" );
        level flag::wait_till( "all_players_spawned" );
        quad_tank_plaza::qt_plaza_outro( 1 );
    }
}

// Namespace cp_mi_cairo_ramses2
// Params 4
// Checksum 0x22ccd839, Offset: 0x2350
// Size: 0x22
function dev_qt_plaza_outro_done( str_objective, b_starting, b_direct, player )
{
    
}

