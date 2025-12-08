#using script_1b9f100b85b7e21d;
#using script_3b2905ec05ed796;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace namespace_1512c89a;

// Namespace namespace_1512c89a/level_init
// Params 1, eflags: 0x40
// Checksum 0x4ce745f9, Offset: 0x550
// Size: 0x11c
function event_handler[level_init] main( *eventstruct )
{
    clientfield::register( "world", "hide_nuke_clouds", 1, 1, "int" );
    clientfield::register( "world", "nuke_trigger_hit", 1, 1, "int" );
    clientfield::register( "world", "post_nuke_state", 1, 1, "int" );
    load::main();
    thread function_1a690b0e();
    thread function_e137ff01();
    thread function_8e05c407();
    thread post_nuke_power_on_01();
    thread post_nuke_power_on_02();
    thread post_nuke_power_on_03();
    thread post_nuke_power_on_04();
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0x30935fd5, Offset: 0x678
// Size: 0xb0c
function function_8e05c407()
{
    while ( !isdefined( level.var_77be18d2 ) )
    {
        waitframe( 1 );
    }
    
    fill = getent( "fill_cin_intro", "targetname" );
    key = getent( "key_cin_intro", "targetname" );
    
    if ( isdefined( level.var_77be18d2 ) )
    {
        key linkto( level.var_77be18d2, "tag_body_animate", ( -90, 0, 106.1 ), ( 0, 0, 0 ) );
        fill linkto( level.var_77be18d2, "tag_body_animate", ( 17, 20, 53.1 ), ( 160, 0, 0 ) );
    }
    
    while ( !isdefined( level.var_5d798cf2 ) )
    {
        waitframe( 1 );
    }
    
    vh_ally_fav_right_tail_light_a = getent( "vh_ally_fav_right_tail_light_a", "targetname" );
    vh_ally_fav_right_tail_light_b = getent( "vh_ally_fav_right_tail_light_b", "targetname" );
    vh_ally_fav_right_head_light_a = getent( "vh_ally_fav_right_head_light_a", "targetname" );
    vh_ally_fav_right_head_light_b = getent( "vh_ally_fav_right_head_light_b", "targetname" );
    vh_ally_fav_right_tail_light_a linkto( level.var_5d798cf2, "tag_fx_tail_light_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    vh_ally_fav_right_tail_light_b linkto( level.var_5d798cf2, "tag_fx_tail_light_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    vh_ally_fav_right_head_light_a linkto( level.var_5d798cf2, "tag_fx_headlight_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    vh_ally_fav_right_head_light_b linkto( level.var_5d798cf2, "tag_fx_headlight_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    while ( !isdefined( level.var_7b278a4f ) )
    {
        waitframe( 1 );
    }
    
    vh_ally_fav_left_tail_light_a = getent( "vh_ally_fav_left_tail_light_a", "targetname" );
    vh_ally_fav_left_tail_light_b = getent( "vh_ally_fav_left_tail_light_b", "targetname" );
    vh_ally_fav_left_head_light_a = getent( "vh_ally_fav_left_head_light_a", "targetname" );
    vh_ally_fav_left_head_light_b = getent( "vh_ally_fav_left_head_light_b", "targetname" );
    vh_ally_fav_left_tail_light_a linkto( level.var_7b278a4f, "tag_fx_tail_light_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    vh_ally_fav_left_tail_light_b linkto( level.var_7b278a4f, "tag_fx_tail_light_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    vh_ally_fav_left_head_light_a linkto( level.var_7b278a4f, "tag_fx_headlight_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    vh_ally_fav_left_head_light_b linkto( level.var_7b278a4f, "tag_fx_headlight_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    while ( !isdefined( level.var_82e50b77 ) )
    {
        waitframe( 1 );
    }
    
    vh_ally_fav_tail_light_a = getentarray( "vh_ally_fav_tail_light_a", "targetname" );
    vh_ally_fav_tail_light_b = getentarray( "vh_ally_fav_tail_light_b", "targetname" );
    vh_ally_fav_head_light_a = getentarray( "vh_ally_fav_head_light_a", "targetname" );
    vh_ally_fav_head_light_b = getentarray( "vh_ally_fav_head_light_b", "targetname" );
    vh_ally_fav_tail_light_a[ 0 ] linkto( level.var_82e50b77, "tag_fx_tail_light_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    vh_ally_fav_tail_light_b[ 0 ] linkto( level.var_82e50b77, "tag_fx_tail_light_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    vh_ally_fav_head_light_a[ 0 ] linkto( level.var_82e50b77, "tag_fx_headlight_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    vh_ally_fav_head_light_b[ 0 ] linkto( level.var_82e50b77, "tag_fx_headlight_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level waittill( #"hash_29db583983db73c" );
    
    for ( i = 1; i < level.var_a1030c4e.size ; i++ )
    {
        vh_ally_fav_tail_light_a[ i ] linkto( level.var_a1030c4e[ i - 1 ], "tag_fx_tail_light_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        vh_ally_fav_tail_light_b[ i ] linkto( level.var_a1030c4e[ i - 1 ], "tag_fx_tail_light_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        vh_ally_fav_head_light_a[ i ] linkto( level.var_a1030c4e[ i - 1 ], "tag_fx_headlight_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        vh_ally_fav_head_light_b[ i ] linkto( level.var_a1030c4e[ i - 1 ], "tag_fx_headlight_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    vh_ally_fav_tail_light_a[ i ] linkto( level.var_77be18d2, "tag_fx_tail_light_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    vh_ally_fav_tail_light_b[ i ] linkto( level.var_77be18d2, "tag_fx_tail_light_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    vh_ally_fav_head_light_a[ i ] linkto( level.var_77be18d2, "tag_fx_headlight_left", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    vh_ally_fav_head_light_b[ i ] linkto( level.var_77be18d2, "tag_fx_headlight_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level waittill( #"hash_465d6bb5960c37f8" );
    fill setlightintensity( 0.01 );
    fill setlightradius( 0.01 );
    key setlightintensity( 0.01 );
    key setlightradius( 0.01 );
    vh_ally_fav_right_tail_light_a setlightintensity( 0.01 );
    vh_ally_fav_right_tail_light_a setlightradius( 0.01 );
    vh_ally_fav_right_tail_light_b setlightintensity( 0.01 );
    vh_ally_fav_right_tail_light_b setlightradius( 0.01 );
    vh_ally_fav_right_head_light_a setlightintensity( 0.01 );
    vh_ally_fav_right_head_light_a setlightradius( 0.01 );
    vh_ally_fav_right_head_light_b setlightintensity( 0.01 );
    vh_ally_fav_right_head_light_b setlightradius( 0.01 );
    vh_ally_fav_left_tail_light_a setlightintensity( 0.01 );
    vh_ally_fav_left_tail_light_a setlightradius( 0.01 );
    vh_ally_fav_left_tail_light_b setlightintensity( 0.01 );
    vh_ally_fav_left_tail_light_b setlightradius( 0.01 );
    vh_ally_fav_left_head_light_a setlightintensity( 0.01 );
    vh_ally_fav_left_head_light_a setlightradius( 0.01 );
    vh_ally_fav_left_head_light_b setlightintensity( 0.01 );
    vh_ally_fav_left_head_light_b setlightradius( 0.01 );
    
    for ( i = 1; i < vh_ally_fav_tail_light_a.size ; i++ )
    {
        vh_ally_fav_tail_light_a[ i ] setlightintensity( 0.01 );
        vh_ally_fav_tail_light_a[ i ] setlightradius( 0.01 );
        vh_ally_fav_tail_light_b[ i ] setlightintensity( 0.01 );
        vh_ally_fav_tail_light_b[ i ] setlightradius( 0.01 );
        vh_ally_fav_head_light_a[ i ] setlightintensity( 0.01 );
        vh_ally_fav_head_light_a[ i ] setlightradius( 0.01 );
        vh_ally_fav_head_light_b[ i ] setlightintensity( 0.01 );
        vh_ally_fav_head_light_b[ i ] setlightradius( 0.01 );
    }
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0xc49f4014, Offset: 0x1190
// Size: 0xb4
function function_e137ff01()
{
    level waittill( #"player_spawned" );
    wait 1;
    
    if ( !level flag::get( "level_intro_nuke_checkpoint" ) && !level flag::get( "flg_loose_ends" ) )
    {
        clientfield::set( "post_nuke_state", 1 );
        setlightingstate( 1 );
        exploder::exploder( "fxexp_nuke_loop_fx" );
    }
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0xf8211be1, Offset: 0x1250
// Size: 0x74
function function_1a690b0e()
{
    level flag::wait_till( "level_intro_nuke_checkpoint" );
    clientfield::set( "hide_nuke_clouds", 1 );
    level thread nuke_explosion();
    level thread function_dabce745();
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0x79fe94b7, Offset: 0x12d0
// Size: 0x5c
function function_99fed945()
{
    var_f796c5fc = getent( "nuke_trail_trigger_fx", "targetname" );
    var_f796c5fc trigger::wait_till();
    exploder::exploder( "fxexp_nuke_trail_fx" );
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0xa3590cc4, Offset: 0x1338
// Size: 0x6e
function nuke_explosion()
{
    level waittill( #"hash_42baa5404bc46f9c" );
    wait 1;
    setlightingstate( 1 );
    exploder::exploder( "lgt_exp_pre_nuke_ext_lights" );
    var_d9452bdb = ( -148, 5446, 123 );
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0xc4ae503, Offset: 0x13b0
// Size: 0x44
function function_dabce745()
{
    level waittill( #"hash_42baa5404bc46f9c" );
    wait 2.5;
    clientfield::set( "nuke_trigger_hit", 1 );
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0xdd015b1f, Offset: 0x1400
// Size: 0x1c4
function function_19de36c9()
{
    var_43c0fe92 = getent( "nuke_trigger", "targetname" );
    var_43c0fe92 trigger::wait_till();
    var_11196acd = getent( "nuke_altostratus_cloud_a", "targetname" );
    var_107ad8f5 = ( 41769.5, 100569, -21784.3 );
    var_a2de0e58 = getent( "nuke_altostratus_cloud_b", "targetname" );
    var_9350951 = ( 41654.1, -32697.4, -17409.6 );
    var_ac9f21da = getent( "nuke_altostratus_cloud_c", "targetname" );
    var_dda2c547 = ( 10988.9, 375.336, -6354.21 );
    var_11196acd moveto( var_107ad8f5, 16, 5, 0.01 );
    var_a2de0e58 moveto( var_9350951, 16, 5, 0.01 );
    var_ac9f21da moveto( var_dda2c547, 16, 5, 0.01 );
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0xe63aba40, Offset: 0x15d0
// Size: 0x5c
function post_nuke_power_on_01()
{
    var_143ff068 = getent( "post_nuke_power_on_01", "targetname" );
    var_143ff068 trigger::wait_till();
    exploder::exploder( "lgt_exp_post_nuke_power_on_01" );
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0x4550c97d, Offset: 0x1638
// Size: 0x74
function post_nuke_power_on_02()
{
    var_143ff068 = getent( "post_nuke_power_on_02", "targetname" );
    var_143ff068 trigger::wait_till();
    exploder::exploder( "lgt_exp_post_nuke_power_on_02" );
    exploder::exploder( "lgt_exp_post_nuke_power_on_03_lightpost" );
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0x974e6c60, Offset: 0x16b8
// Size: 0x5c
function post_nuke_power_on_03()
{
    var_143ff068 = getent( "post_nuke_power_on_03", "targetname" );
    var_143ff068 trigger::wait_till();
    exploder::exploder( "lgt_exp_post_nuke_power_on_03" );
}

// Namespace namespace_1512c89a/namespace_1512c89a
// Params 0
// Checksum 0xf8444ab, Offset: 0x1720
// Size: 0x5c
function post_nuke_power_on_04()
{
    var_143ff068 = getent( "post_nuke_power_on_04", "targetname" );
    var_143ff068 trigger::wait_till();
    exploder::exploder( "lgt_exp_post_nuke_power_on_04" );
}

