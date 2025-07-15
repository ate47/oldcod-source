#using scripts/codescripts/struct;
#using scripts/cp/_accolades;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_fx;
#using scripts/cp/cp_mi_cairo_infection_sgen_test_chamber;
#using scripts/cp/cp_mi_cairo_infection_sim_reality_starts;
#using scripts/cp/cp_mi_cairo_infection_sound;
#using scripts/cp/cp_mi_cairo_infection_theia_battle;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_infection;

// Namespace cp_mi_cairo_infection
// Params 0
// Checksum 0xa37183e1, Offset: 0x628
// Size: 0x32
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace cp_mi_cairo_infection
// Params 0
// Checksum 0xf721903d, Offset: 0x668
// Size: 0x131
function main()
{
    init_clientfields();
    setclearanceceiling( 111 );
    savegame::set_mission_name( "infection" );
    skipto_setup();
    util::init_streamer_hints( 11 );
    callback::on_spawned( &on_player_spawned );
    sarah_battle::main();
    sim_reality_starts::main();
    sgen_test_chamber::main();
    infection_accolades::function_66df416f();
    cp_mi_cairo_infection_fx::main();
    cp_mi_cairo_infection_sound::main();
    skipto::set_skip_safehouse();
    load::main();
    setdvar( "compassmaxrange", "2100" );
    InvalidOpCode( 0xc8, "strings", "war_callsign_a", &"MPUI_CALLSIGN_MAPNAME_A" );
    // Unknown operator ( 0xc8, t7, PC )
}

// Namespace cp_mi_cairo_infection
// Params 0
// Checksum 0xb500e7b0, Offset: 0x8c8
// Size: 0x2a
function init_clientfields()
{
    clientfield::register( "world", "set_exposure_bank", 1, 2, "int" );
}

// Namespace cp_mi_cairo_infection
// Params 0
// Checksum 0x4bc659f9, Offset: 0x900
// Size: 0xf9
function on_player_spawned()
{
    a_skiptos = skipto::get_current_skiptos();
    
    if ( isdefined( a_skiptos ) )
    {
        switch ( a_skiptos[ 0 ] )
        {
            case "vtol_arrival":
                self infection_util::player_enter_cinematic();
                break;
            case "sarah_battle":
                self util::set_lighting_state( 1 );
                self thread function_4fbaf6d6();
                break;
            case "sarah_battle_end":
                self util::set_lighting_state( 1 );
                break;
            case "sim_reality_starts":
                self thread reset_snow_fx_respawn();
                self infection_util::player_enter_cinematic();
                break;
            case "cyber_soliders_invest":
            case "sgen_test_chamber":
            case "time_lapse":
                self infection_util::player_enter_cinematic();
                break;
            default:
                break;
        }
    }
}

// Namespace cp_mi_cairo_infection
// Params 0
// Checksum 0xc635750c, Offset: 0xa08
// Size: 0x8a
function function_4fbaf6d6()
{
    level waittill( #"intial_battle_vo_done" );
    fx_origin = util::spawn_model( "tag_origin", self.origin, self.angles );
    playfxontag( level._effect[ "player_dirt_loop" ], fx_origin, "tag_origin" );
    fx_origin linkto( self );
    level waittill( #"sarah_battle_end" );
    fx_origin delete();
}

// Namespace cp_mi_cairo_infection
// Params 1
// Checksum 0x2cf70658, Offset: 0xaa0
// Size: 0x3a
function reset_snow_fx_respawn( n_id )
{
    self infection_util::snow_fx_stop();
    util::wait_network_frame();
    self infection_util::snow_fx_play( n_id );
}

// Namespace cp_mi_cairo_infection
// Params 0
// Checksum 0x6215956f, Offset: 0xae8
// Size: 0x212
function skipto_setup()
{
    skipto::add( "vtol_arrival", &sarah_battle::vtol_arrival_init, "VTOL ARRIVAL", &sarah_battle::vtol_arrival_done );
    skipto::add( "sarah_battle", &sarah_battle::sarah_battle_init, "SARAH BATTLE", &sarah_battle::sarah_battle_done );
    skipto::function_d68e678e( "sarah_battle_end", &sarah_battle::sarah_battle_end_init, "SARAH BATTLE END", &sarah_battle::sarah_battle_end_done );
    skipto::add( "sim_reality_starts", &sim_reality_starts::sim_reality_starts_init, "BIRTH OF THE AI", &sim_reality_starts::sim_reality_starts_done );
    skipto::function_d68e678e( "sgen_test_chamber", &sgen_test_chamber::sgen_test_chamber_init, "SGEN - 2060", &sgen_test_chamber::sgen_test_chamber_done );
    skipto::add( "time_lapse", &sgen_test_chamber::time_lapse_init, "SGEN - TIME LAPSE", &sgen_test_chamber::time_lapse_done );
    skipto::add( "cyber_soliders_invest", &sgen_test_chamber::cyber_soliders_invest_init, "SGEN - 2070", &sgen_test_chamber::cyber_soliders_invest_done );
    skipto::add_dev( "dev_skipto_infection_2", &skipto_infection_2 );
    skipto::add_dev( "dev_skipto_infection_3", &skipto_infection_3 );
}

// Namespace cp_mi_cairo_infection
// Params 2
// Checksum 0x4f0d0ec5, Offset: 0xd08
// Size: 0x42
function skipto_infection_2( str_objective, b_starting )
{
    switchmap_load( "cp_mi_cairo_infection2" );
    wait 0.05;
    switchmap_switch();
}

// Namespace cp_mi_cairo_infection
// Params 2
// Checksum 0x9f0f35cd, Offset: 0xd58
// Size: 0x42
function skipto_infection_3( str_objective, b_starting )
{
    switchmap_load( "cp_mi_cairo_infection3" );
    wait 0.05;
    switchmap_switch();
}

