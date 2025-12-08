#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_8af9269b;

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0, eflags: 0x6
// Checksum 0x1c17b541, Offset: 0x1e8
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"hash_2261850aec98f6f8", &preload, &postload, undefined, undefined );
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0
// Checksum 0x9fb7d37e, Offset: 0x240
// Size: 0x16c
function preload()
{
    clientfield::register( "toplayer", "zipline_postfx", 1, 1, "int", &zipline_postfx, 0, 0 );
    clientfield::register( "toplayer", "zipline_gesture_strap_visibility", 1, 1, "int", &zipline_gesture_strap_visibility, 0, 0 );
    clientfield::register( "toplayer", "zipline_player_landing_fx", 1, 2, "counter", &zipline_player_landing_fx, 0, 0 );
    clientfield::register( "actor", "zipline_ai_landing_fx", 1, 2, "counter", &zipline_ai_landing_fx, 0, 0 );
    clientfield::register( "scriptmover", "zipline_strap_visibility", 1, 1, "int", &zipline_strap_visibility, 0, 0 );
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0
// Checksum 0x591f6f0e, Offset: 0x3b8
// Size: 0x54
function postload()
{
    level._effect[ #"zipline_ai_landing_fx" ] = #"hash_62e38c7e6420e59d";
    level._effect[ #"zipline_player_landing_fx" ] = #"hash_62e38c7e6420e59d";
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 7
// Checksum 0x80c686c4, Offset: 0x418
// Size: 0xdc
function zipline_postfx( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump )
    {
        if ( self postfx::function_556665f2( "pstfx_ice_slide_motion_blur" ) )
        {
            self postfx::stoppostfxbundle( "pstfx_ice_slide_motion_blur" );
        }
        
        self postfx::playpostfxbundle( "pstfx_ice_slide_motion_blur" );
        return;
    }
    
    self notify( #"hash_4075bb1fa37309a0" );
    self postfx::exitpostfxbundle( "pstfx_ice_slide_motion_blur" );
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 0
// Checksum 0xc128df55, Offset: 0x500
// Size: 0x80
function function_17e2302()
{
    self endon( #"hash_4075bb1fa37309a0" );
    n_blur_amount = 0;
    
    while ( n_blur_amount < 2 )
    {
        self postfx::function_c8b5f318( "pstfx_ice_slide_motion_blur", #"blur amount", n_blur_amount );
        wait 0.2;
        n_blur_amount += 0.2;
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 7
// Checksum 0x4b4e0e21, Offset: 0x588
// Size: 0xcc
function zipline_player_landing_fx( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump === 1 )
    {
        util::playfxontag( fieldname, level._effect[ #"zipline_player_landing_fx" ], self, "tag_origin" );
        return;
    }
    
    if ( bwastimejump === 2 )
    {
        util::playfxontag( fieldname, level._effect[ #"zipline_player_landing_fx" ], self, "tag_origin" );
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 7
// Checksum 0x8a7d9440, Offset: 0x660
// Size: 0xcc
function zipline_ai_landing_fx( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump === 1 )
    {
        util::playfxontag( fieldname, level._effect[ #"zipline_ai_landing_fx" ], self, "tag_origin" );
        return;
    }
    
    if ( bwastimejump === 2 )
    {
        util::playfxontag( fieldname, level._effect[ #"zipline_ai_landing_fx" ], self, "tag_origin" );
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 7
// Checksum 0x65d99df9, Offset: 0x738
// Size: 0xcc
function zipline_strap_visibility( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 1 )
    {
        self playrenderoverridebundle( "rob_zipline_strap_fade_out" );
        wait 1.8;
        self hide();
        return;
    }
    
    if ( bwastimejump == 0 )
    {
        self stoprenderoverridebundle( "rob_zipline_strap_fade_out" );
        self show();
    }
}

// Namespace namespace_8af9269b/namespace_8af9269b
// Params 7
// Checksum 0x15e5995b, Offset: 0x810
// Size: 0x9c
function zipline_gesture_strap_visibility( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump == 1 )
    {
        self playrenderoverridebundle( "rob_zipline_gesture_strap_fade_out", "tag_torso" );
    }
    
    if ( bwastimejump == 0 )
    {
        self playrenderoverridebundle( "rob_zipline_gesture_strap_fade_in", "tag_torso" );
    }
}

