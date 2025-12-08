#using script_165beea08a63a243;
#using script_340a2e805e35f7a2;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\item_world_util;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace namespace_58949729;

// Namespace namespace_58949729/namespace_58949729
// Params 0, eflags: 0x6
// Checksum 0xe3270d1, Offset: 0x270
// Size: 0x54
function private autoexec __init__system__()
{
    system::register( #"hash_5f19cd68b4607f52", &preinit, undefined, &finalize, #"content_manager" );
}

// Namespace namespace_58949729/namespace_58949729
// Params 0
// Checksum 0xbbd2be48, Offset: 0x2d0
// Size: 0xc4c
function preinit()
{
    level.var_8634611a = [];
    level.var_6fff281a = [];
    level.var_b048b7e = [];
    content_manager::register_script( "explore_chests", &function_50855654 );
    content_manager::register_script( "explore_chests_large", &function_c3e93273 );
    content_manager::register_script( "explore_chests_small", &function_61f1a62e );
    content_manager::register_script( "loot_pods", &function_3e953077 );
    clientfield::register( "scriptmover", "reward_chest_fx", 1, getminbitcountfornum( 4 ), "int" );
    function_6ac967bf( #"large", 1, #"large_chest_level_1" );
    function_6ac967bf( #"large", 2, #"large_chest_level_2" );
    function_6ac967bf( #"large", 3, #"large_chest_level_3" );
    function_6ac967bf( #"large", 4, #"large_chest_level_4" );
    function_6ac967bf( #"large", 5, #"large_chest_level_5" );
    function_6ac967bf( #"large", 6, #"large_chest_level_6" );
    function_6ac967bf( #"medium", 1, #"medium_chest_level_1" );
    function_6ac967bf( #"medium", 2, #"medium_chest_level_2" );
    function_6ac967bf( #"medium", 3, #"medium_chest_level_3" );
    function_6ac967bf( #"medium", 4, #"medium_chest_level_4" );
    function_6ac967bf( #"medium", 5, #"medium_chest_level_5" );
    function_6ac967bf( #"medium", 6, #"medium_chest_level_6" );
    function_6ac967bf( #"small", 1, #"small_chest_level_1" );
    function_6ac967bf( #"small", 2, #"small_chest_level_2" );
    function_6ac967bf( #"small", 3, #"small_chest_level_3" );
    function_6ac967bf( #"small", 4, #"small_chest_level_4" );
    function_6ac967bf( #"small", 5, #"small_chest_level_5" );
    function_6ac967bf( #"small", 6, #"small_chest_level_6" );
    function_6ac967bf( #"pod", 1, #"loot_pod_level_1" );
    function_6ac967bf( #"pod", 2, #"loot_pod_level_2" );
    function_6ac967bf( #"pod", 3, #"loot_pod_level_3" );
    function_6ac967bf( #"pod", 4, #"loot_pod_level_4" );
    function_6ac967bf( #"pod", 5, #"loot_pod_level_5" );
    function_6ac967bf( #"pod", 6, #"loot_pod_level_6" );
    function_8e7c24bc( #"normal", 1, #"normal_zombie_level1_drop_list" );
    function_8e7c24bc( #"normal", 2, #"normal_zombie_level2_drop_list" );
    function_8e7c24bc( #"normal", 3, #"normal_zombie_level3_drop_list" );
    function_8e7c24bc( #"normal", 4, #"normal_zombie_level4_drop_list" );
    function_8e7c24bc( #"normal", 5, #"normal_zombie_level5_drop_list" );
    function_8e7c24bc( #"normal", 6, #"normal_zombie_level6_drop_list" );
    function_8e7c24bc( #"zombie_medium_armor", 1, #"armor_zombie_level1_drop_list" );
    function_8e7c24bc( #"zombie_medium_armor", 2, #"armor_zombie_level2_drop_list" );
    function_8e7c24bc( #"zombie_medium_armor", 3, #"armor_zombie_level3_drop_list" );
    function_8e7c24bc( #"zombie_medium_armor", 4, #"armor_zombie_level4_drop_list" );
    function_8e7c24bc( #"zombie_medium_armor", 5, #"armor_zombie_level5_drop_list" );
    function_8e7c24bc( #"zombie_medium_armor", 6, #"armor_zombie_level6_drop_list" );
    function_8e7c24bc( #"hash_7a778318514578f7", 1, #"armor_zombie_level1_drop_list" );
    function_8e7c24bc( #"hash_7a778318514578f7", 2, #"armor_zombie_level2_drop_list" );
    function_8e7c24bc( #"hash_7a778318514578f7", 3, #"armor_zombie_level3_drop_list" );
    function_8e7c24bc( #"hash_7a778318514578f7", 4, #"armor_zombie_level4_drop_list" );
    function_8e7c24bc( #"hash_7a778318514578f7", 5, #"armor_zombie_level5_drop_list" );
    function_8e7c24bc( #"hash_7a778318514578f7", 6, #"armor_zombie_level6_drop_list" );
    function_8e7c24bc( #"special", 1, #"special_zombie_level1_drop_list" );
    function_8e7c24bc( #"special", 2, #"special_zombie_level2_drop_list" );
    function_8e7c24bc( #"special", 3, #"special_zombie_level3_drop_list" );
    function_8e7c24bc( #"special", 4, #"special_zombie_level4_drop_list" );
    function_8e7c24bc( #"special", 5, #"special_zombie_level5_drop_list" );
    function_8e7c24bc( #"special", 6, #"special_zombie_level6_drop_list" );
    function_8e7c24bc( #"elite", 1, #"elite_zombie_level1_drop_list" );
    function_8e7c24bc( #"elite", 2, #"elite_zombie_level2_drop_list" );
    function_8e7c24bc( #"elite", 3, #"elite_zombie_level3_drop_list" );
    function_8e7c24bc( #"elite", 4, #"elite_zombie_level4_drop_list" );
    function_8e7c24bc( #"elite", 5, #"elite_zombie_level5_drop_list" );
    function_8e7c24bc( #"elite", 6, #"elite_zombie_level6_drop_list" );
    function_8e7c24bc( #"hash_605d177c53e5682e", 1, #"elite_zombie_level1_bonus_drop_list" );
    function_8e7c24bc( #"hash_605d177c53e5682e", 2, #"elite_zombie_level2_bonus_drop_list" );
    function_8e7c24bc( #"hash_605d177c53e5682e", 3, #"elite_zombie_level3_bonus_drop_list" );
    function_8e7c24bc( #"hash_605d177c53e5682e", 4, #"elite_zombie_level4_bonus_drop_list" );
    function_8e7c24bc( #"hash_605d177c53e5682e", 5, #"elite_zombie_level5_bonus_drop_list" );
    function_8e7c24bc( #"hash_605d177c53e5682e", 6, #"elite_zombie_level6_bonus_drop_list" );
}

// Namespace namespace_58949729/namespace_58949729
// Params 0
// Checksum 0x1b71b53e, Offset: 0xf28
// Size: 0x1c
function finalize()
{
    /#
        level thread init_devgui();
    #/
}

// Namespace namespace_58949729/namespace_58949729
// Params 0
// Checksum 0xb7b9ace0, Offset: 0xf50
// Size: 0x34
function function_5a12541e()
{
    level.var_82d4d3b8 = 0;
    callback::on_ai_killed( &function_2394df30 );
}

// Namespace namespace_58949729/namespace_58949729
// Params 3, eflags: 0x4
// Checksum 0x4d27eccf, Offset: 0xf90
// Size: 0x5a
function private function_6ac967bf( type, star_rating, list )
{
    if ( !isdefined( level.var_6fff281a[ type ] ) )
    {
        level.var_6fff281a[ type ] = [];
    }
    
    level.var_6fff281a[ type ][ star_rating ] = list;
}

// Namespace namespace_58949729/namespace_58949729
// Params 3, eflags: 0x4
// Checksum 0x609391e2, Offset: 0xff8
// Size: 0x5a
function private function_8e7c24bc( type, star_rating, list )
{
    if ( !isdefined( level.var_b048b7e[ type ] ) )
    {
        level.var_b048b7e[ type ] = [];
    }
    
    level.var_b048b7e[ type ][ star_rating ] = list;
}

// Namespace namespace_58949729/namespace_58949729
// Params 1
// Checksum 0x9b8b5cc8, Offset: 0x1060
// Size: 0x2b0
function function_2394df30( s_params )
{
    if ( is_true( self.var_98f1f37c ) )
    {
        return;
    }
    
    if ( is_true( level.no_powerups ) || is_true( self.no_powerups ) )
    {
        return;
    }
    
    e_player = s_params.eattacker;
    
    if ( !isplayer( e_player ) )
    {
        return;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_4aeae769 = self.origin;
    var_3ecf13fe = self.angles;
    var_35d10171 = self.zm_ai_category;
    var_408fcfcb = self.subarchetype;
    var_9bbfe6c2 = 1;
    var_ec6368f9 = function_257d7203( var_35d10171 );
    
    if ( var_408fcfcb === #"zombie_medium_armor" || var_408fcfcb === #"hash_7a778318514578f7" )
    {
        var_ec6368f9 = function_257d7203( var_408fcfcb );
    }
    
    dropstruct = { #origin:var_4aeae769, #angles:var_3ecf13fe, #var_738dfc81:1 };
    dropstruct namespace_65181344::function_fd87c780( var_ec6368f9, 1, 2 );
    
    if ( var_35d10171 === #"special" )
    {
        dropstruct namespace_65181344::function_fd87c780( #"special_ammo_drop", 1, 2 );
    }
    else if ( var_35d10171 == #"elite" )
    {
        dropstruct namespace_65181344::function_fd87c780( #"special_ammo_drop", 1, 2 );
        var_433a1d59 = function_257d7203( #"hash_605d177c53e5682e" );
        dropstruct namespace_65181344::function_fd87c780( var_433a1d59, 1, 2 );
    }
    
    if ( isdefined( level.var_b20199e0 ) )
    {
        dropstruct [[ level.var_b20199e0 ]]();
    }
}

// Namespace namespace_58949729/namespace_58949729
// Params 1
// Checksum 0xfeff92f6, Offset: 0x1318
// Size: 0x7a
function function_257d7203( type = #"normal" )
{
    star_rating = zm_utility::function_e3025ca5();
    
    if ( isdefined( level.var_b048b7e[ type ][ star_rating ] ) )
    {
        return level.var_b048b7e[ type ][ star_rating ];
    }
    
    return #"normal_zombie_level1_drop_list";
}

// Namespace namespace_58949729/namespace_58949729
// Params 1
// Checksum 0xc7968a1d, Offset: 0x13a0
// Size: 0x7a
function function_fd5e77fa( type = #"small" )
{
    star_rating = zm_utility::function_e3025ca5();
    
    if ( isdefined( level.var_6fff281a[ type ][ star_rating ] ) )
    {
        return level.var_6fff281a[ type ][ star_rating ];
    }
    
    return #"small_chest_level_1";
}

// Namespace namespace_58949729/namespace_58949729
// Params 1
// Checksum 0x69c0bb82, Offset: 0x1428
// Size: 0xcc
function function_c3e93273( instance )
{
    var_cc1fb2d0 = function_fd5e77fa( #"large" );
    var_3a053962 = #"p9_sur_crate_chest_world_01_lrg";
    
    /#
        str_dvar = "<dev string:x38>";
    #/
    
    var_c6e3f0a = 5;
    
    if ( getplayers().size > 3 )
    {
        var_c6e3f0a += 1;
    }
    
    function_34c59c2c( instance, var_c6e3f0a, var_cc1fb2d0, var_3a053962, 3, str_dvar );
}

// Namespace namespace_58949729/namespace_58949729
// Params 1
// Checksum 0x746e3577, Offset: 0x1500
// Size: 0xcc
function function_50855654( instance )
{
    var_cc1fb2d0 = function_fd5e77fa( #"medium" );
    var_3a053962 = #"hash_45aa59ef345ccdfd";
    
    /#
        str_dvar = "<dev string:x56>";
    #/
    
    var_c6e3f0a = 10;
    
    if ( getplayers().size > 2 )
    {
        var_c6e3f0a += 1;
    }
    
    function_34c59c2c( instance, var_c6e3f0a, var_cc1fb2d0, var_3a053962, 2, str_dvar );
}

// Namespace namespace_58949729/namespace_58949729
// Params 1
// Checksum 0x3327bcd, Offset: 0x15d8
// Size: 0xcc
function function_61f1a62e( instance )
{
    var_cc1fb2d0 = function_fd5e77fa( #"small" );
    var_3a053962 = #"hash_193f3ef9e0c714f";
    
    /#
        str_dvar = "<dev string:x75>";
    #/
    
    var_c6e3f0a = 10;
    
    if ( getplayers().size > 1 )
    {
        var_c6e3f0a += 1;
    }
    
    function_34c59c2c( instance, var_c6e3f0a, var_cc1fb2d0, var_3a053962, 1, str_dvar );
}

// Namespace namespace_58949729/namespace_58949729
// Params 6
// Checksum 0xbcc49062, Offset: 0x16b0
// Size: 0x2bc
function function_34c59c2c( instance, var_c6e3f0a, var_cc1fb2d0, var_3a053962, var_dae71351, str_dvar )
{
    var_842cdacd = instance.contentgroups[ #"chest_spawn" ];
    var_842cdacd = array::randomize( var_842cdacd );
    var_8634611a = [];
    
    for ( i = 0; i < var_842cdacd.size ; i++ )
    {
        struct = var_842cdacd[ i ];
        
        if ( isdefined( struct.scriptmodel ) )
        {
            struct.scriptmodel delete();
        }
        
        if ( isdefined( struct.trigger ) )
        {
            struct.trigger delete();
        }
        
        if ( var_8634611a.size >= var_c6e3f0a )
        {
            continue;
        }
        
        var_df4d665a = function_ce254cce( struct );
        util::wait_network_frame();
        
        /#
            level thread function_e4314d0e( struct );
        #/
        
        if ( !var_df4d665a )
        {
            continue;
        }
        
        function_4ec9fc99( struct, var_cc1fb2d0, var_3a053962, var_dae71351 );
        
        if ( !isdefined( var_8634611a ) )
        {
            var_8634611a = [];
        }
        else if ( !isarray( var_8634611a ) )
        {
            var_8634611a = array( var_8634611a );
        }
        
        if ( !isinarray( var_8634611a, struct ) )
        {
            var_8634611a[ var_8634611a.size ] = struct;
        }
        
        if ( !isdefined( level.var_8634611a ) )
        {
            level.var_8634611a = [];
        }
        else if ( !isarray( level.var_8634611a ) )
        {
            level.var_8634611a = array( level.var_8634611a );
        }
        
        if ( !isinarray( level.var_8634611a, struct ) )
        {
            level.var_8634611a[ level.var_8634611a.size ] = struct;
        }
    }
    
    /#
        instance.var_8634611a = var_8634611a;
        level thread function_8f59f892( instance, str_dvar );
    #/
}

// Namespace namespace_58949729/namespace_58949729
// Params 1
// Checksum 0x34010947, Offset: 0x1978
// Size: 0x5a, Type: bool
function function_ce254cce( struct )
{
    var_4ee5a6d7 = arraysortclosest( level.var_8634611a, struct.origin, 1, 0, 2000 );
    
    if ( var_4ee5a6d7.size > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_58949729/namespace_58949729
// Params 4
// Checksum 0x9c56fe06, Offset: 0x19e0
// Size: 0x142
function function_4ec9fc99( struct, var_cc1fb2d0, var_3a053962, var_dae71351 )
{
    struct.scriptmodel = content_manager::spawn_script_model( struct, var_3a053962, 1 );
    struct.scriptmodel clientfield::set( "reward_chest_fx", var_dae71351 );
    
    if ( var_3a053962 === "p9_sur_crate_chest_world_01_lrg" )
    {
        struct.scriptmodel setscale( 0.8 );
    }
    
    struct.var_422ae63e = #"hash_68664ff37bd007b6";
    trigger = content_manager::spawn_interact( struct, &function_8665f666, #"hash_4703982104472957", undefined, 128 );
    trigger.struct = struct;
    trigger.var_cc1fb2d0 = var_cc1fb2d0;
    trigger.targetname = "explore_chest_trigger";
    struct.trigger = trigger;
    trigger.origin += ( 0, 0, 16 );
}

// Namespace namespace_58949729/namespace_58949729
// Params 3
// Checksum 0x8e29b49c, Offset: 0x1b30
// Size: 0x258
function function_25979f32( struct, var_93fe96a6, s_instance )
{
    if ( isdefined( s_instance ) && s_instance flag::get( "cleanup" ) )
    {
        return;
    }
    
    struct.var_422ae63e = #"p8_fxanim_wz_supply_stash_04_bundle";
    struct.scriptmodel = content_manager::spawn_script_model( struct, "p8_fxanim_wz_supply_stash_04_glow_mod", 1 );
    struct.scriptmodel clientfield::set( "reward_chest_fx", 4 );
    trigger = content_manager::spawn_interact( struct, &function_8665f666, #"hash_4703982104472957", undefined, 128 );
    trigger.struct = struct;
    trigger.var_cc1fb2d0 = function_fd5e77fa( #"large" );
    struct.scriptmodel.trigger = trigger;
    trigger.origin += ( 0, 0, 16 );
    
    if ( is_true( var_93fe96a6 ) )
    {
        struct.var_e234ef47 = gameobjects::get_next_obj_id();
        objective_add( struct.var_e234ef47, "active", struct.scriptmodel, "sr_obj_explore" );
    }
    
    if ( isdefined( s_instance ) )
    {
        if ( !isdefined( s_instance.var_f46ace2 ) )
        {
            s_instance.var_f46ace2 = [];
        }
        else if ( !isarray( s_instance.var_f46ace2 ) )
        {
            s_instance.var_f46ace2 = array( s_instance.var_f46ace2 );
        }
        
        if ( !isinarray( s_instance.var_f46ace2, struct ) )
        {
            s_instance.var_f46ace2[ s_instance.var_f46ace2.size ] = struct;
        }
    }
}

// Namespace namespace_58949729/namespace_58949729
// Params 1
// Checksum 0x6ecae5ae, Offset: 0x1d90
// Size: 0xc4
function function_ccf9be41( s_instance )
{
    if ( isdefined( s_instance.var_f46ace2 ) )
    {
        foreach ( s_chest in s_instance.var_f46ace2 )
        {
            if ( isdefined( s_chest ) )
            {
                function_a3852ab5( s_chest );
            }
        }
        
        arrayremovevalue( s_instance.var_f46ace2, undefined );
    }
}

// Namespace namespace_58949729/namespace_58949729
// Params 1
// Checksum 0x9e7c6251, Offset: 0x1e60
// Size: 0x9c
function function_a3852ab5( struct )
{
    function_a5d57202( struct );
    
    if ( isdefined( struct.scriptmodel.trigger ) )
    {
        struct.scriptmodel.trigger delete();
    }
    
    if ( isdefined( struct.scriptmodel ) )
    {
        struct.scriptmodel scene::stop();
        struct.scriptmodel delete();
    }
}

// Namespace namespace_58949729/namespace_58949729
// Params 1
// Checksum 0x2c447bfd, Offset: 0x1f08
// Size: 0x56
function function_a5d57202( struct )
{
    if ( isdefined( struct.var_e234ef47 ) )
    {
        objective_delete( struct.var_e234ef47 );
        gameobjects::release_obj_id( struct.var_e234ef47 );
        struct.var_e234ef47 = undefined;
    }
}

// Namespace namespace_58949729/namespace_58949729
// Params 0
// Checksum 0xec2a5f80, Offset: 0x1f68
// Size: 0x1fe
function function_2901cde1()
{
    self notify( "4b88fd41859d49e4" );
    self endon( "4b88fd41859d49e4" );
    self endon( #"death" );
    
    while ( true )
    {
        foreach ( player in getplayers() )
        {
            if ( !isdefined( player.var_4ee86e15 ) )
            {
                player.var_4ee86e15 = [];
            }
            
            if ( !isinarray( player.var_4ee86e15, self ) && distancesquared( player.origin, self.origin ) < 1562500 )
            {
                player thread globallogic_audio::play_taacom_dialog( "treasureChest" );
                arrayremovevalue( player.var_4ee86e15, undefined );
                
                if ( !isdefined( player.var_4ee86e15 ) )
                {
                    player.var_4ee86e15 = [];
                }
                else if ( !isarray( player.var_4ee86e15 ) )
                {
                    player.var_4ee86e15 = array( player.var_4ee86e15 );
                }
                
                if ( !isinarray( player.var_4ee86e15, self ) )
                {
                    player.var_4ee86e15[ player.var_4ee86e15.size ] = self;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_58949729/namespace_58949729
// Params 1
// Checksum 0x97eb3cfb, Offset: 0x2170
// Size: 0x1f4
function function_8665f666( *eventstruct )
{
    if ( is_true( self.b_opened ) )
    {
        return;
    }
    
    self.b_opened = 1;
    self callback::remove_on_trigger( &function_8665f666 );
    self triggerenable( 0 );
    self.struct.scriptmodel thread scene::play( self.struct.var_422ae63e, self.struct.scriptmodel );
    var_2fab6c8d = #"hash_3c26138474513c5c";
    
    if ( isdefined( self.var_cc1fb2d0 ) )
    {
        if ( self.var_cc1fb2d0 === #"sr_explore_chest_medium" )
        {
            var_2fab6c8d = #"hash_2f094f31f2dbf8f4";
        }
        else if ( self.var_cc1fb2d0 === #"sr_explore_chest_large" )
        {
            var_2fab6c8d = #"hash_6f32121c959e02d0";
        }
    }
    
    self.struct.scriptmodel playsound( var_2fab6c8d );
    wait 1;
    
    if ( isdefined( self.struct.scriptmodel ) )
    {
        level thread function_f82f361c( self.struct, self.var_cc1fb2d0, 3 );
        self.struct.scriptmodel thread function_1e2500f();
    }
    
    waittillframeend();
    
    if ( isdefined( self ) )
    {
        function_a5d57202( self.struct );
        self delete();
    }
}

// Namespace namespace_58949729/namespace_58949729
// Params 0
// Checksum 0x5995b39d, Offset: 0x2370
// Size: 0xac
function function_1e2500f()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self clientfield::set( "reward_chest_fx", 0 );
    level function_a518db14( self.origin );
    self scene::stop();
    util::wait_network_frame();
    self delete();
}

// Namespace namespace_58949729/namespace_58949729
// Params 2
// Checksum 0x40faec11, Offset: 0x2428
// Size: 0x78
function function_a518db14( location, radius = 1500 )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( getplayers( "all", location, radius ).size == 0 )
        {
            return;
        }
        
        wait 5;
    }
}

// Namespace namespace_58949729/namespace_58949729
// Params 3
// Checksum 0xd15002b4, Offset: 0x24a8
// Size: 0xee
function function_f82f361c( struct, var_cc1fb2d0, var_98d110e6 = 1 )
{
    scriptmodel = struct.scriptmodel;
    scriptmodel notsolid();
    n_count = struct.var_738dfc81;
    
    if ( !isdefined( n_count ) )
    {
        n_count = 99;
    }
    
    dropstruct = { #origin:scriptmodel.origin, #angles:scriptmodel.angles, #var_738dfc81:n_count };
    a_items = dropstruct namespace_65181344::function_fd87c780( var_cc1fb2d0, n_count, var_98d110e6 );
}

// Namespace namespace_58949729/namespace_58949729
// Params 1
// Checksum 0xea06d724, Offset: 0x25a0
// Size: 0x46e
function function_3e953077( instance )
{
    var_168390c = 0;
    var_e472e403 = 15;
    var_5b7bb632 = 0;
    var_cb77f56c = instance.contentgroups[ #"pod_group" ];
    
    if ( isdefined( var_cb77f56c ) )
    {
        /#
            level.var_50e94447 = var_cb77f56c;
        #/
        
        var_cb77f56c = array::randomize( var_cb77f56c );
        
        foreach ( s_group in var_cb77f56c )
        {
            var_3471a9bf = 0;
            var_842cdacd = array::randomize( s_group.contentgroups[ #"pod_spawn" ] );
            
            foreach ( spawn in var_842cdacd )
            {
                if ( var_168390c )
                {
                    continue;
                }
                
                if ( randomint( 100 ) > var_e472e403 || getdvarint( #"hash_731bacd49b186d10", 0 ) )
                {
                    model = array::random( array( #"p9_sur_crystal_medium_01", #"p9_sur_crystal_medium_02" ) );
                    var_37180a9f = util::spawn_model( model, spawn.origin, spawn.angles, undefined, 1 );
                    
                    if ( isdefined( var_37180a9f ) )
                    {
                        var_5b7bb632++;
                        var_3471a9bf++;
                        
                        if ( !isdefined( instance.a_models ) )
                        {
                            instance.a_models = [];
                        }
                        else if ( !isarray( instance.a_models ) )
                        {
                            instance.a_models = array( instance.a_models );
                        }
                        
                        instance.a_models[ instance.a_models.size ] = var_37180a9f;
                        var_37180a9f setscale( randomfloatrange( 0.85, 1.2 ) );
                        var_37180a9f val::set( "loot_pod", "takedamage", 1 );
                        var_37180a9f.health = 50;
                        var_37180a9f.var_e9560673 = spawn.var_e9560673;
                        var_37180a9f fx::play( #"hash_6583defa5c93e609", var_37180a9f.origin, var_37180a9f.angles, #"pod_destroyed", 1 );
                        
                        /#
                            var_37180a9f.targetname = "<dev string:x93>";
                        #/
                        
                        level thread function_8265e656( var_37180a9f );
                        
                        if ( ( var_5b7bb632 >= 33 || var_3471a9bf >= 7 ) && !getdvarint( #"hash_731bacd49b186d10", 0 ) )
                        {
                            var_168390c = 1;
                            continue;
                        }
                        
                        util::wait_network_frame();
                    }
                }
            }
            
            if ( var_5b7bb632 < 33 )
            {
                var_168390c = 0;
            }
        }
    }
}

// Namespace namespace_58949729/namespace_58949729
// Params 1
// Checksum 0x45f874f2, Offset: 0x2a18
// Size: 0x36c
function function_8265e656( var_37180a9f )
{
    level endon( #"hash_4a140b223cb0019d" );
    
    while ( isdefined( var_37180a9f ) && var_37180a9f.health > 0 )
    {
        s_result = var_37180a9f waittill( #"damage", #"death" );
        
        if ( isplayer( s_result.attacker ) && isalive( s_result.attacker ) )
        {
            s_result.attacker util::show_hit_marker();
        }
    }
    
    if ( isplayer( s_result.attacker ) || isai( s_result.attacker ) || isvehicle( s_result.attacker ) )
    {
        if ( is_true( var_37180a9f.var_e9560673 ) )
        {
            v_forward = anglestoforward( var_37180a9f.angles );
        }
        else
        {
            v_forward = anglestoup( var_37180a9f.angles );
        }
        
        var_7580ce3e = spawnstruct();
        var_7580ce3e.origin = var_37180a9f.origin;
        var_7580ce3e.var_738dfc81 = 1;
        var_7580ce3e.scriptmodel = var_37180a9f;
        var_4c4636ef = var_7580ce3e.scriptmodel worldtolocalcoords( var_7580ce3e.scriptmodel.origin );
        var_4c4636ef = ( var_4c4636ef[ 0 ], var_4c4636ef[ 1 ], var_4c4636ef[ 2 ] + 8 );
        var_7580ce3e.origin = var_7580ce3e.scriptmodel localtoworldcoords( var_4c4636ef );
        var_37180a9f notify( #"pod_destroyed" );
        var_37180a9f fx::play( #"hash_65063e9505bafd58", var_37180a9f.origin, var_37180a9f.angles );
        
        if ( var_37180a9f.modelname === "p9_sur_crystal_medium_01" )
        {
            var_37180a9f setmodel( #"p9_sur_crystal_medium_01_dmg" );
        }
        else
        {
            var_37180a9f setmodel( #"p9_sur_crystal_medium_02_dmg" );
        }
        
        reward_list = function_fd5e77fa( #"pod" );
        level thread function_f82f361c( var_7580ce3e, reward_list, 4 );
        var_7580ce3e struct::delete();
    }
}

/#

    // Namespace namespace_58949729/namespace_58949729
    // Params 0
    // Checksum 0xf7fe5d7, Offset: 0x2d90
    // Size: 0x134, Type: dev
    function init_devgui()
    {
        util::waittill_can_add_debug_command();
        util::add_devgui( "<dev string:x9f>", "<dev string:xcc>" );
        util::add_devgui( "<dev string:xef>", "<dev string:x121>" );
        util::add_devgui( "<dev string:x13f>", "<dev string:x172>" );
        util::add_devgui( "<dev string:x196>", "<dev string:x1ca>" );
        util::add_devgui( "<dev string:x1ef>", "<dev string:x222>" );
        util::add_devgui( "<dev string:x246>", "<dev string:x271>" );
        util::add_devgui( "<dev string:x28f>", "<dev string:x2b8>" );
        util::add_devgui( "<dev string:x2d7>", "<dev string:x308>" );
        level thread function_b6b13cf8();
    }

    // Namespace namespace_58949729/namespace_58949729
    // Params 0
    // Checksum 0xfb94ddff, Offset: 0x2ed0
    // Size: 0x3be, Type: dev
    function function_b6b13cf8()
    {
        var_50721d66 = 0;
        
        while ( true )
        {
            var_8f420c16 = getdvarint( #"hash_731bacd49b186d10", 0 );
            
            if ( var_8f420c16 && isdefined( level.var_50e94447 ) )
            {
                iprintlnbold( "<dev string:x32e>" );
                function_3e953077( level.var_50e94447[ 0 ].parent );
                iprintlnbold( "<dev string:x354>" );
                setdvar( #"hash_731bacd49b186d10", 0 );
            }
            
            var_794c9d5f = getdvarint( #"hash_748d6103fdf3d390", 0 );
            
            if ( var_794c9d5f )
            {
                var_55b8433b = getentarray( "<dev string:x93>", "<dev string:x360>" );
                
                foreach ( pod in var_55b8433b )
                {
                    n_radius = 64;
                    n_dist = distance( pod.origin, getplayers()[ 0 ].origin );
                    n_radius *= n_dist / 3000;
                    sphere( pod.origin, n_radius, ( 1, 0, 1 ), 0.7, 0, 7, 3 );
                }
            }
            
            var_90f51d74 = getdvarint( #"hash_31e154b4986045db", 1 );
            
            if ( var_90f51d74 && isdefined( level.var_50e94447 ) )
            {
                setdvar( #"hash_31e154b4986045db", 0 );
                
                if ( var_50721d66 >= level.var_50e94447.size - 1 )
                {
                    var_50721d66 = 0;
                }
                
                s_group = level.var_50e94447[ var_50721d66 ];
                
                if ( isdefined( s_group ) )
                {
                    foreach ( player in function_a1ef346b() )
                    {
                        player setorigin( s_group.origin );
                        player setplayerangles( s_group.angles );
                    }
                }
                
                var_50721d66++;
            }
            
            waitframe( 3 );
        }
    }

    // Namespace namespace_58949729/namespace_58949729
    // Params 2
    // Checksum 0xc37fb01f, Offset: 0x3298
    // Size: 0x160, Type: dev
    function function_8f59f892( instance, str_dvar )
    {
        level notify( str_dvar );
        level endon( str_dvar );
        var_ad8b756a = 0;
        
        while ( true )
        {
            var_794c9d5f = getdvarint( str_dvar, 0 );
            
            if ( var_794c9d5f )
            {
                setdvar( str_dvar, 0 );
                s_chest = instance.var_8634611a[ var_ad8b756a ];
                
                foreach ( player in function_a1ef346b() )
                {
                    player setorigin( s_chest.origin );
                }
                
                if ( var_ad8b756a >= instance.var_8634611a.size - 1 )
                {
                    var_ad8b756a = 0;
                }
                else
                {
                    var_ad8b756a++;
                }
            }
            
            waitframe( 5 );
        }
    }

    // Namespace namespace_58949729/namespace_58949729
    // Params 1
    // Checksum 0x703123f1, Offset: 0x3400
    // Size: 0x1ee, Type: dev
    function function_e4314d0e( struct )
    {
        while ( true )
        {
            var_794c9d5f = getdvarint( #"hash_29331ff5a16b8d53", 0 );
            
            if ( isdefined( struct.scriptmodel ) )
            {
                struct.b_spawned = 1;
            }
            else if ( var_794c9d5f == 2 && !is_true( struct.b_spawned ) )
            {
                function_6f0024c1( struct );
            }
            
            if ( var_794c9d5f && isdefined( struct ) )
            {
                n_radius = 64;
                n_dist = distance( struct.origin, getplayers()[ 0 ].origin );
                n_radius *= n_dist / 3000;
                
                if ( isdefined( struct.scriptmodel ) )
                {
                    if ( struct.parent.content_script_name === "<dev string:x36e>" )
                    {
                        str_color = ( 0, 1, 1 );
                    }
                    else if ( struct.parent.content_script_name === "<dev string:x386>" )
                    {
                        str_color = ( 0, 1, 0 );
                    }
                    else
                    {
                        str_color = ( 1, 1, 0 );
                    }
                }
                else
                {
                    str_color = ( 0.75, 0.75, 0.75 );
                }
                
                sphere( struct.origin, n_radius, str_color, 1, 0, 10, 3 );
            }
            
            waitframe( 3 );
        }
    }

    // Namespace namespace_58949729/namespace_58949729
    // Params 1
    // Checksum 0xf25dee94, Offset: 0x35f8
    // Size: 0x268, Type: dev
    function function_6f0024c1( struct )
    {
        if ( struct.parent.content_script_name === "<dev string:x36e>" )
        {
            var_cc1fb2d0 = #"sr_explore_chest_large";
            var_3a053962 = "<dev string:x398>";
            var_dae71351 = 3;
        }
        else if ( struct.parent.content_script_name === "<dev string:x386>" )
        {
            var_cc1fb2d0 = #"sr_explore_chest_medium";
            var_3a053962 = "<dev string:x3bb>";
            var_dae71351 = 2;
        }
        else
        {
            var_cc1fb2d0 = #"sr_explore_chest_small";
            var_3a053962 = "<dev string:x3de>";
            var_dae71351 = 1;
        }
        
        function_4ec9fc99( struct, var_cc1fb2d0, var_3a053962, var_dae71351 );
        
        if ( !isdefined( struct.parent.var_8634611a ) )
        {
            struct.parent.var_8634611a = [];
        }
        else if ( !isarray( struct.parent.var_8634611a ) )
        {
            struct.parent.var_8634611a = array( struct.parent.var_8634611a );
        }
        
        if ( !isinarray( struct.parent.var_8634611a, struct ) )
        {
            struct.parent.var_8634611a[ struct.parent.var_8634611a.size ] = struct;
        }
        
        if ( !isdefined( level.var_8634611a ) )
        {
            level.var_8634611a = [];
        }
        else if ( !isarray( level.var_8634611a ) )
        {
            level.var_8634611a = array( level.var_8634611a );
        }
        
        if ( !isinarray( level.var_8634611a, struct ) )
        {
            level.var_8634611a[ level.var_8634611a.size ] = struct;
        }
    }

#/
