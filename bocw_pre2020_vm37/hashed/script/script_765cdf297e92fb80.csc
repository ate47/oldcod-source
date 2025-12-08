#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;

#namespace namespace_25845e22;

// Namespace namespace_25845e22/namespace_25845e22
// Params 0, eflags: 0x6
// Checksum 0x2302ac52, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"slow_motion", &preload, undefined, undefined, undefined );
}

// Namespace namespace_25845e22/namespace_25845e22
// Params 0
// Checksum 0x5cf6084, Offset: 0x100
// Size: 0x4c
function preload()
{
    clientfield::register( "toplayer", "slowmo_postfx", 1, 1, "int", &slowmo_postfx, 0, 0 );
}

// Namespace namespace_25845e22/namespace_25845e22
// Params 7
// Checksum 0x11354922, Offset: 0x158
// Size: 0xc4
function slowmo_postfx( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        if ( self postfx::function_556665f2( "pstfx_slow_motion" ) )
        {
            self postfx::stoppostfxbundle( "pstfx_slow_motion" );
        }
        
        self postfx::playpostfxbundle( "pstfx_slow_motion" );
        return;
    }
    
    self postfx::exitpostfxbundle( "pstfx_slow_motion" );
}

