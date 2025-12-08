#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;

#namespace namespace_b6fe1dbe;

// Namespace namespace_b6fe1dbe/level_preinit
// Params 1, eflags: 0x44
// Checksum 0x24240248, Offset: 0x1528
// Size: 0x3c
function private event_handler[level_preinit] function_b489bb7b( *eventstruct )
{
    snd::function_5e69f468( &_objective );
    snd::wait_init();
}

// Namespace namespace_b6fe1dbe/event_cc819519
// Params 1, eflags: 0x40
// Checksum 0x7b8f9c09, Offset: 0x1570
// Size: 0x3c
function event_handler[event_cc819519] function_686b88aa( *eventstruct )
{
    thread function_fe07a1d4();
    thread function_cb7fb7e7();
    thread global_submix();
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xac07caf7, Offset: 0x15b8
// Size: 0x2c
function global_submix()
{
    snd::waitforplayers();
    snd::client_msg( "global_submix" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1, eflags: 0x4
// Checksum 0xc8d3b7b2, Offset: 0x15f0
// Size: 0x9a
function private _objective( objective )
{
    switch ( objective )
    {
        case #"hash_65e6eae762f128ac":
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

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 2
// Checksum 0xb9eb7ad4, Offset: 0x1698
// Size: 0x3c
function music( str_msg, n_delay = 0 )
{
    level thread function_7edafa59( str_msg, n_delay );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 2
// Checksum 0x58680778, Offset: 0x16e0
// Size: 0x7ba
function function_7edafa59( str_msg, n_delay )
{
    if ( !isdefined( level.var_41fc1341 ) )
    {
        level.var_41fc1341 = "";
    }
    
    if ( !isdefined( level.var_2c9b406b ) )
    {
        level.var_2c9b406b = "";
    }
    
    if ( level.var_41fc1341 != str_msg )
    {
        level.var_2c9b406b = level.var_41fc1341;
    }
    
    level.var_41fc1341 = str_msg;
    
    switch ( str_msg )
    {
        case #"hash_362faeba3d857051":
        case #"hash_80d6e8de9a9b724":
        case #"hash_50c83da96c91915f":
        case #"hash_9717b8dda46a53a":
        case #"hash_fa148e8ff49700b":
        case #"11.0_lab":
        case #"hash_434ffcd66b6b2766":
        case #"8.0_ruin_2":
        case #"hash_14551414b13cbe8f":
        case #"6.0_reset_1":
        case #"9.0_zombies":
        case #"hash_1d1e507e9e90544e":
        case #"1.0_intro":
        case #"13.0_paddy_3":
        case #"12.0_reset_2":
        case #"hash_569fd9d5a21b5d1e":
        case #"17.0_door_3":
        case #"2.0_paddy_1":
        case #"hash_61febcbde8b3db9b":
        case #"14.0_ruin_3":
        case #"3.0_ruins_1":
        case #"20.0_reset_3":
        case #"7.0_paddy_2":
            music::setmusicstate( str_msg, undefined, n_delay );
            break;
        case #"hash_20f2cf8ecfe3ec4f":
            music::function_2af5f0ec( str_msg );
            break;
        case #"11.3_window_stinger_3":
        case #"11.2_window_stinger_2":
        case #"11.1_window_stinger_1":
            music::function_edda155f( str_msg, n_delay );
            break;
        case #"deactivate_3.0_ruins_1":
            music::setmusicstate( "none", undefined, n_delay );
            break;
        case #"intro_movie":
            music::setmusicstate( "intro_movie" );
            break;
        case #"black_sequence":
            music::function_edda155f( "black_sequence" );
            break;
        case #"rice_paddies_start":
            music::setmusicstate( "rice_paddies_start" );
            break;
        case #"rice_paddies_battle_end":
            music::setmusicstate( "rice_paddies_battle_end" );
            break;
        case #"waterfall_path_start":
            music::setmusicstate( "waterfall_path_start" );
            break;
        case #"caves_entering":
            music::setmusicstate( "caves_entering" );
            break;
        case #"tunnel_part1_eerie":
            music::setmusicstate( "tunnel_part1_eerie" );
            break;
        case #"movie_flashback_01":
            music::setmusicstate( "movie_flashback_01" );
            break;
        case #"rice_paddies_part2_bow_start":
            music::setmusicstate( "rice_paddies_part2_bow_start" );
            break;
        case #"rice_paddies_part2_bow_end":
            music::setmusicstate( "rice_paddies_part2_bow_end" );
            break;
        case #"jungle_path_part2":
            music::setmusicstate( "jungle_path_part2" );
            break;
        case #"village_combat_enter":
            music::setmusicstate( "village_combat_enter" );
            break;
        case #"village_combat_exit":
            music::setmusicstate( "village_combat_exit" );
            break;
        case #"tunnel_part2_eerie":
            music::setmusicstate( "tunnel_part2_eerie" );
            break;
        case #"tunnel_part2_flashback_start":
            music::setmusicstate( "tunnel_part2_flashback_start" );
            break;
        case #"tunnel_part2_flashback_end":
            music::setmusicstate( "tunnel_part2_flashback_end" );
            break;
        case #"rice_paddies_part3_start":
            music::setmusicstate( "rice_paddies_part3_start" );
            break;
        case #"rice_paddies_part3_end":
            music::setmusicstate( "rice_paddies_part3_end" );
            break;
        case #"jungle_path_part3":
            music::setmusicstate( "jungle_path_part3" );
            break;
        case #"jungle_path_part3_battle_enter":
            break;
        case #"jungle_path_part3_battle_exit":
            break;
        case #"hash_86cb0f56400fe4f":
            music::setmusicstate( "music_stop_fadeout" );
            break;
        case #"tunnel_part3_fallen":
            music::setmusicstate( "tunnel_part3_fallen" );
            break;
        case #"tunnel_part3_final_walkdown":
            music::setmusicstate( "tunnel_part3_final_walkdown" );
            break;
        case #"tunnel_part4_final_movie":
            music::setmusicstate( "tunnel_part4_final_movie" );
            break;
        case #"music_stop_fadeout":
            music::setmusicstate( "music_stop_fadeout" );
            break;
        default:
            /#
                iprintlnbold( "<dev string:x60>" + str_msg + "<dev string:x72>" );
            #/
            
            break;
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0x777b7a44, Offset: 0x1ea8
// Size: 0x12a
function function_62dfea3e( location )
{
    snd::waitforplayers();
    waitframe( 1 );
    emi_allruns_stop();
    
    switch ( location )
    {
        case #"day":
            thread emi_allruns_play();
            thread emi_day_play();
            thread function_b15828b6();
            break;
        case #"night":
            thread emi_allruns_play();
            thread emi_night_play();
            thread function_1ac5a394();
            break;
        case #"bunker":
            break;
        case #"lab":
            break;
        default:
            assertmsg( "<dev string:x8d>" );
            break;
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0xd711a375, Offset: 0x1fe0
// Size: 0x24
function function_34830cda( *location )
{
    snd::play( "evt_obey" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0x5d0c632d, Offset: 0x2010
// Size: 0x24
function function_1e0e9b39( *location )
{
    snd::play( "evt_disobey" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 2
// Checksum 0x73d26b0d, Offset: 0x2040
// Size: 0x164
function function_ee033aa( short, type )
{
    if ( type == "door" )
    {
        if ( is_true( short ) )
        {
            snd::play( "evt_teleport_short" );
        }
        else
        {
            snd::play( "evt_teleport_long" );
        }
        
        return;
    }
    
    if ( type == "bunker1" )
    {
        snd::play( "evt_bunker_scene_transition1" );
        return;
    }
    
    if ( type == "bunker2" )
    {
        snd::play( "evt_bunker_scene_transition2" );
        return;
    }
    
    if ( type == "bunker3" )
    {
        snd::play( "evt_bunker_scene_transition3" );
        return;
    }
    
    if ( type == "bunker4" )
    {
        snd::play( "evt_bunker_scene_transition4" );
        return;
    }
    
    if ( type == "bunker5" )
    {
        snd::play( "evt_bunker_scene_transition5" );
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xb4f230a7, Offset: 0x21b0
// Size: 0x1c
function function_b15828b6()
{
    snd::client_msg( "timeofday_day" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xb005bc1, Offset: 0x21d8
// Size: 0x1c
function function_1ac5a394()
{
    snd::client_msg( "timeofday_night" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x5731a465, Offset: 0x2200
// Size: 0x1c
function emi_allruns_play()
{
    snd::client_msg( "emi_allruns_play" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xec47f0b8, Offset: 0x2228
// Size: 0x1c
function emi_allruns_stop()
{
    snd::client_msg( "emi_allruns_stop" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x2cc8fe38, Offset: 0x2250
// Size: 0x1c
function emi_day_play()
{
    snd::client_msg( "emi_day_play" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xf989e09f, Offset: 0x2278
// Size: 0x1c
function emi_night_play()
{
    snd::client_msg( "emi_night_play" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x80f724d1, Offset: 0x22a0
// Size: 0x4
function function_3587d33f()
{
    
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 2
// Checksum 0x72db7e7d, Offset: 0x22b0
// Size: 0xd2
function function_a24fb2ab( entity, threshold )
{
    same = 0;
    
    while ( same == 0 )
    {
        players = snd::function_da785aa8();
        player = players[ 0 ];
        
        if ( isplayer( player ) )
        {
            var_3a170e9c = entity.origin[ 2 ] - player.origin[ 2 ];
            
            if ( abs( var_3a170e9c ) < threshold )
            {
                same = 1;
            }
        }
        
        waitframe( 1 );
    }
    
    wait 1;
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0xd4a9aa26, Offset: 0x2390
// Size: 0x9a
function function_a632951b( choice )
{
    wait 0.5;
    
    switch ( choice )
    {
        case #"obey":
            snd::play( "evt_obey", level.player );
            break;
        case #"disobey":
            snd::play( "evt_disobey", level.player );
            break;
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x960ee0d9, Offset: 0x2438
// Size: 0x1c
function intro_scene()
{
    snd::client_msg( "intro_scene" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x249c70a1, Offset: 0x2460
// Size: 0x24
function function_6acff073()
{
    wait 0.2;
    snd::play( "amb_heli_start_2" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xbb2f3857, Offset: 0x2490
// Size: 0x24
function function_6ec11225()
{
    wait 0.2;
    snd::play( "amb_heli_start_3" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xdead68b4, Offset: 0x24c0
// Size: 0x24
function function_9d794a0e()
{
    wait 0.2;
    snd::play( "amb_heli_start_4" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0x71ea04c9, Offset: 0x24f0
// Size: 0x174
function function_8a5580af( var_c79d614f )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level endon( #"flag_jungle_path" );
    
    if ( level.var_731c10af.paths[ var_c79d614f ].count == 0 )
    {
        snd::client_msg( "rice_paddies_1_start" );
        level flag::wait_till_any( array( "rice_paddies_final_retreat", "rice_paddies_enemies_dead", "flag_jungle_path" ) );
        snd::client_msg( "rice_paddies_1_end" );
        return;
    }
    
    if ( level.var_731c10af.paths[ var_c79d614f ].count == 2 )
    {
        snd::client_msg( "rice_paddies_3_start" );
        level flag::wait_till_any( array( "rice_paddies_final_retreat", "rice_paddies_enemies_dead", "flag_jungle_path" ) );
        snd::client_msg( "rice_paddies_3_end" );
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xea2cc537, Offset: 0x2670
// Size: 0x24
function function_f665ec56()
{
    snd::play( "evt_fast_forward_rice_paddies", level.player );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x80f724d1, Offset: 0x26a0
// Size: 0x4
function function_aa0b70f3()
{
    
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xe7c830e9, Offset: 0x26b0
// Size: 0x7c
function function_ae63d294()
{
    snd::stop( level.var_d596f17e );
    snd::stop( level.var_2297f82d );
    snd::stop( level.var_d9e47cb4 );
    snd::stop( level.var_f6953e44 );
    snd::stop( level.var_45064ee1 );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x56c99121, Offset: 0x2738
// Size: 0x6c
function function_63e81473()
{
    chimes = snd::play( "amb_warpies_lp", ( -728, -227, 320 ) );
    level flag::wait_till( "flag_in_end_path" );
    snd::stop( chimes, 8 );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x86611d24, Offset: 0x27b0
// Size: 0xbc
function function_7e2d7c54()
{
    chimes = snd::play( "amb_warpies_reverse_lp", ( -728, -227, 320 ) );
    thread function_f34d98f2( ( 52, -1907, 84 ), -1000 );
    thread function_f34d98f2( ( -807, -742, 183 ), -1000 );
    level flag::wait_till( "flag_in_end_path" );
    snd::stop( chimes, 8 );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 2
// Checksum 0x35fdb467, Offset: 0x2878
// Size: 0x194
function function_f34d98f2( origin, threshold )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    buzz = snd::play( "amb_cp_nam_prisoner_crt_buzz_lp_path", origin );
    var_a24ddf98 = snd::play( "amb_cp_nam_prisoner_crt_fuzz_lp_path", origin );
    
    while ( !level flag::get( "flag_in_end_path" ) )
    {
        players = snd::function_da785aa8();
        player = players[ 0 ];
        
        if ( isplayer( player ) && isdefined( self ) )
        {
            player snd::waittilldistance( origin, threshold );
            tv = snd::play( "amb_cp_nam_prisoner_adler_tv_path", origin );
            wait randomfloatrange( 5, 10 );
        }
        
        waitframe( 1 );
    }
    
    snd::stop( buzz );
    snd::stop( var_a24ddf98 );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x2a09d294, Offset: 0x2a18
// Size: 0x1c
function waterfall_kill_right()
{
    snd::client_msg( "waterfall_kill_right" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x31d95ab3, Offset: 0x2a40
// Size: 0x1c
function waterfall_kill_left()
{
    snd::client_msg( "waterfall_kill_left" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xe579f28e, Offset: 0x2a68
// Size: 0x1c
function waterfall_slowmo_start()
{
    snd::client_msg( "waterfall_slowmo_start" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x818b6e59, Offset: 0x2a90
// Size: 0x1c
function waterfall_slowmo_stop()
{
    snd::client_msg( "waterfall_slowmo_stop" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xa5507d80, Offset: 0x2ab8
// Size: 0x1c
function waterfall_throw_knife()
{
    snd::client_msg( "waterfall_throw_knife" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0xd939f0ab, Offset: 0x2ae0
// Size: 0x24
function tmp_cp_nam_prisoner_caves_zipline( target )
{
    snd::play( "tmp_cp_nam_prisoner_caves_zipline", target );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x8f12e8c8, Offset: 0x2b10
// Size: 0x1c
function function_280d83da()
{
    snd::play( "evt_pris_bridge_heli_by_1", self );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xc526cf9d, Offset: 0x2b38
// Size: 0x1c
function function_3dd3af66()
{
    snd::play( "evt_pris_bridge_heli_by_2", self );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x423c97f0, Offset: 0x2b60
// Size: 0x1c
function function_8444bc3b()
{
    snd::play( "evt_pris_bridge_heli_by_3", self );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xd5d5b918, Offset: 0x2b88
// Size: 0x1c
function function_9b2e941d()
{
    snd::play( "evt_pris_frozen_battle_heli_by_1", self );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x247e83ab, Offset: 0x2bb0
// Size: 0x1c
function function_a6eaab95()
{
    snd::play( "evt_pris_frozen_battle_heli_by_2", self );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x4604f82, Offset: 0x2bd8
// Size: 0x1c
function function_49b6f127()
{
    snd::play( "evt_pris_frozen_battle_heli_by_3", self );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 2
// Checksum 0xfc922d98, Offset: 0x2c00
// Size: 0x6c
function function_d282054f( target1, target2 )
{
    snd::play( "evt_pris_knife_heli_passby_first", target1 );
    snd::play( "evt_pris_knife_heli_passby_second", target2 );
    snd::play( "evt_pris_knife_heli_passby_distant_leave", ( 2149, 2165, 581 ) );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x49a5c009, Offset: 0x2c78
// Size: 0x354
function function_cb7fb7e7()
{
    level flag::wait_till( "level_is_go" );
    player = getplayers()[ 0 ];
    bridge = getent( "audio_bridge_vol", "targetname" );
    var_184f2cbe = getent( "audio_bridge_debris1", "targetname" );
    var_6998953 = getent( "audio_bridge_debris2", "targetname" );
    snd::play( "amb_pris_bridge_wind_rope_lp", ( -1179, 2764, 386 ) );
    
    while ( true )
    {
        if ( isdefined( bridge ) && player istouching( bridge ) && player getvelocity() != ( 0, 0, 0 ) )
        {
            if ( player issprinting() )
            {
                snd::play( "evt_pris_bridge_creak_sprint", level.player.origin );
                wait 0.23;
            }
            else
            {
                snd::play( "evt_pris_bridge_creak_walk", level.player.origin );
                wait 0.6;
            }
        }
        
        if ( isdefined( var_184f2cbe ) && player istouching( var_184f2cbe ) && player getvelocity() != ( 0, 0, 0 ) )
        {
            if ( player issprinting() )
            {
                snd::play( "evt_pris_bridge_metal_debris_sprint", level.player.origin );
                wait 1;
            }
            else
            {
                snd::play( "evt_pris_bridge_metal_debris", level.player.origin );
                wait 1;
            }
        }
        
        if ( isdefined( var_6998953 ) && player istouching( var_6998953 ) && player getvelocity() != ( 0, 0, 0 ) )
        {
            if ( player issprinting() )
            {
                snd::play( "evt_pris_bridge_metal_debris_sprint", level.player.origin );
                wait 1;
            }
            else
            {
                snd::play( "evt_pris_bridge_metal_debris", level.player.origin );
                wait 1;
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x85f28aed, Offset: 0x2fd8
// Size: 0x1c
function function_df93683a()
{
    snd::play( "evt_pris_lazar_bridge_jumpscare" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xd12951cd, Offset: 0x3000
// Size: 0x4c
function function_c17eddf0()
{
    level flag::wait_till( "flag_jungle_lab_rob" );
    snd::play( "evt_geo_appearance_med", ( -464, -935, 95 ) );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x446938d4, Offset: 0x3058
// Size: 0x4c
function function_6db13656()
{
    level flag::wait_till( "flag_jungle_lab_rob2" );
    snd::play( "evt_geo_appearance_med", ( -464, -935, 95 ) );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xacda1e8b, Offset: 0x30b0
// Size: 0x4c
function function_823f75e6()
{
    level flag::wait_till( "flag_bridge_path_rob" );
    snd::play( "evt_geo_appearance_med", ( -1530, 1919, 368 ) );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x6129be09, Offset: 0x3108
// Size: 0x4c
function function_aaf2474b()
{
    level flag::wait_till( "flag_bridge_path_rob_2" );
    snd::play( "evt_geo_appearance_med", ( -1328, 2854, 381 ) );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x46917ee3, Offset: 0x3160
// Size: 0x4c
function function_e4de9155()
{
    level flag::wait_till( "flag_river_path_rob" );
    snd::play( "evt_geo_appearance_med", ( 59, 2586, -337 ) );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x5b82894a, Offset: 0x31b8
// Size: 0x8c
function function_3047c3a4()
{
    wait 5;
    snd::client_msg( "emi_allruns_stop" );
    wait 5;
    radio = snd::play( "evt_rat_tunnels_radio_lp", ( 1862, 1590, -1505 ) );
    snd::client_msg( "rat_tunnels_throb_low" );
    wait 6;
    thread function_a4db423c();
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x83f12801, Offset: 0x3250
// Size: 0x9c
function function_a4db423c()
{
    snd::play( "amb_rat_tunnels_zomb_amb", ( 1728, 1171, -1519 ) );
    wait 1;
    
    for ( i = 0; i < 9 ; i++ )
    {
        snd::play( "amb_rat_tunnels_zomb_step", ( 1728, 1171, -1519 ) );
        wait randomfloatrange( 0.5, 0.8 );
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0xecc87eee, Offset: 0x32f8
// Size: 0x1b4
function function_8c05dc42( dude )
{
    var_6ef21db4 = snd::emitter( "evt_rat_tunnels_amb_cave_walla", level.player, [ 3, 8 ], [ 500, 2000 ], [ -45, 45 ] );
    var_eabbb931 = snd::emitter( "evt_rat_tunnels_amb_steps", level.player, [ 2, 6 ], [ 500, 2000 ], [ -45, 45 ] );
    wait 0.5;
    snd::play( "evt_rat_tunnels_runner", dude );
    snd::play( "evt_rat_tunnels_amb_cave_walla_shout_close", dude );
    snd::client_msg( "rat_tunnels_throb_medium" );
    wait 0.5;
    level waittill( #"rat_tunnels_ambience_fade_out" );
    snd::stop( var_6ef21db4 );
    snd::stop( var_eabbb931 );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xcc3e7b5, Offset: 0x34b8
// Size: 0x1c
function rat_tunnels_amb_zombies()
{
    snd::client_msg( "rat_tunnels_amb_zombies" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x6be2d6eb, Offset: 0x34e0
// Size: 0x1c
function rat_tunnels_throb_high()
{
    snd::client_msg( "rat_tunnels_throb_high" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x2e1d104c, Offset: 0x3508
// Size: 0x1c
function rat_tunnels_ambience_fade_out()
{
    snd::client_msg( "rat_tunnels_ambience_fade_out" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x2ce56834, Offset: 0x3530
// Size: 0x1c
function function_366915c()
{
    snd::client_msg( "emi_allruns_stop" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x3ff8a8dd, Offset: 0x3558
// Size: 0x1c
function function_19123a4f()
{
    snd::client_msg( "cave_entry" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x9880e8f2, Offset: 0x3580
// Size: 0x1c
function cave_footsteps()
{
    snd::client_msg( "cave_footsteps" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x8626529c, Offset: 0x35a8
// Size: 0x1c
function pre_injection_hallway_sfx()
{
    snd::client_msg( "pre_injection_hallway_sfx" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xf5afd46a, Offset: 0x35d0
// Size: 0x70
function function_fe07a1d4()
{
    while ( true )
    {
        level waittill( #"mkultra_sound_on" );
        snd::client_msg( "mkultra_sound_on" );
        level waittill( #"mkultra_sound_off" );
        snd::client_msg( "mkultra_sound_off" );
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xf1607538, Offset: 0x3648
// Size: 0x1c
function mus_hallway_test()
{
    snd::client_msg( "mus_hallway_test" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0x1d2f90d3, Offset: 0x3670
// Size: 0xbc
function function_c635eb23( count )
{
    if ( count == 1 )
    {
        snd::client_msg( "infinite_hallway_ambience_1" );
        thread function_b216aefd();
        return;
    }
    
    if ( count == 2 )
    {
        snd::client_msg( "infinite_hallway_ambience_2" );
        return;
    }
    
    if ( count == 3 )
    {
        snd::client_msg( "infinite_hallway_ambience_3" );
        return;
    }
    
    if ( count == 4 )
    {
        snd::client_msg( "infinite_hallway_ambience_4" );
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x222ab1ca, Offset: 0x3738
// Size: 0xde
function function_b216aefd()
{
    while ( true )
    {
        level waittill( #"hash_7e0ec26676ae3d41" );
        
        if ( level.var_f668e14a <= 1 )
        {
            snd::client_msg( "infinite_hallway_loop_start" );
        }
        else if ( level.var_f668e14a == 2 )
        {
            snd::client_msg( "infinite_hallway_loop_low" );
        }
        else if ( level.var_f668e14a == 3 )
        {
            snd::client_msg( "infinite_hallway_loop_mid" );
        }
        else
        {
            snd::client_msg( "infinite_hallway_loop_high" );
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x5192b52b, Offset: 0x3820
// Size: 0x1c
function infinite_hallway_ambience_end()
{
    snd::client_msg( "infinite_hallway_ambience_end" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x4484f0a4, Offset: 0x3848
// Size: 0x1c
function stop_hallway_sfx()
{
    snd::client_msg( "stop_hallway_sfx" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x1ea23e8, Offset: 0x3870
// Size: 0x1c
function shrinking_hallway_start()
{
    snd::client_msg( "shrinking_hallway_start" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x46ffc800, Offset: 0x3898
// Size: 0x1c
function shrinking_hallway_hide()
{
    snd::client_msg( "shrinking_hallway_hide" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xf8a22337, Offset: 0x38c0
// Size: 0x1c
function shrinking_hallway_unhide()
{
    snd::client_msg( "shrinking_hallway_unhide" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x48f7fc69, Offset: 0x38e8
// Size: 0x1c
function shrinking_hallway_end()
{
    snd::client_msg( "shrinking_hallway_end" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x413edf6, Offset: 0x3910
// Size: 0xfc
function function_46e4b64f()
{
    while ( true )
    {
        distance = distancesquared( level.players[ 0 ].origin, self.origin );
        
        if ( distance < 902500 )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    loop = snd::play( "amb_hallway_door_pers_lp", self.origin );
    
    while ( true )
    {
        distance = distancesquared( level.players[ 0 ].origin, self.origin );
        
        if ( distance < 30625 )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    wait 0.6;
    snd::stop( loop );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x289d08dc, Offset: 0x3a18
// Size: 0xac
function function_d4255748()
{
    org = ( -1704, 9214, -1216 );
    adler = snd::play( [ "evt_adler_hallway_drone_lp", 4 ], org );
    level waittill( #"hash_54d5f64c5f92585d" );
    snd::play( "evt_adler_hallway_drone_end", org );
    snd::stop( adler, 0.05 );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xaed3059d, Offset: 0x3ad0
// Size: 0x5c
function function_99791793()
{
    snd::play( "evt_cp_nam_prisoner_memory_start" );
    amb = snd::play( "amb_cp_nam_prisoner_memory_lp" );
    wait 3;
    snd::stop( amb, 10 );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0x4326fc0a, Offset: 0x3b38
// Size: 0x156
function function_c298c625( threshold )
{
    level endon( #"memory_reaction_vo_start" );
    snd::play( "amb_cp_nam_prisoner_crt_on", self );
    snd::play( "amb_cp_nam_prisoner_crt_on_ominous", self );
    snd::play( "amb_cp_nam_prisoner_crt_buzz_lp", self );
    snd::play( "amb_cp_nam_prisoner_crt_fuzz_lp", self );
    wait randomfloatrange( 2, 4 );
    threshold *= -1;
    
    while ( isdefined( self ) )
    {
        players = snd::function_da785aa8();
        player = players[ 0 ];
        
        if ( isplayer( player ) && isdefined( self ) )
        {
            player snd::waittilldistance( self, threshold );
            snd::play( "amb_cp_nam_prisoner_adler_tv", self );
            wait randomfloatrange( 8, 16 );
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x828b50eb, Offset: 0x3c98
// Size: 0x1c
function projector_room_enter()
{
    snd::client_msg( "projector_room_enter" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x174fa87c, Offset: 0x3cc0
// Size: 0x4a
function function_82b14d0c()
{
    snd::play( "amb_cp_nam_prisoner_slide_proj_switch", self );
    
    if ( !isdefined( self.idle ) )
    {
        self.idle = snd::play( "amb_cp_nam_prisoner_slide_proj_lp", self );
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x37750ee4, Offset: 0x3d18
// Size: 0x44
function function_6467c4e8()
{
    if ( !level flag::get( "bunker_puzzle_room_solved" ) )
    {
        snd::play( "amb_cp_nam_prisoner_slide_proj_advance", self );
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x21685cc, Offset: 0x3d68
// Size: 0x1c
function projector_room_exit()
{
    snd::client_msg( "projector_room_exit" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x7c037b84, Offset: 0x3d90
// Size: 0xfc
function function_8d29676a()
{
    players = snd::function_da785aa8();
    player = players[ 0 ];
    tiles = snd::play( "evt_cp_nam_prisoner_hall_tile_destruct", player.origin );
    tiles moveto( ( 4809, 16823, -1009 ), 5, 0, 0 );
    rumble = snd::play( [ "amb_cp_nam_prisoner_memory_lp", 3 ] );
    level flag::wait_till( "lab_hallway_exited" );
    snd::stop( rumble, 3 );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x6de801ff, Offset: 0x3e98
// Size: 0x2c
function function_fcfaa723()
{
    level.var_ff423960 = snd::play( "evt_pris_knife_heli_dist_approach_lp", level.var_56894b06 );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xb10470bd, Offset: 0x3ed0
// Size: 0x8c
function function_eacda7cd()
{
    while ( true )
    {
        if ( isdefined( level.var_ff423960 ) )
        {
            wait 0.25;
            break;
        }
        
        waitframe( 1 );
    }
    
    wait 3;
    snd::stop( level.var_ff423960, 1.25 );
    wait 6.5;
    
    if ( isdefined( level.var_56894b06 ) )
    {
        level.var_56894b06 delete();
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0x93fd8fe3, Offset: 0x3f68
// Size: 0x24
function function_f2024bba( target )
{
    snd::play( "evt_pris_knife_heli_passby", target );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x47f8dfa5, Offset: 0x3f98
// Size: 0x34
function function_51f7c962()
{
    level.var_51f7c962 = snd::play( "tmp_cp_nam_prisoner_helicopter_distant_lp", ( 2500, 2038, 1571 ) );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0xa4412f1a, Offset: 0x3fd8
// Size: 0x74
function function_25065c16( heli )
{
    wait 0.5;
    
    if ( isdefined( level.var_51f7c962 ) )
    {
        snd::stop( level.var_51f7c962, 5 );
    }
    
    snd::play( "evt_prs_village_heli", heli );
    snd::play( "evt_prs_village_heli_gusts_lp", heli );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0x189a115f, Offset: 0x4058
// Size: 0x84
function function_2c89f1cf( heli )
{
    level flag::wait_till( "flag_village_heli_turret_loop_start" );
    turret = snd::play( "tmp_prs_village_heli_m60_lp", heli );
    level flag::wait_till( "flag_village_heli_turret_loop_stop" );
    snd::stop( turret );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x8ab724b9, Offset: 0x40e8
// Size: 0x44
function function_2faf67e()
{
    thread function_e40b48c();
    thread function_2e38b089();
    thread function_e25083cf();
    thread function_d3a5e67a();
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xdc63e3d8, Offset: 0x4138
// Size: 0x90
function function_e40b48c()
{
    level flag::wait_till( "village_missile_strike_explo_1" );
    org = ( 1269, 7318, 1091 );
    snd::play( "tmp_prs_village_heli_tower_explo_transient", org );
    snd::play( "tmp_prs_village_heli_tower_explo", org );
    snd::play( "evt_prs_village_heli_left_tower_impacts" );
    
    /#
    #/
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xcbae2720, Offset: 0x41d0
// Size: 0x58
function function_2e38b089()
{
    level waittill( #"hash_3db629f9bf3c2182" );
    org = ( 2255, 7072, 1274 );
    snd::play( "tmp_prs_village_heli_tower_explo", org );
    
    /#
    #/
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x50df6aa2, Offset: 0x4230
// Size: 0x5c
function function_e25083cf()
{
    level flag::wait_till( "village_missile_strike_explo_barrel" );
    org = ( 1814, 7695, 1299 );
    snd::play( "evt_prs_village_heli_explo_1", org );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x227dea06, Offset: 0x4298
// Size: 0x5c
function function_d3a5e67a()
{
    level flag::wait_till( "village_missile_strike_explo_2" );
    org = ( 1814, 7695, 1299 );
    snd::play( "evt_prs_village_heli_explo_2", org );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x1bb4d928, Offset: 0x4300
// Size: 0x6c
function function_4a9b10a8()
{
    gunfire = snd::play( "amb_village_dist_gunfire_lp", ( 147, 4367, 1228 ) );
    level flag::wait_till( "flag_village_start_wave_02" );
    snd::stop( gunfire, 20 );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0x4879e4af, Offset: 0x4378
// Size: 0x24
function tmp_cp_nam_bunk_door_slam( door )
{
    snd::play( "tmp_cp_nam_bunk_door_slam", door );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0xa5256a7a, Offset: 0x43a8
// Size: 0x24
function function_61bc0002( door )
{
    snd::play( "evt_prs_middle_paths_falling_door_incoming", door );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 2
// Checksum 0xb8b6ac5d, Offset: 0x43d8
// Size: 0x94
function function_501657c8( door, water = 0 )
{
    snd::play( "evt_prs_middle_paths_falling_door_impact", door );
    
    if ( is_true( water ) )
    {
        snd::play( "evt_prs_middle_paths_falling_door_water", door );
        return;
    }
    
    snd::play( "evt_prs_middle_paths_falling_door_dirt", door );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xf63c0782, Offset: 0x4478
// Size: 0x1c
function tmp_cp_nam_bunk_door_jumpback_01()
{
    snd::play( "tmp_cp_nam_bunk_door_jumpback_01" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x2660065e, Offset: 0x44a0
// Size: 0x1c
function tmp_cp_nam_bunk_door_jumpback_02()
{
    snd::play( "tmp_cp_nam_bunk_door_jumpback_02" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xbc6af0f1, Offset: 0x44c8
// Size: 0x1c
function tmp_cp_nam_bunk_door_jumpback_03()
{
    snd::play( "tmp_cp_nam_bunk_door_jumpback_03" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x81cde0f6, Offset: 0x44f0
// Size: 0x1c
function tmp_cp_nam_bunk_trap_floor()
{
    snd::play( "tmp_cp_nam_bunk_trap_floor" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0x7662d654, Offset: 0x4518
// Size: 0x164
function function_2982df9f( *door_locked )
{
    self endon( #"death" );
    self endon( #"deleted" );
    drone = undefined;
    
    if ( !isdefined( self.hidden ) || isdefined( self.hidden ) && self.hidden != 1 )
    {
        drone = snd::play( "amb_bunker_door_drone_close_lp", self.door_interact );
    }
    else
    {
        return;
    }
    
    self thread function_8bb241ce();
    util::waittill_any_ents( self, "deleted", self.door_interact, "trigger", level, "start_outro" );
    snd::client_msg( "bunker_door_used" );
    
    if ( level flag::get( "start_outro" ) )
    {
        return;
    }
    
    if ( isdefined( drone ) )
    {
        drone linkto( level.player );
        snd::stop( drone, 8 );
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xcaf377ed, Offset: 0x4688
// Size: 0x200
function function_8bb241ce()
{
    self notify( "3c322edb9b2e2053" );
    self endon( "3c322edb9b2e2053" );
    playing = 0;
    
    while ( true )
    {
        players = snd::function_da785aa8();
        player = players[ 0 ];
        
        if ( isplayer( player ) && isdefined( self.door_interact ) )
        {
            if ( distance( self.door_interact.origin, player.origin ) <= 110 )
            {
                if ( playing == 0 )
                {
                    if ( !isdefined( self.hidden ) || isdefined( self.hidden ) && self.hidden != 1 )
                    {
                        playing = 1;
                        voices = snd::emitter( "amb_bunker_door_perseus", player, [ 1, 11, 12, 28 ], [ 200, 800 ], [ -270, 270 ] );
                    }
                }
            }
            else if ( playing == 1 )
            {
                snd::stop( voices );
                playing = 0;
            }
        }
        else
        {
            if ( playing == 1 )
            {
                snd::stop( voices );
                playing = 0;
            }
            
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0xef0cd69e, Offset: 0x4890
// Size: 0x24
function tmp_cp_nam_pris_jet_passby_1( target )
{
    snd::play( "tmp_cp_nam_pris_jet_passby_1", target );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0x9e4e624e, Offset: 0x48c0
// Size: 0x24
function tmp_cp_nam_pris_jet_passby_2( target )
{
    snd::play( "tmp_cp_nam_pris_jet_passby_2", target );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 1
// Checksum 0x815f1614, Offset: 0x48f0
// Size: 0x24
function tmp_cp_nam_pris_jet_passby_3( target )
{
    snd::play( "tmp_cp_nam_pris_jet_passby_3", target );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x7629ce60, Offset: 0x4920
// Size: 0x2c
function function_ef1735e6()
{
    snd::play( "tmp_cp_nam_pris_napalm_drop", ( -4649, 6156, 71 ) );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0xf59cfa86, Offset: 0x4958
// Size: 0x2c
function function_fcadd113()
{
    snd::play( "tmp_cp_nam_pris_napalm_explode", ( -3510, 6266, 517 ) );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x4c1d9b24, Offset: 0x4990
// Size: 0x4c
function function_20018404()
{
    snd::client_msg( "start_frozen_battle" );
    level waittill( #"hash_135069eaafe77dc0" );
    snd::client_msg( "stop_frozen_battle" );
}

// Namespace namespace_b6fe1dbe/namespace_b6fe1dbe
// Params 0
// Checksum 0x78d5722, Offset: 0x49e8
// Size: 0x74
function bunker_room_final()
{
    voices = snd::play( "amb_perseus_whispers_bunker", ( -613, 11129, -1043 ) );
    level flag::wait_till( "flag_start_memory" );
    wait 3;
    snd::stop( voices, 8 );
}

