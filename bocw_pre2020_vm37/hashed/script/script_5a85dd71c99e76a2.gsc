#using script_2e03cad685678246;
#using script_3072532951b5b4ae;
#using script_3dc93ca9902a9cda;
#using script_55d773296cc240b4;
#using script_58524f08c3081cbb;
#using script_5c325a0a637fdc2e;
#using script_6fad88ff3ed4ff7d;
#using script_c36b776c6718540;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_rus_yamantau_flashlight;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace namespace_cbf28e01;

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x80f724d1, Offset: 0xd98
// Size: 0x4
function function_e39e219e()
{
    
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 2
// Checksum 0xeeec8d0d, Offset: 0xda8
// Size: 0x1ec
function function_37c8a043( *str_objective, *var_50cc0d4f )
{
    level thread scene::init( "scene_yam_1010_hel_intro" );
    level thread globallogic_ui::function_7bc0e4b9();
    level waittill( #"chyron_menu_closed" );
    level.allowbattlechatter[ #"allies" ] = 0;
    level.allowbattlechatter[ #"axis" ] = 0;
    namespace_b73b9191::function_15426f9d( "cull_inside_satcom" );
    namespace_b73b9191::function_15426f9d( "cull_inside_finale" );
    namespace_b73b9191::function_15426f9d( "cull_inside_bunkerext" );
    namespace_b73b9191::function_ee83e03a( "cull_outside_bunkerint" );
    namespace_b73b9191::function_15426f9d( "cull_inside_excavation" );
    level thread function_fe3defb0();
    level thread namespace_8a404420::function_7eb604b9();
    level flag::wait_till( "flg_intro_dialog_done" );
    level thread function_e16fed8b();
    level.ai_woods clientfield::increment( "ai_cold_breath" );
    level thread objectives::scripted( "obj_yamantau_1", undefined, #"hash_423da80c752f859f" );
    skipto::function_4e3ab877( "intro_heli" );
    savegame::checkpoint_save( 1 );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x736e6233, Offset: 0xfa0
// Size: 0x114
function function_fe3defb0()
{
    while ( !isdefined( level.player ) )
    {
        waitframe( 1 );
    }
    
    level.player val::set( "intro", "show_hud", 0 );
    level.player val::set( #"intro", "allow_prone", 0 );
    level flag::wait_till( "flg_intro_dialog_done" );
    level.player val::reset( "intro", "show_hud" );
    level flag::wait_till( "flg_mountain_slide_complete" );
    level.player val::reset( #"intro", "allow_prone" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x4f593d2b, Offset: 0x10c0
// Size: 0x36
function function_3df60a0c()
{
    while ( isdefined( self ) )
    {
        /#
            hms_util::print( "<dev string:x38>" );
        #/
        
        waitframe( 1 );
    }
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 1
// Checksum 0xdcaaf460, Offset: 0x1100
// Size: 0x1c
function function_38910b5f( *str_objective )
{
    namespace_b73b9191::function_2683ec5d();
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 4
// Checksum 0xce6fd2ab, Offset: 0x1128
// Size: 0xbc
function function_a0b88490( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    waitframe( 1 );
    level flag::set( "chyron_menu_closed" );
    namespace_b73b9191::function_15426f9d( "cull_inside_satcom" );
    namespace_b73b9191::function_15426f9d( "cull_inside_finale" );
    namespace_b73b9191::function_15426f9d( "cull_inside_bunkerext" );
    namespace_b73b9191::function_ee83e03a( "cull_outside_bunkerint" );
    namespace_b73b9191::function_15426f9d( "cull_inside_excavation" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 2
// Checksum 0x2ef82c89, Offset: 0x11f0
// Size: 0x1b4
function function_3d1df8a6( *str_objective, *var_50cc0d4f )
{
    var_9bb06b0d = getnode( "ice_slide_exposed_node", "targetname" );
    level.ai_woods thread hms_util::function_b064d2a4( "jog", var_9bb06b0d.origin, "flg_mountain_slide_woods_start", 1 );
    level.player allowslide( 0 );
    level thread function_8ab7aab7();
    level thread function_7503b25a();
    level.ai_woods ai::function_3a5e9945( 1 );
    level thread namespace_7468806b::function_79af70ae( 0 );
    level namespace_5d7a2dac::music( "2.0_ridge", 3 );
    level.ai_woods thread hms_util::function_2f50100e( "stay_ahead", var_9bb06b0d.origin, "flg_mountain_slide_woods_start" );
    level thread namespace_7468806b::function_ec4c365f();
    level thread function_51d9d9c1();
    level flag::wait_till( "flg_mountain_slide_woods_start" );
    skipto::function_4e3ab877( "mountain_summit" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x965ad2e, Offset: 0x13b0
// Size: 0x1c8
function function_7503b25a()
{
    self endon( #"flg_ice_slide_complete" );
    s_mountain_hill_top_ref = struct::get( "s_mountain_hill_top_ref", "targetname" );
    var_63d42019 = 0;
    
    while ( true )
    {
        if ( flag::get( "flg_mountain_uphill_check" ) )
        {
            if ( level.player issprinting() )
            {
                var_a92e0e1c = distancesquared( level.player.origin, s_mountain_hill_top_ref.origin );
                
                if ( var_a92e0e1c > 50 && var_63d42019 == 0 && level flag::get( "flg_mountain_uphill_check" ) )
                {
                    level.player util::blend_movespeedscale( 0.4, 0.5 );
                    var_63d42019 = 1;
                }
            }
            else if ( var_63d42019 == 1 )
            {
                level.player util::blend_movespeedscale( 0.6, 0.5 );
                var_63d42019 = 0;
            }
        }
        else if ( var_63d42019 == 1 )
        {
            level.player util::blend_movespeedscale( 0.6, 0.5 );
            var_63d42019 = 0;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0xfd78885, Offset: 0x1580
// Size: 0x74
function function_8ab7aab7()
{
    level.player val::set( "mountain", "allow_jump", 0 );
    level flag::wait_till( "flg_intro_allow_jump" );
    level.player val::reset( "mountain", "allow_jump" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0xb6be3cd8, Offset: 0x1600
// Size: 0x154
function function_e16fed8b()
{
    while ( !isdefined( level.ai_woods ) )
    {
        waitframe( 1 );
    }
    
    level.ai_woods thread namespace_b73b9191::function_608217cf( "flg_mountain_woods_slide_ready" );
    level thread namespace_b73b9191::function_5c5b6ea7( "s_mountain_woods_path_1", "struct", 0, 1 );
    level flag::wait_till( "flg_mountain_woods_path_2" );
    level thread namespace_b73b9191::function_5c5b6ea7( "s_mountain_woods_path_2", "struct", 0, 1 );
    level flag::wait_till( "flg_mountain_woods_path_3" );
    level thread namespace_b73b9191::function_5c5b6ea7( "s_mountain_woods_path_3", "struct", 0, 1 );
    level flag::wait_till( "flg_mountain_woods_path_4" );
    level thread namespace_b73b9191::function_5c5b6ea7( "s_mountain_woods_path_4", "struct", 0, 1 );
    level thread function_3dedd355();
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x96235186, Offset: 0x1760
// Size: 0x24
function function_51d9d9c1()
{
    level thread breadcrumb::function_61037c6c( #"hash_72504ca297c1cdf9" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 1
// Checksum 0x619908db, Offset: 0x1790
// Size: 0x11c
function function_d3655e70( *str_objective )
{
    level thread objectives::scripted( "obj_yamantau_1", undefined, #"hash_423da80c752f859f" );
    namespace_b73b9191::function_2683ec5d();
    level thread function_e16fed8b();
    level thread function_fe3defb0();
    level flag::set( "flg_intro_dialog_done" );
    level.allowbattlechatter[ #"allies" ] = 0;
    level.allowbattlechatter[ #"axis" ] = 0;
    s_mountain_woods_teleport = struct::get( "s_mountain_woods_teleport", "targetname" );
    level.ai_woods forceteleport( s_mountain_woods_teleport.origin, s_mountain_woods_teleport.angles );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 4
// Checksum 0xc34028e7, Offset: 0x18b8
// Size: 0x24
function function_fdbb9f1e( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 2
// Checksum 0xa467847b, Offset: 0x18e8
// Size: 0x18c
function function_ae06da18( *str_objective, var_50cc0d4f )
{
    if ( var_50cc0d4f )
    {
        level thread function_7503b25a();
    }
    
    level.ai_woods notify( #"flg_mountain_slide_woods_start" );
    level thread function_ed43d759();
    level thread function_d7c4e9();
    level thread function_2f86f258();
    level thread namespace_7468806b::function_3325b147();
    var_fd13eeab = getnode( "intro_zipline_woods_node", "targetname" );
    level.ai_woods thread hms_util::function_2f50100e( "stay_even", var_fd13eeab.origin, "flg_mountains_zipline_dialogue" );
    level flag::wait_till( "flg_ice_slide_start_save" );
    savegame::checkpoint_save( 1 );
    level flag::wait_till( "flg_ice_slide_complete" );
    savegame::checkpoint_save( 1 );
    skipto::function_4e3ab877( "ice_slide" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x26da4fe7, Offset: 0x1a80
// Size: 0xfc
function function_d7c4e9()
{
    level flag::wait_till( "flg_mountain_post_slide_landing" );
    level.player util::blend_movespeedscale( 0.6, 0.5 );
    level.player shellshock( #"default", 0.25 );
    earthquake( 0.3, 1, level.player.origin, 150 );
    level.player util::blend_movespeedscale( 1, 1 );
    level.player allowslide( 1 );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x6b5d987, Offset: 0x1b88
// Size: 0x64
function function_3dedd355()
{
    while ( !isdefined( level.ai_woods ) )
    {
        waitframe( 1 );
    }
    
    level flag::wait_till( "flg_mountain_slide_woods_start" );
    level thread namespace_b73b9191::function_5c5b6ea7( "s_mountain_slide_woods_start", "struct", 0, 1 );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0xdbfd8498, Offset: 0x1bf8
// Size: 0x1dc
function function_ed43d759()
{
    level flag::wait_till( "flg_mountain_woods_slide_ready" );
    level.ai_woods ai::function_3a5e9945( 0 );
    level.ai_woods setgoal( level.ai_woods.origin );
    level scene::play( "scene_yam_3010_sat_slide_woods", array( level.ai_woods ) );
    level.ai_woods ai::function_3a5e9945( 1 );
    self ai::set_behavior_attribute( "demeanor", "cqb" );
    
    if ( !level flag::get( "flg_mountain_woods_advance_to_bldg" ) )
    {
        trigger::use( "tr_mountain_woods_slide_start", "targetname", level.player, 0 );
    }
    
    level flag::wait_till( "flg_mountain_woods_advance_to_bldg" );
    
    if ( !level flag::get( "flg_mountain_woods_dropdown_complete" ) )
    {
        level thread namespace_b73b9191::function_5c5b6ea7( "s_post_slide_woods_path_fast", "struct", 0, 1 );
        return;
    }
    
    level thread namespace_b73b9191::function_5c5b6ea7( "s_post_slide_woods_path_slow", "struct", 0, 1 );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0xea6462c2, Offset: 0x1de0
// Size: 0x74
function function_2f86f258()
{
    level flag::wait_till( "flg_mountain_woods_advance_to_bldg" );
    level.var_52be209f = spawner::simple_spawn_single( "ai_mountain_summit_1", &function_afa7ed6e );
    level thread function_ea4df875( level.var_52be209f );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0xad620408, Offset: 0x1e60
// Size: 0x8c
function function_afa7ed6e()
{
    self endon( #"death" );
    self thread scene::play( "scene_yam_0000_ambient_rooftop_guard_scan", self );
    self thread function_5c4faa0d();
    self namespace_979752dc::function_bf1fb16f();
    self val::set( "mountain_summit_sniper", "ignoreme", 1 );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x1c0d733, Offset: 0x1ef8
// Size: 0x126
function function_5c4faa0d()
{
    self endon( #"death" );
    self util::waittill_any_ents( self, "damage", self, "stealth_combat", self, "bulletwhizby", level, "flg_mountains_sniper_exit_anim" );
    self scene::stop( "scene_yam_0000_ambient_rooftop_guard_scan" );
    self val::reset( "mountain_summit_sniper", "ignoreme" );
    self function_a3fcf9e0( "attack", level.player, level.player getplayercamerapos() );
    self getperfectinfo( level.player );
    self.script_accuracy = 1000;
    self.perfectaim = 1;
    self.favoriteenemy = level.player;
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 1
// Checksum 0x4d5ba2a7, Offset: 0x2028
// Size: 0xac
function function_ea4df875( var_52be209f )
{
    level endon( #"flg_mountains_sniper_exit_anim" );
    
    while ( isalive( var_52be209f ) )
    {
        wait 1;
    }
    
    level flag::set( "mountain_summit_sniper_clear" );
    level thread namespace_7468806b::function_4b868d7e();
    trigger::use( "t_advance_woods_to_zip_intro", "targetname", level.player, 0 );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 1
// Checksum 0x196b5889, Offset: 0x20e0
// Size: 0x124
function function_bb34c64( *str_objective )
{
    level thread objectives::scripted( "obj_yamantau_1", undefined, #"hash_423da80c752f859f" );
    namespace_b73b9191::function_2683ec5d();
    level.ai_woods ai::function_3a5e9945( 1 );
    var_b4bb921 = struct::get( "woods_ice_slide_teleport", "targetname" );
    level.ai_woods forceteleport( var_b4bb921.origin, var_b4bb921.angles );
    level flag::set( "flg_mountain_woods_slide_ready" );
    level thread namespace_7468806b::function_79af70ae( 1 );
    level.allowbattlechatter[ #"allies" ] = 0;
    level.allowbattlechatter[ #"axis" ] = 0;
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 4
// Checksum 0xabf59531, Offset: 0x2210
// Size: 0x24
function function_33fd8fa3( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 2
// Checksum 0xf4612ca9, Offset: 0x2240
// Size: 0x444
function function_11648e12( *str_objective, *var_50cc0d4f )
{
    var_75c2d324 = getent( "zipline_mountain_tutorial", "targetname" );
    var_75c2d324.var_dc6e66ea = 0.7;
    level.player.is_ziplining = 1;
    var_7f7daf16 = struct::get( "zipline_mountain_tutorial_prompt", "targetname" );
    tr_mountain_zipline_woods_color = getent( "tr_mountain_zipline_woods_color", "targetname" );
    nd_woods_satcom_overlook = getnode( "nd_woods_satcom_overlook", "targetname" );
    level thread function_f4cb6831();
    level thread function_de42d9ad();
    level thread namespace_7468806b::function_ba5a28f();
    level thread function_dc28274f();
    level thread namespace_8a404420::function_517fe722();
    level flag::wait_till( "flg_zipline_intro_cleared" );
    savegame::checkpoint_save( 1 );
    level.player.is_ziplining = 0;
    var_75c2d324.var_dc6e66ea = 2;
    objectives::goto( #"hash_164cecb161e0109b", var_7f7daf16.origin + ( 0, 0, 15 ) );
    level.player waittill( #"player_zipline_start" );
    namespace_b73b9191::function_ee83e03a( "cull_inside_satcom" );
    level thread namespace_7468806b::function_32d5f643();
    level namespace_5d7a2dac::music( "4.1_zipline" );
    objectives::complete( #"hash_164cecb161e0109b" );
    level flag::set( "flg_zipline_intro_used" );
    level.ai_woods val::set( #"satcom", "ignoreall", 1 );
    level.ai_woods.var_dfd2d506 = 0;
    level.ai_woods.var_660aa59f = 0.01;
    wait 3;
    
    if ( isdefined( tr_mountain_zipline_woods_color ) )
    {
        trigger::use( "tr_mountain_zipline_woods_color", "targetname", level.player, 0 );
    }
    
    level.ai_woods val::set( #"zipline_mountain_tutorial", "ignoreall", 1 );
    level.ai_woods setgoal( nd_woods_satcom_overlook );
    var_80d333e3 = getnode( "satcom_woods_node", "targetname" );
    level.ai_woods thread hms_util::function_2f50100e( "stay_behind", var_80d333e3.origin, "flg_satcom_approached" );
    objectives::complete( #"hash_164cecb161e0109b" );
    level flag::wait_till( "flg_mountains_zipline_end" );
    skipto::function_4e3ab877( "zipline_intro" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x3a9e25ff, Offset: 0x2690
// Size: 0x178
function function_dc28274f()
{
    var_e1b467ff = getentarray( "e_mountain_zipline_clip", "targetname" );
    level flag::wait_till( "flg_zipline_intro_used" );
    
    foreach ( e_mountain_zipline_clip in var_e1b467ff )
    {
        e_mountain_zipline_clip movez( -1000, 0.1 );
    }
    
    level flag::wait_till( "flg_mountains_zipline_end" );
    
    foreach ( e_mountain_zipline_clip in var_e1b467ff )
    {
        e_mountain_zipline_clip movez( 1000, 0.1 );
    }
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x73a765d5, Offset: 0x2810
// Size: 0x174
function function_de42d9ad()
{
    level.ai_woods endon( #"death" );
    level.ai_woods waittill( #"hash_65134449cd95c3cb" );
    level.ai_woods waittill( #"hash_4c7ded9d08b15793" );
    level.ai_woods.var_dfd2d506 = 1;
    level.ai_woods.var_660aa59f = undefined;
    level.ai_woods val::set( #"zipline_mountain_tutorial", "ignoreall", 0 );
    level flag::set( "flg_intro_zipline_dismount" );
    
    if ( !level flag::get( "flg_zipline_intro_zipliner_killed" ) )
    {
        level.ai_woods val::set( #"hash_19a55d6945f0db9a", "ignoreall", 0 );
        level flag::wait_till( "flg_zipline_intro_zipliner_killed" );
        level.ai_woods val::reset( #"hash_19a55d6945f0db9a", "ignoreall" );
    }
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x94ea9fcc, Offset: 0x2990
// Size: 0x404
function function_f4cb6831()
{
    tr_mountain_zipline_overlook = getent( "tr_mountain_zipline_overlook", "targetname" );
    var_9cdc6574 = getentarray( "tr_mountain_zipline_approach", "targetname" );
    level.var_3369117 = 0;
    var_9d28dc20 = [];
    level.var_d596a87f = spawner::simple_spawn_single( "sp_rus_zipline_patroller_1", &function_77b06f5c );
    level.var_a06bbe2a = spawner::simple_spawn_single( "sp_rus_zipline_patroller_2", &function_77b06f5c, 1 );
    level.var_89f99146 = spawner::simple_spawn_single( "sp_rus_zipline_patroller_3", &function_94354bd7 );
    level.var_74e7e723 = spawner::simple_spawn_single( "sp_rus_zipline_patroller_4", &function_66fc9524 );
    level thread function_75b9b13f();
    level thread function_ef876547();
    level thread function_ddf55816();
    
    if ( isalive( level.var_52be209f ) )
    {
        if ( !isdefined( var_9d28dc20 ) )
        {
            var_9d28dc20 = [];
        }
        else if ( !isarray( var_9d28dc20 ) )
        {
            var_9d28dc20 = array( var_9d28dc20 );
        }
        
        var_9d28dc20[ var_9d28dc20.size ] = level.var_52be209f;
    }
    
    if ( !isdefined( var_9d28dc20 ) )
    {
        var_9d28dc20 = [];
    }
    else if ( !isarray( var_9d28dc20 ) )
    {
        var_9d28dc20 = array( var_9d28dc20 );
    }
    
    var_9d28dc20[ var_9d28dc20.size ] = level.var_d596a87f;
    
    if ( !isdefined( var_9d28dc20 ) )
    {
        var_9d28dc20 = [];
    }
    else if ( !isarray( var_9d28dc20 ) )
    {
        var_9d28dc20 = array( var_9d28dc20 );
    }
    
    var_9d28dc20[ var_9d28dc20.size ] = level.var_a06bbe2a;
    waitframe( 1 );
    level thread namespace_8a404420::function_6240e40f();
    level thread namespace_8a404420::function_f21e84b4();
    
    while ( var_9d28dc20.size > 0 )
    {
        wait 0.5;
        function_1eaaceab( var_9d28dc20, 0 );
    }
    
    level flag::set( "flg_zipline_intro_cleared" );
    
    foreach ( tr in var_9cdc6574 )
    {
        if ( isdefined( tr ) )
        {
            tr triggerenable( 0 );
        }
    }
    
    if ( isdefined( tr_mountain_zipline_overlook ) )
    {
        trigger::use( "tr_mountain_zipline_overlook", "targetname", level.player, 0 );
    }
    
    level.ai_woods pushplayer( 1 );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0xd603eb4c, Offset: 0x2da0
// Size: 0x2f4
function function_94354bd7()
{
    self endon( #"death" );
    self val::set( "zipline_patrol", "ignoreme", 1 );
    self val::set( "zipline_patrol", "ignoreall", 1 );
    self ai::set_behavior_attribute( "demeanor", "patrol" );
    level thread function_ac7492ff( self );
    level flag::wait_till_any( array( "flg_zipline_intro_zipliner_cross", "flg_zipline_intro_stealth_broken" ) );
    
    if ( level flag::get( "flg_zipline_intro_stealth_broken" ) )
    {
        self ai::set_behavior_attribute( "demeanor", "combat" );
        self val::reset_all( "zipline_patrol" );
        return;
    }
    
    self thread function_d32cd800();
    nd_zipliner = getnode( "nd_zipliner", "targetname" );
    wait 1;
    self setgoal( nd_zipliner, 1 );
    self waittill( #"hash_4c7ded9d08b15793" );
    wait 0.5;
    
    if ( !level flag::get( "flg_zipline_intro_rus_weapon_fired" ) )
    {
        self.script_stealthgroup = "stealth_bottom_zipline";
        self namespace_979752dc::do_stealth();
        self val::reset( "zipline_patrol", "ignoreall" );
        level flag::wait_till( "flg_intro_zipline_post" );
    }
    
    nd_zipliner_alert = getnode( "nd_zipliner_alert", "targetname" );
    self setgoal( nd_zipliner_alert, 1 );
    wait 1;
    self ai::set_behavior_attribute( "demeanor", "combat" );
    self val::reset_all( "zipline_patrol" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 1
// Checksum 0x35c76eb5, Offset: 0x30a0
// Size: 0x44
function function_ac7492ff( ai )
{
    ai waittill( #"death" );
    level flag::set( "flg_zipline_intro_zipliner_killed" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0xdba7caba, Offset: 0x30f0
// Size: 0xd4
function function_d32cd800()
{
    self endon( #"hash_4c1bc0b351b4a76f", #"death" );
    level flag::wait_till( "flg_zipline_intro_stealth_broken" );
    nd_zipliner = getnode( "nd_zipliner_combat", "targetname" );
    self setgoal( nd_zipliner, 1 );
    self ai::set_behavior_attribute( "demeanor", "combat" );
    self val::reset_all( "zipline_patrol" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 1
// Checksum 0x7b626c2c, Offset: 0x31d0
// Size: 0x12c
function function_77b06f5c( var_8aa20ba2 = 0 )
{
    self endon( #"death" );
    self val::set( "zipline_patrol", "ignoreme" );
    self thread function_df51d5fa();
    self thread function_7cb7dbe8( var_8aa20ba2 );
    self thread function_2baa592b();
    self thread function_479939d1();
    
    if ( var_8aa20ba2 == 1 )
    {
        self thread function_30fc8357();
    }
    
    self waittill( #"stealth_combat" );
    level flag::set( "flg_zipline_intro_stealth_broken" );
    self val::reset( "zipline_patrol", "ignoreme" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x2a19f4e, Offset: 0x3308
// Size: 0xdc
function function_66fc9524()
{
    self endon( #"death" );
    self val::set( "zipline_patrol", "ignoreme", 1 );
    self val::set( "zipline_patrol", "ignoreall", 1 );
    level flag::wait_till_any( array( "flg_intro_zipline_post", "flg_zipline_intro_rus_weapon_fired" ) );
    wait 1;
    self namespace_979752dc::enable_stealth_for_ai( 0 );
    self val::reset_all( "zipline_patrol" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x72fbee3e, Offset: 0x33f0
// Size: 0x10a
function function_75b9b13f()
{
    level endon( #"flg_zipline_intro_cleared" );
    
    while ( true )
    {
        if ( isalive( level.var_d596a87f ) != 1 && isalive( level.var_a06bbe2a ) != 1 )
        {
            if ( isalive( level.var_89f99146 ) == 1 )
            {
                level.var_89f99146 val::set( "zipline_patrol", "ignoreall", 0 );
            }
            
            if ( isalive( level.var_74e7e723 ) == 1 )
            {
                level.var_74e7e723 val::set( "zipline_patrol", "ignoreall", 0 );
            }
            
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0xb4c3e6ca, Offset: 0x3508
// Size: 0x7c
function function_df51d5fa()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( self cansee( level.ai_woods ) )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    wait 0.2;
    self val::reset( "zipline_patrol", "ignoreme" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 1
// Checksum 0xb1665786, Offset: 0x3590
// Size: 0x154
function function_7cb7dbe8( var_8aa20ba2 )
{
    self endon( #"death" );
    
    if ( var_8aa20ba2 == 1 )
    {
        self allowedstances( "crouch" );
    }
    
    s_notify = self waittill( #"damage" );
    level flag::set( "flg_zipline_intro_engaging" );
    level thread function_1677ef19( self, 0 );
    self val::reset( "zipline_patrol", "ignoreme" );
    
    if ( isalive( self ) && var_8aa20ba2 == 1 )
    {
        self allowedstances( "stand", "crouch" );
    }
    
    self callback::function_d8abfc3d( #"on_ai_killed", &function_4730a08f );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 1
// Checksum 0xfbd80f01, Offset: 0x36f0
// Size: 0x30
function function_4730a08f( s_params )
{
    if ( s_params.eattacker === level.player )
    {
        level.var_3369117++;
    }
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x7d4bf9f5, Offset: 0x3728
// Size: 0x78
function function_2baa592b()
{
    self endon( #"death" );
    self waittill( #"takedown_begin" );
    level flag::set( "flg_zipline_intro_engaging" );
    wait 0.75;
    level thread function_1677ef19( self, 1 );
    level.var_3369117++;
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0xab954ea6, Offset: 0x37a8
// Size: 0x44
function function_479939d1()
{
    self endon( #"death" );
    self waittill( #"shoot" );
    level flag::set( "flg_zipline_intro_rus_weapon_fired" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 2
// Checksum 0x9ece2544, Offset: 0x37f8
// Size: 0x134
function function_1677ef19( var_bcfd0b72, *var_9d4d3a76 )
{
    level endon( #"flg_zipline_intro_cleared" );
    
    if ( isalive( var_9d4d3a76 ) && isalive( level.var_d596a87f ) && var_9d4d3a76 != level.var_d596a87f )
    {
        level.ai_woods ai::shoot_at_target( "kill_within_time", level.var_d596a87f, undefined, 3, 1, 1 );
        return;
    }
    
    if ( isalive( var_9d4d3a76 ) && isalive( level.var_a06bbe2a ) && var_9d4d3a76 != level.var_a06bbe2a )
    {
        level.ai_woods ai::shoot_at_target( "kill_within_time", level.var_a06bbe2a, undefined, 3, 1, 1 );
    }
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x121c2fdf, Offset: 0x3938
// Size: 0x114
function function_83ce3ef6()
{
    level endon( #"flg_zipline_intro_cleared" );
    level flag::wait_till( "flg_zipline_intro_patrol_1_moving" );
    
    if ( !level flag::get( "flg_zipline_intro_cleared" ) && !level flag::get( "flg_zipline_intro_engaging" ) )
    {
        trigger::use( "tr_mountain_zipline_hide", "targetname", level.player, 0 );
        level.ai_woods setblackboardattribute( "_stance", "crouch" );
    }
    
    level flag::wait_till( "flg_zipline_intro_engaging" );
    level.ai_woods setblackboardattribute( "_stance", "stand" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 1
// Checksum 0xe87e4939, Offset: 0x3a58
// Size: 0x2d4
function function_a9bc2432( e_target )
{
    level endon( #"flg_zipline_intro_cleared" );
    self setgoal( e_target.origin, 1 );
    self val::set( "zipline_patrol", "ignoreall" );
    f_dist = distance2d( self.origin, e_target.origin );
    level.ai_woods function_9ae1c50();
    level.ai_woods ai::set_behavior_attribute( "demeanor", "combat" );
    
    while ( f_dist > 150 && isalive( e_target ) )
    {
        f_dist = distance2d( self.origin, e_target.origin );
        waitframe( 1 );
        
        if ( level flag::get( "stealth_spotted" ) && isalive( e_target ) )
        {
            break;
        }
    }
    
    if ( level flag::get( "stealth_spotted" ) && isalive( e_target ) )
    {
        level.ai_woods ai::shoot_at_target( "kill_within_time", e_target, undefined, 3, 1, 1 );
        self val::reset( "zipline_patrol", "ignoreall" );
        e_target val::reset( "zipline_patrol", "ignoreme" );
        return;
    }
    
    if ( !level flag::get( "stealth_spotted" ) && isalive( e_target ) )
    {
        level scene::stop( "scene_yam_2020_zip_cliffside_alt" );
        self val::reset( "zipline_patrol", "ignoreall" );
        e_target val::reset( "zipline_patrol", "ignoreme" );
    }
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x5d1fcf40, Offset: 0x3d38
// Size: 0x32c
function function_ddf55816()
{
    level flag::wait_till( "flg_zipline_intro_dialog" );
    level thread function_40618920();
    level thread function_a361634d();
    level.ai_woods ai::function_3a5e9945( 0 );
    
    if ( !level flag::get( "flg_zipline_intro_engaging" ) )
    {
        level flag::wait_till_timeout( 0.5, "flg_zipline_intro_playing_looking" );
        level thread namespace_7468806b::function_a4f7d6e();
        level thread function_8332a9bd();
    }
    
    level.ai_woods function_9ae1c50();
    level flag::set( "flg_zipline_intro_visible" );
    level namespace_5d7a2dac::music( "3.0_takedown" );
    level flag::wait_till_any_timeout( 15, array( "flg_zipline_intro_engaging", "flg_zipline_intro_cleared" ) );
    
    if ( isalive( level.var_d596a87f ) && isalive( level.var_a06bbe2a ) && !level flag::get( "stealth_spotted" ) && !level flag::get( "flg_zipline_intro_engaging" ) )
    {
        nd_intro_patrol_1 = getnode( "nd_intro_patrol_1", "targetname" );
        nd_intro_patrol_2 = getnode( "nd_intro_patrol_2", "targetname" );
        level.var_d596a87f thread function_7f1196b2( nd_intro_patrol_1, "flg_zipline_intro_patrol_1_moving" );
        level.var_a06bbe2a thread function_7f1196b2( nd_intro_patrol_2, "flg_zipline_intro_patrol_2_moving", 3, "get_up" );
    }
    
    level flag::wait_till( "flg_zipline_intro_cleared" );
    level.ai_woods ai::set_behavior_attribute( "demeanor", "combat" );
    level thread namespace_7468806b::function_478cabb9();
    wait 1.5;
    level thread namespace_7468806b::function_4d86101b();
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x9b7cab15, Offset: 0x4070
// Size: 0x8c
function function_8332a9bd()
{
    level.ai_woods ai::set_behavior_attribute( "demeanor", "cqb" );
    level flag::wait_till( "flg_zipline_intro_engaging" );
    level.ai_woods function_9ae1c50();
    level.ai_woods ai::set_behavior_attribute( "demeanor", "combat" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x4a751e7c, Offset: 0x4108
// Size: 0x21c
function function_a361634d()
{
    var_49292204 = [];
    
    if ( !isdefined( var_49292204 ) )
    {
        var_49292204 = [];
    }
    else if ( !isarray( var_49292204 ) )
    {
        var_49292204 = array( var_49292204 );
    }
    
    var_49292204[ var_49292204.size ] = "stealth_spotted";
    
    if ( !isdefined( var_49292204 ) )
    {
        var_49292204 = [];
    }
    else if ( !isarray( var_49292204 ) )
    {
        var_49292204 = array( var_49292204 );
    }
    
    var_49292204[ var_49292204.size ] = "flg_zipline_intro_engaging";
    var_c87b2793 = [];
    
    if ( !isdefined( var_c87b2793 ) )
    {
        var_c87b2793 = [];
    }
    else if ( !isarray( var_c87b2793 ) )
    {
        var_c87b2793 = array( var_c87b2793 );
    }
    
    var_c87b2793[ var_c87b2793.size ] = "flg_zipline_intro_player_entered_space_right";
    
    if ( !isdefined( var_c87b2793 ) )
    {
        var_c87b2793 = [];
    }
    else if ( !isarray( var_c87b2793 ) )
    {
        var_c87b2793 = array( var_c87b2793 );
    }
    
    var_c87b2793[ var_c87b2793.size ] = "flg_zipline_intro_player_entered_space_left";
    level flag::wait_till_any( var_c87b2793 );
    
    if ( !level flag::get_any( var_49292204 ) )
    {
        if ( level flag::get( "flg_zipline_intro_player_entered_space_right" ) )
        {
            level thread namespace_b73b9191::function_5c5b6ea7( "s_zipline_intro_path_left_start", "struct" );
            return;
        }
        
        level thread namespace_b73b9191::function_5c5b6ea7( "s_zipline_intro_path_right_start", "struct" );
    }
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x5b4258c8, Offset: 0x4330
// Size: 0x1ec
function function_40618920()
{
    level endon( #"flg_zipline_intro_visible" );
    var_49292204 = [];
    
    if ( !isdefined( var_49292204 ) )
    {
        var_49292204 = [];
    }
    else if ( !isarray( var_49292204 ) )
    {
        var_49292204 = array( var_49292204 );
    }
    
    var_49292204[ var_49292204.size ] = "stealth_spotted";
    
    if ( !isdefined( var_49292204 ) )
    {
        var_49292204 = [];
    }
    else if ( !isarray( var_49292204 ) )
    {
        var_49292204 = array( var_49292204 );
    }
    
    var_49292204[ var_49292204.size ] = "flg_zipline_intro_dialog";
    
    if ( !isdefined( var_49292204 ) )
    {
        var_49292204 = [];
    }
    else if ( !isarray( var_49292204 ) )
    {
        var_49292204 = array( var_49292204 );
    }
    
    var_49292204[ var_49292204.size ] = "flg_zipline_intro_engaging";
    var_d250eb9f = 0;
    s_zipline_intro_lookat_ref = struct::get( "s_zipline_intro_lookat_ref", "targetname" );
    
    while ( !level flag::get_any( var_49292204 ) )
    {
        if ( level.player util::is_looking_at( s_zipline_intro_lookat_ref.origin, 0.995 ) )
        {
            var_d250eb9f = 1;
        }
        else
        {
            var_d250eb9f = 0;
        }
        
        waitframe( 1 );
    }
    
    if ( var_d250eb9f == 1 )
    {
        level flag::set( "flg_zipline_intro_playing_looking" );
    }
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x44cd2c4a, Offset: 0x4528
// Size: 0x184
function function_30fc8357()
{
    self endon( #"death" );
    var_49292204 = [];
    
    if ( !isdefined( var_49292204 ) )
    {
        var_49292204 = [];
    }
    else if ( !isarray( var_49292204 ) )
    {
        var_49292204 = array( var_49292204 );
    }
    
    var_49292204[ var_49292204.size ] = "stealth_spotted";
    
    if ( !isdefined( var_49292204 ) )
    {
        var_49292204 = [];
    }
    else if ( !isarray( var_49292204 ) )
    {
        var_49292204 = array( var_49292204 );
    }
    
    var_49292204[ var_49292204.size ] = "flg_zipline_intro_engaging";
    self waittill( #"allow_stand_up" );
    level flag::set( "flg_zipline_intro_allow_stand_up" );
    
    if ( !level flag::get_any( var_49292204 ) )
    {
        level flag::wait_till_any( var_49292204 );
        
        if ( self.health > 0 && self namespace_77fd5d41::stealth_enemy_getbsmstate() == "Stealth_Idle" )
        {
            level thread scene::play( "scene_yam_2020_zip_cliffside_alt", "react" );
        }
    }
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 4
// Checksum 0x69e7106e, Offset: 0x46b8
// Size: 0xec
function function_7f1196b2( nd_target, var_563104ef, var_809b5df, var_3cf3958e )
{
    level endon( #"stealth_spotted", #"flg_zipline_intro_engaging" );
    self endon( #"death", #"damage" );
    
    if ( isdefined( var_809b5df ) )
    {
        wait var_809b5df;
    }
    
    if ( isdefined( var_3cf3958e ) )
    {
        level thread scene::play( "scene_yam_2020_zip_cliffside_alt", var_3cf3958e );
    }
    else
    {
        self animation::stop();
    }
    
    level flag::set( var_563104ef );
    self thread spawner::go_to_node( nd_target );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 0
// Checksum 0x6e88fca9, Offset: 0x47b0
// Size: 0x44
function function_ef876547()
{
    level flag::wait_till( "flg_zipline_intro_engaging" );
    level namespace_5d7a2dac::music( "4.0_zipline_intro" );
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 1
// Checksum 0xbc3fa343, Offset: 0x4800
// Size: 0x104
function function_b205e5be( *str_objective )
{
    level thread objectives::scripted( "obj_yamantau_1", undefined, #"hash_423da80c752f859f" );
    namespace_b73b9191::function_2683ec5d();
    level.ai_woods ai::function_3a5e9945( 1 );
    var_b4bb921 = struct::get( "woods_zipline_teleport", "targetname" );
    level.ai_woods forceteleport( var_b4bb921.origin, var_b4bb921.angles );
    level thread namespace_7468806b::function_79af70ae( 1 );
    level.allowbattlechatter[ #"allies" ] = 0;
    level.allowbattlechatter[ #"axis" ] = 0;
}

// Namespace namespace_cbf28e01/namespace_80d7b257
// Params 4
// Checksum 0xec292a4e, Offset: 0x4910
// Size: 0x44
function function_71f05605( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    waitframe( 1 );
    namespace_b73b9191::function_ee83e03a( "cull_inside_satcom" );
}

