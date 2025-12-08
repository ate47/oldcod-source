#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;

#namespace namespace_5ceacc03;

// Namespace namespace_5ceacc03/level_preinit
// Params 1, eflags: 0x44
// Checksum 0x4dc51b9c, Offset: 0xf18
// Size: 0x2c
function private event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_5e69f468( &_objective );
}

// Namespace namespace_5ceacc03/event_cc819519
// Params 1, eflags: 0x44
// Checksum 0x6430ee3d, Offset: 0xf50
// Size: 0x2c
function private event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    snd::wait_init();
    snd::waitforplayers();
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 1, eflags: 0x4
// Checksum 0x8ea0736a, Offset: 0xf88
// Size: 0x7ea
function private _objective( objective )
{
    switch ( objective )
    {
        case #"train":
            break;
        case #"hash_b4bf1467425eafa":
            break;
        case #"ghost_station":
            music::setmusicstate( "2.0_tracks" );
            snd::client_msg( #"hash_5a65194efa8dcb0f" );
            level thread function_82df2d83();
            level thread function_47f39a4f();
            level thread function_46b43795();
            level thread function_f6a3d7df();
            level thread guard_room_train_occlusion();
            break;
        case #"ghost_station_exit":
            thread function_82df2d83();
            break;
        case #"wall":
            thread function_bb969e94();
            thread function_36cc557();
            thread function_c7ac1381();
            thread function_82df2d83();
            music::setmusicstate( "4.0_rooftops" );
            snd::client_msg( "wall_interior" );
            level flag::wait_till( "move_wall_allies_01a" );
            snd::client_msg( "rooftop_start" );
            break;
        case #"rooftop":
            thread function_82df2d83();
            thread function_bb969e94();
            thread function_36cc557();
            break;
        case #"street":
            thread function_82df2d83();
            thread function_bb969e94();
            thread function_36cc557();
            thread function_c7ac1381();
            level thread bar_ambience();
            level thread function_4e7aa055();
            level thread function_115e410e();
            level thread bar_ambience();
            level thread function_4e7aa055();
            snd::client_msg( "street" );
            break;
        case #"bar":
            break;
        case #"hash_7c9606c7fc0bc2c6":
            thread function_82df2d83();
            thread function_bb969e94();
            thread function_36cc557();
            thread function_c7ac1381();
            thread function_115e410e();
            snd::play( "temp_amb_bar_walla_lp", ( -1533, 9910, 124 ) );
            break;
        case #"hash_7c9605c7fc0bc113":
            thread function_bb969e94();
            thread function_36cc557();
            level thread music::setmusicstate( "9.0_informant_safehouse_2" );
            thread function_2082bda();
            thread function_13d3cf71();
            doors::waittill_door_opened( "alley_2_end_door" );
            thread function_2ef70099();
            break;
        case #"alley_3":
            thread function_bb969e94();
            thread function_36cc557();
            snd::play( "temp_amb_bar_walla_lp", ( -1533, 9910, 124 ) );
            thread function_2ef70099();
            break;
        case #"meetup":
            level thread music::setmusicstate( "9.0_informant_safehouse" );
            thread function_bb969e94();
            thread function_36cc557();
            break;
        case #"safehouse":
            thread function_bb969e94();
            thread function_36cc557();
            break;
        case #"surveillance":
            thread function_bb969e94();
            thread function_36cc557();
            break;
        case #"hash_e19b70cba8e2609":
            thread function_bb969e94();
            thread function_36cc557();
            break;
        case #"apt_street":
            level thread music::setmusicstate( "9.0_informant_safehouse" );
            thread function_bb969e94();
            thread function_36cc557();
            break;
        case #"hash_56aec447ca0e9aa1":
            thread function_36cc557();
            thread function_81b3f069();
            break;
        case #"hash_56aec147ca0e9588":
            time = 1;
            limit = 0.5;
            thread function_82df2d83();
            break;
        case #"hash_1abe628a9a90ff62":
            thread function_82df2d83();
            thread function_bb969e94();
            thread function_36cc557();
            thread function_c7ac1381();
            thread function_115e410e();
            thread function_32ee917f();
            break;
        case #"warehouse_intro":
            snd::client_msg( "warehouse_intro" );
            break;
        case #"warehouse":
            snd::client_msg( "warehouse" );
            break;
        case #"hash_48642c08eff0a94c":
            break;
        case #"no_game":
            break;
        default:
            /#
                snd::function_81fac19d( snd::function_d78e3644(), "<dev string:x38>" + objective + "<dev string:x5b>" );
            #/
            
            break;
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xade3b502, Offset: 0x1780
// Size: 0x3c
function function_d7739931()
{
    snd::client_msg( "stakeout_fade_in" );
    wait 2;
    snd::client_msg( "subway_ride_whooshes" );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xe3794896, Offset: 0x17c8
// Size: 0x84
function function_e40ab25f()
{
    level thread function_52bf5f3a();
    level thread function_a6b9fbbd();
    snd = snd::play( "vox_cp_stkt_02005_gmc1_wewillbearrivin_e4" );
    level flag::wait_till( "inside_train_car_02" );
    thread stop_pa_voice();
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x75ec5648, Offset: 0x1858
// Size: 0x34
function train_fade_up_from_black()
{
    snd::client_msg( "train_fade_up_from_black" );
    music::setmusicstate( "1.0_train" );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xc2f8641a, Offset: 0x1898
// Size: 0x784
function function_52bf5f3a()
{
    players = snd::function_da785aa8();
    player = players[ 0 ];
    fadeintime = snd::function_ea2f17d1( fadeintime, 2 );
    var_33a05373 = snd::play( "amb_train_int" );
    var_b9d9eec0 = snd::play( "evt_stk_ghost_station_train_int_clack_lp", ( -9007, 8608, -188 ) );
    var_c59c7b7c = snd::play( "evt_stk_train_int_vibrations_back_car_lp_01", ( -9720, 8608, -88 ) );
    var_dbd5a7ee = snd::play( "evt_stk_train_int_vibrations_back_car_lp_02", ( -8948, 8608, -88 ) );
    var_3aac46a9 = snd::play( "evt_stk_train_int_vibrations_rear_exit_lp", ( -8276, 8608, -88 ) );
    var_a248ed54 = snd::play( "stk_train_intro_window_wind_lp_01", ( -8738, 8668, -105 ) );
    var_847ab1b8 = snd::play( "stk_train_intro_window_wind_lp_02", ( -8618, 8667, -105 ) );
    var_46cb8d3d = snd::play( "stk_train_intro_window_wind_lp_01", ( -8616, 8547, -105 ) );
    var_c6c60d34 = snd::play( "stk_train_intro_window_wind_lp_02", ( -8495, 8548, -105 ) );
    var_36cd403b = snd::play( [ "amb_train_int_caboose_clacks_lp" ], ( -8283, 8610, -135 ) );
    wait fadeintime + 0.5;
    var_a206411d = 9;
    snd::set_volume( var_33a05373, snd::function_359f7bac( -7 ), var_a206411d );
    snd::set_volume( var_b9d9eec0, snd::function_359f7bac( -10 ), var_a206411d );
    level flag::wait_till( "inside_train_car_02" );
    wait 6;
    var_bd6dc22d = snd::play( [ 1, "stk_train_intro_slowdown_brakes" ], ( -8425, 8603, -122 ) );
    snd::set_pitch( var_33a05373, snd::function_d8b24901( -24 ), 20 );
    snd::set_pitch( var_b9d9eec0, snd::function_d8b24901( -4 ), 20 );
    snd::set_pitch( var_c59c7b7c, snd::function_d8b24901( -6 ), 20 );
    snd::set_pitch( var_dbd5a7ee, snd::function_d8b24901( -6 ), 20 );
    snd::set_pitch( var_3aac46a9, snd::function_d8b24901( -6 ), 20 );
    snd::set_pitch( var_a248ed54, snd::function_d8b24901( -6 ), 20 );
    snd::set_pitch( var_847ab1b8, snd::function_d8b24901( -6 ), 20 );
    snd::set_pitch( var_46cb8d3d, snd::function_d8b24901( -6 ), 20 );
    snd::set_pitch( var_c6c60d34, snd::function_d8b24901( -6 ), 20 );
    var_6f062276 = [ var_33a05373, var_b9d9eec0, var_c59c7b7c, var_dbd5a7ee, var_3aac46a9, var_a248ed54, var_847ab1b8, var_46cb8d3d, var_c6c60d34, var_bd6dc22d ];
    level flag::wait_till( "flag_prep_teleport_train_player" );
    wait 0.35;
    snd::stop( var_36cd403b, 0.1 );
    arrayremovevalue( var_6f062276, undefined );
    
    foreach ( snd in var_6f062276 )
    {
        if ( isdefined( snd ) )
        {
            snd linkto( player );
            snd dontinterpolate();
        }
    }
    
    level waittill( #"hash_19e230299ea7fcb3" );
    wait 1;
    arrayremovevalue( var_6f062276, undefined );
    
    foreach ( snd in var_6f062276 )
    {
        if ( isdefined( snd ) )
        {
            snd unlink();
            snd dontinterpolate();
        }
    }
    
    wait 1;
    fadeouttime = 2;
    arrayremovevalue( var_6f062276, undefined );
    snd::stop( var_6f062276, fadeouttime );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x75c3341, Offset: 0x2028
// Size: 0x1c
function stop_pa_voice()
{
    snd::client_msg( "stop_pa_voice" );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x2971bd3d, Offset: 0x2050
// Size: 0x194
function function_9c504c29()
{
    level waittill( #"player_train_teleport" );
    snd::client_msg( "stop_intro_whooshes" );
    players = snd::function_da785aa8();
    player = players[ 0 ];
    locs = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        locs[ i ] = player.origin + ( randomintrange( -3000, 0 ), randomintrange( -100, 100 ), 20 );
    }
    
    var_93408f70 = snd::play( "emt_train_end_cars_screech_lp", locs );
    
    foreach ( var_819cb54 in var_93408f70 )
    {
    }
    
    wait 5;
    snd::stop( var_93408f70, 0.5 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x122a8e57, Offset: 0x21f0
// Size: 0xf4
function function_a6b9fbbd()
{
    level waittill( #"subway_car_door_open_1" );
    snd::client_msg( "subway_car_door_open_1" );
    level waittill( #"subway_car_door_close_1" );
    snd::client_msg( "subway_car_door_close_1" );
    level waittill( #"subway_car_door_open_2" );
    snd::client_msg( "subway_car_door_open_2" );
    level waittill( #"duck_between_car_amb" );
    snd::client_msg( "duck_between_car_amb" );
    level waittill( #"subway_car_door_close_2" );
    snd::client_msg( "subway_car_door_close_2" );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xd803c1c6, Offset: 0x22f0
// Size: 0x4c
function function_78cda177()
{
    wait 4;
    snd::play( [ 0.05, "evt_stk_ghost_station_train_dist_approach" ], ( -6727, 10401, -316 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xe078fc, Offset: 0x2348
// Size: 0x174
function function_82df2d83()
{
    if ( is_true( level.var_6a6a7eab ) )
    {
        return;
    }
    
    level.var_6a6a7eab = 1;
    var_db275348 = snd::play( [ 0.05, "quad_stk_tunnel_int_front_lp" ] );
    var_230ba64a = snd::play( [ 0.05, "quad_stk_tunnel_int_rear_lp" ] );
    var_71996a42 = snd::play( [ 0.05, "quad_stk_tunnel_int_air_lp" ] );
    level flag::wait_till( "ghost_station_done" );
    wait 1;
    snd::stop( var_db275348, 2 );
    snd::stop( var_230ba64a, 2 );
    snd::stop( var_71996a42, 2 );
    wait 6;
    thread duck_ghost_station();
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xf437922d, Offset: 0x24c8
// Size: 0x1c
function guard_room_train_occlusion()
{
    snd::client_msg( "guard_room_train_occlusion" );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x2b936d72, Offset: 0x24f0
// Size: 0x1c
function duck_ghost_station()
{
    snd::client_msg( "duck_ghost_station" );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x2d983a3d, Offset: 0x2518
// Size: 0x80
function function_47f39a4f()
{
    level endon( #"ghost_station_done" );
    
    while ( true )
    {
        players = snd::function_da785aa8();
        player = players[ 0 ];
        player waittill( #"mantle_start" );
        snd::play( "fly_plr_stk_gs_platform_mantle" );
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x80f724d1, Offset: 0x25a0
// Size: 0x4
function function_46b43795()
{
    
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x7df38d0c, Offset: 0x25b0
// Size: 0xcc
function function_f6a3d7df()
{
    level flag::wait_till_any( array( "guard_station_doors_opened", "player_in_guard_room" ) );
    wait 1;
    var_981ab364 = snd::play( [ 0.1, "env_stk_gs_radio_static_lp", 1 ], ( -5750, 10945, -305 ) );
    level flag::wait_till( "ghost_station_done" );
    snd::stop( var_981ab364, 1 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x61aad4a4, Offset: 0x2688
// Size: 0x2c
function function_60ca00d0()
{
    snd::play( "env_stk_tunnel_metal_door_close", ( -6435, 11100, -285 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x7ba365e0, Offset: 0x26c0
// Size: 0x34
function function_dcaf7611()
{
    wait 0.35;
    snd::play( "foley_stk_gs_sts_enemy02_door_close", ( -6120, 10945, -305 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xcc61c0e8, Offset: 0x2700
// Size: 0x8c
function function_b2633ff9()
{
    level thread function_bb969e94();
    level thread function_36cc557();
    snd::client_msg( #"hash_63b7485b7ad71c1" );
    snd::play( "evt_stk_ghost_station_manhole_open" );
    wait 2;
    snd::play( "amb_thunder_rumble" );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x4cf98461, Offset: 0x2798
// Size: 0x144
function function_bb969e94()
{
    if ( is_true( level.var_5382cbbf ) )
    {
        return;
    }
    
    level.var_5382cbbf = 1;
    snd::emitter( "env_stk_tunnel_small_low_wind_gust", ( -7241, 11051, -294 ), [ 22, 24, 4, 8 ], 0, 0, 0 );
    snd::emitter( "amb_thunder_rumble", ( -2468, 61, 2660 ), [ 20, 74, 20, 74 ] );
    snd::emitter( "amb_thunder_rumble", ( 4403, 20731, 6896 ), [ 38, 74, 6, 11 ] );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x8e6b52e9, Offset: 0x28e8
// Size: 0xec
function function_36cc557()
{
    if ( is_true( level.var_430e3093 ) )
    {
        return;
    }
    
    level.var_430e3093 = 1;
    level.var_c40cc8e9 = snd::play( "emt_quad_nw_lp", ( -16384, 16384, 16384 ) );
    level.var_c1f93de6 = snd::play( "emt_quad_sw_lp", ( -16384, -16384, 16384 ) );
    level.var_528a660e = snd::play( "emt_quad_ne_lp", ( 16384, 16384, 16384 ) );
    level.var_27ba0aaa = snd::play( "emt_quad_se_lp", ( 16384, -16384, 16384 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x5b8a9539, Offset: 0x29e0
// Size: 0xdc
function function_c7ac1381()
{
    if ( is_true( level.var_c7ac1381 ) )
    {
        return;
    }
    
    level.var_c7ac1381 = 1;
    snd::play( "amb_alley_door_amb_lp", ( -4538.81, 10900.6, 64 ) );
    var_a403643d = snd::play( "amb_rain_window_med_int_01_wall", ( -4169, 11378, 339 ) );
    flag::wait_till( "fade_in_rooftop_door_amb" );
    snd::stop( var_a403643d, 1.5 );
    snd::client_msg( "door_to_rooftop_open" );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x1cfe93b2, Offset: 0x2ac8
// Size: 0x15e
function function_ddb87390()
{
    var_bc1e82a6 = snd::play( "env_rain_light_wood_door_int_lp_01", ( -4169, 11376, 365 ) );
    flag::wait_till( "fade_in_rooftop_door_amb" );
    wait 0.25;
    snd::stop( var_bc1e82a6, 2 );
    var_7ffe9874 = snd::play( [ "env_rain_light_splatty_lp_01", 1.5 ], ( -4159, 11496, 353 ) );
    var_baeca0e0 = snd::play( [ "env_rain_light_doorway_splatty", 1.5 ], ( -4172, 11422, 359 ) );
    var_ba4621a5 = snd::play( [ "env_rain_light_wood_partial_lp_01", 1.5 ], ( -4172, 11448, 363 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x6a436961, Offset: 0x2c30
// Size: 0x5c
function function_bc932ea6()
{
    wait 0.25;
    snd::play( "amb_stk_outdoor_transition_from_inside", ( -2623, 14247, 856 ) );
    snd::play( "amb_door_open_rain_city_thunder_3d", ( -2623, 14247, 856 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x880e5159, Offset: 0x2c98
// Size: 0x17c
function function_65f75e1d()
{
    loc = ( -3578, 10770, 237 );
    snd::play( "vox_cp_stkt_couple_01", loc );
    wait 1.5;
    snd::play( "vox_cp_stkt_couple_02", loc );
    wait 1.1;
    snd::play( "vox_cp_stkt_couple_03", loc );
    wait 1.3;
    snd::play( "vox_cp_stkt_couple_04", loc );
    wait 1.8;
    snd::play( "vox_cp_stkt_couple_05", loc );
    wait 3;
    snd::play( "vox_cp_stkt_couple_06", loc );
    wait 4.3;
    snd::play( "vox_cp_stkt_couple_07", loc );
    wait 7.4;
    snd::play( "vox_cp_stkt_couple_08", loc );
    wait 6.4;
    snd::play( "vox_cp_stkt_couple_09", loc );
    wait 4.75;
    snd::play( "vox_cp_stkt_couple_10", loc );
    wait 5.9;
    snd::play( "vox_cp_stkt_couple_11", loc );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x53b9dcc6, Offset: 0x2e20
// Size: 0x1c
function door_to_streets_open()
{
    snd::client_msg( "door_to_streets_open" );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xd705992f, Offset: 0x2e48
// Size: 0xcc
function function_115e410e()
{
    if ( is_true( level.var_115e410e ) )
    {
        return;
    }
    
    level.var_115e410e = 1;
    snd::play( "amb_alley_door_amb_lp", ( -1948, 9874, 88 ) );
    snd::play( "amb_alley_door_amb_lp", ( -1092, 10135, 88 ) );
    snd::play( "amb_rooftop_door_amb_lp", ( -1379, 9658, 90 ) );
    snd::play( "amb_alley_door_amb_lp", ( -737, 9870, 94 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x610f370b, Offset: 0x2f20
// Size: 0x4c
function bar_ambience()
{
    level flag::wait_till( "player_in_bar" );
    snd::play( "temp_amb_bar_walla_lp", ( -1533, 9910, 124 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x69fa6c52, Offset: 0x2f78
// Size: 0x64
function function_4e7aa055()
{
    level flag::wait_till( "flag_found_contact" );
    players = snd::function_da785aa8();
    player = players[ 0 ];
    player waittill( #"hash_52a4e28df0e31dc1" );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x9555618c, Offset: 0x2fe8
// Size: 0x1c
function function_d494f15()
{
    snd::play( "evt_anim_bar_wall_climb" );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x9bee5b26, Offset: 0x3010
// Size: 0xe4
function function_151612f4()
{
    snd::client_msg( "alley_2_start" );
    snd::play( "evt_police_intro", ( -927, 8304, 143 ) );
    snd::play( "evt_police_intro_lp_01", ( -933, 8326, 93 ) );
    snd::play( "evt_police_intro_lp_02", ( -877, 8111, 92 ) );
    snd::play( "evt_police_intro_lp_03", ( -1239, 8148, 81 ) );
    snd::play( "evt_police_intro_lp_02", ( -621, 8933, 110 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xa0bffcbf, Offset: 0x3100
// Size: 0x54
function function_32ee917f()
{
    snd::play( "amb_alley_door_amb_lp", ( -601, 9604, 91 ) );
    snd::play( "amb_rooftop_door_amb_lp", ( -281, 9646, 91 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x558a2207, Offset: 0x3160
// Size: 0x6c
function function_2082bda()
{
    level waittill( #"hash_4d47fbbad11fa020" );
    snd::play( "evt_stasi_harass_door", ( 117, 8576, 127 ) );
    snd::play( "evt_stasi_harass_guard", ( 117, 8576, 127 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x17955f3c, Offset: 0x31d8
// Size: 0x44
function function_13d3cf71()
{
    level waittill( #"hash_4d47febad11fa539" );
    snd::play( "evt_stasi_harass_guard2", ( -1870, 7454, 95 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x77b496d, Offset: 0x3228
// Size: 0xac
function function_2ef70099()
{
    if ( is_true( level.var_2ef70099 ) )
    {
        return;
    }
    
    level.var_2ef70099 = 1;
    baby = snd::play( "env_baby_crying", ( -666, 6724, 89 ) );
    thread function_d75cd506();
    level waittill( #"flag_go_in_store" );
    snd::stop( baby, 0.25 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xe9a0f385, Offset: 0x32e0
// Size: 0x25c
function function_d75cd506()
{
    thread function_42f00d4b();
    loc = ( -945, 6646, 255 );
    level endon( #"flag_go_in_store" );
    snd::play( "env_stasi_knocking_03", loc );
    wait 2.8;
    snd::play( "env_stasi_knocking_01", loc );
    wait 1;
    snd::play( "vox_cp_stkt_stasi_01", loc );
    wait 1.8;
    snd::play( "env_stasi_knocking_02", loc );
    wait 0.85;
    snd::play( "vox_cp_stkt_stasi_02", loc );
    wait 1.75;
    snd::play( "env_stasi_knocking_04", loc );
    wait 0.95;
    snd::play( "env_door_open_muffled", loc );
    wait 1;
    snd::play( "vox_cp_stkt_stasi_03", loc );
    wait 3.6;
    snd::play( "vox_cp_stkt_stasi_04", loc );
    wait 2.55;
    snd::play( "vox_cp_stkt_stasi_05", loc );
    wait 2.95;
    snd::play( "vox_cp_stkt_stasi_06", loc );
    wait 4.4;
    snd::play( "vox_cp_stkt_stasi_07", loc );
    wait 5;
    snd::play( "vox_cp_stkt_stasi_08", loc );
    wait 3.85;
    snd::play( "vox_cp_stkt_stasi_09", loc );
    wait 2.3;
    snd::play( "vox_cp_stkt_stasi_10", loc );
    wait 2.8;
    snd::play( "vox_cp_stkt_stasi_11", loc );
    wait 2.1;
    snd::play( "vox_cp_stkt_stasi_12", loc );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xb6a3f3ba, Offset: 0x3548
// Size: 0xf8
function function_42f00d4b()
{
    level endon( #"flag_go_in_store" );
    loc = ( -581, 6864, 281 );
    aliases = [ "env_stasi_walking_upstairs_01", "env_stasi_walking_upstairs_02", "env_stasi_walking_upstairs_03" ];
    exploder::exploder( "fx_exp_slice_dust" );
    wait 2;
    
    while ( true )
    {
        alias = get_random_array_element_no_repeat( aliases, "stasi_boots", 2 );
        snd::play( alias, loc );
        wait randomintrange( 6, 9 );
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x4f05e629, Offset: 0x3648
// Size: 0xb4
function function_7e88a33b()
{
    wait 2;
    snd::play( [ 0.5, "env_rain_light_doorway_splatty", 0.5 ], ( -76, 6532, 50 ) );
    snd::play( [ 0.5, "amb_rain_door_outside_lp", 0.5 ], ( -77, 6565, 50 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 1
// Checksum 0x520e49a8, Offset: 0x3708
// Size: 0x1c2
function function_81b3f069( volume )
{
    level endon( #"hash_205bf17f449d4088" );
    phone = getent( "apt_phone", "targetname" );
    thread function_db3e2ed5( phone );
    level.var_b159d30f = 0;
    level.var_2a973211 = 0.501;
    
    if ( isdefined( volume ) )
    {
        level.var_2a973211 = volume;
    }
    
    while ( !level flag::get( "flag_phone_receiver_picked_up" ) )
    {
        level.var_b159d30f = 1;
        level.var_9d6e61f8 = snd::play( [ 0.05, "evt_stk_apt_phone_ring_lp" ], phone );
        snd::set_volume( level.var_9d6e61f8, level.var_2a973211 );
        wait 2;
        level.var_1e5c72de = snd::play( [ 0.05, "evt_stk_apt_phone_ring_end" ], phone );
        snd::set_volume( level.var_9d6e61f8, level.var_2a973211 );
        snd::stop( level.var_9d6e61f8, 0.05 );
        level.var_b159d30f = 0;
        wait 3;
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 1
// Checksum 0xea62b7a9, Offset: 0x38d8
// Size: 0x16c
function function_db3e2ed5( phone )
{
    level flag::wait_till_any( array( "flag_apartment_door_open", "flag_1st_entry_kitchen" ) );
    level.var_2a973211 = 1;
    
    if ( isdefined( level.var_9d6e61f8 ) )
    {
        snd::set_volume( level.var_9d6e61f8, level.var_2a973211, 1.5 );
    }
    
    if ( isdefined( level.var_1e5c72de ) )
    {
        snd::set_volume( level.var_1e5c72de, level.var_2a973211 );
    }
    
    level waittill( #"hash_205bf17f449d4088" );
    level flag::set( "flag_phone_receiver_picked_up" );
    
    if ( isdefined( level.var_9d6e61f8 ) && level.var_b159d30f == 1 )
    {
        snd::play( "evt_stk_apt_phone_ring_end", phone );
        snd::stop( level.var_9d6e61f8, 0.05 );
        snd::stop( level.var_1e5c72de, 0.05 );
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xc06ec525, Offset: 0x3a50
// Size: 0x2c
function function_c32bc34f()
{
    snd::play( "evt_vent_open", ( 1891, 4075, 190 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x3e853e4d, Offset: 0x3a88
// Size: 0x2c
function bedroom_drawer()
{
    snd::play( "evt_drawer_open", ( 1758, 4182, 363 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x98cc59bc, Offset: 0x3ac0
// Size: 0x2c
function function_a3c35c97()
{
    snd::play( "evt_metal_drawer_open", ( 1576, 4205, 367 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 2
// Checksum 0x6cd39529, Offset: 0x3af8
// Size: 0xec
function function_4cab7b22( var_a35b31a, time )
{
    thread function_e5ae45dd( time, var_a35b31a );
    waittime = 1;
    waited = 0;
    
    while ( waited < time )
    {
        snd::play( "evt_dark_room_mechanism_timer", var_a35b31a.origin );
        wait waittime;
        waited += waittime;
        
        if ( waittime > 0.5 )
        {
            waittime -= 0.1;
        }
        
        if ( level flag::get( "darkroom_door_open" ) )
        {
            return;
        }
    }
    
    snd::play( "evt_dark_room_mechanism_timer_fail", var_a35b31a.origin );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 2
// Checksum 0x7c9f6e1e, Offset: 0x3bf0
// Size: 0x84
function function_e5ae45dd( time, obj )
{
    level flag::wait_till_timeout( time, "darkroom_door_open" );
    
    if ( level flag::get( "darkroom_door_open" ) )
    {
        if ( obj.targetname == "darkroom_door_interact_button" )
        {
            snd::play( "evt_dark_room_door_unlock", obj );
        }
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0xc484f676, Offset: 0x3c80
// Size: 0x9c
function function_1a80eca8()
{
    wait 1;
    radio = snd::play( "evt_listening_device_tuning_lp_3d", [ level.park, "j_head" ] );
    wait 2;
    radio snd::set_volume( 0.5, 3 );
    wait 12;
    snd::stop( radio, 4 );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 1
// Checksum 0x5b4acfcc, Offset: 0x3d28
// Size: 0x90
function function_af3d3d18( victims )
{
    foreach ( victim in victims )
    {
        victim thread function_18b6b926();
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x9635ecb4, Offset: 0x3dc0
// Size: 0xec
function function_18b6b926()
{
    self waittill( #"death" );
    result = self waittilltimeout( 2, #"start_burning" );
    
    if ( result._notify === "start_burning" )
    {
        aliases = [ "vox_burning_scream_01", "vox_burning_scream_02", "vox_burning_scream_03", "vox_burning_scream_04" ];
        alias = get_random_array_element_no_repeat( aliases, "burn_victim", 3 );
        snd::play( alias, self );
    }
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 0
// Checksum 0x380ba7b, Offset: 0x3eb8
// Size: 0x5c
function function_875a6922()
{
    snd::play( "evt_toilet_flush", ( 9067, -13856, 108 ) );
    wait 1;
    snd::play( "evt_door_kick_open", ( 9229, -13811, 102 ) );
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 3
// Checksum 0x9004de62, Offset: 0x3f20
// Size: 0x1a4
function get_random_array_element_no_repeat( array, label, var_7602d509 = 2 )
{
    if ( !isdefined( level._audio_random_array_dict ) )
    {
        level._audio_random_array_dict = [];
    }
    
    if ( !isdefined( level._audio_random_array_dict[ label ] ) )
    {
        level._audio_random_array_dict[ label ] = array::randomize( getarraykeys( array ) );
    }
    
    if ( level._audio_random_array_dict[ label ].size <= var_7602d509 )
    {
        remaining = array_remove_array( getarraykeys( array ), level._audio_random_array_dict[ label ] );
        new_list = array::randomize( remaining );
        level._audio_random_array_dict[ label ] = arraycombine( new_list, level._audio_random_array_dict[ label ] );
    }
    
    value = level._audio_random_array_dict[ label ][ level._audio_random_array_dict[ label ].size - 1 ];
    level._audio_random_array_dict[ label ][ level._audio_random_array_dict[ label ].size - 1 ] = undefined;
    return array[ value ];
}

// Namespace namespace_5ceacc03/namespace_5ceacc03
// Params 2
// Checksum 0xa4fb357e, Offset: 0x40d0
// Size: 0x9c
function array_remove_array( ents, remover_array )
{
    foreach ( remover in remover_array )
    {
        arrayremovevalue( ents, remover );
    }
    
    return ents;
}

