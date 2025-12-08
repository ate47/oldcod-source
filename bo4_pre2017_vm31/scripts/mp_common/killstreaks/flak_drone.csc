#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/math_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicle_shared;
#using scripts/mp_common/helicopter_sounds;
#using scripts/mp_common/util;

#namespace flak_drone;

// Namespace flak_drone/flak_drone
// Params 0, eflags: 0x2
// Checksum 0x7c59958d, Offset: 0x240
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "flak_drone", &__init__, undefined, undefined );
}

// Namespace flak_drone/flak_drone
// Params 0
// Checksum 0x4963669e, Offset: 0x280
// Size: 0x4c
function __init__()
{
    clientfield::register( "vehicle", "flak_drone_camo", 1, 3, "int", &active_camo_changed, 0, 0 );
}

// Namespace flak_drone/flak_drone
// Params 7
// Checksum 0x3b2acba2, Offset: 0x2d8
// Size: 0x11c
function active_camo_changed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    flags_changed = self duplicate_render::set_dr_flag( "active_camo_flicker", newval == 2 );
    flags_changed = self duplicate_render::set_dr_flag( "active_camo_on", 0 ) || flags_changed;
    flags_changed = self duplicate_render::set_dr_flag( "active_camo_reveal", 1 ) || flags_changed;
    
    if ( flags_changed )
    {
        self duplicate_render::update_dr_filters( localclientnum );
    }
    
    self notify( #"endtest" );
    self thread doreveal( localclientnum, newval != 0 );
}

// Namespace flak_drone/flak_drone
// Params 2
// Checksum 0x5e46a140, Offset: 0x400
// Size: 0x15c
function doreveal( localclientnum, direction )
{
    self notify( #"endtest" );
    self endon( #"endtest" );
    self endon( #"death" );
    
    if ( direction )
    {
        startval = 1;
    }
    else
    {
        startval = 0;
    }
    
    while ( startval >= 0 && startval <= 1 )
    {
        self mapshaderconstant( localclientnum, 0, "scriptVector0", startval, 0, 0, 0 );
        
        if ( direction )
        {
            startval -= 0.032;
        }
        else
        {
            startval += 0.032;
        }
        
        waitframe( 1 );
    }
    
    flags_changed = self duplicate_render::set_dr_flag( "active_camo_reveal", 0 );
    flags_changed = self duplicate_render::set_dr_flag( "active_camo_on", direction ) || flags_changed;
    
    if ( flags_changed )
    {
        self duplicate_render::update_dr_filters( localclientnum );
    }
}

