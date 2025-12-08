#using script_155b17ff7c8b315c;
#using script_446752c03c555e16;
#using script_4489198b8bcf36e8;
#using script_57d05cf093ffba5c;
#using script_97b74052c477c23;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#using scripts\weapons\smokegrenade;

#namespace namespace_4c1dd357;

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0x956755a1, Offset: 0x1630
// Size: 0x64
function function_ad51fa26( *str_objective )
{
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_facades", 0, 0 );
    level thread function_725c2118();
    level thread namespace_fc3e8cb::function_f87024e0( "nd_vh_town_square_apc_facades_start" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 2
// Checksum 0xe8fb54a5, Offset: 0x16a0
// Size: 0xc4
function function_bb5a40cc( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    level thread function_ad066a85();
    level thread ai_t8_zm_twrs_tgr_stalk_turn_l_90();
    level thread function_20d4e36c();
    level thread function_2bd1a728();
    level flag::wait_till( "flg_facades_end" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 4
// Checksum 0x9b2c2dba, Offset: 0x1770
// Size: 0x44
function function_7c8934a0( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    level flag::set( "flg_facades_dropdown" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x7d4bae7, Offset: 0x17c0
// Size: 0x94
function function_ad066a85()
{
    if ( !isdefined( objectives::function_285e460( "obj_observation_follow_woods", level.woods ) ) )
    {
        objectives::follow( "obj_observation_follow_woods", level.woods, #"hash_6783da2c53b544a4" );
    }
    
    level flag::wait_till( "flg_facades_end" );
    objectives::complete( "obj_observation_follow_woods" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0x5abb9d78, Offset: 0x1860
// Size: 0xa4
function function_c691e305( var_630bb80a )
{
    if ( isdefined( objectives::function_285e460( "obj_courtyard_main" ) ) )
    {
        return;
    }
    
    objectives::scripted( "obj_courtyard_main", undefined, #"hash_34b5d949ba5c2a1b" );
    level breadcrumb::function_61037c6c( var_630bb80a );
    level flag::wait_till( "flg_storage_end" );
    objectives::complete( "obj_courtyard_main" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x9db01f4, Offset: 0x1910
// Size: 0x51a
function ai_t8_zm_twrs_tgr_stalk_turn_l_90()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level thread namespace_4bd68414::function_ff520414();
    level.woods.grenadeammo = 0;
    level.woods val::set( #"hash_7f4af3d9057acdb8", "ignoreall", 1 );
    level.woods ai::set_behavior_attribute( "vignette_mode", "fast" );
    level.woods ai::set_behavior_attribute( "disablepeek", 1 );
    level.woods ai::set_behavior_attribute( "disablelean", 1 );
    level.woods.battlechatterallowed = 0;
    var_a44d987e = getnode( "nd_facades_woods_angle", "targetname" );
    level.player util::blend_movespeedscale( 0.9, 1 );
    level.woods ai::set_behavior_attribute( "sprint", 1 );
    level.woods setdesiredspeed( 265 );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_facades_woods_start", 1, 1 );
    level namespace_fc3e8cb::function_92dea087( "flg_facades_start", "flg_facades_dropdown" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_facades_woods_angle", 1, 1 );
    level namespace_fc3e8cb::function_92dea087( "flg_facades_angle", "flg_facades_turn_corner" );
    level.woods notify( #"hash_6f69d6fcf9b17050" );
    var_928274e8 = getnode( "nd_rooftops_woods_start", "targetname" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_facades_woods_destruction_2", 1, 1 );
    level namespace_fc3e8cb::function_92dea087( "flg_facades_destruction_2_play", "flg_facades_corridor_enter" );
    level.woods val::set( #"ai_forcegoal", "ignoreall", 1 );
    s_scene_facades_woods_parkour = struct::get( "s_scene_facades_woods_parkour", "targetname" );
    s_scene_facades_woods_parkour scene::play( "scene_amk_6030_fds_parkour_woods" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_facades_near_end", 1, 1 );
    level namespace_fc3e8cb::function_92dea087( "flg_facades_near_end", "flg_facades_destruction_3_play" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_rooftops_woods_start", 1, 1 );
    level flag::wait_till( "flg_rooftops_start" );
    level.woods notify( #"hash_6f69d9fcf9b17569" );
    level.woods.grenadeammo = 99;
    level.woods ai::set_behavior_attribute( "vignette_mode", "off" );
    level.woods val::set( #"hash_7f4af3d9057acdb8", "ignoreall", 0 );
    level.woods ai::set_behavior_attribute( "disablepeek", 0 );
    level.woods ai::set_behavior_attribute( "disablelean", 0 );
    level.woods ai::set_behavior_attribute( "sprint", 0 );
    level.woods function_9ae1c50();
    level.woods.battlechatterallowed = 1;
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xfd47cc35, Offset: 0x1e38
// Size: 0xcc
function function_725c2118()
{
    println( "<dev string:x38>" );
    var_b9f6cfe = spawner::simple_spawn( "ai_enemy_facades", &function_22df39e0 );
    level thread namespace_fc3e8cb::function_85939627( var_b9f6cfe, "flg_facades_enemies_most_dead", var_b9f6cfe.size - 2 );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_rooftops_start", var_b9f6cfe );
    level thread namespace_fc3e8cb::function_1c62d05e( "ai_enemy_facades_drone", "flg_rooftops_start" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x3c3f6dc2, Offset: 0x1f10
// Size: 0x84
function function_22df39e0()
{
    self endon( #"death" );
    self ai::set_pacifist( 1 );
    self.script_accuracy = 0.5;
    self.grenadeammo = 0;
    level flag::wait_till( "flg_facades_dropdown" );
    self ai::set_pacifist( 0 );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x82c793c0, Offset: 0x1fa0
// Size: 0x38c
function function_20d4e36c()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    var_10a7296c = struct::get_array( "s_facades_apc_intro_target", "targetname" );
    var_10a7296c = array::sort_by_script_int( var_10a7296c, 1 );
    level.vh_town_square_apc hms_util::function_c21ef1d8( "scripted", var_10a7296c[ 0 ].origin );
    level.vh_town_square_apc.aim_only_no_shooting = 1;
    level namespace_fc3e8cb::function_92dea087( "flg_facades_start", "flg_facades_dropdown" );
    level flag::set( "flg_facades_intro_apc" );
    level.vh_town_square_apc.var_21c17c08 thread namespace_4bd68414::function_75a9fa51();
    level.vh_town_square_apc.aim_only_no_shooting = undefined;
    level.vh_town_square_apc thread namespace_fc3e8cb::function_a57ce26d( var_10a7296c, "end_facades_intro_fake_shooting" );
    level.vh_town_square_apc turret::function_aecc6bed( var_10a7296c, 1, 0, 0.15 );
    level.vh_town_square_apc notify( #"end_facades_intro_fake_shooting" );
    level.vh_town_square_apc hms_util::function_c21ef1d8( "shoot_player" );
    var_2fb1c08b = struct::get_array( "s_facades_apc_target_mannequin", "targetname" );
    array::thread_all( var_2fb1c08b, &namespace_fc3e8cb::function_649019cf, "flg_storage_end" );
    level namespace_fc3e8cb::function_92dea087( "flg_facades_corridor_enter", "flg_facades_corridor_approach" );
    var_86a0a866 = struct::get_array( "s_facades_apc_wall_target", "targetname" );
    var_86a0a866 = array::sort_by_script_int( var_86a0a866, 1 );
    level.vh_town_square_apc hms_util::function_c21ef1d8( "scripted", var_86a0a866[ 0 ].origin );
    level.vh_town_square_apc thread namespace_fc3e8cb::function_a57ce26d( var_86a0a866, "end_facades_wall_fake_shooting" );
    level.vh_town_square_apc turret::function_aecc6bed( var_86a0a866, 1, 0, 0.15 );
    level.vh_town_square_apc notify( #"end_facades_wall_fake_shooting" );
    level.vh_town_square_apc hms_util::function_c21ef1d8( "shoot_player" );
    level flag::wait_till( "flg_facades_end" );
    level.vh_town_square_apc hms_util::function_c21ef1d8( "los_player" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x8c01c4af, Offset: 0x2338
// Size: 0x9c
function function_2bd1a728()
{
    scene::function_27f5972e( "p9_fxanim_rus_amk_building_facade_sim_bundle" );
    level thread function_b7b6b5f8();
    level thread function_c8572cad();
    level thread function_b8b8d8a5();
    level flag::wait_till( "flg_facades_end" );
    scene::function_f81475ae( "p9_fxanim_rus_amk_building_facade_sim_bundle" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x68e5f16d, Offset: 0x23e0
// Size: 0xac
function function_b7b6b5f8()
{
    level namespace_fc3e8cb::function_92dea087( "flg_facades_turn_corner", "flg_facades_near_corner" );
    s_scene = struct::get( "s_facades_destruction_scene_1", "targetname" );
    s_scene thread scene::play_from_time( "play" );
    s_scene function_8cc9e7c2( 1 );
    level.vh_town_square_apc hms_util::function_c21ef1d8( "shoot_player" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xbd95d475, Offset: 0x2498
// Size: 0xcc
function function_c8572cad()
{
    level namespace_fc3e8cb::function_92dea087( "flg_facades_corridor_midpoint", "flg_facades_destruction_2_play" );
    level.vh_town_square_apc.var_21c17c08 thread namespace_4bd68414::function_c7c2eb9c();
    s_scene = struct::get( "s_facades_destruction_scene_2", "targetname" );
    s_scene thread scene::play_from_time( "play" );
    s_scene function_8cc9e7c2();
    level.vh_town_square_apc hms_util::function_c21ef1d8( "shoot_player" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xc8bdf5bf, Offset: 0x2570
// Size: 0xac
function function_b8b8d8a5()
{
    level namespace_fc3e8cb::function_92dea087( "flg_facades_near_end", "flg_facades_destruction_3_play" );
    s_scene = struct::get( "s_facades_destruction_scene_3", "targetname" );
    s_scene thread scene::play_from_time( "play" );
    s_scene function_8cc9e7c2();
    level.vh_town_square_apc hms_util::function_c21ef1d8( "shoot_player" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0x1c973181, Offset: 0x2628
// Size: 0x13a
function function_63c5e2dc( var_f487c534 )
{
    a_targets = [];
    str_anim = var_f487c534.str_current_anim;
    notetracks = getnotetracksindelta( str_anim, 0, 999 );
    
    if ( notetracks.size )
    {
        foreach ( notetrack in notetracks )
        {
            if ( notetrack[ 1 ] == #"hash_2eff926bcf50d924" && notetrack[ 2 ] != #"end" )
            {
                v_tag_origin = var_f487c534 gettagorigin( notetrack[ 2 ] );
                a_targets[ a_targets.size ] = v_tag_origin;
            }
        }
    }
    
    return a_targets;
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0xb2e3aee8, Offset: 0x2770
// Size: 0x34e
function function_8cc9e7c2( var_43182387 = 0 )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_facades_end" );
    self endon( #"scene_stop" );
    var_17b7891d = "5a3e37da166aebb2" + turret::_index( 0 );
    self notify( var_17b7891d );
    self endon( var_17b7891d );
    var_f487c534 = self.scene_ents[ #"prop 2" ];
    level.vh_town_square_apc hms_util::function_c21ef1d8( "scripted" );
    var_afa4f4f6 = 0;
    w_weapon = turret::get_weapon( 0 );
    s_turret = level.vh_town_square_apc.a_turrets[ 0 ];
    a_targets = function_63c5e2dc( var_f487c534 );
    var_ba051ef5 = 0;
    
    if ( a_targets.size )
    {
        level.vh_town_square_apc turret::set_target( a_targets[ var_ba051ef5 ], undefined, 0 );
    }
    
    while ( true )
    {
        return_val = var_f487c534 waittill( #"hash_2eff926bcf50d924" );
        
        if ( return_val.tag_name === #"end" )
        {
            break;
        }
        
        v_end_pos = var_f487c534 gettagorigin( return_val.tag_name );
        level.vh_town_square_apc hms_util::function_b5da96ca( v_end_pos, 0, 0 );
        level.player playrumbleonentity( "damage_light" );
        earthquake( 0.4, 0.4, v_end_pos, 600 );
        var_ba051ef5++;
        
        if ( var_ba051ef5 < a_targets.size )
        {
            level.vh_town_square_apc turret::set_target( a_targets[ var_ba051ef5 ], undefined, 0 );
        }
        
        var_51b8d0b4 = distance2dsquared( level.player.origin, v_end_pos );
        
        if ( var_51b8d0b4 < sqr( 600 ) && var_afa4f4f6 == 0 )
        {
            level.player thread function_f94da504( var_43182387, v_end_pos );
            var_afa4f4f6 = 1;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 2
// Checksum 0xc06c2c2, Offset: 0x2ac8
// Size: 0x1c4
function function_f94da504( var_43182387 = 0, v_end_pos )
{
    weapon = getweapon( #"frag_grenade" );
    var_7444953c = getstatuseffect( #"explosive_damage" );
    var_c459838 = getstatuseffect( #"hash_43002ea60b520663" );
    level.player util::blend_movespeedscale( 0.8, 0.5 );
    
    if ( var_43182387 == 1 )
    {
        level.player status_effect::status_effect_apply( var_c459838, weapon, level.vh_town_square_apc, undefined, 2500, undefined, v_end_pos );
        level.player status_effect::status_effect_apply( var_7444953c, weapon, level.vh_town_square_apc, undefined, 2000, undefined, v_end_pos );
        level function_b8b3d2aa();
    }
    else
    {
        level.player status_effect::status_effect_apply( var_7444953c, weapon, level.vh_town_square_apc, undefined, 2000, undefined, v_end_pos );
        wait 1;
    }
    
    level.player util::blend_movespeedscale( 0.9, 1 );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0x10996122, Offset: 0x2c98
// Size: 0x16c
function function_b8b3d2aa( *var_ab3e25a2 )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level.player playgestureviewmodel( #"hash_122fc8a38a46356a" );
    level.player val::set( "facades_flinch", "allow_sprint", 0 );
    var_711343eb = level.player getnormalhealth() * 0.8;
    level.player setnormalhealth( var_711343eb );
    wait 0.5;
    level.player waittilltimeout( 1, #"sprint" );
    level.player stopgestureviewmodel( #"hash_122fc8a38a46356a" );
    wait 0.5;
    level.player val::reset( "facades_flinch", "allow_sprint" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0x12651fc9, Offset: 0x2e10
// Size: 0x94
function function_3c9f8a88( *str_objective )
{
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_rooftops", 0, 0 );
    level flag::set( "flg_facades_enemies_most_dead" );
    level flag::set( "flg_facades_dropdown" );
    level thread namespace_fc3e8cb::function_f87024e0( "nd_vh_town_square_apc_rooftops_start", "los_player" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 2
// Checksum 0xd444a2c0, Offset: 0x2eb0
// Size: 0xfc
function rooftops_main( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    savegame::checkpoint_save( 1 );
    level thread function_c691e305( "s_obj_rooftops_breadcrumb" );
    level thread function_842a66a1();
    level thread function_da6ccedc();
    level thread function_999d0913();
    level thread function_b3e9c19d();
    level flag::wait_till( "flg_rooftops_end" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 4
// Checksum 0xb579a53, Offset: 0x2fb8
// Size: 0x6c
function function_21fbbfb2( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    if ( !isdefined( level.vh_escape_apc ) )
    {
        level.vh_escape_apc = vehicle::simple_spawn_single( "vh_escape_apc" );
    }
    
    level.vh_escape_apc util::magic_bullet_shield();
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x99a5f25e, Offset: 0x3030
// Size: 0x144
function function_842a66a1()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level.player util::blend_movespeedscale_default( 1 );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_rooftops_woods_start" );
    level flag::wait_till( "flg_rooftops_start" );
    level.woods clearforcedgoal();
    level thread namespace_4bd68414::function_c948bfdd();
    level.woods colors::set_force_color( "blue" );
    level flag::wait_till( "flg_rooftops_approaching_exit" );
    level.woods colors::disable();
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_bank_woods_start" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xb818f7c3, Offset: 0x3180
// Size: 0x484
function function_da6ccedc()
{
    level thread scene::init( "rooftops_rappel_scene", "targetname" );
    level flag::wait_till( "flg_rooftops_start" );
    level thread scene::play( "rooftops_rappel_scene", "targetname" );
    level thread namespace_fc3e8cb::function_fa5905d0( "s_rooftops_heli_lights" );
    println( "<dev string:x51>" );
    var_653186e7 = spawner::simple_spawn( "ai_enemy_rooftops" );
    var_1ea2c1da = getaiarray( "ai_rooftops_rappel_group", "targetname" );
    level thread function_266d11ca( var_1ea2c1da );
    var_653186e7 = arraycombine( var_653186e7, var_1ea2c1da );
    level thread namespace_fc3e8cb::function_85939627( var_653186e7, "flg_rooftops_enemies_most_dead", var_653186e7.size - 1 );
    var_63d2d7ec = level flag::wait_till_any( [ "flg_rooftops_advance_right_high", "flg_rooftops_advance_right_low", "flg_rooftops_advance_center", "flg_rooftops_advance_left", "flg_rooftops_enemies_most_dead" ] );
    println( "<dev string:x6b>" );
    var_41419b58 = spawner::simple_spawn( "ai_enemy_rooftops_add_1", &function_bd70a66d );
    var_4c08b0e6 = spawner::simple_spawn( "ai_enemy_rooftops_add_2" );
    var_653186e7 = arraycombine( var_653186e7, var_41419b58 );
    var_653186e7 = arraycombine( var_653186e7, var_4c08b0e6 );
    level thread namespace_fc3e8cb::function_85939627( var_653186e7, "flg_rooftops_enemies_dead", var_653186e7.size );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_storage_advance_1", var_653186e7 );
    level thread namespace_fc3e8cb::function_940ffdb0( [ "flg_rooftops_advance_right_end", "flg_rooftops_advance_left_end" ], var_653186e7, "vol_rooftops_enemy_exit", 2 );
    
    if ( var_63d2d7ec._notify === #"flg_rooftops_advance_right_high" )
    {
        level thread namespace_fc3e8cb::function_8e158d78( var_41419b58, "vol_rooftops_enemy_balcony", undefined, 0 );
        level thread namespace_fc3e8cb::function_8e158d78( var_4c08b0e6, "vol_rooftops_enemy_left", undefined, 0 );
    }
    else if ( var_63d2d7ec._notify === #"flg_rooftops_advance_right_low" || var_63d2d7ec._notify === #"flg_rooftops_advance_left" )
    {
        level thread namespace_fc3e8cb::function_8e158d78( var_41419b58, "vol_rooftops_enemy_balcony", undefined, 0 );
        level thread namespace_fc3e8cb::function_8e158d78( var_4c08b0e6, "vol_rooftops_enemy_right", undefined, 0 );
    }
    else
    {
        level thread namespace_fc3e8cb::function_8e158d78( var_41419b58, "vol_rooftops_enemy_balcony", undefined, 0 );
        level thread namespace_fc3e8cb::function_8e158d78( var_4c08b0e6, "vol_rooftops_enemy_exit", undefined, 0 );
    }
    
    var_78d92c9 = getentarray( "t_rooftops_advance_2", "targetname" );
    array::delete_all( var_78d92c9 );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0x1d74502a, Offset: 0x3610
// Size: 0x1e4
function function_266d11ca( var_1ea2c1da )
{
    function_1eaaceab( var_1ea2c1da );
    
    foreach ( index, ai in var_1ea2c1da )
    {
        switch ( index )
        {
            case 0:
                vol = getent( "vol_rooftops_enemy_right", "targetname" );
                break;
            case 1:
                vol = getent( "vol_rooftops_enemy_left", "targetname" );
                break;
            default:
                vol = getent( "vol_rooftops_enemy_back", "targetname" );
                break;
        }
        
        ai thread namespace_fc3e8cb::function_a7c9ed68( vol, 1 );
    }
    
    wait 1;
    s_rooftops_smoke = struct::get( "s_rooftops_smoke", "targetname" );
    level.player magicgrenadeplayer( getweapon( #"willy_pete" ), s_rooftops_smoke.origin, ( 0, 0, 0 ) );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x3c585a80, Offset: 0x3800
// Size: 0x7c
function function_bd70a66d()
{
    self endon( #"death" );
    level flag::wait_till_any( [ "flg_rooftops_advance_right_end", "flg_rooftops_advance_left_end" ] );
    self ai::set_goal( "vol_rooftops_enemy_exit", "targetname", 1 );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xe74e567c, Offset: 0x3888
// Size: 0x154
function function_b3e9c19d()
{
    level flag::wait_till( "flg_rooftops_start" );
    s_mb_start = struct::get( "s_rooftops_mannequin_mb_start", "targetname" );
    var_ea066846 = struct::get( "s_rooftops_mannequin_mb_end", "targetname" );
    var_a75f2965 = getweapon( #"frag_grenade" );
    var_1da2248f = spawn( "script_model", s_mb_start.origin );
    var_38ffd5df = vectornormalize( var_ea066846.origin - s_mb_start.origin ) * 400;
    e_grenade = var_1da2248f magicgrenadetype( var_a75f2965, s_mb_start.origin, var_38ffd5df, 1.5 );
    var_1da2248f deletedelay();
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xc6b2d8fd, Offset: 0x39e8
// Size: 0x5c
function function_999d0913()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level.vh_town_square_apc hms_util::function_c21ef1d8( "los_player" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xb4b76e12, Offset: 0x3a50
// Size: 0x1c
function function_a5be8514()
{
    self flashlight::function_7c2f623b();
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0x3f9a8, Offset: 0x3a78
// Size: 0x4c
function function_69d1435d( *str_objective )
{
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_storage", 0, 0 );
    level thread namespace_fc3e8cb::function_f87024e0( "nd_vh_town_square_apc_storage_start" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 2
// Checksum 0x4601cf60, Offset: 0x3ad0
// Size: 0xfc
function function_f13abd77( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    savegame::checkpoint_save( 1 );
    level thread function_c691e305( "s_obj_storage_breadcrumb" );
    level thread function_832279f3();
    level thread function_502e3f72();
    level thread function_502e1c27();
    level thread function_d505ce28();
    level flag::wait_till( "flg_storage_end" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 4
// Checksum 0x2d4444ea, Offset: 0x3bd8
// Size: 0x54
function function_80555a03( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    level thread namespace_fc3e8cb::function_6fe40e14( "storage_gun_rack4", "storage_gun_rack5", "storage_gun_rack6" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x1e051b82, Offset: 0x3c38
// Size: 0x1ca
function function_832279f3()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level thread namespace_4bd68414::function_be7fb8d0();
    level.woods.grenadeammo = 0;
    nd_target = getnode( "nd_motor_pool_woods_start", "targetname" );
    level.woods thread hms_util::function_2f50100e( "stay_even", nd_target.origin, "end_woods_storage_follow" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_bank_woods_start" );
    level flag::wait_till( "flg_bank_destruction_play" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_storage_woods_bank" );
    level flag::wait_till( "flg_storage_advance_1" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_storage_woods_corridor" );
    level flag::wait_till( "flg_storage_advance_2" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_storage_woods_end" );
    level.woods notify( #"end_woods_storage_follow" );
    level.woods.grenadeammo = 99;
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xd632af29, Offset: 0x3e10
// Size: 0x254
function function_502e3f72()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    var_b8e95930 = struct::get_array( "s_storage_apc_bank_target", "targetname" );
    var_b8e95930 = array::sort_by_script_int( var_b8e95930, 1 );
    level.vh_town_square_apc hms_util::function_c21ef1d8( "scripted", var_b8e95930[ 0 ].origin );
    level.vh_town_square_apc.aim_only_no_shooting = 1;
    level flag::wait_till( "flg_bank_destruction_play" );
    level.vh_town_square_apc.var_21c17c08 thread namespace_4bd68414::function_d6d8868f();
    level.vh_town_square_apc.aim_only_no_shooting = undefined;
    level.vh_town_square_apc thread namespace_fc3e8cb::function_a57ce26d( var_b8e95930, "end_facades_intro_fake_shooting" );
    level.vh_town_square_apc turret::function_aecc6bed( var_b8e95930, 1, 0, 0.2 );
    level.vh_town_square_apc notify( #"end_facades_intro_fake_shooting" );
    exploder::exploder( "fx_bank_lingering_dust" );
    level.vh_town_square_apc hms_util::function_c21ef1d8( "shoot_player" );
    var_e2720fa8 = struct::get_array( "s_bank_apc_target_mannequin", "targetname" );
    array::thread_all( var_e2720fa8, &namespace_fc3e8cb::function_649019cf, "flg_storage_end" );
    level flag::wait_till( "flg_storage_advance_1" );
    wait 1;
    level.vh_town_square_apc hms_util::function_c21ef1d8( "los_player" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0xe31c6e54, Offset: 0x4070
// Size: 0x7c
function function_36c18ca( *str_objective )
{
    level thread function_502e1c27();
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_motor_pool", 0, 0 );
    level thread function_d505ce28();
    level thread namespace_fc3e8cb::function_f87024e0( "nd_vh_town_square_apc_storage_start" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 2
// Checksum 0x8a3ddf58, Offset: 0x40f8
// Size: 0x144
function function_3b55ec61( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    level thread function_1ec720d1();
    level thread function_f197858e();
    level thread function_b415da85();
    level thread function_c8c76a4f();
    level thread function_7f87d6ab();
    level thread function_7824cd0c();
    level thread function_14fb9b43();
    level flag::wait_till_any( [ "flg_escape_apc_interact_triggered", "flg_motor_pool_all_enemies_dead" ] );
    level flag::set( "flg_motor_pool_end" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 4
// Checksum 0xb2a90d69, Offset: 0x4248
// Size: 0x5c
function function_b78a9ad4( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    level thread function_d505ce28( 1 );
    level flag::set( "flg_motor_pool_giant_doors_closed" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x875c0a9e, Offset: 0x42b0
// Size: 0x214
function function_1ec720d1()
{
    s_obj_motor_pool_exit = struct::get( "s_obj_motor_pool_exit", "targetname" );
    objectives::goto( "obj_motor_pool_exit", s_obj_motor_pool_exit.origin, #"hash_25ceb846d38703d" );
    level flag::wait_till( "flg_motor_pool_enemies_notice_player" );
    wait 3;
    objectives::complete( "obj_motor_pool_exit" );
    var_cb754cc9 = getaiarray( "ai_juggernaut_motor_pool", "targetname" );
    level thread namespace_fc3e8cb::function_85939627( var_cb754cc9, "flg_motor_pool_all_enemies_dead" );
    objectives::kill( "obj_motor_pool_kill_all", var_cb754cc9, #"hash_5139e3b2c7df628" );
    level flag::wait_till_any( [ "flg_motor_pool_all_enemies_dead", "flg_motor_pool_end" ] );
    objectives::complete( "obj_motor_pool_kill_all" );
    s_obj_motor_pool_apc = struct::get( "s_obj_motor_pool_apc", "targetname" );
    objectives::goto( "obj_motor_pool_apc", s_obj_motor_pool_apc.origin, #"hash_1ef0e93b7e6fa136" );
    level flag::wait_till( "flg_motor_pool_end" );
    
    if ( level flag::get( "flg_escape_apc_interact_triggered" ) == 1 )
    {
        objectives::complete( "obj_motor_pool_apc" );
    }
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xfa85c31b, Offset: 0x44d0
// Size: 0xdc
function function_f197858e()
{
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_motorpool_alarm", 1 );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_perf_townsquare_keys", 1 );
    level flag::wait_till( "flg_motor_pool_enemies_notice_player" );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_motorpool_alarm", 0 );
    level waittill( #"hash_2bce2e22f84ebf05" );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_motorpool_closed_state", 0 );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_motorpool_intermediate_state", 0 );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xcb492550, Offset: 0x45b8
// Size: 0x33c
function function_b415da85()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level thread namespace_4bd68414::function_7dec07c8();
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_storage_woods_end" );
    level.woods ai::function_3a5e9945( 1 );
    level.woods namespace_fc3e8cb::function_4171ba27();
    level flag::wait_till( "flg_motor_pool_door_player_interact" );
    
    if ( level flag::get( "flg_storage_woods_at_exit" ) == 0 )
    {
        nd_storage_woods_end = getnode( "nd_storage_woods_end", "targetname" );
        level.woods forceteleport( nd_storage_woods_end.origin, nd_storage_woods_end.angles );
    }
    
    level flag::wait_till( "flg_motor_pool_entry_door_open" );
    savegame::checkpoint_save( 1 );
    level thread namespace_4bd68414::function_a7f9c372();
    level.woods ai::function_3a5e9945( 0 );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_motor_pool_woods_door" );
    level flag::wait_till( "flg_motor_pool_enemies_notice_player" );
    level.woods clearforcedgoal();
    level.woods ai::enable_careful();
    level.woods colors::set_force_color( "blue" );
    level thread function_41ffe14();
    level thread namespace_4bd68414::function_6e5fd7a7();
    level flag::wait_till( "flg_motor_pool_close_doors" );
    level.woods namespace_fc3e8cb::function_d74bffa7();
    level thread namespace_4bd68414::function_3bcf30f9();
    level flag::wait_till( "flg_motor_pool_end" );
    level.woods colors::disable();
    level.woods ai::disable_careful();
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_apc_turret_woods_start", 0, 1 );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xc845684b, Offset: 0x4900
// Size: 0x2f4
function function_41ffe14()
{
    level endon( #"flg_motor_pool_end" );
    level flag::wait_till_any( [ "flg_motor_pool_left_path", "flg_motor_pool_right_path" ] );
    
    if ( level flag::get( "flg_motor_pool_right_path" ) == 1 )
    {
        trigger::use( "t_motor_pool_right_path_1", "targetname" );
        level flag::wait_till( "flg_motor_pool_advance_1" );
        trigger::use( "t_motor_pool_right_path_2", "targetname" );
        level flag::wait_till( "flg_motor_pool_advance_2" );
        trigger::use( "t_motor_pool_right_path_3", "targetname" );
        level flag::wait_till( "flg_motor_pool_advance_3" );
        trigger::use( "t_motor_pool_right_path_4", "targetname" );
        level flag::wait_till_all( [ "flg_motor_pool_advance_4", "flg_motor_pool_all_juggernauts_dead" ] );
        trigger::use( "t_motor_pool_right_path_5", "targetname" );
        return;
    }
    
    trigger::use( "t_motor_pool_left_path_1", "targetname" );
    level flag::wait_till( "flg_motor_pool_advance_1" );
    trigger::use( "t_motor_pool_left_path_2", "targetname" );
    level flag::wait_till( "flg_motor_pool_advance_2" );
    trigger::use( "t_motor_pool_left_path_3", "targetname" );
    level flag::wait_till( "flg_motor_pool_advance_3" );
    trigger::use( "t_motor_pool_left_path_4", "targetname" );
    level flag::wait_till_all( [ "flg_motor_pool_advance_4", "flg_motor_pool_all_juggernauts_dead" ] );
    trigger::use( "t_motor_pool_left_path_5", "targetname" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xed698d47, Offset: 0x4c00
// Size: 0x6cc
function function_c8c76a4f()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_escape_apc_interact_triggered" );
    vol_motor_pool_badplace = getentarray( "vol_motor_pool_badplace", "targetname" );
    array::thread_all( vol_motor_pool_badplace, &function_66da7c94 );
    level flag::wait_till( "flg_motor_pool_entry_door_open" );
    println( "<dev string:x89>" );
    var_892fa6d3 = spawner::simple_spawn( "ai_enemy_motor_jugg_escort", &function_748fc350 );
    var_b1c1e2d0 = getaiteamarray( "axis" );
    level thread namespace_fc3e8cb::function_ffc69c66( "vh_motor_pool_truck_1", undefined, "flg_apc_ride_town_square_exit", 0 );
    var_caac7c01 = getvehiclearray( "vh_motor_pool_truck_1", "targetname" )[ 0 ];
    snd::client_targetname( var_caac7c01, "audio_motorpool_truck_01" );
    level thread function_e2783665();
    level thread namespace_fc3e8cb::function_85939627( var_b1c1e2d0, "flg_motor_pool_initial_enemies_dead", var_b1c1e2d0.size );
    level thread namespace_fc3e8cb::function_85939627( var_b1c1e2d0, "flg_motor_pool_most_enemies_dead", int( var_b1c1e2d0.size * 0.5 ) );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_apc_ride_town_square_crash", var_b1c1e2d0 );
    level thread namespace_fc3e8cb::function_940ffdb0( "flg_motor_pool_most_enemies_dead", var_b1c1e2d0 );
    level flag::wait_till( "flg_motor_pool_car_1_reached_end" );
    var_9323e12d = getaiarray( "sp_enemy_motor_pool_car_1", "targetname" );
    array::thread_all( var_9323e12d, &function_759dc847 );
    level flag::wait_till( "flg_motor_pool_car_2_reached_end" );
    var_2e4a977c = getaiarray( "sp_enemy_motor_pool_car_2", "targetname" );
    array::thread_all( var_2e4a977c, &function_759dc847 );
    level flag::wait_till_any_timeout( 20, [ "flg_motor_pool_advance_1" ] );
    level flag::set( "flg_motor_pool_enemies_notice_player" );
    var_b1c1e2d0 = getaiteamarray( "axis" );
    
    foreach ( index, ai in var_b1c1e2d0 )
    {
        if ( ai.targetname == "ai_juggernaut_motor_pool" )
        {
            arrayremoveindex( var_b1c1e2d0, index );
        }
        
        if ( isvehicle( ai ) )
        {
            arrayremoveindex( var_b1c1e2d0, index );
        }
    }
    
    var_b1c1e2d0 = array::get_all_closest( level.player.origin, var_b1c1e2d0 );
    
    foreach ( index, ai in var_b1c1e2d0 )
    {
        if ( isdefined( ai ) )
        {
            if ( index <= 3 )
            {
                ai ai::set_goal( "vol_motor_pool_front", "targetname" );
            }
            
            if ( index > 3 )
            {
                ai ai::set_goal( "vol_motor_pool_apc", "targetname" );
            }
            
            ai getenemyinfo( level.player );
            ai val::set( #"hash_3721168b725155fc", "ignoreme", 0 );
            ai val::set( #"hash_3721168b725155fc", "ignoreall", 0 );
            ai ai::set_behavior_attribute( "demeanor", "combat" );
            ai ai::set_pacifist( 0 );
            ai ai::function_3a5e9945( 0 );
            wait randomfloatrange( 0.5, 1.5 );
        }
    }
    
    level thread function_db7a929();
    level thread function_debf8314( var_b1c1e2d0 );
    level flag::wait_till_all( [ "flg_motor_pool_advance_3", "flg_motor_pool_all_juggernauts_dead", "flg_motor_pool_reinforcements_dead", "flg_motor_pool_initial_enemies_dead" ] );
    level flag::set( "flg_motor_pool_all_enemies_dead" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x88eb2dba, Offset: 0x52d8
// Size: 0xbc
function function_66da7c94()
{
    name = self.script_noteworthy;
    x = self.var_57e27c13;
    y = self.var_112f6eae;
    z = self.var_fb714332;
    badplace_box( name, 0, self.origin, ( x, y, z ), "axis" );
    level flag::wait_till( "flg_motor_pool_end" );
    badplace_delete( name );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0xf3490f0, Offset: 0x53a0
// Size: 0x108
function function_debf8314( ai_array )
{
    level flag::wait_till_all( [ "flg_motor_pool_most_enemies_dead", "flg_motor_pool_advance_3" ] );
    function_1eaaceab( ai_array );
    
    foreach ( ai in ai_array )
    {
        vol_fallback = getent( "vol_motor_pool_left", "targetname" );
        ai thread ai::force_goal( vol_fallback );
    }
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xf66d58ac, Offset: 0x54b0
// Size: 0x7c
function function_e2783665()
{
    wait 3;
    level thread namespace_fc3e8cb::function_ffc69c66( "vh_motor_pool_truck_2", undefined, "flg_apc_ride_town_square_exit", 0 );
    var_73da4e5e = getvehiclearray( "vh_motor_pool_truck_2", "targetname" )[ 0 ];
    snd::client_targetname( var_73da4e5e, "audio_motorpool_truck_02" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x77821cf8, Offset: 0x5538
// Size: 0xd4
function function_db7a929()
{
    level endon( #"flg_escape_player_in_apc" );
    level flag::wait_till_any( [ "flg_motor_pool_most_enemies_dead", "flg_motor_pool_advance_3", "flg_motor_pool_one_juggernaut_dead" ] );
    var_f201782a = spawner::simple_spawn( "ai_enemy_motor_pool_reinforcements", &function_25ec03fc );
    level thread namespace_fc3e8cb::function_85939627( var_f201782a, "flg_motor_pool_reinforcements_dead" );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_apc_ride_town_square_crash", var_f201782a );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xf5405b4a, Offset: 0x5618
// Size: 0x184
function function_748fc350()
{
    self endon( #"death" );
    self.grenadeammo = 0;
    self thread function_759dc847( "patrol" );
    level flag::wait_till( "flg_motor_pool_enemies_notice_player" );
    wait randomfloatrange( 0, 0.75 );
    self val::set( #"hash_3721168b725155fc", "ignoreme", 0 );
    self val::set( #"hash_3721168b725155fc", "ignoreall", 0 );
    self ai::set_behavior_attribute( "demeanor", "combat" );
    self ai::set_pacifist( 0 );
    self ai::set_goal( "vol_motor_pool_front" );
    level flag::wait_till( "flg_escape_apc_interact_triggered" );
    self ai::set_goal( "vol_motor_pool_gate" );
    self thread namespace_fc3e8cb::function_a9674e4a();
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xbc5aede7, Offset: 0x57a8
// Size: 0x74
function function_25ec03fc()
{
    self endon( #"death" );
    self.grenadeammo = 0;
    level flag::wait_till( "flg_escape_apc_interact_triggered" );
    self ai::set_goal( "vol_motor_pool_gate" );
    self thread namespace_fc3e8cb::function_a9674e4a();
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0xd49580d0, Offset: 0x5828
// Size: 0x1a4
function function_d505ce28( var_67ce64a8 = 0 )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level scene::init( "sc_motor_pool_giant_doors", "targetname" );
    level thread function_8d7a1baa();
    
    if ( var_67ce64a8 == 1 )
    {
        level scene::play_from_time( "sc_motor_pool_giant_doors", "targetname", undefined, 0.8 );
    }
    else
    {
        level flag::wait_till( "flg_motor_pool_close_doors" );
        level scene::play( "sc_motor_pool_giant_doors", "targetname" );
        s_obj_motor_pool_exit = struct::get( "s_obj_motor_pool_exit", "targetname" );
        level.player playrumbleonentity( "damage_light" );
        earthquake( 1, 0.5, s_obj_motor_pool_exit.origin, 1600 );
    }
    
    level flag::set( "flg_motor_pool_giant_doors_closed" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x4df5c59, Offset: 0x59d8
// Size: 0x24c
function function_8d7a1baa()
{
    level endon( #"flg_motor_pool_giant_doors_closed" );
    level flag::wait_till( "flg_motor_pool_exit_kill" );
    v_fwd = anglestoforward( level.player getplayerangles() );
    var_1c8839e = level.player geteye() + v_fwd * -80;
    a_enemies = getaiarray( "ai_juggernaut_motor_pool", "targetname" );
    
    if ( a_enemies.size <= 0 )
    {
        a_enemies = getaiteamarray( "axis" );
        
        foreach ( index, ai in a_enemies )
        {
            if ( isvehicle( ai ) )
            {
                arrayremoveindex( a_enemies, index );
            }
        }
    }
    
    if ( a_enemies.size > 0 )
    {
        a_enemies = arraysortclosest( a_enemies, level.player.origin );
        magicbullet( getweapon( #"hash_228ab35af2dae712" ), var_1c8839e, level.player geteye(), a_enemies[ 0 ] );
    }
    
    level.player util::stop_magic_bullet_shield();
    level.player kill();
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xfd1a81c6, Offset: 0x5c30
// Size: 0x15c
function function_14fb9b43()
{
    assert( isdefined( level.vh_escape_apc ) );
    a_scene_ents[ #"apc" ] = level.vh_escape_apc;
    level thread scene::init( "scene_amk_7010_esc_apc_enter", a_scene_ents );
    var_f9b7abd8 = struct::get( "s_escape_apc_player_interact" );
    var_f9b7abd8 util::create_cursor_hint( undefined, undefined, #"hash_394eef05c5d5cf3b", 90, 0.5, undefined, #"use", 400, undefined, 0, 0 );
    var_f9b7abd8 prompts::function_5698d1c9( #"use", 45 );
    var_f9b7abd8 waittill( #"trigger" );
    level flag::set( "flg_escape_apc_interact_triggered" );
    var_f9b7abd8 util::delay( 0.2, undefined, &util::remove_cursor_hint );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x3e0802f7, Offset: 0x5d98
// Size: 0x13c
function function_7f87d6ab()
{
    level flag::wait_till( "flg_motor_pool_entry_door_open" );
    var_69297501 = spawner::simple_spawn( "ai_juggernaut_motor_pool" );
    level thread namespace_fc3e8cb::function_85939627( var_69297501, "flg_motor_pool_one_juggernaut_dead", 1 );
    level thread namespace_fc3e8cb::function_85939627( var_69297501, "flg_motor_pool_all_juggernauts_dead", var_69297501.size );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_apc_ride_town_square_crash", var_69297501 );
    level array::thread_all( var_69297501, &function_1b30661c );
    level flag::wait_till( "flg_motor_pool_enemies_notice_player" );
    var_69297501[ 0 ] namespace_631d466b::function_90791fca( var_69297501[ 1 ] );
    var_69297501[ 1 ] namespace_631d466b::function_90791fca( var_69297501[ 0 ] );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xa7906af1, Offset: 0x5ee0
// Size: 0x246
function function_1b30661c()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self namespace_631d466b::function_712776a6( 1 );
    s_motor_pool_jugpos_front = struct::get( "s_motor_pool_jugpos_front" );
    s_motor_pool_jugpos_mid = struct::get( "s_motor_pool_jugpos_mid" );
    s_motor_pool_jugpos_back = struct::get( "s_motor_pool_jugpos_back" );
    s_motor_pool_jugpos_turret = struct::get( "s_motor_pool_jugpos_turret" );
    s_motor_pool_jugpos_paths = struct::get( "s_motor_pool_jugpos_paths" );
    s_motor_pool_jugpos_intro = struct::get( "s_motor_pool_jugpos_intro" );
    var_63f3845d = struct::get( "motor_pool_jugpos_intro_mid" );
    
    if ( self.script_noteworthy === "ai_juggernaut_motor_pool_front" )
    {
        self setgoal( s_motor_pool_jugpos_intro.origin, 1, 48, 128 );
    }
    else
    {
        self setgoal( var_63f3845d.origin, 1, undefined, undefined, var_63f3845d.angles );
    }
    
    level flag::wait_till( "flg_motor_pool_enemies_notice_player" );
    self namespace_631d466b::function_712776a6( 0 );
    
    if ( self.script_noteworthy == "ai_juggernaut_motor_pool_front" )
    {
        self namespace_631d466b::function_6aedb63( s_motor_pool_jugpos_paths.origin, s_motor_pool_jugpos_paths.radius, s_motor_pool_jugpos_paths.var_ed151f4c );
    }
    else
    {
        self thread function_90feef7e( s_motor_pool_jugpos_mid );
    }
    
    self.favoriteenemy = level.player;
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0xc106f165, Offset: 0x6130
// Size: 0x84
function function_90feef7e( goal_struct )
{
    self namespace_631d466b::function_6aedb63( goal_struct.origin, goal_struct.radius );
    self namespace_631d466b::function_f94404c3( 1 );
    level flag::wait_till( "flg_motor_pool_car_2_reached_end" );
    self namespace_631d466b::function_f94404c3( 0 );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x78ced800, Offset: 0x61c0
// Size: 0xcc
function function_1edc596e()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"death", #"damage", #"flg_motor_pool_enemies_notice_player" );
    
    while ( true )
    {
        if ( self cansee( level.player ) )
        {
            break;
        }
        
        wait 0.5;
    }
    
    wait 1;
    level flag::set( "flg_motor_pool_enemies_notice_player" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0x14ba05fc, Offset: 0x6298
// Size: 0x104
function function_7824cd0c()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"flg_motor_pool_enemies_notice_player" );
    var_b4767ac9 = level.player waittill( #"weapon_fired", #"grenade_fire", #"offhand_fire" );
    
    if ( var_b4767ac9._notify === #"grenade_fire" )
    {
        wait 2;
    }
    else if ( var_b4767ac9._notify === #"offhand_fire" )
    {
        wait 1;
    }
    
    level flag::set( "flg_motor_pool_enemies_notice_player" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0x6c6a551f, Offset: 0x63a8
// Size: 0xb4
function function_759dc847( var_5207b7a8 = "cqb" )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    self ai::set_behavior_attribute( "demeanor", var_5207b7a8 );
    self ai::set_pacifist( 1 );
    s_goal = struct::get( self.script_noteworthy, "targetname" );
    
    if ( isdefined( s_goal ) )
    {
        self spawner::go_to_struct( s_goal );
    }
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xacf259ad, Offset: 0x6468
// Size: 0x2cc
function function_502e1c27()
{
    level scene::init( "sc_motor_pool_entry_door" );
    s_obj_motor_pool_door_interact = struct::get( "s_obj_motor_pool_door_interact", "targetname" );
    s_obj_motor_pool_door_interact util::create_cursor_hint( undefined, undefined, #"hash_737d6de260985ae3", 60 );
    s_obj_motor_pool_door_interact prompts::function_5698d1c9( #"use", 45 );
    s_obj_motor_pool_door_interact waittill( #"trigger" );
    
    /#
        hms_util::print( "<dev string:xa5>" );
    #/
    
    level thread function_3297dd11();
    level namespace_2977687d::scene_amk_6090_stg_garage();
    snd::client_msg( "audio_motor_pool_rollup_door" );
    level flag::set( "flg_motor_pool_door_player_interact" );
    level scene::play( "sc_motor_pool_entry_door", "Open" );
    s_obj_motor_pool_door_interact util::delay( 0.2, undefined, &util::remove_cursor_hint );
    level flag::set( "flg_motor_pool_entry_door_open" );
    var_6c4841fb = getent( "sm_motor_pool_entry_door", "targetname" );
    var_6c4841fb movey( -256, 0.1, 0.05, 0.05 );
    var_6c4841fb connectpaths();
    level flag::wait_till( "flg_motor_pool_close_doors" );
    var_6c4841fb movey( 256, 0.1, 0.05, 0.05 );
    var_6c4841fb disconnectpaths();
    level scene::play( "sc_motor_pool_entry_door", "Close" );
    snd::client_msg( "audio_motor_pool_rollup_door" );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 0
// Checksum 0xfac48e3c, Offset: 0x6740
// Size: 0x18c
function function_3297dd11()
{
    ai_guard = spawner::simple_spawn_single( "motor_pool_entry_guard" );
    ai_guard.grenadeammo = 0;
    ai_guard.health = 10;
    ai_guard endoncallback( &function_217b2fe2, #"death", #"takedown_executed" );
    ai_guard ai::set_behavior_attribute( "demeanor", "patrol" );
    ai_guard thread function_1edc596e();
    ai_guard waittilltimeout( 10, #"flg_motor_pool_enemies_notice_player" );
    s_goal = struct::get( "motor_pool_entry_guard_dest" );
    ai_guard setgoal( level.player, 0, 16 );
    s_waitresult = ai_guard waittilltimeout( 2, #"flg_motor_pool_enemies_notice_player" );
    ai_guard ai::set_behavior_attribute( "demeanor", "combat" );
    ai_guard setgoal( level.player, 0, 1000 );
}

// Namespace namespace_4c1dd357/namespace_528e5ceb
// Params 1
// Checksum 0xcf7ffabd, Offset: 0x68d8
// Size: 0xdc
function function_217b2fe2( str_notify )
{
    if ( str_notify == "takedown_executed" )
    {
        var_2878dc27 = [ "vox_cp_amrk_01200_svs1_intruder_6e", "vox_cp_amrk_01200_svs1_ineedbackup_dc", "vox_cp_amrk_01200_svs1_enemyspotted_42", "vox_cp_amrk_01200_svs1_callforbackup_9a", "vox_cp_amrk_01200_svs1_anintruder_5d" ];
        wait 1;
        self hms_util::dialogue( array::random( var_2878dc27 ) );
        wait 0.5;
    }
    else
    {
        wait 2;
    }
    
    level flag::set( "flg_motor_pool_enemies_notice_player" );
}

