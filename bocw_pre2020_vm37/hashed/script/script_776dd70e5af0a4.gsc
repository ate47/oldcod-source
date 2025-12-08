#using script_155b17ff7c8b315c;
#using script_446752c03c555e16;
#using script_4489198b8bcf36e8;
#using script_57d05cf093ffba5c;
#using script_719116534f2a623f;
#using script_97b74052c477c23;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snipercam;
#using scripts\cp_common\spawn_manager;
#using scripts\cp_common\util;

#namespace namespace_b767a37e;

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0xd54ad529, Offset: 0x1770
// Size: 0x44
function function_1bfb5e75( *str_objective )
{
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_video_store", 0, 0 );
    level thread namespace_fc3e8cb::function_869f213d();
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 2
// Checksum 0xed7d6bc9, Offset: 0x17c0
// Size: 0xec
function function_6fc923cc( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    level thread function_50c0c9bc();
    level thread function_ab2e5181();
    level thread function_58d0b9b2();
    level thread namespace_f6d09d1a::function_a677563d();
    level thread namespace_fc3e8cb::function_6fe40e14( "video_store_gun_rack1", "video_store_gun_rack2", "video_store_gun_rack3" );
    flag::wait_till( "flg_main_street_start" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 4
// Checksum 0xd308f40e, Offset: 0x18b8
// Size: 0x6c
function function_b85d7b0c( *str_objective, var_50cc0d4f, *var_aa1a6455, *player )
{
    if ( player == 1 )
    {
        level thread namespace_f6d09d1a::function_a677563d();
        level flag::set( "flg_arcade_end_gundown" );
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xc0955673, Offset: 0x1930
// Size: 0x7c
function function_50c0c9bc()
{
    objectives::scripted( "obj_video_store_main", undefined, #"hash_5e0c26968547ac5d" );
    level breadcrumb::function_61037c6c( "s_obj_video_store_breadcrumb" );
    flag::wait_till( "flg_main_street_start" );
    objectives::complete( "obj_video_store_main" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x7731e268, Offset: 0x19b8
// Size: 0x26c
function function_ab2e5181()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level.woods ai::set_behavior_attribute( "vignette_mode", "fast" );
    level.woods ai::set_behavior_attribute( "disablepeek", 1 );
    level.woods ai::set_behavior_attribute( "disablelean", 1 );
    level.woods.battlechatterallowed = 0;
    level thread namespace_4bd68414::function_7bd5886a();
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_video_store_woods_start" );
    level.woods namespace_fc3e8cb::function_4171ba27();
    level.woods colors::set_force_color( "blue" );
    level.woods ai::set_behavior_attribute( "vignette_mode", "off" );
    level.woods ai::set_behavior_attribute( "disablepeek", 0 );
    level.woods ai::set_behavior_attribute( "disablelean", 0 );
    level flag::wait_till( "flg_video_store_alert" );
    level.woods clearforcedgoal();
    level.woods namespace_fc3e8cb::function_d74bffa7();
    level flag::wait_till( "flg_main_street_start" );
    var_bb96f34c = getent( "t_b71", "targetname" );
    var_bb96f34c triggerenable( 0 );
    level hms_util::function_53531f27( "t_b85" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xc9fe0ad2, Offset: 0x1c30
// Size: 0x2a8
function function_58d0b9b2()
{
    level flag::wait_till( "flg_video_store_start" );
    level thread function_dd54be7d();
    level flag::wait_till( "flg_video_store_player_los" );
    level thread function_55b55bb4( "sm_video_store_smoke_1" );
    var_2ec7538d = spawner::simple_spawn( "sp_enemy_video_store_wave1_upper", &function_fffcee20 );
    wait 2;
    level.allowbattlechatter[ #"axis" ] = 0;
    level.var_d6840b = spawner::simple_spawn( "sp_enemy_video_store_wave1", &function_fffcee20 );
    level thread namespace_fc3e8cb::function_85939627( level.var_d6840b, "flg_main_street_start", 2 );
    level thread function_6add98b3();
    level thread function_25f2d4c0();
    level thread namespace_4bd68414::function_59872c12();
    level flag::wait_till( "flg_video_store_start_2" );
    level.allowbattlechatter[ #"axis" ] = 1;
    var_eec4445f = spawner::simple_spawn( "sp_enemy_video_store_wave2" );
    level flag::wait_till( "flg_main_street_start" );
    vol_amerika_outside_video_store = getent( "vol_amerika_outside_video_store", "targetname" );
    
    foreach ( ai in level.var_d6840b )
    {
        if ( isalive( ai ) )
        {
            ai setgoal( vol_amerika_outside_video_store );
        }
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xcfb1c298, Offset: 0x1ee0
// Size: 0x49e
function function_fffcee20()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"death" );
    self thread function_cc1f8e0c();
    
    if ( self.var_f97a8ac4 === "video_store_ground_floor_group" )
    {
        self thread function_aeb3a54d();
    }
    else if ( self.script_noteworthy === "video_store_stealth_guy" )
    {
        self thread function_28ebbd20();
    }
    
    if ( self.script_noteworthy === "video_store_tactical_path_1" )
    {
        var_63d2d7ec = level flag::wait_till_any( [ "flg_video_store_path_1_done", "flg_video_store_alert" ] );
        
        if ( var_63d2d7ec._notify === #"flg_video_store_alert" )
        {
            wait randomfloatrange( 0.5, 2 );
        }
        
        self ai::set_behavior_attribute( "demeanor", "patrol" );
        self ai::function_3a5e9945( 0 );
    }
    else if ( self.script_noteworthy === "video_store_tactical_path_2" )
    {
        var_63d2d7ec = level flag::wait_till_any( [ "flg_video_store_path_2_done", "flg_video_store_alert" ] );
        
        if ( var_63d2d7ec._notify === #"flg_video_store_alert" )
        {
            wait randomfloatrange( 0.5, 2 );
        }
        
        self ai::set_behavior_attribute( "demeanor", "patrol" );
        self ai::function_3a5e9945( 0 );
    }
    else if ( self.script_noteworthy === "video_store_tactical_path_3" )
    {
        var_63d2d7ec = level flag::wait_till_any( [ "flg_video_store_path_3_done", "flg_video_store_alert" ] );
        
        if ( var_63d2d7ec._notify === #"flg_video_store_alert" )
        {
            wait randomfloatrange( 0.5, 2 );
        }
        
        self ai::set_behavior_attribute( "demeanor", "patrol" );
        self ai::function_3a5e9945( 0 );
    }
    
    level flag::wait_till_any( [ "flg_video_store_drills_done", "flg_video_store_alert" ] );
    
    if ( self.var_f97a8ac4 === "video_store_ground_floor_group" )
    {
        self ai::set_goal( "vol_amerika_video_store", "targetname" );
    }
    
    level flag::wait_till( "flg_video_store_alert" );
    self notify( #"stop_going_to_node" );
    self ai::stop_shoot_at_target();
    self function_9ae1c50();
    self ai::set_behavior_attribute( "demeanor", "combat" );
    self val::reset( #"video_store", "ignoreall" );
    
    if ( self.script_noteworthy === "video_store_stealth_guy" )
    {
        self namespace_979752dc::enable_stealth_for_ai( 0 );
        self ai::set_goal( "vol_amerika_video_store_upper", "targetname" );
    }
    
    self.favoriteenemy = level.player;
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x1a0ab63e, Offset: 0x2388
// Size: 0x214
function function_aeb3a54d()
{
    self endon( #"death" );
    level endon( #"flg_video_store_alert" );
    self ai::set_behavior_attribute( "demeanor", "combat" );
    self ai::set_pacifist( 1 );
    self ai::function_3a5e9945( 1 );
    s_goal = struct::get( self.script_noteworthy, "targetname" );
    
    if ( isdefined( s_goal ) )
    {
        self spawner::go_to_struct( s_goal, &function_4de00f83 );
    }
    
    if ( self.script_noteworthy === "video_store_tactical_path_1" )
    {
        self setdesiredspeed( 140 );
        self waittill( #"goal" );
        level flag::set( "flg_video_store_drills_done" );
        level flag::set( "flg_video_store_path_1_done" );
    }
    
    if ( self.script_noteworthy === "video_store_tactical_path_2" )
    {
        self setdesiredspeed( 100 );
        self waittill( #"goal" );
        level flag::set( "flg_video_store_path_2_done" );
    }
    
    if ( self.script_noteworthy === "video_store_tactical_path_3" )
    {
        self setdesiredspeed( 120 );
        self waittill( #"goal" );
        level flag::set( "flg_video_store_path_3_done" );
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0xc1c26569, Offset: 0x25a8
// Size: 0xf4
function function_4de00f83( *s_info )
{
    if ( isdefined( self.go_to_node.script_noteworthy ) )
    {
        self ai::function_3a5e9945( 0 );
        var_275357a3 = randomfloatrange( 1.25, 2.75 );
        self.go_to_node.script_wait = var_275357a3;
        var_342ae5a4 = getent( self.go_to_node.script_noteworthy, "targetname" );
        self ai::shoot_at_target( "normal", var_342ae5a4, "tag_origin", var_275357a3, 100, 1 );
        self ai::function_3a5e9945( 1 );
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0x24a24e75, Offset: 0x26a8
// Size: 0x64
function function_a69dbf23( str_target )
{
    e_target = getent( str_target, "targetname" );
    
    if ( isdefined( e_target ) )
    {
        self thread ai::shoot_at_target( "normal", e_target, undefined, 5 );
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0x6dade636, Offset: 0x2718
// Size: 0x4c
function function_cdeeb022( str_node )
{
    nd_goal = getnode( str_node, "targetname" );
    self ai::set_goal_node( nd_goal );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x381cd527, Offset: 0x2770
// Size: 0x144
function function_28ebbd20()
{
    self endon( #"death" );
    self.var_6eed8aea = 0;
    s_poi_video_store_1st_floor = struct::get( "s_poi_video_store_1st_floor", "targetname" );
    self ai::poi_enable( 1, s_poi_video_store_1st_floor, 0 );
    self.stealth.funcs[ #"event_combat" ] = &function_2113900e;
    self val::set( #"video_store", "ignoreall", 1 );
    level flag::wait_till_any( [ "flg_video_store_alert", "flg_video_store_drills_done" ] );
    self ai::poi_enable( 0 );
    self val::reset( #"video_store", "ignoreall" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0x17d1fd1c, Offset: 0x28c0
// Size: 0x6e, Type: bool
function function_2113900e( *event )
{
    level flag::set( "flg_video_store_drills_done" );
    level flag::set( "flg_video_store_alert" );
    self.stealth.funcs[ #"event_combat" ] = undefined;
    return false;
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x49e6f1f, Offset: 0x2938
// Size: 0x124
function function_f294b4d4()
{
    self endon( #"death", #"damage", #"ai_spotted_player" );
    level endon( #"flg_video_store_alert" );
    self function_cdeeb022( "n_video_store_front_left_point_2" );
    wait 3;
    self function_a69dbf23( "e_video_target_1" );
    level flag::set( "flg_video_store_drills_half_done" );
    wait 5;
    self function_cdeeb022( "n_video_store_front_left_point_3" );
    wait 3;
    level flag::set( "flg_video_store_drills_three_fourths_done" );
    self function_a69dbf23( "e_video_target_2" );
    wait 5;
    level flag::set( "flg_video_store_drills_done" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x731a3556, Offset: 0x2a68
// Size: 0x142
function function_5146e2b5()
{
    self endon( #"death", #"damage", #"ai_spotted_player" );
    level endon( #"flg_video_store_alert" );
    self function_cdeeb022( "n_video_store_front_right_point_1" );
    self function_a69dbf23( "e_video_target_4" );
    wait 10;
    self function_cdeeb022( "n_video_store_front_right_point_2" );
    self waittill( #"goal" );
    wait 3;
    self function_cdeeb022( "n_video_store_front_right_point_3" );
    self waittill( #"goal" );
    self function_a69dbf23( "e_video_target_3" );
    wait 2;
    self function_cdeeb022( "n_video_store_front_right_point_3" );
    self waittill( #"goal" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x48ffd3a7, Offset: 0x2bb8
// Size: 0xd4
function function_223fdcd3()
{
    self endon( #"death", #"damage", #"ai_spotted_player" );
    level endon( #"flg_video_store_alert" );
    self function_cdeeb022( "n_video_store_back_right_point_1" );
    wait 5;
    self function_a69dbf23( "e_video_target_5" );
    wait 7;
    self function_cdeeb022( "n_video_store_back_right_point_3" );
    self waittill( #"goal" );
    self function_a69dbf23( "e_video_target_3" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x540341b5, Offset: 0x2c98
// Size: 0xc4
function function_546b216c()
{
    self endon( #"death", #"damage", #"ai_spotted_player" );
    level endon( #"flg_video_store_alert" );
    wait 3;
    self function_cdeeb022( "n_video_store_back_left_point_2" );
    wait 4;
    self function_cdeeb022( "n_video_store_back_left_point_3" );
    self waittill( #"goal" );
    self function_a69dbf23( "e_video_target_2" );
    wait 5.5;
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xaebc8dfd, Offset: 0x2d68
// Size: 0x4c
function function_cc1f8e0c()
{
    self endon( #"death" );
    level flag::wait_till( "flg_main_street_start" );
    self namespace_979752dc::enable_stealth_for_ai( 0 );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x58a2ebf8, Offset: 0x2dc0
// Size: 0x194
function function_dd54be7d()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_video_store_alert" );
    s_video_store_entrance = struct::get( "s_video_store_entrance", "targetname" );
    
    while ( level flag::get( "flg_video_store_player_los" ) == 0 )
    {
        var_e88b5bd1 = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), s_video_store_entrance.origin, 0.707107 );
        var_d94cabb4 = sighttracepassed( level.player getplayercamerapos(), s_video_store_entrance.origin, 1, level.woods );
        
        if ( var_e88b5bd1 === 1 && var_d94cabb4 === 1 )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    level flag::set( "flg_video_store_player_los" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x1a005fc4, Offset: 0x2f60
// Size: 0x17c
function function_2748614e()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_video_store_alert" );
    self endon( #"death" );
    vol = getent( "vol_amerika_video_store", "targetname" );
    
    while ( true )
    {
        if ( level flag::get( "flg_video_store_drills_done" ) == 1 )
        {
            if ( self cansee( level.player ) )
            {
                break;
            }
        }
        else if ( level.player istouching( vol ) && self cansee( level.player ) )
        {
            break;
        }
        
        wait 0.5;
    }
    
    level flag::set( "flg_video_store_drills_done" );
    level flag::set( "flg_video_store_alert" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xffa52bb, Offset: 0x30e8
// Size: 0x5c
function function_6add98b3()
{
    level endon( #"flg_video_store_alert" );
    ai::waittill_dead_or_dying( level.var_d6840b, 1 );
    level flag::set( "flg_video_store_alert" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x9aa9b021, Offset: 0x3150
// Size: 0xac
function function_25f2d4c0()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_video_store_alert" );
    level.player waittill( #"weapon_fired" );
    level flag::set( "flg_video_store_drills_done" );
    level flag::set( "flg_video_store_alert" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xd7329f43, Offset: 0x3208
// Size: 0x64
function function_90f57948()
{
    self endon( #"death" );
    self waittill( #"stealth_combat" );
    function_1eaaceab( level.var_d6840b );
    array::notify_all( level.var_d6840b, "ai_spotted_player" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0x5c9652b0, Offset: 0x3278
// Size: 0x54
function function_bc754782( *str_objective )
{
    level thread function_a76c968c();
    level thread function_c6c88d08();
    level thread namespace_fc3e8cb::function_869f213d();
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x7b9952b7, Offset: 0x32d8
// Size: 0x104
function function_c6c88d08()
{
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_main_street", 0, 0 );
    var_bb96f34c = getent( "t_b72", "targetname" );
    var_bb96f34c triggerenable( 0 );
    var_f2e43740 = getent( "t_b85", "targetname" );
    var_f2e43740 triggerenable( 0 );
    var_196f0459 = getent( "t_b71", "targetname" );
    var_196f0459 triggerenable( 0 );
    level hms_util::function_53531f27( "t_b86" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x53c02252, Offset: 0x33e8
// Size: 0x26
function function_a76c968c()
{
    var_eec4445f = spawner::simple_spawn( "sp_enemy_video_store_wave2" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 2
// Checksum 0xfdef7dd6, Offset: 0x3418
// Size: 0x154
function function_c5b43ce( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    savegame::checkpoint_save( 1 );
    level thread function_a6a02518();
    level thread namespace_4bd68414::function_92d726be();
    level thread namespace_4bd68414::function_88753bbe();
    level thread namespace_4bd68414::function_cb23defe();
    level thread namespace_4bd68414::function_68bed476();
    level thread namespace_4bd68414::main_street_bubby_optional_dialogue();
    level thread function_65e83155();
    level thread function_11a7fafb();
    level thread function_8a32e8b0();
    level flag::wait_till( "flg_main_street_end" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 4
// Checksum 0xac014460, Offset: 0x3578
// Size: 0x44
function function_c76d36b0( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_perf_mainstreet_keys", 1 );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x2569cc2e, Offset: 0x35c8
// Size: 0x84
function function_a6a02518()
{
    objectives::scripted( "obj_main_street_advance", undefined, #"hash_1ce39c29b923f2b9" );
    level breadcrumb::function_61037c6c( "s_obj_main_street_breadcrumb" );
    level flag::wait_till( "flg_main_street_end" );
    objectives::complete( "obj_main_street_advance" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x3be7bb92, Offset: 0x3658
// Size: 0xf2
function function_65e83155()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level thread function_ce8bced();
    level thread namespace_4bd68414::function_6aa4492a();
    level.woods colors::set_force_color( "blue" );
    var_1dcd05ba = level.woods.script_accuracy;
    level.woods.script_accuracy = 0.8;
    level flag::wait_till( "flg_main_street_end" );
    level.woods.script_accuracy = var_1dcd05ba;
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xae2491d9, Offset: 0x3758
// Size: 0xe8
function function_ce8bced()
{
    level flag::wait_till_any( [ "flg_stop_first_area_woods_color_triggers", "flg_burger_town_resistance" ] );
    trigs = getentarray( "t_main_street_woods_colors_preburgertown", "script_noteworthy" );
    
    foreach ( trig in trigs )
    {
        trig delete();
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x2cfb54ce, Offset: 0x3848
// Size: 0x58c
function function_11a7fafb()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level flag::wait_till( "flg_main_street_start" );
    level thread function_f7306dbb( "flg_main_street_parking_lot_clear" );
    level thread function_f7306dbb( "flg_main_street_autosave_1" );
    var_7ad3e751 = spawner::simple_spawn( "sp_enemy_street_wave1" );
    level thread function_2f0a158();
    level thread function_7972340e();
    level thread function_e65284ff();
    level thread function_1ce0335a();
    level thread function_99afde3b( "flg_tv_store_sniper", "flg_player_down_from_perch", "s_player_perch" );
    level thread function_99afde3b( "flg_upper_route_enemy_grenades", "flg_stop_corner_area_main_street_optional_spawns", "s_player_perch_tv_store" );
    var_b05b51c6 = getaiarray( "sp_enemy_video_store_wave1", "targetname" );
    var_48ac31fb = getaiarray( "sp_enemy_video_store_wave2", "targetname" );
    var_b05b51c6 = arraycombine( var_b05b51c6, var_48ac31fb );
    level.var_bcd79d81 = arraycombine( var_b05b51c6, var_7ad3e751 );
    function_1eaaceab( level.var_bcd79d81 );
    level thread namespace_fc3e8cb::function_85939627( level.var_bcd79d81, "flg_main_street_fallback_2", level.var_bcd79d81.size - 4 );
    level thread function_b211098e();
    var_63d2d7ec = level flag::wait_till_any( [ "flg_main_street_parking_lot_truck_unloaded", "flg_main_street_parking_lot_truck_dead", "flg_main_street_2_start" ] );
    
    if ( var_63d2d7ec._notify === #"flg_main_street_parking_lot_truck_unloaded" )
    {
        wait 1;
    }
    
    function_1eaaceab( level.var_bcd79d81 );
    level thread namespace_fc3e8cb::function_85939627( level.var_bcd79d81, "flg_main_street_rush_player", level.var_bcd79d81.size - 4 );
    level thread namespace_fc3e8cb::function_940ffdb0( "flg_main_street_rush_player", level.var_bcd79d81 );
    var_63d2d7ec = level flag::wait_till_any( [ "flg_main_street_2_start", "flg_main_street_pizza_store" ] );
    level thread function_f7306dbb( "flg_main_street_autosave_2" );
    level thread function_c67de6da();
    level thread function_1adb1a72();
    level thread function_92386a2b();
    level thread function_1061068e();
    level flag::wait_till( "flg_main_street_3_start" );
    level thread function_24fa8f1e();
    function_1eaaceab( level.var_bcd79d81 );
    array::thread_all( level.var_bcd79d81, &function_e5b395e2 );
    var_bb9595e = getent( "vol_amerika_streets_end", "targetname" );
    level.var_b665de74 = spawner::simple_spawn( "sp_enemy_street_wave3" );
    array::thread_all( level.var_b665de74, &function_7c0c35ef );
    level thread function_8f7156c0();
    level flag::wait_till( "flg_main_street_end" );
    var_5c5d4c59 = getactorteamarray( "axis" );
    function_1eaaceab( var_5c5d4c59 );
    array::thread_all( var_5c5d4c59, &function_e5b395e2 );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x98f6f801, Offset: 0x3de0
// Size: 0xe4
function function_b211098e()
{
    level flag::wait_till( "flg_main_street_vehicle_complete_1" );
    waitframe( 1 );
    var_42bbb731 = level.var_bcd79d81;
    var_f5de75be = getaiarray( "sp_enemy_street_theater_sniper", "targetname" );
    var_42bbb731 = arraycombine( var_42bbb731, var_f5de75be );
    var_375e33bd = getaiarray( "sp_enemy_tv_store_roof", "targetname" );
    var_42bbb731 = arraycombine( var_42bbb731, var_375e33bd );
    level thread namespace_fc3e8cb::function_85939627( var_42bbb731, "flg_main_street_parking_lot_clear", var_42bbb731.size );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xd39bff71, Offset: 0x3ed0
// Size: 0x17c
function function_2f0a158()
{
    var_44589d99 = spawner::simple_spawn( "sp_enemy_street_theater_sniper" );
    level flag::wait_till_any( [ "flg_main_street_theater_move_sniper_inside", "flg_main_street_side_spawns_disable" ] );
    function_1eaaceab( var_44589d99 );
    vol_amerika_streets_theater_catwalks = getent( "vol_amerika_streets_theater_catwalks", "targetname" );
    
    foreach ( ai in var_44589d99 )
    {
        ai thread ai::force_goal( vol_amerika_streets_theater_catwalks );
    }
    
    level flag::wait_till( "flg_main_street_sniper_despawn" );
    function_1eaaceab( var_44589d99 );
    array::thread_all( var_44589d99, &function_e5b395e2 );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x5b830913, Offset: 0x4058
// Size: 0xce
function function_24fa8f1e()
{
    var_63d2d7ec = level flag::wait_till_any( [ "flg_main_street_wave3_bridge_window", "flg_main_street_wave3_bridge_from_street" ] );
    
    if ( var_63d2d7ec._notify === #"flg_main_street_wave3_bridge_window" )
    {
        var_82e79ab4 = spawner::simple_spawn( "sp_enemy_street_wave3_bt_backdoor_rpg" );
        return;
    }
    
    if ( var_63d2d7ec._notify === #"flg_main_street_wave3_bridge_from_street" )
    {
        var_5277d254 = spawner::simple_spawn( "sp_enemy_street_wave3_bridge_from_street_rpg" );
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x8b4ca46, Offset: 0x4130
// Size: 0x74
function function_7c0c35ef()
{
    level.player endon( #"death" );
    self endon( #"death" );
    level flag::wait_till( "flg_wave_3_bridge_alternate_positions" );
    self ai::set_goal( "vol_amerika_streets_wave_3_bridge_stairs", "targetname" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x2f0a8c2e, Offset: 0x41b0
// Size: 0xb4
function function_8f7156c0()
{
    level thread namespace_fc3e8cb::function_85939627( level.var_b665de74, "flg_main_street_all_dead", level.var_b665de74.size );
    level flag::wait_till( "flg_main_street_all_dead" );
    level hms_util::function_53531f27( "t_b78" );
    level hms_util::function_53531f27( "t_b87" );
    level hms_util::function_53531f27( "t_main_street_end" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x30c3e521, Offset: 0x4270
// Size: 0x24c
function function_7972340e()
{
    level flag::wait_till_any( [ "flg_main_street_vehicle_1", "flg_main_street_fallback_2" ] );
    level flag::wait_till( "flg_main_street_vehicle_can_go" );
    level thread namespace_4bd68414::function_20228cc();
    level thread function_3e2d3b05();
    level thread namespace_fc3e8cb::function_ffc69c66( "vh_main_street_truck_1", undefined, "flg_terminal_player_exit", 0 );
    var_4e65d853 = getvehiclearray( "vh_main_street_truck_1", "targetname" )[ 0 ];
    snd::client_targetname( var_4e65d853, "evt_audio_main_street_truck_drive_up" );
    level flag::wait_till( "flg_main_street_vehicle_complete_1" );
    
    if ( isalive( var_4e65d853 ) )
    {
        arrayremovevalue( var_4e65d853.var_761c973.riders, undefined, 1 );
        array::thread_all( var_4e65d853.var_761c973.riders, &function_58c0a827 );
        s_result = var_4e65d853 waittill( #"unloaded", #"death" );
        
        if ( s_result._notify === "unloaded" )
        {
            level flag::set( "flg_main_street_parking_lot_truck_unloaded" );
            var_4e65d853 waittill( #"death" );
        }
        
        level flag::set( "flg_main_street_parking_lot_truck_dead" );
        snd::client_msg( "flg_audio_truck_engine_idle_stop" );
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x436ca7e2, Offset: 0x44c8
// Size: 0x134
function function_58c0a827()
{
    if ( !isdefined( self.target ) )
    {
        return;
    }
    
    self endon( #"death" );
    self waittill( #"exited_vehicle" );
    waitframe( 2 );
    
    if ( !isdefined( level.var_bcd79d81 ) )
    {
        level.var_bcd79d81 = [];
    }
    else if ( !isarray( level.var_bcd79d81 ) )
    {
        level.var_bcd79d81 = array( level.var_bcd79d81 );
    }
    
    level.var_bcd79d81[ level.var_bcd79d81.size ] = self;
    to = getnode( self.target, "targetname" );
    
    if ( !isdefined( to ) )
    {
        to = getent( self.target, "targetname" );
    }
    
    if ( isdefined( to ) )
    {
        self setgoal( to, 1 );
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0x95737dbb, Offset: 0x4608
// Size: 0x3c
function function_f7306dbb( flag )
{
    level flag::wait_till( flag );
    savegame::checkpoint_save( 1 );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 3
// Checksum 0x645e747c, Offset: 0x4650
// Size: 0x16a
function function_99afde3b( flag1, flag2, struct )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level flag::wait_till( flag1 );
    wait 13;
    s_player_perch = struct::get( struct, "targetname" );
    
    while ( !level flag::get( flag2 ) )
    {
        while ( distance2d( level.player.origin, s_player_perch.origin ) < 500 )
        {
            wait 8;
            var_5c5d4c59 = getactorteamarray( "axis" );
            
            if ( isdefined( var_5c5d4c59 ) && var_5c5d4c59.size > 0 )
            {
                var_5c5d4c59[ 0 ] hms_util::throw_grenade( level.player.origin, 1 );
            }
            
            wait 8;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 2
// Checksum 0x84945b00, Offset: 0x47c8
// Size: 0x16c
function function_c231897a( var_a7dc1f6a, var_ed4d350b )
{
    var_44589d99 = spawner::simple_spawn( var_a7dc1f6a );
    
    foreach ( ai in var_44589d99 )
    {
        if ( !isdefined( level.var_bcd79d81 ) )
        {
            level.var_bcd79d81 = [];
        }
        else if ( !isarray( level.var_bcd79d81 ) )
        {
            level.var_bcd79d81 = array( level.var_bcd79d81 );
        }
        
        level.var_bcd79d81[ level.var_bcd79d81.size ] = ai;
    }
    
    level flag::wait_till( var_ed4d350b );
    function_1eaaceab( var_44589d99 );
    array::thread_all( var_44589d99, &function_e5b395e2 );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x43ef8674, Offset: 0x4940
// Size: 0x11c
function function_e5b395e2()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( self scene::function_c935c42() )
        {
            wait 1;
            continue;
        }
        
        var_e88b5bd1 = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), self geteye(), 0.707107 );
        
        if ( var_e88b5bd1 == 0 )
        {
            break;
        }
        
        wait 0.2;
    }
    
    self delete();
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x9cf5dbd1, Offset: 0x4a68
// Size: 0x5c
function function_e65284ff()
{
    level endon( #"flg_stop_first_area_main_street_optional_spawns" );
    level flag::wait_till( "flg_tv_store_sniper" );
    level thread function_c231897a( "sp_enemy_tv_store_roof", "flg_stop_first_area_main_street_optional_spawns" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xdbf19305, Offset: 0x4ad0
// Size: 0x76
function function_1ce0335a()
{
    level endon( #"flg_stop_first_area_main_street_optional_spawns" );
    level flag::wait_till( "flg_theater_second_floor_start" );
    level flag::set( "flg_tv_store_sniper" );
    var_92f176a4 = spawner::simple_spawn( "sp_enemy_theater_second_floor" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xdb7cfcf, Offset: 0x4b50
// Size: 0x66
function function_15a4d1ad()
{
    level endon( #"flg_stop_first_area_main_street_optional_spawns", #"flg_main_street_2_start" );
    level flag::wait_till( "flg_main_street_pizza_store" );
    var_d4e072a8 = spawner::simple_spawn( "sp_enemy_pizza_store" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x924a83ff, Offset: 0x4bc0
// Size: 0x128
function function_c67de6da()
{
    level flag::wait_till( "flg_burger_town_floor_enemies" );
    var_16cec532 = spawner::simple_spawn( "sp_enemy_street_burger_town" );
    level flag::wait_till( "flg_burgertown_enemies_fallback_to_final_fight" );
    var_bb9595e = getent( "vol_amerika_streets_wave_3_left", "targetname" );
    function_1eaaceab( var_16cec532 );
    
    foreach ( ai in var_16cec532 )
    {
        ai thread ai::force_goal( var_bb9595e );
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xf06fb87e, Offset: 0x4cf0
// Size: 0x5c
function function_1adb1a72()
{
    level flag::wait_till_any( [ "flg_upper_route_snipers", "flg_burger_town_resistance" ] );
    function_c231897a( "sp_enemy_street_wave2_alt", "flg_main_street_3_start" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x78503663, Offset: 0x4d58
// Size: 0x64
function function_92386a2b()
{
    level flag::wait_till( "flg_burger_town_resistance" );
    var_9eac748 = spawner::simple_spawn( "sp_enemy_burger_town_resistance" );
    level thread function_55b55bb4( "sm_main_street_smoke_1" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0xc51f19e2, Offset: 0x4dc8
// Size: 0x7c
function function_55b55bb4( var_f41f62c0 )
{
    var_c9ec79c6 = getent( var_f41f62c0, "targetname" );
    level.player magicgrenadeplayer( getweapon( #"willy_pete" ), var_c9ec79c6.origin, ( 0, 0, 0 ) );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xc9bb7d92, Offset: 0x4e50
// Size: 0x56
function function_1061068e()
{
    level endon( #"flg_stop_corner_area_main_street_optional_spawns" );
    level flag::wait_till( "flg_bar_stairs_start" );
    var_eb831daf = spawner::simple_spawn( "sp_enemy_bar" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xd20784f5, Offset: 0x4eb0
// Size: 0x54
function function_eac97f7a()
{
    self endon( #"death" );
    self waittill( #"damage", #"bulletwhizby" );
    self function_f46ca8fb( 150 );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0x28033615, Offset: 0x4f10
// Size: 0xb4
function function_f46ca8fb( goal_radius = 350 )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"death" );
    wait randomfloatrange( 0.5, 2.5 );
    self setgoal( level.player, 1, goal_radius );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0x57da0305, Offset: 0x4fd0
// Size: 0x7c
function function_e169c9d8( *str_objective )
{
    level thread namespace_fc3e8cb::function_2e7c81f6( 0 );
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_elevator_fight", 0, 0 );
    level flag::set( "flg_stop_corner_area_main_street_optional_spawns" );
    level thread namespace_fc3e8cb::function_869f213d();
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 2
// Checksum 0xe327f354, Offset: 0x5058
// Size: 0xf4
function function_f7a489fd( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    level thread function_d6440d09();
    level thread function_a15139a6();
    level thread function_c5a2a18f();
    level thread function_97fe34c();
    level thread function_1dba4c53();
    level flag::wait_till( "flg_elevator_ready" );
    level thread namespace_aad1a8fc::function_2a03dea7();
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 4
// Checksum 0x964fd54f, Offset: 0x5158
// Size: 0x120
function function_5ce25b5( *str_objective, var_50cc0d4f, *var_aa1a6455, *player )
{
    if ( player )
    {
        var_d5535d9a = getvehiclearray( "control_tower_elevator", "targetname" )[ 0 ];
        var_a6d70f94 = getentarray( "elevator_player_clip", "targetname" );
        
        foreach ( clip in var_a6d70f94 )
        {
            clip linkto( var_d5535d9a );
            clip hide();
        }
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x6eb1c79b, Offset: 0x5280
// Size: 0x10c
function function_1dba4c53()
{
    objectives::goto( "obj_elevator_interact", undefined, #"hash_233d6343fbeb9550" );
    level flag::wait_till( "flg_elevator_fight_start" );
    objectives::complete( "obj_elevator_interact" );
    level flag::wait_till( "flg_elevator_fight_jugg_intro_complete" );
    objectives::kill( "obj_elevator_kill_juggernaut", level.var_74fa4108, #"hash_2037cc845e66293b" );
    level flag::wait_till( "flg_elevator_juggernauts_dead" );
    objectives::complete( "obj_elevator_kill_juggernaut" );
    wait 1;
    savegame::checkpoint_save( 1 );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x2e8674e0, Offset: 0x5398
// Size: 0x124
function function_a15139a6()
{
    level flag::wait_till( "flg_elevator_fight_start" );
    level.var_74fa4108 = spawner::simple_spawn( "sp_enemy_main_street_elevator_jugg", &function_3c0bc573 );
    level thread namespace_fc3e8cb::function_85939627( level.var_74fa4108, "flg_elevator_juggernauts_dead", level.var_74fa4108.size );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_terminal_player_interact", level.var_74fa4108 );
    level flag::wait_till( "flg_elevator_juggernauts_dead" );
    level thread namespace_4bd68414::function_951c664b();
    level flag::wait_till( "flg_elevator_regular_enemies_dead" );
    level flag::set( "flg_elevator_all_enemies_dead" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x37f1b3c2, Offset: 0x54c8
// Size: 0x14c
function function_c5a2a18f()
{
    level flag::wait_till_any( [ "flg_elevator_fight_advance", "flg_elevator_juggernauts_dead" ] );
    var_d1700a09 = spawner::simple_spawn( "sp_enemy_elevator_smg", &function_4b1daaaa );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_terminal_player_interact", var_d1700a09 );
    level thread namespace_fc3e8cb::function_85939627( var_d1700a09, "flg_elevator_most_enemies_dead", var_d1700a09.size - 1 );
    level thread namespace_fc3e8cb::function_85939627( var_d1700a09, "flg_elevator_regular_enemies_dead", var_d1700a09.size );
    wait 1;
    level thread namespace_4bd68414::function_41f45773();
    level thread namespace_fc3e8cb::elevator_descend();
    level flag::wait_till( "flg_main_street_elevator_reached_ground" );
    level thread namespace_fc3e8cb::function_bd7f6a68();
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xabd37d55, Offset: 0x5620
// Size: 0xbc
function function_7a830693()
{
    self endon( #"death" );
    self.grenadeammo = 0;
    self.script_accuracy = 0.5;
    level flag::wait_till( "flg_elevator_juggernauts_dead" );
    self.health = 10;
    vol = getent( "vol_elevator_bottom", "targetname" );
    wait randomfloatrange( 1, 3 );
    self setgoal( vol );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xaa4f006b, Offset: 0x56e8
// Size: 0x52c
function function_3c0bc573()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"death" );
    s_mainst_elevator_jugpos_start = struct::get( "s_mainst_elevator_jugpos_start" );
    s_mainst_elevator_jugpos_center = struct::get( "s_mainst_elevator_jugpos_center" );
    s_mainst_elevator_jugpos_back = struct::get( "s_mainst_elevator_jugpos_back" );
    n_health_threshold = int( self.health * 0.4 );
    self.favoriteenemy = level.woods;
    self.holdfire = 1;
    self namespace_631d466b::function_57a875b1( 0 );
    self val::set( #"elevator_jugg", "magic_bullet_shield", 1 );
    level.player val::set( #"hash_9ca6389832f4abf", "ignoreme", 1 );
    self thread function_d30dfbf8();
    level thread namespace_4bd68414::function_163c82e7();
    self thread function_538bceed();
    self thread function_b1c9c908();
    self.juggernautdisablemovebehavior = 1;
    self.var_419d64f3 = 1;
    waitframe( 2 );
    self ai::set_behavior_attribute( "demeanor", "cqb" );
    self setdesiredspeed( 120 );
    self.ignorepathenemyfightdist = 1;
    self setgoal( s_mainst_elevator_jugpos_start.origin, 1, s_mainst_elevator_jugpos_start.radius, 32 );
    self thread function_e0c8603d( 2 );
    waitresult = self waittill( #"goal", #"damage", #"player_close" );
    self.ignorepathenemyfightdist = 0;
    self.juggernautdisablemovebehavior = 0;
    self.var_419d64f3 = undefined;
    level flag::set( "flg_elevator_fight_jugg_intro_at_goal" );
    str_notify = waitresult._notify;
    
    if ( str_notify === "goal" )
    {
        self waittilltimeout( 2, #"damage", #"player_close" );
    }
    
    self thread namespace_4bd68414::function_9ab4952e();
    self function_9ae1c50();
    level.player val::set( #"hash_9ca6389832f4abf", "ignoreme", 0 );
    self.favoriteenemy = level.player;
    level flag::wait_till( "flg_elevator_fight_jugg_intro_complete" );
    self val::reset_all( #"elevator_jugg" );
    self namespace_631d466b::function_6aedb63( s_mainst_elevator_jugpos_center.origin, s_mainst_elevator_jugpos_center.radius );
    
    while ( level flag::get( "flg_elevator_fight_advance" ) == 0 )
    {
        if ( self.health < n_health_threshold )
        {
            self thread namespace_4bd68414::function_aa33d336();
            break;
        }
        
        if ( level flag::get( "flg_elevator_fight_jugg_helmet_off" ) == 1 )
        {
            self thread namespace_4bd68414::function_31c14ca2( n_health_threshold );
            break;
        }
        
        waitframe( 1 );
    }
    
    self namespace_631d466b::function_6aedb63( s_mainst_elevator_jugpos_back.origin, s_mainst_elevator_jugpos_back.radius );
    level flag::set( "flg_elevator_fight_advance" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0xf8c50e1c, Offset: 0x5c20
// Size: 0x72
function function_e0c8603d( n_delay = 1 )
{
    self endon( #"death" );
    self waittilltimeout( n_delay, #"goal", #"damage", #"player_close" );
    self.holdfire = 0;
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x5b63c09, Offset: 0x5ca0
// Size: 0x82
function function_d30dfbf8()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( self.var_afc00716 === 1 )
        {
            level flag::set( "flg_elevator_fight_jugg_helmet_off" );
            self ai::set_behavior_attribute( "demeanor", "combat" );
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x443b6466, Offset: 0x5d30
// Size: 0x2d4
function function_538bceed()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    var_7a1c52df = 500;
    var_6c76f1a4 = 0.5;
    var_dc01518d = sqr( 280 );
    var_cf1eeb88 = sqr( 140 );
    var_3ba4d952 = 0;
    s_mb_start = struct::get( "s_elevator_fight_mb_start", "targetname" );
    var_ea066846 = struct::get( "s_elevator_fight_mb_end", "targetname" );
    v_fwd = anglestoforward( level.player getplayerangles() );
    v_right = anglestoright( level.player getplayerangles() );
    var_a6be6a4f = level.player getplayercamerapos() + ( 0, 0, -32 ) + v_fwd * 20 + v_right * 20;
    var_a75f2965 = getweapon( #"hash_58a74d179a004add" );
    var_38ffd5df = vectornormalize( var_a6be6a4f - s_mb_start.origin ) * var_7a1c52df;
    e_grenade = self magicgrenadetype( var_a75f2965, s_mb_start.origin, var_38ffd5df, var_6c76f1a4 );
    
    while ( true )
    {
        if ( !isdefined( e_grenade ) )
        {
            break;
        }
        else
        {
            n_dist = distance2dsquared( e_grenade.origin, level.player getplayercamerapos() );
            
            if ( n_dist < var_dc01518d )
            {
                break;
            }
        }
        
        waitframe( 1 );
    }
    
    self thread function_b6283110( e_grenade );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0xedc2dea1, Offset: 0x6010
// Size: 0x144
function function_b6283110( *e_grenade )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    var_e88b5bd1 = 1;
    wait 0.3;
    setslowmotion( 1, 0.4, 0.2 );
    level.player thread function_82bbbc5f( 2.5 );
    level flag::wait_till_timeout( 2.5, "flg_elevator_fight_jugg_intro_at_goal" );
    setslowmotion( 0.4, 1, 0.5 );
    level flag::set( "flg_elevator_fight_jugg_intro_complete" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0x4a965e00, Offset: 0x6160
// Size: 0xc4
function function_82bbbc5f( var_7fb467c )
{
    self endon( #"death" );
    self playgestureviewmodel( #"hash_6cb04aab2ccc6f0a" );
    self function_912b1fe1();
    level flag::wait_till_any_timeout( var_7fb467c, [ "flg_elevator_fight_jugg_intro_at_goal", "flg_elevator_fight_player_weapon_fired" ] );
    self stopgestureviewmodel( #"hash_6cb04aab2ccc6f0a" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x573f63d6, Offset: 0x6230
// Size: 0x114
function function_912b1fe1()
{
    self endon( #"death" );
    level endon( #"flg_elevator_fight_jugg_intro_complete" );
    wait 2;
    
    while ( true )
    {
        if ( self adsbuttonpressed() || self meleebuttonpressed() || self sprintbuttonpressed() || self jumpbuttonpressed() || self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    level flag::set( "flg_elevator_fight_player_weapon_fired" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x73158a95, Offset: 0x6350
// Size: 0xd0
function function_b1c9c908()
{
    self endon( #"death" );
    level endon( #"flg_elevator_fight_jugg_intro_complete" );
    var_3af9ba8b = sqr( 200 );
    
    while ( level flag::get( "flg_elevator_fight_jugg_intro_complete" ) == 0 )
    {
        n_dist = distance2dsquared( self.origin, level.player.origin );
        
        if ( n_dist < var_3af9ba8b )
        {
            self notify( #"player_close" );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xd4820803, Offset: 0x6428
// Size: 0x504
function function_4b1daaaa()
{
    self endon( #"death" );
    self.grenadeammo = 0;
    self val::set( #"hash_4852286cfcfcbf76", "ignoreme", 1 );
    var_d5535d9a = getvehiclearray( "control_tower_elevator", "targetname" )[ 0 ];
    self linkto( var_d5535d9a );
    level flag::wait_till( "flg_main_street_elevator_near_ground" );
    self val::set( #"hash_4852286cfcfcbf76", "ignoreme", 0 );
    self unlink();
    wait randomfloatrange( 0.5, 1.5 );
    self.og_goalradius = self.goalradius;
    self.goalradius = 32;
    
    if ( self.script_noteworthy == "elevator_left" )
    {
        node = getnode( "nd_elevator_fight_enemy_left", "targetname" );
        self setgoal( node, 1 );
        self waittilltimeout( 10, #"goal" );
        vol = getent( "vol_elevator_left", "targetname" );
        self.goalradius = self.og_goalradius;
        self setgoal( vol, 1 );
    }
    else if ( self.script_noteworthy == "elevator_left" )
    {
        node = getnode( "nd_elevator_fight_enemy_right", "targetname" );
        self.og_goalradius = self.goalradius;
        self.goalradius = 32;
        self setgoal( node, 1 );
        self waittilltimeout( 10, #"goal" );
        vol = getent( "vol_elevator_catwalk", "targetname" );
        self.goalradius = self.og_goalradius;
        self setgoal( vol, 1 );
    }
    else if ( self.script_noteworthy == "elevator_center" )
    {
        node = getnode( "nd_elevator_fight_enemy_center", "targetname" );
        self.og_goalradius = self.goalradius;
        self.goalradius = 32;
        self setgoal( node, 1 );
        self waittilltimeout( 10, #"goal" );
        vol = getent( "vol_elevator_bottom", "targetname" );
        self.goalradius = self.og_goalradius;
        self setgoal( vol, 1 );
    }
    else
    {
        node = getnode( "nd_elevator_fight_enemy_back", "targetname" );
        self.og_goalradius = self.goalradius;
        self.goalradius = 32;
        self setgoal( node, 1 );
        self waittilltimeout( 10, #"goal" );
        vol = getent( "vol_elevator_bottom", "targetname" );
        self.goalradius = self.og_goalradius;
        self setgoal( vol, 1 );
    }
    
    level flag::wait_till( "flg_elevator_most_enemies_dead" );
    vol = getent( "vol_elevator_bottom", "targetname" );
    wait randomfloatrange( 1, 3 );
    self setgoal( vol );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x3644433c, Offset: 0x6938
// Size: 0x248
function function_97fe34c()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_elevator_player_interact" );
    level.woods colors::disable();
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_elevator_fight_woods_start" );
    level flag::wait_till( "flg_elevator_fight_start" );
    e_elevator_fight_mantle_wood = getent( "e_elevator_fight_mantle_wood", "targetname" );
    e_elevator_fight_mantle_wood delete();
    
    while ( true )
    {
        if ( isdefined( level.var_74fa4108[ 0 ] ) )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    level.woods.favoriteenemy = level.var_74fa4108[ 0 ];
    level flag::wait_till( "flg_elevator_fight_jugg_intro_complete" );
    level.woods clearforcedgoal();
    level.woods colors::set_force_color( "blue" );
    level flag::wait_till_any( [ "flg_elevator_fight_advance", "flg_elevator_juggernauts_dead" ] );
    trig = getent( "t_elevator_fight_advance1", "targetname" );
    trig notify( #"trigger" );
    level flag::wait_till( "flg_elevator_most_enemies_dead" );
    trig = getent( "t_elevator_fight_advance2", "targetname" );
    trig notify( #"trigger" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x15943635, Offset: 0x6b88
// Size: 0xb4
function function_d6440d09()
{
    level flag::wait_till( "flg_elevator_fight_start" );
    e_elevator_fight_catwalk_clip = getent( "e_elevator_fight_catwalk_clip", "targetname" );
    e_elevator_fight_catwalk_clip movez( 512, 0.2, 0.05, 0.05 );
    level flag::wait_till( "flg_elevator_player_interact" );
    e_elevator_fight_catwalk_clip deletedelay();
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x5c68d1e8, Offset: 0x6c48
// Size: 0x16e
function function_9f102dd9()
{
    level flag::wait_till( "flg_main_street_magic_bullet_rpgs" );
    level thread namespace_4bd68414::function_a4c61d8d();
    var_25a9f3f = "s_main_street_magic_rpg_start_";
    var_50e379d = "s_main_street_magic_rpg_end_";
    
    for ( n_index = 1; n_index <= 1 ; n_index++ )
    {
        s_start_point = struct::get( var_25a9f3f + n_index, "targetname" );
        var_6ff18756 = struct::get( var_50e379d + n_index, "targetname" );
        magicbullet( getweapon( #"launcher_standard_t9" ), s_start_point.origin, var_6ff18756.origin );
        wait randomfloatrange( 1, 1.5 );
    }
    
    var_6b648c96 = spawner::simple_spawn( "sp_enemy_street_wave_rpg_guy" );
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0xeae11fd4, Offset: 0x6dc0
// Size: 0x258
function function_b248642e()
{
    level scene::init( "burger_town_rappel_scene", "targetname" );
    level flag::wait_till( "flg_burger_town_heli_rappel_start" );
    level thread scene::play( "burger_town_rappel_scene", "targetname" );
    level thread namespace_fc3e8cb::function_fa5905d0( "s_burger_town_heli_lights" );
    var_6d99da8c = getent( "vol_amerika_streets_vehicle_dropoff", "targetname" );
    var_f1f393cc = getaiarray( "sp_burger_town_rappel_group", "targetname" );
    function_1eaaceab( var_f1f393cc );
    
    foreach ( ai in var_f1f393cc )
    {
        ai thread namespace_fc3e8cb::function_a7c9ed68( var_6d99da8c, 1 );
    }
    
    level flag::wait_till( "flg_main_street_burger_town_heli_fallback" );
    var_84da118d = getent( "vol_amerika_streets_wave_3_left", "targetname" );
    function_1eaaceab( var_f1f393cc );
    
    foreach ( ai in var_f1f393cc )
    {
        ai thread ai::force_goal( var_84da118d );
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x371c9391, Offset: 0x7020
// Size: 0x168
function function_3e2d3b05()
{
    var_4371e76f = getentarray( "veh_main_street_destructibles", "script_noteworthy" );
    
    foreach ( veh in var_4371e76f )
    {
        veh val::set( "veh_main_street_destructibles", "takedamage", 0 );
    }
    
    level flag::wait_till( "flg_main_street_vehicle_complete_1" );
    
    foreach ( veh in var_4371e76f )
    {
        veh val::set( "veh_main_street_destructibles", "takedamage", 1 );
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 0
// Checksum 0x5713338d, Offset: 0x7190
// Size: 0x2b0
function function_8a32e8b0()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_elevator_fight_start" );
    s_obj_bubby_button_interact = struct::get( "s_obj_bubby_button_interact", "targetname" );
    s_obj_bubby_button_interact util::create_cursor_hint( undefined, undefined, #"hash_4f0d1e085fec7281", 40, 0.2, undefined, #"use", 40 );
    level thread function_414b79c1( s_obj_bubby_button_interact );
    
    while ( true )
    {
        s_obj_bubby_button_interact waittill( #"trigger" );
        level.player val::set( #"bubby_button_interact", "disable_weapons", 1 );
        level.player val::set( #"bubby_button_interact", "freezecontrols_allowlook", 1 );
        level.player val::set( #"bubby_button_interact", "ignoreme", 1 );
        wait 0.5;
        s_scene = struct::get( "s_scene_main_street_bubby_button_press", "targetname" );
        s_scene scene::play( "scene_amk_6090_stg_garage" );
        level.player val::reset_all( #"bubby_button_interact" );
        s_obj_bubby_button_interact util::delay( 0.2, undefined, &util::remove_cursor_hint );
        level namespace_4bd68414::main_street_bubby_button_react_dialogue();
        wait 1;
        s_obj_bubby_button_interact util::create_cursor_hint( undefined, undefined, #"hash_4f0d1e085fec7281", 40, 0.2, undefined, #"use", 40 );
    }
}

// Namespace namespace_b767a37e/namespace_ff025add
// Params 1
// Checksum 0xf4e3e67d, Offset: 0x7448
// Size: 0x74
function function_414b79c1( s_obj_bubby_button_interact )
{
    level flag::wait_till( "flg_elevator_fight_start" );
    s_obj_bubby_button_interact util::remove_cursor_hint();
    waitframe( 1 );
    
    if ( isdefined( level.var_c39cfb7a ) )
    {
        level.var_c39cfb7a deletedelay();
    }
}

