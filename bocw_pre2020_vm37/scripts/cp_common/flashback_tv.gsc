#using script_3dc93ca9902a9cda;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;

#namespace flashback_tv;

// Namespace flashback_tv/flashback_tv
// Params 8
// Checksum 0x3f9e7e5, Offset: 0x178
// Size: 0x1ec
function function_15eaa2db( var_ec670c03, var_7589d009, var_cfa5fdd5, var_5021564e, var_79d6c881, var_e74daa74, var_88db8fbc, var_14e7d014 )
{
    if ( !level flag::exists( var_cfa5fdd5 ) )
    {
        level flag::init( var_cfa5fdd5 );
    }
    
    if ( !level flag::exists( var_5021564e ) )
    {
        level flag::init( var_5021564e );
    }
    
    videostart( var_ec670c03, 1 );
    var_c0646472 = self function_e538e340( var_14e7d014 );
    
    if ( is_true( var_c0646472 ) )
    {
        return;
    }
    
    while ( !flag::get( var_cfa5fdd5 ) )
    {
        level flag::wait_till_clear( var_5021564e );
        videostop( var_ec670c03 );
        self thread function_33ef1077( var_7589d009, var_cfa5fdd5, var_5021564e, var_79d6c881, var_e74daa74, var_88db8fbc, var_14e7d014 );
        level flag::wait_till( var_5021564e );
        level notify( #"hash_68eb05a3e5bf2912" );
        function_3b211e90();
        videostart( var_ec670c03, 1 );
        var_c0646472 = self function_e538e340( var_14e7d014 );
        
        if ( is_true( var_c0646472 ) )
        {
            return;
        }
    }
}

// Namespace flashback_tv/flashback_tv
// Params 7
// Checksum 0x9fa94704, Offset: 0x370
// Size: 0x2ce
function function_33ef1077( var_7589d009, var_cfa5fdd5, var_5021564e, var_79d6c881, var_e74daa74, var_88db8fbc, var_14e7d014 )
{
    level endon( #"hash_68eb05a3e5bf2912" );
    s_lookat = level struct::get( var_79d6c881, "targetname" );
    var_4026a1a6 = getent( var_e74daa74, "script_noteworthy" );
    var_4026a1a6.var_9d9f02b4 = 0;
    var_c0646472 = self function_e538e340( var_14e7d014 );
    
    if ( is_true( var_c0646472 ) )
    {
        self thread function_9ce08b4( var_4026a1a6, var_7589d009, var_cfa5fdd5, var_5021564e, var_88db8fbc, var_14e7d014 );
    }
    
    wait 0.1;
    
    while ( true )
    {
        var_c0646472 = self function_e538e340( var_14e7d014 );
        
        if ( is_true( var_c0646472 ) )
        {
            return;
        }
        
        b_is_visible = util::within_fov( level.player.origin, level.player getplayerangles(), s_lookat.origin, cos( 45 ) );
        
        if ( is_true( b_is_visible ) && isdefined( var_4026a1a6 ) && !is_true( var_4026a1a6.var_9d9f02b4 ) )
        {
            videoprime( var_7589d009 );
            self function_24654660( var_14e7d014 );
            wait 1.5;
            var_4026a1a6 show();
            var_4026a1a6.var_9d9f02b4 = 1;
            videostart( var_7589d009, 1 );
            tv_abstract_on();
            level thread exploder::exploder( var_88db8fbc );
            self thread function_9ce08b4( var_4026a1a6, var_7589d009, var_cfa5fdd5, var_5021564e, var_88db8fbc, var_14e7d014 );
        }
        
        waitframe( 1 );
    }
}

// Namespace flashback_tv/flashback_tv
// Params 6
// Checksum 0x9d12c32, Offset: 0x648
// Size: 0x104
function function_9ce08b4( var_4026a1a6, var_7589d009, var_cfa5fdd5, var_5021564e, var_88db8fbc, var_14e7d014 )
{
    level flag::wait_till_any( [ var_cfa5fdd5, var_5021564e ] );
    level thread exploder::stop_exploder( var_88db8fbc );
    tv_abstract_off();
    videostop( var_7589d009 );
    
    if ( isdefined( var_4026a1a6 ) )
    {
        var_4026a1a6.var_9d9f02b4 = 0;
        var_c0646472 = self function_e538e340( var_14e7d014 );
        
        if ( is_true( var_c0646472 ) )
        {
            var_4026a1a6 delete();
        }
    }
}

// Namespace flashback_tv/flashback_tv
// Params 0
// Checksum 0xeec37010, Offset: 0x758
// Size: 0x9c
function tv_abstract_on()
{
    var_c50d49d8 = getent( "flashback_tv_screen", "targetname" );
    level.var_b07c33dd = snd::play( "event_tv_abstracts_tension_render_lp", var_c50d49d8 );
    snd::play( "event_tv_abstract_start", var_c50d49d8 );
    snd::play( "event_tv_abstract_on", var_c50d49d8 );
    snd::client_msg( "tv_abstract_on" );
}

// Namespace flashback_tv/flashback_tv
// Params 0
// Checksum 0xf586a755, Offset: 0x800
// Size: 0x7c
function tv_abstract_off()
{
    var_c50d49d8 = getent( "flashback_tv_screen", "targetname" );
    snd::stop( level.var_b07c33dd );
    snd::play( "event_tv_abstract_off", var_c50d49d8 );
    snd::client_msg( "tv_abstract_off" );
}

// Namespace flashback_tv/flashback_tv
// Params 0
// Checksum 0xc09f94c5, Offset: 0x888
// Size: 0x64
function function_3b211e90()
{
    var_c50d49d8 = getent( "flashback_tv_screen", "targetname" );
    snd::stop( level.var_b07c33dd );
    snd::client_msg( "tv_abstract_off" );
}

// Namespace flashback_tv/flashback_tv
// Params 1
// Checksum 0xfd43b07b, Offset: 0x8f8
// Size: 0x5c
function function_24654660( var_14e7d014 )
{
    assert( isplayer( self ) );
    player = self;
    player savegame::set_player_data( var_14e7d014, 1 );
}

// Namespace flashback_tv/flashback_tv
// Params 1
// Checksum 0x9a554cd1, Offset: 0x960
// Size: 0x7a
function function_e538e340( var_14e7d014 )
{
    assert( isplayer( self ) );
    player = self;
    var_393a392a = int( player savegame::function_2ee66e93( var_14e7d014, 0 ) );
    return var_393a392a;
}

