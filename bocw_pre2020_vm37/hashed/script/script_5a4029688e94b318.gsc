#using script_155b17ff7c8b315c;
#using script_3dc93ca9902a9cda;
#using script_4489198b8bcf36e8;
#using script_57d05cf093ffba5c;
#using script_77d064824b2c820c;
#using script_97b74052c477c23;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\debug_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\debug;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace namespace_80316bc8;

// Namespace namespace_80316bc8/namespace_5675011e
// Params 1
// Checksum 0x8e133630, Offset: 0xe90
// Size: 0xc4
function function_757efcb6( *str_objective )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_apc_turret", 1, 0 );
    level thread namespace_fc3e8cb::function_f87024e0( "nd_vh_town_square_apc_storage_start" );
    level thread namespace_4c1dd357::function_14fb9b43();
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_motorpool_door", 1 );
    level thread namespace_f6d09d1a::function_7b9feaa3( "lgtexp_perf_townsquare_keys", 1 );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 2
// Checksum 0x7f8bc5a1, Offset: 0xf60
// Size: 0xe4
function function_6bd1bb5a( str_objective, *var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( var_50cc0d4f );
    #/
    
    level thread function_32e0dc9e();
    level thread function_a72ad13b();
    level thread function_25d1af15();
    level thread function_a1756ca0();
    level.vh_town_square_apc hms_util::function_c21ef1d8( "suspend" );
    level flag::wait_till( "flg_apc_turret_end" );
    skipto::function_4e3ab877( var_50cc0d4f );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 4
// Checksum 0x20691dc4, Offset: 0x1050
// Size: 0x24
function function_54337d3f( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xff440e65, Offset: 0x1080
// Size: 0x17c
function function_32e0dc9e()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    
    if ( level flag::get( "flg_escape_player_in_apc" ) == 0 )
    {
        if ( !isdefined( objectives::function_285e460( "obj_motor_pool_apc" ) ) )
        {
            s_obj_motor_pool_apc = struct::get( "s_obj_motor_pool_apc", "targetname" );
            objectives::function_4eb5c04a( "obj_motor_pool_apc", s_obj_motor_pool_apc.origin, #"hash_1ef0e93b7e6fa136" );
            id = objectives::function_285e460( "obj_motor_pool_apc" );
            thread objectives_ui::function_f3ac479c( id );
            level.player thread objectives_ui::show_objectives();
            level flag::wait_till( "flg_escape_apc_interact_triggered" );
            objectives::complete( "obj_motor_pool_apc" );
            return;
        }
        
        thread objectives_ui::function_1c6b4aeb();
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x93785a63, Offset: 0x1208
// Size: 0x114
function function_25d1af15()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level thread namespace_fc3e8cb::function_5c5b6ea7( "nd_apc_turret_woods_start" );
    level flag::wait_till( "flg_escape_player_in_apc" );
    
    if ( level flag::get( "flg_escape_woods_driving_apc" ) == 0 )
    {
        level thread namespace_4bd68414::function_1569400a();
    }
    
    level flag::wait_till( "flg_escape_woods_driving_apc" );
    level namespace_4bd68414::function_bcf74cb9();
    level flag::set( "flg_apc_turret_end" );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xfb689dfe, Offset: 0x1328
// Size: 0x1ec
function function_a1756ca0()
{
    level flag::wait_till( "flg_escape_apc_interact_triggered" );
    wait 3;
    var_6e070da0 = [];
    println( "<dev string:x38>" );
    var_71ee249b = spawner::simple_spawn( "ai_enemy_apc_turret_jugg", &function_ae02d927 );
    var_ed0d3599 = spawner::simple_spawn( "ai_enemy_apc_turret_1", &namespace_fc3e8cb::function_a9674e4a );
    level flag::wait_till( "flg_escape_player_in_apc" );
    var_fe67584d = spawner::simple_spawn( "ai_enemy_apc_turret_2", &namespace_fc3e8cb::function_a9674e4a );
    level flag::wait_till( "flg_apc_ride_town_square_start" );
    var_10b7fcee = spawner::simple_spawn( "ai_enemy_apc_turret_3", &namespace_fc3e8cb::function_a9674e4a );
    arraycombine( var_6e070da0, var_71ee249b );
    arraycombine( var_6e070da0, var_ed0d3599 );
    arraycombine( var_6e070da0, var_fe67584d );
    arraycombine( var_6e070da0, var_10b7fcee );
    function_1eaaceab( var_6e070da0 );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_apc_ride_town_square_crash", var_6e070da0 );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xcc7210b2, Offset: 0x1520
// Size: 0x29c
function function_ae02d927()
{
    level flag::wait_till( "all_players_spawned" );
    level.player endon( #"death" );
    self endon( #"death" );
    s_start = struct::get( "s_" + self.script_noteworthy + "_start", "targetname" );
    s_end = struct::get( "s_" + self.script_noteworthy + "_end", "targetname" );
    s_move = struct::get( "s_" + self.script_noteworthy + "_move", "targetname" );
    self.health = 100;
    self.grenadeammo = 0;
    self thread namespace_fc3e8cb::function_8065702();
    self ai::set_pacifist( 1 );
    self.holdfire = 1;
    self setentitytarget( level.vh_escape_apc );
    self namespace_631d466b::function_6aedb63( s_start.origin, s_start.radius );
    level flag::wait_till( "flg_escape_player_in_apc" );
    self namespace_631d466b::function_efd568bc( s_end.origin, s_end.radius );
    self ai::set_pacifist( 0 );
    self.holdfire = 0;
    self thread namespace_631d466b::function_eaf1039d( randomfloatrange( 3, 5 ) );
    wait randomfloatrange( 1, 3 );
    
    if ( isdefined( s_move ) )
    {
        self namespace_631d466b::function_6aedb63( s_move.origin, s_move.radius );
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x5850701e, Offset: 0x17c8
// Size: 0x64
function function_a72ad13b()
{
    if ( !isdefined( level.vh_escape_apc ) )
    {
        level.vh_escape_apc = vehicle::simple_spawn_single( "vh_escape_apc" );
    }
    
    level.vh_escape_apc util::magic_bullet_shield();
    level function_47e3ca7b();
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x32936f48, Offset: 0x1838
// Size: 0x21c
function function_47e3ca7b()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    assert( isdefined( level.woods ) && isdefined( level.vh_escape_apc ) );
    
    if ( flag::get( "flg_escape_apc_interact_triggered" ) )
    {
        level function_14d0be04( 1 );
        level thread namespace_4bd68414::function_1da50f50();
        level function_eec2fa5b( 1 );
        return;
    }
    
    do
    {
        var_9b647c99 = distance2dsquared( level.player.origin, level.vh_escape_apc.origin ) < 640000;
        var_82e1e4b = util::within_fov( level.player getplayercamerapos(), level.player getplayerangles(), level.vh_escape_apc.origin, 0.5 );
        wait 0.5;
    }
    while ( !( var_9b647c99 && var_82e1e4b ) );
    
    level thread namespace_4bd68414::function_616aaf6e();
    level thread function_eec2fa5b();
    level flag::wait_till( "flg_escape_apc_interact_triggered" );
    level function_14d0be04( 0 );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 1
// Checksum 0x7c93409b, Offset: 0x1a60
// Size: 0x1b4
function function_eec2fa5b( *var_bd98a2b8 )
{
    level.woods val::set( #"apc_enter", "ignoreall", 1 );
    level.woods val::set( #"apc_enter", "ignoreme", 1 );
    a_scene_ents[ #"woods" ] = level.woods;
    a_scene_ents[ #"apc" ] = level.vh_escape_apc;
    level scene::play( "scene_amk_7010_esc_apc_enter", "woods_enter_apc", a_scene_ents );
    level thread scene::play( "scene_amk_7010_esc_apc_enter", "woods_loop_apc", a_scene_ents );
    waitframe( 1 );
    level.woods linkto( level.vh_escape_apc );
    level.woods val::reset( #"apc_enter", "ignoreall" );
    level.woods val::reset( #"apc_enter", "ignoreme" );
    level flag::set( "flg_escape_woods_driving_apc" );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 1
// Checksum 0x921e5687, Offset: 0x1c20
// Size: 0x1c4
function function_14d0be04( var_c6dacd13 = 0 )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    n_wait_time = var_c6dacd13 ? 0 : 3;
    level thread function_405fd6a( n_wait_time );
    level.player val::set( #"hash_23d795e7301fe7d2", "disable_weapons", 1 );
    level.player val::set( #"hash_23d795e7301fe7d2", "freezecontrols_allowlook", 1 );
    wait 0.5;
    level scene::play( "scene_amk_7010_esc_apc_enter_plr", "player_enter_apc" );
    level.player val::reset_all( #"hash_23d795e7301fe7d2" );
    level.vh_escape_apc usevehicle( level.player, 1 );
    setdvar( #"vehicle_selfcollision", 1 );
    level flag::set( "flg_escape_player_in_apc" );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 1
// Checksum 0x7f27eb96, Offset: 0x1df0
// Size: 0xcc
function function_405fd6a( n_wait_time )
{
    var_e09d191e = level scene::is_ready( "scene_amk_7010_esc_apc_enter" );
    var_89f9e30f = level flag::get( "flg_escape_woods_driving_apc" );
    
    if ( var_e09d191e || var_89f9e30f )
    {
        return;
    }
    
    wait n_wait_time;
    nd_apc_turret_woods_start = getnode( "nd_apc_turret_woods_start", "targetname" );
    level.woods forceteleport( nd_apc_turret_woods_start.origin );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 1
// Checksum 0x7ea9529f, Offset: 0x1ec8
// Size: 0x14c
function function_7da641f5( *str_objective )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    namespace_fc3e8cb::function_2987fd4c( "s_teleport_woods_apc_ride", 1, 0 );
    
    if ( !isdefined( level.vh_escape_apc ) )
    {
        level.vh_escape_apc = vehicle::simple_spawn_single( "vh_escape_apc" );
    }
    
    level.vh_escape_apc usevehicle( level.player, 1 );
    level flag::set( "flg_escape_player_in_apc" );
    level.woods linkto( level.vh_escape_apc );
    level.woods hide();
    level flag::set( "flg_escape_woods_driving_apc" );
    level thread namespace_fc3e8cb::function_f87024e0();
    level thread namespace_4c1dd357::function_14fb9b43();
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 2
// Checksum 0x6a850ba6, Offset: 0x2020
// Size: 0x324
function function_a668e580( str_objective, var_50cc0d4f )
{
    /#
        namespace_fc3e8cb::function_44a6fc04( "<dev string:x54>" );
    #/
    
    if ( var_50cc0d4f == 0 && str_objective != #"apc_townsquare" )
    {
        return;
    }
    
    setdvar( #"vehicle_selfcollision", 1 );
    level thread function_de15d472();
    level thread function_611d14b4();
    level thread function_e71e5cb2();
    level thread function_24b65377( str_objective );
    
    switch ( str_objective )
    {
        case #"apc_townsquare":
            level thread function_979f55f7();
            level thread function_448bf40();
            level thread function_d209720a();
            level thread function_eae2816b();
            level thread function_50940288();
        case #"apc_mall":
            savegame::checkpoint_save( 1 );
            level thread function_7da5f37f();
            level thread function_f1f398f7();
            level thread function_6d356837();
            level thread function_3542e366();
            level thread function_1d7bde5c();
            level thread function_4e3bc9ad();
            level thread function_32ac3f51();
            level thread function_a735636c();
            break;
    }
    
    level flag::wait_till( "flg_apc_ride_exit_fade_start" );
    snd::client_msg( "outro_movie" );
    lui::screen_fade_out( 1, "black" );
    wait 1.1;
    level flag::wait_till( "flg_apc_ride_end" );
    skipto::function_4e3ab877( str_objective );
    level play_outro_movie();
    skipto::function_1c2dfc20( "cp_rus_yamantau" );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 4
// Checksum 0xfe40198, Offset: 0x2350
// Size: 0x24
function function_28117f7e( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x39c572e, Offset: 0x2380
// Size: 0x6c
function play_outro_movie()
{
    level.player val::set( #"outro_movie", "freezecontrols", 1 );
    level lui::play_movie( #"cp_interstitial_confrontation", "fullscreen", 1, 0, 1 );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xed079d49, Offset: 0x23f8
// Size: 0x9c
function function_de15d472()
{
    objectives::scripted( "obj_apc_ride_main", undefined, #"hash_512fdc2b261612ec" );
    level flag::wait_till( "flg_apc_ride_mall_blockade_start" );
    level.var_5b0ef54d thread function_e3ba2154( "flg_apc_ride_mall_apc_one_dead" );
    flag::wait_till( "flg_apc_ride_end" );
    objectives::complete( "obj_apc_ride_main" );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 1
// Checksum 0x57fd16c8, Offset: 0x24a0
// Size: 0x104
function function_e3ba2154( flg_endon )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_apc_ride_end" );
    objectives::kill( "obj_apc_ride_kill", self, undefined, undefined, undefined, undefined, #"hash_17f4660b06e37fdb" );
    objectives::function_67f87f80( "obj_apc_ride_kill", self, #"hash_6ba8a06ef5a1abad" );
    
    if ( isdefined( flg_endon ) )
    {
        level flag::wait_till( flg_endon );
        objectives::hide( "obj_apc_ride_kill", self );
        objectives::complete( "obj_apc_ride_kill" );
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 1
// Checksum 0x6eac7eca, Offset: 0x25b0
// Size: 0x324
function function_24b65377( str_objective )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    
    if ( !isdefined( level.vh_escape_apc ) )
    {
        level.vh_escape_apc = vehicle::simple_spawn_single( "vh_escape_apc" );
    }
    
    level.vh_escape_apc endon( #"death" );
    thread function_bb8ce128();
    thread function_773fd049();
    
    if ( str_objective === #"apc_townsquare" )
    {
        wait 1;
    }
    
    level thread function_ee7f0031( str_objective );
    level thread function_f4366128();
    
    switch ( str_objective )
    {
        case #"apc_townsquare":
            if ( !level flag::get( "flg_apc_ride_apc_destroyed" ) )
            {
                var_b6d2feca[ #"apc" ] = level.vh_escape_apc;
                var_b6d2feca[ #"enemy_apc" ] = level.vh_town_square_apc;
                var_b6d2feca[ #"gate" ] = getent( "e_motor_pool_gate_anim", "targetname" );
                level scene::play( "scene_amk_7020_apc_townsquare", var_b6d2feca );
            }
        case #"apc_mall":
            if ( !level flag::get( "flg_apc_ride_apc_destroyed" ) )
            {
                var_59c98490[ #"apc" ] = level.vh_escape_apc;
                var_59c98490[ #"hash_612be37238f9b689" ] = level.var_170f6d3b;
                var_59c98490[ #"hash_612be07238f9b170" ] = level.var_de187b4e;
                var_59c98490[ #"car1" ] = level.var_9bdc49b5;
                var_59c98490[ #"car2" ] = level.var_8d81ad00;
                var_59c98490[ #"car3" ] = level.var_8237966c;
                var_59c98490[ #"hash_35619e90e87bcd4f" ] = level.var_74f57be8;
                level scene::play( "scene_amk_7050_apc_mall", var_59c98490 );
            }
            
            break;
    }
    
    level flag::set( "flg_apc_ride_end" );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xa7b5c322, Offset: 0x28e0
// Size: 0x204
function function_bb8ce128()
{
    level endon( #"flg_apc_ride_end", #"flg_apc_ride_apc_destroyed" );
    v_fwd = anglestoforward( level.vh_escape_apc.angles );
    var_2386f8a6 = level.vh_escape_apc.origin + ( 0, 0, 48 ) + v_fwd * 200;
    level.vh_escape_apc.var_dd39434b = spawn( "script_origin", var_2386f8a6 );
    level.vh_escape_apc.var_dd39434b linkto( level.vh_escape_apc );
    level flag::wait_till_any( [ "flg_apc_ride_town_square_crash", "flg_apc_ride_mall_transition_start" ] );
    playfxontag( level._effect[ #"hash_7a068d4f89c57a66" ], level.vh_escape_apc, "tag_origin" );
    level flag::wait_till( "flg_apc_ride_mall_car_hit_3" );
    playfxontag( level._effect[ #"hash_7a068c4f89c578b3" ], level.vh_escape_apc, "tag_origin" );
    level flag::wait_till( "flg_apc_ride_mall_blockade_smash" );
    playfxontag( level._effect[ #"hash_7a068b4f89c57700" ], level.vh_escape_apc, "tag_origin" );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 1
// Checksum 0xfa7e279e, Offset: 0x2af0
// Size: 0x174
function function_c137b56e( var_1d966281 = #"damage" )
{
    level flag::set( "flg_apc_ride_apc_destroyed" );
    
    switch ( var_1d966281 )
    {
        case #"hash_3513ed862f9af2bd":
            level scene::stop( #"scene_amk_7020_apc_townsquare" );
            break;
        case #"hash_3003875db1c127f6":
            level scene::stop( #"scene_amk_7050_apc_mall" );
            break;
        default:
            break;
    }
    
    level.var_85b00b2b = #"hash_7006c5af8caee1fa";
    level.var_30eb363 = #"hash_45bf16b8cf5955b3";
    level.vh_escape_apc util::stop_magic_bullet_shield();
    level.vh_escape_apc setcandamage( 1 );
    waitframe( 1 );
    level.vh_escape_apc kill();
    level.player kill();
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xfa805a3c, Offset: 0x2c70
// Size: 0x150
function function_773fd049()
{
    var_dcdcc34 = getentarray( "apc_ride_mannequin", "script_noteworthy" );
    
    foreach ( e_part in var_dcdcc34 )
    {
        if ( e_part.targetname === "male_mannequin_trigger" || e_part.targetname === "female_mannequin_trigger" || e_part.targetname === "child_mannequin_trigger" )
        {
            e_trigger = spawn( "trigger_radius", e_part.origin, 16, 128, 128 );
            e_trigger thread function_db8b1513( e_part );
            e_part thread function_60d7a2c1( e_trigger );
        }
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 3, eflags: 0x4
// Checksum 0x3a87fbf1, Offset: 0x2dc8
// Size: 0x2a4
function private function_db8b1513( var_5c400ae2, var_ba6a6060 = 1, str_exploder )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"death" );
    s_event = self waittill( #"trigger", #"delete" );
    
    if ( s_event._notify == "trigger" )
    {
        var_1b9cc75d = vectornormalize( s_event.activator.origin - self.origin );
        v_offset = var_1b9cc75d * 7 - ( 0, 0, 30 );
        physicsexplosionsphere( self.origin + v_offset, 80, 10, 3 );
        
        if ( var_ba6a6060 == 1 )
        {
            playfx( level._effect[ #"fx9_impact_mannequin_sm" ], self.origin );
            snd::play( "exp_facade_debris_mannequin", self.origin );
        }
        else if ( isdefined( str_exploder ) )
        {
            exploder::exploder( str_exploder );
        }
        else
        {
            playfx( level._effect[ #"hash_3e4b172e1a13831" ], self.origin );
        }
        
        if ( s_event.activator == level.player )
        {
            level thread namespace_fc3e8cb::function_7898ea4c( "light" );
        }
    }
    
    if ( isdefined( var_5c400ae2 ) )
    {
        var_5c400ae2 notify( #"hash_27629c40b49f163c" );
        var_5c400ae2 delete();
    }
    
    if ( var_ba6a6060 == 1 )
    {
        self delete();
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 1
// Checksum 0x9f672442, Offset: 0x3078
// Size: 0x1ea
function function_60d7a2c1( e_trigger )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"death" );
    level endon( #"flg_apc_ride_end" );
    var_6aece548 = getweapon( #"hash_35678e052f645998" );
    
    while ( true )
    {
        waitresult = self waittill( #"damage" );
        damage = waitresult.amount;
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        method = waitresult.mod;
        
        if ( weapon == var_6aece548 && damage > 2 )
        {
            e_trigger notify( #"delete" );
            self dodamage( damage * 200, self.origin );
            physicsexplosionsphere( self.origin, 80, 10, 3 );
            playfx( level._effect[ #"hash_5cefba84bf717346" ], self.origin );
            break;
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xf2483a21, Offset: 0x3270
// Size: 0x13c
function function_f4366128()
{
    level.var_170f6d3b = hms_util::function_a3bb1e9c( "vh_apc_ride_mall_apc_1", "suspend", 0 );
    level.var_170f6d3b thread function_8e8eaada();
    level.var_de187b4e = hms_util::function_a3bb1e9c( "vh_apc_ride_mall_apc_2", "suspend", 0 );
    level.var_de187b4e thread function_8e8eaada();
    level.var_5b0ef54d = [ level.var_170f6d3b, level.var_de187b4e ];
    level.var_9bdc49b5 = vehicle::simple_spawn_single( "vh_apc_ride_mall_car_1" );
    level.var_8d81ad00 = vehicle::simple_spawn_single( "vh_apc_ride_mall_car_2" );
    level.var_8237966c = vehicle::simple_spawn_single( "vh_apc_ride_mall_car_3" );
    level.var_74f57be8 = vehicle::simple_spawn_single( "vh_apc_ride_mall_car_4" );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x6280d8d, Offset: 0x33b8
// Size: 0xa4
function function_50940288()
{
    level flag::wait_till( "flg_apc_ride_town_square_enter" );
    var_53953eb3 = getent( "e_motor_pool_gate_anim", "targetname" );
    e_motor_pool_gate_clip = getent( "e_motor_pool_gate_clip", "targetname" );
    e_motor_pool_gate_clip connectpaths();
    e_motor_pool_gate_clip delete();
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x609d85e2, Offset: 0x3468
// Size: 0xfc
function function_eae2816b()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level flag::wait_till( "flg_apc_ride_town_square_enter" );
    level thread namespace_fc3e8cb::function_7898ea4c( "medium" );
    level flag::wait_till( "flg_apc_ride_town_square_crash" );
    level thread namespace_fc3e8cb::function_7898ea4c( "crash1" );
    level flag::wait_till( "flg_apc_ride_town_square_steps" );
    level thread namespace_fc3e8cb::function_7898ea4c( "light" );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x70dfa4e9, Offset: 0x3570
// Size: 0x1fc
function function_3542e366()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level flag::wait_till( "flg_apc_ride_mall_car_hit_1" );
    level thread namespace_fc3e8cb::function_7898ea4c( "heavy" );
    level flag::wait_till( "flg_apc_ride_mall_car_hit_2" );
    level thread namespace_fc3e8cb::function_7898ea4c( "medium" );
    level flag::wait_till( "flg_apc_ride_mall_car_hit_3" );
    level thread namespace_fc3e8cb::function_7898ea4c( "medium" );
    level flag::wait_till( "flg_apc_ride_mall_car_hit_4" );
    level thread namespace_fc3e8cb::function_7898ea4c( "light" );
    level flag::wait_till( "flg_apc_ride_mall_blockade_smash" );
    level thread namespace_fc3e8cb::function_7898ea4c( "crash2" );
    level flag::wait_till( "flg_apc_ride_exit_jump_start" );
    level thread namespace_fc3e8cb::function_7898ea4c( "light" );
    level flag::wait_till( "flg_apc_ride_exit_jump_end" );
    level thread namespace_fc3e8cb::function_7898ea4c( "medium" );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x46535c0b, Offset: 0x3778
// Size: 0x8c
function function_979f55f7()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level.vh_escape_apc endon( #"death" );
    level thread namespace_fc3e8cb::function_7898ea4c( "start" );
    level thread namespace_4bd68414::function_750cab2();
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xb3a59e5e, Offset: 0x3810
// Size: 0x74
function function_7da5f37f()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level flag::wait_till( "flg_apc_ride_mall_transition_start" );
    level thread namespace_4bd68414::function_44f82a6d();
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x8aadfbab, Offset: 0x3890
// Size: 0x1c4
function function_448bf40()
{
    println( "<dev string:x60>" );
    var_904dcd29 = spawner::simple_spawn( "ai_enemy_apc_ride_town_square_1", &namespace_fc3e8cb::function_a9674e4a );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_apc_ride_mall_transition_end", var_904dcd29 );
    level flag::wait_till( "flg_apc_ride_town_square_crash" );
    var_9a83e195 = spawner::simple_spawn( "ai_enemy_apc_ride_town_square_2", &namespace_fc3e8cb::function_a9674e4a );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_apc_ride_mall_transition_end", var_9a83e195 );
    level flag::wait_till( "flg_apc_ride_town_square_midpoint" );
    var_e1c96239 = arraycombine( var_904dcd29, var_9a83e195 );
    function_1eaaceab( var_e1c96239 );
    level thread function_d88afd7( var_e1c96239 );
    level flag::wait_till( "flg_apc_ride_town_square_near_exit" );
    var_e4d9f640 = spawner::simple_spawn( "ai_enemy_apc_ride_town_square_3", &namespace_fc3e8cb::function_a9674e4a );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_apc_ride_mall_transition_end", var_e4d9f640 );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 1
// Checksum 0xbc0a45d1, Offset: 0x3a60
// Size: 0x108
function function_d88afd7( var_697fc91a )
{
    foreach ( ai_enemy in var_697fc91a )
    {
        if ( isdefined( ai_enemy ) )
        {
            vol = getent( "vol_apc_ride_town_square_road", "targetname" );
            ai_enemy ai::force_goal( vol, math::cointoss( 75 ), undefined, 0, math::cointoss( 75 ) );
            wait randomfloatrange( 0.1, 0.3 );
        }
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xdbfd1ea1, Offset: 0x3b70
// Size: 0x164
function function_f1f398f7()
{
    level flag::wait_till_any( [ "flg_apc_ride_town_square_curb", "flg_apc_ride_mall_transition_start" ] );
    level thread namespace_fc3e8cb::function_1c62d05e( "ai_enemy_apc_ride_transition_drone", "flg_apc_ride_mall_blockade_start" );
    var_c2cfcbfc = spawner::simple_spawn( "ai_enemy_apc_ride_transition", &namespace_fc3e8cb::function_a9674e4a );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_apc_ride_mall_blockade_start", var_c2cfcbfc );
    vh_enemy_apc_ride_truck_01 = vehicle::simple_spawn_single( "vh_enemy_apc_ride_truck_01" );
    vh_enemy_apc_ride_truck_01.health = int( vh_enemy_apc_ride_truck_01.health * 0.5 );
    vh_enemy_apc_ride_truck_01 thread function_86238755();
    var_cfb40849 = spawner::simple_spawn( "ai_enemy_apc_ride_transition_rpg", &function_5584d0eb );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_apc_ride_mall_blockade_start", var_cfb40849 );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x21da0493, Offset: 0x3ce0
// Size: 0xa4
function function_86238755()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    waitresult = self waittill( #"death" );
    level thread namespace_fc3e8cb::function_7898ea4c( "light" );
    level thread namespace_fc3e8cb::function_38b40877( self.origin, 300 );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xa26c16cd, Offset: 0x3d90
// Size: 0x174
function function_6d356837()
{
    level flag::wait_till( "flg_apc_ride_mall_transition_end" );
    println( "<dev string:x86>" );
    var_701a2965 = spawner::simple_spawn( "ai_enemy_apc_ride_street", &namespace_fc3e8cb::function_a9674e4a );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_apc_ride_end", var_701a2965 );
    var_7d18e2c4 = spawner::simple_spawn( "ai_enemy_apc_ride_street_rpg", &function_5584d0eb );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_apc_ride_end", var_7d18e2c4 );
    level flag::wait_till( "flg_apc_ride_mall_blockade_smash" );
    println( "<dev string:xa7>" );
    var_6fa25d88 = spawner::simple_spawn( "ai_enemy_apc_ride_exit", &namespace_fc3e8cb::function_a9674e4a );
    level thread namespace_fc3e8cb::function_18e5080e( "flg_apc_ride_end", var_6fa25d88 );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xf5832a43, Offset: 0x3f10
// Size: 0x2c4
function function_d209720a()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level.vh_town_square_apc endon( #"death", #"fake_death" );
    level.vh_town_square_apc hms_util::function_c21ef1d8( "suspend" );
    level.vh_town_square_apc.var_e32d3cab = level.vh_town_square_apc.health;
    level.vh_town_square_apc.fake_health = level.vh_town_square_apc.health;
    level.vh_town_square_apc.health = -727379969;
    level.vh_town_square_apc thread function_edf3045c( "flg_apc_ride_town_square_see_exit" );
    level flag::wait_till( "flg_apc_ride_town_square_enter" );
    level.vh_town_square_apc thread function_e3ba2154( "flg_apc_ride_apc_town_square_apc_dead" );
    level.vh_town_square_apc hms_util::function_c21ef1d8( "miss_apc" );
    level.vh_town_square_apc.var_21c17c08 thread namespace_4bd68414::function_cd66d03e();
    level flag::wait_till( "flg_apc_ride_town_square_midpoint" );
    level.vh_town_square_apc hms_util::function_c21ef1d8( "shoot_apc" );
    level.vh_town_square_apc util::stop_magic_bullet_shield();
    level.vh_town_square_apc thread function_dc20e39f( "flg_apc_ride_apc_town_square_apc_dead", "flg_apc_ride_town_square_see_exit", "flg_apc_ride_town_square_near_exit" );
    level flag::wait_till( "flg_apc_ride_town_square_curb" );
    
    if ( level.vh_town_square_apc.var_76517ab1 == 1 )
    {
        level.vh_town_square_apc notify( #"force_kill" );
        return;
    }
    
    level.vh_town_square_apc util::magic_bullet_shield();
    level thread namespace_fc3e8cb::function_7898ea4c( "uber" );
    waitframe( 1 );
    level function_c137b56e( #"hash_3513ed862f9af2bd" );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 3
// Checksum 0x60233d78, Offset: 0x41e0
// Size: 0x3bc
function function_dc20e39f( var_89203ab8 = undefined, var_3966912f = undefined, var_43c70182 = undefined )
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    level endon( #"flg_apc_ride_end", #"flg_apc_ride_apc_destroyed" );
    self endon( #"death" );
    var_1c33d3c9 = getweapon( #"hash_2ee96992825ffaa5" );
    
    while ( true )
    {
        waitresult = self waittill( #"damage", #"force_kill" );
        
        if ( waitresult._notify === "force_kill" )
        {
            break;
        }
        else
        {
            damage = waitresult.amount;
            attacker = waitresult.attacker;
            weapon = waitresult.weapon;
            method = waitresult.mod;
            
            if ( isdefined( damage ) && attacker === level.player )
            {
                multiplier = 1;
                
                if ( isdefined( var_3966912f ) && level flag::get( var_3966912f ) == 1 )
                {
                    multiplier = 2;
                }
                
                if ( isdefined( var_43c70182 ) && level flag::get( var_43c70182 ) == 1 )
                {
                    multiplier = 4;
                }
                
                self.fake_health -= int( damage * multiplier );
                
                if ( self.fake_health <= 0 )
                {
                    break;
                }
            }
        }
        
        waitframe( 1 );
    }
    
    self notify( #"fake_death" );
    level flag::set( var_89203ab8 );
    self hms_util::function_c21ef1d8( "suspend" );
    level thread namespace_fc3e8cb::function_7898ea4c( "medium" );
    level thread namespace_fc3e8cb::function_38b40877( self.origin );
    playfxontag( level._effect[ #"hash_7e2939ab74146e9c" ], self, "tag_body" );
    self setmodel( "veh_t9_mil_ru_apc_heavy_dead" );
    snd::play( "exp_veh_large", self.origin );
    self util::magic_bullet_shield();
    
    if ( self == level.vh_town_square_apc )
    {
        level thread namespace_4bd68414::function_c9327de3();
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x78348159, Offset: 0x45a8
// Size: 0x29c
function function_8e8eaada()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"death", #"fake_death" );
    self thread hms_util::function_7b8ccc06();
    self hms_util::function_c21ef1d8( "suspend" );
    self.var_e32d3cab = self.health;
    self.fake_health = self.health;
    self.health = -727379969;
    level flag::wait_till( "flg_apc_ride_mall_blockade_start" );
    self thread function_edf3045c( "flg_apc_ride_mall_car_hit_3" );
    self thread function_dc20e39f( "flg_apc_ride_mall_apc_one_dead", "flg_apc_ride_mall_blockade_midpoint", "flg_apc_ride_mall_car_hit_4" );
    self thread function_f010ec55();
    self util::stop_magic_bullet_shield();
    self hms_util::function_c21ef1d8( "miss_apc" );
    level flag::wait_till( "flg_apc_ride_mall_blockade_midpoint" );
    
    if ( self flag::get( "buddy_destroyed" ) == 0 )
    {
        self hms_util::function_c21ef1d8( "shoot_apc" );
    }
    
    level flag::wait_till( "flg_apc_ride_mall_blockade_smash" );
    
    if ( self.var_76517ab1 === 1 )
    {
        self notify( #"force_kill" );
        return;
    }
    
    if ( level flag::get( "flg_apc_ride_mall_apc_one_dead" ) == 0 )
    {
        self util::magic_bullet_shield();
        level thread namespace_fc3e8cb::function_7898ea4c( "uber" );
        waitframe( 1 );
        level function_c137b56e( #"hash_3003875db1c127f6" );
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x1d70d8ff, Offset: 0x4850
// Size: 0x108
function function_f010ec55()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    self endon( #"death", #"fake_death" );
    level flag::wait_till( "flg_apc_ride_mall_apc_one_dead" );
    wait 0.5;
    self flag::set( "buddy_destroyed" );
    self hms_util::function_c21ef1d8( "suspend" );
    self.fake_health = 20;
    
    for ( i = 0; i < 10 ; i++ )
    {
        self.fake_health--;
        wait 0.1;
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x44c6b2be, Offset: 0x4960
// Size: 0x104
function function_611d14b4()
{
    e_town_square_exit_gate_right = getent( "e_town_square_exit_gate_right", "targetname" );
    e_town_square_exit_gate_left = getent( "e_town_square_exit_gate_left", "targetname" );
    e_town_square_exit_gate_right_clip = getent( "e_town_square_exit_gate_right_clip", "targetname" );
    e_town_square_exit_gate_left_clip = getent( "e_town_square_exit_gate_left_clip", "targetname" );
    e_town_square_exit_gate_right_clip linkto( e_town_square_exit_gate_right );
    e_town_square_exit_gate_right_clip disconnectpaths();
    e_town_square_exit_gate_left_clip linkto( e_town_square_exit_gate_left );
    e_town_square_exit_gate_left_clip disconnectpaths();
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xc592e136, Offset: 0x4a70
// Size: 0x2d4
function function_e71e5cb2()
{
    e_town_square_exit_gate_right = getent( "e_town_square_exit_gate_right", "targetname" );
    e_town_square_exit_gate_left = getent( "e_town_square_exit_gate_left", "targetname" );
    s_town_square_exit_gate_right_pivot = struct::get( "s_town_square_exit_gate_right_pivot", "targetname" );
    s_town_square_exit_gate_left_pivot = struct::get( "s_town_square_exit_gate_left_pivot", "targetname" );
    var_1517cc89 = spawn( "script_model", s_town_square_exit_gate_right_pivot.origin );
    var_439358df = spawn( "script_model", s_town_square_exit_gate_left_pivot.origin );
    var_1517cc89.angles = e_town_square_exit_gate_right.angles;
    var_439358df.angles = e_town_square_exit_gate_left.angles;
    e_town_square_exit_gate_right linkto( var_1517cc89 );
    e_town_square_exit_gate_left linkto( var_439358df );
    level flag::wait_till( "flg_apc_ride_town_square_near_exit" );
    var_2a13e805 = ( var_1517cc89.angles[ 0 ], var_1517cc89.angles[ 1 ] - 120, var_1517cc89.angles[ 2 ] );
    var_c8c0f18f = ( var_439358df.angles[ 0 ], var_439358df.angles[ 1 ] + 120, var_439358df.angles[ 2 ] );
    var_1517cc89 rotateto( var_2a13e805, 3, 0.2, 0.5 );
    var_439358df rotateto( var_c8c0f18f, 3, 0.2, 0.5 );
    level flag::wait_till( "flg_apc_ride_mall_transition_end" );
    var_1517cc89 delete();
    var_439358df delete();
    e_town_square_exit_gate_right delete();
    e_town_square_exit_gate_left delete();
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x99d865ff, Offset: 0x4d50
// Size: 0x54
function function_32ac3f51()
{
    level thread function_3d7d695c( "s_apc_ride_mall_break_gate_1", "fx_apc_gate_hit_1" );
    level thread function_3d7d695c( "s_apc_ride_mall_break_gate_2", "fx_apc_gate_hit_1" );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 2
// Checksum 0x3e1b9e91, Offset: 0x4db0
// Size: 0xc4
function function_3d7d695c( str_gate, str_exploder )
{
    s_gate = struct::get( str_gate );
    var_9d8fad40 = getent( str_gate + "_clip", "targetname" );
    e_trigger = spawn( "trigger_radius", s_gate.origin, 16, 160, 160 );
    e_trigger thread function_db8b1513( var_9d8fad40, 0, str_exploder );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0x8ed70853, Offset: 0x4e80
// Size: 0x20c
function function_a735636c()
{
    level flag::wait_till( "flg_amk_player_spawned" );
    level.player endon( #"death" );
    wait 1;
    n_damage = level.var_9bdc49b5.health * 0.5;
    level flag::wait_till( "flg_apc_ride_mall_car_hit_1" );
    
    if ( isdefined( level.var_9bdc49b5 ) )
    {
        level.var_9bdc49b5 dodamage( n_damage, level.vh_escape_apc.origin, level.player );
    }
    
    level flag::wait_till( "flg_apc_ride_mall_car_hit_2" );
    
    if ( isdefined( level.var_8d81ad00 ) )
    {
        level.var_8d81ad00 dodamage( n_damage, level.vh_escape_apc.origin, level.player );
    }
    
    level flag::wait_till( "flg_apc_ride_mall_car_hit_3" );
    
    if ( isdefined( level.var_8237966c ) )
    {
        level.var_8237966c dodamage( n_damage, level.vh_escape_apc.origin, level.player );
    }
    
    level flag::wait_till( "flg_apc_ride_mall_car_hit_4" );
    
    if ( isdefined( level.var_74f57be8 ) )
    {
        level.var_74f57be8 dodamage( n_damage, level.vh_escape_apc.origin, level.player );
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 1
// Checksum 0x23599a58, Offset: 0x5098
// Size: 0x390
function function_edf3045c( var_3966912f = undefined )
{
    level endon( #"flg_apc_ride_end", #"flg_apc_ride_apc_destroyed" );
    self endon( #"death" );
    var_dde5e376 = int( self.var_e32d3cab * 0.85 );
    var_d02847fb = int( self.var_e32d3cab * 0.6 );
    var_14505056 = int( self.var_e32d3cab * 0.45 );
    self.var_9226325e = 0;
    self.var_a0764efe = 0;
    self.var_76517ab1 = 0;
    var_1c33d3c9 = getweapon( #"hash_2ee96992825ffaa5" );
    
    while ( true )
    {
        waitresult = self waittill( #"damage" );
        damage = waitresult.amount;
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        method = waitresult.mod;
        
        if ( isdefined( damage ) && attacker === level.player )
        {
            multiplier = 1;
            
            if ( isdefined( var_3966912f ) && level flag::get( var_3966912f ) == 1 )
            {
                multiplier = 2;
            }
            
            self.var_e32d3cab -= int( damage * multiplier );
            
            if ( self.var_e32d3cab > 0 )
            {
                if ( self.var_e32d3cab < var_14505056 && self.var_76517ab1 == 0 )
                {
                    playfxontag( level._effect[ #"hash_6443bbe270c9cfee" ], self, "tag_origin" );
                    self.var_76517ab1 = 1;
                    break;
                }
                else if ( self.var_e32d3cab < var_d02847fb && self.var_a0764efe == 0 )
                {
                    playfxontag( level._effect[ #"hash_6443bce270c9d1a1" ], self, "tag_origin" );
                    self.var_a0764efe = 1;
                }
                else if ( self.var_e32d3cab < var_dde5e376 && self.var_9226325e == 0 )
                {
                    playfxontag( level._effect[ #"hash_6443b9e270c9cc88" ], self, "tag_origin" );
                    self.var_9226325e = 1;
                }
            }
        }
        
        wait 0.2;
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xc9e6071b, Offset: 0x5430
// Size: 0x3ec
function function_5584d0eb()
{
    self endon( #"death" );
    self.goalradius = 32;
    self val::set( #"hash_3f23d66345d259d4", "magic_bullet_shield", 1 );
    
    if ( isdefined( self.target ) )
    {
        self waittill( #"goal" );
    }
    
    a_flags = [];
    
    if ( isdefined( self.var_dc7f6660 ) )
    {
        a_flags[ 0 ] = self.var_dc7f6660;
    }
    
    if ( isdefined( self.var_d6955a8c ) )
    {
        a_flags[ 1 ] = self.var_d6955a8c;
    }
    
    if ( isdefined( self.var_c0fcaf5b ) )
    {
        a_flags[ 2 ] = self.var_c0fcaf5b;
    }
    
    if ( isdefined( self.var_ab4783f1 ) )
    {
        a_flags[ 3 ] = self.var_ab4783f1;
    }
    
    var_ec588ec8 = struct::get_array( "s_" + self.script_noteworthy + "_target", "targetname" );
    var_ec588ec8 = array::sort_by_script_int( var_ec588ec8, 1 );
    self val::set( #"hash_3f23d66345d259d4", "ignoreall", 1 );
    weapon = getweapon( #"hash_35678e052f645998" );
    var_6ca2e6d1 = self gettagorigin( "tag_flash" );
    self aimatentityik( level.vh_escape_apc );
    
    foreach ( index, flag in a_flags )
    {
        var_c8d3d75e = var_ec588ec8[ index ];
        self aimatposik( var_c8d3d75e.origin );
        level flag::wait_till( flag );
        var_50880411 = vectornormalize( var_c8d3d75e.origin - var_6ca2e6d1 ) * 300;
        missile = self magicmissile( weapon, var_6ca2e6d1, var_50880411 );
        playfxontag( level._effect[ #"hash_5b89c053ca995f2f" ], self, "tag_flash" );
        missile thread function_4c48fcfd( var_c8d3d75e.script_noteworthy );
        
        if ( index == 0 )
        {
            self val::reset( #"hash_3f23d66345d259d4", "magic_bullet_shield" );
        }
        
        self aimatentityik( level.vh_escape_apc );
    }
    
    wait 1;
    self val::reset( #"hash_3f23d66345d259d4", "ignoreall" );
    self aimatentityik( level.vh_escape_apc );
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 1
// Checksum 0x1506a4ec, Offset: 0x5828
// Size: 0x154
function function_4c48fcfd( var_6fcbfcc7 )
{
    self waittill( #"death" );
    level thread namespace_fc3e8cb::function_7898ea4c( "light" );
    
    if ( var_6fcbfcc7 === "missile_crater" )
    {
        crater = spawn( "script_model", self.origin - ( 0, 0, 2 ) );
        crater.angles = ( 0, randomfloatrange( 0, 360 ), 0 );
        crater setmodel( "p8_zm_esc_spawn_cap_crater" );
        crater setscale( 0.2 );
        playfx( level._effect[ #"hash_33a7ded5abb15e2b" ], self.origin );
        level flag::wait_till( "flg_apc_ride_end" );
        crater delete();
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xd7eda31e, Offset: 0x5988
// Size: 0xb0
function function_1d7bde5c()
{
    var_b3bf70b5 = getentarray( "veh_apc_ride_mall_destructibles", "script_noteworthy" );
    
    foreach ( veh in var_b3bf70b5 )
    {
        veh thread function_c126946c();
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xf5c33fdb, Offset: 0x5a40
// Size: 0x11e
function function_c126946c()
{
    self endon( #"death" );
    level endon( #"flg_apc_ride_end" );
    var_6aece548 = getweapon( #"hash_35678e052f645998" );
    
    while ( true )
    {
        waitresult = self waittill( #"damage" );
        damage = waitresult.amount;
        attacker = waitresult.attacker;
        weapon = waitresult.weapon;
        method = waitresult.mod;
        
        if ( weapon == var_6aece548 && damage > 5 )
        {
            self dodamage( damage * 200, self.origin );
        }
        
        waitframe( 1 );
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 0
// Checksum 0xf23e7c86, Offset: 0x5b68
// Size: 0x1a8
function function_4e3bc9ad()
{
    level thread scene::init( "apc_ride_rappel_scene_01", "targetname" );
    level flag::wait_till( "flg_apc_ride_mall_transition_end" );
    level thread scene::play( "apc_ride_rappel_scene_01", "targetname" );
    level thread namespace_fc3e8cb::function_fa5905d0( "s_apc_ride_heli_lights_01" );
    var_f1f393cc = getaiarray( "ai_apc_ride_rappel_group_01", "targetname" );
    level flag::wait_till( "flg_apc_ride_exit_outside" );
    function_1eaaceab( var_f1f393cc );
    
    if ( var_f1f393cc.size > 0 )
    {
        foreach ( ai in var_f1f393cc )
        {
            if ( isalive( ai ) && ai.allowdeath !== 0 )
            {
                ai delete();
            }
        }
    }
}

// Namespace namespace_80316bc8/namespace_5675011e
// Params 1, eflags: 0x4
// Checksum 0xf4beff2b, Offset: 0x5d18
// Size: 0x3c8
function private function_ee7f0031( str_objective )
{
    var_b623ad82 = array( #"flg_apc_ride_town_square_start", #"flg_apc_ride_town_square_enter", #"flg_apc_ride_town_square_crash", #"flg_apc_ride_town_square_steps", #"flg_apc_ride_town_square_midpoint", #"flg_apc_ride_town_square_see_exit", #"flg_apc_ride_town_square_near_exit", #"flg_apc_ride_town_square_curb", #"hash_5892925c62afba", #"flg_apc_ride_mall_transition_start", #"flg_apc_ride_mall_transition_rpg", #"hash_468761259827b778", #"hash_2ba964c99f1c4dec", #"flg_apc_ride_mall_turn_end", #"flg_apc_ride_mall_transition_end", #"flg_apc_ride_mall_car_hit_1", #"flg_apc_ride_mall_car_hit_2", #"flg_apc_ride_mall_blockade_start", #"hash_7d74afeabc0ee393", #"flg_apc_ride_mall_car_hit_3", #"flg_apc_ride_mall_blockade_midpoint", #"hash_7d74b0eabc0ee546", #"flg_apc_ride_mall_car_hit_4", #"hash_7d74b1eabc0ee6f9", #"flg_apc_ride_mall_blockade_smash", #"flg_apc_ride_mall_break_gate_1", #"flg_apc_ride_mall_at_booth", #"flg_apc_ride_mall_break_gate_2", #"flg_apc_ride_exit_up_ramp", #"flg_apc_ride_exit_jump_start", #"flg_apc_ride_exit_jump_end", #"flg_apc_ride_exit_outside", #"hash_132d7af7b0ac4ecc", #"flg_apc_ride_exit_fade_start", #"flg_apc_ride_end" );
    var_e851262d = undefined;
    
    switch ( str_objective )
    {
        case #"apc_townsquare":
            var_e851262d = #"flg_apc_ride_town_square_start";
            snd::client_msg( "flg_audio_apc_ride_town_square_start" );
            break;
        case #"apc_mall":
            var_e851262d = #"flg_apc_ride_mall_transition_start";
            snd::client_msg( "flg_audio_apc_ride_mall_transition_start" );
            break;
    }
    
    var_2b11c7f3 = 0;
    
    foreach ( flag in var_b623ad82 )
    {
        if ( flag !== var_e851262d && !var_2b11c7f3 )
        {
            level flag::set( flag );
            continue;
        }
        else
        {
            var_2b11c7f3 = 1;
        }
        
        level waittill( flag );
        level flag::set( flag );
    }
}

