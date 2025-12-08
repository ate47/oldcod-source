#using script_1351b3cdb6539f9b;
#using script_2d443451ce681a;
#using script_61fee52bb750ac99;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
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
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hint_tutorial;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\smart_bundle;
#using scripts\cp_common\util;

#namespace namespace_18c72e49;

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0xaa2a73, Offset: 0x1228
// Size: 0xc
function start( *str_objective )
{
    
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 2
// Checksum 0x675c4091, Offset: 0x1240
// Size: 0x2c
function main( str_objective, *var_50cc0d4f )
{
    level thread namespace_d9b153b9::start_outro( var_50cc0d4f );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 4
// Checksum 0xef1d507, Offset: 0x1278
// Size: 0x24
function cleanup( *str_objective, *var_50cc0d4f, *var_aa1a6455, *player )
{
    
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x917ffc26, Offset: 0x12a8
// Size: 0x1c4
function function_c26b0bc0()
{
    level flag::init( "waterfall_path_completed" );
    level flag::init( "flag_waterfall_path_intro_complete" );
    level flag::init( "flag_waterfall_path_heli_complete" );
    level flag::init( "flag_waterfall_path_player_melee" );
    level flag::init( "flag_waterfall_path_player_melee_kill" );
    level flag::init( "flag_waterfall_path_player_melee_nokill" );
    level flag::init( "flag_waterfall_path_melee_complete" );
    level flag::init( "flag_waterfall_kill_player_enemies_anim_done" );
    level flag::init( "flag_waterfall_path_ally_anim_complete" );
    level flag::init( "flag_waterfall_path_player_right_trigger" );
    level flag::init( "flag_waterfall_path_player_left_trigger" );
    level flag::init( "flag_waterfall_path_player_shot" );
    level flag::init( "flag_waterfall_path_suspended" );
    level flag::init( "flag_waterfall_path_player_shot2" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x3f60aee2, Offset: 0x1478
// Size: 0x2f2
function function_a08d5cab()
{
    level flag::clear( "flag_waterfall_path_enter_water" );
    level flag::clear( "flag_waterfall_path_enter_water2" );
    level flag::clear( "flag_adler_waterfall_disappear" );
    level flag::clear( "waterfall_path_exited" );
    level flag::clear( "flag_waterfall_path_suspended" );
    level flag::clear( "flag_waterfall_path_intro_complete" );
    level flag::clear( "flag_waterfall_path_heli_complete" );
    level flag::clear( "flag_waterfall_path_exit_water" );
    level flag::clear( "flag_waterfall_path_ambush" );
    level flag::clear( "flag_waterfall_path_player_melee" );
    level flag::clear( "flag_waterfall_path_player_melee_kill" );
    level flag::clear( "flag_waterfall_path_player_melee_nokill" );
    level flag::clear( "flag_waterfall_path_melee_complete" );
    level flag::clear( "flag_waterfall_kill_player_enemies_anim_done" );
    level flag::clear( "flag_waterfall_path_ally_anim_complete" );
    level flag::clear( "flag_waterfall_path_player_right_trigger" );
    level flag::clear( "flag_waterfall_path_player_left_trigger" );
    level flag::clear( "flag_waterfall_path_player_shot" );
    level flag::clear( "flag_waterfall_path_suspended" );
    var_466c2e19 = smart_bundle::function_6c12ff6( "waterfall1_visit1_bundle1_ally" );
    var_466c2e19.var_2b96e535 = 1;
    var_8dfbed88 = smart_bundle::function_6c12ff6( "waterfall1_visit1_bundle1" );
    var_8dfbed88.var_2b96e535 = 1;
    var_9755003e = smart_bundle::function_6c12ff6( "waterfall1_visit1_bundle2" );
    var_9755003e.var_2b96e535 = 1;
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x922db700, Offset: 0x1778
// Size: 0x116
function waterfall_path()
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    var_c79d614f = "waterfall_path";
    level childthread function_3bc2244b();
    level flag::wait_till( "flag_" + var_c79d614f );
    
    while ( true )
    {
        level thread namespace_d9b153b9::function_a57f6629( var_c79d614f );
        level function_22aed800( var_c79d614f );
        
        if ( level flag::get( var_c79d614f + "_completed" ) )
        {
            break;
        }
        
        wait 1;
        level flag::wait_till( "flag_" + var_c79d614f );
        waitframe( 1 );
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x4391bb9e, Offset: 0x1898
// Size: 0x18
function function_1c93ffec()
{
    level notify( #"hash_48117f07e3e52886" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0x5c2bf67a, Offset: 0x18b8
// Size: 0x2d4
function function_22aed800( var_c79d614f )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level endon( var_c79d614f + "_end" );
    level.var_3f5c80c8 = "waterfall_path";
    level thread function_c1b6e3a0( var_c79d614f );
    level thread savegame::checkpoint_save();
    level thread function_1c93ffec();
    
    if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 == 2 )
    {
        level thread function_1c115d87();
    }
    
    level thread function_56f79bad( var_c79d614f );
    
    if ( !level flag::get( "exit_ready" ) )
    {
        if ( level.var_731c10af.paths[ var_c79d614f ].count == 0 )
        {
            function_cc2bf8f7( var_c79d614f );
        }
        else if ( level.var_731c10af.paths[ var_c79d614f ].count == 1 )
        {
            function_cc2bf8f7( var_c79d614f );
        }
        else if ( level.var_731c10af.paths[ var_c79d614f ].count >= 2 )
        {
            function_b264c569();
        }
    }
    
    level flag::wait_till( "flag_waterfall_path_complete" );
    namespace_d9b153b9::function_e106e062( var_c79d614f );
    level flag::set( var_c79d614f + "_completed" );
    var_2cf9fe23 = level.var_731c10af.var_42659717 + 1;
    str = "visit_" + var_2cf9fe23 + "_" + var_c79d614f + "_" + level.var_731c10af.paths[ var_c79d614f ].count;
    bb::function_cd497743( str, level.player );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0x78af4839, Offset: 0x1b98
// Size: 0x388
function function_56f79bad( var_c79d614f )
{
    level notify( #"hash_4998d2e9f6658ee5" );
    level endon( #"hash_4998d2e9f6658ee5" );
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    level endon( var_c79d614f + "_completed" );
    
    while ( true )
    {
        level flag::wait_till( var_c79d614f + "_exited" );
        level flag::clear( "flag_" + var_c79d614f );
        level notify( #"waterfall_end_vo" );
        level flag::clear( "flag_waterfall_path_enter_water" );
        level flag::clear( "flag_waterfall_path_enter_water2" );
        level flag::clear( "flag_waterfall_path_intro_complete" );
        level flag::clear( "flag_waterfall_path_heli_complete" );
        level flag::clear( "flag_waterfall_path_ambush" );
        level flag::clear( "flag_waterfall_path_player_melee" );
        level flag::clear( "flag_waterfall_path_player_melee_kill" );
        level flag::clear( "flag_waterfall_path_player_melee_nokill" );
        level flag::clear( "flag_waterfall_path_melee_complete" );
        level flag::clear( "flag_waterfall_path_player_right_trigger" );
        level flag::clear( "flag_waterfall_path_player_left_trigger" );
        level flag::clear( "flag_waterfall_path_player_shot" );
        level flag::clear( "flag_waterfall_path_suspended" );
        level flag::clear( "waterfall1_visit1_bundle1_ally_flag_true" );
        level flag::clear( "waterfall1_visit1_bundle1_flag_true" );
        level flag::clear( "waterfall1_visit1_bundle2_flag_true" );
        level flag::clear( "waterfall1_visit2_bundle1_flag_true" );
        level flag::clear( "waterfall1_visit3_bundle1_ally_flag_true" );
        level flag::clear( "flag_adler_waterfall_disappear" );
        wait 1;
        level flag::wait_till( "flag_" + var_c79d614f );
        level flag::clear( var_c79d614f + "_exited" );
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0x1f31c19a, Offset: 0x1f28
// Size: 0x3f4
function function_cc2bf8f7( var_c79d614f )
{
    level endon( var_c79d614f + "_end" );
    level.player endon( #"death" );
    spawner::add_spawn_function_group( "waterfall1_visit1", "script_aigroup", &function_3e6220d0 );
    spawner::add_spawn_function_group( "waterfall1_visit1_ally", "script_aigroup", &function_3e6220d0 );
    level flag::set( "waterfall1_visit1_bundle1_ally_flag_true" );
    level flag::set( "waterfall1_visit1_bundle1_flag_true" );
    level flag::set( "waterfall1_visit1_bundle2_flag_true" );
    var_466c2e19 = smart_bundle::function_6c12ff6( "waterfall1_visit1_bundle1_ally" );
    var_466c2e19 smart_bundle::function_e47ac090();
    var_8dfbed88 = smart_bundle::function_6c12ff6( "waterfall1_visit1_bundle1" );
    var_8dfbed88 smart_bundle::function_e47ac090();
    var_9755003e = smart_bundle::function_6c12ff6( "waterfall1_visit1_bundle2" );
    var_9755003e smart_bundle::function_e47ac090();
    a_allies = getaiarray( "waterfall1_visit1_ally", "script_aigroup" );
    a_enemies = getaiarray( "waterfall1_visit1_enemy1", "targetname" );
    level childthread function_4a9bc048();
    level childthread function_438267a6();
    
    if ( !level flag::get( "flag_waterfall_path_suspended" ) )
    {
        level childthread function_9224fc8();
    }
    
    level childthread function_1384307e( a_allies, a_enemies );
    childthread function_cd92d1d9( a_allies );
    childthread function_981d2e58( a_enemies );
    
    if ( !level flag::get( "flag_waterfall_path_suspended" ) )
    {
        level childthread function_8c0c4b93( a_allies, a_enemies );
    }
    
    level flag::wait_till( "flag_waterfall_path_enter_water" );
    level thread function_c1a3a0bc();
    level childthread function_c833f9a3();
    
    if ( !level flag::get( "flag_waterfall_path_suspended" ) )
    {
        level childthread function_d1f683f0( a_enemies, "flag_waterfall_path_player_right_trigger", "kill_player_right", "flag_waterfall_path_player_right_trigger_in" );
        level childthread function_d1f683f0( a_enemies, "flag_waterfall_path_player_left_trigger", "kill_player_left", "flag_waterfall_path_player_left_trigger_in" );
    }
    
    level childthread function_f745e644( a_allies, var_c79d614f );
    level flag::wait_till( "flag_waterfall_path_complete" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x71d51f3c, Offset: 0x2328
// Size: 0x2c
function function_3e6220d0()
{
    self val::set( "waterfall_wake", "ignoreall", 1 );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x680b2532, Offset: 0x2360
// Size: 0xac
function function_c1a3a0bc()
{
    var_29ac256c = struct::get( "waterfall_helicopter_sound_struct", "targetname" );
    level.var_56894b06 = util::spawn_model( "tag_origin", var_29ac256c.origin );
    wait 6;
    level thread namespace_b6fe1dbe::music( "deactivate_3.0_ruins_1" );
    level thread namespace_b6fe1dbe::function_fcfaa723();
    level thread function_2d21d4a3();
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0xed0e4b02, Offset: 0x2418
// Size: 0x4c
function function_2d21d4a3()
{
    level flag::wait_till_any( array( "flag_waterfall_path_enter_water2", "waterfall_path_exited" ) );
    level thread namespace_b6fe1dbe::function_eacda7cd();
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x3de15051, Offset: 0x2470
// Size: 0x198
function function_c833f9a3()
{
    level flag::wait_till( "flag_waterfall_path_enter_water2" );
    var_736f7cf8 = vehicle::simple_spawn_and_drive( "waterfall_heligroup1b" );
    var_736f7cf8[ 1 ] playrumblelooponentity( "damage_heavy" );
    namespace_b6fe1dbe::function_d282054f( var_736f7cf8[ 0 ], var_736f7cf8[ 1 ] );
    
    if ( isdefined( var_736f7cf8[ 0 ] ) && isdefined( level.var_56894b06 ) )
    {
        level.var_56894b06 linkto( var_736f7cf8[ 0 ], "tag_origin", level.var_56894b06.origin );
    }
    
    foreach ( heli in var_736f7cf8 )
    {
        heli setrotorspeed( 1 );
        heli vehicle::toggle_tread_fx( 1 );
        heli vehicle::toggle_exhaust_fx( 1 );
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 2
// Checksum 0xb2a5a71a, Offset: 0x2610
// Size: 0x1c2
function function_8c0c4b93( a_allies, a_enemies )
{
    level endon( #"flag_waterfall_path_player_melee" );
    level thread scene::init( "waterfall_kill_allies", a_allies );
    level thread scene::init( "waterfall_kill_enemies", a_enemies );
    childthread function_7d20c75b( a_allies );
    childthread function_19d803e0( a_enemies );
    
    foreach ( ai in a_allies )
    {
        weapon = getweapon( #"hash_4ff481a4f55ed901" );
        ai aiutility::setprimaryweapon( weapon );
        ai.var_5b22d53 = 0;
    }
    
    foreach ( ai in a_enemies )
    {
        ai.var_5b22d53 = 0;
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0xc8df3922, Offset: 0x27e0
// Size: 0xe4
function function_7d20c75b( a_allies )
{
    level thread scene::play( "waterfall_kill_allies", "intro_loop", a_allies );
    level flag::wait_till( "flag_waterfall_path_enter_water" );
    
    if ( function_1ed5f194() )
    {
        level scene::play( "waterfall_kill_allies", "intro", a_allies );
    }
    
    if ( function_1ed5f194() )
    {
        level flag::set( "flag_waterfall_path_intro_complete" );
        level scene::play( "waterfall_kill_allies", "wait_loop", a_allies );
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0x9f058e68, Offset: 0x28d0
// Size: 0xe4
function function_19d803e0( a_enemies )
{
    level thread scene::play( "waterfall_kill_enemies", "intro_loop", a_enemies );
    level flag::wait_till( "flag_waterfall_path_enter_water2" );
    
    if ( function_1ed5f194() )
    {
        level flag::set( "flag_waterfall_path_heli_complete" );
        level scene::play( "waterfall_kill_enemies", "intro", a_enemies );
    }
    
    if ( function_1ed5f194() )
    {
        level scene::play( "waterfall_kill_enemies", "wait_loop", a_enemies );
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0xc8040690, Offset: 0x29c0
// Size: 0x7e, Type: bool
function function_1ed5f194()
{
    return !flag::get( "flag_waterfall_path_exit_water" ) && !flag::get( "stealth_spotted" ) && !flag::get( "flag_waterfall_path_player_melee" ) && !flag::get( "flag_waterfall_path_player_shot" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 2
// Checksum 0x408d4370, Offset: 0x2a48
// Size: 0x18c
function function_1384307e( a_allies, a_enemies )
{
    result = level flag::wait_till_any( array( "stealth_spotted", "flag_waterfall_path_exit_water", "flag_waterfall_path_player_melee", "flag_waterfall_path_player_shot" ) );
    thread hint_tutorial::function_9f427d88();
    objectives::complete( "flag_waterfall_path_player_right_trigger" );
    objectives::complete( "flag_waterfall_path_player_left_trigger" );
    childthread function_6444a0e8();
    thread function_306abb40( a_allies, a_enemies );
    level notify( #"waterfall_end_vo" );
    
    if ( !( level flag::get( "flag_waterfall_path_intro_complete" ) || level flag::get( "flag_waterfall_path_player_melee" ) ) && !level flag::get( "flag_waterfall_path_heli_complete" ) )
    {
        wait 2;
    }
    
    wait 1;
    function_3781040d( "waterfall1_visit1_ally", "script_aigroup" );
    function_3781040d( "waterfall1_visit1", "script_aigroup" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x4a1fea3a, Offset: 0x2be0
// Size: 0x94
function function_6444a0e8()
{
    level.var_a8dd4628 = getent( "flag_waterfall_path_player_left_trigger", "targetname" );
    level.var_db471312 = getent( "flag_waterfall_path_player_right_trigger", "targetname" );
    waitframe( 1 );
    level.var_a8dd4628 triggerenable( 0 );
    level.var_db471312 triggerenable( 0 );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 2
// Checksum 0xb4e182f9, Offset: 0x2c80
// Size: 0x5a4
function function_306abb40( a_allies, a_enemies )
{
    wait 0.25;
    var_a6be88da = arraycombine( a_allies, a_enemies );
    
    if ( level flag::get( "flag_waterfall_path_intro_complete" ) && level flag::get( "flag_waterfall_path_heli_complete" ) || level flag::get( "flag_waterfall_path_player_melee" ) )
    {
        if ( flag::get( "flag_waterfall_path_player_melee" ) )
        {
            foreach ( ai in var_a6be88da )
            {
                if ( isalive( ai ) )
                {
                    ai val::set( "waterfall_wake", "ignoreall", 1 );
                    ai stopanimscripted();
                }
            }
        }
        
        var_c8b44cd7 = [];
        
        foreach ( guy in var_a6be88da )
        {
            if ( isalive( guy ) && ( guy.animname == "enemy1" || guy.animname == "enemy4" ) )
            {
                var_c8b44cd7[ var_c8b44cd7.size ] = guy;
            }
        }
        
        var_c0e178b0 = arraycombine( a_allies, var_c8b44cd7 );
        
        foreach ( ally in a_allies )
        {
            if ( isalive( ally ) )
            {
                util::magic_bullet_shield( ally );
            }
        }
        
        level thread function_690c742d( a_allies );
        level scene::play( "waterfall_kill", "ally_kills", var_c0e178b0 );
        waitframe( 1 );
        
        foreach ( ai in a_allies )
        {
            if ( isalive( ai ) && ai.animname == "ally1" )
            {
                ai ai::set_goal( "waterfall1_visit1_ally_node2", "targetname", 1 );
                continue;
            }
            
            if ( isalive( ai ) && ai.animname == "ally2" )
            {
                ai ai::set_goal( "waterfall1_visit1_ally_node1", "targetname", 1 );
            }
        }
    }
    else if ( !level flag::get( "flag_waterfall_path_heli_complete" ) )
    {
        foreach ( ai in a_enemies )
        {
            if ( isdefined( ai ) )
            {
                ai getenemyinfo( level.player );
                ai function_a3fcf9e0( "attack", level.player, level.player.origin );
                ai.stealth.breacting = "large";
            }
        }
        
        level scene::play( "waterfall_kill_enemies_react", a_enemies );
    }
    
    level flag::set( "flag_waterfall_path_melee_complete" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 2
// Checksum 0x12a56fe2, Offset: 0x3230
// Size: 0x16c
function function_f745e644( a_allies, var_c79d614f )
{
    level.player endon( #"death" );
    wait 1;
    a_enemies = getaiarray( "waterfall1_visit1", "script_aigroup" );
    function_1eaaceab( a_enemies );
    arrayremovevalue( a_enemies, undefined );
    ai::waittill_dead( a_enemies );
    
    if ( !level flag::get( var_c79d614f + "_exited" ) )
    {
        level flag::set( "flag_waterfall_path_complete" );
    }
    else
    {
        level flag::set( "flag_waterfall_path_suspended" );
    }
    
    level.player val::set( "waterfall", "allow_melee", 1 );
    function_1eaaceab( a_allies );
    level childthread function_425b25c6( a_allies, var_c79d614f );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 2
// Checksum 0x8939291, Offset: 0x33a8
// Size: 0x9c
function function_425b25c6( a_allies, *var_c79d614f )
{
    level childthread function_ea710d32( var_c79d614f );
    level scene::play( "waterfall_kill_allies_cleanup", "cleanup", var_c79d614f );
    level thread scene::play( "waterfall_kill_allies_cleanup", "cleanup_loop", var_c79d614f );
    level flag::set( "flag_waterfall_path_ally_anim_complete" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0x555d6ec9, Offset: 0x3450
// Size: 0xd8
function function_690c742d( a_allies )
{
    level flag::wait_till_any( array( "flag_waterfall_path_complete", "flag_waterfall_path_ally_anim_complete" ) );
    
    foreach ( ally in a_allies )
    {
        if ( isalive( ally ) )
        {
            util::stop_magic_bullet_shield( ally );
        }
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 4
// Checksum 0x1a288441, Offset: 0x3530
// Size: 0x244
function function_d1f683f0( var_a6be88da, triggername, shotname, *var_74ad35de )
{
    level endon( #"flag_waterfall_path_exit_water" );
    level endon( #"stealth_spotted" );
    childthread function_db10087a( triggername, shotname, var_74ad35de );
    thread scene::init( "waterfall_kill_player_right" );
    thread scene::init( "waterfall_kill_player_left" );
    trigger = getent( shotname, "targetname" );
    trigger triggerenable( 1 );
    trigger triggerignoreteam();
    trigger setvisibletoall();
    trigger setcursorhint( "HINT_NOICON" );
    trigger setteamfortrigger( #"none" );
    trigger usetriggerrequirelookat();
    flag::wait_till( "flag_waterfall_path_ambush" );
    struct = struct::get( "struct_" + shotname, "targetname" );
    objectives::function_4eb5c04a( shotname, struct.origin );
    objectives::function_67f87f80( shotname, undefined, #"hash_3c73b6445c421b5" );
    flag::wait_till( shotname );
    flag::set( "flag_waterfall_path_player_melee" );
    function_ca41480a( triggername, var_74ad35de );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 3
// Checksum 0x456e6780, Offset: 0x3780
// Size: 0x1a4
function function_db10087a( var_a6be88da, var_74ad35de, shotname )
{
    level.player endon( #"death" );
    level.player notifyonplayercommand( "weapon_melee", "+melee" );
    level.player notifyonplayercommand( "weapon_melee", "+melee_zoom" );
    level endon( #"flag_waterfall_path_exit_water" );
    level endon( #"flag_waterfall_path_player_melee" );
    trigger = getent( var_74ad35de, "targetname" );
    
    while ( true )
    {
        if ( !isdefined( trigger ) )
        {
            break;
        }
        
        while ( isdefined( trigger ) && !level.player istouching( trigger ) )
        {
            waitframe( 1 );
        }
        
        thread function_71f5f1ab( var_a6be88da, shotname );
        
        if ( !isdefined( trigger ) )
        {
            break;
        }
        
        while ( isdefined( trigger ) && level.player istouching( trigger ) )
        {
            waitframe( 1 );
        }
        
        function_4115b6f( var_a6be88da );
        waitframe( 1 );
        level notify( #"hash_20cd41bb32936407" );
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 2
// Checksum 0x6a2ed3ee, Offset: 0x3930
// Size: 0x214
function function_71f5f1ab( var_a6be88da, shotname )
{
    level endon( #"flag_waterfall_path_exit_water" );
    level endon( #"hash_20cd41bb32936407" );
    level.player endon( #"death" );
    level.player val::set( "waterfall", "allow_melee", 0 );
    level.player.var_c681e4c1 = 1;
    
    foreach ( guy in var_a6be88da )
    {
        if ( isalive( guy ) )
        {
            guy.var_c681e4c1 = 1;
            guy val::set( "waterfall_wake", "ignoreall", 1 );
        }
    }
    
    thread hint_tutorial::function_4c2d4fc4( #"hash_56cec4baa5332ed0", undefined, undefined, undefined, 2 );
    level.player waittill( #"weapon_melee" );
    flag::set( "flag_waterfall_path_player_melee" );
    objectives::complete( "flag_waterfall_path_player_right_trigger" );
    objectives::complete( "flag_waterfall_path_player_left_trigger" );
    function_ca41480a( var_a6be88da, shotname );
    thread function_4115b6f();
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0xeb6d9457, Offset: 0x3b50
// Size: 0x180
function function_4115b6f( var_a6be88da )
{
    level.player thread util::hide_hint_text();
    objectives::complete( "flag_waterfall_path_player_right_trigger" );
    objectives::complete( "flag_waterfall_path_player_left_trigger" );
    
    if ( isalive( level.player ) )
    {
        level.player val::set( "waterfall", "allow_melee", 1 );
        level.player.var_c681e4c1 = 0;
    }
    
    if ( isdefined( var_a6be88da ) && var_a6be88da.size > 0 )
    {
        foreach ( guy in var_a6be88da )
        {
            if ( isalive( guy ) )
            {
                guy.var_c681e4c1 = 1;
                guy val::set( "waterfall_wake", "ignoreall", 1 );
            }
        }
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 2
// Checksum 0xb9b8dfbe, Offset: 0x3cd8
// Size: 0x3ec
function function_ca41480a( var_a6be88da, shotname )
{
    level.player endon( #"death" );
    var_4e5d86e6 = [];
    
    foreach ( guy in var_a6be88da )
    {
        if ( isalive( guy ) && ( guy.animname == "enemy2" || guy.animname == "enemy3" ) )
        {
            var_4e5d86e6[ var_4e5d86e6.size ] = guy;
        }
    }
    
    setsaveddvar( #"hash_7bf40e4b6a830d11", 0 );
    currentweapon = level.player getcurrentweapon();
    level.player switchtoweapon();
    wait 0.25;
    level.player disableweapons();
    
    if ( shotname == "kill_player_right" )
    {
        thread namespace_b6fe1dbe::waterfall_kill_right();
        level scene::play( "waterfall_kill_player_right", var_4e5d86e6 );
    }
    else
    {
        thread namespace_b6fe1dbe::waterfall_kill_left();
        level scene::play( "waterfall_kill_player_left", var_4e5d86e6 );
    }
    
    function_1eaaceab( var_4e5d86e6 );
    thread function_dde9b0c5();
    thread function_c502836b( var_4e5d86e6, shotname );
    level flag::wait_till_any( array( "flag_waterfall_path_player_melee_kill", "flag_waterfall_kill_player_enemies_anim_done" ) );
    weapon = getweapon( "special_throwingknife_t9" );
    level.player takeweapon( weapon );
    level.player enableweaponcycling();
    level.player switchtoweaponimmediate( currentweapon );
    setsaveddvar( #"hash_7bf40e4b6a830d11", 1 );
    thread namespace_b6fe1dbe::waterfall_slowmo_stop();
    setslowmotion( 0.25, 1, 0.25 );
    level.player clientfield::set_to_player( "lerp_fov", 4 );
    
    if ( !level flag::get( "flag_waterfall_path_player_melee_kill" ) )
    {
        level flag::set( "flag_waterfall_path_player_melee_nokill" );
    }
    
    level.player freezecontrolsallowlook( 0 );
    level flag::set( "flag_waterfall_path_exit_water" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 2
// Checksum 0x1f74512a, Offset: 0x40d0
// Size: 0x2bc
function function_c502836b( var_4e5d86e6, shotname )
{
    level.player endon( #"death" );
    
    foreach ( ai in var_4e5d86e6 )
    {
        ai getenemyinfo( level.player );
        ai function_a3fcf9e0( "attack", level.player, level.player.origin );
        
        if ( shotname == "kill_player_right" && isdefined( ai.animname ) && ai.animname == "enemy2" )
        {
            childthread function_8c8c40db( ai, "scene_pri_waterfall_kill_player_react_right_death" );
            level scene::play( "waterfall_kill_player_react_right", shotname + "_kill_react", array( ai ) );
        }
        else if ( shotname == "kill_player_left" && isdefined( ai.animname ) && ai.animname == "enemy3" )
        {
            childthread function_8c8c40db( ai, "scene_pri_waterfall_kill_player_react_left_death" );
            level scene::play( "waterfall_kill_player_react_left", shotname + "_kill_react", array( ai ) );
        }
        
        ai getenemyinfo( level.player );
        ai function_a3fcf9e0( "attack", level.player, level.player.origin );
        ai ai::set_goal( "waterfall1_visit1_volume1", "targetname", 1 );
    }
    
    level flag::set( "flag_waterfall_kill_player_enemies_anim_done" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 2
// Checksum 0xb161198b, Offset: 0x4398
// Size: 0x4c
function function_8c8c40db( ai, str_scene_name )
{
    level endon( #"flag_waterfall_kill_player_enemies_anim_done" );
    ai.scriptbundlename = str_scene_name;
    ai waittill( #"damage" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0xfe4712d7, Offset: 0x43f0
// Size: 0x134
function function_dde9b0c5()
{
    level endon( #"flag_waterfall_path_player_melee_nokill" );
    level.player endon( #"death" );
    weapon = getweapon( "special_throwingknife_t9" );
    level.player giveweapon( weapon );
    level.player givestartammo( weapon );
    level.player switchtoweaponimmediate( weapon );
    level.player disableweaponcycling();
    level.player showviewmodel();
    level.player freezecontrolsallowlook( 1 );
    level.player setstance( "crouch" );
    childthread function_641aa2d6();
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x9cb1db3b, Offset: 0x4530
// Size: 0x154
function function_641aa2d6()
{
    level.player endon( #"death" );
    wait 0.3;
    level.player enableweapons();
    level.player clientfield::set_to_player( "lerp_fov", 3 );
    childthread function_4a15681b();
    wait 0.5;
    level.player notifyonplayercommand( "weapon_fire", "+attack" );
    level.player notifyonplayercommand( "weapon_fire", "+melee" );
    level.player notifyonplayercommand( "weapon_fire", "+melee_zoom" );
    level.player waittill( #"weapon_fire" );
    thread namespace_b6fe1dbe::waterfall_throw_knife();
    wait 0.65;
    level flag::set( "flag_waterfall_path_player_melee_kill" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0xde87b6b8, Offset: 0x4690
// Size: 0x44
function function_4a15681b()
{
    thread namespace_b6fe1dbe::waterfall_slowmo_start();
    wait 0.3;
    setslowmotion( 1, 0.25, 0.25 );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x4dbd6c5, Offset: 0x46e0
// Size: 0x9c
function function_4a9bc048()
{
    level notify( #"hash_18adcd53baf4df1b" );
    level endon( #"hash_18adcd53baf4df1b" );
    level endon( #"flag_waterfall_path_player_melee" );
    wait 0.25;
    level ai::function_bb79f1ad( "waterfall1_visit1", "waterfall1_visit1_volume1", 1, 1 );
    level flag::set( "flag_waterfall_path_exit_water" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x3e4cb449, Offset: 0x4788
// Size: 0xdc
function function_438267a6()
{
    level endon( #"flag_waterfall_path_player_melee" );
    level.player endon( #"death" );
    level.player notifyonplayercommand( "weapon_fire", "+attack" );
    
    while ( true )
    {
        level.player waittill( #"weapon_fire" );
        
        if ( level.player getcurrentweapon().name != #"hash_165cf52ce418f5a1" )
        {
            level flag::set( "flag_waterfall_path_player_shot" );
            break;
        }
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x8b20babb, Offset: 0x4870
// Size: 0x12e
function function_9224fc8()
{
    level endon( #"flag_waterfall_path_exit_water" );
    level endon( #"flag_waterfall_path_player_melee" );
    level.player endon( #"death" );
    thread function_6d00113d();
    volume = getent( "volume_waterfall_kill_stand", "targetname" );
    
    while ( true )
    {
        while ( isdefined( volume ) && !level.player istouching( volume ) )
        {
            waitframe( 1 );
        }
        
        childthread function_246d692();
        
        while ( isdefined( volume ) && level.player istouching( volume ) )
        {
            waitframe( 1 );
        }
        
        childthread function_5134b5f();
        waitframe( 1 );
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x678eec9e, Offset: 0x49a8
// Size: 0x4c
function function_6d00113d()
{
    flag::wait_till_any( array( "flag_waterfall_path_exit_water", "flag_waterfall_path_player_melee" ) );
    wait 1;
    function_246d692();
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0xd542d20a, Offset: 0x4a00
// Size: 0xd8
function function_246d692()
{
    aigroup = getaiarray( "waterfall1_visit1", "script_aigroup" );
    
    foreach ( ai in aigroup )
    {
        if ( isalive( ai ) )
        {
            ai val::set( "waterfall_wake", "ignoreall", 0 );
        }
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0xc259d31d, Offset: 0x4ae0
// Size: 0xd8
function function_5134b5f()
{
    aigroup = getaiarray( "waterfall1_visit1", "script_aigroup" );
    
    foreach ( ai in aigroup )
    {
        if ( isalive( ai ) )
        {
            ai val::set( "waterfall_wake", "ignoreall", 1 );
        }
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 2
// Checksum 0x64c18956, Offset: 0x4bc0
// Size: 0x250
function function_3781040d( var_cb357a94, key )
{
    aigroup = getaiarray( var_cb357a94, key );
    
    foreach ( ai in aigroup )
    {
        if ( !( level flag::get( "flag_waterfall_path_intro_complete" ) && level flag::get( "flag_waterfall_path_heli_complete" ) || level flag::get( "flag_waterfall_path_player_melee" ) ) )
        {
            ai stopanimscripted();
        }
        else if ( !flag::get( "flag_waterfall_path_player_melee" ) && isdefined( ai.animname ) && ( ai.animname == "enemy2" || ai.animname == "enemy3" ) )
        {
            ai stopanimscripted();
        }
        
        ai getenemyinfo( level.player );
        ai getperfectinfo( level.player );
        ai function_a3fcf9e0( "attack", level.player, level.player.origin );
        
        if ( isalive( ai ) )
        {
            ai val::set( "waterfall_wake", "ignoreall", 0 );
        }
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0x346978f5, Offset: 0x4e18
// Size: 0x1ec
function function_cd92d1d9( a_allies )
{
    level endon( #"waterfall_end_vo" );
    wait 1;
    
    if ( isalive( a_allies[ 0 ] ) )
    {
        a_allies[ 0 ] dialogue::queue( "vox_cp_prsn_28000_ams1_downgetdown_f2" );
    }
    
    childthread namespace_d9b153b9::function_f6cbf7fd( &function_58a1520d, 1, 15, "waterfall_end_vo_idle" );
    level flag::wait_till( "flag_waterfall_path_enter_water" );
    
    if ( isalive( a_allies[ 0 ] ) )
    {
        a_allies[ 0 ] dialogue::queue( "vox_cp_prsn_28000_ams2_vc_23" );
    }
    
    wait 1;
    
    if ( isalive( a_allies[ 0 ] ) )
    {
        a_allies[ 0 ] dialogue::queue( "vox_cp_prsn_28000_ams1_letsmoveinclose_66" );
    }
    
    wait 0.1;
    
    if ( isalive( a_allies[ 0 ] ) )
    {
        a_allies[ 0 ] dialogue::queue( "vox_cp_prsn_28000_ams1_staylow_41" );
    }
    
    wait 2;
    
    if ( isalive( a_allies[ 0 ] ) )
    {
        a_allies[ 0 ] dialogue::queue( "vox_cp_prsn_28000_ams1_usethegrassforc_a2" );
    }
    
    wait 1;
    
    if ( isalive( a_allies[ 1 ] ) )
    {
        a_allies[ 1 ] dialogue::queue( "vox_cp_prsn_28000_ams1_theywontseeusco_ad" );
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0x5cededbf, Offset: 0x5010
// Size: 0x104
function function_981d2e58( a_enemies )
{
    level endon( #"waterfall_end_vo" );
    level flag::wait_till( "flag_waterfall_path_enter_water" );
    wait 5;
    
    if ( isalive( a_enemies[ 0 ] ) )
    {
        a_enemies[ 0 ] dialogue::queue( "vox_cp_prsn_28100_vms1_keepyoureyesope_3b" );
    }
    
    if ( isalive( a_enemies[ 1 ] ) )
    {
        a_enemies[ 1 ] dialogue::queue( "vox_cp_prsn_28100_vms2_ifanysurviveddi_fb" );
    }
    
    if ( isalive( a_enemies[ 0 ] ) )
    {
        a_enemies[ 0 ] dialogue::queue( "vox_cp_prsn_28100_vms1_yesbutafewofthe_33" );
    }
    
    childthread function_bd18cfc5( a_enemies );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0x6187b8bc, Offset: 0x5120
// Size: 0x2ac
function function_bd18cfc5( a_enemies )
{
    level endon( #"waterfall_end_vo" );
    level flag::wait_till( "flag_waterfall_path_enter_water2" );
    wait 4;
    
    if ( isalive( a_enemies[ 1 ] ) )
    {
        a_enemies[ 1 ] dialogue::queue( "vox_cp_prsn_28100_vms2_theyreheadedthe_a3" );
    }
    
    if ( isalive( a_enemies[ 0 ] ) )
    {
        a_enemies[ 0 ] dialogue::queue( "vox_cp_prsn_28100_vms1_goodthenwewonth_a6" );
    }
    
    if ( isalive( a_enemies[ 2 ] ) )
    {
        a_enemies[ 2 ] dialogue::queue( "vox_cp_prsn_28100_vms3_weshouldgetback_38" );
    }
    
    if ( isalive( a_enemies[ 1 ] ) )
    {
        a_enemies[ 1 ] dialogue::queue( "vox_cp_prsn_28500_vms3_whatdoyouthinka_c4" );
    }
    
    if ( isalive( a_enemies[ 0 ] ) )
    {
        a_enemies[ 0 ] dialogue::queue( "vox_cp_prsn_28500_nvs2_theguyisahardas_82" );
    }
    
    if ( isalive( a_enemies[ 2 ] ) )
    {
        a_enemies[ 2 ] dialogue::queue( "vox_cp_prsn_28500_nvs3_agreedbutwhatdo_d9" );
    }
    
    if ( isalive( a_enemies[ 1 ] ) )
    {
        a_enemies[ 1 ] dialogue::queue( "vox_cp_prsn_28500_nvs1_myguessheshopin_f7" );
    }
    
    if ( isalive( a_enemies[ 0 ] ) )
    {
        a_enemies[ 0 ] dialogue::queue( "vox_cp_prsn_28500_nvs2_butdidperseusre_3a" );
    }
    
    if ( isalive( a_enemies[ 1 ] ) )
    {
        a_enemies[ 1 ] dialogue::queue( "vox_cp_prsn_28500_nvs1_hedid_3d" );
    }
    
    if ( isalive( a_enemies[ 2 ] ) )
    {
        a_enemies[ 2 ] dialogue::queue( "vox_cp_prsn_28500_nvs3_yeahrememberbac_cc" );
    }
    
    if ( isalive( a_enemies[ 1 ] ) )
    {
        a_enemies[ 1 ] dialogue::queue( "vox_cp_prsn_28500_nvs2_ohyeahwhatadick_ca" );
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0x8d0c6491, Offset: 0x53d8
// Size: 0x26c
function function_ea710d32( a_allies )
{
    level endon( #"hash_2c4f011314455376" );
    
    if ( flag::get( "waterfall_path_exited" ) )
    {
        return;
    }
    
    wait 2;
    
    if ( !( isalive( a_allies[ 0 ] ) && isalive( a_allies[ 1 ] ) ) )
    {
        dialogue::radio( "vox_cp_prsn_04300_adlr_yourrashactionc_ad" );
        return;
    }
    
    if ( flag::get( "flag_waterfall_path_player_shot" ) )
    {
        if ( isalive( a_allies[ 0 ] ) )
        {
            a_allies[ 0 ] dialogue::queue( "vox_cp_prsn_28300_ams1_whatthehellwere_06" );
        }
        
        if ( isalive( a_allies[ 0 ] ) )
        {
            a_allies[ 0 ] dialogue::queue( "vox_cp_prsn_28300_ams1_ifyouwereinmyun_43" );
        }
        
        if ( isalive( a_allies[ 0 ] ) )
        {
            a_allies[ 0 ] dialogue::queue( "vox_cp_prsn_28300_ams1_comebackhereimn_cd" );
        }
        
        return;
    }
    
    if ( flag::get( "flag_waterfall_path_player_melee" ) )
    {
        if ( isalive( a_allies[ 0 ] ) )
        {
            a_allies[ 0 ] dialogue::queue( "vox_cp_prsn_28200_ams1_thanksfortheass_ca" );
        }
        
        return;
    }
    
    if ( isalive( a_allies[ 0 ] ) )
    {
        a_allies[ 0 ] dialogue::queue( "vox_cp_prsn_28300_ams1_whatpartofmysig_7b" );
    }
    
    if ( isalive( a_allies[ 0 ] ) )
    {
        a_allies[ 0 ] dialogue::queue( "vox_cp_prsn_28300_ams1_areyoualonebeca_7a" );
    }
    
    if ( isalive( a_allies[ 0 ] ) )
    {
        a_allies[ 0 ] dialogue::queue( "vox_cp_prsn_28300_ams1_youreworthlessg_74" );
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0xa22181e5, Offset: 0x5650
// Size: 0x1f4
function function_b264c569()
{
    level flag::clear( "flag_waterfall_path_ambush" );
    spawner::add_spawn_function_group( "waterfall1_visit2", "script_aigroup", &function_3e6220d0 );
    childthread function_da04a4c5();
    childthread function_b6caf72b();
    childthread function_6e07d190();
    level childthread scene::play( "scene_pri_waterfall_kill_alt1" );
    level flag::set( "waterfall1_visit2_bundle1_flag_true" );
    level flag::wait_till_any( array( "flag_waterfall_path_ambush", "flag_waterfall_path_player_shot2" ) );
    wait 0.25;
    aienemies = getaiarray( "waterfall1_visit2", "script_aigroup" );
    
    foreach ( ai in aienemies )
    {
        if ( isalive( ai ) )
        {
            ai val::set( "waterfall_wake", "ignoreall", 0 );
        }
    }
    
    function_1011729b( aienemies );
    childthread function_b46aa4d0();
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0x6210212b, Offset: 0x5850
// Size: 0x54
function function_1011729b( aienemies )
{
    level endon( #"flag_waterfall_path_complete" );
    function_1eaaceab( aienemies );
    level ai::waittill_dead( aienemies, aienemies.size );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x28816d88, Offset: 0x58b0
// Size: 0xb4
function function_b6caf72b()
{
    level.player endon( #"death" );
    var_8dfbed88 = smart_bundle::function_6c12ff6( "waterfall1_visit2_bundle1" );
    var_8dfbed88 smart_bundle::function_e47ac090();
    var_8564fb5f = spawner::get_ai_group_ai( "waterfall1_visit2" );
    level ai::waittill_dead( var_8564fb5f, 1 );
    level flag::set( "flag_waterfall_path_player_shot2" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0xac3a4d8c, Offset: 0x5970
// Size: 0x7c
function function_6e07d190()
{
    level.player endon( #"death" );
    level.player notifyonplayercommand( "weapon_fire", "+attack" );
    level.player waittill( #"weapon_fire" );
    level flag::set( "flag_waterfall_path_player_shot2" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x89d27743, Offset: 0x59f8
// Size: 0x7c
function function_da04a4c5()
{
    level endon( #"waterfall_end_vo" );
    level flag::wait_till( "flag_waterfall_path_ambush" );
    dialogue::radio( "vox_cp_prsn_28600_vms1_attackkilltheam_e7" );
    childthread namespace_d9b153b9::function_f6cbf7fd( &function_f4e241d, 1, 15, "waterfall_end_vo_idle" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0xf58dec9e, Offset: 0x5a80
// Size: 0x20
function function_b46aa4d0()
{
    if ( flag::get( "waterfall_path_exited" ) )
    {
        return;
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x172284ce, Offset: 0x5aa8
// Size: 0x64
function function_3bc2244b()
{
    if ( !isdefined( level.var_71cc355e ) || isdefined( level.var_71cc355e ) && !array::contains( level.var_71cc355e, "struct_ghost_convo3" ) )
    {
        namespace_d9b153b9::function_48926a5f( "struct_ghost_convo3" );
    }
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0xa10f6a63, Offset: 0x5b18
// Size: 0x74
function function_1c115d87()
{
    level thread scene::play( "scene_pri_waterfall_observe", "shot 1" );
    level flag::wait_till( "flag_adler_waterfall_disappear" );
    level scene::play( "scene_pri_waterfall_observe", "shot 2" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0xae1cc55c, Offset: 0x5b98
// Size: 0x64
function function_58a1520d()
{
    level endon( #"waterfall_end_vo_idle" );
    dialogue::radio( "vox_cp_prsn_14200_adlr_sureitwasanicer_f0" );
    childthread namespace_d9b153b9::function_f6cbf7fd( &function_76f98ebd, 1, 15, "waterfall_end_vo_idle" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0xe3a63aee, Offset: 0x5c08
// Size: 0x5c
function function_76f98ebd()
{
    level endon( #"waterfall_end_vo_idle" );
    dialogue::radio( "vox_cp_prsn_14200_adlr_whydoesbellkeep_c2" );
    namespace_d9b153b9::function_f76551eb( "vox_cp_prsn_14200_park_mostlikelytryin_4e", "vox_cp_prsn_14200_lazr_forgotthemissio_0e", "vox_cp_prsn_14200_sims_tryingtofigures_50" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x74e95f49, Offset: 0x5c70
// Size: 0x1a
function function_f4e241d()
{
    level endon( #"waterfall_end_vo_idle" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x16a57618, Offset: 0x5c98
// Size: 0x1a
function function_7966f86d()
{
    level endon( #"waterfall_end_vo_idle" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 0
// Checksum 0x7907a731, Offset: 0x5cc0
// Size: 0x1a
function function_4bac1cf8()
{
    level endon( #"waterfall_end_vo_idle" );
}

// Namespace namespace_18c72e49/namespace_18c72e49
// Params 1
// Checksum 0xf13fb087, Offset: 0x5ce8
// Size: 0x274
function function_c1b6e3a0( var_c79d614f )
{
    level endon( #"visit_restart" );
    level endon( #"start_outro" );
    
    if ( isdefined( level.var_731c10af.var_42659717 ) && ( level.var_731c10af.var_42659717 == 0 || level.var_731c10af.var_42659717 == 1 ) )
    {
        if ( level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook" )
        {
            thread namespace_b6fe1dbe::function_1e0e9b39( var_c79d614f );
            dialogue::radio( "vox_cp_prsn_05000_adlr_yourreportsayst_f9" );
            dialogue::radio( "vox_cp_prsn_05100_adlr_thisisntrightca_e7" );
        }
        else if ( level.var_baa7cf92 == "caves" || level.var_baa7cf92 == "rat_tunnels" )
        {
            thread namespace_b6fe1dbe::function_34830cda( var_c79d614f );
        }
        
        return;
    }
    
    if ( isdefined( level.var_731c10af.var_42659717 ) && level.var_731c10af.var_42659717 == 2 )
    {
        if ( level.var_baa7cf92 == "village" || level.var_baa7cf92 == "sniper_overlook" )
        {
            thread namespace_b6fe1dbe::function_1e0e9b39( var_c79d614f );
            
            if ( isdefined( level.var_731c10af.var_58ca484f ) )
            {
                dialogue::radio( "vox_cp_prsn_08000_adlr_stopfightingmeb_e9" );
            }
            else
            {
                dialogue::radio( "vox_cp_prsn_08000_adlr_thebunkerisleft_37" );
            }
            
            dialogue::radio( "vox_cp_prsn_08100_adlr_turnaroundbella_a7" );
            return;
        }
        
        if ( level.var_baa7cf92 == "caves" || level.var_baa7cf92 == "rat_tunnels" )
        {
            thread namespace_b6fe1dbe::function_34830cda( var_c79d614f );
        }
    }
}

