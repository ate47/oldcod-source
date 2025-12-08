#using script_1351b3cdb6539f9b;
#using script_2d443451ce681a;
#using script_61fee52bb750ac99;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;

#namespace namespace_371f22ea;

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 1
// Checksum 0xcd45b0d, Offset: 0x768
// Size: 0xc
function start( *str_objective )
{
    
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 2
// Checksum 0x943d5ca0, Offset: 0x780
// Size: 0x2c
function main( str_objective, *var_50cc0d4f )
{
    level thread namespace_d9b153b9::start_outro( var_50cc0d4f );
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 4
// Checksum 0xcb7ae26c, Offset: 0x7b8
// Size: 0x24
function cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0x8db6be8f, Offset: 0x7e8
// Size: 0xa4
function function_c26b0bc0()
{
    level flag::init( "bridge_path_completed" );
    level flag::init( "flag_bridge_path_zipline_start" );
    level flag::init( "flag_bridge_path_zipline_done" );
    level flag::init( "flag_bridge_path_zipline_vo_done" );
    level flag::init( "flag_bridge_jumper" );
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0xcf319c72, Offset: 0x898
// Size: 0x104
function function_a08d5cab()
{
    level flag::clear( "flag_bridge_path_complete" );
    level flag::clear( "flag_bridge_path_memory_start" );
    level flag::clear( "flag_bridge_path_backtrack" );
    level flag::clear( "flag_bridge_path_zipline_vo" );
    level flag::clear( "flag_bridge_path_zipline_start" );
    level flag::clear( "flag_bridge_path_on_bridge" );
    level flag::clear( "flag_bridge_crossed" );
    level flag::clear( "flag_bridge_path_overlook" );
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0x952135bb, Offset: 0x9a8
// Size: 0x5c
function bridge_path()
{
    level endon( #"start_outro" );
    var_c79d614f = "bridge_path";
    level thread function_2b388cee( var_c79d614f );
    level thread function_6620854c( var_c79d614f );
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0x8df16b2f, Offset: 0xa10
// Size: 0x18
function function_898195a8()
{
    level notify( #"hash_1314cbd25bca805d" );
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 1
// Checksum 0xba549079, Offset: 0xa30
// Size: 0x3bc
function function_2b388cee( var_c79d614f )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    vo_array = [];
    vo_array[ 0 ] = "vox_cp_prsn_14500_adlr_surebellyoucomm_54";
    vo_array[ 1 ] = "vox_cp_prsn_14300_adlr_sticktotherepor_17";
    level thread namespace_d9b153b9::function_47e52704( "flag_bridge_jumper", "struct_bridge_jump_teleport", vo_array );
    
    if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 >= 2 )
    {
        level thread function_462674();
    }
    
    level flag::wait_till( "flag_" + var_c79d614f );
    level.var_3f5c80c8 = "bridge_path";
    level function_364f9974();
    level childthread function_898195a8();
    level childthread function_b9c10ace();
    level childthread function_5a197a91( var_c79d614f );
    
    if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 == 1 )
    {
        level childthread function_e9d11934();
    }
    
    if ( level.var_731c10af.paths[ var_c79d614f ].count == 0 )
    {
        function_25c21ed3();
    }
    else if ( level.var_731c10af.paths[ var_c79d614f ].count == 1 )
    {
        function_25c21ed3();
    }
    else if ( level.var_731c10af.paths[ var_c79d614f ].count == 2 )
    {
        function_393dc5ca();
    }
    else if ( level.var_731c10af.paths[ var_c79d614f ].count >= 3 )
    {
        function_25c21ed3();
    }
    
    namespace_d9b153b9::function_e106e062( var_c79d614f );
    var_2cf9fe23 = level.var_731c10af.var_42659717 + 1;
    str = "visit_" + var_2cf9fe23 + "_" + var_c79d614f + "_" + level.var_731c10af.paths[ var_c79d614f ].count;
    bb::function_cd497743( str, level.player );
    level flag::wait_till( "flag_bridge_path_complete" );
    level notify( #"hash_4dc1bd447e15018a" );
    level flag::set( var_c79d614f + "_completed" );
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0xaafde4bb, Offset: 0xdf8
// Size: 0x12c
function function_462674()
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    
    if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 == 2 )
    {
        level flag::clear( "flag_bridge_path_rob" );
        level flag::clear( "flag_bridge_path_rob_2" );
    }
    
    level thread function_bedf680d();
    
    if ( !level flag::get( "flag_bridge_path_rob" ) )
    {
        level thread namespace_d9b153b9::function_1e281213( "mdl_mem_hallway_bridge", 4, "flag_bridge_path_rob", "render_texture_switch", "flag_in_end_path" );
        level thread namespace_b6fe1dbe::function_823f75e6();
    }
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0xd21d8aa9, Offset: 0xf30
// Size: 0xb4
function function_bedf680d()
{
    if ( !level flag::get( "flag_bridge_path_rob_2" ) )
    {
        level thread namespace_d9b153b9::function_1e281213( "mdl_mem_hallway_bridge_2", 4, "flag_bridge_path_rob_2", "render_texture_switch", "flag_in_end_path" );
        level thread namespace_b6fe1dbe::function_aaf2474b();
        level flag::wait_till( "flag_bridge_path_rob_2" );
        wait 1;
        level thread namespace_d9b153b9::function_b96db417( "bridge_path_rob_light" );
    }
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0x68a77d6e, Offset: 0xff0
// Size: 0x84
function function_364f9974()
{
    level flag::clear( "flag_adler_bridge_fork_disappear" );
    level flag::clear( "flag_bridge_path_zipline_start" );
    level flag::clear( "flag_bridge_path_zipline_done" );
    level flag::clear( "flag_bridge_path_zipline_vo_done" );
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 1
// Checksum 0xc29701ce, Offset: 0x1080
// Size: 0xfc
function function_6620854c( *var_c79d614f )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level flag::wait_till( "flag_bridge_path_memory_start" );
    
    if ( level.var_731c10af.var_e15e5b51.size == 2 )
    {
        scene::add_scene_func( "scene_pri_frozen_fight_bridge", &function_3170191d );
        thread scene::play( "scene_frozen_fight_bridge" );
        level thread exploder::exploder( "bridge_frozen_battle" );
        level thread namespace_b6fe1dbe::function_20018404();
    }
    
    thread function_dfbf6c10();
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 1
// Checksum 0xfcea6fc6, Offset: 0x1188
// Size: 0x98
function function_3170191d( a_ents )
{
    foreach ( ent in a_ents )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        ent thread namespace_d9b153b9::function_7428d519();
    }
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0xa3f4aa5b, Offset: 0x1228
// Size: 0x94
function function_dfbf6c10()
{
    level flag::wait_till( "flag_in_end_path" );
    level notify( #"hash_135069eaafe77dc0" );
    scene::stop( "scene_frozen_fight_bridge" );
    level scene::delete_scene_spawned_ents( "scene_frozen_fight_bridge" );
    level thread exploder::kill_exploder( "bridge_frozen_battle" );
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0x777e2d75, Offset: 0x12c8
// Size: 0x1e
function function_2a29619c()
{
    self.health = 1;
    self.var_c681e4c1 = 1;
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0x7c43bc30, Offset: 0x12f0
// Size: 0x11c
function function_25c21ed3()
{
    var_736f7cf8 = vehicle::simple_spawn_and_drive( "bridge_heligroup1" );
    
    foreach ( heli in var_736f7cf8 )
    {
        heli setrotorspeed( 1 );
    }
    
    var_736f7cf8[ 0 ] thread namespace_b6fe1dbe::function_280d83da();
    var_736f7cf8[ 1 ] thread namespace_b6fe1dbe::function_3dd3af66();
    var_736f7cf8[ 2 ] thread namespace_b6fe1dbe::function_8444bc3b();
    var_736f7cf8[ 1 ] playrumblelooponentity( "damage_heavy" );
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0xa7f8f45e, Offset: 0x1418
// Size: 0xfc
function function_393dc5ca()
{
    var_73567cca = vehicle::simple_spawn_and_drive( "bridge_heligroup3" );
    
    foreach ( heli in var_73567cca )
    {
        heli setrotorspeed( 1 );
    }
    
    var_73567cca[ 0 ] thread namespace_b6fe1dbe::function_9b2e941d();
    var_73567cca[ 1 ] thread namespace_b6fe1dbe::function_a6eaab95();
    var_73567cca[ 2 ] thread namespace_b6fe1dbe::function_49b6f127();
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 1
// Checksum 0x32b79ab6, Offset: 0x1520
// Size: 0x2e4
function function_5a197a91( var_c79d614f )
{
    level endon( #"hash_4dc1bd447e15018a" );
    level flag::wait_till( "flag_bridge_path_zipline_vo" );
    level childthread function_9e133c64();
    level childthread function_9e985d7f();
    
    if ( level.var_baa7cf92 == "caves" )
    {
        if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 == 2 )
        {
            dialogue::radio( "vox_cp_prsn_08500_adlr_belltakethezipl_9e" );
        }
        else
        {
            dialogue::radio( "vox_cp_prsn_02700_adlr_theziplinenearb_3e" );
        }
    }
    else if ( level.var_baa7cf92 == "village" )
    {
        level thread function_1077143c();
        dialogue::radio( "vox_cp_prsn_05500_adlr_youmentionedcro_04" );
    }
    else if ( level.var_baa7cf92 == "sniper_overlook" )
    {
        level thread function_1077143c();
        dialogue::radio( "vox_cp_prsn_08500_adlr_reportshadthebu_0b" );
    }
    
    level flag::wait_till( "flag_bridge_crossed" );
    
    if ( level.var_baa7cf92 == "caves" )
    {
        thread namespace_b6fe1dbe::function_1e0e9b39( var_c79d614f );
        
        if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 == 2 )
        {
            dialogue::radio( "vox_cp_prsn_08500_adlr_bellgobacktothe_9f" );
        }
        else
        {
            dialogue::radio( "vox_cp_prsn_02700_adlr_bellturnbackand_dd" );
        }
        
        return;
    }
    
    if ( level.var_baa7cf92 == "village" )
    {
        thread namespace_b6fe1dbe::function_34830cda( var_c79d614f );
        thread namespace_b6fe1dbe::function_4a9b10a8();
        dialogue::radio( "vox_cp_prsn_05500_adlr_attheforkyoufol_73" );
        return;
    }
    
    if ( level.var_baa7cf92 == "sniper_overlook" )
    {
        thread namespace_b6fe1dbe::function_34830cda( var_c79d614f );
        dialogue::radio( "vox_cp_prsn_08500_adlr_youwentleftatth_17" );
    }
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 1
// Checksum 0xaa53791e, Offset: 0x1810
// Size: 0xdc
function function_48800705( var_c79d614f )
{
    level endon( #"flag_bridge_crossed" );
    level flag::wait_till( "flag_bridge_path_on_bridge" );
    
    if ( level.var_baa7cf92 == "caves" )
    {
        thread namespace_b6fe1dbe::function_1e0e9b39( var_c79d614f );
        
        if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 == 2 )
        {
            dialogue::radio( "vox_cp_prsn_08500_adlr_bellturnarounda_a7" );
            return;
        }
        
        dialogue::radio( "vox_cp_prsn_02700_adlr_bellyoudidntcro_e8" );
    }
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0xdc25c99a, Offset: 0x18f8
// Size: 0x54
function function_22390791()
{
    level flag::wait_till( "flag_bridge_path_overlook" );
    
    if ( level.var_baa7cf92 == "village" )
    {
        dialogue::radio( "vox_cp_prsn_05500_adlr_bellyoudidntjus_6c" );
    }
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0xb5b438c6, Offset: 0x1958
// Size: 0x84
function function_b9c10ace()
{
    level flag::wait_till( "flag_bridge_crossed" );
    
    if ( level.var_731c10af.paths[ #"village" ].count == 0 )
    {
        level flag::wait_till_any( array( "flag_village", "flag_sniper_overlook" ) );
    }
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0x199ce29a, Offset: 0x19e8
// Size: 0x5c
function function_9e133c64()
{
    level endon( #"hash_4dc1bd447e15018a" );
    level flag::wait_till( "flag_bridge_path_zipline_done" );
    wait 1.75;
    level flag::set( "flag_bridge_path_zipline_vo_done" );
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0xa6ea154d, Offset: 0x1a50
// Size: 0xbc
function function_1077143c()
{
    level endon( #"hash_4dc1bd447e15018a" );
    level flag::wait_till( "flag_bridge_path_zipline_start" );
    
    if ( level.var_baa7cf92 == "village" )
    {
        dialogue::radio( "vox_cp_prsn_05500_adlr_bellyourreportd_18" );
    }
    else if ( level.var_baa7cf92 == "sniper_overlook" )
    {
        dialogue::radio( "vox_cp_prsn_08500_adlr_goddammitbellwe_c8" );
    }
    
    level flag::set( "flag_bridge_path_zipline_vo_done" );
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0x5019a56c, Offset: 0x1b18
// Size: 0x88
function function_9e985d7f()
{
    level endon( #"hash_4dc1bd447e15018a" );
    level flag::wait_till( "flag_bridge_path_backtrack" );
    
    if ( isdefined( level.var_731c10af.var_42659717 ) && ( level.var_731c10af.var_42659717 == 0 || level.var_731c10af.var_42659717 == 1 ) )
    {
    }
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0xd0f474d9, Offset: 0x1ba8
// Size: 0x80
function function_b6dc2ea2()
{
    level flag::wait_till( "flag_bridge_path_complete" );
    
    if ( level.var_baa7cf92 == "village" && !level flag::get( "flag_bridge_path_zipline_start" ) && level flag::get( "flag_sniper_overlook" ) )
    {
    }
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 0
// Checksum 0xa5193904, Offset: 0x1c30
// Size: 0x320
function function_e9d11934()
{
    str_name = util::function_875955a();
    
    if ( str_name == "sims" )
    {
        var_ef191d3c = spawner::simple_spawn_single( "ally_park_bridge" );
        var_7ac9696f = spawner::simple_spawn_single( "ally_lazar_bridge" );
        a_e_allies = array( var_ef191d3c, var_7ac9696f );
    }
    else if ( str_name == "lazar" )
    {
        var_ef191d3c = spawner::simple_spawn_single( "ally_park_bridge" );
        a_e_allies = array( var_ef191d3c );
    }
    else if ( str_name == "park" )
    {
        var_7ac9696f = spawner::simple_spawn_single( "ally_lazar_bridge" );
        a_e_allies = array( var_7ac9696f );
    }
    
    level thread scene::init( "scene_lost_companion", a_e_allies );
    level flag::wait_till_any( array( "flag_adler_bridge_fork_disappear", "flag_in_end_path" ) );
    
    if ( !level flag::get( "flag_in_end_path" ) )
    {
        level thread scene::play( "scene_lost_companion", "shot 2", a_e_allies );
        childthread function_7a3d38d9( a_e_allies );
        
        while ( isdefined( a_e_allies[ 0 ] ) && a_e_allies[ 0 ] getanimtime( a_e_allies[ 0 ].str_current_anim ) < 0.9 )
        {
            waitframe( 1 );
        }
    }
    
    level scene::stop( "scene_lost_companion" );
    level scene::delete_scene_spawned_ents( "scene_lost_companion" );
    waitframe( 1 );
    function_1eaaceab( a_e_allies );
    
    foreach ( var_ac85c33a in a_e_allies )
    {
        if ( isdefined( var_ac85c33a ) )
        {
            util::stop_magic_bullet_shield( var_ac85c33a );
        }
        
        waitframe( 1 );
        
        if ( isdefined( var_ac85c33a ) )
        {
            var_ac85c33a delete();
        }
    }
}

// Namespace namespace_371f22ea/namespace_371f22ea
// Params 1
// Checksum 0xb1c0be9d, Offset: 0x1f58
// Size: 0x204
function function_7a3d38d9( a_e_allies )
{
    var_469f12b5 = undefined;
    
    while ( true )
    {
        foreach ( var_ac85c33a in a_e_allies )
        {
            if ( !isalive( var_ac85c33a ) )
            {
                return;
            }
            
            f_distance = distance2d( var_ac85c33a.origin, level.player.origin );
            
            if ( f_distance < 500 )
            {
                var_469f12b5 = var_ac85c33a;
                break;
            }
        }
        
        if ( isdefined( var_469f12b5 ) )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    if ( isdefined( var_469f12b5.str_current_anim ) )
    {
        f_time = var_469f12b5 getanimtime( var_469f12b5.str_current_anim );
        
        foreach ( var_ac85c33a in a_e_allies )
        {
            var_ac85c33a.n_script_anim_rate = 10;
        }
        
        namespace_b6fe1dbe::function_df93683a();
        level scene::play_from_time( "scene_lost_companion", "shot 2", a_e_allies, f_time );
    }
    
    level thread namespace_d9b153b9::function_57eac84a();
}

