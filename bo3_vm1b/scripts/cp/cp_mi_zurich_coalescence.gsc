#using scripts/cp/_collectibles;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_coalescence_accolades;
#using scripts/cp/cp_mi_zurich_coalescence_clearing;
#using scripts/cp/cp_mi_zurich_coalescence_fx;
#using scripts/cp/cp_mi_zurich_coalescence_outro;
#using scripts/cp/cp_mi_zurich_coalescence_root_cairo;
#using scripts/cp/cp_mi_zurich_coalescence_root_cinematics;
#using scripts/cp/cp_mi_zurich_coalescence_root_singapore;
#using scripts/cp/cp_mi_zurich_coalescence_root_zurich;
#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_city;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_hq;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_plaza_battle;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_rails;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_sacrifice;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_server_room;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_street;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_zurich_coalescence;

// Namespace cp_mi_zurich_coalescence
// Params 0
// Checksum 0xf0b71cc2, Offset: 0xc08
// Size: 0x32
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace cp_mi_zurich_coalescence
// Params 0
// Checksum 0x7cc0e526, Offset: 0xc48
// Size: 0x1d2
function main()
{
    init_clientfields();
    setup_skiptos();
    init_level_vars();
    flag_init();
    level.var_75ba074a = 1;
    util::init_streamer_hints( 9 );
    cp_mi_zurich_coalescence_fx::main();
    cp_mi_zurich_coalescence_sound::main();
    root_cinematics::main();
    root_singapore::main();
    root_zurich::main();
    root_cairo::main();
    zurich_clearing::main();
    zurich_street::main();
    skipto::set_final_level();
    level.var_d086f08f = 1;
    collectibles::function_93523442( "p7_nc_zur_coa_01", 30, ( 0, 0, 10 ) );
    collectibles::function_93523442( "p7_nc_zur_coa_03", 60, ( -10, 0, -10 ) );
    collectibles::function_93523442( "p7_nc_zur_coa_04", 60, ( 0, 0, 10 ) );
    namespace_e9d9fb34::function_4d39a2af();
    level thread zurich_util::t_skipto_init();
    level thread zurich_util::function_be06d646();
    level thread zurich_util::function_91d852fa();
    level thread zurich_util::function_a7b5b565();
    load::main();
    level.oob_timelimit_ms = getdvarint( "oob_timelimit_ms", 3000 );
}

// Namespace cp_mi_zurich_coalescence
// Params 0
// Checksum 0x990112cd, Offset: 0xe28
// Size: 0xf2
function init_clientfields()
{
    clientfield::register( "world", "intro_ambience", 1, 1, "int" );
    clientfield::register( "world", "plaza_battle_amb_wasps", 1, 1, "int" );
    clientfield::register( "world", "hq_amb", 1, 1, "int" );
    clientfield::register( "world", "decon_spray", 1, 1, "int" );
    clientfield::register( "world", "clearing_hide_lotus_tower", 1, 1, "int" );
    clientfield::register( "world", "clearing_hide_ferris_wheel", 1, 1, "int" );
}

