#using script_1fd2c6e5fc8cb1c3;
#using script_3dc93ca9902a9cda;
#using script_44aef2868ad2e317;
#using script_4ec222619bffcfd1;
#using script_779f525443585713;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\snd_utility;
#using scripts\cp_common\util;

#namespace kgb_aslt_entry;

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 1
// Checksum 0x4b922609, Offset: 0x6d0
// Size: 0x9c
function starting( *var_d3440450 )
{
    level thread function_272c06e0();
    level thread namespace_e77bf565::function_8191bcdc( 1 );
    level.adler = namespace_e77bf565::adler_spawn( "kgb_aslt_entry" );
    level.adler.ignoreme = 1;
    level.adler.ignoreall = 1;
    level thread namespace_99e99ffa::function_1d90bc4a();
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 2
// Checksum 0x6b530fc4, Offset: 0x778
// Size: 0x184
function main( var_d3440450, var_50cc0d4f )
{
    if ( is_true( var_50cc0d4f ) )
    {
        kgb_ins_prepare::function_52f0fcb3();
        kgb_ins_prepare::function_84d00884();
        level thread namespace_99e99ffa::function_99e99ffa( var_d3440450 );
        level thread namespace_e77bf565::function_ada6d016();
        level thread scene::play( "scene_kgb_walkup_adler", "Shot 4", [ level.adler ] );
        namespace_e77bf565::function_c4de67de();
    }
    
    player = getplayers()[ 0 ];
    player.ignoreme = 1;
    player.ignoreall = 1;
    level flag::set( "flag_prep_elevator" );
    level thread function_9e8ed6b4();
    function_5c4d2cf9();
    level thread function_c7b22bd4();
    
    if ( isdefined( var_d3440450 ) )
    {
        skipto::function_4e3ab877( var_d3440450 );
    }
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 4
// Checksum 0x2fa0cf79, Offset: 0x908
// Size: 0x24
function cleanup( *name, *starting, *direct, *player )
{
    
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0xc0918e16, Offset: 0x938
// Size: 0x24
function init_flags()
{
    level flag::init( "aslt_entry_complete" );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x80f724d1, Offset: 0x968
// Size: 0x4
function init_clientfields()
{
    
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x80f724d1, Offset: 0x978
// Size: 0x4
function function_22b7fffd()
{
    
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0xdb640cb8, Offset: 0x988
// Size: 0x1cc
function function_272c06e0()
{
    level scene::add_scene_func( "scene_kgb_security_checkpoint", &function_79dac42c );
    level scene::add_scene_func( "scene_kgb_security_intro_final", &function_79dac42c );
    level thread scene::play( "scene_kgb_security_checkpoint", "Intro_Loop" );
    level.var_aaa7acce = spawner::simple_spawn_single( "checkpoint_guy", &function_e1286843 );
    level.var_aaa7acce thread kgb_ins_prepare::function_3cf5b786();
    level thread scene::play( "scene_kgb_security_intro_guard", "Intro" );
    level thread scene::play( "scene_kgb_security_checkpoint_ambient_right" );
    level thread scene::play( "scene_kgb_security_checkpoint_ambient" );
    level.checkpoint_clip = getent( "checkpoint_clip", "targetname" );
    level.checkpoint_clip solid();
    level.checkpoint_clip_right = getent( "checkpoint_clip_right", "targetname" );
    level.checkpoint_clip_right solid();
    doors::function_f35467ac( "checkpoint_door", "targetname" );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x57a459c1, Offset: 0xb60
// Size: 0x3c
function function_5c4d2cf9()
{
    level thread function_c844d59a();
    level flag::wait_till( "checkpoint_crossed" );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x5822b781, Offset: 0xba8
// Size: 0x12c
function function_b6138231()
{
    wait 11;
    function_32e31449();
    level.belikov = namespace_e77bf565::function_e4660071( undefined );
    level.belikov.ignoreme = 1;
    level.belikov.ignoreall = 1;
    level thread function_bdc1f930();
    level thread scene::play( "scene_kgb_security_player" );
    level thread scene::play( "scene_kgb_security_inside" );
    level thread scene::play( "scene_kgb_security_checkpoint", "Checkpoint" );
    level scene::play( "scene_kgb_security_adler", level.adler );
    level flag::set( "checkpoint_crossed" );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x2194d663, Offset: 0xce0
// Size: 0x484
function function_c844d59a()
{
    struct = struct::get( "checkpoint_interact", "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_1b2da47a0dd85d2d", 80 );
    tag waittill( #"trigger" );
    level flag::set( "flag_aslt_entry_door" );
    tag util::remove_cursor_hint();
    tag delete();
    level thread scene::play( "scene_kgb_walkup_adler", "Init" );
    level.player districts::function_930f8c81( [ "kgb_hq_basement" ] );
    namespace_353d803e::music( "8.1_gate" );
    namespace_353d803e::music( "8.2_cello_stingers_1" );
    level scene::stop( "scene_kgb_security_intro_guard" );
    level scene::stop( "scene_kgb_security_checkpoint_ambient_right", 1 );
    level scene::play( "scene_kgb_security_intro_final", "Intro" );
    level thread scene::play( "scene_kgb_security_intro_final", "DT Loop" );
    waitframe( 1 );
    var_dee2ca2d = dialog_tree::new_tree( &function_c99d812a, &function_c9d5e36c, 1, 1 );
    var_dee2ca2d dialog_tree::add_option( #"hash_4b2b78e6a833b04f", "vox_cp_rkgb_02510_rms1_gothroughtheche_ae", undefined, undefined, 1 );
    var_dee2ca2d dialog_tree::add_option( #"hash_4b2b79e6a833b202", "vox_cp_rkgb_02510_rms1_gothroughtheche_ae", undefined, undefined, 1 );
    var_dee2ca2d dialog_tree::add_option( #"hash_4b2b7ae6a833b3b5", "vox_cp_rkgb_02510_rms1_gothroughtheche_ae", undefined, undefined, 1 );
    var_dee2ca2d dialog_tree::run( level.var_aaa7acce, undefined, 5, undefined, 1 );
    level thread function_a3c75b89();
    level scene::play( "scene_kgb_security_intro_final", "Walk Through Checkpoint" );
    level thread scene::play( "scene_kgb_security_intro_final", "Checkpoint Wait" );
    level flag::wait_till( "flag_player_checkpoint_start" );
    level.checkpoint_clip_right solid();
    level snd::play( "tmp_kgb_doorbuzzer_buzz", ( 26, -850, 440 ) );
    level thread function_b6138231();
    level scene::play( "scene_kgb_security_intro_final", "Player Enter" );
    
    if ( !level flag::get( "flag_player_bag" ) )
    {
        level thread scene::play( "scene_kgb_security_intro_final", "Bag Wait" );
    }
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x40014e18, Offset: 0x1170
// Size: 0x84
function function_a3c75b89()
{
    player = getplayers()[ 0 ];
    player freezecontrolsallowlook( 1 );
    wait 4;
    player freezecontrolsallowlook( 0 );
    wait 8.5;
    level.checkpoint_clip_right notsolid();
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x686c0688, Offset: 0x1200
// Size: 0x94
function function_f13fa17e()
{
    level thread scene::play( "scene_kgb_security_intro_guard", "failure", [ level.var_aaa7acce ] );
    level flag::wait_till( "flag_player_checkpoint_start" );
    level thread scene::play( "scene_kgb_security_intro_guard", "block", [ level.var_aaa7acce ] );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x8f7a9db5, Offset: 0x12a0
// Size: 0x4c
function function_c99d812a()
{
    player = getplayers()[ 0 ];
    player thread clientfield::set_to_player( "set_dof", 2 );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x75ead73, Offset: 0x12f8
// Size: 0x4c
function function_c9d5e36c()
{
    player = getplayers()[ 0 ];
    player thread clientfield::set_to_player( "set_dof", 1 );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x3ce6969e, Offset: 0x1350
// Size: 0x24
function function_521104dc()
{
    level flag::set( "flag_door_picked" );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x229eb7da, Offset: 0x1380
// Size: 0x2e
function function_e1286843()
{
    self.ignoreme = 1;
    self.ignoreall = 1;
    self.animname = "checkpoint_guy";
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0xc6ebfbc1, Offset: 0x13b8
// Size: 0x11c
function function_32e31449()
{
    struct = struct::get( "struct_player_checkpoint", "targetname" );
    tag = spawn( "script_model", struct.origin );
    tag setmodel( "tag_origin" );
    tag util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_3b72af0b8e4b647f", 64 );
    tag waittill( #"trigger" );
    tag util::remove_cursor_hint();
    tag delete();
    level flag::set( "flag_player_bag" );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x31508695, Offset: 0x14e0
// Size: 0x44
function function_bdc1f930()
{
    wait 6;
    namespace_353d803e::music( "9.0_infiltrating" );
    wait 9;
    namespace_353d803e::music( "8.3_cello_stingers_2" );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 1
// Checksum 0xd113b907, Offset: 0x1530
// Size: 0x112
function function_79dac42c( a_ents )
{
    level.var_db3f76f3 = a_ents[ #"guard_metal_detector_left" ];
    
    if ( isdefined( level.var_db3f76f3 ) )
    {
        level.var_db3f76f3.ignoreme = 1;
        level.var_db3f76f3.ignoreall = 1;
    }
    
    level.var_c98bb014 = a_ents[ #"guard_side_counter" ];
    
    if ( isdefined( level.var_c98bb014 ) )
    {
        level.var_c98bb014.ignoreme = 1;
        level.var_c98bb014.ignoreall = 1;
    }
    
    level.var_e77c1147 = a_ents[ #"guard_behind_counter" ];
    
    if ( isdefined( level.var_e77c1147 ) )
    {
        level.var_e77c1147.ignoreme = 1;
        level.var_e77c1147.ignoreall = 1;
    }
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x1a149e45, Offset: 0x1650
// Size: 0xfc
function function_c7b22bd4()
{
    level flag::wait_till( "team_in_elevator" );
    level.belikov util::stop_magic_bullet_shield();
    level scene::stop( "scene_kgb_security_checkpoint_ambient", 1 );
    level scene::stop( "scene_kgb_security_intro_guard", 1 );
    level scene::stop( "scene_kgb_security_inside", 1 );
    level scene::stop( "scene_kgb_security_checkpoint", 1 );
    level scene::stop( "scene_kgb_security_intro_final", 1 );
    level scene::stop( "scene_kgb_walkup_adler" );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x41e9e856, Offset: 0x1758
// Size: 0x2c
function function_f3c6e044()
{
    wait 3;
    level.var_aaa7acce thread dialogue::queue( "vox_cp_rkgb_02510_rms1_whatdoyouthinky_45" );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 0
// Checksum 0x2a1e4ece, Offset: 0x1790
// Size: 0xf4
function function_9e8ed6b4()
{
    level scene::add_scene_func( "scene_kgb_bodybag_vignette", &function_ae4ff0e2 );
    level thread function_8c2ff160( undefined, "camera_murder_investigation" );
    level thread function_8c2ff160( [ "false_intel_printed" ], "server_murder_investigation" );
    level thread function_8c2ff160( [ "flag_show_family_choice" ], "records_murder_investigation" );
    level thread function_8c2ff160( [ "flag_poi_armory_guy_dead", "flag_poi_data_computer" ], "data_murder_investigation", "flag_player_near_elevator" );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 3
// Checksum 0x4a448307, Offset: 0x1890
// Size: 0x104
function function_8c2ff160( check_flag, scene_name, var_515424a3 )
{
    if ( isdefined( check_flag ) && !level flag::get_any( check_flag ) )
    {
        return;
    }
    
    level thread scene::play( scene_name, "Duo_Loop" );
    
    if ( isdefined( var_515424a3 ) )
    {
        level flag::wait_till( var_515424a3 );
        level scene::play( scene_name, "Transition" );
        level thread scene::play( scene_name, "Trio_Loop" );
    }
    
    level flag::wait_till( "team_in_elevator" );
    level scene::stop( scene_name, 1 );
}

// Namespace kgb_aslt_entry/namespace_46f1d96e
// Params 1
// Checksum 0x8d7e874b, Offset: 0x19a0
// Size: 0xaa
function function_ae4ff0e2( a_ents )
{
    foreach ( ent in a_ents )
    {
        if ( isai( ent ) )
        {
            ent.ignoreme = 1;
            ent.var_7b71465f = 1;
        }
    }
}

