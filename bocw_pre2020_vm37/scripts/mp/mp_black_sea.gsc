#using script_67ce8e728d8f37ba;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\compass;
#using scripts\core_common\load_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace mp_black_sea;

// Namespace mp_black_sea/level_init
// Params 1, eflags: 0x40
// Checksum 0xbaaa8c07, Offset: 0x170
// Size: 0x19c
function event_handler[level_init] main( *eventstruct )
{
    callback::on_game_playing( &on_game_playing );
    callback::on_end_game( &on_end_game );
    callback::on_vehicle_spawned( &on_vehicle_spawned );
    namespace_66d6aa44::function_3f3466c9();
    killstreaks::function_257a5f13( "straferun", 40 );
    killstreaks::function_257a5f13( "helicopter_comlink", 75 );
    scene::function_497689f6( "cin_mp_blacksea_intro_cia", "helicopter", "tag_probe_cabin", "prb_tn_us_heli_lg_cabin" );
    scene::function_497689f6( "cin_mp_blacksea_intro_cia", "helicopter", "tag_probe_cockpit", "prb_tn_us_heli_lg_cockpit" );
    load::main();
    compass::setupminimap( "" );
    str_gametype = util::get_game_type();
    
    if ( str_gametype == "tdm" || str_gametype == "dom" )
    {
        hidemiscmodels( "zipline_flags" );
    }
}

// Namespace mp_black_sea/mp_black_sea
// Params 0
// Checksum 0x2812839e, Offset: 0x318
// Size: 0x2c
function on_game_playing()
{
    setdvar( #"hash_1a7932faa613bd0f", 1 );
}

// Namespace mp_black_sea/mp_black_sea
// Params 0
// Checksum 0x4a22029a, Offset: 0x350
// Size: 0x24
function on_end_game()
{
    setdvar( #"hash_1a7932faa613bd0f", 0 );
}

// Namespace mp_black_sea/mp_black_sea
// Params 0
// Checksum 0x9377b63f, Offset: 0x380
// Size: 0x4c
function on_vehicle_spawned()
{
    if ( isvehicle( self ) && is_true( self.break_glass ) )
    {
        self util::break_glass();
    }
}

