#using script_17b26b2e6b98a995;
#using script_268625b0934ee2ce;
#using script_2cd384a0f7be5baf;
#using script_2e03cad685678246;
#using script_3d81630134db409c;
#using script_4d984e2ed26bb2d9;
#using script_55d0a106fd8aa60a;
#using script_58524f08c3081cbb;
#using script_5a85dd71c99e76a2;
#using script_5c325a0a637fdc2e;
#using script_6f32a5eb9cd9dc68;
#using script_78fce3c67fb63796;
#using script_79f085c1bc211f9b;
#using script_8b6f2185feb33ac;
#using script_c36b776c6718540;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_rus_yamantau_flashlight;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace cp_rus_yamantau;

// Namespace cp_rus_yamantau/level_init
// Params 1, eflags: 0x40
// Checksum 0x6a145fbc, Offset: 0x4b0
// Size: 0x39c
function event_handler[level_init] main( *eventstruct )
{
    level.disablestattracking = 1;
    level.var_9c4a751d = 1;
    function_37dfd679();
    callback::on_spawned( &function_2675a176 );
    callback::on_ai_spawned( &ai_cold_breath );
    init_clientfields();
    level util::function_d96391ba();
    level cp_rus_yamantau_flashlight::preload();
    level namespace_c8bf7287::preload();
    load::main();
    namespace_ecdab0f4::function_f84e1e7();
    level thread cp_rus_yamantau_flashlight::postload();
    level thread namespace_1d6bb8b4::postload();
    level thread namespace_517e3310::postload();
    level.var_99a24a99 = 1;
    level thread function_dce9f3d4();
    level thread namespace_8af9269b::function_1acebbc0( "zipline_mountain_tutorial", undefined, 0.8, undefined, 1, undefined, 1, "snow" );
    level thread namespace_8af9269b::function_1acebbc0( "zipline_mountain_tutorial_jump", undefined, undefined, undefined, undefined, undefined, 1, "snow" );
    level thread namespace_8af9269b::function_1acebbc0( "zipline_catwalks", 0.7, undefined, undefined, undefined, 1, 1, "snow" );
    level thread namespace_8af9269b::function_1acebbc0( "zipline_excavation_1", undefined, undefined, undefined, undefined, undefined, 1, "snow" );
    level thread namespace_8af9269b::function_1acebbc0( "zipline_excavation_4", undefined, undefined, undefined, undefined, undefined, 1, "snow" );
    level thread namespace_8af9269b::function_1acebbc0( "zipline_excavation_5", undefined, undefined, undefined, undefined, undefined, 1, "snow" );
    level thread namespace_8af9269b::function_1acebbc0( "zipline_excavation_6", undefined, undefined, undefined, undefined, undefined, 1, "snow" );
    level thread namespace_8af9269b::function_1acebbc0( "zipline_excavation_7", undefined, undefined, undefined, undefined, undefined, 1, "snow" );
    level thread namespace_8af9269b::function_1acebbc0( "zipline_server_1", undefined, undefined, undefined, undefined, undefined, 1, "snow" );
    level flag::wait_till( "game_start" );
    setdvar( #"compassmaxrange", "2100" );
    
    /#
        level thread hms_util::function_5056f90d();
        level thread function_37fa595();
    #/
}

// Namespace cp_rus_yamantau/cp_rus_yamantau
// Params 0
// Checksum 0x8e0f18ed, Offset: 0x858
// Size: 0x4e4
function function_37dfd679()
{
    skipto::function_eb91535d( "intro_heli", &namespace_cbf28e01::function_37c8a043, &namespace_cbf28e01::function_38910b5f, undefined, &namespace_cbf28e01::function_a0b88490 );
    skipto::function_eb91535d( "mountain_summit", &namespace_cbf28e01::function_3d1df8a6, &namespace_cbf28e01::function_d3655e70, undefined, &namespace_cbf28e01::function_fdbb9f1e );
    skipto::function_eb91535d( "ice_slide", &namespace_cbf28e01::function_ae06da18, &namespace_cbf28e01::function_bb34c64, undefined, &namespace_cbf28e01::function_33fd8fa3 );
    skipto::function_eb91535d( "zipline_intro", &namespace_cbf28e01::function_11648e12, &namespace_cbf28e01::function_b205e5be, undefined, &namespace_cbf28e01::function_71f05605 );
    skipto::function_eb91535d( "satcom_approach", &namespace_94dc1844::function_56b991c1, &namespace_94dc1844::function_c73772c6, undefined, &namespace_94dc1844::function_844967aa );
    skipto::function_eb91535d( "satcom", &namespace_94dc1844::function_8cc2cc25, &namespace_94dc1844::function_f6f8cdca, undefined, &namespace_94dc1844::function_a46dc345 );
    skipto::function_eb91535d( "catwalks", &namespace_a2d2e744::function_32d297d8, &namespace_a2d2e744::function_2445d847, undefined, &namespace_a2d2e744::function_dfe7cd78 );
    skipto::add_dev( "dev_catwalks_stealth", &namespace_a2d2e744::function_965213e6, &namespace_a2d2e744::function_2445d847, undefined, &namespace_a2d2e744::function_dfe7cd78 );
    skipto::function_eb91535d( "zipline_fall", &namespace_a2d2e744::function_198e08b8, &namespace_a2d2e744::function_9539fa90, undefined, &namespace_a2d2e744::function_b366b7a9 );
    skipto::function_eb91535d( "bunker_explore", &namespace_73841f48::function_599d30fb, &namespace_73841f48::function_c3ccbcc8, undefined, &namespace_73841f48::function_f46b6ef );
    skipto::function_eb91535d( "bunker_encounter", &namespace_73841f48::function_eea0086d, &namespace_73841f48::function_b47dd82e, undefined, &namespace_73841f48::function_511f3559 );
    skipto::function_eb91535d( "woods_regroup", &namespace_73841f48::function_4e75b98e, &namespace_73841f48::function_4d07bf4e, undefined, &namespace_73841f48::function_53b51eb0 );
    skipto::function_eb91535d( "excavation", &namespace_9e8d4ac3::function_6d9e84ea, &namespace_9e8d4ac3::function_ab15a34c, undefined, &namespace_9e8d4ac3::function_1e5a768a );
    skipto::function_eb91535d( "excavation_finale", &namespace_9e8d4ac3::function_e30ea9da, &namespace_9e8d4ac3::function_4a1a74fe, undefined, &namespace_9e8d4ac3::function_888e9b6b );
    skipto::function_eb91535d( "server_reveal", &namespace_7ef9d872::function_87560e1a, &namespace_7ef9d872::function_dba43792, undefined, &namespace_7ef9d872::function_bb405879 );
    skipto::function_eb91535d( "server_ascent", &namespace_7ef9d872::function_e936fbf4, &namespace_7ef9d872::function_f59af500, undefined, &namespace_7ef9d872::function_b80cf494 );
    skipto::add_dev( "dev_satcom_shot", &namespace_94dc1844::function_22e1ef3a, &namespace_94dc1844::function_cc91ce1f, undefined, &namespace_94dc1844::function_a46dc345 );
    skipto::function_46d8992a( "intro_heli" );
}

// Namespace cp_rus_yamantau/cp_rus_yamantau
// Params 0
// Checksum 0x618b7900, Offset: 0xd48
// Size: 0x124
function init_clientfields()
{
    clientfield::register( "toplayer", "optional_objective_camera_fx", 1, 1, "int" );
    clientfield::register( "world", "cull_inside_satcom", 1, 2, "int" );
    clientfield::register( "world", "cull_inside_finale", 1, 2, "int" );
    clientfield::register( "world", "cull_inside_bunkerext", 1, 2, "int" );
    clientfield::register( "world", "cull_outside_bunkerint", 1, 2, "int" );
    clientfield::register( "world", "cull_inside_excavation", 1, 2, "int" );
}

// Namespace cp_rus_yamantau/cp_rus_yamantau
// Params 0
// Checksum 0xf263b6e9, Offset: 0xe78
// Size: 0x6c
function ai_cold_breath()
{
    self endon( #"death" );
    wait 0.2;
    
    if ( level.var_28c22d88[ 0 ] != "intro_heli" && !isvehicle( self ) )
    {
        self clientfield::increment( "ai_cold_breath" );
    }
}

// Namespace cp_rus_yamantau/cp_rus_yamantau
// Params 0
// Checksum 0xe1237ca, Offset: 0xef0
// Size: 0x512
function function_2675a176()
{
    if ( !isdefined( level.player ) )
    {
        level.player = self;
    }
    
    if ( !isdefined( level.var_28c22d88[ 0 ] ) )
    {
        return;
    }
    
    self setcharacterbodytype( 1 );
    self setcharacteroutfit( 6 );
    
    switch ( level.var_28c22d88[ 0 ] )
    {
        case #"mountain_summit":
        case #"intro_heli":
        case #"zipline_intro":
        case #"ice_slide":
        case #"satcom_approach":
        case #"satcom":
        case #"catwalks":
        case #"zipline_fall":
            w_primary = getweapon( #"sniper_standard_t9", "suppressed2", "smoothzoom" );
            w_secondary = getweapon( #"pistol_burst_t9", "suppressed2" );
            var_deeb6741 = getweapon( #"frag_grenade" );
            var_2586eb45 = getweapon( #"eq_flash_grenade" );
            hms_util::function_2e7c81f6( w_primary, w_secondary, var_deeb6741, var_2586eb45 );
            break;
        case #"bunker_explore":
        case #"bunker_encounter":
            w_primary = getweapon( #"knife_loadout" );
            var_deeb6741 = getweapon( #"frag_grenade" );
            var_2586eb45 = getweapon( #"eq_flash_grenade" );
            hms_util::function_2e7c81f6( w_primary, undefined, var_deeb6741, var_2586eb45 );
            break;
        case #"woods_regroup":
        case #"excavation":
            w_primary = getweapon( #"smg_standard_t9" );
            w_secondary = getweapon( #"pistol_semiauto_t9" );
            var_deeb6741 = getweapon( #"frag_grenade" );
            var_2586eb45 = getweapon( #"eq_flash_grenade" );
            hms_util::function_2e7c81f6( w_primary, w_secondary, var_deeb6741, var_2586eb45 );
            break;
        case #"excavation_finale":
        case #"server_reveal":
        case #"server_ascent":
            w_primary = getweapon( #"smg_heavy_t9", "extclip2", "grip" );
            w_secondary = getweapon( #"pistol_semiauto_t9" );
            var_deeb6741 = getweapon( #"frag_grenade" );
            var_2586eb45 = getweapon( #"eq_flash_grenade" );
            hms_util::function_2e7c81f6( w_primary, w_secondary, var_deeb6741, var_2586eb45 );
            break;
        default:
            w_primary = getweapon( #"sniper_standard_t9", "suppressed2", "smoothzoom" );
            w_secondary = getweapon( #"pistol_burst_t9", "suppressed2" );
            var_deeb6741 = getweapon( #"frag_grenade" );
            var_2586eb45 = getweapon( #"eq_flash_grenade" );
            hms_util::function_2e7c81f6( w_primary, w_secondary, var_deeb6741, var_2586eb45 );
            break;
    }
    
    self.var_9d386cb9 = "Mason";
}

// Namespace cp_rus_yamantau/cp_rus_yamantau
// Params 0
// Checksum 0xe2c595bc, Offset: 0x1410
// Size: 0xe8
function function_dce9f3d4()
{
    level.e_server_hook = getent( "e_server_hook", "targetname" );
    s_situation_room_glass = struct::get_array( "s_situation_room_glass", "targetname" );
    
    foreach ( struct in s_situation_room_glass )
    {
        glassradiusdamage( struct.origin, 20, 10, 10 );
    }
}

/#

    // Namespace cp_rus_yamantau/cp_rus_yamantau
    // Params 0, eflags: 0x4
    // Checksum 0xfbddf97, Offset: 0x1500
    // Size: 0x170, Type: dev
    function private function_37fa595()
    {
        var_2c251c2e = util::get_map_name();
        adddebugcommand( "<dev string:x38>" );
        adddebugcommand( "<dev string:x91>" );
        adddebugcommand( "<dev string:xed>" );
        
        while ( true )
        {
            var_25d5206e = getdvarint( #"hash_6bcb191f82f445a0", 0 );
            
            switch ( var_25d5206e )
            {
                case 1:
                    level thread namespace_73841f48::function_99854e6c();
                    break;
                case 2:
                    level thread namespace_73841f48::function_c54b46bc();
                    break;
                case 3:
                    level thread function_23d342b7();
                    break;
                default:
                    break;
            }
            
            setdvar( #"hash_6bcb191f82f445a0", 0 );
            wait 0.5;
        }
    }

    // Namespace cp_rus_yamantau/cp_rus_yamantau
    // Params 0
    // Checksum 0x1815c05a, Offset: 0x1678
    // Size: 0x8c, Type: dev
    function function_23d342b7()
    {
        transient = savegame::function_6440b06b( #"transient" );
        transient.var_296ec611 = 1;
        savegame::function_7790f03( 1 );
        wait 0.5;
        skipto::function_8722a51a( "<dev string:x14a>" );
        map_restart();
    }

#/
