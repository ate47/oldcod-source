#using script_1351b3cdb6539f9b;
#using script_2d443451ce681a;
#using script_61fee52bb750ac99;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_nam_prisoner_rat_tunnels;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\smart_bundle;
#using scripts\cp_common\util;

#namespace namespace_6020b123;

// Namespace namespace_6020b123/namespace_6020b123
// Params 1
// Checksum 0x1c072bc6, Offset: 0x748
// Size: 0xc
function start( *str_objective )
{
    
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 2
// Checksum 0xd0bd9179, Offset: 0x760
// Size: 0x2c
function main( str_objective, *var_50cc0d4f )
{
    level thread namespace_d9b153b9::start_outro( var_50cc0d4f );
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 4
// Checksum 0xaadb0119, Offset: 0x798
// Size: 0x24
function cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 0
// Checksum 0x99b50053, Offset: 0x7c8
// Size: 0x24
function function_c26b0bc0()
{
    level flag::init( "river_path_completed" );
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 0
// Checksum 0xfdf0001c, Offset: 0x7f8
// Size: 0x184
function function_a08d5cab()
{
    level flag::clear( "flag_river_path" );
    level flag::clear( "flag_river_path_memory_start" );
    level flag::clear( "flag_river_progression" );
    level flag::clear( "flag_caves_path" );
    level flag::clear( "flag_rat_tunnels_path" );
    level flag::clear( "flag_rat_tunnels_field" );
    level flag::clear( "flag_open_rat_tunnels" );
    level flag::clear( "flag_river_ladder" );
    level flag::clear( "flag_river_ladder_approach" );
    level flag::clear( "flag_river_ladder_top" );
    level flag::clear( "flag_adler_river_disappear" );
    level flag::clear( "flag_adler_rat_tunnels_disappear" );
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 0
// Checksum 0x95e057e5, Offset: 0x988
// Size: 0x5c
function river_path()
{
    level endon( #"start_outro" );
    var_c79d614f = "river_path";
    level thread function_76ef45a9( var_c79d614f );
    level thread function_9c53d200( var_c79d614f );
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 0
// Checksum 0xcb8e90d4, Offset: 0x9f0
// Size: 0x18
function function_7b5ef878()
{
    level notify( #"waterfall_end_vo" );
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 1
// Checksum 0x8f5725f, Offset: 0xa10
// Size: 0x254
function function_76ef45a9( var_c79d614f )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    vo_array = [];
    vo_array[ 0 ] = "vox_cp_prsn_14500_adlr_surebellyoucomm_54";
    vo_array[ 1 ] = "vox_cp_prsn_14300_adlr_sticktotherepor_17";
    level thread namespace_d9b153b9::function_47e52704( "flag_river_jumper", "struct_river_jump_teleport", vo_array );
    
    if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 >= 2 )
    {
        level thread function_7beef866();
    }
    
    level flag::wait_till( "flag_" + var_c79d614f );
    level.var_3f5c80c8 = "river_path";
    
    if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 == 1 )
    {
        level thread function_a517e48c();
    }
    
    thread function_7b5ef878();
    function_384b4a52( var_c79d614f );
    namespace_d9b153b9::function_e106e062( var_c79d614f );
    level flag::set( var_c79d614f + "_completed" );
    var_2cf9fe23 = level.var_731c10af.var_42659717 + 1;
    str = "visit_" + var_2cf9fe23 + "_" + var_c79d614f + "_" + level.var_731c10af.paths[ var_c79d614f ].count;
    bb::function_cd497743( str, level.player );
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 0
// Checksum 0x8dcbd21, Offset: 0xc70
// Size: 0x134
function function_7beef866()
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    
    if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 == 2 )
    {
        level flag::clear( "flag_river_path_rob" );
    }
    
    if ( !level flag::get( "flag_river_path_rob" ) )
    {
        level thread namespace_d9b153b9::function_1e281213( "mdl_mem_hallway_river", 4, "flag_river_path_rob", "render_texture_switch", "flag_in_end_path" );
        level thread namespace_b6fe1dbe::function_e4de9155();
        level flag::wait_till( "flag_river_path_rob" );
        wait 1;
        level thread namespace_d9b153b9::function_b96db417( "river_path_rob_light" );
    }
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 1
// Checksum 0x59274c82, Offset: 0xdb0
// Size: 0xdc
function function_384b4a52( var_c79d614f )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level childthread function_34a64026( var_c79d614f );
    level childthread function_d5b16935( var_c79d614f );
    level childthread function_cca4aa65( var_c79d614f );
    level childthread function_1db0a952();
    
    if ( !level flag::get( "flag_rat_tunnels" ) )
    {
        level childthread cp_nam_prisoner_rat_tunnels::function_4b429874( "rat_tunnels" );
    }
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 1
// Checksum 0x7ebb3d70, Offset: 0xe98
// Size: 0x394
function function_34a64026( var_c79d614f )
{
    level endon( #"hash_411bceb4b6375aff" );
    
    if ( level flag::get( "flag_bridge_path_zipline_start" ) )
    {
        level flag::wait_till( "flag_bridge_path_zipline_vo_done" );
        
        if ( level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook" )
        {
            level thread dialogue::radio( "vox_cp_prsn_05500_adlr_goddammitbellwh_f0" );
        }
        
        level flag::set( "flag_bridge_path_complete" );
    }
    
    if ( level.var_baa7cf92 == "caves" )
    {
        level flag::wait_till( "flag_river_ladder" );
        wait 1;
        dialogue::radio( "vox_cp_prsn_02200_adlr_youheardrussian_c8" );
        var_5d7cba12 = struct::get( "struct_lookat_caves", "targetname" );
        playsoundatposition( "vox_cp_prsn_29500_rms1_report_9d", var_5d7cba12.origin );
        wait 3;
        playsoundatposition( "vox_cp_prsn_29500_rms2_entryissecuresi_70", var_5d7cba12.origin );
    }
    else if ( level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook" )
    {
        level flag::wait_till( "flag_river_progression" );
        thread namespace_b6fe1dbe::function_1e0e9b39( var_c79d614f );
        
        if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 == 2 )
        {
            dialogue::radio( "vox_cp_prsn_08200_adlr_bellusetheladde_f0" );
        }
        else
        {
            dialogue::radio( "vox_cp_prsn_05200_adlr_bellgobackandcl_3b" );
        }
    }
    
    struct_lookat_caves = struct::get( "struct_lookat_caves", "targetname" );
    level.player childthread namespace_d9b153b9::function_d683b544( &function_14dbdc61, struct_lookat_caves.origin );
    struct_lookat_beach = struct::get( "struct_lookat_beach", "targetname" );
    level.player childthread namespace_d9b153b9::function_d683b544( &function_f3e42700, struct_lookat_beach.origin );
    struct_lookat_firepit = struct::get( "struct_lookat_firepit", "targetname" );
    level.player childthread namespace_d9b153b9::function_d683b544( &function_cec783b5, struct_lookat_firepit.origin );
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 0
// Checksum 0x80f724d1, Offset: 0x1238
// Size: 0x4
function function_14dbdc61()
{
    
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 0
// Checksum 0x80f724d1, Offset: 0x1248
// Size: 0x4
function function_f3e42700()
{
    
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 0
// Checksum 0x7cf40a1c, Offset: 0x1258
// Size: 0x1c
function function_cec783b5()
{
    dialogue::radio( "vox_cp_prsn_14300_adlr_asovietstatuein_b6" );
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 1
// Checksum 0xb3597bff, Offset: 0x1280
// Size: 0x7c
function function_d5b16935( var_c79d614f )
{
    level endon( #"hash_411bceb4b6375aff" );
    level flag::wait_till( "flag_caves_path" );
    
    if ( level.var_baa7cf92 == "caves" )
    {
        thread namespace_b6fe1dbe::function_34830cda( var_c79d614f );
        thread namespace_b6fe1dbe::function_19123a4f();
    }
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 1
// Checksum 0x7c406f4f, Offset: 0x1308
// Size: 0xd4
function function_cca4aa65( var_c79d614f )
{
    level endon( #"hash_411bceb4b6375aff" );
    level flag::wait_till( "flag_rat_tunnels_path" );
    thread namespace_b6fe1dbe::function_1e0e9b39( var_c79d614f );
    
    if ( level.var_baa7cf92 == "caves" )
    {
        dialogue::radio( "vox_cp_prsn_02200_adlr_nobellyoufoundt_ae" );
        return;
    }
    
    if ( level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook" )
    {
        dialogue::radio( "vox_cp_prsn_08200_adlr_bellthebunkeris_3a" );
    }
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 0
// Checksum 0x8684d489, Offset: 0x13e8
// Size: 0x10c
function function_1db0a952()
{
    level endon( #"hash_411bceb4b6375aff" );
    level flag::wait_till( "flag_river_ladder" );
    
    if ( level.var_baa7cf92 == "caves" )
    {
        level flag::wait_till( "flag_river_ladder_approach" );
        dialogue::radio( "vox_cp_prsn_02200_adlr_bellineedyoutot_53" );
        level flag::wait_till( "flag_river_ladder_top" );
        dialogue::radio( "vox_cp_prsn_02200_adlr_bellsstartingto_5f" );
        return;
    }
    
    if ( level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook" )
    {
        dialogue::radio( "vox_cp_prsn_05200_adlr_bellyounoticeda_44" );
    }
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 0
// Checksum 0x80f724d1, Offset: 0x1500
// Size: 0x4
function function_a517e48c()
{
    
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 0
// Checksum 0xac97ad66, Offset: 0x1510
// Size: 0x18c
function function_5dece0a6()
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level endon( #"hash_6298f1ecb0e7b6ba" );
    
    if ( level.var_731c10af.paths[ #"rat_tunnels" ].count == 1 )
    {
        a_ents = [];
        a_ents[ #"hatch" ] = getent( "rat_tunnel_hatch", "targetname" );
        level thread scene::init( "scene_pri_rat_tunnel_reveal", a_ents );
        return;
    }
    
    a_ents = [];
    a_ents[ #"hatch" ] = getent( "rat_tunnel_hatch", "targetname" );
    level thread scene::init( "scene_pri_rat_tunnel_reveal", a_ents );
    level flag::wait_till( "flag_open_rat_tunnels" );
    level thread scene::play( "scene_pri_rat_tunnel_reveal", a_ents );
    thread function_81c9b145( a_ents );
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 1
// Checksum 0x8b6d1e8c, Offset: 0x16a8
// Size: 0x22
function function_81c9b145( *a_ents )
{
    level endon( #"hash_411bceb4b6375aff" );
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 1
// Checksum 0xef0454f5, Offset: 0x16d8
// Size: 0xe4
function function_9c53d200( *var_c79d614f )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level flag::wait_till( "flag_river_path_memory_start" );
    
    if ( level.var_731c10af.var_e15e5b51.size == 2 )
    {
        scene::add_scene_func( "scene_pri_frozen_fight_creek", &function_d915ae1b );
        thread scene::play( "scene_frozen_fight_creek" );
        level thread exploder::exploder( "river_frozen_battle" );
    }
    
    thread function_d90c1d8a();
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 1
// Checksum 0xfc796041, Offset: 0x17c8
// Size: 0x98
function function_d915ae1b( a_ents )
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

// Namespace namespace_6020b123/namespace_6020b123
// Params 0
// Checksum 0xc98d1e05, Offset: 0x1868
// Size: 0x94
function function_d90c1d8a()
{
    level flag::wait_till( "flag_in_end_path" );
    level notify( #"hash_135069eaafe77dc0" );
    scene::stop( "scene_frozen_fight_creek" );
    level scene::delete_scene_spawned_ents( "scene_frozen_fight_creek" );
    level thread exploder::kill_exploder( "river_frozen_battle" );
}

// Namespace namespace_6020b123/namespace_6020b123
// Params 0
// Checksum 0xa8eb7e8e, Offset: 0x1908
// Size: 0x1e
function function_3d2d64ea()
{
    self.health = 1;
    self.var_c681e4c1 = 1;
}

