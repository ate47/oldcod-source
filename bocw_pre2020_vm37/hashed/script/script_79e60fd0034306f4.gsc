#using script_11d98532ca8f6c58;
#using script_2d443451ce681a;
#using script_4937c6974f43bb71;
#using script_4ab78e327b76395f;
#using script_758226507b1afa11;
#using script_86ebb5dd573a003;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
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
#using scripts\cp_common\bb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace namespace_f8073734;

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xae7cb75d, Offset: 0x1280
// Size: 0xe4
function init_flags()
{
    level flag::init( "warehouse_intro_opening_vo_done" );
    level flag::init( "kill_greta" );
    level flag::init( "warehouse_intro_ai_rappelling" );
    level flag::init( "warehouse_intro_park_goal_reached" );
    level flag::init( "warehouse_intro_give_player_gun" );
    level flag::init( "warehouse_dialog_end_a" );
    level flag::init( "warehouse_dialog_end_b" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 1
// Checksum 0xb73ad297, Offset: 0x1370
// Size: 0x4c
function intro_start( *str_objective )
{
    level.var_375ea1c1 = spawner::simple_spawn_single( "warehouse_volkov" );
    level flag::set( "informant_released" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 2
// Checksum 0xde9c7f7f, Offset: 0x13c8
// Size: 0x2a4
function intro_main( *str_objective, *var_50cc0d4f )
{
    savegame::checkpoint_save();
    level.player val::set( "wake_up", "show_weapon_hud", 0 );
    level thread function_ea2f2e25();
    level scene::init( "p9_fxanim_cp_stakeout_elevated_train_01_bundle" );
    level.var_9c4a751d = 1;
    level notify( #"hash_617ae3084a75a5b0" );
    util::function_268bdf4f( "park" );
    level.lazar = spawner::simple_spawn_single( "warehouse_lazar" );
    level.lazar.is_hero = 1;
    level.lazar util::magic_bullet_shield();
    level.adler = spawner::simple_spawn_single( "warehouse_adler" );
    level.adler.is_hero = 1;
    level.adler util::magic_bullet_shield();
    level thread function_e807f2c6();
    level thread function_639f072c();
    level thread function_131f5dc5();
    level thread warehouse_intro_enemies();
    level thread function_677b97d8( "park_window_grenade", "glass_park", "park_window_shatter" );
    level thread function_677b97d8( "lazar_window_grenade", "glass_lazar", "lazar_window_shatter" );
    level thread function_677b97d8( "adler_window_grenade", "glass_adler", "adler_window_shatter" );
    level thread function_853aef38();
    level flag::wait_till( "warehouse_intro_done" );
    skipto::function_4e3ab877( "warehouse_intro" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xb9fd4fb7, Offset: 0x1678
// Size: 0xe4
function function_e807f2c6()
{
    level endon( #"mission_failed" );
    namespace_11998b8f::stakeout_stow_weapon();
    level waittill( #"hash_7c33da3b415e547d" );
    level flag::set( "warehouse_give_player_weapon" );
    level.player val::set( "wake_up", "show_weapon_hud", 1 );
    level.player val::set( "knock_out", "show_crosshair", 1 );
    namespace_11998b8f::function_cdb7cc7e();
    namespace_11998b8f::function_a73e6a64();
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xb94fc2d2, Offset: 0x1768
// Size: 0x24
function function_dfdd2f82()
{
    level thread namespace_82bfe441::fade( 0, "FadeImmediate" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x6632763f, Offset: 0x1798
// Size: 0x64
function function_aba6a2e8()
{
    level.adler colors::set_force_color( "b" );
    level.lazar colors::set_force_color( "g" );
    level.park colors::set_force_color( "r" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xbf52a853, Offset: 0x1808
// Size: 0x2b0
function function_94c482e0()
{
    level endon( #"mission_failed" );
    warehouse_door_to_meeting = doors::get_doors( "warehouse_door_to_meeting" )[ 0 ];
    doors::lock( "warehouse_door_to_outro", "targetname" );
    lock_doors = [];
    warehouse_entrance_door = doors::get_doors( "warehouse_entrance_door" )[ 0 ];
    
    if ( !isdefined( lock_doors ) )
    {
        lock_doors = [];
    }
    else if ( !isarray( lock_doors ) )
    {
        lock_doors = array( lock_doors );
    }
    
    lock_doors[ lock_doors.size ] = warehouse_entrance_door;
    var_195859c8 = doors::get_doors( "warehouse_door_to_exit_room" )[ 0 ];
    
    if ( !isdefined( lock_doors ) )
    {
        lock_doors = [];
    }
    else if ( !isarray( lock_doors ) )
    {
        lock_doors = array( lock_doors );
    }
    
    lock_doors[ lock_doors.size ] = var_195859c8;
    warehouse_spawn_closet_door_upper = doors::get_doors( "warehouse_spawn_closet_door_upper" )[ 0 ];
    
    if ( !isdefined( lock_doors ) )
    {
        lock_doors = [];
    }
    else if ( !isarray( lock_doors ) )
    {
        lock_doors = array( lock_doors );
    }
    
    lock_doors[ lock_doors.size ] = warehouse_spawn_closet_door_upper;
    warehouse_spawn_closet_door = doors::get_doors( "warehouse_spawn_closet_door" )[ 0 ];
    
    if ( !isdefined( lock_doors ) )
    {
        lock_doors = [];
    }
    else if ( !isarray( lock_doors ) )
    {
        lock_doors = array( lock_doors );
    }
    
    lock_doors[ lock_doors.size ] = warehouse_spawn_closet_door;
    
    foreach ( door in lock_doors )
    {
        door doors::lock();
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x35aafcbf, Offset: 0x1ac0
// Size: 0x714
function function_131f5dc5()
{
    level flag::wait_till( "level_is_go" );
    player = getplayers()[ 0 ];
    player val::set( "warehouse", "ignoreme", 1 );
    player val::reset( "apartment_to_warehouse", "freezecontrols" );
    battlechatter::function_2ab9360b( 0 );
    level.adler val::set( "warehouse_intro", "ignoreme", 1 );
    level.lazar val::set( "warehouse_intro", "ignoreme", 1 );
    level.park val::set( "warehouse_intro", "ignoreme", 1 );
    level thread function_3eeef9bb();
    player.animname = "player 1";
    level.adler.animname = "adler";
    level.lazar.animname = "lazar";
    level.park.animname = "park";
    level thread function_44f6ffee();
    level thread function_66685f();
    var_84ccdeed = #"hash_57683ed4de0128fe";
    var_3997c880 = #"hash_57683dd4de01274b";
    var_1fd89502 = #"hash_57683cd4de012598";
    var_4419dea4 = #"hash_576c66d4de0555cd";
    var_4dcbf208 = #"hash_576c63d4de0550b4";
    var_d98d098c = #"hash_576c64d4de055267";
    level.var_27da2f39 = dialog_tree::new_tree( &function_cddf31f8, undefined, 1, 1, "scene_z_stk_warehouse_dt" );
    level.var_27da2f39 dialog_tree::add_option( var_84ccdeed, undefined, "fu_response", "loop", 1, undefined, undefined, &function_f23b762a );
    level.var_27da2f39 dialog_tree::add_option( var_3997c880, undefined, "eliminate_u_response", "loop", 1, undefined, undefined, &function_e31e5b0e );
    level.var_27da2f39 dialog_tree::add_option( var_1fd89502, undefined, "i_know_u_response", "loop", 1, undefined, undefined, &function_1a6949a3 );
    level.var_58759087 = dialog_tree::new_tree( undefined, undefined, 1, 1, "scene_z_stk_warehouse_dt" );
    level.var_58759087 dialog_tree::add_option( var_3997c880, undefined, "eliminate_u_response", "loop", 1, undefined, undefined, &function_e31e5b0e );
    level.var_58759087 dialog_tree::add_option( var_4419dea4, undefined, "end", "end_loop", 1, undefined, undefined, &warehouse_dialog_end_b );
    level.var_58759087 dialog_tree::add_option( var_1fd89502, undefined, "i_know_u_response", "loop", 1, undefined, undefined, &function_1a6949a3 );
    level.var_4a3df400 = dialog_tree::new_tree( undefined, undefined, 1, 1, "scene_z_stk_warehouse_dt" );
    level.var_4a3df400 dialog_tree::add_option( var_84ccdeed, undefined, "end", "end_loop", 1, undefined, undefined, &warehouse_dialog_end_b );
    level.var_4a3df400 dialog_tree::add_option( var_4dcbf208, undefined, [ "smuggling_nukes_response", "end" ], "end_loop", 1, undefined, undefined, &function_acd56d69 );
    level.var_4a3df400 dialog_tree::add_option( var_1fd89502, undefined, "i_know_u_response", "loop", 1, undefined, undefined, &function_1a6949a3 );
    level.var_cb1375a9 = dialog_tree::new_tree( undefined, undefined, 1, 1, "scene_z_stk_warehouse_dt" );
    level.var_cb1375a9 dialog_tree::add_option( var_d98d098c, undefined, [ "tell_me_where_response", "end" ], "end_loop", 1, undefined, undefined, &function_971341e5 );
    level.var_cb1375a9 dialog_tree::add_option( var_3997c880, undefined, "end", "end_loop", 1, undefined, undefined, &warehouse_dialog_end_a );
    level.var_375ea1c1 val::set( "warehouse", "ignoreme", 1 );
    level.var_375ea1c1 val::set( "warehouse", "ignoreall", 1 );
    level.var_27da2f39 thread dialog_tree::run( level.var_375ea1c1, undefined, undefined, undefined, 1 );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xe9fcb7e, Offset: 0x21e0
// Size: 0x134
function function_44f6ffee()
{
    if ( level flag::get( "informant_released" ) )
    {
        level.var_66d09511 = getent( "warehouse_informant", "targetname", 1 );
        scene::play( "scene_z_stk_warehouse_dt_informant", "intro_start" );
        scene::play( "scene_z_stk_warehouse_dt_informant", "intro_info" );
        scene::play( "scene_z_stk_warehouse_dt_informant", "intro_end" );
        level thread scene::play( "scene_z_stk_warehouse_dt_informant", "loop" );
        level flag::wait_till_any( array( "warehouse_dialog_end_a", "warehouse_dialog_end_b" ) );
        level thread scene::play( "scene_z_stk_warehouse_dt_informant", "end" );
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x5b15286e, Offset: 0x2320
// Size: 0x194
function function_66685f()
{
    level.var_ffeb9413 = getent( "warehouse_greta", "targetname", 1 );
    scene::play( "scene_z_stk_warehouse_dt_greta", "intro_start" );
    
    if ( level flag::get( "informant_released" ) )
    {
        scene::play( "scene_z_stk_warehouse_dt_greta", "intro_info" );
    }
    
    scene::play( "scene_z_stk_warehouse_dt_greta", "intro_end" );
    level thread scene::play( "scene_z_stk_warehouse_dt_greta", "loop" );
    level thread function_e736d047();
    level flag::wait_till_any( array( "warehouse_dialog_end_a", "warehouse_dialog_end_b" ) );
    
    if ( !level flag::get( "kill_greta" ) )
    {
        level scene::play( "scene_z_stk_warehouse_dt_greta", "end" );
        level thread scene::play( "scene_z_stk_warehouse_dt_greta", "loop" );
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xdcac2419, Offset: 0x24c0
// Size: 0x74
function function_e736d047()
{
    level flag::wait_till( "kill_greta" );
    level scene::play( "scene_z_stk_warehouse_dt_greta", "fu_response" );
    level thread scene::play( "scene_z_stk_warehouse_dt_greta", "dead_loop" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xe5bb0185, Offset: 0x2540
// Size: 0xac
function function_cddf31f8()
{
    scene::play( "scene_z_stk_warehouse_dt", "intro_start" );
    
    if ( level flag::get( "informant_released" ) )
    {
        scene::play( "scene_z_stk_warehouse_dt", "intro_info" );
    }
    
    scene::play( "scene_z_stk_warehouse_dt", "intro_end" );
    level thread scene::play( "scene_z_stk_warehouse_dt", "loop" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x6e5ad223, Offset: 0x25f8
// Size: 0xdc
function function_3eeef9bb()
{
    level.park waittill( #"end_vo" );
    
    if ( !level flag::get( "kill_greta" ) )
    {
        level.park dialogue::queue( "vox_cp_stkt_13400_park_illhelpherandse_c4" );
    }
    else
    {
        level.park dialogue::queue( "vox_cp_stkt_13400_park_illsecurethecas_49" );
    }
    
    level thread function_c63cd141();
    level flag::set( "warehouse_intro_opening_vo_done" );
    level flag::set( "warehouse_intro_done" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xf62548e6, Offset: 0x26e0
// Size: 0x6c
function function_f23b762a()
{
    level flag::set( "kill_greta" );
    level.var_375ea1c1 waittill( #"dialog_tree_scene_response_complete" );
    level.var_58759087 thread dialog_tree::run( level.var_375ea1c1, undefined, undefined, undefined, 1 );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x80639553, Offset: 0x2758
// Size: 0x4c
function function_e31e5b0e()
{
    level.var_375ea1c1 waittill( #"dialog_tree_scene_response_complete" );
    level.var_4a3df400 thread dialog_tree::run( level.var_375ea1c1, undefined, undefined, undefined, 1 );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x66c3959a, Offset: 0x27b0
// Size: 0x4c
function function_1a6949a3()
{
    level.var_375ea1c1 waittill( #"dialog_tree_scene_response_complete" );
    level.var_cb1375a9 thread dialog_tree::run( level.var_375ea1c1, undefined, undefined, undefined, 1 );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xcd47ed59, Offset: 0x2808
// Size: 0x1c
function function_acd56d69()
{
    level thread warehouse_dialog_end_a();
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xdec633c9, Offset: 0x2830
// Size: 0x1c
function function_971341e5()
{
    level warehouse_dialog_end_a();
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x4d0bd389, Offset: 0x2858
// Size: 0x1d4
function warehouse_dialog_end_a()
{
    level flag::set( "warehouse_dialog_end_a" );
    level thread function_dc4b560d();
    music::setmusicstate( "16.0_finale", undefined );
    level.var_375ea1c1 waittill( #"end_vo" );
    level.var_375ea1c1 thread dialogue::queue( "vox_cp_stkt_13300_vlkv_youhavefailedno_66" );
    player = getplayers()[ 0 ];
    player val::set( "warehouse", "ignoreme", 0 );
    level waittill( #"hash_2c8fbda941438cbe" );
    level.var_375ea1c1 val::set( "warehouse", "ignoreme", 1 );
    level.var_375ea1c1 val::set( "warehouse", "ignoreall", 1 );
    level.var_375ea1c1 ai::set_behavior_attribute( "demeanor", "combat" );
    level.var_375ea1c1 thread ai::force_goal( getnode( "warehouse_intro_volkov_runaway_pos", "targetname" ) );
    wait 6;
    level.var_375ea1c1 thread function_1de6c9b7();
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x322ae024, Offset: 0x2a38
// Size: 0x1d4
function warehouse_dialog_end_b()
{
    level flag::set( "warehouse_dialog_end_b" );
    level thread function_dc4b560d();
    music::setmusicstate( "16.0_finale", undefined );
    level.var_375ea1c1 waittill( #"end_vo" );
    level.var_375ea1c1 thread dialogue::queue( "vox_cp_stkt_13300_vlkv_idonotlikespies_fe" );
    player = getplayers()[ 0 ];
    player val::set( "warehouse", "ignoreme", 0 );
    level waittill( #"hash_2c8fbda941438cbe" );
    level.var_375ea1c1 val::set( "warehouse", "ignoreme", 1 );
    level.var_375ea1c1 val::set( "warehouse", "ignoreall", 1 );
    level.var_375ea1c1 ai::set_behavior_attribute( "demeanor", "combat" );
    level.var_375ea1c1 thread ai::force_goal( getnode( "warehouse_intro_volkov_runaway_pos", "targetname" ) );
    wait 6;
    level.var_375ea1c1 thread function_1de6c9b7();
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xa6d23852, Offset: 0x2c18
// Size: 0xe4
function function_c63cd141()
{
    level thread function_aba6a2e8();
    waitframe( 1 );
    trigger::use( "warehouse_intro_ally_move_01", "targetname" );
    level.adler val::set( "warehouse_intro", "ignoreall", 0 );
    level.adler val::set( "warehouse_intro", "ignoreme", 0 );
    level.lazar val::set( "warehouse_intro", "ignoreall", 0 );
    level.lazar val::set( "warehouse_intro", "ignoreme", 0 );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xce00abe8, Offset: 0x2d08
// Size: 0x4c
function function_1f6e9d44()
{
    player = getplayers()[ 0 ];
    self ai::set_behavior_attribute( "demeanor", "combat" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x40d8d143, Offset: 0x2d60
// Size: 0x6c
function warehouse_intro_enemies()
{
    level endon( #"mission_failed" );
    spawner::add_spawn_function_group( "warehouse_intro_enemies", "targetname", &function_ce44c432 );
    level.var_2724698 = spawner::simple_spawn( "warehouse_intro_enemies" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xa96e41a0, Offset: 0x2dd8
// Size: 0x194
function function_ce44c432()
{
    self endon( #"death" );
    self.health = 1;
    self val::set( "warehouse", "ignoreall", 1 );
    self ai::set_behavior_attribute( "demeanor", "patrol" );
    self thread animation::enable_headlook_notorso( 1 );
    level waittill( #"hash_7b2b890e79274cc" );
    wait randomfloatrange( 0.3, 0.6 );
    self val::set( "warehouse", "ignoreall", 0 );
    self ai::set_behavior_attribute( "demeanor", "combat" );
    self lookatentity( level.park );
    wait randomfloatrange( 2, 3.5 );
    wait 0.75;
    
    if ( isdefined( self ) && isalive( self ) )
    {
        self kill();
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x9ff1d20f, Offset: 0x2f78
// Size: 0xcc
function function_dc4b560d()
{
    level waittill( #"hash_2399d9df0270889e" );
    level thread function_332986a1( "park_window_shatter", "warehouse_intro_gas_park_start", "warehouse_intro_gas_park_end" );
    level thread function_332986a1( "lazar_window_shatter", "warehouse_intro_gas_lazar_start", "warehouse_intro_gas_lazar_end" );
    level thread function_332986a1( "adler_window_shatter", "warehouse_intro_gas_adler_start", "warehouse_intro_gas_adler_end" );
    wait 4;
    exploder::exploder( "temp_warehouse_smoke" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 3
// Checksum 0x5554945, Offset: 0x3050
// Size: 0xc4
function function_332986a1( break_notify, var_8c04d509, var_ada1e239 )
{
    level waittill( break_notify );
    var_af827872 = getent( var_8c04d509, "targetname" );
    var_af2e70d5 = getent( var_ada1e239, "targetname" );
    magicbullet( getweapon( #"pistol_semiauto_t9", "suppressed" ), var_af827872.origin, var_af2e70d5.origin );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 3
// Checksum 0x242ca2fb, Offset: 0x3120
// Size: 0x9c
function function_677b97d8( var_ef943c8, var_2d29a1e2, var_79efa269 )
{
    decal = getent( var_2d29a1e2, "targetname" );
    decal hide();
    level waittill( var_ef943c8 );
    decal show();
    level waittill( var_79efa269 );
    decal delete();
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x69eab4f6, Offset: 0x31c8
// Size: 0xd2
function function_1de6c9b7()
{
    self endon( #"death" );
    
    if ( isdefined( self ) && isalive( self ) )
    {
        self clearforcedgoal();
        waitframe( 1 );
        node = getnode( "warehouse_outro_volkov_end_pos", "targetname" );
        self forceteleport( node.origin, node.angles );
        self setgoal( node, 1 );
        self.fixednode = 1;
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x8ca93559, Offset: 0x32a8
// Size: 0x5c
function function_853aef38()
{
    level flag::wait_till_any( array( "warehouse_dialog_end_a", "warehouse_dialog_end_b" ) );
    level thread scene::play_from_time( "p9_fxanim_cp_stakeout_elevated_train_01_bundle", undefined, undefined, 0.2 );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 1
// Checksum 0xd36c9c77, Offset: 0x3310
// Size: 0x2d4
function start( *str_objective )
{
    util::function_268bdf4f( "park" );
    level flag::set( "warehouse_intro_done" );
    level flag::set( "warehouse_give_player_weapon" );
    level.lazar = spawner::simple_spawn_single( "warehouse_lazar_spawner" );
    level.lazar.is_hero = 1;
    level.lazar util::magic_bullet_shield();
    level.adler = spawner::simple_spawn_single( "warehouse_adler_spawner" );
    level.adler.is_hero = 1;
    level.adler util::magic_bullet_shield();
    level thread scene::play( "scene_z_stk_warehouse_dt", "end_loop" );
    level.var_9c4a751d = 1;
    level thread function_639f072c();
    level.var_375ea1c1 = spawner::simple_spawn_single( "warehouse_volkov" );
    waitframe( 1 );
    level.lazar clearforcedgoal();
    level.adler clearforcedgoal();
    level.park clearforcedgoal();
    level.park val::set( "warehouse_combat", "ignoreall", 1 );
    level thread function_aba6a2e8();
    level.var_375ea1c1 = getent( "warehouse_volkov", "targetname", 1 );
    level.var_375ea1c1 thread function_ef769f0d( "warehouse_outro_volkov_end_pos" );
    level.park thread function_ef769f0d( "warehouse_combat_park_node" );
    wait 2;
    trigger::use( "warehouse_intro_ally_move_01", "targetname" );
    exploder::exploder( "temp_warehouse_smoke" );
    music::setmusicstate( "16.0_finale", undefined );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 2
// Checksum 0x97844efe, Offset: 0x35f0
// Size: 0x24c
function main( *str_objective, *var_50cc0d4f )
{
    level thread function_55737f44();
    level thread function_59e47159();
    savegame::checkpoint_save( 1 );
    level.park.holdfire = 1;
    level.adler ai::enable_careful();
    level.lazar ai::enable_careful();
    level.adler.script_accuracy = 0.2;
    level.lazar.script_accuracy = 0.2;
    level.adler.ignoresuppression = 1;
    level.lazar.ignoresuppression = 1;
    createthreatbiasgroup( "allies" );
    createthreatbiasgroup( "player" );
    createthreatbiasgroup( "warehouse_enemies" );
    getplayers()[ 0 ] setthreatbiasgroup( "player" );
    level.adler setthreatbiasgroup( "allies" );
    level.lazar setthreatbiasgroup( "allies" );
    level thread function_ad178f3f();
    level thread function_e47b21fa();
    level thread function_2525ab9b();
    level thread warehouse_combat();
    level flag::wait_till( "flag_warehouse_outro_door" );
    skipto::function_4e3ab877( "warehouse" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x553d5dca, Offset: 0x3848
// Size: 0x18c
function function_ad178f3f()
{
    player = getplayers()[ 0 ];
    objectives::scripted( "kill_or_capture_obj", undefined, #"hash_1c73a293c174c216" );
    wait 0.5;
    var_f8d522f5 = struct::get( "obj_outro_door_pos", "targetname" );
    objectives::goto( "outro_door", var_f8d522f5 );
    level flag::wait_till( "flag_warehouse_combat_vo" );
    id = objectives::function_285e460( "outro_door", var_f8d522f5 );
    thread objectives_ui::function_f3ac479c( id );
    player thread objectives_ui::show_objectives();
    level thread doors::unlock( "warehouse_door_to_outro", "targetname", 0 );
    level flag::wait_till( "flag_warehouse_outro_door" );
    objectives::remove( "kill_or_capture_obj" );
    objectives::remove( "outro_door", var_f8d522f5 );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xb0bf41d, Offset: 0x39e0
// Size: 0x5a4
function warehouse_combat()
{
    battlechatter::function_2ab9360b( 1 );
    level thread function_85177212();
    level thread function_2cc3a1be();
    flag::wait_till_any_timeout( 3, [ "flag_start_forklift_event", "flag_start_lazar_event" ] );
    wave1_enemies = spawner::simple_spawn( "warehouse_enemy_wave_01", &function_f471eec0 );
    level thread ai::function_b0bd06fa( "warehouse_enemies", 2, "warehouse_retreat_enemy_1" );
    level flag::wait_till( "warehouse_retreat_enemy_1" );
    level thread ai::function_eb9f3f65( "warehouse_enemies", "warehouse_enemy_vol_02", undefined, undefined, undefined, undefined, 7 );
    waitframe( 1 );
    level thread function_a099daab( "warehouse_ally_move_01" );
    level flag::set( "warehouse_spawn_wave_02_br" );
    wave2_enemies = spawner::simple_spawn( "warehouse_enemy_wave_02", &function_f471eec0 );
    level thread ai::function_b0bd06fa( "warehouse_enemies", 4, "warehouse_retreat_enemy_2" );
    level flag::wait_till( "warehouse_retreat_enemy_2" );
    level thread ai::function_eb9f3f65( "warehouse_enemies", "warehouse_enemy_vol_03", undefined, undefined, undefined, undefined, 6 );
    waitframe( 1 );
    enemies = spawner::get_ai_group_ai( "warehouse_enemies" );
    var_b6d2a469 = array::random( enemies );
    var_b6d2a469 ai::set_goal( "warehouse_enemy_vol_03_catwalk", "targetname", 1 );
    level thread function_a099daab( "warehouse_ally_move_03" );
    level thread function_a2c72e4b( "warehouse_ally_move_01", "warehouse_retreat_enemy_2" );
    level thread function_a2c72e4b( "warehouse_ally_move_02", "warehouse_retreat_enemy_2" );
    var_25dc55fa = spawner::simple_spawn( "warehouse_enemy_wave_03", &function_f471eec0 );
    level thread ai::function_b0bd06fa( "warehouse_enemies", 3, "warehouse_retreat_enemy_3" );
    level flag::wait_till( "warehouse_retreat_enemy_3" );
    level thread ai::function_eb9f3f65( "warehouse_enemies", "warehouse_enemy_vol_04", undefined, undefined, undefined, undefined, 7 );
    waitframe( 1 );
    level thread function_a099daab( "warehouse_ally_move_06" );
    level thread function_a2c72e4b( "warehouse_ally_move_04", "warehouse_retreat_enemy_3" );
    level thread function_a2c72e4b( "warehouse_ally_move_05", "warehouse_retreat_enemy_3" );
    var_1cb07350 = spawner::simple_spawn( "warehouse_enemy_wave_04", &function_f471eec0 );
    
    if ( isdefined( level.adler ) && isalive( level.adler ) )
    {
        level.adler.script_accuracy = 0.85;
        self.perfectaim = 1;
    }
    
    if ( isdefined( level.lazar ) && isalive( level.lazar ) )
    {
        level.lazar.script_accuracy = 0.85;
        level.lazar.perfectaim = 1;
    }
    
    level thread ai::function_b0bd06fa( "warehouse_enemies", 2, "warehouse_retreat_enemy_final" );
    flag::wait_till_timeout( 30, "warehouse_retreat_enemy_final" );
    level thread function_397c4f92();
    level thread ai::function_b0bd06fa( "warehouse_enemies", 0, "warehouse_combat_over" );
    flag::wait_till_timeout( 5, "warehouse_combat_over" );
    level thread function_3266ad2c();
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xbdcbc8f8, Offset: 0x3f90
// Size: 0x128
function function_397c4f92()
{
    level endon( #"mission_failed" );
    player = getplayers()[ 0 ];
    player endon( #"death" );
    enemies = spawner::get_ai_group_ai( "warehouse_enemies" );
    
    foreach ( guy in enemies )
    {
        if ( isdefined( guy ) && isalive( guy ) )
        {
            guy.health = 1;
            guy setgoal( player, 1 );
        }
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 1
// Checksum 0x8dbd23a, Offset: 0x40c0
// Size: 0x7c
function function_ef769f0d( teleport_node )
{
    node = getnode( teleport_node, "targetname" );
    self forceteleport( node.origin, node.angles );
    self setgoal( node, 1 );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x86809c34, Offset: 0x4148
// Size: 0xa6
function function_85177212()
{
    level endon( #"warehouse_kill_bathroom_event" );
    level flag::wait_till( "flag_warehouse_toilet_enemy" );
    wait 0.5;
    namespace_5ceacc03::function_875a6922();
    
    if ( !level flag::get( "warehouse_kill_bathroom_event" ) )
    {
        var_791550cf = spawner::simple_spawn_single( "warehouse_enemy_toilet", &function_f471eec0 );
        return;
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xeb015203, Offset: 0x41f8
// Size: 0x8e
function function_2cc3a1be()
{
    level endon( #"warehouse_kill_breakroom_event" );
    level flag::wait_till( "flag_warehouse_breakroom_enemy" );
    
    if ( !level flag::get( "warehouse_kill_breakroom_event" ) )
    {
        var_c71bf7 = spawner::simple_spawn_single( "warehouse_enemy_breakroom", &function_f471eec0 );
        return;
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x9d7173f4, Offset: 0x4290
// Size: 0x64
function function_e47b21fa()
{
    level flag::wait_till( "flag_warehouse_combat_vo" );
    level.adler dialogue::radio( "vox_cp_stkt_13500_adlr_bellvolkovwentt_2b" );
    level.park dialogue::radio( "vox_cp_stkt_13500_park_hesmorevaluable_ca" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x34afb4c5, Offset: 0x4300
// Size: 0x164
function function_2525ab9b()
{
    level endon( #"flag_warehouse_outro_door" );
    flag::wait_till( "warehouse_retreat_enemy_3" );
    nags = [];
    speaker = [];
    nags[ nags.size ] = "vox_cp_stkt_13500_adlr_getaftervolkovb_df";
    speaker[ speaker.size ] = level.adler;
    nags[ nags.size ] = "vox_cp_stkt_13500_park_wecantletvolkov_61";
    speaker[ speaker.size ] = level.park;
    nags[ nags.size ] = "vox_cp_stkt_13500_adlr_volkovsgettinga_20";
    speaker[ speaker.size ] = level.adler;
    nags[ nags.size ] = "vox_cp_stkt_13500_park_bellgoaftervolk_95";
    speaker[ speaker.size ] = level.park;
    wait 5;
    i = 0;
    
    while ( !flag::get( "flag_warehouse_outro_door" ) )
    {
        speaker[ i ] dialogue::queue( "" + nags[ i ] );
        i++;
        
        if ( i >= nags.size )
        {
            i = 0;
        }
        
        wait 15;
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x20e3f374, Offset: 0x4470
// Size: 0x34
function function_f471eec0()
{
    self endon( #"death" );
    self setthreatbiasgroup( "warehouse_enemies" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 1
// Checksum 0xc12cee50, Offset: 0x44b0
// Size: 0x28c
function outro_start( *str_objective )
{
    util::function_268bdf4f( "park" );
    util::function_268bdf4f( "lazar" );
    doors::lock( "warehouse_entrance_door" );
    doors::lock( "warehouse_door_to_outro", "targetname" );
    level thread doors::unlock( "warehouse_door_to_outro", "targetname", 0 );
    level flag::set( "warehouse_intro_done" );
    level flag::set( "warehouse_give_player_weapon" );
    level.var_9c4a751d = 1;
    level.adler = spawner::simple_spawn_single( "warehouse_adler_spawner" );
    waitframe( 1 );
    level.adler thread function_ef769f0d( "warehouse_outro_adler_start_node" );
    level.lazar thread function_ef769f0d( "warehouse_outro_lazar_node" );
    level.park thread function_ef769f0d( "warehouse_intro_park_node" );
    level.adler colors::set_force_color( "b" );
    level.park colors::set_force_color( "r" );
    level.var_375ea1c1 = spawner::simple_spawn_single( "warehouse_volkov" );
    level.var_375ea1c1 thread function_ef769f0d( "warehouse_outro_volkov_end_pos" );
    level.var_375ea1c1 val::set( "warehouse", "ignoreall", 1 );
    level.var_375ea1c1 val::set( "warehouse", "ignoreme", 1 );
    level.var_375ea1c1.animname = "volkov";
    trigger::use( "warehouse_outro_ally_move_01", "targetname" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 2
// Checksum 0x5e5a250e, Offset: 0x4748
// Size: 0x1c4
function outro_main( str_objective, *var_50cc0d4f )
{
    music::setmusicstate( "null" );
    battlechatter::function_2ab9360b( 0 );
    level thread function_27777aad();
    level thread function_6b148d96();
    level.adler val::set( "warehouse", "ignoreall", 1 );
    level.adler val::set( "warehouse", "ignoreme", 1 );
    
    if ( !isdefined( level.var_375ea1c1 ) )
    {
        level.var_375ea1c1 = spawner::simple_spawn_single( "warehouse_outro_volkov" );
    }
    
    level thread function_82d03a33();
    level.var_375ea1c1 thread function_6aa51edd();
    level.var_375ea1c1.health = 1;
    level.var_375ea1c1.dontdropweapon = 1;
    level thread function_f038b760();
    level flag::wait_till( "warehouse_outro_end" );
    skipto::function_4e3ab877( var_50cc0d4f );
    skipto::function_1c2dfc20( "cp_rus_amerika" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xef77e160, Offset: 0x4918
// Size: 0x124
function function_82d03a33()
{
    player = getplayers()[ 0 ];
    wait 0.5;
    objectives::goto( "kill_or_capture_obj", level.var_375ea1c1.origin + ( 0, 0, 75 ), #"hash_1c73a293c174c216", 1, 0 );
    level flag::wait_till( "flag_warehouse_outro_scene_start" );
    
    if ( isdefined( level.var_375ea1c1 ) && isalive( level.var_375ea1c1 ) )
    {
        objectives::function_67f87f80( "kill_or_capture_obj", undefined, #"hash_213a842d18f87d1d" );
        player thread objectives_ui::show_objectives();
        level.var_375ea1c1 thread function_b22fe3db();
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x45bbcf94, Offset: 0x4a48
// Size: 0x19c
function function_b22fe3db()
{
    self endon( #"death" );
    player = getplayers()[ 0 ];
    self.var_c681e4c1 = 1;
    player.takedown.disabled = 1;
    
    if ( isalive( self ) && isdefined( self ) )
    {
        level.var_cb14744d = util::spawn_model( "tag_origin", self.origin, self.angles );
        level.var_cb14744d linkto( self );
        level.var_cb14744d util::create_cursor_hint( "tag_origin", ( 0, 0, 43 ), #"hash_6c7bb285599937ba", 350, undefined, undefined, undefined, undefined, undefined, 0, 1 );
        level.var_cb14744d waittill( #"trigger" );
        level flag::set( "flag_warehouse_outro_volkov_capture" );
        self stopsounds();
        objectives::complete( "kill_or_capture_obj" );
        level.var_cb14744d util::remove_cursor_hint();
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x46f90e4a, Offset: 0x4bf0
// Size: 0x8c
function function_6aa51edd()
{
    self waittill( #"death" );
    level flag::set( "flag_warehouse_outro_volkov_killed" );
    self stopsounds();
    objectives::complete( "kill_or_capture_obj" );
    
    if ( isdefined( level.var_cb14744d ) )
    {
        level.var_cb14744d util::remove_cursor_hint();
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xa9992aa9, Offset: 0x4c88
// Size: 0xd4
function function_f038b760()
{
    level thread scene::play( "scene_z_stk_warehouse_cornered", "intro_loop", [ level.var_375ea1c1 ] );
    flag::wait_till( "flag_warehouse_outro_scene_start" );
    scene::stop( "scene_z_stk_warehouse_cornered" );
    level thread scene::play( "scene_z_stk_warehouse_cornered", "shot 1", [ level.var_375ea1c1 ] );
    level waittill( #"hash_270d598a9405d904" );
    level thread function_40509d9e();
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x5f384636, Offset: 0x4d68
// Size: 0x7c
function function_27777aad()
{
    level endon( #"flag_warehouse_outro_volkov_capture" );
    level endon( #"flag_warehouse_outro_volkov_killed" );
    level thread function_e7edd44c();
    level thread function_433af336();
    level thread function_da8622e6();
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x3b695ad4, Offset: 0x4df0
// Size: 0xcc
function function_40509d9e()
{
    level endon( #"flag_warehouse_outro_volkov_killed" );
    level endon( #"flag_warehouse_outro_volkov_capture" );
    wait 3;
    level.var_375ea1c1 dialogue::queue( "vox_cp_stkt_13600_vlkv_youknowihavesee_95" );
    wait 3;
    level.var_375ea1c1 dialogue::queue( "vox_cp_stkt_13600_vlkv_yougoingtodosom_e5" );
    wait 3;
    level.var_375ea1c1 dialogue::queue( "vox_cp_stkt_13600_vlkv_yourepathetic_db" );
    wait 3;
    level flag::set( "warehouse_outro_volkov_attack" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xd704d6ea, Offset: 0x4ec8
// Size: 0x14c
function function_e7edd44c()
{
    level endon( #"flag_warehouse_outro_volkov_capture" );
    level flag::wait_till( "flag_warehouse_outro_volkov_killed" );
    
    if ( isdefined( level.adler ) )
    {
        if ( isdefined( level.adler.magic_bullet_shield ) )
        {
            level.adler util::stop_magic_bullet_shield();
        }
        
        level.adler delete();
    }
    
    waitframe( 1 );
    level thread scene::play( "scene_z_stk_warehouse_kill_ending", [ level.park, level.lazar ] );
    
    if ( !level flag::get( "kill_greta" ) )
    {
        level thread scene::play( "scene_z_stk_warehouse_kill_ending_greta" );
    }
    
    level waittill( #"fade_out" );
    level flag::set( "warehouse_outro_end" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x88257bb8, Offset: 0x5020
// Size: 0x1ac
function function_433af336()
{
    level endon( #"flag_warehouse_outro_volkov_killed" );
    player = getplayers()[ 0 ];
    level flag::wait_till( "flag_warehouse_outro_volkov_capture" );
    
    if ( isdefined( level.adler ) )
    {
        if ( isdefined( level.adler.magic_bullet_shield ) )
        {
            level.adler util::stop_magic_bullet_shield();
        }
        
        level.adler delete();
    }
    
    waitframe( 1 );
    scene::stop( "scene_z_stk_warehouse_cornered" );
    level thread scene::play( "scene_z_stk_warehouse_captured_ending", [ player, level.var_375ea1c1, level.park, level.lazar ] );
    
    if ( !level flag::get( "kill_greta" ) )
    {
        level thread scene::play( "scene_z_stk_warehouse_captured_ending_greta" );
    }
    
    player waittill( #"fade_out" );
    level flag::set( "warehouse_outro_end" );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x52c8bc18, Offset: 0x51d8
// Size: 0x114
function function_da8622e6()
{
    level endon( #"flag_warehouse_outro_volkov_killed" );
    level endon( #"flag_warehouse_outro_volkov_capture" );
    level flag::wait_till( "warehouse_outro_volkov_attack" );
    player = getplayers()[ 0 ];
    scene::stop( "scene_z_stk_warehouse_cornered" );
    level thread scene::play( "scene_z_stk_warehouse_cornered", "shoot", [ level.var_375ea1c1 ] );
    level waittill( #"hash_501366e9fb99c760" );
    player dodamage( player.health + 500, player.origin, level.var_375ea1c1 );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x118d5fae, Offset: 0x52f8
// Size: 0x12c
function function_66c00fee()
{
    teleport::hero( level.adler, "warehouse_outro_teleport" );
    teleport::hero( level.park, "warehouse_outro_teleport" );
    level.adler ai::set_behavior_attribute( "demeanor", "cqb" );
    level.park ai::set_behavior_attribute( "demeanor", "cqb" );
    node = getnode( "warehouse_outro_adler_node", "targetname" );
    level.adler setgoal( node, 1 );
    node = getnode( "warehouse_outro_park_node", "targetname" );
    level.park setgoal( node, 1 );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xd271fc60, Offset: 0x5430
// Size: 0x12a
function function_6b148d96()
{
    level endon( #"flag_warehouse_outro_volkov_killed" );
    level endon( #"flag_warehouse_outro_volkov_capture" );
    level endon( #"warehouse_outro_volkov_attack" );
    player = getplayers()[ 0 ];
    checkvol = getent( "warehouse_outro_player_check_vol", "targetname" );
    level flag::wait_till( "warehouse_outro_volkov_attack_start" );
    
    while ( true )
    {
        if ( player istouchingvolume( checkvol.origin, checkvol getmins(), checkvol getmaxs() ) )
        {
            level flag::set( "warehouse_outro_volkov_attack" );
            continue;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xc4ebc61, Offset: 0x5568
// Size: 0x9c
function function_d72718a1()
{
    setslowmotion( 1, 0.15, 0.25 );
    level waittilltimeout( 1.5, #"hash_2342375c4243cd85", #"hash_755094c9bc31be45" );
    setslowmotion( 0.15, 1, 0.25 );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x574ebb80, Offset: 0x5610
// Size: 0x8c
function function_233956ed()
{
    level.warehouse_enemies = [];
    
    if ( !isdefined( level.warehouse_enemies ) )
    {
        level.warehouse_enemies = [];
    }
    else if ( !isarray( level.warehouse_enemies ) )
    {
        level.warehouse_enemies = array( level.warehouse_enemies );
    }
    
    level.warehouse_enemies[ level.warehouse_enemies.size ] = self;
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xfa50deb3, Offset: 0x56a8
// Size: 0x104
function function_59e47159()
{
    explo_pos = getent( "warehouse_adler_explo_pos", "targetname" );
    var_af2e70d5 = getent( "warehouse_adler_explo_end_pos", "targetname" );
    var_8cafb845 = spawner::simple_spawn( "warehouse_adler_enemies" );
    namespace_5ceacc03::function_af3d3d18( var_8cafb845 );
    level flag::wait_till_any_timeout( 6, array( "flag_start_lazar_event", "flag_start_forklift_event" ) );
    magicbullet( getweapon( #"pistol_semiauto_t9" ), explo_pos.origin, var_af2e70d5.origin );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x8b4c0966, Offset: 0x57b8
// Size: 0xe4
function function_55737f44()
{
    scene::init( "aib_vign_stakeout_warehouse_lazar_takedown", [ level.lazar ] );
    level flag::wait_till_any_timeout( 4, array( "flag_start_lazar_event", "flag_start_forklift_event" ) );
    scene::play( "aib_vign_stakeout_warehouse_lazar_takedown", [ level.lazar ] );
    level.lazar.perfectaim = 0;
    level.lazar.script_accuracy = 0.15;
    level.lazar clearentitytarget();
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x82484311, Offset: 0x58a8
// Size: 0xdc
function function_ea2f2e25()
{
    player = getplayers()[ 0 ];
    setdvar( #"r_motionblurmode", 0 );
    player clientfield::set_to_player( "knock_out_vision", 1 );
    wait 2;
    level lui::screen_fade_in( 5 );
    wait 0.5;
    level lui::screen_fade_out( 6 );
    wait 1.5;
    level lui::screen_fade_in( 7 );
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0x300122d1, Offset: 0x5990
// Size: 0x2c0
function function_639f072c()
{
    lock_doors = [];
    warehouse_entrance_door = doors::get_doors( "warehouse_entrance_door" )[ 0 ];
    
    if ( !isdefined( lock_doors ) )
    {
        lock_doors = [];
    }
    else if ( !isarray( lock_doors ) )
    {
        lock_doors = array( lock_doors );
    }
    
    lock_doors[ lock_doors.size ] = warehouse_entrance_door;
    var_195859c8 = doors::get_doors( "warehouse_door_to_exit_room" )[ 0 ];
    
    if ( !isdefined( lock_doors ) )
    {
        lock_doors = [];
    }
    else if ( !isarray( lock_doors ) )
    {
        lock_doors = array( lock_doors );
    }
    
    lock_doors[ lock_doors.size ] = var_195859c8;
    warehouse_spawn_closet_door_upper = doors::get_doors( "warehouse_spawn_closet_door_upper" )[ 0 ];
    
    if ( !isdefined( lock_doors ) )
    {
        lock_doors = [];
    }
    else if ( !isarray( lock_doors ) )
    {
        lock_doors = array( lock_doors );
    }
    
    lock_doors[ lock_doors.size ] = warehouse_spawn_closet_door_upper;
    warehouse_spawn_closet_door = doors::get_doors( "warehouse_spawn_closet_door" )[ 0 ];
    
    if ( !isdefined( lock_doors ) )
    {
        lock_doors = [];
    }
    else if ( !isarray( lock_doors ) )
    {
        lock_doors = array( lock_doors );
    }
    
    lock_doors[ lock_doors.size ] = warehouse_spawn_closet_door;
    warehouse_door_to_outro = doors::get_doors( "warehouse_door_to_outro" )[ 0 ];
    
    if ( !isdefined( lock_doors ) )
    {
        lock_doors = [];
    }
    else if ( !isarray( lock_doors ) )
    {
        lock_doors = array( lock_doors );
    }
    
    lock_doors[ lock_doors.size ] = warehouse_door_to_outro;
    
    foreach ( door in lock_doors )
    {
        door doors::lock();
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 1
// Checksum 0xd823963d, Offset: 0x5c58
// Size: 0x4c
function function_a099daab( var_9c878bb5 )
{
    wait 1.5;
    
    if ( isdefined( getent( var_9c878bb5, "targetname" ) ) )
    {
        trigger::use( var_9c878bb5 );
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 2
// Checksum 0x57d3842d, Offset: 0x5cb0
// Size: 0x8c
function function_a2c72e4b( var_9c878bb5, set_flag )
{
    if ( flag::get( set_flag ) && isdefined( getent( var_9c878bb5, "targetname" ) ) )
    {
        trigger = getent( var_9c878bb5, "targetname" );
        trigger delete();
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 0
// Checksum 0xbc35e615, Offset: 0x5d48
// Size: 0xc8
function function_3266ad2c()
{
    enemies = spawner::get_ai_group_ai( "warehouse_enemies" );
    
    foreach ( enemy in enemies )
    {
        if ( isdefined( enemy ) && isalive( enemy ) )
        {
            enemy thread function_69f192ab();
        }
    }
}

// Namespace namespace_f8073734/namespace_f8073734
// Params 3
// Checksum 0x57b1424a, Offset: 0x5e18
// Size: 0x180
function function_69f192ab( distsquared, fov = 360000, *var_a729919a = cos( 45 ) )
{
    self endon( #"death" );
    e_player = getplayers()[ 0 ];
    e_player endon( #"death" );
    
    while ( true )
    {
        wait 0.1;
        
        if ( distancesquared( e_player.origin, self.origin ) < fov )
        {
            continue;
        }
        
        if ( !util::within_fov( e_player geteye(), e_player getplayerangles(), self geteye(), var_a729919a ) )
        {
            self notify( #"hash_17b0a9d5a9585319" );
            
            if ( !isdefined( self.magic_bullet_shield ) )
            {
                self kill();
                continue;
            }
            
            self util::stop_magic_bullet_shield();
            self kill();
        }
    }
}

