#using script_1fd2c6e5fc8cb1c3;
#using script_2d443451ce681a;
#using script_4ec222619bffcfd1;
#using script_7901e9dc8618be8a;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace kgb_aslt_bunker;

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 1
// Checksum 0xdb5e30cf, Offset: 0x830
// Size: 0xc
function starting( *var_d3440450 )
{
    
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 2
// Checksum 0x10aba7c8, Offset: 0x848
// Size: 0x2cc
function main( var_d3440450, var_50cc0d4f )
{
    level flag::set( "aslt_bunker_begin" );
    spawner::add_spawn_function_ai_group( "bunker_intro_security", &function_5f5e32bd );
    
    if ( is_true( var_50cc0d4f ) )
    {
        level thread scene::init( "scene_kgb_bunker_intro_elevator" );
    }
    
    level thread scene::init( "scene_kgb_door_kick" );
    level thread scene::init( "scene_kgb_utility_room_adler" );
    level thread scene::init( "scene_kgb_utility_room_player" );
    player = getplayers()[ 0 ];
    player setlowready( 1 );
    level thread function_8f134086();
    level thread namespace_e77bf565::function_7feb07bb( var_d3440450, var_50cc0d4f );
    level thread function_1c059274();
    level thread function_deb648d2();
    level thread function_c8052750();
    
    if ( !isdefined( level.adler ) )
    {
        level.adler = namespace_e77bf565::adler_spawn( var_d3440450 );
        level.adler namespace_e77bf565::function_5770c74( "assault" );
    }
    
    level.adler.ignoreall = 0;
    level.adler.ignoreme = 0;
    level thread function_c353f42a();
    level thread function_8279b9f2();
    namespace_353d803e::music( "10.0_combat_intro" );
    level thread namespace_bed29d94::function_a0d18564();
    level flag::wait_till( "aslt_bunker_complete" );
    
    if ( isdefined( var_d3440450 ) )
    {
        skipto::function_4e3ab877( var_d3440450 );
    }
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0xdc5f59d2, Offset: 0xb20
// Size: 0x62a
function function_b735db01()
{
    level.adler endon( #"death" );
    level.player endon( #"death" );
    level notify( #"hash_49ad3ddc839a715c" );
    ai::setaiattribute( level.adler, "can_melee", 0 );
    level.adler.script_accuracy = 500;
    level.adler.perfectaim = 1;
    level.adler.ignoresuppression = 1;
    scene::remove_scene_func( "scene_kgb_bunker_intro_adler", &function_b735db01, "done" );
    scene::remove_scene_func( "scene_kgb_bunker_intro_adler", &function_b735db01, "stop" );
    bunker_intro_adler_node = getnode( "bunker_intro_adler_node", "targetname" );
    level.adler.fixednode = 1;
    level.adler spawner::go_to_node( bunker_intro_adler_node );
    level flag::wait_till( "bunker_intro_security_cleared" );
    level.adler.script_accuracy = 1;
    level.adler.perfectaim = 0;
    level.adler.ignoresuppression = 0;
    level flag::set( "enable_adler_kick_door" );
    level flag::wait_till( "start_adler_door_kick" );
    level.adler.fixednode = 0;
    level scene::play( "scene_kgb_door_kick", "Enter" );
    ai::setaiattribute( level.adler, "can_melee", 1 );
    level.adler colors::set_force_color( "g" );
    level.adler colors::enable();
    level flag::wait_till( "player_reached_end_of_bunker" );
    enemies = getaiteamarray( #"axis" );
    
    foreach ( enemy in enemies )
    {
        if ( isdefined( enemy ) && isalive( enemy ) )
        {
            if ( distancesquared( enemy.origin, level.player.origin ) > 722500 )
            {
                enemy delete();
            }
        }
    }
    
    level.adler.script_accuracy = 500;
    level.adler.perfectaim = 1;
    level.adler.ignoresuppression = 1;
    
    while ( true )
    {
        if ( level flag::get( "aslt_bunker_complete" ) )
        {
            break;
        }
        
        enemies = getaiteamarray( #"axis" );
        
        if ( isdefined( enemies ) && isdefined( enemies.size ) )
        {
            if ( enemies.size == 0 )
            {
                wait 1;
                continue;
            }
            
            if ( enemies.size <= 6 )
            {
                foreach ( enemy in enemies )
                {
                    if ( isdefined( enemy ) && isalive( enemy ) )
                    {
                        if ( isdefined( enemy.script_noteworthy ) && enemy.script_noteworthy == "retreat_and_delete_because_cannot_seek_player" )
                        {
                            if ( isdefined( enemy.script_parameters ) )
                            {
                                node = getnode( enemy.script_parameters, "targetname" );
                                
                                if ( isdefined( node ) )
                                {
                                    enemy thread namespace_e77bf565::function_bf9d2fd0( node );
                                    continue;
                                }
                            }
                        }
                        
                        enemy thread function_a99a76b0();
                        wait randomfloatrange( 0.1, 3 );
                    }
                }
            }
            else
            {
                wait 1;
                continue;
            }
            
            continue;
        }
        
        wait 1;
        continue;
    }
    
    level.adler.script_accuracy = 1;
    level.adler.perfectaim = 0;
    level.adler.ignoresuppression = 0;
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0xe714eeea, Offset: 0x1158
// Size: 0xe4
function function_a99a76b0()
{
    self endon( #"death" );
    level.player endon( #"death" );
    closest = arraysortclosest( [ level.player, level.adler ], self.origin );
    target = closest[ 0 ];
    self.ignoresuppression = 1;
    self.goalradius = 300;
    self setgoal( target, 1 );
    self namespace_e77bf565::function_7d2d1987( 1440000, undefined, 1 );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0xe578e7b0, Offset: 0x1248
// Size: 0x24
function function_5f5e32bd()
{
    ai::setaiattribute( level.adler, "can_melee", 0 );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0xa8f58fd2, Offset: 0x1278
// Size: 0x6c
function function_a6d1922d()
{
    player = getplayers()[ 0 ];
    
    while ( true )
    {
        if ( player adsbuttonpressed() )
        {
            level notify( #"hash_742020afbebe9132" );
            break;
        }
        
        wait 0.05;
    }
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0x7692b3ed, Offset: 0x12f0
// Size: 0x5c
function function_8f134086()
{
    level waittill( #"hash_742020afbebe9132" );
    player = getplayers()[ 0 ];
    player setlowready( 0 );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 4
// Checksum 0xdb740b31, Offset: 0x1358
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0x38a4ecb0, Offset: 0x1388
// Size: 0x104
function init_flags()
{
    level flag::init( "aslt_bunker_begin" );
    level flag::init( "aslt_bunker_complete" );
    level flag::init( "bunker_intro_runners_fallback" );
    level flag::init( "bunker_three_story_guys_fallback" );
    level flag::init( "bunker_pre_conf_room_initial_guys_fallback" );
    level flag::init( "bunker_pre_conf_room_guys_fallback" );
    level flag::init( "bunker_conf_room_guys_fallback" );
    level flag::init( "enable_obj_retrieve_intel" );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0x80f724d1, Offset: 0x1498
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0x80f724d1, Offset: 0x14a8
// Size: 0x4
function function_22b7fffd()
{
    
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0x18f291de, Offset: 0x14b8
// Size: 0x484
function function_8279b9f2()
{
    level.var_8dad5090 = "React_Fast";
    level.bunker_intro_phone = util::spawn_anim_model( "rus_phone_wall_01_anim" );
    var_6b5c13c2 = [];
    var_6b5c13c2[ #"bunker_intro_phone" ] = level.bunker_intro_phone;
    level thread scene::play( "scene_kgb_bunker_intro_elevator", "Start" );
    scene::add_scene_func( "scene_kgb_bunker_intro_guard01", &function_25831409, "Loop" );
    level thread scene::play( "scene_kgb_bunker_intro_guard01", "Loop" );
    scene::add_scene_func( "scene_kgb_bunker_intro_guard02", &function_c44b308e, "Loop" );
    level thread scene::play( "scene_kgb_bunker_intro_guard02", "Loop" );
    scene::add_scene_func( "scene_kgb_bunker_intro_guard03", &function_65b9c362, "Loop" );
    level thread scene::play( "scene_kgb_bunker_intro_guard03", "Loop" );
    level thread scene::play( "scene_kgb_bunker_intro_guard04", "Loop" );
    level thread scene::play( "scene_kgb_bunker_intro_phone", "Loop", var_6b5c13c2 );
    scene::add_scene_func( "scene_kgb_bunker_intro_adler", &function_b735db01, "done" );
    scene::add_scene_func( "scene_kgb_bunker_intro_adler", &function_b735db01, "stop" );
    level thread scene::play( "scene_kgb_bunker_intro_adler", "Start", [ level.adler ] );
    level thread function_a6d1922d();
    level thread function_476dd8fe();
    level waittill( #"hash_49ad3ddc839a715c", #"bunker_intro_security_cleared" );
    namespace_353d803e::music( "10.2_combat_loop" );
    
    if ( scene::is_active( "scene_kgb_bunker_intro_adler" ) )
    {
        if ( !isdefined( level.var_e2e2c645 ) )
        {
            level scene::stop( "scene_kgb_bunker_intro_adler" );
        }
    }
    
    scene::add_scene_func( "scene_kgb_bunker_intro_guard01", &function_97192259, level.var_8dad5090 );
    level thread scene::play( "scene_kgb_bunker_intro_guard01", level.var_8dad5090 );
    scene::add_scene_func( "scene_kgb_bunker_intro_guard02", &function_1cb30cf6, level.var_8dad5090 );
    level thread scene::play( "scene_kgb_bunker_intro_guard02", level.var_8dad5090 );
    scene::add_scene_func( "scene_kgb_bunker_intro_guard03", &function_82cb64f1, level.var_8dad5090 );
    level thread scene::play( "scene_kgb_bunker_intro_guard03", level.var_8dad5090 );
    level thread scene::play( "scene_kgb_bunker_intro_guard04", level.var_8dad5090 );
    level thread scene::play( "scene_kgb_bunker_intro_phone", level.var_8dad5090 );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0x17ed6789, Offset: 0x1948
// Size: 0x50
function function_c8052750()
{
    level waittill( #"hash_619863a87e777fd1" );
    level.var_8dad5090 = "React";
    level.var_e2e2c645 = 1;
    level notify( #"hash_49ad3ddc839a715c" );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0x4058b449, Offset: 0x19a0
// Size: 0x50
function function_476dd8fe()
{
    player = getplayers()[ 0 ];
    player waittill( #"weapon_fired" );
    level notify( #"hash_49ad3ddc839a715c" );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0xf22e5f7f, Offset: 0x19f8
// Size: 0x164
function function_1c059274()
{
    level flag::wait_till( "bunker_intro_security_cleared" );
    level thread savegame::checkpoint_save( 0 );
    level.adler dialogue::queue( "vox_cp_rkgb_03300_adlr_thiswaytothevau_e7" );
    level flag::wait_till( "adler_vo_keep_moving" );
    level thread savegame::checkpoint_save( 0 );
    level.adler dialogue::queue( "vox_cp_rkgb_03400_adlr_keepmovingtowar_27" );
    level flag::wait_till( "adler_vo_advance" );
    level.adler dialogue::queue( "vox_cp_rkgb_03400_adlr_advance_d3" );
    level thread savegame::checkpoint_save( 0 );
    level flag::wait_till( "adler_vo_getting_close" );
    level.adler dialogue::queue( "vox_cp_rkgb_03400_adlr_weregettingclos_a7" );
    level thread savegame::checkpoint_save( 0 );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0x1a9eb572, Offset: 0x1b68
// Size: 0xcc
function function_6e6f3309()
{
    level thread namespace_e77bf565::function_23705b46( "bunker_intro_runners", 2, "bunker_intro_runners_fallback" );
    level thread namespace_e77bf565::function_23705b46( "bunker_three_story_guys", 3, "bunker_three_story_guys_fallback" );
    level thread namespace_e77bf565::function_23705b46( "bunker_pre_conf_room_initial_guys", 2, "bunker_pre_conf_room_initial_guys_fallback" );
    level thread namespace_e77bf565::function_23705b46( "bunker_pre_conf_room_guys", 2, "bunker_pre_conf_room_guys_fallback" );
    level thread namespace_e77bf565::function_23705b46( "bunker_conf_room_guys", 3, "bunker_conf_room_guys_fallback" );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0x80f724d1, Offset: 0x1c40
// Size: 0x4
function function_deb648d2()
{
    
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 0
// Checksum 0xfea197f9, Offset: 0x1c50
// Size: 0xbc
function function_c353f42a()
{
    level flag::wait_till_all( [ "bunker_intro_security_cleared", "bunker_intro_runners_cleared", "bunker_secondary_guys_cleared", "bunker_three_story_guys_cleared", "bunker_pre_conf_room_initial_guys_cleared", "bunker_pre_conf_room_guys_cleared", "bunker_conf_room_guys_cleared", "bunker_end_guys_cleared" ] );
    level flag::set( "aslt_bunker_complete" );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 1
// Checksum 0xa404dcf6, Offset: 0x1d18
// Size: 0x94
function function_25831409( a_ents )
{
    guy = a_ents[ #"bunker_intro_guard01" ];
    guy endon( #"death" );
    level endon( #"hash_619863a87e777fd1" );
    level waittill( #"hash_5945fb19f4765b76" );
    guy thread dialogue::queue( "vox_cp_rkgb_03300_rms1_laugh_62" );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 1
// Checksum 0x9932c8a3, Offset: 0x1db8
// Size: 0x8c
function function_97192259( a_ents )
{
    guy = a_ents[ #"bunker_intro_guard01" ];
    guy endon( #"death" );
    guy thread dialogue::function_47b06180();
    level waittill( #"hash_3d671f3adb08034" );
    guy thread dialogue::queue( "vox_cp_rkgb_03300_rms1_putthoseweapons_c7", undefined, 1 );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 1
// Checksum 0x26bf50be, Offset: 0x1e50
// Size: 0x94
function function_c44b308e( a_ents )
{
    guy = a_ents[ #"bunker_intro_guard02" ];
    guy endon( #"death" );
    level endon( #"hash_619863a87e777fd1" );
    level waittill( #"hash_2597a9a7421731ab" );
    guy thread dialogue::queue( "vox_cp_rkgb_03300_rms2_laugh_62" );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 1
// Checksum 0xdd47ac6, Offset: 0x1ef0
// Size: 0x8c
function function_1cb30cf6( a_ents )
{
    guy = a_ents[ #"bunker_intro_guard02" ];
    guy endon( #"death" );
    guy thread dialogue::function_47b06180();
    level waittill( #"hash_51e288b6c1579efd" );
    guy thread dialogue::queue( "vox_cp_rkgb_03300_rms2_thisareasofflim_44", undefined, 1 );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 1
// Checksum 0x6a7eacba, Offset: 0x1f88
// Size: 0xcc
function function_65b9c362( a_ents )
{
    guy = a_ents[ #"bunker_intro_guard03" ];
    guy endon( #"death" );
    level endon( #"hash_619863a87e777fd1" );
    level waittill( #"hash_772597925aee74a4" );
    guy thread dialogue::queue( "vox_cp_rkgb_03300_rms3_laugh_62" );
    level waittill( #"hash_51063caa12ea0f88" );
    guy thread dialogue::queue( "vox_cp_rkgb_03300_rms3_andbeforekravch_31", undefined, 1 );
}

// Namespace kgb_aslt_bunker/namespace_329b9fe5
// Params 1
// Checksum 0x283b514f, Offset: 0x2060
// Size: 0x54
function function_82cb64f1( a_ents )
{
    guy = a_ents[ #"bunker_intro_guard03" ];
    guy endon( #"death" );
    guy thread dialogue::function_47b06180();
}

