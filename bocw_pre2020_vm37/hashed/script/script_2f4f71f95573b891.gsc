#using script_41e8adffbda93483;
#using script_498cf7685befe7bf;
#using script_77f51076c7c89596;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_rus_siege;
#using scripts\cp_common\breadcrumbs;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace namespace_9940c067;

// Namespace namespace_9940c067/namespace_9940c067
// Params 1
// Checksum 0x9b5c2eb0, Offset: 0xd30
// Size: 0xbc
function function_d7e02379( *str_objective )
{
    exploder::exploder( "lgt_exp_pre_nuke_ext_lights" );
    namespace_534279a::spawn_allies( "graveyard_start" );
    level.var_77be18d2 = vehicle::simple_spawn_single( "player_fav" );
    level.var_77be18d2 val::set( #"hash_533b89b2c3072f64", "takedamage", 0 );
    level thread namespace_9e5ef376::function_b7e649c0();
    snd::client_msg( "audio_graveyard_fire_start" );
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 2
// Checksum 0xeba027ec, Offset: 0xdf8
// Size: 0x35c
function function_8b10d19c( *str_objective, var_50cc0d4f )
{
    if ( var_50cc0d4f )
    {
        exploder::exploder( "fxexp_env_fx_set_graveyard" );
        exploder::exploder( "fxexp_env_fx_set_graveyard_2" );
    }
    
    function_a5083d9c();
    spawner::simple_spawn_single( "parapet_aa_gunner" );
    level.player namespace_534279a::function_a3c3a2b0();
    level.mason val::set( #"hash_427e34b7109385d2", "ignoreme", 1 );
    level.woods val::set( #"hash_427e34b7109385d2", "ignoreme", 1 );
    level notify( #"hash_72c4460ada02022c" );
    level notify( #"hash_49fd25a30e3024a0" );
    level thread function_a1514e3c();
    level thread function_e6528249();
    var_ce667ea2 = getentarray( "destructible_tombstone", "targetname" );
    
    foreach ( var_b337ad77 in var_ce667ea2 )
    {
        var_b337ad77 thread function_2a1cc4d0();
    }
    
    level flag::wait_till( "flg_graveyard_reveal" );
    objectives::complete( #"hash_7956ac3690b300bb" );
    var_c31a6f62 = getent( "aa_parapet", "targetname" );
    objectives::kill( #"hash_75d3caceed12ab7d", var_c31a6f62, #"hash_5c22b5de1fc16f25", undefined, 0, 1 );
    objectives_ui::function_49dec5b( #"hash_75d3caceed12ab7d", var_c31a6f62, #"hash_7056653275b7909e" );
    level thread function_cb6a2e9b();
    snd::client_msg( "audio_graveyard_fire_start" );
    function_6ea2cd94();
    
    /#
        function_5e3101b2();
    #/
    
    objectives::complete( #"hash_75d3caceed12ab7d" );
    skipto::function_4e3ab877( "graveyard" );
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 4
// Checksum 0x6d4b0526, Offset: 0x1160
// Size: 0x34
function function_cdf0a865( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    function_693651a7();
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0
// Checksum 0x11ec9509, Offset: 0x11a0
// Size: 0x4c
function function_6ea2cd94()
{
    level thread function_7e171808();
    level waittill( #"flg_aa_gun_c4_planted" );
    level thread namespace_604e2e22::function_f2f9526e();
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0
// Checksum 0xa27ef3df, Offset: 0x11f8
// Size: 0x78
function function_7e171808()
{
    var_80d256bf = getent( "aa_parapet", "targetname" );
    var_80d256bf namespace_534279a::function_2a8ee50f( "parapet" );
    level notify( #"hash_7797b485016eeeed" );
    var_80d256bf notify( #"remove_objective" );
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0xa7b63bd8, Offset: 0x1278
// Size: 0x7c
function private function_a1514e3c()
{
    level thread function_778517c4();
    level thread function_996c0ba0();
    level thread function_e4ead38e();
    level thread function_de07f71e();
    level thread function_2c6ed0b9();
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 1, eflags: 0x4
// Checksum 0xe98ae002, Offset: 0x1300
// Size: 0x140
function private function_1e0501c8( eventstruct )
{
    dynent = eventstruct.ent;
    var_f2f0344e = 1;
    var_9d27f60c = getentitiesinradius( dynent.origin, 170, 15 );
    
    foreach ( actor in var_9d27f60c )
    {
        var_dfc4aab4 = actor getteam();
        
        if ( var_dfc4aab4 == #"axis" )
        {
            actor dodamage( 1, dynent.origin, undefined, undefined, 0, "MOD_UNKNOWN", 0, undefined, undefined, var_f2f0344e );
        }
    }
}

// Namespace namespace_9940c067/event_9e981c4
// Params 1, eflags: 0x44
// Checksum 0x9dfb35b0, Offset: 0x1448
// Size: 0x64
function private event_handler[event_9e981c4] function_87fb14da( eventstruct )
{
    dynent = eventstruct.ent;
    
    if ( isdefined( dynent.targetname ) && dynent.targetname == #"hash_59014f81a0bff5e7" )
    {
        function_1e0501c8( eventstruct );
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0x7ef05ea6, Offset: 0x14b8
// Size: 0x41c
function private function_778517c4()
{
    level flag::wait_till( "flg_graveyard_initial" );
    a_ai = namespace_534279a::function_da412d49( [ "graveyard_initial_group", "graveyard_initial_rear_group" ] );
    array::run_all( a_ai, &val::set, "graveyard_intro_ignore", "ignoreall", 1 );
    array::run_all( a_ai, &ai::set_behavior_attribute, "disablelean", 1 );
    level.adler val::set( "graveyard_intro_ignore", "ignoreall", 1 );
    level flag::wait_till( "flg_graveyard_reveal" );
    a_ai = namespace_534279a::function_da412d49( [ "graveyard_initial_group", "graveyard_initial_rear_group" ] );
    array::run_all( a_ai, &val::set, "graveyard_intro_ignore", "ignoreall", 1 );
    array::run_all( a_ai, &ai::set_behavior_attribute, "disablelean", 1 );
    array::thread_all( a_ai, &function_99345cd4 );
    level flag::wait_till( "flg_graveyard_unignore" );
    a_ai = namespace_534279a::function_da412d49( [ "graveyard_initial_group", "graveyard_initial_rear_group" ] );
    array::run_all( a_ai, &val::reset, "graveyard_intro_ignore", "ignoreall" );
    array::run_all( a_ai, &ai::set_behavior_attribute, "disablelean", 0 );
    level.adler val::reset( "graveyard_intro_ignore", "ignoreall" );
    namespace_534279a::function_bd1a75b( "graveyard_initial_group", 3, "flg_initial_fallback" );
    namespace_534279a::function_b5e4f3bc( "graveyard_initial_group", "graveyard_initial_fallback_1_volume", "script_noteworthy" );
    level flag::wait_till( "flg_graveyard_engage" );
    spawner::simple_spawn( "graveyard_engage" );
    namespace_534279a::function_bd1a75b( "graveyard_initial_group", 3, "flg_engage_fallback" );
    namespace_534279a::function_b5e4f3bc( "graveyard_initial_group", "graveyard_initial_fallback_2_volume", "script_noteworthy" );
    namespace_534279a::function_bd1a75b( "graveyard_initial_group", 1, "flg_lowground_fallback" );
    namespace_534279a::function_b5e4f3bc( "graveyard_initial_group", "graveyard_lowground_retreat_volume", "script_noteworthy" );
    namespace_534279a::function_b5e4f3bc( "graveyard_initial_rear_group", "graveyard_lowground_retreat_volume", "script_noteworthy" );
    level thread function_71d31006();
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0x2511d7e3, Offset: 0x18e0
// Size: 0x84
function private function_99345cd4()
{
    level endon( #"flg_graveyard_unignore", #"game_ended" );
    level.player endon( #"death" );
    self waittill( #"damage", #"bulletwhizby" );
    level flag::set( "flg_graveyard_unignore" );
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0x5d85c4bf, Offset: 0x1970
// Size: 0xc4
function private function_e4ead38e()
{
    level endon( #"flg_initial_fallback", #"game_ended" );
    level flag::wait_till( "flg_graveyard_unignore" );
    wait 3;
    var_37bcd55 = getaiarray( "graveyard_front_left", "script_noteworthy" );
    var_44265112 = getent( "graveyard_initial_backright_fallback_volume", "script_noteworthy" );
    array::thread_all( var_37bcd55, &ai::force_goal, var_44265112 );
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0xffe0cee7, Offset: 0x1a40
// Size: 0x2b4
function private function_996c0ba0()
{
    level thread function_a5d5b89c( "parapet_turret_1", "parapet_turret_gunner_1" );
    level flag::wait_till( "flg_initial_fallback" );
    
    if ( !spawner::get_ai_group_sentient_count( "graveyard_turret_group" ) )
    {
        function_a5d5b89c( "parapet_turret_1", "parapet_turret_gunner_2" );
    }
    else
    {
        level flag::wait_till( "flg_engage_fallback" );
        
        if ( !spawner::get_ai_group_sentient_count( "graveyard_turret_group" ) )
        {
            function_a5d5b89c( "parapet_turret_1", "parapet_turret_gunner_2" );
        }
    }
    
    level flag::wait_till( "flg_turret_gunner_fallback" );
    namespace_534279a::function_b5e4f3bc( "graveyard_mg_support_front_group", "graveyard_turret_gunner_fallback_volume", "script_noteworthy" );
    namespace_534279a::function_b5e4f3bc( "graveyard_turret_group", "graveyard_turret_gunner_fallback_volume", "script_noteworthy" );
    waitframe( 1 );
    namespace_534279a::function_b5e4f3bc( "graveyard_turret_group", "graveyard_turret_gunner_fallback_volume", "script_noteworthy" );
    var_a27e797b = spawner::get_ai_group_ai( "graveyard_turret_group" );
    array::thread_all( var_a27e797b, &val::reset, #"hash_4d90a080f869a233", "ignoreme" );
    savegame::checkpoint_save();
    level flag::wait_till( "flg_mg_support_entrance" );
    level thread function_39a55ac8();
    level flag::wait_till( "flg_stair_fallback" );
    namespace_534279a::function_b5e4f3bc( "graveyard_turret_group", "graveyard_lowground_retreat_volume", "script_noteworthy" );
    namespace_534279a::function_b5e4f3bc( "graveyard_mg_support_front_group", "graveyard_lowground_retreat_volume", "script_noteworthy" );
    namespace_534279a::function_b5e4f3bc( "graveyard_stair_group", "graveyard_lowground_retreat_volume", "script_noteworthy" );
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0x53a2b0be, Offset: 0x1d00
// Size: 0x170
function private function_39a55ac8()
{
    level endon( #"game_ended" );
    level.player endon( #"death" );
    wait 1;
    spawner::simple_spawn( "graveyard_mg_support_entrance_delay" );
    
    while ( !level flag::get( "flg_stair_fallback" ) )
    {
        level flag::wait_till_any( [ "flg_stair_engage_left", "flg_stair_engage_right" ] );
        
        if ( level flag::get( "flg_stair_engage_left" ) )
        {
            namespace_534279a::function_b5e4f3bc( "graveyard_stair_group", "graveyard_stair_engage_left", "script_noteworthy" );
        }
        else
        {
            namespace_534279a::function_b5e4f3bc( "graveyard_stair_group", "graveyard_stair_engage_right", "script_noteworthy" );
        }
        
        level flag::clear( "flg_stair_engage_left" );
        level flag::clear( "flg_stair_engage_right" );
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 2, eflags: 0x4
// Checksum 0x4d103954, Offset: 0x1e78
// Size: 0x314
function private function_a5d5b89c( var_d562fbb8, var_14a42c6d )
{
    var_d93ed883 = getnode( var_d562fbb8, "targetname" );
    veh_turret = function_1a2a3760( var_d93ed883 );
    
    if ( !isdefined( level.var_c837e477 ) )
    {
        level.var_c837e477 = 1;
        veh_turret.aim_only_no_shooting = 1;
        veh_turret setteam( #"axis" );
        veh_turret turretsetontargettolerance( 0, 0 );
        veh_turret turret::set_burst_parameters( 100, 100, 0.05, 0.05, 0 );
        veh_turret turret::set_target( level.player, ( 0, 0, 0 ), 0 );
        var_3c0b220f = spawner::simple_spawn_single( var_14a42c6d );
        var_3c0b220f setgoal( var_d93ed883, 1, 64 );
        var_3c0b220f val::set( #"hash_4d90a080f869a233", "ignoreme", 1 );
        var_3c0b220f thread function_91520ec4();
        veh_turret.var_5deea171 = var_3c0b220f;
        level.var_dae3084a = spawn( "script_origin", level.player.origin );
        level.var_dae3084a makesentient();
        level.var_dae3084a setteam( #"neutral" );
        veh_turret function_5ef98b38();
        
        if ( flag::get( "flg_graveyard_unignore" ) )
        {
            wait 3;
        }
        
        level thread function_c81a0e5f();
        veh_turret function_4a536ec1();
        wait 3;
        level flag::set( "flg_graveyard_unignore" );
        return;
    }
    
    var_3c0b220f = spawner::simple_spawn_single( var_14a42c6d );
    var_3c0b220f setgoal( var_d93ed883, 1, 64 );
    var_3c0b220f val::set( #"hash_4d90a080f869a233", "ignoreme", 1 );
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0
// Checksum 0xe05321b3, Offset: 0x2198
// Size: 0x74
function function_c368c7fd()
{
    while ( true )
    {
        if ( distance2dsquared( level.player.origin, self.origin ) < sqr( 125 ) )
        {
            break;
        }
        
        waitframe( 1 );
    }
    
    self makeunusable();
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0
// Checksum 0xd8919fc5, Offset: 0x2218
// Size: 0x204
function function_5ef98b38()
{
    level endon( #"flg_graveyard_unignore" );
    self.var_5deea171 endon( #"damage", #"bulletwhizby" );
    var_b3294f70[ 0 ] = ( 10269.5, -6197.72, 269.635 );
    var_b3294f70[ 1 ] = ( 10273.1, -6217.24, 268.791 );
    var_b3294f70[ 2 ] = ( 10517.9, -6288.31, 294.283 );
    
    while ( true )
    {
        var_efff4c42 = 0;
        var_3b1efaa4 = 0;
        var_947b4032 = ( 0, 0, 0 );
        
        foreach ( v in var_b3294f70 )
        {
            var_3b1efaa4 = vectordot( vectornormalize( level.player geteye() - self.origin ), vectornormalize( v - self.origin ) );
            
            if ( var_3b1efaa4 > var_efff4c42 )
            {
                var_efff4c42 = var_3b1efaa4;
                var_947b4032 = v;
            }
        }
        
        level.var_b949cb00 = var_947b4032;
        level.var_dae3084a.origin = level.var_b949cb00;
        waitframe( 1 );
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0
// Checksum 0x7eeaca46, Offset: 0x2428
// Size: 0x1ec
function function_4a536ec1()
{
    level endon( #"graveyard_turret_gunner_killed" );
    i = 0;
    
    while ( i < 2 )
    {
        var_c154039f = i / 2;
        var_3421afd1 = level.var_b949cb00 - level.player.origin;
        v_offset = var_c154039f * var_3421afd1;
        level.var_dae3084a.origin = level.var_b949cb00 - v_offset;
        a_trace = bullettrace( self gettagorigin( "tag_flash" ), level.var_dae3084a.origin, 1, self, 0, 1 );
        level.var_dae3084a.origin = a_trace[ #"position" ];
        self turret::fire( 0 );
        wait 0.15;
        i += 0.15;
    }
    
    self turretsetontargettolerance( 0, 15 );
    self turret::set_burst_parameters( 3, 3.5, 2.5, 3, 0 );
    self turret::function_49c3b892( level.player );
    self.script_accuracy = 0.33;
    self.aim_only_no_shooting = undefined;
    level.var_dae3084a delete();
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0
// Checksum 0x8291b294, Offset: 0x2620
// Size: 0x30
function function_91520ec4()
{
    self waittill( #"death" );
    level notify( #"graveyard_turret_gunner_killed" );
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0
// Checksum 0xf4ceba23, Offset: 0x2658
// Size: 0x156
function function_71d31006()
{
    level endon( #"game_ended" );
    level.player endon( #"death" );
    level flag::wait_till( "flg_turret_gunner_fallback" );
    
    while ( !level flag::get( "flg_graveyard_upper_entrance" ) )
    {
        a_ai = spawner::get_ai_group_ai( "graveyard_initial_group" );
        
        if ( a_ai.size >= 2 )
        {
            foreach ( ai in a_ai )
            {
                if ( !level.player cansee( ai ) )
                {
                    ai deletedelay();
                    break;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0x8df06268, Offset: 0x27b8
// Size: 0xcc
function private function_2c6ed0b9()
{
    level flag::wait_till( "flg_hallway_shotgunner_spawn" );
    ai = spawner::simple_spawn_single( "graveyard_hallway_shotgunner" );
    ai ai::set_behavior_attribute( "demeanor", "cqb" );
    ai waittill( #"goal", #"death" );
    waitframe( 1 );
    
    if ( isalive( ai ) )
    {
        ai thread ai::force_goal( level.player );
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0x5b050f1b, Offset: 0x2890
// Size: 0x154
function private function_de07f71e()
{
    level thread function_bb05a3f7();
    level flag::wait_till( "flg_graveyard_upper_entrance" );
    level thread function_ea6cda92();
    level flag::wait_till( "flg_graveyard_upper_reinforce" );
    level thread function_ea6cda92();
    namespace_534279a::function_bd1a75b( "graveyard_upper_group", 5, "flg_aa_fallback" );
    namespace_534279a::function_b5e4f3bc( "graveyard_turret_group", "graveyard_AA_retreat_volume", "script_noteworthy" );
    namespace_534279a::function_b5e4f3bc( "graveyard_mg_support_front_group", "graveyard_AA_retreat_volume", "script_noteworthy" );
    namespace_534279a::function_b5e4f3bc( "graveyard_stair_group", "graveyard_AA_retreat_volume", "script_noteworthy" );
    namespace_534279a::function_b5e4f3bc( "graveyard_upper_group", "graveyard_AA_retreat_volume", "script_noteworthy" );
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0x3d9fc5a8, Offset: 0x29f0
// Size: 0xd2
function private function_ea6cda92()
{
    wait 0.5;
    a_ai = getaiarchetypearray( "human", "axis" );
    function_1eaaceab( a_ai );
    
    foreach ( ai in a_ai )
    {
        ai.script_accuracy = 0.33;
        ai.grenadeammo = 0;
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0x483d077c, Offset: 0x2ad0
// Size: 0x150
function private function_bb05a3f7()
{
    level endon( #"flg_danger_close", #"game_ended" );
    level.player endon( #"death" );
    level flag::wait_till( "flg_graveyard_upper_rusher_start" );
    
    while ( true )
    {
        a_ai = getaiarchetypearray( "human", "axis" );
        function_1eaaceab( a_ai );
        
        if ( a_ai.size )
        {
            for ( i = 0; i < 2 ; i++ )
            {
                ai = a_ai[ randomintrange( 0, a_ai.size ) ];
                
                if ( isdefined( ai ) )
                {
                    ai ai::force_goal( level.player );
                }
            }
            
            wait randomfloatrange( 5, 8 );
            continue;
        }
        
        break;
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0xefa96d54, Offset: 0x2c28
// Size: 0x2a8
function private function_2a1cc4d0()
{
    self endon( #"game_ended", #"disconnect" );
    
    if ( isdefined( self.var_3016f2b2 ) )
    {
        var_1f3a4780 = getnodearray( self.var_3016f2b2, "targetname" );
        
        if ( isdefined( var_1f3a4780 ) )
        {
            foreach ( nd in var_1f3a4780 )
            {
                if ( isdefined( nd.target ) )
                {
                    var_cc827aa1 = getnode( nd.target, "targetname" );
                    
                    if ( isdefined( var_cc827aa1 ) )
                    {
                        setenablenode( var_cc827aa1, 0 );
                    }
                }
            }
            
            self waittill( #"broken" );
            
            foreach ( nd in var_1f3a4780 )
            {
                setenablenode( nd, 0 );
                
                if ( isdefined( nd.target ) )
                {
                    var_cc827aa1 = getnode( nd.target, "targetname" );
                    
                    if ( isdefined( var_cc827aa1 ) )
                    {
                        setenablenode( var_cc827aa1, 1 );
                    }
                }
                
                ai = getnodeowner( nd );
                
                if ( isdefined( ai ) && ai != level.player )
                {
                    ai setgoal( ai.origin, 0, 2048, 1024 );
                    waitframe( 1 );
                    aiutility::releaseclaimnode( ai );
                    aiutility::choosebestcovernodeasap( ai );
                }
            }
        }
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0xbd1e1347, Offset: 0x2ed8
// Size: 0x304
function private function_e6528249()
{
    level flag::wait_till( "flg_power_returns" );
    level.woods hms_util::dialogue( "vox_cp_seig_01500_wood_adlerareyouseei_6f", 1 );
    level.adler hms_util::dialogue( "vox_cp_seig_01500_adlr_yeahthepowerisc_c9" );
    level.adler hms_util::dialogue( "vox_cp_seig_01500_adlr_bellwevegottohu_65_1" );
    level flag::wait_till( "flg_west_AA_clear" );
    level.player hms_util::dialogue( "vox_cp_seig_01500_wood_adlerwevecleare_21", 1, "allies", "Woods" );
    level.player hms_util::dialogue( "vox_cp_seig_01500_hdsn_copythatadlerwh_f5", 1, "allies", "Hudson" );
    level.adler hms_util::dialogue( "vox_cp_seig_01500_adlr_wevegoteyesonth_8f" );
    level.player hms_util::dialogue( "vox_cp_seig_01500_hdsn_yourecuttingitc_b5", 1, "allies", "Hudson" );
    level.adler hms_util::dialogue( "vox_cp_seig_01500_adlr_justdoit_b7" );
    level flag::wait_till( "flg_call_in_bombers" );
    level notify( #"hash_24e97c3654187766" );
    level.adler hms_util::dialogue( "vox_cp_seig_01500_adlr_commandsendinth_0d" );
    level.player hms_util::dialogue( "vox_cp_seig_01500_cmnd_havethegunsbeen_82", 1 );
    level.adler hms_util::dialogue( "vox_cp_seig_01500_adlr_weareoutoffucki_1a" );
    level.player hms_util::dialogue( "vox_cp_seig_01500_hdsn_copythatgetyour_5d", 1 );
    level.player hms_util::dialogue( "vox_cp_seig_01700_pilo_coordinatesconf_17", 1 );
    level flag::set( "flg_start_timer" );
    level thread function_ce03fba7();
    level flag::wait_till( "flg_danger_close" );
    level.player hms_util::dialogue( "vox_cp_seig_01600_cmnd_youaredangerclo_60", 1 );
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0x3e05c43d, Offset: 0x31e8
// Size: 0x12c
function private function_c81a0e5f()
{
    var_70cf0f3a = [ "vox_cp_seig_01700_adlr_watchitheavymgo_90", "vox_cp_seig_01700_adlr_belltakeoutthat_8e", "vox_cp_seig_01700_adlr_bellyouregonnah_c6", "vox_cp_seig_01700_adlr_thatmgisduginti_eb", "vox_cp_seig_01700_adlr_bellwellneverge_68" ];
    level endon( #"game_ended", #"flg_west_AA_clear" );
    wait 1;
    level thread function_1914d55();
    
    for ( i = 0; i < var_70cf0f3a.size ; i++ )
    {
        level flag::wait_till( "graveyard_turret_gunner_alive" );
        level.adler hms_util::dialogue( var_70cf0f3a[ i ] );
        wait randomfloatrange( 15, 20 );
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0x685134f3, Offset: 0x3320
// Size: 0xc6
function private function_1914d55()
{
    level endon( #"game_ended", #"flg_west_AA_clear" );
    
    while ( true )
    {
        a_ai = spawner::get_ai_group_ai( "graveyard_turret_group" );
        
        if ( a_ai.size && a_ai[ 0 ] isatgoal() )
        {
            level flag::set( "graveyard_turret_gunner_alive" );
        }
        else
        {
            level flag::clear( "graveyard_turret_gunner_alive" );
        }
        
        wait 1;
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0
// Checksum 0x5909971a, Offset: 0x33f0
// Size: 0x118
function function_ed691e53()
{
    level endon( #"game_ended", #"hash_24e97c3654187766" );
    
    while ( true )
    {
        level.adler hms_util::dialogue( "vox_cp_seig_01500_adlr_bellwevegottohu_65" );
        wait randomfloatrange( 10, 15 );
        level.adler hms_util::dialogue( "vox_cp_seig_01500_adlr_movebellwereout_6e" );
        wait randomfloatrange( 10, 15 );
        level.adler hms_util::dialogue( "vox_cp_seig_01500_adlr_bellwevegottohu_65_1" );
        wait randomfloatrange( 10, 15 );
        level.adler hms_util::dialogue( "vox_cp_seig_01500_adlr_movebellwereout_6e" );
        wait randomfloatrange( 10, 15 );
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0, eflags: 0x4
// Checksum 0x2de932cb, Offset: 0x3510
// Size: 0xd4
function private function_ce03fba7()
{
    level endon( #"game_ended", #"flg_danger_close" );
    wait 1;
    level.adler hms_util::dialogue( "vox_cp_seig_01700_adlr_thebombersareon_6f" );
    wait randomfloatrange( 7, 12 );
    level.adler hms_util::dialogue( "vox_cp_seig_01700_adlr_bellthebombersa_e1" );
    wait randomfloatrange( 7, 12 );
    level.adler hms_util::dialogue( "vox_cp_seig_01700_adlr_wegottacleartha_20" );
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0
// Checksum 0x5ca777ed, Offset: 0x35f0
// Size: 0x9c
function function_cb6a2e9b()
{
    level flag::wait_till( "flg_start_timer" );
    level thread function_68842b0f();
    
    /#
        function_b6c5e7fc();
    #/
    
    /#
        function_5c6bf555();
    #/
    
    /#
        function_cfcd9b92();
    #/
    
    /#
        function_5e3101b2();
    #/
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0
// Checksum 0xc73a6146, Offset: 0x3698
// Size: 0x24
function function_68842b0f()
{
    wait 2;
    level thread function_939a79c0();
}

/#

    // Namespace namespace_9940c067/namespace_9940c067
    // Params 0
    // Checksum 0x8e3e871c, Offset: 0x36c8
    // Size: 0x13c, Type: dev
    function function_b6c5e7fc()
    {
        level.var_796fbc8 = newdebughudelem();
        level.var_796fbc8.elemtype = "<dev string:x38>";
        level.var_796fbc8.font = "<dev string:x40>";
        level.var_796fbc8.fontscale = 1;
        level.var_796fbc8.horzalign = "<dev string:x4d>";
        level.var_796fbc8.vertalign = "<dev string:x57>";
        level.var_796fbc8.alignx = "<dev string:x4d>";
        level.var_796fbc8.aligny = "<dev string:x57>";
        level.var_796fbc8.y = -187;
        level.var_796fbc8.sort = 2;
        level.var_796fbc8.alpha = 1;
        level.var_796fbc8.hidewheninmenu = 1;
        level.var_796fbc8 settext( "<dev string:x61>" );
    }

    // Namespace namespace_9940c067/namespace_9940c067
    // Params 0
    // Checksum 0xf4407f6, Offset: 0x3810
    // Size: 0x11a, Type: dev
    function function_5c6bf555()
    {
        level.var_105512d3 = newdebughudelem();
        level.var_105512d3.elemtype = "<dev string:x38>";
        level.var_105512d3.font = "<dev string:x40>";
        level.var_105512d3.fontscale = 1.5;
        level.var_105512d3.horzalign = "<dev string:x4d>";
        level.var_105512d3.vertalign = "<dev string:x57>";
        level.var_105512d3.alignx = "<dev string:x4d>";
        level.var_105512d3.aligny = "<dev string:x57>";
        level.var_105512d3.y = -167;
        level.var_105512d3.sort = 2;
        level.var_105512d3.alpha = 1;
        level.var_105512d3.hidewheninmenu = 1;
    }

    // Namespace namespace_9940c067/namespace_9940c067
    // Params 0
    // Checksum 0x92cb291d, Offset: 0x3938
    // Size: 0x188, Type: dev
    function function_cfcd9b92()
    {
        level endon( #"flg_aa_gun_c4_planted" );
        level.n_timer = 60;
        
        while ( level.n_timer >= 0 )
        {
            var_81ffb4b5 = floor( level.n_timer / 60 );
            var_f168d6d2 = level.n_timer % 60;
            
            if ( var_f168d6d2 < 10 )
            {
                var_f168d6d2 = "<dev string:x7b>" + var_f168d6d2;
            }
            
            /#
                level.var_105512d3 settext( var_81ffb4b5 + "<dev string:x80>" + var_f168d6d2 );
            #/
            
            if ( level.n_timer == 10 )
            {
                level.var_105512d3.color = ( 1, 0, 0 );
            }
            
            if ( level.n_timer == 0 && !level flag::get( "<dev string:x85>" ) )
            {
                wait 1;
                level thread function_94505a0b();
                break;
            }
            
            wait 1;
            
            if ( getdvar( #"hash_3cbb0c98822270b1", 0 ) == 0 )
            {
                level.n_timer--;
            }
        }
    }

    // Namespace namespace_9940c067/namespace_9940c067
    // Params 0
    // Checksum 0x5ff881ad, Offset: 0x3ac8
    // Size: 0x54, Type: dev
    function function_94505a0b()
    {
        level notify( #"hash_735d8a7a19186a9e" );
        function_5e3101b2();
        util::missionfailedwrapper( #"hash_74dae6ee671bda93" );
    }

    // Namespace namespace_9940c067/namespace_9940c067
    // Params 0
    // Checksum 0xfec2521d, Offset: 0x3b28
    // Size: 0x6c, Type: dev
    function function_5e3101b2()
    {
        if ( isdefined( level.var_796fbc8 ) && isdefined( level.var_105512d3 ) )
        {
            level.var_796fbc8 settext( "<dev string:x9e>" );
            level.var_105512d3 settext( "<dev string:x9e>" );
        }
    }

#/

// Namespace namespace_9940c067/namespace_9940c067
// Params 0
// Checksum 0xc3cfd65d, Offset: 0x3ba0
// Size: 0x490
function function_a5083d9c()
{
    level.var_c88d2182 = [];
    level.var_c88d2182[ 0 ] = getent( "e_radar_1_rotation", "targetname" );
    level.var_c88d2182[ 1 ] = getent( "e_radar_2_rotation", "targetname" );
    level.var_c88d2182[ 2 ] = getent( "e_radar_3_rotation", "targetname" );
    level.var_c88d2182[ 3 ] = getent( "e_radar_4_rotation", "targetname" );
    level.var_1d829da4 = [];
    var_9dce209a = struct::get( "dish_red_light_fx_1", "targetname" );
    var_fb87dc0c = struct::get( "dish_red_light_fx_2", "targetname" );
    var_7b6c5bd7 = struct::get( "dish_red_light_fx_3", "targetname" );
    var_892e775b = struct::get( "dish_red_light_fx_4", "targetname" );
    level.var_1d829da4[ 0 ] = spawn( "script_model", var_9dce209a.origin );
    level.var_1d829da4[ 1 ] = spawn( "script_model", var_fb87dc0c.origin );
    level.var_1d829da4[ 2 ] = spawn( "script_model", var_7b6c5bd7.origin );
    level.var_1d829da4[ 3 ] = spawn( "script_model", var_892e775b.origin );
    level.var_1d829da4[ 0 ].angles = level.var_c88d2182[ 0 ].angles + ( 0, 90, 0 );
    level.var_1d829da4[ 1 ].angles = level.var_c88d2182[ 1 ].angles + ( 0, 90, 0 );
    level.var_1d829da4[ 2 ].angles = level.var_c88d2182[ 2 ].angles + ( 0, 90, 0 );
    level.var_1d829da4[ 3 ].angles = level.var_c88d2182[ 3 ].angles + ( 0, 90, 0 );
    level.var_1d829da4[ 0 ] linkto( level.var_c88d2182[ 0 ] );
    level.var_1d829da4[ 1 ] linkto( level.var_c88d2182[ 1 ] );
    level.var_1d829da4[ 2 ] linkto( level.var_c88d2182[ 2 ] );
    level.var_1d829da4[ 3 ] linkto( level.var_c88d2182[ 3 ] );
    
    foreach ( e in level.var_1d829da4 )
    {
        e setmodel( "tag_origin" );
        e cp_rus_siege::play_radar_fx();
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0
// Checksum 0xd189d070, Offset: 0x4038
// Size: 0x158
function function_939a79c0()
{
    var_5a5a8327 = 0;
    
    foreach ( index, ent in level.var_c88d2182 )
    {
        s_scene = struct::get( "radar_" + index + 1, "targetname" );
        
        if ( 115 - s_scene.angles[ 1 ] > var_5a5a8327 )
        {
            var_5a5a8327 = 115 - s_scene.angles[ 1 ];
        }
    }
    
    foreach ( index, ent in level.var_c88d2182 )
    {
        ent thread function_6d038c35( index, var_5a5a8327 );
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 2
// Checksum 0x6c7f9be0, Offset: 0x4198
// Size: 0x184
function function_6d038c35( index, var_5a5a8327 )
{
    s_scene = struct::get( "radar_" + index + 1, "targetname" );
    var_69a6acc4 = 115 - s_scene.angles[ 1 ];
    var_b1595f6a = var_5a5a8327 / 30 / 20;
    var_5c614d61 = int( var_69a6acc4 / var_b1595f6a );
    
    for ( i = 0; i < var_5c614d61 ; i++ )
    {
        foreach ( ent in s_scene.scene_ents )
        {
            ent rotateyaw( var_b1595f6a, 0.05 );
        }
        
        self rotateyaw( var_b1595f6a, 0.05 );
        wait 0.05;
    }
}

// Namespace namespace_9940c067/namespace_9940c067
// Params 0
// Checksum 0xec6f1dcb, Offset: 0x4328
// Size: 0xcc
function function_693651a7()
{
    var_c3d060a6 = [ "graveyard_initial_group", "graveyard_initial_rear_group", "graveyard_turret_group", "graveyard_mg_support_front_group", "graveyard_stair_lmg_group", "graveyard_stair_group", "graveyard_upper_group", "graveyard_upper_special_group" ];
    var_c3d060a6 = namespace_534279a::function_da412d49( var_c3d060a6 );
    array::run_all( var_c3d060a6, &deletedelay );
}