// Namespace cp_mi_zurich_coalescence
// Params 0
// Checksum 0xd4394be2, Offset: 0xf28
// Size: 0x612
function setup_skiptos()
{
    skipto::add( "zurich", &zurich_city::skipto_main, "Zurich", &zurich_city::skipto_done );
    skipto::add( "intro_igc", &zurich_city::function_9940e82f, "Intro IGC", &zurich_city::function_40b9b738 );
    skipto::add( "intro_pacing", &zurich_city::function_8fb45492, "Intro Pacing", &zurich_city::function_cf4ddc29 );
    skipto::function_d68e678e( "street", &zurich_street::skipto_main, "Don't Panic", &zurich_street::skipto_done );
    skipto::function_d68e678e( "garage", &zurich_street::function_568e2e07, "Don't Panic 2", &zurich_street::skipto_garage_done );
    skipto::function_d68e678e( "rails", &zurich_rails::skipto_main, "Off the Rails", &zurich_rails::skipto_done );
    skipto::function_d68e678e( "plaza_battle", &zurich_plaza_battle::skipto_main, "Coalescence Plaza", &zurich_plaza_battle::skipto_done );
    skipto::function_d68e678e( "hq", &zurich_hq::skipto_main, "HQ", &zurich_hq::skipto_done );
    skipto::function_d68e678e( "sacrifice", &zurich_sacrifice::skipto_main, "Sacrifice", &zurich_sacrifice::skipto_done );
    skipto::function_d68e678e( "server_room", &zurich_server_room::skipto_main, "Server Room", &zurich_server_room::skipto_done );
    skipto::add( "clearing_start", &zurich_clearing::skipto_start, "Clearing Start", &zurich_clearing::skipto_start_done );
    skipto::function_d68e678e( "clearing_waterfall", &zurich_clearing::skipto_waterfall, "Clearing Waterfall", &zurich_clearing::skipto_waterfall_done );
    skipto::function_d68e678e( "clearing_path_choice", &zurich_clearing::skipto_path_choice, "Clearing Path Choice", undefined );
    skipto::add( "clearing_hub", &zurich_clearing::function_1270c207, "Clearing Hub", &zurich_clearing::function_44c2b6a );
    skipto::function_d68e678e( "root_zurich_start", &root_zurich::skipto_main, "Zurich Root", undefined );
    skipto::function_d68e678e( "root_zurich_vortex", &root_zurich::function_95b88092, "Zurich Root Vortex", &root_zurich::skipto_done );
    skipto::function_d68e678e( "clearing_hub_2", &zurich_clearing::function_1270c207, "Clearing Hub", &zurich_clearing::function_600acf3f );
    skipto::function_d68e678e( "root_cairo_start", &root_cairo::skipto_main, "Cairo Root", undefined );
    skipto::function_d68e678e( "root_cairo_vortex", &root_cairo::function_95b88092, "Cairo Root Vortex", &root_cairo::skipto_done );
    skipto::function_d68e678e( "clearing_hub_3", &zurich_clearing::function_1270c207, "Clearing Hub", &zurich_clearing::function_b42e7a80 );
    skipto::function_d68e678e( "root_singapore_start", &root_singapore::skipto_main, "Singapore Root", &root_singapore::skipto_start_done );
    skipto::function_d68e678e( "root_singapore_vortex", &root_singapore::function_95b88092, "Singapore Root Vortex", &root_singapore::function_53a05865 );
    skipto::function_d68e678e( "outro_movie", &zurich_outro::function_8c381165, "Outro Movie", &zurich_outro::function_7c294f88 );
    skipto::add( "server_interior", &zurich_outro::function_618d5a98, "Server Interior", &zurich_outro::function_d9ccb9e3 );
    skipto::add( "zurich_outro", &zurich_outro::function_313f113, "Outro", &zurich_outro::function_f2f0f1ec );
}

// Namespace cp_mi_zurich_coalescence
// Params 0
// Checksum 0xa1d3a569, Offset: 0x1548
// Size: 0x1a
function init_level_vars()
{
    setdvar( "player_swimTime", 5000 );
}

// Namespace cp_mi_zurich_coalescence
// Params 0
// Checksum 0x7f91e0be, Offset: 0x1570
// Size: 0x302
function flag_init()
{
    level flag::init( "intro_squad_ready_move" );
    level flag::init( "flag_enable_zurich_ending" );
    level flag::init( "flag_start_zurich_outro" );
    level flag::init( "flag_enable_waterfall_vine_burn" );
    level flag::init( "flag_hq_security_room_clear" );
    level flag::init( "flag_hq_siege_bot_dead" );
    level flag::init( "flag_hq_security_room_move_upstairs" );
    level flag::init( "flag_hq_hack_door_open" );
    level flag::init( "flag_decon_door_open" );
    level flag::init( "flag_start_kane_sacrifice_igc" );
    level flag::init( "flag_move_kane_into_sacrifice_start" );
    level flag::init( "flag_clearing_start" );
    level flag::init( "flag_zurich_root_final_encounter_complete" );
    level flag::init( "flag_cairo_arena_complete" );
    level flag::init( "flag_start_elevator_siege_bot" );
    level flag::init( "flag_hq_move_kane_to_locker_room" );
    level flag::init( "flag_hq_move_to_airlock" );
    level flag::init( "flag_hall_sing_intro_vo_done" );
    level flag::init( "flag_diaz_first_path_complete_vo_done" );
    level flag::init( "flag_taylor_outro_vo_01" );
    level flag::init( "flag_taylor_outro_vo_02" );
    level flag::init( "flag_taylor_outro_vo_03" );
    level flag::init( "flag_salim_cognititve_neural_vo_done" );
    level flag::init( "flag_kane_sacrifice_door_closed" );
    level flag::init( "flag_start_kane_it_won_t_vo_done" );
    level flag::init( "flag_fill_purging_bar_40" );
    level flag::init( "flag_fill_purging_bar_60" );
    level flag::init( "flag_fill_purging_bar_80" );
    level flag::init( "flag_singapore_root_monologue_02_done" );
    level flag::init( "flag_singapore_root_monologue_04_done" );
    level flag::init( "flag_cairo_root_monologue_04_done" );
    level flag::init( "flag_monologue_zurich_root_04_done" );
}

