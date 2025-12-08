#using script_11d98532ca8f6c58;
#using script_20b8e1a789215df0;
#using script_268625b0934ee2ce;
#using script_279a5d4e51c06d1a;
#using script_34c07e36b76bab45;
#using script_3b7c3b99b28b21b7;
#using script_549b1f81e7dfe241;
#using script_6f92dbd09c4e8204;
#using script_708fc8496e63a128;
#using script_79e60fd0034306f4;
#using script_7e8d968512a21e26;
#using script_86ebb5dd573a003;
#using script_bd3bf54a93a5a3b;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp\cp_ger_stakeout_fx;
#using scripts\cp_common\devgui;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace cp_ger_stakeout;

// Namespace cp_ger_stakeout/level_init
// Params 1, eflags: 0x40
// Checksum 0x50799a41, Offset: 0x7a0
// Size: 0x13c
function event_handler[level_init] main( *eventstruct )
{
    function_bf4b4b7e();
    init_flags();
    init_spawnfunctions();
    init_clientfields();
    load::main();
    function_22b7fffd();
    init_callbacks();
    level thread objective_init();
    setdvar( #"compassmaxrange", "2100" );
    setdvar( #"r_motionblurstrength", 0.2 );
    setdvar( #"r_motionblurmode", 2 );
    level thread function_5fb77e0e();
    level.var_f4ed1999 = &namespace_11998b8f::function_d1c278ab;
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xac273f23, Offset: 0x8e8
// Size: 0x30c
function init_clientfields()
{
    clientfield::register( "toplayer", "force_stream_train", 1, 1, "int" );
    clientfield::register( "world", "force_stream_bar", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_chromatic_aberration", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_sprite_rain_loop", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_sprite_rain_ladder", 1, 1, "int" );
    clientfield::register( "toplayer", "pstfx_head_trauma", 1, 1, "counter" );
    clientfield::register( "toplayer", "lerp_fov", 1, 3, "int" );
    clientfield::register( "toplayer", "player_blacklight", 1, 1, "int" );
    clientfield::register( "toplayer", "knock_out_vision", 1, 1, "int" );
    clientfield::register( "scriptmover", "guard_room_light", 1, 1, "int" );
    clientfield::register( "scriptmover", "sewer_exit_flashlight_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "darkroom_light", 1, 1, "int" );
    clientfield::register( "scriptmover", "rooftop_spotlight", 1, 1, "int" );
    clientfield::register( "scriptmover", "render_emissive_blacklight_material", 1, 1, "int" );
    clientfield::register( "toplayer", "kraus_zoom_hint_start", 1, 1, "int" );
    serverfield::register( "kraus_zoom_hint_end", 1, 1, "int", &namespace_acaa3a2e::function_afc2d473 );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xa6231715, Offset: 0xc00
// Size: 0xc4
function function_22b7fffd()
{
    level thread namespace_a613430e::function_22b7fffd();
    level thread namespace_acaa3a2e::function_22b7fffd();
    level thread namespace_dd1bf157::function_22b7fffd();
    level thread namespace_afd0968c::function_22b7fffd();
    level thread namespace_e6b6aea1::function_22b7fffd();
    level thread cp_ger_stakeout_fx::function_22b7fffd();
    level thread namespace_11998b8f::function_dd4726f3();
    level thread namespace_11998b8f::function_54158bc();
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xdf47f9f0, Offset: 0xcd0
// Size: 0x7c4
function function_bf4b4b7e()
{
    skipto::function_eb91535d( "train", &namespace_4dd4b998::main, &namespace_4dd4b998::start, "Train", &namespace_4dd4b998::cleanup, "train" );
    skipto::function_eb91535d( "ghost_station", &namespace_a613430e::main, &namespace_a613430e::start, "Ghost Station", undefined, "tunnels" );
    skipto::function_eb91535d( "ghost_station_exit", &namespace_3aaa42f7::main, &namespace_3aaa42f7::start, "Ghost Station Exit", &namespace_3aaa42f7::cleanup, [ "tunnels", "vista" ] );
    skipto::function_eb91535d( "wall", &namespace_acaa3a2e::function_cca0368, &namespace_acaa3a2e::wall_start, "Berlin Wall", &namespace_acaa3a2e::function_f39fdd43, [ "tunnels", "vista", "streets", "alley" ] );
    skipto::function_eb91535d( "rooftop", &namespace_acaa3a2e::rooftop_main, &namespace_acaa3a2e::rooftop_start, "ID Kraus", &namespace_acaa3a2e::rooftop_cleanup, [ "tunnels", "vista", "streets", "alley" ] );
    skipto::function_eb91535d( "street", &namespace_dd1bf157::main, &namespace_dd1bf157::start, "Berlin Street", &namespace_dd1bf157::function_dc6107f7, [ "tunnels", "vista", "streets", "alley" ] );
    skipto::function_eb91535d( "bar", &namespace_dd1bf157::function_9145f67a, &namespace_dd1bf157::function_ae924b50, "Bar Meet", undefined, [ "tunnels", "vista", "streets", "alley" ] );
    skipto::function_eb91535d( "alley_1", &namespace_4dc9a074::function_b3837ddc, &namespace_4dc9a074::function_9de162de, "Back Alley 1", &namespace_4dc9a074::function_4f2cda6a, [ "tunnels", "vista", "streets", "alley" ] );
    skipto::function_eb91535d( "alley_2", &namespace_4dc9a074::function_34ee80b8, &namespace_4dc9a074::function_2d6c81be, "Back Alley 2", undefined, [ "streets", "alley", "apartment_street" ] );
    skipto::function_eb91535d( "alley_3", &namespace_4dc9a074::function_b4ae0031, &namespace_4dc9a074::function_8262abe1, "Back Alley 3", undefined, [ "streets", "alley", "apartment_street", "apartment" ] );
    skipto::function_eb91535d( "meetup", &namespace_afd0968c::main, &namespace_afd0968c::start, "Rendezvous", &namespace_afd0968c::function_7451d8da, [ "alley", "apartment_street", "apartment" ] );
    skipto::function_eb91535d( "apt_street", &namespace_fba81a7f::main, &namespace_fba81a7f::start, "Infiltrate Apartment", &namespace_fba81a7f::function_f62cf54d, [ "alley", "apartment_street", "apartment" ] );
    skipto::function_eb91535d( "apt_1", &namespace_e6b6aea1::function_b3837ddc, &namespace_e6b6aea1::function_9de162de, "Apartment Entry", &namespace_e6b6aea1::function_69c02b2b, [ "alley", "apartment_street", "apartment" ] );
    skipto::function_eb91535d( "apt_2", &namespace_e6b6aea1::function_34ee80b8, &namespace_e6b6aea1::function_2d6c81be, "Plant Tracking Device", &namespace_e6b6aea1::function_a3c49bc0, [ "alley", "apartment_street", "apartment", "warehouse" ] );
    skipto::function_eb91535d( "warehouse_intro", &namespace_f8073734::intro_main, &namespace_f8073734::intro_start, "Warehouse Intro", undefined, "warehouse" );
    skipto::function_eb91535d( "warehouse", &namespace_f8073734::main, &namespace_f8073734::start, "Warehouse", undefined, "warehouse" );
    skipto::function_eb91535d( "warehouse_outro", &namespace_f8073734::outro_main, &namespace_f8073734::outro_start, "Warehouse Outro", undefined, "warehouse" );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0x79be65ae, Offset: 0x14a0
// Size: 0x54
function init_flags()
{
    namespace_4dd4b998::init_flags();
    namespace_b4dbc583::init_flags();
    namespace_acaa3a2e::init_flags();
    namespace_dd1bf157::init_flags();
    namespace_f8073734::init_flags();
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0x935bdee, Offset: 0x1500
// Size: 0x64
function init_callbacks()
{
    callback::on_spawned( &function_4174e4e6 );
    callback::on_connect( &on_player_connect );
    callback::on_player_damage( &on_player_damage );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xdabc7d77, Offset: 0x1570
// Size: 0xbc
function on_player_connect()
{
    if ( isdefined( level.var_28c22d88 ) && array::contains( level.var_28c22d88, "train" ) || level.var_28c22d88.size == 0 )
    {
        util::function_f3cadc9a( "cp_ger_stakeout_train_ready" );
        
        if ( isdefined( level.var_d7d201ba ) && !self flag::exists( level.var_d7d201ba ) )
        {
            self flag::init( level.var_d7d201ba );
        }
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xf3eea6f0, Offset: 0x1638
// Size: 0x1dc
function function_4174e4e6()
{
    player = getplayers()[ 0 ];
    level.player = player;
    level thread function_76565f80();
    level thread function_bf14bffe();
    level thread function_356633ac();
    player setcharacterbodytype( 1 );
    player setcharacteroutfit( 5 );
    player util::function_a5318821();
    weapons = player getweaponslistprimaries();
    
    foreach ( weapon in weapons )
    {
        player takeweapon( weapon );
    }
    
    if ( skipto::function_fb89516e( "train" ) )
    {
        level flag::wait_till( "flag_post_train_weapons" );
    }
    
    namespace_11998b8f::function_cdb7cc7e();
    level util::delay( 1, undefined, &function_81fce913 );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 1
// Checksum 0x4c4f00b5, Offset: 0x1820
// Size: 0x44
function on_player_damage( params )
{
    if ( params.smeansofdeath === "MOD_MELEE_WEAPON_BUTT" )
    {
        self clientfield::increment_to_player( "pstfx_head_trauma" );
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xf84deeaa, Offset: 0x1870
// Size: 0x24
function init_spawnfunctions()
{
    namespace_4dc9a074::function_4bf845e0();
    namespace_fba81a7f::function_742bc3ab();
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xbcb90ff4, Offset: 0x18a0
// Size: 0x54
function function_76565f80()
{
    level flag::wait_till( "all_players_spawned" );
    getplayers()[ 0 ] clientfield::set_to_player( "pstfx_chromatic_aberration", 1 );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0x59b5b659, Offset: 0x1900
// Size: 0x19e
function function_bf14bffe()
{
    level flag::wait_till( "all_players_spawned" );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    setdvar( #"hash_7b06b8037c26b99b", 30 );
    
    while ( true )
    {
        var_1e8cb595 = bullettracepassed( player.origin, player.origin + ( 0, 0, 10000 ), 0, player );
        
        if ( var_1e8cb595 && !level flag::get( "player_in_rain" ) )
        {
            level flag::set( "player_in_rain" );
            player clientfield::set_to_player( "pstfx_sprite_rain_loop", 1 );
        }
        else if ( !var_1e8cb595 && level flag::get( "player_in_rain" ) )
        {
            level flag::clear( "player_in_rain" );
            player clientfield::set_to_player( "pstfx_sprite_rain_loop", 0 );
        }
        
        wait 3;
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xc84c38c7, Offset: 0x1aa8
// Size: 0x1cc
function function_356633ac()
{
    level flag::wait_till( "all_players_spawned" );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    t_rain_ladder = getent( "t_rain_ladder", "targetname" );
    
    while ( !level flag::get( "climbed_out_of_sewer" ) )
    {
        if ( player istouching( t_rain_ladder ) && !level flag::get( "player_on_ladder_rain" ) )
        {
            level flag::set( "player_on_ladder_rain" );
            player clientfield::set_to_player( "pstfx_sprite_rain_ladder", 1 );
        }
        else if ( !player istouching( t_rain_ladder ) && level flag::get( "player_on_ladder_rain" ) )
        {
            level flag::clear( "player_on_ladder_rain" );
            player clientfield::set_to_player( "pstfx_sprite_rain_ladder", 0 );
        }
        
        waitframe( 1 );
    }
    
    wait 3;
    player clientfield::set_to_player( "pstfx_sprite_rain_ladder", 0 );
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xcd90ad12, Offset: 0x1c80
// Size: 0x5c
function objective_init()
{
    level flag::wait_till( "game_start" );
    level thread obj_start();
    function_94602e66();
    function_68d3f62d();
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xee637c98, Offset: 0x1ce8
// Size: 0xe4
function obj_start()
{
    if ( !level flag::get( "identify_kraus_done" ) )
    {
        level flag::wait_till( "train_adler_ready" );
        objectives::scripted( "identify_kraus", undefined, #"hash_28a49531ff7ca7fb" );
        level flag::wait_till( "identify_kraus_done" );
        wait 1;
        objectives::complete( "identify_kraus" );
        
        if ( isdefined( objectives::function_285e460( "identify_kraus_pos" ) ) )
        {
            objectives::remove( "identify_kraus_pos" );
        }
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0x61c40fcc, Offset: 0x1dd8
// Size: 0xac
function function_94602e66()
{
    if ( !level flag::get( "at_street_overlook" ) )
    {
        level flag::wait_till( "player_jumped_off_train" );
        wait 1;
        objectives::follow( "obj_follow_adler", level.adler );
        level flag::wait_till( "at_street_overlook" );
        objectives::hide( "obj_follow_adler", level.adler );
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0x64ed42d3, Offset: 0x1e90
// Size: 0xfc
function function_68d3f62d()
{
    if ( !level flag::get( "street_done" ) )
    {
        level flag::wait_till( "street_begin" );
        wait 2;
        
        if ( !isdefined( objectives::function_285e460( "obj_follow_adler", level.adler ) ) )
        {
            objectives::follow( "obj_follow_adler", level.adler );
        }
        else
        {
            objectives::show( "obj_follow_adler", level.adler );
        }
        
        level flag::wait_till( "start_rooftop_descend_alley" );
        objectives::remove( "obj_follow_adler", level.adler );
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0xf965bbce, Offset: 0x1f98
// Size: 0x150
function function_81fce913()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    
    if ( level flag::get( "stop_supressed_hint" ) )
    {
        return;
    }
    
    var_3c5bb3db = 25000;
    level.var_614f0319 = 0;
    
    while ( !level flag::get( "stop_supressed_hint" ) )
    {
        waitframe( 1 );
        
        if ( function_8b935e3e( player ) )
        {
            player notify( #"using_suppressed_weapon" );
            continue;
        }
        
        current_time = gettime();
        time_diff = current_time - level.var_614f0319;
        
        if ( time_diff > var_3c5bb3db )
        {
            level.var_614f0319 = gettime();
            
            if ( !level flag::get( "stealth_spotted" ) )
            {
                player thread util::show_hint_text( #"hash_25cfdd1c1cc0294f", 0, "using_suppressed_weapon" );
            }
        }
    }
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 1
// Checksum 0x156f4d3a, Offset: 0x20f0
// Size: 0x1a0, Type: bool
function function_8b935e3e( player )
{
    var_1691b94e = getplayers()[ 0 ];
    
    if ( player function_8bc54983() || player getweaponslistprimaries().size == 0 || player scene::is_igc_active() )
    {
        return true;
    }
    
    var_44dc4109 = 0;
    var_bd1c473f = getweapon( #"hash_5dbab0bd6a78c6e5" );
    weapon = player getcurrentweapon();
    
    if ( weapon === level.weaponnone || weapon === level.var_fb71a7c4 || weapon === level.var_e3f5eafc || is_true( weapon.isgadget ) || weapon === var_bd1c473f )
    {
        return true;
    }
    
    if ( weaponhasattachment( weapon, "suppressed" ) )
    {
        var_44dc4109 = 1;
    }
    
    if ( level flag::get( "stealth_spotted" ) || var_44dc4109 )
    {
        return true;
    }
    
    return false;
}

// Namespace cp_ger_stakeout/cp_ger_stakeout
// Params 0
// Checksum 0x1084de33, Offset: 0x2298
// Size: 0x2f8
function function_5fb77e0e()
{
    level flag::wait_till( "all_players_spawned" );
    var_2d653b13 = getentarray( "tower01", "targetname" );
    var_64d129ee = getentarray( "tower02", "targetname" );
    var_7a965578 = getentarray( "tower03", "targetname" );
    
    foreach ( ent in var_64d129ee )
    {
        ent hide();
    }
    
    foreach ( ent in var_7a965578 )
    {
        ent hide();
    }
    
    level flag::wait_till( "flag_show_vista_tower_02" );
    array::delete_all( var_2d653b13 );
    
    foreach ( ent in var_64d129ee )
    {
        ent show();
    }
    
    level flag::wait_till( "flag_show_vista_tower_03" );
    array::delete_all( var_64d129ee );
    
    foreach ( ent in var_7a965578 )
    {
        ent show();
    }
}

