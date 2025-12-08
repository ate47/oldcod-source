#using script_1fd2c6e5fc8cb1c3;
#using script_396062ed2667195d;
#using script_3dc93ca9902a9cda;
#using script_4134e1e2e7684c4c;
#using script_44aef2868ad2e317;
#using script_4937c6974f43bb71;
#using script_4ec222619bffcfd1;
#using script_779f525443585713;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace kgb_ins_activation;

// Namespace kgb_ins_activation/namespace_41636311
// Params 1
// Checksum 0x4a637df1, Offset: 0x488
// Size: 0xfc
function starting( *var_d3440450 )
{
    level.checkpoint_clip = getent( "checkpoint_clip", "targetname" );
    level.checkpoint_clip notsolid();
    level.checkpoint_clip_right = getent( "checkpoint_clip_right", "targetname" );
    level.checkpoint_clip_right notsolid();
    level thread scene::init( "scene_kgb_activation" );
    level thread scene::init_streamer( #"scene_kgb_activation", getplayers() );
    level thread namespace_99e99ffa::function_1d90bc4a();
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 2
// Checksum 0x749b3631, Offset: 0x590
// Size: 0x21c
function main( var_d3440450, *var_50cc0d4f )
{
    namespace_82bfe441::fade( 1, "FadeImmediate" );
    level thread scene::init( "scene_kgb_poison_tea" );
    level thread scene::init( "scene_kgb_elevator_holdup" );
    level thread scene::init( "scene_kgb_walkup_adler" );
    level thread function_cb6665bc();
    level thread scene::play( "scene_kgb_ambient_security_vignette" );
    namespace_353d803e::music( "2.0_call" );
    snd::client_msg( #"hash_695d2aba2d66c4b2" );
    level thread function_ea6a0033();
    kgb_ins_prepare::function_52f0fcb3();
    kgb_ins_prepare::function_84d00884();
    level thread namespace_99e99ffa::function_99e99ffa( var_50cc0d4f );
    level thread namespace_e77bf565::function_ada6d016();
    battlechatter::function_2ab9360b( 0 );
    function_30c2cc8f();
    level thread lobby_scene();
    
    if ( isdefined( var_50cc0d4f ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
    
    level flag::wait_till( "ins_activation_complete" );
    namespace_82bfe441::fade( 0, "FadeSlow" );
    namespace_353d803e::function_fef24c06();
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0xef19523, Offset: 0x7b8
// Size: 0x314
function function_cb6665bc()
{
    level endon( #"level_restarting" );
    namespace_6f1d35e1::function_b2911127( 0 );
    wait 0.5;
    namespace_6f1d35e1::function_eea42dd9( #"hash_21ac68bbb6070a7b" );
    namespace_6f1d35e1::function_487b4340( #"hash_6a49038dbf554db" );
    namespace_6f1d35e1::function_5d2e6f6a( 1 );
    namespace_6f1d35e1::function_4951a2c8( 1, 1 );
    wait 2;
    namespace_6f1d35e1::function_487b4340( #"hash_35e421d5b19eafa6" );
    namespace_6f1d35e1::function_5d2e6f6a( 2 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_5cffb9f2( #"hash_22991d7388c6e6bf", 1, 1 );
    level waittill( #"typing_complete" );
    wait 1;
    namespace_6f1d35e1::function_487b4340( #"hash_90177fb520dea18" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 10 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 2, 10 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 3, 10 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_4951a2c8( 4, 10 );
    level waittill( #"Establish_Connection" );
    snd::client_msg( #"hash_4b5a6716aab86d8e" );
    namespace_6f1d35e1::function_5cffb9f2( #"hash_3a975e0e1e2ac322", 4, 1, 0, 50 );
    level waittill( #"typing_complete" );
    wait 1;
    namespace_6f1d35e1::function_487b4340( #"hash_5d1bd5788569d1f8" );
    namespace_6f1d35e1::function_5d2e6f6a( 4 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 4
// Checksum 0xb94bb7b2, Offset: 0xad8
// Size: 0x3c
function cleanup( *name, *starting, *direct, *player )
{
    namespace_6f1d35e1::function_b2911127( 1 );
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0xb02c23c5, Offset: 0xb20
// Size: 0x44
function init_flags()
{
    level flag::init( "ins_activation_complete" );
    level flag::init( "informant_alive" );
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0x80f724d1, Offset: 0xb70
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0xb974f428, Offset: 0xb80
// Size: 0x24
function function_22b7fffd()
{
    level thread scene::init( "scene_kgb_briefing_doorman" );
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0x48f45772, Offset: 0xbb0
// Size: 0x27c
function function_ba654587()
{
    level thread globallogic_ui::function_7bc0e4b9( 0 );
    namespace_6f1d35e1::function_5d2e6f6a( 2 );
    namespace_6f1d35e1::function_4951a2c8( 1 );
    level waittill( #"typing_complete" );
    wait 14;
    namespace_6f1d35e1::function_487b4340( #"hash_2cbc476e04f1edf6" );
    namespace_6f1d35e1::function_5d2e6f6a( 3 );
    namespace_6f1d35e1::function_4951a2c8( 1, 20 );
    level waittill( #"typing_complete" );
    wait 1;
    namespace_6f1d35e1::function_4951a2c8( 2, 30 );
    level waittill( #"typing_complete" );
    wait 1;
    namespace_6f1d35e1::function_4951a2c8( 3, 20 );
    level waittill( #"typing_complete" );
    wait 1;
    namespace_6f1d35e1::function_4951a2c8( 4, 30 );
    level waittill( #"typing_complete" );
    wait 1;
    namespace_6f1d35e1::function_4951a2c8( 5, 20 );
    level waittill( #"typing_complete" );
    wait 0.5;
    namespace_6f1d35e1::function_4951a2c8( 6, 20 );
    level waittill( #"typing_complete" );
    wait 1;
    namespace_6f1d35e1::function_4951a2c8( 7, 30 );
    level waittill( #"typing_complete" );
    wait 0.5;
    namespace_6f1d35e1::function_4951a2c8( 8, 20 );
    level waittill( #"typing_complete" );
    wait 2;
    level flag::set( "ins_activation_complete" );
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0x80f724d1, Offset: 0xe38
// Size: 0x4
function function_f0db4949()
{
    
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0x80f724d1, Offset: 0xe48
// Size: 0x4
function function_964bc23e()
{
    
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0xc8e5aa50, Offset: 0xe58
// Size: 0x3c
function function_94e65ad5()
{
    level flag::wait_till( "player_in_briefing_room" );
    self delete();
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0x7aa376a2, Offset: 0xea0
// Size: 0x44
function function_ea6a0033()
{
    level flag::wait_till( "player_in_briefing_room" );
    level scene::stop( "scene_kgb_ambient_security_vignette", 1 );
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0x2078e010, Offset: 0xef0
// Size: 0x84
function lobby_scene()
{
    level flag::wait_till( "flag_start_lobby_scene" );
    level thread scene::play( "lobby_scene_1" );
    level flag::wait_till( "player_in_briefing_room" );
    level scene::stop( "lobby_scene_1", 1 );
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0x8ecfba00, Offset: 0xf80
// Size: 0x6e4
function function_30c2cc8f()
{
    getplayers()[ 0 ] flag::set( "cp_rus_kgb_player_ready" );
    namespace_e77bf565::function_f6eb250d( "cinematicmotion_kgb_computer" );
    level scene::play( "scene_kgb_activation", "Start" );
    level thread scene::play( "scene_kgb_activation", "Intro_Loop" );
    wait 1.75;
    level dialogue::function_96171f6d( "vox_cp_rkgb_01000_adlr_imsorryithought_58" );
    var_e077503c = dialog_tree::new_tree( undefined, undefined, 1, 1 );
    var_e077503c dialog_tree::function_6bb91351( 1 );
    var_e077503c dialog_tree::add_option( #"hash_54efabbe2388ef19", undefined, undefined, undefined, 1, undefined, undefined );
    var_e077503c dialog_tree::run();
    level notify( #"Establish_Connection" );
    level scene::play( "scene_kgb_activation", "Establish_Connection" );
    level thread scene::play( "scene_kgb_activation", "Loop" );
    wait 4;
    var_5ed6e2b0 = dialog_tree::new_tree( undefined, undefined, 1, 1 );
    var_5ed6e2b0 dialog_tree::add_option( #"hash_5c304c1661aee8e8", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_wereinthetunnel_92" );
    var_5ed6e2b0 dialog_tree::add_option( #"hash_5c304f1661aeee01", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_wereinthetunnel_92" );
    var_5ed6e2b0 dialog_tree::add_option( #"hash_5c304e1661aeec4e", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_wereinthetunnel_92" );
    var_5ed6e2b0 dialog_tree::run();
    function_4d361b8e();
    var_ab5165ed = dialog_tree::new_tree( undefined, undefined, 1, 1 );
    var_ab5165ed dialog_tree::add_option( #"hash_5c2c281661aac2e5", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_theresalwaysapr_2b" );
    var_ab5165ed dialog_tree::add_option( #"hash_5c2c251661aabdcc", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_notyetiknowyouh_bf" );
    choice = var_ab5165ed dialog_tree::run();
    
    if ( choice == 0 )
    {
        var_c4ee992b = dialog_tree::new_tree( undefined, undefined, 1, 1 );
        var_c4ee992b dialog_tree::add_option( #"hash_5c29401661a8b5d6", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_weregettingthef_8d" );
        var_c4ee992b dialog_tree::add_option( #"hash_5c293f1661a8b423", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_belikovyoumight_9e" );
        var_c4ee992b dialog_tree::run();
    }
    else
    {
        var_c4ee992b = dialog_tree::new_tree( undefined, undefined, 1, 1 );
        var_c4ee992b dialog_tree::add_option( #"hash_5c293e1661a8b270", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_weregettingthef_8d" );
        var_c4ee992b dialog_tree::add_option( #"hash_5c29451661a8be55", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_belikovyoumight_9e" );
        var_c4ee992b dialog_tree::run();
    }
    
    function_47eb7c9e();
    
    if ( namespace_94c47ce5::function_11b2b847() )
    {
        namespace_94c47ce5::function_ef6de0f0();
    }
    
    level dialogue::function_96171f6d( "vox_cp_rkgb_01000_adlr_wellmeetyouatth_b1" );
    snd::client_msg( #"hash_72fda24008633c70" );
    var_8fd5aef6 = dialog_tree::new_tree( undefined, undefined, 1, 1 );
    var_8fd5aef6 dialog_tree::function_6bb91351( 1 );
    var_8fd5aef6 dialog_tree::add_option( #"hash_54efa8be2388ea00", undefined, undefined, undefined, 1, undefined, undefined );
    var_8fd5aef6 dialog_tree::run();
    snd::client_msg( #"hash_3d26d1914456dcbe" );
    namespace_6f1d35e1::function_b2911127( 0 );
    snd::client_msg( #"hash_3398664455247bac" );
    snd::client_msg( #"hash_441b6b70aae75c67" );
    level notify( #"hash_b7d623ab42e754a" );
    level scene::play( "scene_kgb_activation", "End" );
    namespace_e77bf565::function_f6eb250d();
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 1
// Checksum 0x5ce2e23f, Offset: 0x1670
// Size: 0x84
function function_3d2a48a7( var_ef7f50ee )
{
    if ( !isarray( var_ef7f50ee ) )
    {
        level dialogue::function_96171f6d( var_ef7f50ee );
        return;
    }
    
    for ( i = 0; i < var_ef7f50ee.size ; i++ )
    {
        iprintlnbold( var_ef7f50ee[ i ] );
        wait 0.5;
    }
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0x94ce5485, Offset: 0x1700
// Size: 0xc2
function function_64747129()
{
    namespace_6f1d35e1::function_5cffb9f2( #"hash_5ceb589c9935a37e", 7, 1 );
    level waittill( #"typing_complete" );
    namespace_6f1d35e1::function_487b4340( #"hash_4ef7a9c966dac71c" );
    namespace_6f1d35e1::function_5d2e6f6a( 1 );
    namespace_6f1d35e1::function_4951a2c8( 1, 50 );
    level waittill( #"typing_complete" );
    wait 1;
    wait 0.5;
    wait 1;
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0xf72892c0, Offset: 0x17d0
// Size: 0x1c
function function_4d361b8e()
{
    namespace_6f1d35e1::function_5d2e6f6a( 5 );
}

// Namespace kgb_ins_activation/namespace_41636311
// Params 0
// Checksum 0x50109968, Offset: 0x17f8
// Size: 0x1c
function function_47eb7c9e()
{
    namespace_6f1d35e1::function_5d2e6f6a( 6 );
}

