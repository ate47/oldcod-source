#using scripts/core_common/clientfield_shared;
#using scripts/core_common/system_shared;

#namespace destructible;

// Namespace destructible/destructible
// Params 0, eflags: 0x2
// Checksum 0xc6f2aeb0, Offset: 0x118
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "destructible", &__init__, undefined, undefined );
}

// Namespace destructible/destructible
// Params 0
// Checksum 0x5c0abd76, Offset: 0x158
// Size: 0x4c
function __init__()
{
    clientfield::register( "scriptmover", "start_destructible_explosion", 1, 10, "int", &doexplosion, 0, 0 );
}

// Namespace destructible/destructible
// Params 7
// Checksum 0x727dbc74, Offset: 0x1b0
// Size: 0xac
function playgrenaderumble( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playrumbleonposition( localclientnum, "grenade_rumble", self.origin );
    getlocalplayer( localclientnum ) earthquake( 0.5, 0.5, self.origin, 800 );
}

// Namespace destructible/destructible
// Params 7
// Checksum 0x41bdbd57, Offset: 0x268
// Size: 0x104
function doexplosion( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 0 )
    {
        return;
    }
    
    physics_explosion = 0;
    
    if ( newval & 1 << 9 )
    {
        physics_explosion = 1;
        newval -= 1 << 9;
    }
    
    physics_force = 0.3;
    
    if ( physics_explosion )
    {
        physicsexplosionsphere( localclientnum, self.origin, newval, newval - 1, physics_force, 25, 400 );
    }
    
    playgrenaderumble( localclientnum, self.origin );
}

