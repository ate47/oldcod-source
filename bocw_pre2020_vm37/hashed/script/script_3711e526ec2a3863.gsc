#using script_3dc93ca9902a9cda;
#using script_4ab78e327b76395f;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;
#using scripts\cp_common\util;

#namespace namespace_72b0499b;

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 0
// Checksum 0x8fd07179, Offset: 0x530
// Size: 0x4c
function init_audio()
{
    level thread function_827cf084();
    level thread function_2cc7f62c();
    level thread function_6cd6e708();
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 0
// Checksum 0x5b817089, Offset: 0x588
// Size: 0xc4
function function_4e1b7477()
{
    while ( level.players.size == 0 )
    {
        wait 0.25;
    }
    
    level.players[ 0 ] endon( #"death" );
    level endon( #"hash_629da45ba6679aae" );
    
    while ( true )
    {
        level flag::wait_till( "dambs_armada_base_playing" );
        thread function_816f9a23();
        level flag::wait_till_clear( "dambs_armada_base_playing" );
        level notify( #"snd_emitter_stop" );
    }
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 0
// Checksum 0x5648fb64, Offset: 0x658
// Size: 0xdc
function function_827cf084()
{
    while ( level.players.size == 0 )
    {
        wait 0.25;
    }
    
    level.players[ 0 ] endon( #"death" );
    level endon( #"hash_488f3af92d575e4d" );
    
    while ( true )
    {
        level flag::wait_till( "dambs_armada_mortar_village_playing" );
        thread function_62d67678();
        level flag::wait_till_clear( "dambs_armada_mortar_village_playing" );
        level notify( #"snd_emitter_stop" );
        level notify( #"hash_629da45ba6679aae" );
    }
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 0
// Checksum 0x72d48c56, Offset: 0x740
// Size: 0xdc
function function_2cc7f62c()
{
    while ( level.players.size == 0 )
    {
        wait 0.25;
    }
    
    level.players[ 0 ] endon( #"death" );
    level endon( #"hash_6e7780f7f1e44599" );
    
    while ( true )
    {
        level flag::wait_till( "dambs_armada_swamp_playing" );
        thread function_54b26c90();
        level flag::wait_till_clear( "dambs_armada_swamp_playing" );
        level notify( #"snd_emitter_stop" );
        level notify( #"hash_488f3af92d575e4d" );
    }
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 0
// Checksum 0x887d420a, Offset: 0x828
// Size: 0xdc
function function_6cd6e708()
{
    while ( level.players.size == 0 )
    {
        wait 0.25;
    }
    
    level.players[ 0 ] endon( #"death" );
    level endon( #"hash_11376b46ca5b856e" );
    
    while ( true )
    {
        level flag::wait_till( "dambs_armada_crash_playing" );
        thread function_552d1d58();
        level flag::wait_till_clear( "dambs_armada_crash_playing" );
        level notify( #"snd_emitter_stop" );
        level notify( #"hash_6e7780f7f1e44599" );
    }
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 0
// Checksum 0x2ae1d982, Offset: 0x910
// Size: 0x794
function function_816f9a23()
{
    snd::emitter( "emt_wind_breeze", level.players[ 0 ], [ 10, 15, 10, 15 ] );
    snd::emitter( "emt_nam_base_canvas_sweetener", ( -9092, -71547.3, 1071.8 ), [ 2, 4 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_base_canvas_wind", ( -9092, -71547.5, 1071.33 ), [ 14, 15 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_heli_distant_flyover", level.players[ 0 ], [ 11, 17, 10, 15 ], [ 500, 650 ], [ 0, 0 ] );
    snd::emitter( "emt_heli_distant_mono_flyover", level.players[ 0 ], [ 10, 17, 10, 15 ], [ 500, 650 ], [ 0, 0 ] );
    snd::emitter( "amb_radio_oneshot", ( -9910, -71384, 1050 ), [ 5, 11 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "amb_radio_oneshot", ( -9893, -71400, 1051 ), [ 7, 12 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "amb_radio_oneshot", ( -9713, -71944, 1055 ), [ 4, 8 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "amb_radio_oneshot", ( -9635, -71998, 1057 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "amb_radio_oneshot", ( -9725, -72024, 1057 ), [ 5, 11 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "amb_radio_oneshot", ( -10467, -71363, 1061 ), [ 5, 11 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_walla_armada_base_calm", level.players[ 0 ], [ 13, 15 ], [ 350, 750 ], [ 0, 0 ] );
    snd::emitter( "emt_walla_armada_base_yell", level.players[ 0 ], [ 13, 16 ], [ 350, 750 ], [ 0, 0 ] );
    snd::emitter( "emt_walla_armada_base_yell_short", level.players[ 0 ], [ 10, 15 ], [ 350, 750 ], [ 0, 0 ] );
    snd::emitter( "emt_walla_armada_base_yell", ( -10090, -73241, 1065 ), [ 11, 14 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_walla_armada_base_yell_short", ( -8680, -71504, 1165 ), [ 10, 15 ], [ 0, 0 ], [ 0, 0 ] );
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 0
// Checksum 0xaf1c7c06, Offset: 0x10b0
// Size: 0xf04
function function_62d67678()
{
    snd::emitter( "emt_foliage_rustle_light", ( -17917, 42063, 770 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -18005, 41844, 770 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -18246, 42188, 750 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -18465, 42476, 795 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -19424, 41721, 879 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -21149, 42321, 1066 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -21497, 42116, 1066 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -21764, 40218, 1094 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -20547, 38344, 1034 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -19255, 38504, 978 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -19262, 39331, 917 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -18193, 37664, 1047 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -17582, 39754, 586 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -17537, 40100, 576 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_rustle_light", ( -18454, 41111, 533 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_base_canvas_wind", ( -19369, 40288, 800 ), [ 14, 15 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_animal_birds_forest", ( -18101, 42238, 954 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_animal_birds_forest", ( -19346, 41684, 1075 ), [ 5, 12 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_animal_birds_forest", ( -21440, 42351, 1145 ), [ 5, 9 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_swamp_jungle_birds", ( -22326, 40112, 1145 ), [ 7, 12 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_animal_birds_forest", ( -21707, 37928, 1201 ), [ 5, 10 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_swamp_jungle_birds", ( -20230, 37827, 1201 ), [ 7, 11 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_animals_bird_mystery", ( -18775, 38029, 1125 ), [ 8, 13 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_foliage_wood_creaks_large", ( -17343, 40343, 543 ), [ 9, 15 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_water_lapping_short", ( -17282, 39821, 467 ), [ 4, 8 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_water_lapping_short", ( -16920, 40840, 467 ), [ 4, 8 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_water_lapping_short", ( -17091, 39287, 512 ), [ 4, 8 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_wood_creaking_room", ( -17854, 39134, 678 ), [ 5, 10 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_wood_creaking_room", ( -17155, 40476, 514 ), [ 5, 10 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_wood_creaking_room", ( -17096, 41070, 470 ), [ 5, 10 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_wood_forest_creak_deep", ( -17854, 39134, 678 ), [ 5, 13 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_wood_forest_creak_deep", ( -17096, 41070, 470 ), [ 5, 13 ], [ 0, 0 ], [ 0, 0 ] );
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 0
// Checksum 0xacec65e5, Offset: 0x1fc0
// Size: 0xa1c
function function_54b26c90()
{
    snd::emitter( "emt_foliage_rustle_light", level.players[ 0 ], [ 6, 10, 11, 15 ], [ 300, 500 ], [ 0, 360 ] );
    snd::emitter( "emt_animal_birds_forest", level.players[ 0 ], [ 15, 19, 10, 15 ], [ 500, 700 ], [ 0, 360 ] );
    snd::emitter( "emt_wind_breeze", level.players[ 0 ], [ 8, 11, 10, 15 ], [ 300, 500 ], [ 0, 360 ] );
    snd::emitter( "emt_nam_animals_howler_monkey", level.players[ 0 ], [ 12, 16, 11, 15 ], [ 200, 400 ], [ 0, 360 ] );
    snd::emitter( "emt_nam_animals_gibbon_monkey", level.players[ 0 ], [ 7, 11, 10, 15 ], [ 200, 400 ], [ 0, 360 ] );
    snd::emitter( "emt_nam_animals_bird_mystery", level.players[ 0 ], [ 8, 15, 10, 15 ], [ 400, 600 ], [ 0, 360 ] );
    snd::emitter( "emt_nam_swamp_jungle_birds", level.players[ 0 ], [ 14, 21, 10, 15 ], [ 300, 500 ], [ 0, 360 ] );
    snd::emitter( "emt_nam_wood_forest_creak_deep", level.players[ 0 ], [ 5, 13, 8, 15 ], [ 200, 500 ], [ 0, 360 ] );
    snd::emitter( "emt_foliage_wood_creaks_large", level.players[ 0 ], [ 6, 16, 8, 15 ], [ 200, 500 ], [ 0, 360 ] );
    snd::emitter( "emt_nam_jungle_foliage_breaks_medium_short", level.players[ 0 ], [ 12, 15 ], [ 100, 400 ], [ 0, 180 ] );
    snd::emitter( "emt_nam_jungle_foliage_breaks_medium_long", level.players[ 0 ], [ 10, 15 ], [ 100, 400 ], [ 0, 180 ] );
    snd::emitter( "emt_nam_jungle_foliage_breaks_medium_short", level.players[ 0 ], [ 9, 14 ], [ 100, 400 ], [ 0, 180 ] );
    snd::emitter( "emt_nam_walla_viet_yell_long", level.players[ 0 ], [ 8, 15, 10, 15 ], [ 200, 300 ], [ 0, 180 ] );
    snd::emitter( "emt_nam_walla_viet_yell_short", level.players[ 0 ], [ 8, 15, 10, 15 ], [ 200, 300 ], [ 0, 180 ] );
    snd::play( "emt_nam_engine_hiss_high_lp", ( 41965, 62150, 1340 ) );
    snd::emitter( "emt_nam_engine_radiator_ones", ( 41965, 62150, 1340 ), [ 2, 4 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_engine_radiator_clinks", ( 41965, 62150, 1340 ), [ 3, 5 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_water_lapping_short", ( 41829, 62242, 1304 ), [ 5, 8 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_water_lapping_short", ( 41281, 62191, 1325 ), [ 5, 8 ], [ 0, 0 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_water_lapping_short", ( 42594, 62234, 1320 ), [ 5, 8 ], [ 0, 0 ], [ 0, 0 ] );
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 0
// Checksum 0xca26b779, Offset: 0x29e8
// Size: 0x1b4
function function_552d1d58()
{
    snd::emitter( "emt_nam_gunfire_distant", level.players[ 0 ], [ 2, 4, 10, 15 ], [ 200, 800 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_exp_far", level.players[ 0 ], [ 3, 6, 10, 15 ], [ 400, 800 ], [ 0, 0 ] );
    snd::emitter( "emt_nam_exp_medium", level.players[ 0 ], [ 2, 5, 10, 15 ], [ 400, 800 ], [ 0, 0 ] );
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 2
// Checksum 0xd25aa386, Offset: 0x2ba8
// Size: 0x3c
function music( str_msg, n_delay = 0 )
{
    level thread function_7edafa59( str_msg, n_delay );
}

// Namespace namespace_72b0499b/namespace_268b0a5e
// Params 2
// Checksum 0xc6d7bb96, Offset: 0x2bf0
// Size: 0x192
function function_7edafa59( str_msg, n_delay )
{
    switch ( str_msg )
    {
        case #"hash_252fa416cd77cfc8":
        case #"hash_2f66a9ef795e8d6d":
        case #"hash_35a3e2376177a2ff":
        case #"hash_473a9efc535149cd":
        case #"hash_483005964fd4b32c":
        case #"hash_49def208c4d82ef7":
        case #"hash_6ad54a3806b553e0":
        case #"hash_724e7f4e8f785901":
            music::setmusicstate( str_msg, undefined, n_delay );
            break;
        case #"hash_7a72528b9f2c2f90":
            music::function_edda155f( str_msg, n_delay );
            break;
        case #"hash_2193c42e21ea2e63":
            music::function_2af5f0ec( str_msg );
            break;
        case #"hash_697ac6da22d55620":
            music::setmusicstate( "none", undefined, n_delay );
            break;
        default:
            /#
                iprintlnbold( "<dev string:x38>" + str_msg + "<dev string:x4a>" );
            #/
            
            break;
    }
}

