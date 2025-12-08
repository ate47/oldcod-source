#using script_155b17ff7c8b315c;
#using script_1b9f100b85b7e21d;
#using script_446752c03c555e16;
#using script_57d05cf093ffba5c;
#using script_6cd35fe7afb1f231;
#using script_97b74052c477c23;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp\cp_rus_amerika_fx;
#using scripts\cp_common\arcade_machine;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;

#namespace namespace_aad1a8fc;

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 1
// Checksum 0xa5547eba, Offset: 0x7b0
// Size: 0x2c
function function_c4dc0c81( *str_objective )
{
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_arcade", 1, 0 );
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 2
// Checksum 0xbd248a39, Offset: 0x7e8
// Size: 0x1f4
function function_f31f54a0( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    level thread function_d9a12f35();
    level thread function_28acc8ac();
    level thread function_c73e4889();
    level thread function_ae1399c9();
    clientfield::set( "cull_mainstreet", 1 );
    snd::client_msg( "flg_arcade_audio_emitters_start" );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_arcade_window_volumetric", 1 );
    level thread function_14dd1d24();
    level thread function_c924cc46();
    level namespace_fc3e8cb::function_a96c8ec0();
    level thread namespace_fc3e8cb::function_56dd5180();
    level thread namespace_fc3e8cb::function_869f213d();
    function_74f802ab();
    function_c51e3343();
    function_2bf3c36e();
    level function_7ad4f5cb();
    level thread function_9df06428();
    level.woods flag::wait_till( "flg_arcade_scenes_complete" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 4
// Checksum 0xb2409876, Offset: 0x9e8
// Size: 0xec
function function_bb767617( *str_objective, var_50cc0d4f, *var_aa1a6455, *player )
{
    clientfield::set( "cull_facility", 2 );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_arcade_window_volumetric", 0 );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_perf_tunnel", 1 );
    
    if ( player )
    {
        level thread namespace_fc3e8cb::function_2e7c81f6( 0 );
        level thread function_28acc8ac();
        level namespace_fc3e8cb::function_a96c8ec0();
        level thread namespace_fc3e8cb::function_56dd5180();
    }
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0xa128f4ca, Offset: 0xae0
// Size: 0x26c
function function_d9a12f35()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level spy_camera::function_f91a82ef( 0 );
    objectives::scripted( "obj_arcade_main", undefined, #"hash_6e65c7528d18da7f" );
    level breadcrumb::function_61037c6c( "s_obj_arcade_breadcrumb" );
    level flag::wait_till( "flg_arcade_at_vista" );
    objectives::complete( "obj_arcade_main" );
    level.player clientfield::set_to_player( "spy_camera_photo_focus_check", 1 );
    var_457dd409 = struct::get( "s_arcade_vig_heli_rappel", "targetname" );
    objectives::goto( "obj_arcade_photo", var_457dd409.origin, #"hash_5425ac050fa6e018" );
    objectives::function_67f87f80( "obj_arcade_photo", undefined, #"hash_10a1b044bd73dc29" );
    wait 1;
    
    if ( !flag::get( "flg_arcade_street_photo_taken" ) && level.player getcurrentweapon() != level.var_e3f5eafc )
    {
        level.player util::show_hint_text( #"hash_549b99af44962dbf", undefined, "hide_camera_equip_hint", 20 );
    }
    
    level flag::wait_till( "flg_arcade_street_photo_taken" );
    level.player clientfield::set_to_player( "spy_camera_photo_focus_check", 0 );
    objectives::complete( "obj_arcade_photo" );
    level spy_camera::function_f91a82ef( 1 );
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0xe5e94526, Offset: 0xd58
// Size: 0xec
function function_ae1399c9()
{
    level.woods ai::set_behavior_attribute( "vignette_mode", "fast" );
    level.woods ai::set_behavior_attribute( "disablepeek", 1 );
    level.woods ai::set_behavior_attribute( "disablelean", 1 );
    level.woods.battlechatterallowed = 0;
    level scene::init( "scene_amk_3025_arc_exit" );
    level thread namespace_2977687d::scene_amk_3010_arc_enter();
    level.player util::blend_movespeedscale( 0.85, 1 );
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0x338826a7, Offset: 0xe50
// Size: 0x1a4
function function_28acc8ac()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    var_229a8637 = 0;
    level flag::wait_till_any( [ "flg_arcade_gun_low_ready", "flg_arcade_end_gundown" ] );
    
    while ( !flag::get( "flg_arcade_end_gundown" ) )
    {
        if ( flag::get( "flg_arcade_gun_low_ready" ) && !var_229a8637 )
        {
            var_229a8637 = 1;
            level.player util::function_749362d7( 1 );
            level.player util::blend_movespeedscale( 0.85, 1 );
        }
        else if ( !flag::get( "flg_arcade_gun_low_ready" ) && var_229a8637 )
        {
            var_229a8637 = 0;
            level.player util::function_749362d7( 0 );
            level.player util::blend_movespeedscale_default( 1 );
        }
        
        wait 0.25;
    }
    
    level function_77b24e0e();
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0xcbbb7540, Offset: 0x1000
// Size: 0xb4
function function_9df06428()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    
    while ( !level flag::get( "flg_arcade_woods_move_to_exit" ) )
    {
        if ( level.player getcurrentweapon() == level.var_e3f5eafc )
        {
            level flag::set( "flg_arcade_camera_out" );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0, eflags: 0x4
// Checksum 0x98fc0cdc, Offset: 0x10c0
// Size: 0xcc
function private function_77b24e0e()
{
    level.player util::function_749362d7( 0 );
    level.player util::blend_movespeedscale_default( 1 );
    var_507573c7 = getent( "t_arcade_gun_low_ready_volume", "targetname" );
    var_507573c7 delete();
    level scene::init( "scene_amk_3025_arc_exit" );
    level thread scene::play( "p9_fxanim_cp_amk_4010_heli_rappel_rope_bundle", "post" );
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0xfcc1003d, Offset: 0x1198
// Size: 0x3cc
function function_c73e4889()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    var_a430c43a = getentarray( "e_obj_arcade_photo", "targetname" );
    assert( var_a430c43a.size == 13 );
    
    foreach ( e_obj in var_a430c43a )
    {
        level.player spy_camera::function_f785d9e9( e_obj );
    }
    
    var_4c148acb = getentarray( "arcade_window_vista_clip", "targetname" );
    assert( isarray( var_4c148acb ) );
    array::run_all( var_4c148acb, &hide );
    array::run_all( var_4c148acb, &notsolid );
    array::wait_any( var_a430c43a, "photo_taken" );
    level flag::set( "flg_arcade_street_photo_taken" );
    clientfield::set( "cull_facility", 2 );
    level.player flag::clear( "flg_random_photo_taken" );
    array::run_all( var_4c148acb, &show );
    array::run_all( var_4c148acb, &solid );
    
    foreach ( e_obj in var_a430c43a )
    {
        level.player spy_camera::function_b28ab5a9( e_obj );
        waitframe( 1 );
    }
    
    array::delete_all( var_a430c43a );
    
    while ( level.player adsbuttonpressed() || !util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), level.woods geteye(), cos( 45 ) ) )
    {
        wait 0.5;
    }
    
    level.woods flag::set( "flg_arcade_woods_move_to_exit" );
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0x398f09df, Offset: 0x1570
// Size: 0x1aa
function function_14dd1d24()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    s_arcade_vig_heli_rappel = struct::get( "s_arcade_vig_heli_rappel", "targetname" );
    level thread scene::init( "arcade_window_rappel_scene", "targetname" );
    level flag::wait_till( "flg_arcade_at_vista" );
    
    while ( true )
    {
        within_fov = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), s_arcade_vig_heli_rappel.origin, cos( 45 ) );
        var_19433220 = sighttracepassed( level.player getplayercamerapos(), s_arcade_vig_heli_rappel.origin, 0, undefined );
        
        if ( within_fov == 1 && var_19433220 == 1 )
        {
            level function_61dadea0();
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0x19b677ba, Offset: 0x1728
// Size: 0x188
function function_61dadea0()
{
    level thread scene::play( "arcade_window_rappel_scene", "targetname" );
    level thread namespace_fc3e8cb::function_fa5905d0( "s_arcade_heli_lights" );
    var_f1f393cc = getaiarray( "sp_streets_rappel_group", "targetname" );
    function_1eaaceab( var_f1f393cc );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_video_store_start", var_f1f393cc );
    var_31a7069 = getent( "vol_amerika_video_store_heli_vignette", "targetname" );
    
    foreach ( ai in var_f1f393cc )
    {
        ai namespace_fc3e8cb::function_aa5f0d6b();
        ai thread namespace_fc3e8cb::function_a7c9ed68( var_31a7069, 0 );
        ai thread function_48dea88a();
    }
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0x18050223, Offset: 0x18b8
// Size: 0xd4
function function_c924cc46()
{
    level flag::wait_till( "flg_arcade_at_entrance" );
    level thread function_c1bc15a1();
    level thread namespace_fc3e8cb::function_1c62d05e( "ai_enemy_arcade_drone", "flg_video_store_at_catwalk", 1 );
    sp_arcade_vista_actors = spawner::simple_spawn( "sp_arcade_vista_actors", &namespace_fc3e8cb::function_aa5f0d6b );
    level flag::wait_till( "flg_main_street_start" );
    array::run_all( sp_arcade_vista_actors, &deletedelay );
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0xe9978c39, Offset: 0x1998
// Size: 0xa4
function function_48dea88a()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"death" );
    self waittill( #"hash_542161c43bda2568" );
    wait 1;
    self waittill( #"goal" );
    
    if ( self.allowdeath !== 0 )
    {
        self deletedelay();
    }
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0x7589fcf0, Offset: 0x1a48
// Size: 0x194
function function_c1bc15a1()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    s_scene_arcade_window_01 = struct::get( "s_scene_arcade_window_01", "targetname" );
    s_scene_arcade_window_02 = struct::get( "s_scene_arcade_window_02", "targetname" );
    s_scene_arcade_window_01 scene::init( "scene_amk_0000_command_window_02" );
    s_scene_arcade_window_02 scene::init( "scene_amk_0000_command_window_02" );
    s_scene_arcade_window_01 thread scene::play( "scene_amk_0000_command_window_01" );
    s_scene_arcade_window_02 thread scene::play( "scene_amk_0000_command_window_02" );
    level flag::wait_till( "flg_video_store_at_catwalk" );
    s_scene_arcade_window_01 scene::stop( "scene_amk_0000_command_window_01" );
    s_scene_arcade_window_02 scene::stop( "scene_amk_0000_command_window_02" );
    waitframe( 1 );
    s_scene_arcade_window_01 scene::delete_scene_spawned_ents( "scene_amk_0000_command_window_01" );
    s_scene_arcade_window_02 scene::delete_scene_spawned_ents( "scene_amk_0000_command_window_02" );
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0x887cef93, Offset: 0x1be8
// Size: 0x54
function function_2bf3c36e()
{
    level.var_8abec566 = struct::spawn( ( 2059.26, 1405.85, -282.874 ) );
    level thread function_1e82d786();
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 1
// Checksum 0xf823b19c, Offset: 0x1c48
// Size: 0x22, Type: bool
function function_f68b665f( *var_ac921376 )
{
    return level.player.var_77638a73 == 0;
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 1
// Checksum 0x1f26bbba, Offset: 0x1c78
// Size: 0x22, Type: bool
function function_5600b611( *var_ac921376 )
{
    return level.player.var_77638a73 > 0;
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 1
// Checksum 0xfdb54504, Offset: 0x1ca8
// Size: 0x3c
function function_3d2bd879( *var_ac921376 )
{
    level.player util::show_hint_text( #"hash_6de73b2403ec301c", 0, 0, 5 );
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0xcac9c7a9, Offset: 0x1cf0
// Size: 0x212
function function_1e82d786()
{
    level endon( #"hash_248b99792c47a486" );
    
    while ( true )
    {
        level.var_b38d5b50 = dialog_tree::new_tree( undefined, undefined, 0, 0 );
        level.var_b38d5b50 dialog_tree::add_option( #"hash_434cce07caf724dd", undefined, undefined, undefined, 1, "forever", undefined, &function_76052005, 0 );
        level.var_b38d5b50 dialog_tree::add_option( #"hash_3980a2c43a1a1a07", undefined, undefined, undefined, 1, "forever", undefined, &function_76052005, 1 );
        level.var_b38d5b50 dialog_tree::add_option( #"hash_460d23ccb087c6e8", undefined, undefined, undefined, 1, "forever", undefined, &function_76052005, 2 );
        level.var_b38d5b50 dialog_tree::add_option( #"hash_3c20f7307892c308", undefined, undefined, undefined, 1, "forever", undefined, &function_76052005, 3 );
        level.var_8abec566 util::create_cursor_hint( undefined, undefined, #"hash_6c7bb285599937ba" );
        level.var_8abec566 waittill( #"trigger" );
        level.var_8abec566 util::remove_cursor_hint();
        level.var_b38d5b50 dialog_tree::run( undefined, undefined, undefined, undefined, 1 );
        level.var_b38d5b50 = undefined;
    }
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 1
// Checksum 0xf4c222eb, Offset: 0x1f10
// Size: 0x25c
function function_76052005( var_68f1c314 )
{
    level.var_8abec566 util::remove_cursor_hint();
    var_37dec5d7 = ( 2047, 1430, -242 );
    xfade = 0.1;
    tracks = [ "tmp_mus_3d_queen_dontstopmenow_bar_jukebox", "tmp_mus_3d_rush_tomsawyer_bar_jukebox", "tmp_mus_3d_ironmaiden_wrathchild_bar_jukebox", "tmp_mus_3d_breakingthelaw_bar_jukebox" ];
    wait 0.5;
    track = tracks[ var_68f1c314 ];
    
    if ( !isdefined( track ) )
    {
        /#
            hms_util::print( "<dev string:x38>" );
        #/
        
        return;
    }
    
    var_bc2b55eb = undefined;
    var_5b07db82 = undefined;
    
    switch ( var_68f1c314 )
    {
        case 0:
            var_bc2b55eb = "Don't Stop Me Now";
            var_5b07db82 = "sexy";
            break;
        case 1:
            var_bc2b55eb = "Tom Sawyer";
            var_5b07db82 = "cool";
            break;
        case 2:
            var_bc2b55eb = "Wrath Child";
            var_5b07db82 = "suck";
            break;
        case 3:
            var_bc2b55eb = "Breaking the Law";
            var_5b07db82 = "badass";
            break;
        default:
            assertmsg( "<dev string:x4a>" );
            break;
    }
    
    iprintlnbold( "Plays " + var_bc2b55eb + " if we get the rights." );
    level thread namespace_4bd68414::function_e3e98e84( var_5b07db82 );
    
    if ( !isdefined( level.var_535c9e4b ) )
    {
        /#
            hms_util::print( "<dev string:x61>" );
        #/
    }
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0x5e62c84d, Offset: 0x2178
// Size: 0xdc
function function_74f802ab()
{
    level.var_a4ca883c = spawn( "script_model", ( 2155, 1579, -320 ) );
    level.var_a4ca883c setmodel( "dun_belongings_coin_01_quarter" );
    level.var_a4ca883c namespace_f942705d::play_coin_fx();
    level.player.var_77638a73 = 0;
    level.var_a4ca883c util::create_cursor_hint( undefined, ( 0, 0, 7 ), #"hash_36ff92c5535c0209", undefined, undefined, &function_52fbdf85, undefined, undefined, undefined, undefined, undefined, undefined, &function_f76a47f0 );
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 1
// Checksum 0x60fe3890, Offset: 0x2260
// Size: 0x108
function function_f76a47f0( *var_ac921376 )
{
    if ( distance2dsquared( level.var_a4ca883c.origin, level.player.origin ) < sqr( 50 ) && vectordot( vectornormalize( anglestoforward( level.player getplayerangles() ) ), vectornormalize( level.var_a4ca883c.origin - level.player geteye() ) ) > 0.88 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 1
// Checksum 0x90f7af7c, Offset: 0x2370
// Size: 0x70
function function_52fbdf85( *var_ac921376 )
{
    level.var_a4ca883c util::remove_cursor_hint();
    level.var_a4ca883c namespace_f942705d::kill_coin_fx();
    waitframe( 1 );
    level.var_a4ca883c hide();
    level.player.var_77638a73++;
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0xa7607a3b, Offset: 0x23e8
// Size: 0xd4
function function_c51e3343()
{
    level.var_df219d10 = spawnstruct();
    level.var_84c6f65 = spawnstruct();
    level.var_df219d10.origin = ( 2002.5, 1402.5, -291 );
    level.var_84c6f65.origin = ( 1560, 1388, -279 );
    level.var_df219d10.angles = ( 0, 0, 0 );
    level.var_84c6f65.angles = ( 0, 0, 0 );
    level.var_df219d10 thread function_87448984();
    level.var_84c6f65 thread function_87448984();
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0x7546aad5, Offset: 0x24c8
// Size: 0xd8
function function_87448984()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"hash_248b99792c47a486" );
    
    while ( true )
    {
        self util::create_cursor_hint( undefined, ( 0, 0, 3 ), #"hash_36ff92c5535c0209", undefined, undefined, &function_4ae5059d, undefined, undefined, undefined, undefined, undefined, undefined, &function_e9a33d75 );
        self waittill( #"trigger" );
        wait 0.5;
    }
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 1
// Checksum 0x788dae09, Offset: 0x25a8
// Size: 0xf0
function function_e9a33d75( *var_ac921376 )
{
    if ( distance2dsquared( self.origin, level.player.origin ) < sqr( 37 ) && vectordot( vectornormalize( anglestoforward( level.player getplayerangles() ) ), vectornormalize( self.origin - level.player geteye() ) ) > 0.95 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 1
// Checksum 0xa263836e, Offset: 0x26a0
// Size: 0x20
function function_4ae5059d( *var_ac921376 )
{
    level.player.var_77638a73++;
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0
// Checksum 0x8a3e9fdb, Offset: 0x26c8
// Size: 0x114
function function_2a03dea7()
{
    if ( isdefined( level.var_535c9e4b ) )
    {
        snd::function_4286bd2c( level.var_535c9e4b );
        level.var_535c9e4b delete();
    }
    
    if ( isdefined( level.player.var_77638a73 ) )
    {
        level notify( #"hash_248b99792c47a486" );
        level.player.var_77638a73 = undefined;
        level.var_8abec566 util::remove_cursor_hint();
        level.var_8abec566 = undefined;
        level.var_df219d10 util::remove_cursor_hint();
        level.var_df219d10 = undefined;
        level.var_84c6f65 util::remove_cursor_hint();
        level.var_84c6f65 = undefined;
        level.var_a4ca883c delete();
    }
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0, eflags: 0x4
// Checksum 0xf0b36519, Offset: 0x27e8
// Size: 0xdc
function private function_7ad4f5cb()
{
    a_s_interacts = struct::get_array( #"hash_3dd86258529972ca" );
    array::thread_all( a_s_interacts, &function_f78628e6 );
    level.player notifyonplayercommand( #"hash_55b6e1fbec32b71", "+stance" );
    level.player notifyonplayercommand( #"hash_55b6e1fbec32b71", "+movedown" );
    level.player notifyonplayercommand( #"hash_55b6e1fbec32b71", "+lowerstance" );
}

// Namespace namespace_aad1a8fc/namespace_45f08619
// Params 0, eflags: 0x4
// Checksum 0x476768db, Offset: 0x28d0
// Size: 0x2dc
function private function_f78628e6()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    e_interact = util::spawn_model( #"tag_origin", self.origin, self.angles );
    var_cffbeaae = struct::get( #"hash_23c049910e1e4a97" );
    assert( isdefined( self.target ) );
    var_f35de83 = struct::get( self.target );
    
    while ( !flag::get( "flg_arcade_end_gundown" ) )
    {
        e_interact util::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), #"hash_77965c9740b1082d", 40, undefined, undefined, undefined, 150 );
        util::waittill_any_ents_two( level, #"flg_arcade_end_gundown", e_interact, "trigger" );
        e_interact util::delay( 0.2, undefined, &util::remove_cursor_hint );
        
        if ( level flag::get( "flg_arcade_end_gundown" ) )
        {
            break;
        }
        
        wait 0.5;
        self arcade_machine::function_2a291669( var_cffbeaae, var_f35de83 );
        level.player flag::set( "playing_arcade_game" );
        level thread namespace_4bd68414::arcade_woods_play_game_start_dialogue();
        self arcade_machine::function_85de737f( var_f35de83 );
        level.player waittill( #"hash_55b6e1fbec32b71" );
        level.player flag::clear( "playing_arcade_game" );
        self arcade_machine::function_b6d06a2d( var_f35de83 );
        self arcade_machine::function_67a244d3( var_cffbeaae );
        level thread namespace_4bd68414::arcade_woods_play_game_end_dialogue();
    }
    
    e_interact util::remove_cursor_hint();
    e_interact delete();
}

