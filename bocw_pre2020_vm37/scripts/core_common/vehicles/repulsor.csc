#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace repulsor;

// Namespace repulsor/repulsor
// Params 0, eflags: 0x6
// Checksum 0x2bcfef54, Offset: 0xa8
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"repulsor", &preinit, undefined, undefined, undefined );
}

// Namespace repulsor/repulsor
// Params 0, eflags: 0x4
// Checksum 0xcb599dc7, Offset: 0xf0
// Size: 0x4c
function private preinit()
{
    clientfield::register( "vehicle", "pulse_fx", 1, 1, "counter", &pulsefxhandler, 0, 0 );
}

// Namespace repulsor/repulsor
// Params 7, eflags: 0x4
// Checksum 0xa63c5464, Offset: 0x148
// Size: 0x104
function private pulsefxhandler( localclientnum, *oldvalue, newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump )
{
    self endon( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( #"pulsefx" );
    self endon( #"pulsefx" );
    
    if ( wasdemojump )
    {
        self playsound( 0, #"hash_32a17ce5991f5801" );
        self mapshaderconstant( fieldname, 0, "scriptVector2", 0, 1 );
        wait 1;
    }
    
    self mapshaderconstant( fieldname, 0, "scriptVector2", 0, 0.2 );
}

