#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_fx;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_church;
#using scripts/cp/cp_mi_cairo_infection_forest;
#using scripts/cp/cp_mi_cairo_infection_forest_surreal;
#using scripts/cp/cp_mi_cairo_infection_foy_turret;
#using scripts/cp/cp_mi_cairo_infection_murders;
#using scripts/cp/cp_mi_cairo_infection_sgen_server_room;
#using scripts/cp/cp_mi_cairo_infection_tiger_tank;
#using scripts/cp/cp_mi_cairo_infection_underwater;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_village;
#using scripts/cp/cp_mi_cairo_infection_village_surreal;
#using scripts/cp/gametypes/_save;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_cairo_infection2;

// Namespace cp_mi_cairo_infection2
// Params 0
// Checksum 0xd8e65d6c, Offset: 0x888
// Size: 0x32
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace cp_mi_cairo_infection2
// Params 0
// Checksum 0xca5a20fd, Offset: 0x8c8
// Size: 0x1a1
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
    
    savegame::set_mission_name( "infection" );
    util::init_streamer_hints( 11 );
    skipto_setup();
    callback::on_spawned( &on_player_spawned );
    init_clientfields();
    sgen_server_room::main();
    blackstation_murders::main();
    underwater::main();
    church::init_client_field_callback_funcs();
    forest::init_client_field_callback_funcs();
    village::init_client_field_callback_funcs();
    village_surreal::init_client_field_callback_funcs();
    infection_util::setup_anim_callbacks();
    infection_accolades::function_66df416f();
    cp_mi_cairo_infection2_sound::main();
    skipto::set_skip_safehouse();
    load::main();
    setdvar( "compassmaxrange", "2100" );
    InvalidOpCode( 0xc8, "strings", "war_callsign_a", &"MPUI_CALLSIGN_MAPNAME_A" );
    // Unknown operator ( 0xc8, t7, PC )
}

// Namespace cp_mi_cairo_infection2
// Params 0
// Checksum 0x9161fa6f, Offset: 0xbd8
// Size: 0x52
function init_clientfields()
{
    clientfield::register( "world", "cathedral_water_state", 1, 1, "int" );
    clientfield::register( "world", "set_exposure_bank", 1, 2, "int" );
}

// Namespace cp_mi_cairo_infection2
// Params 0
// Checksum 0x591d074f, Offset: 0xc38
// Size: 0x201
function on_player_spawned()
{
    a_skiptos = skipto::get_current_skiptos();
    
    if ( isdefined( a_skiptos ) )
    {
        switch ( a_skiptos[ 0 ] )
        {
            case "sgen_server_room":
                infection_util::function_4f66eed6();
                self infection_util::player_enter_cinematic();
                break;
            case "forest_intro":
                infection_util::function_4f66eed6();
                self thread reset_snow_fx_respawn();
                break;
            case "forest":
                infection_util::function_4f66eed6();
                self thread reset_snow_fx_respawn();
                break;
            case "forest_surreal":
                infection_util::function_4f66eed6();
                break;
            case "forest_wolves":
                infection_util::function_4f66eed6();
                break;
            case "forest_sky_bridge":
                infection_util::function_4f66eed6();
                break;
            case "forest_tunnel":
                infection_util::function_4f66eed6();
                break;
            case "black_station":
                infection_util::function_4f66eed6();
                break;
            case "village":
                infection_util::function_4f66eed6();
                self thread reset_snow_fx_respawn();
                break;
            case "village_inception":
                self thread reset_snow_fx_respawn( 3 );
                break;
            case "church":
                infection_util::function_4f66eed6();
                self infection_util::player_enter_cinematic();
                break;
            case "cathedral":
                infection_util::function_4f66eed6();
                break;
            case "underwater":
                infection_util::function_4f66eed6();
                break;
            case "dev_cathedral_outro":
                infection_util::function_4f66eed6();
                break;
            case "dev_black_station_intro":
                infection_util::function_4f66eed6();
                break;
            default:
                break;
        }
    }
}

// Namespace cp_mi_cairo_infection2
// Params 1
// Checksum 0x74142bc5, Offset: 0xe48
// Size: 0x3a
function reset_snow_fx_respawn( n_id )
{
    self infection_util::snow_fx_stop();
    util::wait_network_frame();
    self infection_util::snow_fx_play( n_id );
}

// Namespace cp_mi_cairo_infection2
// Params 0
// Checksum 0xd5f40f00, Offset: 0xe90
// Size: 0x3ea
function skipto_setup()
{
    skipto::add( "sgen_server_room", &sgen_server_room::sgen_server_room_init, "SGEN - SERVER ROOM", &sgen_server_room::sgen_server_room_done );
    skipto::function_d68e678e( "forest_intro", &forest::intro_main, "BASTOGNE INTRO", &forest::intro_cleanup );
    skipto::add( "forest", &forest::forest_main, "BASTOGNE", &forest::cleanup );
    skipto::function_d68e678e( "forest_surreal", &forest_surreal::main, "WORLD FALLS AWAY", &forest_surreal::cleanup );
    skipto::function_d68e678e( "forest_wolves", &forest_surreal::forest_wolves, "FOREST WOLVES", &forest_surreal::forest_wolves_cleanup );
    skipto::add( "forest_sky_bridge", &forest_surreal::forest_sky_bridge, "FOREST SKY BRIDGE", &forest_surreal::function_dd270bfd );
    skipto::add( "forest_tunnel", &forest_surreal::forest_tunnel, "FOREST TUNNEL", &forest_surreal::function_de606506 );
    skipto::add_dev( "dev_black_station_intro", &forest_surreal::dev_black_station_intro, "DEV: BLACK STATION INTRO", &forest_surreal::dev_black_station_cleanup );
    skipto::function_d68e678e( "black_station", &blackstation_murders::murders_main, "BLACK STATION", &blackstation_murders::cleanup );
    skipto::function_d68e678e( "village", &village::main, "FOY", &village::cleanup );
    skipto::function_d68e678e( "village_inception", &village_surreal::main, "FOLD", &village_surreal::cleanup );
    skipto::function_d68e678e( "church", &church::main_church, "CHURCH", &church::cleanup_church );
    skipto::add( "cathedral", &church::main_cathedral, "CATHEDRAL", &church::cleanup_cathedral );
    skipto::add_dev( "dev_cathedral_outro", &church::dev_cathedral_outro, "CATHEDRAL", &church::dev_cathedral_outro_cleanup );
    skipto::function_d68e678e( "underwater", &underwater::underwater_main, "UNDERWATER", &underwater::underwater_cleanup );
    skipto::add_dev( "dev_skipto_infection_3", &skipto_infection_3 );
}

// Namespace cp_mi_cairo_infection2
// Params 2
// Checksum 0x92d889d0, Offset: 0x1288
// Size: 0x42
function skipto_infection_3( str_objective, b_starting )
{
    switchmap_load( "cp_mi_cairo_infection3" );
    wait 0.05;
    switchmap_switch();
}

