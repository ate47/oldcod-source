#using scripts\core_common\system_shared;

#namespace gadget_clone_render;

// Namespace gadget_clone_render/gadget_clone_render
// Params 0, eflags: 0x6
// Checksum 0xa1e3f63c, Offset: 0x80
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"gadget_clone_render", &preinit, undefined, undefined, undefined );
}

// Namespace gadget_clone_render/gadget_clone_render
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0xc8
// Size: 0x4
function private preinit()
{
    
}

// Namespace gadget_clone_render/gadget_clone_render
// Params 1
// Checksum 0x6ee63cf, Offset: 0xd8
// Size: 0xa6
function transition_shader( localclientnum )
{
    self endon( #"death" );
    self endon( #"clone_shader_off" );
    rampinshader = 0;
    
    while ( rampinshader < 1 )
    {
        if ( isdefined( self ) )
        {
            self mapshaderconstant( localclientnum, 0, "scriptVector3", 1, rampinshader, 0, 0.04 );
        }
        
        rampinshader += 0.04;
        waitframe( 1 );
    }
}

