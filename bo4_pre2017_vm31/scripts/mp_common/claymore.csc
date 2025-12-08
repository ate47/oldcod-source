#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/mp_common/util;

#namespace claymore;

// Namespace claymore/claymore
// Params 0, eflags: 0x2
// Checksum 0x3e7d74b, Offset: 0x178
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "claymore", &__init__, undefined, undefined );
}

// Namespace claymore/claymore
// Params 1
// Checksum 0xf4de6b54, Offset: 0x1b8
// Size: 0x54
function __init__( localclientnum )
{
    level._effect[ "fx_claymore_laser" ] = "_t6/weapon/claymore/fx_claymore_laser";
    callback::add_weapon_type( "claymore", &spawned );
}

// Namespace claymore/claymore
// Params 1
// Checksum 0xb5724cba, Offset: 0x218
// Size: 0xd8
function spawned( localclientnum )
{
    self endon( #"death" );
    self util::waittill_dobj( localclientnum );
    
    while ( true )
    {
        if ( isdefined( self.stunned ) && self.stunned )
        {
            wait 0.1;
            continue;
        }
        
        self.claymorelaserfxid = playfxontag( localclientnum, level._effect[ "fx_claymore_laser" ], self, "tag_fx" );
        self waittill( "stunned" );
        stopfx( localclientnum, self.claymorelaserfxid );
    }
}

