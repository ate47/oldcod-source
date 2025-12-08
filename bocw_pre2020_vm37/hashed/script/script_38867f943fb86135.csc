#using scripts\core_common\callbacks_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace cp_post;

// Namespace cp_post/cp_post
// Params 0, eflags: 0x6
// Checksum 0x95b6024d, Offset: 0xe0
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"cp_post", undefined, &post_init, undefined, undefined );
}

// Namespace cp_post/cp_post
// Params 0
// Checksum 0x58a3d303, Offset: 0x128
// Size: 0x24
function post_init()
{
    callback::on_localplayer_spawned( &start );
}

// Namespace cp_post/cp_post
// Params 7
// Checksum 0x13b1ff4f, Offset: 0x158
// Size: 0x11c
function start( *localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    self postfx::playpostfxbundle( "pstfx_t9_cp_default" );
    self postfx::function_c8b5f318( "pstfx_t9_cp_default", "Vignette Fade", 0.5 );
    self postfx::function_c8b5f318( "pstfx_t9_cp_default", "Blur Amount", 0.5 );
    self postfx::function_c8b5f318( "pstfx_t9_cp_default", "Aberration", 0.5 );
    self postfx::function_c8b5f318( "pstfx_t9_cp_default", "Reveal Threshold", 0.5 );
}

// Namespace cp_post/cp_post
// Params 7
// Checksum 0x9ba01752, Offset: 0x280
// Size: 0x74
function stop( *localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump )
{
    if ( postfx::function_556665f2( "pstfx_t9_cp_default" ) )
    {
        self postfx::stoppostfxbundle( "pstfx_t9_cp_default" );
    }
}

// Namespace cp_post/cp_post
// Params 4
// Checksum 0x7cadde92, Offset: 0x300
// Size: 0x104
function function_d9475fc( var_dccfb95, var_72b185dd, aberration, reveal_threshold )
{
    if ( !postfx::function_556665f2( "pstfx_t9_cp_default" ) )
    {
        waitframe( 1 );
    }
    
    if ( isdefined( var_dccfb95 ) )
    {
        self postfx::function_c8b5f318( "pstfx_t9_cp_default", "Vignette Fade", var_dccfb95 );
    }
    
    if ( isdefined( var_72b185dd ) )
    {
        self postfx::function_c8b5f318( "pstfx_t9_cp_default", "Blur Amount", var_72b185dd );
    }
    
    if ( isdefined( aberration ) )
    {
        self postfx::function_c8b5f318( "pstfx_t9_cp_default", "Aberration", aberration );
    }
    
    if ( isdefined( reveal_threshold ) )
    {
        self postfx::function_c8b5f318( "pstfx_t9_cp_default", "Reveal Threshold", reveal_threshold );
    }
}

