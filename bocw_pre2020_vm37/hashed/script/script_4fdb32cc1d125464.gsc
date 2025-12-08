#using script_1b9f100b85b7e21d;
#using script_1fd2c6e5fc8cb1c3;
#using script_2d443451ce681a;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_4ec222619bffcfd1;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_utility;
#using scripts\cp_common\spawn_manager;
#using scripts\cp_common\util;

#namespace kgb_aslt_exfil_escape;

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 1
// Checksum 0xdcddcad8, Offset: 0x12a0
// Size: 0xc
function starting( *var_d3440450 )
{
    
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 2
// Checksum 0x31f9e33b, Offset: 0x12b8
// Size: 0x3c4
function main( var_d3440450, var_50cc0d4f )
{
    level flag::set( "aslt_exfil_escape_begin" );
    
    if ( is_true( var_50cc0d4f ) )
    {
        level.adler = namespace_e77bf565::adler_spawn( var_d3440450, "adler_casual_killer" );
        level.inside_man = namespace_e77bf565::function_e4660071( var_d3440450, "inside_man_casual_killer" );
        level thread alarm_lights();
        level thread namespace_353d803e::function_d4ea305a();
        level thread function_1f999428();
        level thread doors::close_all();
        level thread doors::function_f35467ac();
        level flag::set( "exfil_escape_elevator_guards_explosion_triggered" );
        level flag::set( "turn_on_elevator_alarm_light" );
        level flag::set( "adler_exfil_escape_start_pathing" );
        level flag::set( "inside_man_exfil_escape_start_pathing" );
        level flag::set( "slow_mo_stopped" );
    }
    
    spawner::add_spawn_function_group( "exfil_escape_spetsnaz", "script_noteworthy", &function_4ab39cb8 );
    level thread namespace_e77bf565::escape_objective( var_d3440450, var_50cc0d4f );
    level thread function_2ce634b9();
    level thread function_b735db01();
    level thread function_d883a464();
    level thread function_607a27c4();
    level thread function_e6fcee54();
    level thread function_77668431();
    level thread function_59171011();
    level thread function_f58c4091();
    spawner::add_spawn_function_ai_group( "exfil_escape_russians", &function_e8d1d4f9 );
    spawner::set_ai_group_cleared_count( "exfil_escape_russians", 1 );
    
    if ( !isdefined( level.var_4638dea7 ) )
    {
        level.var_4638dea7 = [];
        level.var_4638dea7[ #"hash_673ccd49cfca8feb" ] = level.var_bde873f5;
        level.var_4638dea7[ #"hash_5e05ae2085249930" ] = level.var_3d559f37;
    }
    
    level flag::wait_till( "aslt_exfil_escape_complete" );
    
    if ( isdefined( var_d3440450 ) )
    {
        skipto::function_4e3ab877( var_d3440450 );
    }
    
    skipto::function_1c2dfc20( "cp_ger_hub_post_kgb" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 4
// Checksum 0xa18e2ac9, Offset: 0x1688
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0xb77ed376, Offset: 0x16b8
// Size: 0x1c4
function init_flags()
{
    level flag::init( "aslt_exfil_escape_begin" );
    level flag::init( "exfil_escape_cover_hidden" );
    level flag::init( "escape_follow_adler" );
    level flag::init( "exfil_escape_elevator_guards_explosion_triggered" );
    level flag::init( "escape_vehicle_enter" );
    level flag::init( "escape_enable_car_interact" );
    level flag::init( "player_started_car_escape" );
    level flag::init( "aslt_exfil_escape_complete" );
    level flag::init( "scene_kgb_exfil_door_kick_played" );
    level flag::init( "adler_exfil_escape_start_pathing" );
    level flag::init( "inside_man_exfil_escape_start_pathing" );
    level flag::init( "escape_enable_car_interact_waypoint" );
    level flag::init( "player_opened_exfil_tunnel_door" );
    level flag::init( "scene_kgb_exfil_door_kick_started" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0xc1685c50, Offset: 0x1888
// Size: 0x64
function init_clientfields()
{
    clientfield::register( "world", "elevator_hall_dmg_models_and_vol_decals", 1, 1, "int" );
    clientfield::register( "world", "exfil_cover_models", 1, 1, "int" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x19a36d9e, Offset: 0x18f8
// Size: 0x16c
function function_22b7fffd()
{
    animation::add_notetrack_func( "kgb_aslt_exfil_escape::exfil_escape_elevator_guards_explosion", &function_10d1e2b8 );
    animation::add_notetrack_func( "kgb_util::start_firing_magic_bullets", &namespace_e77bf565::function_7264e049 );
    animation::add_notetrack_func( "kgb_aslt_exfil_escape::attach_armor", &function_8484087e );
    animation::add_notetrack_func( "kgb_util::handle_rob_char_burn", &namespace_e77bf565::function_9c6f33d9 );
    animation::add_notetrack_func( "kgb_aslt_exfil_escape::car_escape_side_window_to_rear_window_gesture", &function_a9ab5a76 );
    animation::add_notetrack_func( "kgb_aslt_exfil_escape::swap_in_damaged_trunk", &function_3685f662 );
    animation::add_notetrack_func( "kgb_aslt_exfil_escape::swap_cabinet_model", &function_29d84d49 );
    animation::add_notetrack_func( "kgb_aslt_exfil_escape::chase_vehicle_hide_windows", &function_54f735b0 );
    animation::add_notetrack_func( "kgb_aslt_exfil_escape::chase_vehicle_windshield", &function_fd03a68b );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x4bc2d075, Offset: 0x1a70
// Size: 0x2c
function function_2ce634b9()
{
    wait 1;
    level flag::set( "escape_follow_adler" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0xb1f31fe, Offset: 0x1aa8
// Size: 0x59c
function function_b735db01()
{
    level.adler endon( #"death" );
    level.adler thread function_3145b7e3();
    level.adler thread function_8484087e();
    level.adler thread give_lmg();
    level flag::wait_till( "adler_exfil_escape_start_pathing" );
    level.adler.fixednode = 1;
    node = getnode( "exfil_escape_adler_start_node", "targetname" );
    level.adler thread spawner::go_to_node( node );
    level flag::wait_till( "exfil_escape_elevator_guards_explosion_triggered" );
    level.adler thread dialogue::queue( "vox_cp_rkgb_09000_adlr_dropem_a2" );
    level flag::wait_till( "slow_mo_stopped" );
    wait 2;
    level thread savegame::checkpoint_save();
    level.adler thread dialogue::queue( "vox_cp_rkgb_08100_adlr_gogodontstop_b0" );
    level flag::wait_till( "exfil_escape_move_allies_40" );
    level.adler thread dialogue::queue( "vox_cp_rkgb_08100_adlr_werealmostthere_97" );
    level flag::wait_till( "exfil_escape_move_allies_50" );
    level thread savegame::checkpoint_save();
    level.adler thread dialogue::queue( "vox_cp_rkgb_08100_adlr_keeppushing_c4" );
    level flag::wait_till_any( [ "player_opened_exfil_tunnel_door", "scene_kgb_exfil_door_kick_played" ] );
    guys = spawner::get_ai_group_ai( "exfil_escape_group_05" );
    guys = arraycombine( guys, spawner::get_ai_group_ai( "exfil_escape_group_07" ) );
    guys = arraycombine( guys, spawner::get_ai_group_ai( "exfil_escape_group_10" ) );
    guys = arraycombine( guys, spawner::get_ai_group_ai( "exfil_escape_group_15" ) );
    guys = arraycombine( guys, spawner::get_ai_group_ai( "exfil_escape_group_20" ) );
    guys = arraycombine( guys, spawner::get_ai_group_ai( "exfil_escape_group_25" ) );
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy ) && isalive( guy ) )
        {
            guy kill();
        }
    }
    
    level thread savegame::checkpoint_save();
    
    if ( flag::get( "player_opened_exfil_tunnel_door" ) )
    {
        if ( !flag::get( "adler_near_tunnel_entrance" ) )
        {
            level.adler notify( #"stop_going_to_node" );
            node = getnode( "adler_tunnel_entrance_node", "targetname" );
            level.adler forceteleport( node.origin, node.angles, 1, 1 );
        }
    }
    
    level.adler thread dialogue::queue( "vox_cp_rkgb_09000_adlr_lazarshouldbeju_b7" );
    wait 1;
    namespace_353d803e::music( "15.0_car" );
    level.adler notify( #"stop_going_to_node" );
    level.adler.script_accuracy = 500;
    level.adler.perfectaim = 1;
    level.adler.ignoresuppression = 1;
    node = getnode( "exfil_escape_adler_tunnel_node", "targetname" );
    level.adler thread spawner::go_to_node( node );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x7df42b3a, Offset: 0x2050
// Size: 0x314
function function_d883a464()
{
    level.inside_man endon( #"death" );
    level.inside_man thread function_3145b7e3();
    level.inside_man thread function_8484087e();
    level.inside_man thread give_lmg();
    level flag::wait_till( "inside_man_exfil_escape_start_pathing" );
    level.inside_man.fixednode = 1;
    node = getnode( "exfil_escape_inside_man_start_node", "targetname" );
    level.inside_man thread spawner::go_to_node( node );
    level flag::wait_till_any( [ "player_opened_exfil_tunnel_door", "exfil_escape_move_allies_70" ] );
    
    if ( flag::get( "exfil_escape_move_allies_70" ) )
    {
        level flag::set( "scene_kgb_exfil_door_kick_started" );
        function_6575a0cf();
        scene::play( "scene_kgb_exfil_door_kick", [ level.exfil_tunnel_door_left, level.exfil_tunnel_door_right ] );
        level flag::set( "scene_kgb_exfil_door_kick_played" );
    }
    else if ( flag::get( "player_opened_exfil_tunnel_door" ) )
    {
        if ( !flag::get( "inside_man_near_tunnel_entrance" ) )
        {
            level.inside_man notify( #"stop_going_to_node" );
            node = getnode( "inside_man_tunnel_entrance_node", "targetname" );
            level.inside_man forceteleport( node.origin, node.angles, 1, 1 );
            wait 0.5;
        }
    }
    
    level.inside_man.script_accuracy = 500;
    level.inside_man.perfectaim = 1;
    level.inside_man.ignoresuppression = 1;
    level.inside_man notify( #"stop_going_to_node" );
    node = getnode( "exfil_escape_inside_man_tunnel_node", "targetname" );
    level.inside_man thread spawner::go_to_node( node );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x3e0bdab2, Offset: 0x2370
// Size: 0xc2
function function_3145b7e3()
{
    self endon( #"death" );
    function_1ad415e();
    
    if ( !flag::get( "player_opened_exfil_tunnel_door" ) )
    {
        self.forcesprint = 1;
    }
    
    level flag::wait_till_any( [ "scene_kgb_exfil_door_kick_played", "player_opened_exfil_tunnel_door" ] );
    self.forcesprint = 0;
    level flag::wait_till( "exfil_escape_russians_cleared" );
    self.forcesprint = 1;
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0xa5cc974d, Offset: 0x2440
// Size: 0x94
function function_1ad415e()
{
    level endon( #"player_opened_exfil_tunnel_door" );
    level flag::wait_till_all( [ "exfil_escape_group_05_cleared", "exfil_escape_group_07_cleared", "exfil_escape_group_10_cleared", "exfil_escape_group_15_cleared", "exfil_escape_group_20_cleared", "exfil_escape_group_25_cleared" ] );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x120a500d, Offset: 0x24e0
// Size: 0x36
function function_4ab39cb8()
{
    self.ignoresuppression = 1;
    self.disablebulletwhizbyreaction = 1;
    self.var_b81bb500 = 1;
    self.dodangerreact = 0;
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 1
// Checksum 0x70428f83, Offset: 0x2520
// Size: 0x3e4
function function_10d1e2b8( *params )
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    exfil_escape_elevator_explosion_org = struct::get( "exfil_escape_elevator_explosion_org", "targetname" );
    exploder::exploder( "elevator_explosion" );
    playfx( "maps/cp_kgb/fx9_kgb_c4_exp", exfil_escape_elevator_explosion_org.origin, anglestoforward( exfil_escape_elevator_explosion_org.angles ), anglestoup( exfil_escape_elevator_explosion_org.angles ) );
    screenshake( exfil_escape_elevator_explosion_org.origin, 4, 4, 4, 0.5, 0, -1, 0, 5, 1, 3, 8 );
    snd::client_msg( #"hash_2705a705c011de47" );
    thread namespace_353d803e::function_81b99645();
    wait 0.14;
    screenshake( exfil_escape_elevator_explosion_org.origin, 8, 7, 5, 0.5, 0, -1, 0, 15, 13, 6, 8 );
    screenshake( exfil_escape_elevator_explosion_org.origin, 1, 1, 1, 2.5, 0, -1, 0, 50, 5, 1, 4 );
    e_grenade = player magicgrenadetype( getweapon( #"hash_3d69608df21d9085" ), exfil_escape_elevator_explosion_org.origin, ( 0, 0, 0 ), 0 );
    e_grenade.var_83323dfb = 1;
    origin = exfil_escape_elevator_explosion_org.origin;
    radius = exfil_escape_elevator_explosion_org.radius;
    wait 0.1;
    radiusdamage( origin, radius, 500, 200, player, "MOD_GRENADE", getweapon( #"hash_3d69608df21d9085" ) );
    var_5ff9756e = struct::get_array( "exfil_escape_elevator_light_post_explosion_org", "targetname" );
    
    foreach ( org in var_5ff9756e )
    {
        radiusdamage( org.origin, org.radius, 250, 100, player, "MOD_GRENADE", getweapon( #"hash_3d69608df21d9085" ) );
    }
    
    level flag::set( "exfil_escape_elevator_guards_explosion_triggered" );
    player clientfield::set_to_player( "set_player_pbg_bank", 1 );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x8518cf8d, Offset: 0x2910
// Size: 0x1bc
function function_e6fcee54()
{
    level.lazar = spawner::simple_spawn_single( "lazar" );
    level.escape_vehicle = getent( "escape_vehicle", "targetname" );
    level.var_fb380007 = [];
    level.var_fb380007[ #"lazar" ] = level.lazar;
    level.var_fb380007[ #"escape_vehicle" ] = level.escape_vehicle;
    scene::init( "scene_kgb_exfil_drive_in", level.var_fb380007 );
    level thread function_f8c9f021();
    msg = level flag::wait_till_any( [ "escape_vehicle_enter", "exfil_escape_russians_cleared" ] );
    
    if ( msg._notify == #"exfil_escape_russians_cleared" )
    {
        level flag::wait_till_timeout( 1.5, "escape_vehicle_enter" );
    }
    
    snd::client_msg( "exfil_car_pullup" );
    snd::client_targetname( level.escape_vehicle, "veh_escape_vehicle" );
    level thread scene::play( "scene_kgb_exfil_drive_in", "Drive_In", level.var_fb380007 );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0xc55d97dd, Offset: 0x2ad8
// Size: 0x3f4
function function_77668431()
{
    player = getplayers()[ 0 ];
    level flag::wait_till( "escape_enable_car_interact" );
    level.var_ea185900 = util::spawn_model( "tag_origin" );
    level.var_ea185900 linkto( level.escape_vehicle, "tag_enter_passenger2", ( -10, 11, 42 ), ( 0, 0, 0 ) );
    level.var_ea185900 util::create_cursor_hint( "tag_origin", undefined, #"hash_35327dad8881bb8f" );
    level thread function_72bfe030();
    level flag::set( "escape_enable_car_interact_waypoint" );
    level.var_ea185900 waittill( #"trigger" );
    player disableweapons();
    player enableinvulnerability();
    setdvar( #"aim_assist_script_disable", 1 );
    setdvar( #"hash_3d9a09e7ecea2271", 0 );
    snd::client_msg( "exfil_car_enter" );
    level.lazar stopanimscripted();
    level.escape_vehicle stopanimscripted();
    level thread function_1147675b();
    level thread namespace_82bfe441::fade( 1, "FadeFast" );
    level notify( #"hash_32e3ef5fcfcdd1" );
    level thread infinite_ammo();
    level flag::set( "player_started_car_escape" );
    player namespace_e77bf565::function_123fe6d1();
    level thread function_796d7c74();
    thread namespace_353d803e::function_a645cbed();
    level thread function_8c7969b4();
    level thread scene::play( "scene_kgb_exfil_end", level.var_fb380007 );
    namespace_353d803e::music( "deactivate_15.0_car", 16 );
    level.player districts::function_930f8c81( [ "kgb_hq_front_04", "kgb_hq_elevator", "kgb_hq_armory_wing", "kgb_hq_second_floor" ] );
    level waittill( #"hash_7a44c000d09533e7" );
    player setlowready( 1 );
    level waittill( #"mission_end" );
    level lui::screen_fade_out( 2.5, "black" );
    wait 1;
    level flag::set( "aslt_exfil_escape_complete" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 1
// Checksum 0xb026066d, Offset: 0x2ed8
// Size: 0x104
function function_f8c9f021( *params )
{
    if ( level.escape_vehicle haspart( "tag_glass_left_rear_d0" ) )
    {
        level.escape_vehicle hidepart( "tag_glass_left_rear_d0" );
    }
    
    if ( level.escape_vehicle haspart( "tag_glass_left_front_d0" ) )
    {
        level.escape_vehicle hidepart( "tag_glass_left_front_d0" );
    }
    
    level waittill( #"hash_4fbed25073820ad4" );
    
    if ( level.escape_vehicle haspart( "tag_glass_back_d0" ) )
    {
        level.escape_vehicle hidepart( "tag_glass_back_d0" );
    }
    
    level.escape_vehicle attach( "veh_t9_civ_ru_sedan_80s_kgb_cp_dest_attach" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 1
// Checksum 0x8ce05073, Offset: 0x2fe8
// Size: 0x6c
function function_3685f662( *params )
{
    if ( level.escape_vehicle haspart( "tag_trunk_d0" ) )
    {
        level.escape_vehicle hidepart( "tag_trunk_d0" );
    }
    
    level.escape_vehicle attach( "veh_t9_civ_ru_sedan_80s_kgb_cp_dest_trunk_attach" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 1
// Checksum 0xca1f5067, Offset: 0x3060
// Size: 0x8c
function function_54f735b0( *params )
{
    if ( self haspart( "tag_glass_right_front_d0" ) )
    {
        self hidepart( "tag_glass_right_front_d0" );
    }
    
    if ( self haspart( "tag_glass_right_rear_d0" ) )
    {
        self hidepart( "tag_glass_right_rear_d0" );
    }
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 1
// Checksum 0x3dee7df9, Offset: 0x30f8
// Size: 0x4c
function function_fd03a68b( *params )
{
    if ( self haspart( "tag_glass_windshield_d0" ) )
    {
        self hidepart( "tag_glass_windshield_d0" );
    }
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 1
// Checksum 0xc41220b5, Offset: 0x3150
// Size: 0xdc
function function_a9ab5a76( *params )
{
    player = getplayers()[ 0 ];
    self show();
    self setvisibletoall();
    player playgestureviewmodel( #"hash_766e9121b19084f0", undefined, 1, 0.2, undefined, 1, 1 );
    level waittill( #"hash_5dd780085338cc6" );
    self hide();
    self setinvisibletoall();
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0xd446ce67, Offset: 0x3238
// Size: 0x150
function infinite_ammo()
{
    player = getplayers()[ 0 ];
    player endon( #"death" );
    
    while ( true )
    {
        primary_weapons = player getweaponslistprimaries();
        offhand_weapons_and_alts = array::exclude( player getweaponslist( 1 ), primary_weapons );
        weapons = arraycombine( primary_weapons, offhand_weapons_and_alts, 0, 0 );
        
        for ( i = 0; i < weapons.size ; i++ )
        {
            weapon = weapons[ i ];
            n_clip_size = player getclipsize( weapon );
            player setweaponammoclip( weapon, n_clip_size );
            player givemaxammo( weapon );
        }
        
        wait 0.05;
    }
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x28e4db2d, Offset: 0x3390
// Size: 0xa4
function function_59171011()
{
    level flag::wait_till_any( [ "player_opened_exfil_tunnel_door", "exfil_escape_move_allies_70" ] );
    level flag::wait_till_timeout( 5, "player_in_exfil_escape_tunnel" );
    spawner::add_spawn_function_ai_group( "exfil_escape_courtyard_tunnel_backup", &function_30265b41 );
    spawn_manager::enable( "exfil_escape_courtyard_tunnel_backup_spawn_manager" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x6d2d6e24, Offset: 0x3440
// Size: 0x24
function function_30265b41()
{
    self ai::set_behavior_attribute( "useGrenades", 0 );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0xb80f6d01, Offset: 0x3470
// Size: 0x24
function function_f08e1bcc()
{
    self ai::set_behavior_attribute( "useGrenades", 0 );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x5c2b7c3, Offset: 0x34a0
// Size: 0x1e4
function function_8c7969b4()
{
    level waittill( #"hash_58d4258e0144099f" );
    level thread function_c6a312d7();
    exploder::exploder( "exfil_escape_tunnel_grenade" );
    namespace_353d803e::function_ad8a133d();
    spawn_manager::disable( "exfil_escape_courtyard_tunnel_backup_spawn_manager" );
    guys = spawner::get_ai_group_ai( "exfil_escape_courtyard_tunnel_backup" );
    var_2eb84b6c = spawn_manager::get_ai( "exfil_escape_courtyard_tunnel_backup_spawn_manager" );
    var_db641a18 = arraycombine( guys, var_2eb84b6c );
    
    foreach ( guy in var_db641a18 )
    {
        guy dodamage( 99999, ( -950, -180, 440 ), level.adler, guy, "none", "MOD_EXPLOSIVE" );
    }
    
    wait 0.1;
    snd::function_9ae4fc6f( "tmp_explo_mid", ( -1150, -180, 440 ) );
    wait 0.1;
    snd::function_9ae4fc6f( "tmp_explo_mid", ( -1250, -180, 440 ) );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x936da9f3, Offset: 0x3690
// Size: 0x6c
function function_c6a312d7()
{
    wait 2.5;
    spawner::add_spawn_function_group( "exfil_escape_courtyard_backup", "targetname", &function_f08e1bcc );
    spawner::simple_spawn( "exfil_escape_courtyard_backup" );
    level thread function_6f1b194c();
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x3f58fbdd, Offset: 0x3708
// Size: 0x27c
function function_cac47141()
{
    level thread scene::play( "scene_kgb_exfil_escape_wall_frisk" );
    level thread scene::play( "scene_kgb_exfil_escape_urgent_radio" );
    level thread scene::play( "scene_kgb_exfil_escape_pacing_guard" );
    level thread scene::play( "scene_kgb_exfil_escape_pacing_guard_02" );
    level thread scene::play( "scene_kgb_exfil_escape_directing_evac_01" );
    level thread scene::play( "scene_kgb_exfil_escape_directing_evac_02" );
    level thread scene::init( "scene_kgb_exfil_escape_stairs" );
    level thread scene::init( "scene_kgb_exfil_escape_frisk" );
    level thread scene::init( "scene_kgb_exfil_escape_radio" );
    level flag::wait_till_any( [ "escape_vehicle_enter", "exfil_escape_russians_cleared" ] );
    level scene::stop( "scene_kgb_exfil_escape_wall_frisk", 1 );
    level scene::stop( "scene_kgb_exfil_escape_urgent_radio", 1 );
    level scene::stop( "scene_kgb_exfil_escape_pacing_guard", 1 );
    level scene::stop( "scene_kgb_exfil_escape_pacing_guard_02", 1 );
    level scene::stop( "scene_kgb_exfil_escape_directing_evac_01", 1 );
    level scene::stop( "scene_kgb_exfil_escape_directing_evac_02", 1 );
    level scene::stop( "scene_kgb_exfil_escape_stairs", 1 );
    level scene::stop( "scene_kgb_exfil_escape_frisk", 1 );
    level scene::stop( "scene_kgb_exfil_escape_radio", 1 );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x94efbad5, Offset: 0x3990
// Size: 0x1dc
function function_796d7c74()
{
    var_be8bf861 = 0.2;
    var_8fbc7640 = 0.9;
    player = getplayers()[ 0 ];
    level waittill( #"hash_48ab167faeb01dbb" );
    player enableweapons();
    player enableweaponcycling();
    player lerpviewangleclamp( 0.5, 0, 0, 35, 35, 10, 10 );
    player.ignoreme = 0;
    level waittill( #"hash_2c0beb312425c5c7" );
    setslowmotion( 1, var_be8bf861, 0.5, 1, var_8fbc7640 );
    level waittill( #"hash_7d7501d3d751f73c" );
    player lerpviewangleclamp( 0.2, 0, 0, 0, 0, 0, 0 );
    level waittill( #"hash_77c37dbef6b09fe" );
    player lerpviewangleclamp( 0.5, 0, 0, 35, 35, 10, 10 );
    level waittill( #"hash_6498bbe6e48dc96d" );
    setslowmotion( var_be8bf861, 1, 0.2, var_8fbc7640, 1 );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x2acfbab3, Offset: 0x3b78
// Size: 0x134
function function_72bfe030()
{
    level endon( #"hash_32e3ef5fcfcdd1" );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    var_72bfe030 = [];
    var_72bfe030[ var_72bfe030.size ] = "vox_cp_rkgb_09000_adlr_bellgetinthecar_da";
    var_72bfe030[ var_72bfe030.size ] = "vox_cp_rkgb_09000_adlr_getinthecarwego_4c";
    var_72bfe030[ var_72bfe030.size ] = "vox_cp_rkgb_09000_adlr_getinbell_03";
    level.adler thread dialogue::queue( "vox_cp_rkgb_09000_adlr_gogogettothecar_0f" );
    wait 10;
    i = 0;
    
    while ( true )
    {
        player thread objectives_ui::show_objectives();
        level.adler dialogue::queue( "" + var_72bfe030[ i ] );
        i++;
        
        if ( i + 1 > var_72bfe030.size )
        {
            i = 0;
        }
        
        wait 10;
    }
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 1
// Checksum 0xbb3b0a8e, Offset: 0x3cb8
// Size: 0x15c
function function_8484087e( *params )
{
    if ( is_true( self.var_65e55583 ) )
    {
        return;
    }
    
    self attach( "c_t9_pl_m_vietnam_torso1_armorheavy1", "j_mainroot" );
    self.var_c681e4c1 = 1;
    self.ignoresuppression = 1;
    self.disablebulletwhizbyreaction = 1;
    self.var_b81bb500 = 1;
    self.dodangerreact = 0;
    self.allowpain = 0;
    self ai::set_behavior_attribute( #"can_be_meleed", 0 );
    self.health *= 7;
    self.var_65e55583 = 1;
    
    if ( isdefined( self.targetname ) )
    {
        if ( issubstr( self.targetname, "adler" ) || issubstr( self.targetname, "inside_man" ) )
        {
            self detach( "c_t9_pl_m_vietnam_torso1_armorheavy1", "j_mainroot" );
        }
    }
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0xf77210ac, Offset: 0x3e20
// Size: 0xb4
function give_lmg()
{
    if ( is_true( self.has_lmg ) )
    {
        return;
    }
    
    self ai::gun_remove();
    lmg = getweapon( #"hash_3e26411a4ac03eb0" );
    self ai::gun_switchto( lmg, "right" );
    self.has_lmg = 1;
    self.primaryweapon = lmg;
    self ai::gun_recall();
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x776c9816, Offset: 0x3ee0
// Size: 0x1a4
function function_8346d62f()
{
    exfil_escape_cover_clip = getentarray( "exfil_escape_cover_clip", "targetname" );
    
    foreach ( clip in exfil_escape_cover_clip )
    {
        clip notsolid();
        clip connectpaths();
    }
    
    exfil_escape_cover_og_clip = getentarray( "exfil_escape_cover_og_clip", "targetname" );
    
    foreach ( clip in exfil_escape_cover_og_clip )
    {
        clip solid();
        clip disconnectpaths();
    }
    
    level flag::set( "exfil_escape_cover_hidden" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0xea62ba97, Offset: 0x4090
// Size: 0x36c
function function_1f999428()
{
    level flag::wait_till( "exfil_escape_cover_hidden" );
    exfil_escape_cover_clip = getentarray( "exfil_escape_cover_clip", "targetname" );
    
    foreach ( clip in exfil_escape_cover_clip )
    {
        clip solid();
        clip disconnectpaths();
    }
    
    exfil_escape_cover_og_clip = getentarray( "exfil_escape_cover_og_clip", "targetname" );
    
    foreach ( clip in exfil_escape_cover_og_clip )
    {
        clip notsolid();
        clip connectpaths();
        clip delete();
    }
    
    clientfield::set( "exfil_cover_models", 1 );
    exfil_escape_cover_model = struct::get_array( "exfil_escape_cover_model", "targetname" );
    
    foreach ( model in exfil_escape_cover_model )
    {
        model.script_model = spawn( "script_model", model.origin );
        model.script_model.angles = model.angles;
        model.script_model setmodel( model.model );
        
        if ( isdefined( model.script_parameters ) )
        {
            model.script_model setscale( float( model.script_parameters ) );
        }
    }
    
    level thread namespace_e77bf565::function_5dfd7fb1( "exfil_escape_nodes", "script_noteworthy", 1 );
    util::function_bfa9c188( "exfil_cover_dyn_models", 1 );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0xe7f79280, Offset: 0x4408
// Size: 0x1ec
function function_f58c4091()
{
    exfil_tunnel_exit_scissor_gate_right = getent( "exfil_tunnel_exit_scissor_gate_right", "targetname" );
    
    if ( isdefined( exfil_tunnel_exit_scissor_gate_right ) )
    {
        exfil_tunnel_exit_scissor_gate_right delete();
    }
    
    exfil_tunnel_exit_scissor_gate_left = getent( "exfil_tunnel_exit_scissor_gate_left", "targetname" );
    
    if ( isdefined( exfil_tunnel_exit_scissor_gate_left ) )
    {
        exfil_tunnel_exit_scissor_gate_left delete();
    }
    
    exfil_tunnel_exit_scissor_gate_clip = getent( "exfil_tunnel_exit_scissor_gate_clip", "targetname" );
    
    if ( isdefined( exfil_tunnel_exit_scissor_gate_clip ) )
    {
        exfil_tunnel_exit_scissor_gate_clip delete();
    }
    
    level.exfil_tunnel_door_left = doors::function_73f09315( "exfil_tunnel_door_left", "targetname" );
    level.exfil_tunnel_door_right = doors::function_73f09315( "exfil_tunnel_door_right", "targetname" );
    doors::unlock( "exfil_tunnel_door_left", "targetname", 0 );
    doors::unlock( "exfil_tunnel_door_right", "targetname", 0 );
    doors::function_f5dd4f8f( "exfil_tunnel_door_left", "targetname", 1 );
    doors::function_f5dd4f8f( "exfil_tunnel_door_right", "targetname", 1 );
    level thread function_7391cebb();
    level thread function_60881101();
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x1fad3e2, Offset: 0x4600
// Size: 0x44
function function_6575a0cf()
{
    doors::function_f35467ac( "exfil_tunnel_door_left", "targetname" );
    doors::function_f35467ac( "exfil_tunnel_door_right", "targetname" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x6b492f86, Offset: 0x4650
// Size: 0x5c
function function_7391cebb()
{
    level endon( #"player_opened_exfil_tunnel_door" );
    doors::waittill_door_opened( "exfil_tunnel_door_left", "targetname" );
    level flag::set( "player_opened_exfil_tunnel_door" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x82572038, Offset: 0x46b8
// Size: 0x5c
function function_60881101()
{
    level endon( #"player_opened_exfil_tunnel_door" );
    doors::waittill_door_opened( "exfil_tunnel_door_right", "targetname" );
    level flag::set( "player_opened_exfil_tunnel_door" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x16b0d88, Offset: 0x4720
// Size: 0x118
function alarm_lights()
{
    var_8ff1cde7 = getentarray( "exfil_escape_alarm_light", "targetname" );
    
    if ( isdefined( var_8ff1cde7 ) )
    {
        foreach ( light in var_8ff1cde7 )
        {
            light setlightintensity( 12000000 );
            playfx( "maps/cp_kgb/fx9_kgb_lf_alarm", light.origin, anglestoforward( light.angles ), anglestoup( light.angles ) );
        }
    }
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x62c322bc, Offset: 0x4840
// Size: 0xd0
function function_6f1b194c()
{
    var_f2334255 = struct::get_array( "exfil_escape_glass_break_org", "targetname" );
    
    foreach ( org in var_f2334255 )
    {
        glassradiusdamage( org.origin, 64, 1000, 500, "MOD_RIFLE_BULLET" );
        wait 0.2;
    }
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x6e64c46f, Offset: 0x4918
// Size: 0x244
function function_3253f5dc()
{
    elevator_hall_dmg_bmodels = getentarray( "elevator_hall_dmg_bmodels", "targetname" );
    
    if ( isdefined( elevator_hall_dmg_bmodels ) )
    {
        foreach ( bmodel in elevator_hall_dmg_bmodels )
        {
            bmodel hide();
        }
    }
    
    level flag::wait_till( "exfil_escape_elevator_guards_explosion_triggered" );
    elevator_hall_clean_bmodels = getentarray( "elevator_hall_clean_bmodels", "targetname" );
    
    if ( isdefined( elevator_hall_clean_bmodels ) )
    {
        foreach ( bmodel in elevator_hall_clean_bmodels )
        {
            bmodel hide();
        }
    }
    
    elevator_hall_dmg_bmodels = getentarray( "elevator_hall_dmg_bmodels", "targetname" );
    
    if ( isdefined( elevator_hall_dmg_bmodels ) )
    {
        foreach ( bmodel in elevator_hall_dmg_bmodels )
        {
            bmodel show();
        }
    }
    
    clientfield::set( "elevator_hall_dmg_models_and_vol_decals", 1 );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0xdb2e7b15, Offset: 0x4b68
// Size: 0x3c
function function_1147675b()
{
    level flag::wait_till( "start_exfil_end_hit_guy" );
    snd::play( "cin_kgb_exfil_chase_carhit" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0xa8ca9709, Offset: 0x4bb0
// Size: 0x74
function function_e8d1d4f9()
{
    self endon( #"death" );
    level flag::wait_till( "player_started_car_escape" );
    wait 1;
    
    if ( isdefined( self ) && isalive( self ) )
    {
        self kill();
    }
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 1
// Checksum 0xd5a49a53, Offset: 0x4c30
// Size: 0x2c
function function_29d84d49( *params )
{
    self setmodel( "emb_cabinet_file_single_open_dmg_anim" );
}

// Namespace kgb_aslt_exfil_escape/namespace_803268d1
// Params 0
// Checksum 0x5aac72e3, Offset: 0x4c68
// Size: 0x54
function function_607a27c4()
{
    level flag::wait_till_any( [ "player_opened_exfil_tunnel_door", "scene_kgb_exfil_door_kick_started" ] );
    spawner::simple_spawn( "exfil_escape_russians" );
}

