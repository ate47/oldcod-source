#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;

#namespace planemortar;

// Namespace planemortar/planemortar
// Params 0, eflags: 0x2
// Checksum 0x889c4835, Offset: 0x158
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "planemortar", &__init__, undefined, undefined );
}

// Namespace planemortar/planemortar
// Params 0
// Checksum 0xa9f2d829, Offset: 0x198
// Size: 0x5c
function __init__()
{
    level.planemortarexhaustfx = "killstreaks/fx_ls_exhaust_afterburner";
    clientfield::register( "scriptmover", "planemortar_contrail", 1, 1, "int", &planemortar_contrail, 0, 0 );
}

// Namespace planemortar/planemortar
// Params 7
// Checksum 0x1b8c4405, Offset: 0x200
// Size: 0x84
function planemortar_contrail( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"death" );
    
    if ( newval )
    {
        self.fx = playfxontag( localclientnum, level.planemortarexhaustfx, self, "tag_fx" );
    }
}

