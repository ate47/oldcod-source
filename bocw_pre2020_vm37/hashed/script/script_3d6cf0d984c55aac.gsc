#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_4d0e7ced9714e7d4;
#using script_5513c8efed5ff300;
#using script_63ae018f589c2e64;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace namespace_d6f0b09d;

// Namespace namespace_d6f0b09d/namespace_da887860
// Params 1
// Checksum 0x1c072bc6, Offset: 0x560
// Size: 0xc
function function_ad4c4af2( *str_objective )
{
    
}

// Namespace namespace_d6f0b09d/namespace_da887860
// Params 4
// Checksum 0x96fbec3, Offset: 0x578
// Size: 0x44
function function_be4e11a7( *name, *starting, *direct, *player )
{
    level flag::set( "flag_comprimised_complete" );
}

// Namespace namespace_d6f0b09d/namespace_da887860
// Params 0
// Checksum 0x3aae097a, Offset: 0x5c8
// Size: 0x152
function function_73f39397()
{
    e_player = getplayers()[ 0 ];
    e_player val::set( #"hash_4d99b770ba54ea0d", "freezecontrols", 1 );
    var_b29e95a1 = [ level.woods, level.mason ];
    
    if ( isdefined( level.var_deda09e ) )
    {
        array::add( var_b29e95a1, level.var_c1881cdd );
    }
    
    var_b29e95a1[ var_b29e95a1.size ] = getplayers()[ 0 ];
    level.adler thread scene::play( "scene_duga_intro_adler", "dt4_end", level.adler );
    level thread scene::play( "scene_duga_intro", "dt4_end", var_b29e95a1 );
    level waittill( #"hash_bf0839fbe842087" );
    wait 3;
}

// Namespace namespace_d6f0b09d/namespace_da887860
// Params 2
// Checksum 0xd7d7ba86, Offset: 0x728
// Size: 0x53c
function function_60a583d8( str_objective, *var_50cc0d4f )
{
    battlechatter::function_2ab9360b( 0 );
    level thread function_7de1bd9d();
    e_player = getplayers()[ 0 ];
    e_player showcrosshair( 0 );
    namespace_82bfe441::fade( 1, "FadeImmediate" );
    e_player val::set( #"hash_2e97aa66c8fb4309", "disable_weapons", 1 );
    level function_1a0d08a6();
    level globallogic_ui::function_7bc0e4b9();
    level namespace_ac5221d7::function_ed760ecb( "adler" );
    level namespace_ac5221d7::function_ed760ecb( "woods" );
    level namespace_ac5221d7::function_ed760ecb( "mason" );
    var_b29e95a1 = [ level.woods, level.mason ];
    var_b29e95a1[ var_b29e95a1.size ] = getplayers()[ 0 ];
    level.var_574a6d1a = spawner::simple_spawn( "spawners_us_forces_intro" );
    
    foreach ( ai in level.var_574a6d1a )
    {
        ai.allowbattlechatter[ #"bc" ] = 0;
    }
    
    if ( isdefined( level.var_deda09e ) )
    {
        level namespace_ac5221d7::function_ed760ecb( namespace_ac5221d7::function_7b37895() );
        array::add( var_b29e95a1, level.var_c1881cdd );
    }
    
    e_player flag::set( level.var_d7d201ba );
    var_a2509eb6 = 1;
    level util::delay( var_a2509eb6, undefined, &namespace_e1ccb37b::function_64c39708 );
    scene::function_d0d7d9f7( "scene_duga_intro", &namespace_ac5221d7::function_6f94ced5 );
    var_b29e95a1 = [ level.woods, level.mason ];
    
    if ( isdefined( level.var_deda09e ) )
    {
        array::add( var_b29e95a1, level.var_c1881cdd );
    }
    
    level thread scene::play( "scene_duga_intro", "dt_enter", var_b29e95a1 );
    level thread scene::play( "scene_duga_intro_adler", "dt_enter", [ level.adler ] );
    level waittill( #"hash_459a515290c970dc" );
    level thread scene::play( "scene_duga_intro_adler", "dt_idle", [ level.adler ] );
    level.var_1bf038f6 dialog_tree::run( level.adler );
    s_result = level flag::wait_till_any( [ #"flag_ambush_signaled", #"hash_49d647c310f93e45" ] );
    
    if ( s_result._notify === "flag_ambush_signaled" )
    {
        level flag::set( "flag_comprimised_complete" );
        skipto::function_4e3ab877( var_50cc0d4f );
        return;
    }
    
    function_73f39397();
    skipto::function_f02f0c63();
    skipto::function_1c2dfc20();
}

// Namespace namespace_d6f0b09d/namespace_da887860
// Params 0
// Checksum 0xbbbf6530, Offset: 0xc70
// Size: 0xa4
function function_1a0d08a6()
{
    var_2fab6c8d = "";
    
    if ( !isdefined( level.var_deda09e ) )
    {
        var_2fab6c8d = "vox_cp_duga_01000_masn_adlernosignsofm_50";
    }
    else if ( level.var_deda09e === "park" )
    {
        var_2fab6c8d = "vox_cp_duga_01000_park_adlerstillseein_a0";
    }
    else
    {
        var_2fab6c8d = "vox_cp_duga_01000_lazr_adlernocontacto_8c";
    }
    
    dialogue::radio( var_2fab6c8d );
    dialogue::radio( "vox_cp_duga_01000_wood_sameihaventseen_bb" );
    dialogue::radio( "vox_cp_duga_01000_adlr_alrighteveryone_3c" );
}

// Namespace namespace_d6f0b09d/namespace_da887860
// Params 0
// Checksum 0x4ca2bdc, Offset: 0xd20
// Size: 0x762
function function_7de1bd9d()
{
    var_681b585d = level.var_96d76ea;
    var_7b500845 = "dt_idle";
    var_8bba7bce = 20;
    level.var_1bf038f6 = dialog_tree::new_tree( undefined, undefined, 1, 1, "scene_duga_intro_adler", 1, var_8bba7bce );
    var_9d78df2a = "vox_cp_duga_01100_adlr_ihadnootherchoi_ce";
    var_21eb0ff0 = "vox_cp_duga_01100_adlr_whatkindoffucke_20";
    var_bdac1482 = "vox_cp_duga_01100_adlr_whatawasteyouac_39";
    level.var_1bf038f6 dialog_tree::add_option( #"hash_2b270bbc8e926055", undefined, "dt1_res1", undefined, 1, undefined, undefined, &function_cece5b3e );
    level.var_1bf038f6 dialog_tree::add_option( #"hash_2b23e3bc8e8fe686", undefined, "dt1_res2", undefined, 1, undefined, undefined, &function_cece5b3e );
    
    if ( is_true( var_681b585d ) )
    {
        level.var_1bf038f6 dialog_tree::add_option( #"hash_65dfd8ecb8e90e2f", undefined, undefined, undefined, 1, undefined, undefined, &function_b31036ab, 1 );
        level.var_1bf038f6 dialog_tree::function_6ebd37a4();
    }
    
    level.var_2daedc73 = dialog_tree::new_tree( &function_e7dca05b, undefined, 1, 1, "scene_duga_intro_adler", 1, var_8bba7bce );
    var_9d78df2a = "vox_cp_duga_01100_adlr_thosenukesweref_58";
    var_21eb0ff0 = "vox_cp_duga_01100_adlr_theresnowinnerh_67";
    var_1ee51ad7 = "vox_cp_duga_01100_adlr_youllregretthis_2e";
    level.var_2daedc73 dialog_tree::add_option( #"hash_7de0ebb62c198152", undefined, "dt2_res1", undefined, 1, undefined, undefined, &function_33ff1feb );
    level.var_2daedc73 dialog_tree::add_option( #"hash_7de413b62c1bfb21", undefined, "dt2_res2", undefined, 1, undefined, undefined, &function_33ff1feb );
    
    if ( is_true( var_681b585d ) )
    {
        level.var_2daedc73 dialog_tree::add_option( #"hash_3092ff7b2aa8cc8f", undefined, undefined, undefined, 1, undefined, undefined, &function_b31036ab, 1 );
        level.var_2daedc73 dialog_tree::function_6ebd37a4();
    }
    
    level.var_305ce1cf = dialog_tree::new_tree( &function_f3ddb2c5, undefined, 1, 1, "scene_duga_intro_adler", 1, var_8bba7bce );
    var_9d78df2a = "vox_cp_duga_01100_adlr_youreflattering_89";
    var_21eb0ff0 = "vox_cp_duga_01100_adlr_apparentlywedid_6e";
    var_fe0dc6ea = "vox_cp_duga_01100_adlr_imcomfortablewi_ab";
    var_66b4a54 = "vox_cp_duga_01100_adlr_timesupkid_b4";
    level.var_305ce1cf dialog_tree::add_option( #"hash_2773b7ae90a8ee17", undefined, "dt3_res1", undefined, 1, undefined, undefined, &function_32bc6252 );
    level.var_305ce1cf dialog_tree::add_option( #"hash_277ea7ae90b2da6c", undefined, "dt3_res2", undefined, 1, undefined, undefined, &function_32bc6252 );
    
    if ( is_true( var_681b585d ) )
    {
        level.var_305ce1cf dialog_tree::add_option( #"hash_65c8ebb6d6f2f8e1", undefined, undefined, undefined, 1, undefined, undefined, &function_b31036ab, 1 );
        level.var_305ce1cf dialog_tree::function_6ebd37a4();
    }
    
    level.var_4222855a = dialog_tree::new_tree( undefined, undefined, 1, 1, "scene_duga_intro_adler", 1, var_8bba7bce );
    level.var_4222855a dialog_tree::add_option( #"hash_3e50d706852384a4", undefined, undefined, undefined, 1, undefined, undefined, &function_b31036ab );
    level.var_4222855a dialog_tree::function_6ebd37a4();
    level.var_4222855a dialog_tree::add_option( #"hash_762b5d6397cfcbbd", undefined, undefined, undefined, 1, undefined, undefined, &function_b31036ab );
    level.var_4222855a dialog_tree::function_6ebd37a4();
    var_1584d516 = getplayers()[ 0 ] namespace_70eba6e6::function_1c4fb6d4();
    
    /#
        var_9a7b5d79 = getdvarint( #"hash_4dd19684bf68597b", -1 );
        
        if ( var_9a7b5d79 != -1 )
        {
            var_1584d516 = var_9a7b5d79;
        }
    #/
    
    switch ( var_1584d516 )
    {
        case 0:
            level.var_4222855a dialog_tree::add_option( #"hash_5ccf7beaba70f824", undefined, undefined, undefined, 1, undefined, undefined, &function_b31036ab );
            level.var_4222855a dialog_tree::function_6ebd37a4();
            break;
        case 1:
            level.var_4222855a dialog_tree::add_option( #"hash_6a96859fd1722324", undefined, undefined, undefined, 1, undefined, undefined, &function_b31036ab );
            level.var_4222855a dialog_tree::function_6ebd37a4();
            break;
        case 2:
            level.var_4222855a dialog_tree::add_option( #"hash_4befaf7450e295c5", undefined, undefined, undefined, 1, undefined, undefined, &function_b31036ab );
            level.var_4222855a dialog_tree::function_6ebd37a4();
            break;
    }
}

// Namespace namespace_d6f0b09d/namespace_da887860
// Params 0
// Checksum 0xae45c77b, Offset: 0x1490
// Size: 0x3c
function function_cece5b3e()
{
    self waittill( #"dialog_tree_scene_response_complete" );
    level.var_2daedc73 thread dialog_tree::run( level.adler );
}

// Namespace namespace_d6f0b09d/namespace_da887860
// Params 0
// Checksum 0xcadc4b56, Offset: 0x14d8
// Size: 0x54
function function_e7dca05b()
{
    level.adler scene::play( "scene_duga_intro_adler", "dt2_enter" );
    level.adler thread scene::play( "scene_duga_intro_adler", "dt_idle" );
}

// Namespace namespace_d6f0b09d/namespace_da887860
// Params 0
// Checksum 0x2845255c, Offset: 0x1538
// Size: 0x3c
function function_33ff1feb()
{
    self waittill( #"dialog_tree_scene_response_complete" );
    level.var_305ce1cf thread dialog_tree::run( level.adler );
}

// Namespace namespace_d6f0b09d/namespace_da887860
// Params 0
// Checksum 0x755e2a40, Offset: 0x1580
// Size: 0x54
function function_f3ddb2c5()
{
    level.adler scene::play( "scene_duga_intro_adler", "dt3_enter" );
    level.adler thread scene::play( "scene_duga_intro_adler", "dt_idle" );
}

// Namespace namespace_d6f0b09d/namespace_da887860
// Params 0
// Checksum 0x45b39f47, Offset: 0x15e0
// Size: 0xac
function function_32bc6252()
{
    self waittill( #"dialog_tree_scene_response_complete" );
    level.adler scene::play( "scene_duga_intro_adler", "dt4_enter" );
    
    if ( is_true( level.var_96d76ea ) )
    {
        level.var_4222855a thread dialog_tree::run( level.adler );
        return;
    }
    
    wait 2;
    level flag::set( #"hash_49d647c310f93e45" );
}

// Namespace namespace_d6f0b09d/namespace_da887860
// Params 0
// Checksum 0x80f724d1, Offset: 0x1698
// Size: 0x4
function function_a9cf5806()
{
    
}

// Namespace namespace_d6f0b09d/namespace_da887860
// Params 1
// Checksum 0x8e99fd43, Offset: 0x16a8
// Size: 0x8c
function function_b31036ab( *var_d62d7ec3 )
{
    var_b29e95a1 = [ level.woods, level.mason ];
    
    if ( isdefined( level.var_deda09e ) )
    {
        array::add( var_b29e95a1, level.var_c1881cdd );
    }
    
    level flag::set( #"flag_ambush_signaled" );
}

