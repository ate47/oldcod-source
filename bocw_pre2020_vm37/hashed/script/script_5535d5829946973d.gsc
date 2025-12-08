#using script_155b17ff7c8b315c;
#using script_1b9f100b85b7e21d;
#using script_2d443451ce681a;
#using script_3072532951b5b4ae;
#using script_446752c03c555e16;
#using script_55c94e3e2ed0bf40;
#using script_57d05cf093ffba5c;
#using script_6cd35fe7afb1f231;
#using script_97b74052c477c23;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snipercam;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;

#namespace namespace_e967dd33;

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1
// Checksum 0xab14b620, Offset: 0x1710
// Size: 0x44
function function_2c620a1d( *str_objective )
{
    level thread namespace_fc3e8cb::function_2e7c81f6( 1 );
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_forest", 1, 1 );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 2
// Checksum 0xc13c942c, Offset: 0x1760
// Size: 0x204
function function_d033814a( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    level globallogic_ui::function_7bc0e4b9();
    level thread function_c7bb3708();
    level thread function_4fdccb97();
    level.is_dark = 1;
    clientfield::set( "cull_mainstreet", 2 );
    clientfield::set( "cull_facility", 1 );
    clientfield::set( "cull_helipad", 1 );
    clientfield::set( "cull_courtyard", 2 );
    clientfield::set( "cull_allinterior", 2 );
    level thread function_e58ab150();
    level thread function_567e8e5a();
    vh_heli = level namespace_fc3e8cb::function_594838c( "vh_forest_vig_heli_forest_flyby", "flg_forest_approaching_tree", 1, 1, #"hash_d1ac7b99c32a7bd" );
    snd::client_targetname( vh_heli, "evt_audio_vig_forest_flyby" );
    level thread function_d2597977();
    level flag::wait_till( "flg_perimeter_start" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 4
// Checksum 0xe1af14c1, Offset: 0x1970
// Size: 0x10c
function function_34489c64( *str_objective, var_50cc0d4f, *var_aa1a6455, *player )
{
    level.var_9c4a751d = 0;
    clientfield::set( "cull_mainstreet", 2 );
    clientfield::set( "cull_facility", 1 );
    clientfield::set( "cull_helipad", 1 );
    clientfield::set( "cull_courtyard", 2 );
    clientfield::set( "cull_allinterior", 2 );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_perf_escape", 1 );
    
    if ( player )
    {
        level thread namespace_fc3e8cb::function_2e7c81f6( 1 );
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x9125f057, Offset: 0x1a88
// Size: 0x3d4
function function_4fdccb97()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level flag::set( "flg_forest_start" );
    level.player clientfield::set_to_player( "lerp_fov", 1 );
    level.player util::blend_movespeedscale( 0.85, 1 );
    level.player val::set( #"hash_2c68347f0c0f9438", "disable_weapons", 1 );
    level.player val::set( #"hash_2c68347f0c0f9438", "freezecontrols_allowlook", 1 );
    level.player val::set( #"hash_2c68347f0c0f9438", "allow_prone", 0 );
    level waittill( #"hash_62e5fbb59729b1b4" );
    level.player seteverhadweaponall( 0 );
    level.player util::delay( 0.25, undefined, &val::reset, #"hash_2c68347f0c0f9438", "disable_weapons" );
    level.player util::delay( 1.33, undefined, &util::function_749362d7, 1 );
    level scene::play( "scene_amk_1010_per_intro", "intro_hold_player" );
    level waittill( #"hash_e6162fcb323c4c7" );
    level.player val::reset( #"hash_2c68347f0c0f9438", "freezecontrols_allowlook" );
    level flag::wait_till( "flg_forest_past_tree" );
    level.player clientfield::set_to_player( "lerp_fov", 2 );
    level flag::wait_till( "woods_at_reveal" );
    wait 1.5;
    level.player val::set( #"hash_22754d9885e308f0", "disable_weapons", 1 );
    level.player waittill( #"hash_2faeb0c63497afa7" );
    level.player clientfield::set_to_player( "lerp_fov", 0 );
    level flag::wait_till( "flg_perimeter_start" );
    level.player val::set( #"hash_2c68347f0c0f9438", "allow_prone", 1 );
    level.player util::function_749362d7( 0 );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xb0bbfd04, Offset: 0x1e68
// Size: 0xe4
function function_c7bb3708()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level flag::wait_till( "flg_forest_woods_begin_moving" );
    level waittill( #"hash_e6162fcb323c4c7" );
    objectives::follow( "obj_forest_follow_woods", level.woods, #"hash_639e647ccafac037" );
    level flag::wait_till( "flg_perimeter_start" );
    objectives::complete( "obj_forest_follow_woods", level.woods );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x963127c7, Offset: 0x1f58
// Size: 0x3cc
function function_e58ab150()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level thread scene::play( "scene_amk_1010_per_intro", "init", [ level.woods ] );
    level thread function_b5b112b();
    level flag::set( "flg_forest_woods_begin_moving" );
    level scene::play( "scene_amk_1010_per_intro", "intro_start", [ level.woods ] );
    level flag::set( "flg_forest_woods_at_tree" );
    level thread function_e587b21b();
    level thread function_5d70adbf();
    level.woods.var_5b22d53 = 0;
    
    if ( level flag::get( "flg_forest_approaching_tree_fast" ) == 1 )
    {
        level scene::play( "scene_amk_1020_per_log", "log_enter_fast", [ level.woods ] );
    }
    else
    {
        level scene::play( "scene_amk_1020_per_log", "log_enter", [ level.woods ] );
        level thread scene::play( "scene_amk_1020_per_log", "log_idle", [ level.woods ] );
        var_5f6f4e0a = array( "log_nag01", "log_nag02" );
        level namespace_2977687d::function_95dc818f( "scene_amk_1020_per_log", "log_idle", var_5f6f4e0a, "flg_forest_approaching_tree" );
        level scene::play( "scene_amk_1020_per_log", "log_exit", [ level.woods ] );
    }
    
    level scene::play( "scene_amk_1025_per_forest", "woods_enter", [ level.woods ] );
    level thread scene::play( "scene_amk_1025_per_forest", "woods_loop", [ level.woods ] );
    level flag::wait_till( "flg_forest_past_tree" );
    level scene::play( "scene_amk_1025_per_forest", "woods_exit", [ level.woods ] );
    level.woods.var_5b22d53 = undefined;
    level namespace_2977687d::scene_amk_1030_per_reveal();
    wait 1;
    level.woods setgoal( level.woods.origin );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x95090de1, Offset: 0x2330
// Size: 0xe4
function function_b5b112b()
{
    s_scene_forest_intro = struct::get( "s_scene_forest_intro", "targetname" );
    
    while ( true )
    {
        if ( isdefined( s_scene_forest_intro.scene_ents ) )
        {
            var_9ac68214 = s_scene_forest_intro.scene_ents[ #"heli" ];
            break;
        }
        
        waitframe( 1 );
    }
    
    var_9ac68214 thread namespace_fc3e8cb::function_b510a5de( 1, #"hash_d1ac7b99c32a7bd" );
    level flag::wait_till( "flg_forest_woods_at_tree" );
    var_9ac68214 notify( #"hash_63fe58da4b00d989" );
    var_9ac68214 deletedelay();
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x87057305, Offset: 0x2420
// Size: 0x4c
function function_e587b21b()
{
    wait 2;
    e_forest_under_tree_clip = getent( "e_forest_under_tree_clip", "targetname" );
    e_forest_under_tree_clip delete();
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x3536a618, Offset: 0x2478
// Size: 0x134
function function_5d70adbf()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    wait 15;
    
    if ( level flag::get( "flg_forest_past_tree" ) == 0 && level.player getstance() == "stand" )
    {
        level.player thread util::show_hint_text( #"hash_4503efdcde1e4685", undefined, "hide_forest_crouch_hint", -1 );
        
        while ( level flag::get( "flg_forest_past_tree" ) == 0 )
        {
            if ( level.player getstance() == "crouch" )
            {
                break;
            }
            
            waitframe( 1 );
        }
        
        level.player notify( #"hide_forest_crouch_hint" );
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1
// Checksum 0xf6d65e61, Offset: 0x25b8
// Size: 0xdc
function function_d2597977( var_50cc0d4f = 0 )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    
    if ( var_50cc0d4f == 0 )
    {
        level flag::wait_till( "flg_forest_approaching_vista" );
    }
    
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_reveal_vista", 1 );
    level.player flag::wait_till( #"lockpicking" );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_reveal_vista", 0 );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x3f8a686c, Offset: 0x26a0
// Size: 0x74
function function_567e8e5a()
{
    level flag::wait_till( "flg_forest_past_tree" );
    var_1137b7d7 = spawner::simple_spawn( "ai_enemy_perimeter_tower", &function_eba4ec4f );
    level flag::set( "flg_perimeter_tower_enemies_spawned" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1
// Checksum 0x4e7e3cfc, Offset: 0x2720
// Size: 0x8c
function function_bdf1abf6( *str_objective )
{
    level thread function_d2597977( 1 );
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_perimeter", 1, 1 );
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player util::blend_movespeedscale( 0.85, 0.1 );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 2
// Checksum 0xba8c4e30, Offset: 0x27b8
// Size: 0x16c
function function_ccc536c3( str_objective, var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( str_objective );
    #/
    
    level thread function_14ea178a();
    level thread function_fb756f88();
    level.is_dark = 1;
    level thread function_ed4f7807( var_50cc0d4f );
    level thread function_ac248ed1();
    level thread function_21905e6d();
    level thread function_aa2788ec();
    level namespace_fc3e8cb::function_594838c( "vh_perimeter_vig_heli_vista_flyby" );
    level thread function_38e6d741();
    snd::client_msg( "flg_audio_perimeter_heli_spawned" );
    level thread function_59945288();
    level flag::wait_till( "flg_perimeter_end" );
    skipto::function_4e3ab877( str_objective );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 4
// Checksum 0x255df0f3, Offset: 0x2930
// Size: 0x3c
function function_1399c3c8( *str_objective, var_50cc0d4f, *var_aa1a6455, *player )
{
    level thread function_be7864ef( player );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x9f1a2055, Offset: 0x2978
// Size: 0xfc
function function_fb756f88()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level thread function_3039953f();
    level.player.var_546f1a27 = 0;
    level flag::wait_till( "flg_perimeter_approaching_fence" );
    level.player util::blend_movespeedscale_default( 1 );
    
    if ( level flag::get_all( [ "flg_perimeter_tower_enemies_dead", "flg_perimeter_truck_enemies_dead" ] ) == 1 )
    {
        savegame::checkpoint_save( 1 );
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xb5d08551, Offset: 0x2a80
// Size: 0x504
function function_14ea178a()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_perimeter_apc_shooting_player" );
    level flag::wait_till_any( [ "flg_perimeter_obj_take_photo_begin", "flg_perimeter_tower_enemies_alerted" ] );
    
    if ( level flag::get( "flg_perimeter_obj_take_photo_begin" ) == 1 )
    {
        level thread function_e4916f71();
        level thread function_9166c56d();
        level flag::wait_till_any( [ "flg_perimeter_obj_take_vista_photo_complete", "flg_perimeter_tower_enemies_alerted" ] );
    }
    
    level thread function_34f5b376();
    level.player notify( #"hide_camera_equip_hint" );
    objectives::complete( "obj_perimeter_take_photo" );
    
    if ( level flag::get( "flg_perimeter_obj_take_vista_photo_complete" ) == 1 )
    {
        level.player clientfield::set_to_player( "spy_camera_photo_focus_check", 0 );
        level flag::wait_till_timeout( 5, "flg_perimeter_player_end_camera_ads" );
    }
    
    var_1137b7d7 = getaiarray( "ai_enemy_perimeter_tower", "targetname" );
    objectives::kill( "obj_perimeter_kill_guards", var_1137b7d7, #"hash_410fe71956890b72" );
    level flag::wait_till( "flg_perimeter_tower_enemies_alerted" );
    level.player notify( #"hide_camera_unequip_hint" );
    level flag::wait_till_all( [ "flg_perimeter_tower_enemies_dead", "flg_perimeter_truck_enemies_dead" ] );
    objectives::complete( "obj_perimeter_kill_guards" );
    wait 1;
    
    if ( level flag::get( "flg_perimeter_slide_downhill" ) == 0 )
    {
        s_obj_perimeter_downhill = struct::get( "s_obj_perimeter_downhill", "targetname" );
        objectives::goto( "obj_perimeter_slide_downhill", s_obj_perimeter_downhill.origin, #"hash_4e1b7176c7dd10e2", 0, 0 );
        level flag::wait_till( "flg_perimeter_slide_downhill" );
        objectives::complete( "obj_perimeter_slide_downhill" );
    }
    
    s_obj_perimeter_guard_house = struct::get( "s_obj_perimeter_guard_house", "targetname" );
    objectives::goto( "obj_perimeter_guard_house", s_obj_perimeter_guard_house.origin, #"hash_6e8520935e16535f" );
    level thread function_9e464fb5();
    level flag::wait_till_any( [ "flg_perimeter_obj_take_guard_house_photo_complete", "flg_perimeter_end" ] );
    objectives::complete( "obj_perimeter_guard_house" );
    
    if ( level flag::get( "flg_perimeter_end" ) == 0 )
    {
        s_obj_perimeter_infil = struct::get( "s_obj_perimeter_infil", "targetname" );
        objectives::goto( "obj_perimeter_bypass_fence", s_obj_perimeter_infil.origin, #"hash_d2fd5b1a26e8fdd" );
        level flag::wait_till( "flg_perimeter_end" );
        objectives::complete( "obj_perimeter_bypass_fence" );
    }
    
    objectives::complete( "obj_perimeter_main" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x418ff345, Offset: 0x2f90
// Size: 0x154
function function_9166c56d()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_perimeter_obj_take_vista_photo_complete", #"flg_perimeter_tower_enemies_alerted" );
    wait 15;
    
    if ( isdefined( objectives::function_285e460( "obj_perimeter_take_photo" ) ) )
    {
        s_obj_perimeter_photo = struct::get( "s_obj_perimeter_photo", "targetname" );
        objectives::update_position( "obj_perimeter_take_photo", s_obj_perimeter_photo.origin );
        objectives::function_67f87f80( "obj_perimeter_take_photo", undefined, #"hash_10a1b044bd73dc29" );
        id = objectives::function_285e460( "obj_perimeter_take_photo" );
        thread objectives_ui::function_f3ac479c( id );
        level.player thread objectives_ui::show_objectives();
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1
// Checksum 0x7bdb1436, Offset: 0x30f0
// Size: 0x484
function function_ed4f7807( var_50cc0d4f )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    
    if ( var_50cc0d4f )
    {
        level scene::play( "scene_amk_1030_per_reveal", "to_idle_woods" );
        level scene::play( "scene_amk_1030_per_reveal", "woods_idle_nags4" );
        level thread namespace_2977687d::function_504c79a0();
    }
    
    level flag::set( "flg_perimeter_obj_take_photo_begin" );
    level.woods flag::set( "flg_pause_photo_react" );
    level thread namespace_2977687d::function_54afad46();
    level flag::wait_till_any( [ "flg_perimeter_obj_take_vista_photo_complete", "flg_perimeter_tower_enemies_alerted" ] );
    level.woods allowedstances( "stand" );
    vol_perimeter_ridge_shadow = getent( "vol_perimeter_ridge_shadow", "script_noteworthy" );
    vol_perimeter_ridge_shadow deletedelay();
    
    if ( level flag::get( "flg_perimeter_obj_take_vista_photo_complete" ) == 1 )
    {
        level thread namespace_4bd68414::function_b9e6f11a();
    }
    else
    {
        level thread namespace_4bd68414::function_9ee2fa9c();
    }
    
    level flag::wait_till_all( [ "flg_perimeter_tower_enemies_dead", "flg_perimeter_truck_enemies_dead" ] );
    wait 1;
    level.woods ai::set_behavior_attribute( "demeanor", "alert" );
    
    if ( level flag::get( "flg_perimeter_obj_take_vista_photo_complete" ) == 0 )
    {
        namespace_4bd68414::function_6ebfb88e();
    }
    else if ( level.player.var_546f1a27 < 2 || level flag::get( "flg_perimeter_tower_enemies_killed_slowly" ) == 1 )
    {
        namespace_4bd68414::function_876349be();
    }
    else if ( level.player.var_546f1a27 >= 3 )
    {
        namespace_4bd68414::function_ff8d98f1();
    }
    else
    {
        namespace_4bd68414::function_75011fc4();
    }
    
    level namespace_4bd68414::function_f287c5ff();
    level flag::wait_till( "flg_perimeter_slide_downhill" );
    level flag::set( "flg_woods_radio" );
    level flag::wait_till( "flg_perimeter_approaching_fence" );
    level thread namespace_4bd68414::function_37f6c1ad();
    level flag::wait_till( "flg_perimeter_inside_gatehouse" );
    level thread function_523e5f8a();
    level.woods allowedstances( "stand", "crouch", "prone" );
    level.woods ai::set_behavior_attribute( "demeanor", "cqb" );
    level.woods flag::clear( "flg_pause_photo_react" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x1c9f87fc, Offset: 0x3580
// Size: 0x234
function function_cb4b43d9()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    wait 4;
    var_ab8f8fa = getaiarray( "ai_enemy_perimeter_tower", "targetname" );
    function_1eaaceab( var_ab8f8fa );
    var_a9b8cca0 = undefined;
    
    if ( var_ab8f8fa.size == 0 )
    {
        var_5d13c51 = struct::get( "s_obj_perimeter_guard_house", "targetname" );
    }
    else
    {
        foreach ( ai_guard in var_ab8f8fa )
        {
            if ( ai_guard.script_noteworthy === "ai_enemy_perimeter_tower_bottom" )
            {
                var_a9b8cca0 = ai_guard;
                break;
            }
        }
        
        if ( !isdefined( var_a9b8cca0 ) )
        {
            var_a9b8cca0 = var_ab8f8fa[ 0 ];
        }
    }
    
    if ( isdefined( var_a9b8cca0 ) )
    {
        level.woods aimatentityik( var_a9b8cca0 );
        level flag::wait_till( "flg_perimeter_tower_enemies_alerted" );
        level.woods aimatentityik();
        return;
    }
    
    level.woods aimatposik( var_5d13c51.origin );
    level flag::wait_till( "flg_perimeter_tower_enemies_alerted" );
    level.woods aimatposik();
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x632210b1, Offset: 0x37c0
// Size: 0xbc
function function_523e5f8a()
{
    level endon( #"flg_perimeter_end" );
    level.player endon( #"death", #"hide_camera_equip_hint" );
    level.player thread util::show_hint_text( #"hash_549b99af44962dbf", undefined, "hide_camera_equip_hint", -1 );
    level.player flag::wait_till( #"lockpicking" );
    level.player notify( #"hide_camera_equip_hint" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xfadb1475, Offset: 0x3888
// Size: 0x154
function function_3039953f()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    var_1a06c56c = getentarray( "e_perimeter_downhill_slide_clip", "targetname" );
    array::delete_all( var_1a06c56c );
    level flag::wait_till_all( [ "flg_perimeter_tower_enemies_dead", "flg_perimeter_truck_enemies_dead" ] );
    wait 20;
    
    if ( level flag::get( "flg_perimeter_slide_downhill" ) == 1 )
    {
        return;
    }
    
    level.player thread util::show_hint_text( #"hash_37d00a47d04a2236", undefined, "hide_perimeter_mantle_hint", -1 );
    level flag::wait_till( "flg_perimeter_slide_downhill" );
    level.player notify( #"hide_perimeter_mantle_hint" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xa669a7ed, Offset: 0x39e8
// Size: 0x310
function function_ac248ed1()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    println( "<dev string:x38>" );
    
    if ( level flag::get( "flg_perimeter_tower_enemies_spawned" ) == 1 )
    {
        var_1137b7d7 = getaiarray( "ai_enemy_perimeter_tower", "targetname" );
    }
    else
    {
        var_1137b7d7 = spawner::simple_spawn( "ai_enemy_perimeter_tower", &function_eba4ec4f );
    }
    
    level thread namespace_fc3e8cb::function_85939627( var_1137b7d7, "flg_perimeter_tower_enemies_one_dead", 1 );
    level thread namespace_fc3e8cb::function_85939627( var_1137b7d7, "flg_perimeter_tower_enemies_dead" );
    level thread namespace_fc3e8cb::function_535e9168( var_1137b7d7, "flg_perimeter_tower_enemies_alerted", 1 );
    level thread function_34818618();
    level thread function_c2d70280();
    level thread namespace_fc3e8cb::function_384c3b4b( var_1137b7d7, "flg_perimeter_tower_enemies_dead", [ "flg_perimeter_tower_enemies_one_dead", "flg_perimeter_tower_enemies_alerted" ] );
    level thread namespace_fc3e8cb::function_55a81eeb( "flg_perimeter_tower_enemies_alerted", var_1137b7d7, 1, 0 );
    level flag::wait_till( "flg_perimeter_approaching_fence" );
    level flag::set( "flg_perimeter_apc_alerted" );
    function_1eaaceab( var_1137b7d7 );
    
    if ( var_1137b7d7.size > 0 )
    {
        level thread namespace_4bd68414::function_d1ebb0b9( var_1137b7d7 );
        
        foreach ( ai in var_1137b7d7 )
        {
            ai util::delay( randomfloatrange( 1, 3 ), undefined, &ai::set_pacifist, 0 );
        }
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x1749fbb5, Offset: 0x3d00
// Size: 0xb4
function function_34818618()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_perimeter_tower_enemies_alerted" );
    t_perimeter_damage = getent( "t_perimeter_damage", "targetname" );
    t_perimeter_damage waittill( #"trigger" );
    level flag::set( "flg_perimeter_tower_enemies_alerted" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xe73aac9d, Offset: 0x3dc0
// Size: 0xbc
function function_c2d70280()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_perimeter_tower_enemies_alerted" );
    level flag::wait_till_any( [ "flg_perimeter_slide_downhill", "flg_perimeter_tower_enemies_one_dead", "flg_perimeter_truck_enemies_one_dead" ] );
    level flag::set( "flg_perimeter_tower_enemies_alerted" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x9de1689f, Offset: 0x3e88
// Size: 0x504
function function_21905e6d()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    var_be80400a = vehicle::simple_spawn_and_drive( "vh_perimeter_vig_truck_driveby" );
    array::thread_all( var_be80400a, &namespace_fc3e8cb::function_6fdf0945 );
    array::thread_all( var_be80400a, &function_842bc8de );
    vh_perimeter_vig_truck_driveby_apc = vehicle::simple_spawn_single( "vh_perimeter_vig_truck_driveby_apc" );
    vh_perimeter_vig_truck_driveby_apc thread namespace_fc3e8cb::function_6fdf0945( 1 );
    vh_perimeter_vig_truck_driveby_apc thread function_842bc8de();
    vh_perimeter_vig_truck_gate_stop = vehicle::simple_spawn_single( "vh_perimeter_vig_truck_gate_stop" );
    vh_perimeter_vig_truck_gate_stop thread namespace_fc3e8cb::function_6fdf0945( 1 );
    vh_perimeter_vig_truck_gate_stop thread function_842bc8de();
    level thread function_aa82e98f();
    vh_perimeter_vig_truck_driveby_apc thread function_38e9d3a0();
    level flag::wait_till_any( [ "flg_perimeter_vig_driveby_start", "flg_perimeter_tower_enemies_alerted", "flg_perimeter_tower_enemies_one_dead" ] );
    vh_perimeter_vig_truck_driveby_apc thread vehicle::go_path();
    vh_perimeter_vig_truck_gate_stop thread vehicle::go_path();
    snd::function_9ae4fc6f( "tmp_veh_truck_drive_away", vh_perimeter_vig_truck_gate_stop );
    wait 1;
    var_ff7839a5 = getaiarray( "ai_enemy_perimeter_truck_gate", "targetname" );
    level thread namespace_fc3e8cb::function_85939627( var_ff7839a5, "flg_perimeter_truck_enemies_one_dead", 1 );
    level thread namespace_fc3e8cb::function_85939627( var_ff7839a5, "flg_perimeter_truck_enemies_dead" );
    function_1eaaceab( var_ff7839a5 );
    
    foreach ( ai_enemy in var_ff7839a5 )
    {
        ai_enemy thread function_dcf56792( vh_perimeter_vig_truck_gate_stop );
        ai_enemy thread function_eba4ec4f();
    }
    
    level flag::wait_till_any( [ "flg_perimeter_tower_enemies_alerted", "flg_perimeter_apc_alerted" ] );
    level flag::wait_till( "flg_perimeter_truck_approaching_gate" );
    vh_perimeter_vig_truck_gate_stop vehicle::pause_path();
    
    while ( vh_perimeter_vig_truck_gate_stop getspeed() > 1 )
    {
        waitframe( 1 );
    }
    
    wait 1;
    vh_perimeter_vig_truck_gate_stop vehicle::unload();
    
    if ( level flag::get( "flg_perimeter_apc_alerted" ) == 1 )
    {
        level thread namespace_4bd68414::function_9ee2fa9c();
    }
    else
    {
        level thread namespace_4bd68414::function_60f53b98();
    }
    
    level flag::wait_till( "flg_perimeter_tower_enemies_dead" );
    level thread function_2972fbf8();
    level flag::wait_till_timeout( 1, "flg_perimeter_truck_enemies_one_dead" );
    level thread namespace_fc3e8cb::function_384c3b4b( var_ff7839a5, "flg_perimeter_truck_enemies_dead" );
    level flag::wait_till( "flg_helipad_end" );
    vh_perimeter_vig_truck_gate_stop delete();
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xfd654299, Offset: 0x4398
// Size: 0x104
function function_842bc8de()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"death" );
    level endon( #"flg_perimeter_tower_enemies_alerted" );
    
    while ( true )
    {
        waitresult = self waittill( #"damage" );
        attacker = waitresult.attacker;
        
        if ( attacker == level.player )
        {
            break;
        }
        
        wait 0.5;
    }
    
    level flag::set( "flg_perimeter_apc_alerted" );
    level flag::set( "flg_perimeter_tower_enemies_alerted" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xae849928, Offset: 0x44a8
// Size: 0xd8
function function_eba4ec4f()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self thread namespace_fc3e8cb::function_e57eea9a();
    self.var_6eed8aea = 0;
    self ai::set_pacifist( 1 );
    waitresult = self waittill( #"death" );
    attacker = waitresult.attacker;
    
    if ( attacker === level.player )
    {
        level.player.var_546f1a27++;
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x1c90ea1d, Offset: 0x4588
// Size: 0x44
function function_2972fbf8()
{
    level endon( #"flg_perimeter_truck_enemies_dead" );
    wait 10;
    level flag::set( "flg_perimeter_tower_enemies_killed_slowly" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xee776dcc, Offset: 0x45d8
// Size: 0x1c6
function function_aa82e98f()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_perimeter_vig_driveby_start" );
    s_perimeter_vig_driveby_lookat = struct::get( "s_perimeter_vig_driveby_lookat", "targetname" );
    level flag::delay_set( 15, "flg_perimeter_vig_driveby_start" );
    
    while ( true )
    {
        var_e88b5bd1 = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), s_perimeter_vig_driveby_lookat.origin, 0.707107 );
        var_d94cabb4 = sighttracepassed( level.player getplayercamerapos(), s_perimeter_vig_driveby_lookat.origin, 0, undefined );
        
        if ( var_e88b5bd1 == 1 && var_d94cabb4 == 1 || level flag::get( "flg_perimeter_obj_take_vista_photo_complete" ) == 1 )
        {
            level flag::set( "flg_perimeter_vig_driveby_start" );
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x4e537c10, Offset: 0x47a8
// Size: 0x22c
function function_38e9d3a0()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"death" );
    level endon( #"flg_perimeter_apc_out_of_range" );
    self turret::_init_turret( 0 );
    self turret::enable( 0, 0, ( 0, 0, 5 ) );
    self turret::pause( 0, 0 );
    self turret::set_burst_parameters( 10, 10, 0.2, 0.2, 0 );
    self turret::function_41c79ce4( 1, 0 );
    self turret::set_ignore_line_of_sight( 1, 0 );
    self turret::function_8bbe7822( 1, 0 );
    self turret::set_on_target_angle( 1, 0 );
    self turret::function_3e5395( 0.5, 0 );
    self turret::function_f5e3e1de( 0, 0 );
    self turret::function_9c04d437( 0 );
    self turret::function_14223170( 0 );
    self.aim_only_no_shooting = 1;
    util::waittill_any_ents( self, "damage", level, "flg_perimeter_apc_alerted" );
    level flag::set( "flg_perimeter_apc_alerted" );
    self thread function_cc29bec9();
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x6328afd7, Offset: 0x49e0
// Size: 0x2c0
function function_cc29bec9()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"death" );
    level flag::wait_till( "flg_perimeter_apc_approaching_gate" );
    self vehicle::pause_path();
    var_7f025395 = "tag_fx_turret_spotlight";
    light_origin = self gettagorigin( var_7f025395 );
    light_angles = self gettagangles( var_7f025395 );
    self turret::function_49c3b892( level.player, 0 );
    self turret::set_target( level.player, ( 0, 0, 5 ), 0 );
    self turret::unpause( 0 );
    self turret::function_21827343( 0 );
    self turret::function_14223170( 0 );
    self.aim_only_no_shooting = undefined;
    level flag::set( "flg_perimeter_apc_shooting_player" );
    doors::function_f35467ac( "e_perimeter_guardhouse_door" );
    self hms_util::function_ca8302de();
    self.var_21c17c08 thread namespace_4bd68414::side_door_apc_shoot_player_dialogue();
    self util::delay( 5, undefined, &function_b49d9d8a, 0 );
    m_fx = util::spawn_model( "tag_origin", light_origin, light_angles );
    m_fx linkto( self, var_7f025395 );
    playfxontag( fx::get( #"hash_465b323348def919" ), m_fx, "tag_origin" );
    
    while ( true )
    {
        m_fx function_3b6fe102( 0.1 );
        wait 0.15;
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1
// Checksum 0x19ed4ccc, Offset: 0x4ca8
// Size: 0x174
function function_dcf56792( var_ff72be84 )
{
    self endon( #"death" );
    level.player endon( #"death" );
    self.grenadeammo = 0;
    self.health = 10;
    self ai::set_pacifist( 1 );
    var_ff72be84 waittill( #"unloaded" );
    self getenemyinfo( level.player );
    level flag::set( "flg_perimeter_apc_alerted" );
    self thread namespace_fc3e8cb::function_e193f7f( "flg_perimeter_vehicle_enemies_alerted", 1 );
    level flag::wait_till_any_timeout( randomfloatrange( 2, 3 ), [ "flg_perimeter_vehicle_enemies_alerted", "flg_perimeter_truck_enemies_one_dead" ] );
    self ai::set_pacifist( 0 );
    self ai::set_goal( "vol_perimeter_gate", "targetname", 1 );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1
// Checksum 0xbb0843f7, Offset: 0x4e28
// Size: 0xcc
function function_9c64f9d( var_ff7839a5 )
{
    self endon( #"death" );
    level.player endon( #"death" );
    
    if ( level flag::get( "flg_perimeter_slide_downhill" ) == 1 )
    {
        return;
    }
    
    ai::waittill_dead_or_dying( var_ff7839a5, var_ff7839a5.size - 1 );
    self snipercam::set_enabled( 1 );
    level flag::wait_till( "flg_perimeter_slide_downhill" );
    self snipercam::set_enabled( 0 );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x21961765, Offset: 0x4f00
// Size: 0x294
function function_e4916f71()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_perimeter_tower_enemies_alerted" );
    level.player clientfield::set_to_player( "spy_camera_photo_focus_check", 1 );
    objectives::scripted( "obj_perimeter_take_photo", undefined, #"hash_18da005ea2a820e7" );
    level spy_camera::function_f91a82ef( 1, #"hash_4f0d57b7fae34a99" );
    level namespace_fc3e8cb::function_4c2899e3();
    level.player thread util::show_hint_text( #"hash_549b99af44962dbf", undefined, "hide_camera_equip_hint", -1 );
    var_5d11ac37 = getentarray( "e_obj_perimeter_photo", "targetname" );
    
    foreach ( e_obj_perimeter_photo in var_5d11ac37 )
    {
        level.player spy_camera::function_f785d9e9( e_obj_perimeter_photo );
    }
    
    array::wait_any( var_5d11ac37, "photo_taken" );
    level flag::set( "flg_perimeter_obj_take_vista_photo_complete" );
    level spy_camera::function_f91a82ef( 1, undefined );
    level.player waittill( #"end_camera_ads" );
    level.player thread util::show_hint_text( #"hash_12be6ba1327c64b1", undefined, "hide_camera_unequip_hint", -1 );
    level flag::set( "flg_perimeter_player_end_camera_ads" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xab4152e, Offset: 0x51a0
// Size: 0x164
function function_34f5b376()
{
    level.player flag::clear( "flg_random_photo_taken" );
    var_5d11ac37 = getentarray( "e_obj_perimeter_photo", "targetname" );
    
    foreach ( e_obj_perimeter_photo in var_5d11ac37 )
    {
        level.player spy_camera::function_b28ab5a9( e_obj_perimeter_photo );
        waitframe( 1 );
    }
    
    array::delete_all( var_5d11ac37 );
    level.player waittill( #"end_camera_ads" );
    level.player thread util::show_hint_text( #"hash_12be6ba1327c64b1", undefined, "hide_camera_unequip_hint", -1 );
    level flag::set( "flg_perimeter_player_end_camera_ads" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x16b9b9de, Offset: 0x5310
// Size: 0xb4
function function_9e464fb5()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_perimeter_end" );
    e_perimeter_guard_house_map = getent( "e_perimeter_guard_house_map", "script_noteworthy" );
    e_perimeter_guard_house_map waittill( #"photo_taken" );
    level flag::set( "flg_perimeter_obj_take_guard_house_photo_complete" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1
// Checksum 0x44232b69, Offset: 0x53d0
// Size: 0xd4
function function_be7864ef( var_50cc0d4f )
{
    if ( var_50cc0d4f == 0 )
    {
        level.player flag::wait_till( #"lockpicking" );
        doors::waittill_door_opened( "e_perimeter_guardhouse_door", "targetname" );
        level flag::set( "flg_perimeter_end" );
        level flag::wait_till( "flg_helipad_at_open_ground" );
    }
    
    doors::close( "e_perimeter_guardhouse_door" );
    doors::function_f35467ac( "e_perimeter_guardhouse_door" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x6f4c21ea, Offset: 0x54b0
// Size: 0x9c
function function_aa2788ec()
{
    if ( level flag::get( "flg_perimeter_tower_vig_enemies_spawned" ) == 1 )
    {
        return;
    }
    
    var_247ca294 = spawner::simple_spawn( "ai_enemy_perimeter_tower_vig", &namespace_fc3e8cb::function_aa5f0d6b );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_lockpick_start", var_247ca294 );
    level flag::set( "flg_perimeter_tower_vig_enemies_spawned" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xaa4398d4, Offset: 0x5558
// Size: 0xdc
function function_38e6d741()
{
    e_forest_branch_reveal_clip = getent( "e_forest_branch_reveal_clip", "targetname" );
    e_perimeter_blocking_bush = getent( "e_perimeter_blocking_bush", "targetname" );
    e_perimeter_blocking_bush movez( 128, 0.2, 0.05, 0.05 );
    level flag::wait_till( "flg_perimeter_end" );
    e_perimeter_blocking_bush deletedelay();
    e_forest_branch_reveal_clip deletedelay();
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x20f2835d, Offset: 0x5640
// Size: 0x214
function function_59945288()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level.player flag::wait_till( #"lockpicking" );
    
    if ( level flag::get_all( [ "flg_perimeter_tower_enemies_dead", "flg_perimeter_truck_enemies_dead" ] ) == 0 )
    {
        v_fwd = anglestoforward( level.player getplayerangles() );
        var_1c8839e = level.player geteye() + v_fwd * -80;
        a_enemies = getaiteamarray( "axis" );
        a_enemies = arraysortclosest( a_enemies, level.player.origin );
        level.var_85b00b2b = #"hash_aa1a0042fd9fd71";
        level.var_30eb363 = #"hash_761c2b2b6618dd2c";
        waitframe( 1 );
        level.player util::stop_magic_bullet_shield();
        magicbullet( getweapon( #"sniper_powersemi_t9" ), var_1c8839e, level.player geteye(), a_enemies[ 0 ] );
        waitframe( 1 );
        level.player kill();
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1
// Checksum 0x4c6aefb7, Offset: 0x5860
// Size: 0x4c
function function_b53f913c( *str_objective )
{
    level flag::set( "flg_woods_radio" );
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_perimeter", 1, 1 );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 2
// Checksum 0xb9092c6d, Offset: 0x58b8
// Size: 0x17c
function function_4f9d9de3( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    level thread function_db273da1();
    level.is_dark = 1;
    level thread function_fc5749dd();
    level thread function_e25ef0de();
    level thread function_4ce0578d();
    level thread function_d50f1d6c();
    level thread function_aa2788ec();
    level thread function_4b3cbb7f();
    level namespace_fc3e8cb::function_594838c( "vh_helipad_vig_heli_woods_awol", "flg_helipad_woods_awol" );
    level thread function_35bcd44c();
    level flag::wait_till( "flg_helipad_end" );
    
    if ( !level flag::get( #"flg_vig_heli_shooting_player" ) )
    {
        skipto::function_4e3ab877( var_50cc0d4f );
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 4
// Checksum 0xab07bc65, Offset: 0x5a40
// Size: 0x4c
function function_f83ba620( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    if ( isdefined( level.var_9d0b8f71 ) )
    {
        level.var_9d0b8f71 namespace_fc3e8cb::function_621fafb2();
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x61bb4b90, Offset: 0x5a98
// Size: 0x1ac
function function_db273da1()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    
    while ( !isdefined( level.woods ) )
    {
        waitframe( 1 );
    }
    
    s_obj_helipad_entrance = struct::get( "s_obj_helipad_entrance", "targetname" );
    objectives::goto( "obj_helipad_cross_grounds", s_obj_helipad_entrance.origin, #"hash_43352958802b7c8c", 0, 0 );
    level flag::wait_till( "flg_helipad_at_open_ground" );
    s_obj_helipad_exit = struct::get( "s_obj_helipad_exit", "targetname" );
    objectives::update_position( "obj_helipad_cross_grounds", s_obj_helipad_exit.origin );
    id = objectives::function_285e460( "obj_helipad_cross_grounds" );
    thread objectives_ui::function_f3ac479c( id );
    level.player thread objectives_ui::show_objectives();
    level flag::wait_till( "flg_helipad_end" );
    objectives::complete( "obj_helipad_cross_grounds" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x26aca7e1, Offset: 0x5c50
// Size: 0x164
function function_fc5749dd()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level thread namespace_4bd68414::function_8b403488();
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_perimeter_woods_start" );
    level flag::wait_till_any( [ "flg_helipad_at_open_ground_center", "flg_helipad_at_open_ground_high", "flg_helipad_at_open_ground_left", "flg_helipad_at_open_ground_right" ] );
    level flag::set( "flg_helipad_at_open_ground" );
    level thread namespace_4bd68414::function_1c74ea6e();
    level flag::wait_till( "flg_helipad_woods_awol" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_forest_woods_awol" );
    level flag::wait_till( "flg_helipad_end" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x4f0b5b6a, Offset: 0x5dc0
// Size: 0x59c
function function_e25ef0de()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level flag::wait_till( "flg_helipad_approaching_open_ground" );
    level.player thread util::show_hint_text( #"hash_714029e70466cae6", undefined, "hide_helipad_hatchet_hint", 15 );
    level thread function_bee40e19();
    println( "<dev string:x59>" );
    var_78d6f873 = spawner::simple_spawn( "ai_enemy_helipad", &namespace_fc3e8cb::function_e57eea9a );
    var_595b3c05 = spawner::simple_spawn( "ai_enemy_helipad_trio_scene", &namespace_fc3e8cb::function_e57eea9a );
    var_175962cd[ #"hash_73d1f08772b74de5" ] = var_595b3c05[ 0 ];
    var_175962cd[ #"hash_73d1ed8772b748cc" ] = var_595b3c05[ 1 ];
    var_175962cd[ #"hash_73d1ee8772b74a7f" ] = var_595b3c05[ 2 ];
    s_scene = struct::get( "s_scene_helipad_talking_trio", "targetname" );
    s_scene thread scene::play( "scene_amk_0000_ambient_talking_trio_standing_armed_a", var_175962cd );
    var_78d6f873 = arraycombine( var_78d6f873, var_595b3c05 );
    level flag::wait_till_any( [ "flg_helipad_at_open_ground_center", "flg_helipad_at_open_ground_high", "flg_helipad_at_open_ground_left", "flg_helipad_at_open_ground_right" ] );
    
    if ( flag::get( "flg_helipad_at_open_ground_high" ) )
    {
        var_e4f59af8 = spawner::simple_spawn( "ai_enemy_helipad_high", &namespace_fc3e8cb::function_e57eea9a );
        var_78d6f873 = arraycombine( var_78d6f873, var_e4f59af8 );
    }
    else if ( flag::get( "flg_helipad_at_open_ground_left" ) )
    {
        var_563e1c3 = spawner::simple_spawn( "ai_enemy_helipad_left", &namespace_fc3e8cb::function_e57eea9a );
        var_78d6f873 = arraycombine( var_78d6f873, var_563e1c3 );
        level thread namespace_f6d09d1a::function_4699a51c();
    }
    else if ( flag::get( "flg_helipad_at_open_ground_right" ) )
    {
        var_9c4a9e55 = spawner::simple_spawn( "ai_enemy_helipad_right", &namespace_fc3e8cb::function_e57eea9a );
        var_78d6f873 = arraycombine( var_78d6f873, var_9c4a9e55 );
    }
    else
    {
        var_45f600df = spawner::simple_spawn( "ai_enemy_helipad_center", &namespace_fc3e8cb::function_e57eea9a );
        var_78d6f873 = arraycombine( var_78d6f873, var_45f600df );
    }
    
    level thread namespace_4bd68414::function_b7dac1e6( var_595b3c05 );
    level thread function_89c60d9( s_scene, var_595b3c05 );
    level.var_5163900 = spawnstruct();
    level thread namespace_fc3e8cb::function_85939627( var_78d6f873, "flg_helipad_enemies_one_dead", 1 );
    level thread namespace_fc3e8cb::function_85939627( var_78d6f873, "flg_helipad_enemies_half_dead", int( var_78d6f873.size * 0.5 ) );
    level thread namespace_fc3e8cb::function_85939627( var_78d6f873, "flg_helipad_enemies_all_dead" );
    level thread namespace_fc3e8cb::function_535e9168( var_78d6f873, "flg_helipad_enemies_alerted", 0, level.var_5163900 );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_side_door_scene_start", var_78d6f873 );
    level thread namespace_fc3e8cb::function_55a81eeb( "flg_helipad_enemies_alerted", var_78d6f873, 1, 1, level.var_5163900 );
    level thread function_377a91ea( var_78d6f873 );
    level thread function_b08f5e48( var_78d6f873 );
    level flag::wait_till( "flg_helipad_enemies_alerted" );
    level thread namespace_4bd68414::function_d1ebb0b9( var_78d6f873, level.var_5163900 );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1
// Checksum 0x5ec50c72, Offset: 0x6368
// Size: 0x25c
function function_377a91ea( var_78d6f873 )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level flag::wait_till( "flg_helipad_end" );
    
    if ( level flag::get( "flg_helipad_enemies_alerted" ) == 1 && level flag::get( "flg_helipad_enemies_half_dead" ) == 0 )
    {
        s_struct = struct::get( "s_obj_helipad_exit", "targetname" );
        var_e88b5bd1 = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), s_struct.origin, 0.5 );
        
        if ( var_e88b5bd1 )
        {
            v_fwd = anglestoforward( level.player getplayerangles() );
            var_1c8839e = level.player geteye() + v_fwd * -80;
            function_1eaaceab( var_78d6f873 );
            var_78d6f873 = arraysortclosest( var_78d6f873, level.player.origin );
            
            if ( isalive( var_78d6f873[ 0 ] ) )
            {
                magicbullet( getweapon( #"sniper_powersemi_t9" ), var_1c8839e, level.player geteye(), var_78d6f873[ 0 ] );
            }
        }
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xcf4659e9, Offset: 0x65d0
// Size: 0x12c
function function_bee40e19()
{
    level.player endon( #"death" );
    wait 1;
    level.player notifyonplayercommand( "player_ads", "+toggleads_throw" );
    level.player thread function_64cf5653();
    waitresult = level.player waittill( #"weapon_fired", #"player_ads", #"grenade_fire", #"offhand_fire", #"notify_turn_off_hint_text" );
    
    if ( waitresult._notify != "notify_turn_off_hint_text" )
    {
        level.player notify( #"hide_helipad_hatchet_hint" );
        return;
    }
    
    /#
        hms_util::print( "<dev string:x7e>" );
    #/
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x37045283, Offset: 0x6708
// Size: 0x74
function function_64cf5653()
{
    level.player endon( #"death", #"hide_helipad_hatchet_hint" );
    
    while ( level.player adsbuttonpressed() == 0 )
    {
        waitframe( 1 );
    }
    
    level.player notify( #"player_ads" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1
// Checksum 0x270df37f, Offset: 0x6788
// Size: 0x270
function function_b08f5e48( var_78d6f873 )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level flag::wait_till( "flg_helipad_enemies_alerted" );
    level flag::wait_till_any( [ "flg_helipad_enemies_half_dead", "flg_helipad_advance_2", "flg_helipad_advance_3" ] );
    function_1eaaceab( var_78d6f873 );
    s_helipad_gate_goal = struct::get( "s_helipad_gate_goal", "targetname" );
    v_angle = vectortoangles( level.player.origin - s_helipad_gate_goal.origin );
    
    foreach ( index, ai_enemy in var_78d6f873 )
    {
        if ( !isdefined( ai_enemy ) )
        {
            continue;
        }
        
        if ( isdefined( ai_enemy.script_noteworthy ) && ai_enemy.script_noteworthy == "ai_helipad_sniper" )
        {
            ai_enemy ai::set_goal( "vol_helipad_sniper_exit", "targetname" );
        }
        else if ( index < 2 )
        {
            ai_enemy.goalradius = 400;
            ai_enemy ai::set_goal_ent( level.player );
        }
        else
        {
            ai_enemy ai::set_goal( "vol_helipad_enemy_reinforcements", "targetname" );
        }
        
        wait randomfloatrange( 0.5, 1.5 );
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 2
// Checksum 0x9a1823c0, Offset: 0x6a00
// Size: 0x160
function function_89c60d9( s_scene, var_595b3c05 )
{
    foreach ( ai in var_595b3c05 )
    {
        ai.flashlightoverride = undefined;
    }
    
    while ( s_scene scene::is_active( "scene_amk_0000_ambient_talking_trio_standing_armed_a" ) )
    {
        waitframe( 1 );
    }
    
    level notify( #"hash_2915c0ce8ab308fd" );
    waitframe( 1 );
    
    foreach ( ai in var_595b3c05 )
    {
        if ( isalive( ai ) )
        {
            ai dialogue::function_47b06180();
        }
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xee844ca2, Offset: 0x6b68
// Size: 0x38c
function function_4ce0578d()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_helipad_at_open_ground_high", #"flg_helipad_at_open_ground_left", #"flg_helipad_at_open_ground_right" );
    level thread function_7266a202();
    level flag::wait_till( "flg_helipad_enemy_intro_vig" );
    println( "<dev string:x9b>" );
    ai_enemy_helipad = spawner::simple_spawn_single( "ai_enemy_helipad_intro_vig", &namespace_fc3e8cb::function_e57eea9a );
    level thread doors::open( "e_helipad_intro_vig_door" );
    ai_enemy_helipad thread function_d1863cca();
    ai_enemy_helipad waittilltimeout( 3, #"death" );
    
    if ( isdefined( ai_enemy_helipad ) )
    {
        var_5c66d0b2 = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), ai_enemy_helipad geteye(), cos( 40 ) );
        
        if ( var_5c66d0b2 == 1 )
        {
            ai_enemy_helipad function_a3fcf9e0( "sight", level.player, level.player getplayercamerapos() );
        }
    }
    
    wait 0.5;
    
    if ( isdefined( ai_enemy_helipad ) )
    {
        var_9fe2734 = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), ai_enemy_helipad geteye(), cos( 15 ) );
        
        if ( var_9fe2734 == 1 )
        {
            level.player waittilltimeout( 1, #"weapon_fired", #"grenade_fire" );
        }
    }
    
    if ( isdefined( ai_enemy_helipad ) && ai_enemy_helipad flag::get( "takedown_active" ) == 0 )
    {
        s_helipad_woods_mb_start = struct::get( "s_helipad_woods_mb_start", "targetname" );
        magicbullet( getweapon( #"sniper_quickscope_t9", "suppressed" ), s_helipad_woods_mb_start.origin, ai_enemy_helipad geteye() );
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xfa7ab3ef, Offset: 0x6f00
// Size: 0x154
function function_d1863cca()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_helipad_at_open_ground_high", #"flg_helipad_at_open_ground_left", #"flg_helipad_at_open_ground_right" );
    s_waitresult = self waittill( #"death", #"takedown_begin" );
    e_attacker = s_waitresult.attacker;
    str_notify = s_waitresult._notify;
    wait 1;
    
    if ( level flag::get( "flg_helipad_woods_awol" ) == 0 )
    {
        if ( e_attacker === level.player || str_notify === #"takedown_begin" )
        {
            level thread namespace_4bd68414::function_19e4681b();
            return;
        }
        
        level thread namespace_4bd68414::function_8a5d9832();
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x6f4aab9d, Offset: 0x7060
// Size: 0x1ae
function function_7266a202()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_helipad_at_open_ground_high", #"flg_helipad_at_open_ground_left", #"flg_helipad_at_open_ground_right", #"flg_helipad_enemy_intro_vig" );
    level flag::wait_till( "flg_helipad_approaching_open_ground" );
    
    while ( true )
    {
        if ( level.player getstance() != "crouch" || level.player issprinting() )
        {
            door = doors::function_73f09315( "e_helipad_intro_vig_door", "targetname" );
            var_e88b5bd1 = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), door.origin, 0.866025 );
            
            if ( var_e88b5bd1 == 1 )
            {
                level flag::set( "flg_helipad_enemy_intro_vig" );
            }
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x69504ab4, Offset: 0x7218
// Size: 0x204
function function_4b3cbb7f()
{
    level flag::wait_till_any( [ "flg_helipad_center_advance_1", "flg_helipad_left_advance_1", "flg_helipad_right_advance_1" ] );
    level flag::set( "flg_helipad_advance_1" );
    
    if ( level flag::get( "flg_helipad_enemies_alerted" ) == 0 )
    {
        str_targetname = "ai_enemy_helipad_add_left";
        
        if ( level flag::get( "flg_helipad_right_advance_1" ) == 1 )
        {
            str_targetname = "ai_enemy_helipad_add_right";
        }
        else if ( level flag::get( "flg_helipad_center_advance_1" ) == 1 && math::cointoss() )
        {
            str_targetname = "ai_enemy_helipad_add_right";
        }
        
        level thread function_556c9077( str_targetname );
    }
    
    level flag::wait_till_any( [ "flg_helipad_center_advance_2", "flg_helipad_left_advance_2", "flg_helipad_right_advance_2" ] );
    level flag::set( "flg_helipad_advance_2" );
    level flag::wait_till_any( [ "flg_helipad_center_advance_3", "flg_helipad_left_advance_2", "flg_helipad_right_advance_3" ] );
    level flag::set( "flg_helipad_advance_3" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1
// Checksum 0xcaa7c949, Offset: 0x7428
// Size: 0xcc
function function_556c9077( str_targetname )
{
    var_d5738156 = spawner::simple_spawn( str_targetname, &namespace_fc3e8cb::function_e57eea9a );
    level thread namespace_fc3e8cb::function_535e9168( var_d5738156, "flg_helipad_enemies_alerted", 0, level.var_5163900 );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_side_door_scene_start", var_d5738156 );
    level thread namespace_fc3e8cb::function_55a81eeb( "flg_helipad_enemies_alerted", var_d5738156, 1, 1, level.var_5163900 );
    level thread function_b08f5e48( var_d5738156 );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x6c7a7a20, Offset: 0x7500
// Size: 0x424
function function_d50f1d6c()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_helipad_end", #"flg_helipad_near_exit" );
    var_17dd140a = 0;
    level flag::wait_till( "flg_helipad_enemies_alerted" );
    println( "<dev string:xbc>" );
    
    if ( level flag::get( "flg_helipad_advance_1" ) == 1 )
    {
        str_targetname = "ai_enemy_helipad_reinforcements_short";
        var_17dd140a = 1;
    }
    else
    {
        str_targetname = "ai_enemy_helipad_reinforcements_long";
    }
    
    var_8d5ae0f1 = spawner::simple_spawn( str_targetname, &function_41378b2c, var_17dd140a );
    level thread namespace_fc3e8cb::function_85939627( var_8d5ae0f1, "flg_helipad_reinforcements_dead" );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_side_door_scene_start", var_8d5ae0f1 );
    n_wait_time = 5;
    
    switch ( level.gameskill )
    {
        case 0:
            n_wait_time = 20;
            break;
        case 1:
            n_wait_time = 15;
            break;
        case 2:
            n_wait_time = 10;
            break;
        case 3:
            n_wait_time = 5;
            break;
        default:
            n_wait_time = 15;
            break;
    }
    
    wait n_wait_time;
    
    if ( var_17dd140a == 0 )
    {
        var_17dd140a = 1;
        var_8d5ae0f1 = spawner::simple_spawn( "ai_enemy_helipad_reinforcements_short", &function_41378b2c, var_17dd140a );
        level thread namespace_fc3e8cb::function_85939627( var_8d5ae0f1, "flg_helipad_reinforcements_dead" );
        level thread namespace_fc3e8cb::function_18e5080e( "flg_side_door_scene_start", var_8d5ae0f1 );
    }
    
    if ( level flag::get( "flg_helipad_enemies_dead" ) == 0 && level flag::get( "flg_helipad_reinforcements_dead" ) == 0 )
    {
        level thread namespace_4bd68414::function_bad8f79d();
        level.var_9d0b8f71 = namespace_fc3e8cb::function_594838c( "vh_helipad_heli_reinforcements_flyover", undefined, 1, 0, undefined, 1 );
        objectives::convert( #"obj_helipad_cross_grounds", #"hash_6d05b1cec06f98c" );
        s_obj_helipad_exit = struct::get( "s_obj_helipad_exit", "targetname" );
        objectives::update_position( #"obj_helipad_cross_grounds", s_obj_helipad_exit.origin );
        id = objectives::function_285e460( #"obj_helipad_cross_grounds" );
        thread objectives_ui::function_f3ac479c( id );
        level.player thread objectives_ui::show_objectives();
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1
// Checksum 0xfc1b91fe, Offset: 0x7930
// Size: 0xfc
function function_41378b2c( var_7b70bc67 = 1 )
{
    self endon( #"death" );
    level.player endon( #"death" );
    self getenemyinfo( level.player );
    
    if ( var_7b70bc67 == 1 && !isdefined( self.script_noteworthy ) )
    {
        self.goalradius = 400;
        self ai::set_goal_ent( level.player );
    }
    
    if ( var_7b70bc67 == 0 && !isdefined( self.script_noteworthy ) )
    {
        self.goalradius = 600;
        self ai::set_goal_ent( level.player );
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xbaef840f, Offset: 0x7a38
// Size: 0xd4
function function_35bcd44c()
{
    s_scene_helipad_vig_heli_landing = struct::get( "s_scene_helipad_vig_heli_landing", "targetname" );
    s_scene_helipad_vig_heli_landing scene::init( "scene_amk_2010_hpd_helipad_landing_helicopter" );
    s_scene_helipad_vig_heli_landing thread scene::play( "scene_amk_2010_hpd_helipad_landing_helicopter", "loop" );
    level flag::wait_till( "flg_lockpick_start" );
    s_scene_helipad_vig_heli_landing scene::stop( "scene_amk_2010_hpd_helipad_landing_helicopter" );
    waitframe( 1 );
    s_scene_helipad_vig_heli_landing scene::delete_scene_spawned_ents( "scene_amk_2010_hpd_helipad_landing_helicopter" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1
// Checksum 0x4bb1fa72, Offset: 0x7b18
// Size: 0x4c
function function_908a5d78( *str_objective )
{
    level flag::set( "flg_woods_radio" );
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_perimeter", 1, 1 );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 2
// Checksum 0x6c9abd23, Offset: 0x7b70
// Size: 0x184
function function_d27fe3f3( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    savegame::checkpoint_save( 1 );
    level thread function_a9fbd51f();
    level.is_dark = 1;
    level thread function_1ad673c5();
    level thread function_987dac0();
    level namespace_fc3e8cb::function_594838c( "vh_side_door_vig_heli_near_flyby", "flg_side_door_start", 1, 0 );
    level namespace_96add23c::function_b9596ad1();
    level thread namespace_fc3e8cb::function_ffc69c66( "vh_side_door_vig_convoy", "flg_side_door_start" );
    level namespace_fc3e8cb::function_594838c( "vh_side_door_vig_heli_distant_flyby", "flg_side_door_start", 1, 0 );
    level thread function_aa2788ec();
    level.player flag::wait_till( #"lockpicking" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 4
// Checksum 0xbd9307c9, Offset: 0x7d00
// Size: 0x34
function function_56a40f23( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    level.var_9c4a751d = 1;
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0xaaf97710, Offset: 0x7d40
// Size: 0x11c
function function_a9fbd51f()
{
    s_obj_side_door_entrance = struct::get( "s_obj_side_door_entrance", "targetname" );
    objectives::goto( "obj_side_door_find_entrance", s_obj_side_door_entrance.origin, #"hash_783161cb2beea0a0" );
    level flag::wait_till( "flg_side_door_start" );
    s_obj_side_door_lockpick = struct::get( "s_obj_side_door_lockpick", "targetname" );
    objectives::update_position( "obj_side_door_find_entrance", s_obj_side_door_lockpick.origin );
    level thread namespace_96add23c::function_a0b22623();
    level flag::wait_till( "flg_side_door_scene_start" );
    objectives::complete( "obj_side_door_find_entrance" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x4ce57717, Offset: 0x7e68
// Size: 0x74
function function_1ad673c5()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level thread namespace_4bd68414::function_bd0df055();
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_perimeter_woods_start" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0
// Checksum 0x1feb3ff4, Offset: 0x7ee8
// Size: 0x30c
function function_987dac0()
{
    println( "<dev string:xe4>" );
    var_127d9a14 = vehicle::simple_spawn_single( "vh_side_door_vig_truck_driveby" );
    var_127d9a14 vehicle::lights_on();
    var_127d9a14 function_53880acc();
    var_127d9a14 turret::_init_turret( 0 );
    var_127d9a14 turret::enable( 0, 0, ( 0, 0, 5 ) );
    var_127d9a14 turret::pause( 0, 0 );
    var_127d9a14 turret::set_burst_parameters( 10, 10, 0.2, 0.2, 0 );
    var_127d9a14 turret::function_41c79ce4( 1, 0 );
    var_127d9a14 turret::set_ignore_line_of_sight( 1, 0 );
    var_127d9a14 turret::function_8bbe7822( 1, 0 );
    var_127d9a14 turret::set_on_target_angle( 1, 0 );
    var_127d9a14 turret::function_3e5395( 0.5, 0 );
    var_127d9a14 turret::function_f5e3e1de( 0, 0 );
    var_127d9a14 turret::function_9c04d437( 0 );
    var_127d9a14 turret::function_14223170( 0 );
    var_127d9a14.aim_only_no_shooting = 1;
    var_7f025395 = "tag_fx_turret_spotlight";
    light_origin = var_127d9a14 gettagorigin( var_7f025395 );
    light_angles = var_127d9a14 gettagangles( var_7f025395 );
    m_fx = util::spawn_model( "tag_origin", light_origin, light_angles );
    m_fx linkto( var_127d9a14, var_7f025395 );
    m_fx thread function_9dcef71a( var_127d9a14 );
    var_127d9a14 hms_util::function_ca8302de();
    level flag::wait_till( "flg_side_door_start" );
    var_127d9a14 thread vehicle::go_path();
    snd::client_targetname( var_127d9a14, "audio_side_door_apc_go" );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0, eflags: 0x4
// Checksum 0xafa87258, Offset: 0x8200
// Size: 0x44
function private function_53880acc()
{
    self clientfield::set( "apc_threat_sight_meter", 0 );
    self clientfield::set( "apc_threat_sight_state", 0 );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0, eflags: 0x4
// Checksum 0xd530dd59, Offset: 0x8250
// Size: 0x100
function private function_7ad04c33()
{
    self endon( #"death" );
    var_7e8680b8 = 0;
    var_a9a206a = 0.01 * 100 / ceil( 3.3333 * 30 );
    self clientfield::set( "apc_threat_sight_state", 1 );
    
    while ( isdefined( self ) && var_7e8680b8 <= 1 )
    {
        self clientfield::set( "apc_threat_sight_meter", int( var_7e8680b8 * ( ( 1 << 6 ) - 1 ) ) );
        var_7e8680b8 += var_a9a206a;
        waitframe( 1 );
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0, eflags: 0x4
// Checksum 0x2b3742a6, Offset: 0x8358
// Size: 0xfc
function private function_26cb8a58()
{
    self endon( #"death" );
    var_7e8680b8 = 1;
    var_a9a206a = 0.01 * 100 / ceil( 3.33 * 30 );
    
    while ( isdefined( self ) && var_7e8680b8 >= 0 )
    {
        self clientfield::set( "apc_threat_sight_meter", int( var_7e8680b8 * ( ( 1 << 6 ) - 1 ) ) );
        var_7e8680b8 -= var_a9a206a;
        waitframe( 1 );
    }
    
    if ( isdefined( self ) )
    {
        self clientfield::set( "apc_threat_sight_state", 0 );
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0, eflags: 0x4
// Checksum 0xa1f4c38c, Offset: 0x8460
// Size: 0x24
function private function_7a36cad7()
{
    self clientfield::set( "apc_threat_sight_state", 2 );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 0, eflags: 0x4
// Checksum 0xa5d919cf, Offset: 0x8490
// Size: 0x24
function private function_bcaf7c12()
{
    self clientfield::set( "apc_threat_sight_state", 3 );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1, eflags: 0x4
// Checksum 0x79a98f79, Offset: 0x84c0
// Size: 0x4dc
function private function_9dcef71a( var_127d9a14 )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    
    switch ( level.gameskill )
    {
        case 0:
            var_83ad7547 = 6;
            break;
        case 1:
            var_83ad7547 = 4;
            break;
        case 2:
            var_83ad7547 = 3;
            break;
        case 3:
            var_83ad7547 = 2;
            break;
        default:
            var_83ad7547 = 4;
            break;
    }
    
    var_af1ba7ee = 0;
    var_3a9d594c = var_127d9a14.health;
    var_6b87488d = gettime();
    var_f483287b = struct::get( "apc_light_path_start" );
    var_e068cb3e = undefined;
    var_d0405eb9 = 1;
    
    while ( isdefined( var_f483287b ) && isdefined( var_127d9a14 ) )
    {
        if ( var_f483287b !== var_e068cb3e )
        {
            var_9fe8257a = vectornormalize( var_f483287b.origin - self.origin );
            var_29d5113a = vectortoangles( var_9fe8257a );
            self rotateto( var_29d5113a, 1 );
            var_6b87488d = gettime();
            var_e068cb3e = var_f483287b;
            
            if ( var_d0405eb9 == 1 )
            {
                playfxontag( fx::get( #"hash_465b323348def919" ), self, "tag_origin" );
            }
        }
        
        v_player_pos = level.player getplayercamerapos();
        var_b7f6eb31 = vectornormalize( v_player_pos - self.origin );
        var_f38bb4f3 = vectordot( var_9fe8257a, var_b7f6eb31 );
        var_aa19e187 = distance2dsquared( v_player_pos, self.origin );
        
        if ( var_3a9d594c > var_127d9a14.health )
        {
            var_af1ba7ee += 2;
            
            if ( var_af1ba7ee >= var_83ad7547 )
            {
                self function_36d7f7d7( var_127d9a14 );
            }
            else
            {
                var_d0405eb9 = 1;
                level flag::set( "flg_side_door_apc_attacked" );
                var_127d9a14.var_21c17c08 thread namespace_4bd68414::side_door_apc_attacked_dialogue();
                var_127d9a14 function_7a36cad7();
                wait 0.75;
                var_6bb207b7 = gettime() - var_6b87488d;
                self function_a28f9816( var_127d9a14, var_af1ba7ee );
                var_3a9d594c = var_127d9a14.health;
                var_6b87488d = gettime() - var_6bb207b7;
            }
        }
        else if ( var_d0405eb9 == 1 && var_f38bb4f3 > 0.95 && var_aa19e187 < 2250000 && var_127d9a14 function_18b8dcc4( v_player_pos ) )
        {
            var_af1ba7ee++;
            
            if ( var_af1ba7ee >= var_83ad7547 )
            {
                self function_36d7f7d7( var_127d9a14 );
            }
            else
            {
                var_6bb207b7 = gettime() - var_6b87488d;
                self function_a28f9816( var_127d9a14, var_af1ba7ee );
                var_6b87488d = gettime() - var_6bb207b7;
            }
        }
        else if ( gettime() - var_6b87488d >= 4000 )
        {
            var_f483287b = struct::get( var_f483287b.target );
        }
        
        waitframe( 1 );
    }
    
    self delete();
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 2, eflags: 0x4
// Checksum 0x59d0dbdc, Offset: 0x89a8
// Size: 0x354
function private function_a28f9816( var_127d9a14, var_af1ba7ee )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    var_f6b3aab7 = 4000 - ( var_af1ba7ee - 1 ) * 1000;
    var_7bed3696 = var_f6b3aab7 * 0.001 * 0.16;
    var_b7f6eb31 = undefined;
    var_127d9a14 thread function_7ad04c33();
    var_5334d4d1 = gettime();
    var_127d9a14 vehicle::pause_path();
    snd::client_targetname( var_127d9a14, "audio_side_door_apc_stop" );
    var_127d9a14.var_21c17c08 thread namespace_4bd68414::side_door_apc_spotted_player_dialogue();
    var_127d9a14 turret::set_target( level.player, ( 0, 0, 5 ), 0 );
    var_127d9a14.aim_only_no_shooting = 1;
    playfxontag( fx::get( #"hash_465b323348def919" ), self, "tag_origin" );
    
    while ( gettime() - var_5334d4d1 <= var_f6b3aab7 )
    {
        var_b7f6eb31 = vectornormalize( level.player getplayercamerapos() - self.origin );
        var_29d5113a = vectortoangles( var_b7f6eb31 );
        self function_3b6fe102( var_7bed3696 );
        wait var_7bed3696;
    }
    
    v_player_pos = level.player getplayercamerapos();
    var_8ebb97d4 = vectornormalize( v_player_pos - self.origin );
    var_f38bb4f3 = vectordot( var_b7f6eb31, var_8ebb97d4 );
    
    if ( var_f38bb4f3 > 0.9 && var_127d9a14 function_18b8dcc4( v_player_pos ) )
    {
        self function_36d7f7d7( var_127d9a14 );
    }
    
    if ( isalive( level.player ) )
    {
        var_127d9a14.var_21c17c08 thread namespace_4bd68414::side_door_apc_resume_movement_dialogue();
        var_127d9a14 thread function_26cb8a58();
        var_127d9a14 vehicle::resume_path();
        snd::client_targetname( var_127d9a14, "audio_side_door_apc_go" );
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1, eflags: 0x4
// Checksum 0xf5023026, Offset: 0x8d08
// Size: 0x8c
function private function_3b6fe102( var_20995ecd )
{
    var_b7f6eb31 = vectornormalize( level.player getplayercamerapos() - self.origin );
    var_29d5113a = vectortoangles( var_b7f6eb31 );
    self rotateto( var_29d5113a, var_20995ecd );
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1, eflags: 0x4
// Checksum 0x9c0ba2a0, Offset: 0x8da0
// Size: 0x1e8
function private function_36d7f7d7( var_127d9a14 )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    var_127d9a14 turret::function_49c3b892( level.player, 0 );
    var_127d9a14 turret::set_target( level.player, ( 0, 0, 5 ), 0 );
    var_127d9a14 turret::unpause( 0 );
    var_127d9a14 turret::function_21827343( 0 );
    var_127d9a14 turret::function_14223170( 0 );
    var_127d9a14.aim_only_no_shooting = undefined;
    playfxontag( fx::get( #"hash_465b323348def919" ), self, "tag_origin" );
    level flag::set( "flg_side_door_apc_shooting_player" );
    var_127d9a14.var_21c17c08 thread namespace_4bd68414::side_door_apc_shoot_player_dialogue();
    var_127d9a14 function_bcaf7c12();
    doors::function_f35467ac( "e_lockpick_door" );
    var_127d9a14 util::delay( 3, undefined, &function_b49d9d8a );
    
    while ( true )
    {
        self function_3b6fe102( 0.1 );
        wait 0.15;
    }
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1, eflags: 0x4
// Checksum 0x7aec5f6c, Offset: 0x8f90
// Size: 0x25c
function private function_b49d9d8a( var_ed03deed = 1 )
{
    if ( !isalive( level.player ) )
    {
        return;
    }
    
    v_player_pos = level.player getplayercamerapos();
    var_c197f9aa = "tag_flash";
    
    if ( is_true( var_ed03deed ) )
    {
        var_e3dd3903 = getweapon( #"hash_161ca1bfb05ce95c" );
    }
    else
    {
        var_e3dd3903 = getweapon( #"hash_3d9006e5b2cd1362" );
    }
    
    var_ec67a181 = self gettagorigin( var_c197f9aa ) + ( 0, 0, 32 );
    level.var_85b00b2b = #"hash_695810e2d2481345";
    level.var_30eb363 = #"hash_70772ca86e781390";
    waitframe( 1 );
    b_trace = sighttracepassed( var_ec67a181, v_player_pos, 0, undefined );
    
    if ( b_trace == 1 )
    {
        playfxontag( level._effect[ #"hash_7fa91cf654f23aa0" ], self, var_c197f9aa );
        var_1c8839e = v_player_pos + ( 0, 0, 16 );
        magicbullet( var_e3dd3903, var_1c8839e, v_player_pos );
    }
    else
    {
        level thread namespace_4bd68414::function_d4e6ea3d();
        level lui::screen_fade_out( 0.5, "black" );
    }
    
    level.player util::stop_magic_bullet_shield();
    level.player disableinvulnerability();
    level.player kill();
}

// Namespace namespace_e967dd33/namespace_e3f9db54
// Params 1, eflags: 0x4
// Checksum 0xb792bc3d, Offset: 0x91f8
// Size: 0x8c
function private function_18b8dcc4( v_player_pos )
{
    if ( level.player namespace_fc3e8cb::function_bcdd0822( "vol_side_door_hidden" ) )
    {
        return 0;
    }
    
    var_f1e2d68b = self gettagorigin( "tag_flash" ) + ( 0, 0, 10 );
    return sighttracepassed( var_f1e2d68b, v_player_pos, 0, self );
}

