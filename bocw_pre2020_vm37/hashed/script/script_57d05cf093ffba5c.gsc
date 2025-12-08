#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\hms_util;

#namespace namespace_f6d09d1a;

// Namespace namespace_f6d09d1a/namespace_681dba33
// Params 0
// Checksum 0x89562dd4, Offset: 0x268
// Size: 0xe4
function init()
{
    level thread function_4aae9dfd();
    level thread function_14faa6d8( "t_mainstreet_keys_on", 0, "lgtexp_perf_mainstreet_keys" );
    level thread function_14faa6d8( "t_mainstreet_keys_off", 1, "lgtexp_perf_mainstreet_keys" );
    level thread function_14faa6d8( "t_townsquare_keys_on", 0, "lgtexp_perf_townsquare_keys" );
    level thread function_14faa6d8( "t_townsquare_keys_off", 1, "lgtexp_perf_townsquare_keys" );
    level thread function_14faa6d8( "t_apc_townsquare_keys_on", 0, "lgtexp_perf_townsquare_keys" );
}

// Namespace namespace_f6d09d1a/namespace_681dba33
// Params 3
// Checksum 0xb79b4efe, Offset: 0x358
// Size: 0x124
function function_7b9feaa3( var_bcf6cfb, b_play, var_ad7bbec = undefined )
{
    level flag::wait_till( "game_start" );
    
    if ( isdefined( var_ad7bbec ) )
    {
        waitframe( 1 );
        
        if ( b_play == 1 & flag::get( var_ad7bbec ) == 0 )
        {
            exploder::exploder( var_bcf6cfb );
        }
        
        if ( b_play == 0 & flag::get( var_ad7bbec ) == 0 )
        {
            exploder::stop_exploder( var_bcf6cfb );
        }
        
        return;
    }
    
    waitframe( 1 );
    
    if ( b_play == 1 )
    {
        exploder::exploder( var_bcf6cfb );
    }
    
    if ( b_play == 0 )
    {
        exploder::stop_exploder( var_bcf6cfb );
    }
}

// Namespace namespace_f6d09d1a/namespace_681dba33
// Params 0
// Checksum 0x2f2dbec8, Offset: 0x488
// Size: 0x74
function function_4aae9dfd()
{
    var_93a64e41 = getent( "t_lgt_escape", "targetname" );
    var_93a64e41 trigger::wait_till();
    exploder::exploder( "lgtexp_escape_facility" );
    exploder::stop_exploder( "lgtexp_perf_escape" );
}

// Namespace namespace_f6d09d1a/namespace_681dba33
// Params 3
// Checksum 0x48eb99b7, Offset: 0x508
// Size: 0xae
function function_14faa6d8( s_trigger, b_play, var_bcf6cfb )
{
    t_trigger = getent( s_trigger, "targetname" );
    
    while ( isdefined( t_trigger ) )
    {
        t_trigger trigger::wait_till();
        
        if ( b_play == 1 )
        {
            exploder::exploder( var_bcf6cfb );
        }
        
        if ( b_play == 0 )
        {
            exploder::stop_exploder( var_bcf6cfb );
        }
        
        wait 1;
    }
}

// Namespace namespace_f6d09d1a/namespace_681dba33
// Params 0
// Checksum 0xa96a3ceb, Offset: 0x5c0
// Size: 0x148
function function_a677563d()
{
    var_d5535d9a = getvehiclearray( "control_tower_elevator", "targetname" )[ 0 ];
    var_d5535d9a.probe = getent( "elevator_probe_dyn", "targetname" );
    
    if ( isdefined( var_d5535d9a.probe ) )
    {
        var_d5535d9a.probe linkto( var_d5535d9a, undefined, ( -3, 0, -21.5 ), ( 0, 0, 180 ) );
    }
    
    light_origin = var_d5535d9a.origin + ( 0, 0, 32.5 );
    light_angles = ( 90, 0, 0 );
    var_d5535d9a fx::play( "maps/cp_rus_amerika/fx9_amrka_lgt_elevator", light_origin, light_angles, "kill_elevator_fx_lgt", 1 );
    level flag::wait_till( "flg_terminal_end" );
    var_d5535d9a notify( #"kill_elevator_fx_lgt" );
}

// Namespace namespace_f6d09d1a/namespace_681dba33
// Params 0
// Checksum 0xc2801be, Offset: 0x710
// Size: 0x4c
function function_4699a51c()
{
    ai_enemy_helipad_left = getent( "ai_lgt_enemy_helipad_left", "script_noteworthy", 1 );
    ai_enemy_helipad_left waittill( #"death" );
}

